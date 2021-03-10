# EJECUCION DE COMANDOS DE FORMA REMOTA

$equipo = "W7"

# obtención de servicios del equipo remoto
Get-Service –ComputerName $equipo
Invoke-Command –ComputerName $equipo –Credential (Get-Credential) –ScriptBlock {

	Get-Service
	
}

# obtención y parada de procesos. 
# - En el primer caso, se obtienen los procesos remotos que comiencen por "note", pero se paran en el equipo local
# - En el segundo caso, se obtiene los procesos remotos que comiencen por "note", pero en este caso sí se para en el equipo remoto
Invoke-Command –ScriptBlock {Get-Process -Name "Note*" } –ComputerName $equipo –Credential (Get-Credential) | Stop-Process
Invoke-Command –ScriptBlock {Get-Process -Name "Note*" | Stop-Process } –ComputerName $equipo –Credential (Get-Credential)

# obtención de servicio en concreto del sistema remoto, indicando su nombre a través de argumento/parámetro
$nombreServicio = "netlogon"
Invoke-Command -computer $equipo -ScriptBlock{Param($nombre) Get-Service -Name $nombre } -ArgumentList $nombreServicio