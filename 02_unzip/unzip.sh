#!/bin/bash

#####################################################################################

# Dézip des génomes téléchargés, création d'un dossier de sortie dans lequel 

#####################################################################################

input="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data"

cd "$input" # Déplacement dans le dossier avec les .zip des espèces
for zipfile in *.zip; do 
    if [[ -f "$zipfile" ]]; then
        dirname="${zipfile%.zip}"
        mkdir -p "$dirname" # Création d'un dossier dans lequel on extrait les résultats.
        unzip "$zipfile" -d "$dirname"
	rm "$zipfile"
    fi
done
