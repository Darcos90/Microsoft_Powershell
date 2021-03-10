# 07 - Control de errores
# EJEMPLOS DE DIFERENTES FORMAS DE CONTROLAR Y GESTIONAR LSO ERRORES

# el siguiente ejemplo no entra en la clausula 'catch' por lo que no se controla el error, y se muestra
Write-host "Ejemplo 1 (Continue): no se controla el error y se muestra el error de PowerShell" -ForegroundColor Green
$ErrorActionPreference = "Continue"
try
{
    Get-Item ".\file"
}
Catch [Exception]
{
    Write-host "Error ejemplo1: $($_.Exception.Message)" -ForegroundColor Red
}
"-----------------------------------------------------------------------------" | Out-Default


# el siguiente ejemplo no muestra ningún error y continua la ejecución
Write-host "Ejemplo 2 (SilentlyContinue): se controla el error, pero no entra el 'catch'" -ForegroundColor Green
$ErrorActionPreference = "SilentlyContinue"
try
{
    Get-Item ".\file2"
}
Catch [Exception]
{
    Write-host "Error ejemplo2: $($_.Exception.Message)" -ForegroundColor Red
}
"-----------------------------------------------------------------------------" | Out-Default


# el siguiente ejemplo para dentro de la clausula 'catch'
Write-host "Ejemplo 3 (Stop): se controla el error, y entra el 'catch'" -ForegroundColor Green
$ErrorActionPreference = "Stop"
try
{
    Get-Item ".\file3"
}
Catch [Exception]
{
    Write-host "Error ejemplo3: $($_.Exception.Message)" -ForegroundColor Red
}
"-----------------------------------------------------------------------------" | Out-Default


# el siguiente ejemplo pregunta antes de continuar
Write-host "Ejemplo 4 (Inquire): se controla el error, y se pregunta al usuario por lo que se debe hacer" -ForegroundColor Green
$ErrorActionPreference = "Inquire"
try
{
    Get-Item ".\file4"
}
Catch [Exception]
{
    Write-host "Error ejemplo4: $($_.Exception.Message)" -ForegroundColor Red
}
"-----------------------------------------------------------------------------" | Out-Default