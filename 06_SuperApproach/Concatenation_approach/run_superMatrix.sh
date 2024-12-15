#!/bin/bash

# Activer Conda

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

SUPMATRIXSCRIPT="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/scripts_exec/06_SuperApproach/Concatenation_approach/super_matrix.py"
INPUT_DIR=$1
OUTPUT_FILE=$2


python3 "$SUPMATRIXSCRIPT" -i "$INPUT_DIR" -o "$OUTPUT_FILE"

echo "Traitement terminé : super matrice réalisée."
