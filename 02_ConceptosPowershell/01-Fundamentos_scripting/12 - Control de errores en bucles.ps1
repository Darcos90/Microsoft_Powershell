# 08 - Control de errores en bucles
# USO DE CONTROL DE ERRORES CON BUCLES

$ErrorActionPreference = 'Continue' # no interrupción del script y visualización de errores

$array = New-Object System.Collections.Generic.List[string]

Write-Host "Ejemplo de try-catch fuera del bucle" -ForegroundColor Green
try # Comienzo de bloque de código en el que se controlan los errores
{
    [int]$cont = 2
    for([int]$in = 0;$in -lt $cont; $in++)
    {
        "Estamos en la iteración $in del primer ejemplo" | Out-Default
        $array.clo() # provocar error => el bucle for se parará
    }
}
Catch [Exception]
{
	# código tras error
	Write-host "`tMensaje de error" -ForegroundColor Red
}
Finally
{
	# código al finalizar
}
"Fin primer ejemplo" | Out-Default
"-----------------------------------------------------------------------" | Out-Default

Write-Host "Ejemplo de try-catch dentro del bucle" -ForegroundColor Green
[int]$cont = 2
for([int]$in = 0;$in -lt $cont; $in++)
{
    try # Comienzo de bloque de código en el que se controlan los errores
    {
        "Estamos en la iteración $in del segundo ejemplo" | Out-Default
        $array.clo() # provocar error => el bucle for no se parará
    }
    Catch [Exception]
    {
	    # código tras error
	    Write-host "`tMensaje de error" -ForegroundColor Red
    }
    Finally
    {
	    # código al finalizar
    }
}
"Fin segundo ejemplo" | Out-Default
"-----------------------------------------------------------------------" | Out-Default