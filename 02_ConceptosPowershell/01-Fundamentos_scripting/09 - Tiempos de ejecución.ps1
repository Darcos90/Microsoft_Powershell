# EJEMPLO DE CONSUMO DE TIEMPOS DE OPERACIONES
# Nota: se recomienda no tomar como referencia este ejemplo ya que el consumo de tiempos en cada caso dependerá de la carga del procesador, y de la forma interna que tiene Windows de realizar la llamada a, en este caso, Get-Process y de almacenar la información en la caché del sistema. El propósito principal del script es mostrar cómo medir tiempos de ejecución.

# operación de búsqueda de procesos usando where-object
$tiempo = Measure-Command {
    $procesos1 = @()
    $procesos1 = Get-Process | Where-Object { $_.Id -eq 0 }

} | select TotalMilliseconds

Write-host "Tiempo de ejecución usando usando where-object ----------------> $($tiempo.TotalMilliseconds) milisegundos" -ForegroundColor Green

Start-Sleep -Seconds 5
# operación de búsqueda de procesos usando opcion ID de Get-Process
$tiempo = Measure-Command {
    $procesos3 = @()
    $procesos3 = Get-Process -Id 0

} | select TotalMilliseconds

Write-host "Tiempo de ejecución usando usando opcion ID de Get-Process ----> $($tiempo.TotalMilliseconds) milisegundos" -ForegroundColor Green

Start-Sleep -Seconds 5
# operación de búsqueda de procesos usando bucle
$tiempo = Measure-Command {
    $procesos2 = @()
    $resultado = @()
    $procesos2 = Get-Process

    foreach ($proceso in $procesos2)
    {
        if ( $proceso.Id -eq 0)
        {
            $resultado += $proceso
        }
    }

} | select TotalMilliseconds

Write-host "Tiempo de ejecución usando bucle ------------------------------> $($tiempo.TotalMilliseconds) milisegundos" -ForegroundColor Green
