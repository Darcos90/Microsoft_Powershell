# 04 - Arrays Listas y Diccionarios
# DEFINICION Y USO DE UN ARRAY
Write-Host "Uso de arrays" -ForegroundColor Green
$array = @(0, 1)  # definición e inicialización del array       

# Inclusión de información en el array
$array += 2
$array += 3
$array += 4

"Número de elementos: $($array.Count)" | Out-Default
foreach ($elemento in $array)
{
    "El valor $elemento está en el array" | Out-Default
}
"El segundo elemento del array es $($array[1])" | Out-Default
"----------------------------------------------------------" | Out-Default

# DEFINICIÓN Y USO DE LISTAS
Write-Host "Uso de listas" -ForegroundColor Green
$lista = New-Object System.Collections.Generic.List[string]

# Eliminación de elementos del array e insercción de nuevos elementos
$lista.clear()
$lista.Add("Item 1")
$lista.Add("Item 2")
$lista.Add("Item 3")
$lista.Add("Item 4")
$lista.Add("Item 5")
    
"Numero de elementos: " + $lista.Count | Out-Default

# Eliminación de un elemento específico
$lista.Remove("Item 5") | Out-Null
"Numero de elementos: " + $lista.Count | Out-Default

# Recorrido del array
for([int]$i = 0; $i -lt $lista.Count; $i++)
{
    "Elemento " + $i + ": " + $lista[$i] | Out-Default
}

# Acceso a elemento específico
[int]$posicion = 0
do
{
    $posicion = Read-Host ("Introduce la posicion del elemento a conocer (de 0 hasta " + ($lista.Count-1) + ")")
}
while($posicion -lt 0 -or $posicion -ge $lista.count) # -ge porque "Count" representa el número de elementos del array, no la última posicion dentro del array
"Valor en la posición '" + $posicion + "': " + $lista[$posicion] | Out-Default
"----------------------------------------------------------" | Out-Default

# DEFINICION Y USO DE UN DICCIONARIO
Write-Host "Uso de diccionarios" -ForegroundColor Green
$diccionario = @{0 = "Elemento 0"; 1 = "Elemento 1"}  # definición e inicialización del diccionario

# agregar valores al diccionario
$diccionario.Add(2, "Elemento 2")
$diccionario.Add(3, "Elemento 3")
$diccionario.Add(4, "Elemento 4")

"El diccionario contiene $($diccionario.Count) elementos" | Out-Default
"Las claves del diccionario son '$($diccionario.Keys)'" | Out-Default
"Los valores del diccionario son '$($diccionario.Values)'" | Out-Default

# buscar un elemento en concreto
if ($diccionario.ContainsKey(1))
{
    "El elemento 1 del diccionario es '$($diccionario[1])'" | Out-Default
}

# obtener el conjunto completo de valores según su clave
foreach ($clave in $diccionario.Keys)
{
    "La clave $clave corresponde a '$($diccionario[$clave])" | Out-Default
}
