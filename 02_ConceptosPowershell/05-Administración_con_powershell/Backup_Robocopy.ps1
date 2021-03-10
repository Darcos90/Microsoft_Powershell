Write-host "La ejecución del script se ha de realizar con privilegios de administrador."
Write-host "Por favor, salga del script en caso de no haber elevado privilegios."
pause

#Obtener permisos de ejecución de Scripts
Get-ExecutionPolicy

#Quitar restricciones de ejecución
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
pause

#copia todos los archivos incluidos ficheros vacíos
#robocopy <origen> <destino> /E /MIR
robocopy D:\Users\nombreUsuario\Escritorio\folder D:\Users\nombreUsuario\Escritorio\EXAMPLE\ /E

#Aplicar restricciones de ejecución
Set-ExecutionPolicy -ExecutionPolicy Restricted

pause
