#Creación y guardado de scripts en Azure PowerShell

<#
En esta unidad, continuará con el ejemplo de una empresa que crea herramientas administrativas con Linux. Recuerde que tiene previsto usar máquinas virtuales Linux para permitir que los clientes potenciales prueben el software. Tiene un grupo de recursos listo y ahora es el momento de crear las máquinas virtuales.

Su empresa ha pagado por un stand en la gran feria de Linux. Planea habilitar un área de demostración que contiene tres terminales, cada una de ellas conectada a una máquina virtual Linux independiente. Al final de cada día, desea eliminar las máquinas virtuales y volver a crearlas, para empezar de cero cada mañana. Crear las máquinas virtuales manualmente después de trabajar cuando está cansado sería una tarea propensa a errores. Desea escribir un script de PowerShell para automatizar el proceso de creación de máquinas virtuales.
Escritura de un script que crea máquinas virtuales

Siga estos pasos en el lado derecho de Cloud Shell para escribir el script:

    Cambie a la carpeta principal en Cloud Shell.

#>

Set-Location $HOME\clouddrive

#Cree un archivo de texto denominado ConferenceDailyReset.ps1.

touch "./ConferenceDailyReset.ps1"

#Abra el editor integrado y seleccione el archivo ConferenceDailyReset.ps1.

code "./ConferenceDailyReset.ps1"
<#
Sugerencia: Cloud Shell integrado también admite emacs, vim y nano si prefiere usar uno de esos editores.

Empiece por capturar el parámetro de entrada en una variable. Agregue la siguiente línea al script:
#>

param([string]$resourceGroup)

#Nota: Normalmente, tiene que autenticarse en Azure con las credenciales mediante Connect-AzAccount y esto se puede hacer en el script. Pero en el entorno de Cloud Shell ya estará autenticado, por lo que esto no es necesario.

#Pida un nombre de usuario y una contraseña para la cuenta de administrador de la máquina virtual y capture el resultado en una variable:

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

#Cree un bucle que se ejecute tres veces:

For ($i = 1; $i -le 3; $i++) 
{

}

#En el cuerpo del bucle, cree un nombre para cada máquina virtual, almacénelo en una variable y envíelo a la consola:

$vmName = "ConferenceDemo" + $i
Write-Host "Creating VM: " $vmName

#Luego cree una máquina virtual con la variable $vmName:


    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS

    Guarde el archivo. Puede usar el menú "..." de la esquina superior derecha del editor. También hay teclas de aceleración comunes para Guardar.

#Este es el aspecto que debería tener el script completado:


param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}

#Ejecución del script

#Cierre el editor mediante el menú contextual "...".

    Ejecute el script.
    PowerShell

    .\ConferenceDailyReset.ps1 [sandbox resource group name]

<#El script puede tardar varios minutos en completarse. Cuando haya finalizado, compruebe que se ha ejecutado correctamente al examinar los recursos que ahora hay en el grupo de recursos:
PowerShell#>

Get-AzResource -ResourceType Microsoft.Compute/virtualMachines
<#
Debería ver tres máquinas virtuales, cada una con un nombre único.

Ha escrito un script que ha automatizado la creación de tres máquinas virtuales en el grupo de recursos indicado por un parámetro de script. El script es corto y sencillo pero automatiza un proceso que tardaría mucho tiempo en completar manualmente en Azure Portal.

Limpieza

El espacio aislado limpia los recursos automáticamente cuando haya terminado con este módulo.

Al trabajar en una suscripción propia, se recomienda identificar al final de un proyecto si aún necesita los recursos creados. Dejar recursos en funcionamiento puede costarle dinero. Puede eliminar recursos de forma individual o eliminar el grupo de recursos para eliminar todo el conjunto de recursos.

Cuando esté trabajando con su suscripción, podrá usar el siguiente cmdlet de PowerShell para eliminar el grupo de recursos (y todos los recursos relacionados).
PowerShell
##>
Remove-AzResourceGroup -Name MyResourceGroupName