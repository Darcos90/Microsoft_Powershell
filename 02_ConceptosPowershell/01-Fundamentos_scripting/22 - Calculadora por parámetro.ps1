# EJEMPLO DE CALCULADORA EN FUNCIÓN, PASANDO PARÁMETROS DESDE CONSOLA DE COMANDOS A SCRIPT, Y DESPUÉS A FUNCIÓN

Param(
        [ValidateRange(0,100)]
        [int]$operando1Script,
        [ValidateRange(0,100)]
        [int]$operando2Script,
        [switch]$sumaScript,
        [switch]$restaScript,
        [switch]$multiplicacionScript
    )

# función calculadora
Function Calculadora()
{
    Param(
        [ValidateRange(0,100)]
        [int]$operando1,
        [ValidateRange(0,100)]
        [int]$operando2,
        # a diferencia que en el caso del script, en este caso se debe utilizar el tipo de datos 'bool' ya que estamos 
        #   pasando a la función un parámetro de tipo switch ($sumaScript, $restaScript, $multiplicacionScript)
        [bool]$suma,
        [bool]$resta,
        [bool]$multiplicacion
    )

    if ( $suma -eq $true -or $resta -eq $true -or $multiplicacion -eq $true)
    {
        if ($suma)
        {
            $operando1 + $operando2
        }

        if ($resta)
        {
            $operando1 - $operando2
        }

        if ($multiplicacion)
        {
            $operando1 * $operando2
        }
    }
    else
    {
        "no me has dado operacion"
    }
}

Calculadora -operando1 $operando1Script -operando2 $operando2Script -suma $sumaScript -resta $restaScript -multiplicacion $multiplicacionScript
