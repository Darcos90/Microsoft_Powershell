# EJEMPLO DE CÓMO USANDO LA OPCION SELECCIONAR DE LA VENTANA DE POWERSHELL, ES POSIBLE PARAR LA EJECUCIÓN DEL SCRIPT

$contador = 0

while ($true) # bucle sin fin
{
    $contador | Out-File .\contador.txt -Append # escribimos la salida al final de un fichero para comprobar si por debajo se está ejecutando algo
    $contador | Out-Default # escribimos en la consola
    $contador++
    Start-Sleep -Seconds 1 # esperamos 1 segundo antes de continuar
}