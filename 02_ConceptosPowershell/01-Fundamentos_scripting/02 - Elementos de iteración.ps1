#02 - Elementos de iteración
# ITERACIÓN DE ELEMENTOS EN BUCLE

[int]$contador = 1;

Write-host "`nIteración en bucle 'while':" -ForegroundColor Green
# Inicialización de contador
$contador = 1;
while($contador -lt 10) # Condición a evaluar antes de entrar en el bucle
{
    "Iteración en while: '" + $contador + "'" | Out-Default
    $contador = $contador + 1
}
"------------------------------------------------------------------------" | Out-Default

Write-host "`nIteración en bucle 'do-while':" -ForegroundColor Green
$contador = 10;
do
{
    "Iteración en do-while: '" + $contador + "'" | Out-Default
    $contador = $contador + 1
}while($contador -lt 10) # Condición a evaluar tras ejecutar el contenido del bucle
"------------------------------------------------------------------------" | Out-Default

Write-host "`nIteración en bucle 'for':" -ForegroundColor Green
for ($contador = 1; $contador -lt 10; $contador++)
{
    "Iteración en for: '" + $contador + "'" | Out-Default
}
"------------------------------------------------------------------------" | Out-Default

# Definición de array de elementos
[array]$numeros = @(1,2,3,4)
# Recorrer el array mostrando cada elemento
foreach ($numero in $numeros)
{
	"Elemento '" + $numero + "'" | Out-Default
}
"------------------------------------------------------------------------" | Out-Default

# Ejemplo de obtención de procesos
[array]$procesos = @()

$procesos = Get-Process

Write-host "`nLos procesos del sistema son: " -ForegroundColor Green
$procesos | Out-Default
"------------------------------------------------------------------------" | Out-Default


# Uso de bucle while para recorrer procesos
$contador = 0;
Write-host "`nIteración de procesos usando bucle while: " -ForegroundColor Green
while($contador -lt $procesos.Count) # Condición a evaluar antes de entrar en el bucle
{
    "Este proceso se llama: '" + $procesos[$contador].ProcessName + "'" | Out-Default # Acceso a propiedad de un proceso específico dentro del array
    $contador = $contador + 1
}
"------------------------------------------------------------------------" | Out-Default

Write-host "`nIteración de procesos usando bucle do-while: " -ForegroundColor Green
$contador = 0;
do
{
    "Este proceso se llama: '" + $procesos[$contador].ProcessName + "'" | Out-Default # Acceso a propiedad de un proceso específico dentro del array
    $contador = $contador + 1
}while($contador -ne $procesos.Count) # Condición a evaluar tras ejecutar el contenido del bucle
"------------------------------------------------------------------------" | Out-Default

# Uso de bucle for para recorrer procesos
Write-host "`nIteración de procesos usando bucle for: " -ForegroundColor Green
for ($contador = 1; $contador -lt $procesos.Count; $contador++)
{
    "Este proceso se llama: '" + $procesos[$contador].ProcessName + "'" | Out-Default # Acceso a propiedad de un proceso específico dentro del array
}
"------------------------------------------------------------------------" | Out-Default

# Uso de foreach
Write-host "`nIteración de procesos usando bucle foreach: " -ForegroundColor Green
foreach($proceso in $procesos)
{
    "Este proceso se llama: '" + $proceso.ProcessName + "'" | Out-Default # Acceso a propiedad del proceso actual
}
"------------------------------------------------------------------------" | Out-Default

# Uso de '%'
Write-host "`nIteración de procesos usando bucle foreach: " -ForegroundColor Green
$procesos | % {
    "Este proceso se llama: '" + $_.ProcessName + "'" | Out-Default # Acceso a propiedad del proceso actual
}