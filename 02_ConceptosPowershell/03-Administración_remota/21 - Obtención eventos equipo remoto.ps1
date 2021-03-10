# EJEMPLO DE PASO DE PARÁMETROS A BLOQUE DE CÓDIGO A EJECUTAR EN EQUIPO REMOTO

# definición de variables y valores
$credEquipoRemoto = Get-Credential  # preguntar credenciales del equipo remoto
$nombreLog = "Security"             # nombre del log a comprobar
$cantidad = 10                      # numero de items a obtener del log remoto
$equipo = "192.168.2.201"           # equipo remoto

# ejemplo 1 de paso de parámetros
Invoke-Command -computer $equipo -Credential $credEquipoRemoto -ScriptBlock {

    Param($nombre, $items) # parámetros a usar
    Get-EventLog -LogName $nombre -Newest $items

} -ArgumentList $nombreLog, $cantidad # definición del listado de parámetros/argumentos

# ejemplo 2 de paso de parámetros (se hace referencia a las variables del script a través de "$using:")
Invoke-Command -computer $equipo -Credential $credEquipoRemoto -ScriptBlock {

    Get-EventLog -LogName $using:nombreLog -Newest $using:cantidad

}

