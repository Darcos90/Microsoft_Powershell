# EJEMPLO DE SCRIPT PARA APAGADO REMOTO SI SE CUMPLE DETERMINADA CONDICION

$credEquipoRemoto = Get-Credential # preguntar credenciales del equipo remoto

# invocar comando de forma remota definiendo:
# - nombre/ip del equipo remoto (192.168.2.201)
# - credenciales
# - bloque de script a ejecutar en equipo remoto
Invoke-Command -ComputerName 192.168.2.201 -Credential $credEquipoRemoto -ScriptBlock {

    # a continuaci�n se obtienen los procesos del equipo remoto. Si hay al menos 1 que se llame "notepad", entrar� en el bloque del if

    $procesosRemotosNotepad = Get-Process | Where-Object {$_.ProcessName -eq "notepad"} # obtener procesos del "notepad"
    $numeroProcesosNotepad = $procesosRemotosNotepad.Count # obtener n�mero de procesos

    if ($numeroProcesosNotepad -ge 1)  # validaci�n en una �nica l�nea ==> if ((Get-Process | Where-Object {$_.ProcessName -eq "notepad"}).Count -ge 1)
    {
        Restart-Computer -Force  # Reiniciar equipo forzando la operaci�n
    }
}