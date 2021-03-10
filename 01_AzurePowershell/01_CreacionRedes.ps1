#Inicio de sesión en Azure desde powershell
    Connect-AzAccount

#Creación de grupo de recursos "RG"
    $Location="EastUS" 
    New-AzResourceGroup -Name vm-networks -Location $Location


#Creación de Red virtual y subred
    $Subnet=New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
    New-AzVirtualNetwork -Name myVnet -ResourceGroupName vm-networks -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet

#Creación de Máquinas virtuales
    #Cración de MV WinServer2016 Datacenter
        New-AzVm `
        -ResourceGroupName "vm-networks" `
        -Name "dataProcStage1" `
        -VirtualNetworkName "myVnet" `
        -SubnetName "default" `
        -image "Win2016Datacenter" `
        -Size "Standard_DS2_v2"
        #Nota:El puerto 3389 se abrirá automáticamente de forma predeterminada al crear una máquina virtual Windows en Azure.

    #Asignación IP publica para acceso remoto al servidor
        Get-AzPublicIpAddress -Name dataProcStage1

    #Desasignar IP publica
        $nic = Get-AzNetworkInterface -Name dataProcStage2 -ResourceGroup vm-networks
        $nic.IpConfigurations.publicipaddress.id = $null
        Set-AzNetworkInterface -NetworkInterface $nic

    #Conexión a mv mediante escritorio remoto
        mstsc /v:<publicIpAddress>
        #Nota:Inicie sesión en el equipo remoto con el nombre de usuario y la contraseña que ha creado. En la sesión remota, abra el símbolo del sistema de Windows y ejecute el comando siguiente:
        ping dataProcStage2 -4
        


