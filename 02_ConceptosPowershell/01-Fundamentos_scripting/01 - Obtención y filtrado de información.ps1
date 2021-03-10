#01 - Obtención y filtrado de información
# FILTRADO DE INFORMACIÓN

# PROCESOS EN EJECUCIÓN
get-process                                                            # obtener los procesos del sistema

get-process | select Id, VM, ProcessName                               # obtener el ID, uso de memoria virtual y el nombre de proceso de todos los procesos del sistema

get-process |                                                          # obtener los procesos del sistema
    select Id, @{n='Memoria virtual';e={$PSItem.VM/(1024*1024)}}, ProcessName      # obtener el ID, memoria virtual en MB's y el nombre de proceso

get-process |                                                          # obtener los procesos del sistema
    where-object {$_.VM -gt 1024*1024*60}                              # obtener los procesos que ocupen más de 60 MB's en memoria

# SERVICIOS EN EJECUCIÓN
get-service |                                                          # obtener los servicios del sistema
    where-object {$_.Status -eq "running" -and $_.Name -like 'w*'} |   # obtener servicios en ejecución y que comiencen por 'w' 
    Sort-Object Name |                                                 # ordenar los servicios por la propiedad 'Name'
    select -first 10                                                   # obtener los primeros 10 servicios