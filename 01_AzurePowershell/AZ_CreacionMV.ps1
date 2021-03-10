#Script creación de máquinas virutales en Azure

#Install-Module -name az -AllowClobber

#Import-Module -name Az

#Connect-AzAccount

Get-AzSubscription | ft

Select-AzSubscription -Subscription


$Subscription="Experimentaci"
$vmName="testvm-eus-01"
$location="West EU"
$imageSO="UbuntuLTS"
$openPorts=22 , 3389


New-AzVm -ResourceGroupName [sandbox resource group name] -Name $vmName -Credential (Get-Credential) -Location $location -Image $imageSO -OpenPorts $ports -watif