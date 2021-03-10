# 06 - Parametros
# EJEMPLO DE PASO DE PARAMETROS

Param(
    [Parameter(Mandatory=$true)]  # obligatorio
    [ValidateRange(0,100)]        # rango entre 0 y 100
    [int]$operando1,              # valor entero
    [Parameter(Mandatory=$true)]
    [ValidateRange(0,100)]
    [int]$operando2,
    [Parameter(Mandatory=$false)]
    [switch]$suma,                # valor de tipo switch
    [Parameter(Mandatory=$false)]
    [switch]$resta,
    [Parameter(Mandatory=$false)]
    [switch]$multiplicacion
)

if ($suma)                        # verdadero si existe
{
    "La suma de $operando1 y $operando2 es $($operando1 + $operando2)" | Out-Default
}
if ($resta -eq $true)             # verdadero si existe
{
    "La resta de $operando1 menos $operando2 es $($operando1 - $operando2)" | Out-Default
}
if ($multiplicacion)
{
    "La multiplicación de $operando1 y $operando2 es $($operando1 * $operando2)" | Out-Default
}

if ($suma -eq $false -and $resta -eq $false -and $multiplicacion -eq $false)
{
    Write-host "No se ha definido ningún operador" -ForegroundColor Red
}