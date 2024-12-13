#!/bin/bash

# Vérifier si le script Python est spécifié
if [ $# -ne 2 ]; then
    echo "Usage: $0 <path_to_accession_to_species_script> <path_to_input_dir>"
    exit 1
fi

ACCESSION_SCRIPT=$1
INPUT_DIR=$2
INPUT_SPECIES="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/scripts_exec/05_filtering/c_renaming_species_inFiles/dict_access_species/species_names.csv"

# Vérifier si le script Python existe
if [ ! -f "$ACCESSION_SCRIPT" ]; then
    echo "Erreur : le script $ACCESSION_SCRIPT n'existe pas."
    exit 1
fi

# Créer ou vider le fichier de sortie
OUTPUT_FILE="accession_numberAndSpecies.txt"
> "$OUTPUT_FILE"

# Lire les noms d'espèces depuis le fichier CSV
species_names=($(cat "$INPUT_SPECIES"))

# Parcourir tous les fichiers .faa dans le dossier courant
for FILE in "$INPUT_DIR"/*.faa; do
    for species_name in "${species_names[@]}"; do
        if [ -f "$FILE" ]; then
            echo "Traitement du fichier : $FILE"
            echo "Nom concerné : $species_name"

            python3 "$ACCESSION_SCRIPT" -f "$FILE" -n "$species_name" >> "$OUTPUT_FILE"
            echo "Résultat ajouté à $OUTPUT_FILE"
        else
            echo "Aucun fichier .faa trouvé dans le dossier."
        fi
    done
done

echo "Traitement terminé. Résultats dans $OUTPUT_FILE."