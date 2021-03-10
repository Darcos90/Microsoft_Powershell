#Condiciones

if($env:USERNAME -eq "adearcos"){

    write-host "El usuario actual es adearcos"

}
elseif($env:USERNAME -eq "administrador"){

    write-host "El usuario actual es administrador"
    
}
else{

    write-host "el usuario iniciado no es ninguno de los anteriores"

}