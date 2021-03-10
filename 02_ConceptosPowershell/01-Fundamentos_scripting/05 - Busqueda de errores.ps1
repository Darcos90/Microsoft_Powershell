# 05 - Busqueda de errores
# MODIFICA Y/O ENCUENTRA LOS ERRORES EN EL SCRIPT PARA QUE SE PUEDAN MOSTRAR LAS 12 ITERACIONES (DE 0 A 11) EN CADA EJEMPLO

$iteraciones = "12"

# EJEMPLO 1
Write-host "Bucle 'for'" -ForegroundColor Green
for ($contador = 0; $contador -lt $iteraciones; $contador++)
{
    "Estoy en la iteración $contador" | Out-Default
}
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER



# EJEMPLO 2
Write-host "Bucle 'while'" -ForegroundColor Green
$contador = 0
while ($contador -gt $iteraciones)
{
    "Estoy en la iteración $contador" | Out-Default
    $contador++
}
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER



# EJEMPLO 3
Write-host "Bucle 'do-while'" -ForegroundColor Green
do
{
    "Estoy en la iteración $contador" | Out-Default
    $contador++
}
while ($contador -lt $iteraciones)
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER



# EJEMPLO 4
Write-host "Bucle 'foreach' con array como iteraciones" -ForegroundColor Green
[array]$numeros = @(-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16) # NO ELIMINES NINGUN ELEMENTO DE AQUI
foreach ($iteracion in $numeros) {
    "Estoy en la iteración $iteracion" | Out-Default
}
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER



# EJEMPLO 5
Write-host "Bucle 'foreach' con lista" -ForegroundColor Green
$lista = @()
$lista += 0
$lista += 1
$lista += 2
$lista += 3
$lista += 4
$lista += 5
$lista += 6
$lista += 7
$lista += 8
$lista += 9
$lista += 10
$lista += 11
foreach ($iteracion in $lista.Count) {
    "Estoy en la iteración $iteracion" | Out-Default
}
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER



# EJEMPLO 6
Write-host "Diccionario con bucle 'foreach'" -ForegroundColor Green
$diccionario = @{}
foreach ($clave in $diccionario.Keys)
{
    "La clave $clave corresponde a '$($diccionario[$clave])'" | Out-Default
}
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER



# EJEMPLO 7
Write-host "Diccionario con bucle 'foreach' 2" -ForegroundColor Green
$diccionario = @{}
$diccionario.Add(0, "Elemento0")
$diccionario.Add(1, "Elemento1")
$diccionario.Add(2, "Elemento2")
$diccionario.Add(3, "Elemento3")
$diccionario.Add(4, "Elemento4")
$diccionario.Add(5, "Elemento5")
$diccionario.Add(6, "Elemento6")
$diccionario.Add(7, "Elemento7")
$diccionario.Add(8, "Elemento8")
$diccionario.Add(10, "Elemento10")
$diccionario.Add(11, "Elemento11")
$diccionario.Add(12, "Elemento12")
[array]$claves = @(-1,0,1,2,3,4,5,6,7,8,9,13,12)
foreach ($clave in $claves)
{
    "$($diccionario[$clave])" | Out-Default
}
"----------------------------------------------------------------" | Out-Default
Break ## ELIMINAR TRAS RESOLVER