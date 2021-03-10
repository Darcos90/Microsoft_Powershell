
#Obtener estado de las politicas de ejecución de scripts en powershell
get-ExecutionPolicy

#Asignar política de ejecución de scripts
Set-ExecutionPolicy -ExecutionPolicy Bypass -File "c:\MyScript.ps1"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned


#Alias y funciones similares

Write-Host

write-host "hola mundo"

write-output "hola mundo"

$message=Write-Output "hola mundo"

echo 'hola mundo'

write 'hola mundo'


#Listar elementos de una ruta
ls

dir

Get-ChildItem

#Crear un propio alias cn el cmdlet Set-alias el tiempo de vida del alias durará hasta que la sesión de usuario finalice
Set-Alias -name ipadd -value ipconfig

#1.3: Pipe - Utilización de una salida desde PowerShell
Get-ChildItem | Select-Object Name

#More advanced usage of the pipeline allows us to pipe the output of a cmdlet into a foreach loop:
Get-ChildItem | ForEach-Object {    Copy-Item -Path $_.FullName -destination C:\NewDirectory\ }
#This may be shortened to: gci | % { Copy $_.FullName C:\NewDirectory\ }


#This may be shortened to: 

gci | % { Copy $_.FullName C:\NewDirectory\ }

#Note that the example above uses the $_ automatic variable. $_ is the short alias of $PSItem which is an automatic variable which contains the current item in the pipeline.

#Calling .Net Library Methods
#Calling Path.GetFileName()

[System.IO.Path]::GetFileName('C:\Windows\explorer.exe')

#1.6 Comentarios

#comentario simple

<#comentario
multilínea#>

#1.7 creando objetos

# New-Objet cmdlet is used to create an object

# Create a DateTime object and stores the object in variable "$var"
$var = New-object System.DateTime

# Calling constructor with parameters

$sr = New-Object System.IO.SteamReader -ArgumentList "file path"


#In many instances, a new object will be created in order to export data or pass it to another commandlet. This can be done like so:

$newObject = New-Object -TypeName PSObject -Property @{    
    ComputerName = "SERVER1"
    Role = "Interface"
    Environment = "Production" 
}

#In case you already have an object, but you only need one or two extra properties, you can simply add that property by using Select-Object:

Get-ChildItem | Select-Object FullName, Name,    @{Name='DateTime'; Expression={Get-Date}},    @{Name='PropertyName'; Expression={'CustomValue'}}


# Chapter2: Variables in Powershell

#Section 1.2: Simple variable

$foo = "bar"

#Section 2.2: Arrays

$myarrayOfints = 1,2,3,4

$myarrayOfStrings = "1","2","3","4"

$myarrayOfpeople = @("Juan","Ramon","Lucia","Paco")

#Adding to an array

$myarrayOfints = 1,2,3,4

$myarrayOfints = $myarrayOfints + 5

#Combinar Arrays con el operador "+"

$myArrayOfInts = 1,2,3,4

$myOtherArrayOfInts = 5,6,7

$myArrayOfInts = $myArrayOfInts + $myOtherArrayOfInts # now 1,2,3,4,5,6,7

Write-Host $myarrayOfints

#Section 2.3: List Assignment of Multiple Variables

$input = "foo.bar.baz"
$parts = $input.Split(".")
$foo = $parts[0]
$bar = $parts[1]
$baz = $parts[2]

#You can simply do this:

$foo, $bar, $baz = $input.Split(".")


#list of variables to assign them to, the last variable becomes an array of the remaining values. This means you can also do things like this:
$foo, $leftover = $input.Split(".") #Sets $foo = "foo", $leftover = ["bar","baz"]

$bar = $leftover[0] # $bar = "bar" 
$baz = $leftover[1] # $baz = "baz

#Section 2.4: Scope
$foo = "Global Scope" 
function myFunc {    
    $foo = "Function (local) scope"    
    Write-Host $global:foo
    Write-Host $local:foo
    Write-Host $foo 
} 
myFunc 
Write-Host $local:foo
Write-Host $foo