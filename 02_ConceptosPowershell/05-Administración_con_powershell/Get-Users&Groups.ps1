$array = @("Administradores","Administradores de Hyper-V","docker-users","Duplicadores","HomeUsers","IIS_IUSRS","Invitados","Lectores del registro de eventos","Operadores criptográficos","Operadores de asistencia de control de acceso","Operadores de configuración de red","Operadores de copia de seguridad","System Managed Accounts Group","Usuarios","Usuarios avanzados","Usuarios COM distribuidos","Usuarios de administración remota","Usuarios de escritorio remoto","Usuarios del monitor de sistema","Usuarios del registro de rendimiento")

$array.GetType()

foreach($val in $array){

    Write-Host -foregroundcolor Yellow "Miembros del grupo $val"

    Get-LocalGroupMember -Name $val
    
}


#Get-LocalGroupMember -Name "Miembros del grupo Administradores de Hyper-V"