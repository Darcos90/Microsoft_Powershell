<#
Comando:makecert

Sintáxis:
makedert -n "CN=Powershell i64" -a sha1 -ss MY -pe -eku 1.3.

 Parámetros:
  -a: indica algoritmo d la firma
  -n: indica el nombre del certificado
  -r: indica que el certificado será autofirmado
  -sv:indica cual es  la clave privada asociada a un certificado
  -ss: indica el nombre del almacén (My=personal/Root=CA)
  -sr: indica en que zona del registro se registra el almacén del certificado
  -eku: inserta identificadores. En este caso se está indicando el propósito del certificado con este código
  -iv: indica el archivo de la clave privada
  -pe: incluye la clave privada en el certificado
  -ic: indica el archivo del certificado

  Requisitos: instalar Microsoft Windows SKD

Firmar script

$cert= ls -path cert:\currentuser\my -codesigningCert
Set-autentica

Set-AuthenticodeSignature .\rutascript\script.ps1 -certifiate $cert

#>
