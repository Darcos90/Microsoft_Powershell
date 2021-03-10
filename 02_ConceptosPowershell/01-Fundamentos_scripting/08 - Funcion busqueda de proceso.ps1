# EJEMPLO DE OBTENCIÓN DE PROCESOS SEGÚN ID O NOMBRE A TRAVÉS DE FUNCIÓN

Param # parametros del script
(
    [ValidateScript({$_ -ge 0})]   # el identificador del proceso debe ser mayor o igual que 0
    [int]
    $IdProceso = $null,
    [string]
    $NombreProceso = $null
)

Function Buscar-Proceso()
{
    Param # parametros de la función
    (
        [ValidateScript({$_ -ge 0})]   # el identificador del proceso debe ser mayor o igual que 0
        [int]
        $Id = $null,
        [string]
        $Nombre = $null
    )

    $procesos = @()

    if ($null -ne $Id) # búsqueda por id
    {
        Write-Host "Buscando por Id '$Id'..." -ForegroundColor Green

        $procesos = Get-Process | Where-Object { $_.Id -eq $Id }  # obtener procesos que tengan dicho identificador

        if ($procesos.Count -ne 0)
        {
            Write-Host "Resultado:" -ForegroundColor Green
            $procesos
        }
        else
        {
            Write-Host "No hay procesos con este identificador" -ForegroundColor Red
        }
        "--------------------------------------------------------------"
    }

    if ($nombre) # búsqueda por nombre
    {
        Write-Host "Buscando por nombre '$nombre'..." -ForegroundColor Green

        $procesos = Get-Process | Where-Object { $_.ProcessName -eq $nombre } # obtener procesos que tengan dicho nombre

        if ($procesos.Count -ne 0)
        {
            Write-Host "Resultado:" -ForegroundColor Green
            $procesos
        }
        else
        {
            Write-Host "No hay procesos con este nombre" -ForegroundColor Red
        }
        "--------------------------------------------------------------"
    }
} # fin código de la función

# llamada a la función usando los parámetros del script
Buscar-Proceso -id $IdProceso -Nombre $NombreProceso