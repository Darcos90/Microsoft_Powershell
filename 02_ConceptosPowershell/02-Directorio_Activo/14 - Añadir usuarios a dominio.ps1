Import-Module ActiveDirectory

$ficheroUsuarios = ".\usuariosAD.csv"        # fichero con los usuarios a a�adir

$dominio = "dominio.local"                   # dominio donde se van a crear los usuarios
$credencialesDominio = Get-Credential -Message "Introduzca las credenciales del dominio"        # credenciales del dominio

if (Test-Path $ficheroUsuarios)
{
    $usuarios = Import-csv $ficheroUsuarios -Delimiter '#'   # leer usuarios del fichero

    foreach ($usuario in $usuarios) # por cada usuario...
    {
        # guardar los datos en variables temporales
        $dominio = $usuario.dominio
        $rutaUOUsuario = $usuario.UO
        $samAccountName = $usuario.SamAccountName
        $name = $usuario.Name
        $givenName = $usuario.GiveName
        $surname = $usuario.Surname
        $displayName = $usuario.DisplayName
        $accountExpirationDate = $usuario.AccountExpirationDate
        $password = $usuario.Password
        if ($usuario.Habilitado -eq 1)
        {
            $habilitado = $true
        }
        else
        {
            $habilitado = $false
        }
        if ($usuario.CambiarPassword -eq 1)
        {
            $cambiarPassword = $true
        }
        else
        {
            $cambiarPassword = $false
        }
        
        # comprobar si el usuario ya existe
        $rutaUsuario = "cn=" + $samAccountName + "," + $rutaUOUsuario
        if (Get-ADUser -Server $dominio -Credential $credencialesDominio -Filter  {distinguishedname -eq $rutaUsuario})
        {
            Write-host "El usuario '$samAccountName' ya existe" -ForegroundColor Yellow
        }
        else
        {
            # comprobar si la unidad organizativa existe
            if (-not (Get-ADObject -Server $dominio -Credential $credencialesDominio -Filter {distinguishedname -eq $rutaUOUsuario}))
            {
                Write-Host "La UO '$rutaUOUsuario' no existe" -ForegroundColor Red           
            }
            else
            {
                # crear usuario. Informaci�n:
                # - dominio a administrar
                # - UO contenedora del usuario
                # - credenciales del administrador del dominio
                # - cuenta del usuario en el dominio
                # - nombre del usuario a mostrar en el listado de usuarios
                # - nombre de pila
                # - apellido
                # - nombre para mostrar
                # - fecha de expiraci�n
                # - cuenta habilitada
                # - cambiar contrase�a al iniciar sesi�n
                # - Contrase�a de cuenta
                New-ADUser -Server $dominio `
                    -Path $rutaUOUsuario `
                    -Credential $credencialesDominio `
                    -SamAccountName $samAccountName `
                    -Name $name `
                    -GivenName $givenName `
                    -Surname $surname `
                    -DisplayName $displayName `
                    -AccountExpirationDate $accountExpirationDate `
                    -Enabled $habilitado `
                    -ChangePasswordAtLogon $cambiarPassword `
                    �AccountPassword (ConvertTo-SecureString $password �asplaintext �force)
            }
        }
    }
}

# MOVIMIENTO DE USUARIOS ENTRE UNIDADES ORGANIZATIVAS:
#Move-ADObject -Server "dominio.local" -Identity "CN=bfeet,OU=naboo,DC=dominio,DC=local" -TargetPath "CN=Users,DC=dominio,DC=local"