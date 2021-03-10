# EJEMPLO DE GESTIÓN DE CREDENCIALES

$fichero = ".\passwords.txt"

# escritura de contraseña "cifrada" en disco
Read-host "Introduce la contraseña" -AsSecureString | ConvertFrom-SecureString | Out-File $fichero

# lectura de contraseña de disco
$pass = get-content $fichero | ConvertTo-SecureString

# creción de objeto de credenciales
$cred = new-object -TypeName System.Management.Automation.PSCredential -arg "dominio\admin", $pass
