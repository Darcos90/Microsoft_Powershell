##Getting LetterDrive
[string[]] $drives = $null;
gwmi win32_logicaldisk -filter "drivetype = 3" | Select Name  | % { $drives +=  $_.Name   }
$drives -is [array]
Write-Output $drives


#Probar otro metodo de obtención de unidad del disco
<#$drives = get-wmiobject win32_logicaldisk -filter "drivetype=3" | select-object -expandproperty name
write-output $drives#>
#https://stackoverflow.com/questions/36607341/list-of-drives-as-string-array


foreach ($drive in $drives){


    #Get-ChildItem C:\ -recurse

   # Get-ChildItem $drive -recurse | Get-Acl | fl >> D:\Users\$env:USERNAME\Escritorio\acl_all_Drives.txt

    Get-ChildItem $drive | Get-Acl | fl >> "D:\Users\$env:USERNAME\Escritorio\Root_Device.txt"


#get-acl 

#Clear-Variable drives
}