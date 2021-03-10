#Importar Módulos de Azure

Install-Module -Name AZ -AllowClobber

#Actualizar módulos de Azure
Update-Module -Name AZ

#Importar módulos de Azure
Import-Module Az

#Conexión a Microsoft Azure
Connect-AzAccount

#Obtener/Listar Subscripciones
Get-AzSubscription

#Seleccionar Subscripciones
Select-AzSubscription -Subscription "nombre subscripción"

#Obtener los grupos de recursos
Get-AzResource
Get-AzResource | ft
Get-AzResource -ResourceGroupName "Nombre del grupo de recursos"

#Crear máquina virtual
<# 
Azure PowerShell proporciona el cmdlet New-AzVm para crear una máquina virtual. El cmdlet tiene muchos parámetros para que pueda controlar la gran cantidad de valores de configuración de la máquina virtual. La mayoría de los parámetros tiene valores predeterminados razonables, por lo que solo es necesario especificar cinco elementos:

    ResourceGroupName: el grupo de recursos en el que se colocará la nueva máquina virtual.
    Name: el nombre de la máquina virtual en Azure.
    Location: ubicación geográfica donde se aprovisionará la máquina virtual.
    Credential: un objeto que contiene el nombre de usuario y la contraseña de la cuenta de administrador de la máquina virtual. Aquí se usará el cmdlet Get-Credential. Este cmdlet pedirá un nombre de usuario y una contraseña, los empaquetará en un objeto de credencial.
    Image: la imagen de sistema operativo que se va a usar para la máquina virtual. Suele ser una distribución de Linux o Windows Server.


   New-AzVm
       -ResourceGroupName <resource group name>
       -Name <machine name>
       -Credential <credentials object> 
       -Location <location> 
       -Image <image name>
#>

New-AzVM -Name MyVm -ResourceGroupName ExerciseResources -Credential (Get-Credential) ...
New-AzVm -ResourceGroupName [sandbox resource group name] -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22

<#

El sufijo AzVM es específico de los comandos basados en máquina virtual de PowerShell. No obstante, se pueden usar otros:

Comando 	Descripción
Remove-AzVM 	Elimina una máquina virtual de Azure.
Start-AzVM 	Iniciar una máquina virtual detenida.
Stop-AzVM 	Detener una máquina virtual en ejecución.
Restart-AzVM 	Reiniciar una máquina virtual.
Update-AzVM 	Actualiza la configuración de una máquina virtual.

#>

#Obtener información de una MV

#Puede enumerar las máquinas virtuales de su suscripción con el comando Get-AzVM -Status. También puede especificar una máquina virtual con la propiedad -Name. Aquí se asigna a una variable de PowerShell:

$vm = Get-AzVM  -Name MyVM -ResourceGroupName ExerciseResources

#Lo interesante es que se trata de un objeto con el que puede interactuar. Por ejemplo, puede tomar dicho objeto, realizar los cambios que quiera y, después, enviar esos cambios a Azure con el comando Update-AzVM:

$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm

#Ejemplo de creación de la VM
New-AzVm -ResourceGroupName [sandbox resource group name] -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22
$vm = Get-AzVM -Name "testvm-eus-01" -ResourceGroupName [sandbox resource group name]
Write-Host $vm
<#
ResourceGroupName : [sandbox resource group name]
Id                : /subscriptions/xxxxxxxx-xxxx-aaaa-bbbb-cccccccccccc/resourceGroups/[sandbox resource group name]/providers/Microsoft.Compute/virtualMachines/testvm-eus-01
VmId              : xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
Name              : testvm-eus-01
Type              : Microsoft.Compute/virtualMachines
Location          : eastus
Tags              : {}
HardwareProfile   : {VmSize}
NetworkProfile    : {NetworkInterfaces}
OSProfile         : {ComputerName, AdminUsername, LinuxConfiguration, Secrets}
ProvisioningState : Succeeded
StorageProfile    : {ImageReference, OsDisk, DataDisks}
#>


#Puede acceder a objetos complejos a través de la sintaxis de un punto ("."). Por ejemplo, para ver las propiedades del objeto VMSize asociado a la sección HardwareProfile, puede escribir:
$vm.StorageProfile

#Incluso puede pasar el objeto de máquina virtual a otros cmdlets. Por ejemplo, esto recupera la dirección IP pública de la máquina virtual:
$vm | Get-AzPublicIpAddress

#Con la dirección IP, puede conectarse a la máquina virtual con SSH. Por ejemplo, si ha usado el nombre de usuario "bob" y la dirección IP es "205.22.16.5", este comando conectaría a la máquina Linux:
ssh bob@205.22.16.5

#Eliminación de una máquina virtual

#1.Primero tiene que cerrarla.
Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

#2.Eliminar VM
Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

#Comprobar eliminación del recurso
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | ft

<#
Debería ver una serie de recursos (discos, redes virtuales, etc.) que aún existen.
output

Microsoft.Compute/disks
Microsoft.Network/networkInterfaces
Microsoft.Network/networkSecurityGroups
Microsoft.Network/publicIPAddresses
Microsoft.Network/virtualNetworks
#>

#Esto se debe a que el comando Remove-AzVMsolo elimina la máquina virtual. No limpia ninguno de los demás recursos. En este punto, simplemente eliminaríamos el grupo de recursos y nos libraríamos de él. Pero vamos a continuar el ejercicio para limpiarlo manualmente. Debería ver un patrón en los comandos.

#Eliminación de la interfaz de red.
$vm | Remove-AzNetworkInterface –Force

#Eliminación de los discos administrados del SO y la cuenta de almacenamiento
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force

#Eliminación de red virtual.
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force

#Elimine el grupo de seguridad de red.
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force

#Por último, la dirección IP pública.
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force

#Deberíamos haber acabado con todos los recursos creados; compruebe el grupo de recursos para asegurarse. Hemos ejecutado muchos comandos manuales, pero una forma mejor hubiera sido escribir un script para poder volver a usar esta lógica más adelante para crear o eliminar una máquina virtual. Vamos a examinar la creación de scripts con PowerShell.

<#Técnicas de PowerShell

PowerShell tiene muchas características que se encuentran en los lenguajes de programación típicos. Se pueden definir variables, usar bifurcaciones y bucles, parámetros de línea de comandos de captura, escribir funciones, agregar comentarios y así sucesivamente. En este script se necesitarán tres características: variables, bucles y parámetros.
Variables

Como se vio en la última unidad, PowerShell admite variables. Use $ para declarar una variable y = para asignar un valor. Por ejemplo:#>

$loc = "East US"
$iterations = 3

#Las variables pueden contener objetos. Por ejemplo, en la definición siguiente se establece la variable adminCredential para el objeto devuelto por el cmdlet Get-Credential.
$adminCredential = Get-Credential

#Para obtener el valor almacenado en una variable, use el prefijo $ y su nombre como se muestra a continuación:
$loc = "East US"
New-AzResourceGroup -Name "MyResourceGroup" -Location $loc

#Bucles
#PowerShell tiene varios bucles: For, Do...While, For...Each, etc. El bucle For es la mejor coincidencia para nuestras necesidades ya que ejecutará un cmdlet un número fijo de veces.

#A continuación se muestra la sintaxis básica; el ejemplo se ejecuta durante dos iteraciones y, cada vez, se imprime el valor de i. Los operadores de comparación se escriben -lt para "menor que", -le para "menor o igual que", eq para "igual", ne para "no igual", etc.

For ($i = 1; $i -lt 3; $i++)
{
    $i
}


#Parámetros

#Cuando se ejecuta un script, se pueden pasar argumentos en la línea de comandos. Se pueden proporcionar nombres para cada parámetro para ayudar a que el script extraiga los valores. Por ejemplo:

.\setupEnvironment.ps1 -size 5 -location "East US"

#Dentro del script, los valores se capturan en variables. En este ejemplo, los parámetros se comparan por nombre:

param([string]$location, [int]$size)

#Puede omitir los nombres de la línea de comandos. Por ejemplo:

.\setupEnvironment.ps1 5 "East US"

#Dentro del script, se recurre a la posición para buscar coincidencias cuando los parámetros no tienen nombre:

param([int]$size, [string]$location)

#Podríamos tomar estos parámetros como entrada y usar un bucle para crear un conjunto de máquinas virtuales con los parámetros especificados. A continuación, intentaremos esto.

#La combinación de PowerShell y Azure PowerShell ofrece todas las herramientas necesarias para la automatización de Azure. En nuestro ejemplo CRM, podremos crear varias máquinas virtuales con Linux con un parámetro para que el script sea genérico y un bucle para evitar código repetido. Esto significa que una operación que antes era compleja ahora se puede ejecutar en un solo paso.