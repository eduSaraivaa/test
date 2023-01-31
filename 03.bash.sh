#!/bin/bash
find /path_to_be_cleaned/* -mindepth 1 -mtime +182 -delete

#-mtime +182 >> período de 6 meses
#-mindepth 1 >> valida o directorio atual




#é possível adicionar na crontab
#descomentar a linha abaixo
#contrab -e
#executar a linha abaixo
#@daily find /path_to_be_cleaned/* -mindepth 1 -mtime +182 -exec rm {} \;
