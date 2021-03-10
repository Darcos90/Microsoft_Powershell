#Nos situamos en la ubicación de los binarios de VirtualBox
cd "C:\Program Files\Oracle\VirtualBox"

#Array con la ubicación de los archivos .VDI
$vdis=@(<#Añadir Ruta y archivo .VDI#>)

#Iteración para actualizar el UUID de cada archivo .VDI
foreach ($vdi in $vdis)
{
    .\VBoxManage.exe internalcommands sethduuid "$vdi"
}
