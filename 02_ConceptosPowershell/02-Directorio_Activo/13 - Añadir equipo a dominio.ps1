Import-Module ActiveDirectory

$equipo = "W7"                                                                                           # nombre del equipo
$dominio = "dominio.local"                                                                               # dominio
$nombreUnidadOrganizativa = "Equipos Windows 7"                                                          # unidad organizativa donde se va a alojar el equipo
$rutaContenedorUnidadOrganizativa = "dc=dominio,dc=local"                                                # ruta del contenedor de la unidad organizativa
$rutaUnidadOrganizativa = "ou=" + $nombreUnidadOrganizativa + "," + $rutaContenedorUnidadOrganizativa    # ruta completa de la unidad organizativa del equipo

$credencialesDominio = Get-Credential -Message "Introduzca las credenciales del dominio"                 # credenciales del dominio
$credencialesEquipo = Get-Credential -Message "Introduzca las credenciales del equipo remoto"            # credenciales del equipo a administrar


# comprobar si la unidad organizativa existe
$existe = Get-ADOrganizationalUnit -Server $dominio -Credential $credencialesDominio -Filter {distinguishedname -eq $rutaUnidadOrganizativa}

if ($null -eq $existe)
{
    # si no existe, crear la UO
    "La unidad organizativa '$rutaUnidadOrganizativa' no existe" | Out-Default
    New-ADOrganizationalUnit -Server $dominio -Name $nombreUnidadOrganizativa -Path $rutaContenedorUnidadOrganizativa -Description "Equipos Windows 7"
    $existe = Get-ADObject -Server $dominio -Credential $credencialesDominio -Filter {distinguishedname -eq $rutaUnidadOrganizativa}
    if ($existe)
    {
        Write-host "La unidad organizativa '$rutaUnidadOrganizativa' se ha creado correctamente" -ForegroundColor Green
    }
    else
    {
        Write-host "La unidad organizativa '$rutaUnidadOrganizativa' no se ha creado correctamente" -ForegroundColor Red
    }
}
else
{
    Write-host "La unidad organizativa '$rutaUnidadOrganizativa' ya existe" -ForegroundColor Yellow
}

if ($existe) # si existe, entonces se agrega al dominio el equipo en la unidad organizativa establecida
{
    Add-Computer -ComputerName $equipo -LocalCredential $credencialesEquipo -Domain $dominio -Credential $credencialesDominio -OUPath $rutaUnidadOrganizativa -Restart
}