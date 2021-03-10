# Crear un Fichero de contraseña encriptado
(get-credential).password | ConvertFrom-SecureString | set-content "D:\Users\$env:USERNAME\Escritorio\password.txt"

# Reutilizar las contraseñas previamente creadas
$password = Get-Content "D:\Users\$env:USERNAME\Escritorio\password.txt" | ConvertTo-SecureString 
$credential = New-Object System.Management.Automation.PsCredential("username",$password)


#https://www.altaro.com/msp-dojo/encrypt-password-powershell/

#Ejemplo de uso de credenciales

#Montar unidedes de red
New-PSDrive -name "R" -PSProvider FileSystem -Root "\\o-servidor\Repositorio-Software\" -Credential $credential
New-PSDrive -Name "S" -Root "\\Server01\Scripts" -Persist -PSProvider "FileSystem" -Credential $credential