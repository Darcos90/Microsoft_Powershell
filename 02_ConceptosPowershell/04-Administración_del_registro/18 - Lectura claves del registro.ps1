# EJEMPLO PARA OBTENER LAS APLICACIONES DEL SISTEMA DESDE EL REGISTRO

$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\" # ruta del registro del que obtener información

if (Test-Path $path)
{
    $subclaves = Get-ChildItem $path  # obtenemos las subclaves de la ruta del registro

    Write-Host "Aplicaciones detectadas en el registro a nivel de máquina (HKLM):" -ForegroundColor Green
    foreach ($subclave in $subclaves)  # iteramos entre las subclaves
    {
        $rutaTemporal = $subclave.Name.ToUpper() # obtenemos la ruta de la subclave y la convertimos a mayúsculas
        $rutaTemporal = $rutaTemporal.Replace("HKEY_LOCAL_MACHINE\","HKLM:\") # reemplazamos la ruta para poder acceder

        $propiedades = Get-ItemProperty -Path $rutaTemporal # obtenemos las propiedades (valores) de la subclave

        if ($propiedades -ne $null -and $propiedades.DisplayName -ne $null) # comprobamos si tiene valores y si tiene la que nos interesa
        {
            $propiedades.DisplayName
        }
    }
}
else
{
    Write-Host "La ruta '$path' no existe" -ForegroundColor Red
}
"----------------------------------------------------------" | Out-Default