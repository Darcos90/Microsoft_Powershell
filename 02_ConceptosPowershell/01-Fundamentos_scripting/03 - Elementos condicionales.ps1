# 03 - Elementos condicionales
# ELEMENTOS CONDICIONALES

$a = 1
# condición simple
if ($a -eq 1)                  # la condición se cumple (es verdadera)
{
    "'a' vale 1" | Out-Default
}

$a = 5
# condición compleja
if ($a -eq 1)                  # la condición se cumple (es verdadera)
{
    "'a' vale 1" | Out-Default
}
else                           # la condición no se cumple (es falsa)
{
    "'a' no vale 1" | Out-Default
    "'a' vale $a" | Out-Default
}

# condición múltiple
if ($a -eq 1)
{
    "'a' vale 1" | Out-Default
}
elseif ($a -eq 2)
{
    "'a' vale 2" | Out-Default
}
elseif ($a -eq 3)
{
    "'a' vale 3" | Out-Default
}
else
{
    "'a' no vale ni 1, ni 2, ni 3" | Out-Default
}

# FILTRADO DE SERVICIOS SEGÚN ESTADO DE EJECUCIÓN

[array]$servicios = Get-Service

$servicios | % {
    if ($_.Name -like 'w*' -and 'running' -eq $_.Status)
    {
        "El servicio '$($_.Name)' está en ejecución y comienza por 'w'" | Out-Default
    }
}
