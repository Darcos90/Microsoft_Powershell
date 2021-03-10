#Bucles

#Bucle FOR
for($c=0;$c -le 11;$c++){

    write-host $c

}


#Bucle FOREACH
$dias=@("Lunes","Martes","Miercoles")

foreach($dia in $dias){

    write-host $dia

}

#Bucles DOWHILE
$cont=0
do{

    $cont=$cont+1
write-host "hola mundo"

}while($cont -lt 10)


$cont1=0
while($cont1 -lt 10){

    $cont1=$cont1+1
    write-host "hola mundo"

}