$services=@("AdobeARMservice","AJRouter","ALG","AppHostSvc","AppIDSvc","Appinfo","AppMgmt")

foreach($service in $services){

        $arg=Get-Service -Name $service
     
        if($arg.status -eq "running"){
        
        Write-host -Foregroundcolor Green "El servicio $service está en estado Running"
        
        }
        elseif($arg.status -eq "Stopped"){
        
        Write-host -ForegroundColor red "El servicio $service está en estado Stopped"
        
        }
}