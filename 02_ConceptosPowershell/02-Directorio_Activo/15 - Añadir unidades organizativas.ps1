Import-module ActiveDirectory

$ficheroOUs = ".\UOs.csv"                     # fichero con las unidades organizativas

$ous = Import-csv $ficheroOUs -Delimiter '#'  # importar contenido del fichero

$dominio = "dominio.local"                    # dominio donde crear las unidades organizativas
$credencialesDominio = Get-Credential -Message "Introduzca las credenciales del dominio"        # credenciales del dominio

foreach ($ou in $ous) # para cada UO...
{
    $rutaUnidadOrganizativa = "ou=" + $ou.Nombre + "," + $ou.contenedor       # ruta completa de la UO

    # comprobar si la UO existe
    if (-not(Get-ADObject -Server $dominio -Credential $credencialesDominio -Filter {distinguishedname -eq $rutaUnidadOrganizativa}))
    {
        # crear UO
        New-ADOrganizationalUnit -Server $dominio -Name $ou.Nombre -Path $ou.contenedor
    }
    else
    {
        Write-host "La unidad organizativa '$rutaUnidadOrganizativa' ya existe" -ForegroundColor Yellow
    }
}