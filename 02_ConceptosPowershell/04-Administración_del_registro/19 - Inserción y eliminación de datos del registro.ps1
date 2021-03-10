# 19 - Inserción y eliminación de datos del registro
# EJEMPLO DE ESCRITURA Y ELIMINACIÓN DE DATOS DEL REGISTRO

# definición de variables y rutas
[string]$path = "HKLM:\SOFTWARE\"  
[string]$nombreClave = "Nueva_Clave"
[string]$nombreValorCadena = "Nuevo_Valor_Cadena"
[string]$nombreValorEntero = "Nuevo_Valor_Entero"
[string]$valorCadena = "valor_cadena"
[int]$valorEntero = 123

# definición de rutas de las propiedades (valores) a insertar en el registro
[string]$rutaValorCadena = $path + "\" + $nombreClave + "\" + $nombreValorCadena
[string]$rutaValorEntero = $path + "\" + $nombreClave + "\" + $nombreValorEntero

# comprobación de la existencia de las claves y valores -> si existen, los eliminamos
if (Test-Path ($path + "\" + $nombreClave))
{
    Remove-Item ($path + "\" + $nombreClave)
}
if (Test-Path $rutaValorCadena)
{
    Remove-Item $rutaValorCadena
}
if (Test-Path $rutaValorEntero)
{
    Remove-Item $rutaValorEntero
}

# creación de la clave
New-Item -Path $path -Name $nombreClave

# creación de dos tipos de valores
New-ItemProperty -Path ($path + "\" + $nombreClave) -Name $nombreValorCadena -Value $valorCadena -PropertyType String
New-ItemProperty -Path ($path + "\" + $nombreClave) -Name $nombreValorEntero -Value $valorEntero -PropertyType DWord

<#
Posibles tipos de propiedades:

Binary
DWord
ExpandString
MultiString
String
QWord
#>