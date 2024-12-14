#!/bin/bash

# Activer Conda
source /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur : Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Vérifier que le bon nombre d'arguments est passé
if [ "$#" -lt 1 ]; then
    echo "Usage : $0 chemin/vers/dossierFiltration"
    exit 1
fi

# Valeurs de filtration
MAX_EVO_DIST=39.638706946780005
MIN_ALIGN=199.0
MAX_ALIGN=1806.0400000000004

# Variables pour les scripts Python
INPUT_DIR=$1
SCRIPT_PYTHON_ALIGN="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/scripts_exec/05_filtering/a_distribution_alignment/fasta_len.py"
SCRIPT_PYTHON_EVODIST="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/scripts_exec/05_filtering/b_distribution_fulldist/total_dist.py"

# Fichier de sortie
output_file="FilesChecked.txt"
> "$output_file"  # Effacer le fichier s'il existe déjà

# Récupération des noms de base sans extension
base_names=$(find "$INPUT_DIR" -type f -exec basename {} \; | grep -Eo 'N0\.[A-Z0-9]+_renamed' | sort -u)

# Boucle sur chaque nom de base
for base_name in $base_names; do
    treefileValidation=false
    mafftValidation=false

    # Vérification du fichier treefile
    treefile="$INPUT_DIR/$base_name.treefile" # Input dir doti être sans / à la fin
    
    if [ -f "$treefile" ]; then
        echo "Calcul de la distance évolutive sur le fichier $treefile."
        full_dist=$(python3 "$SCRIPT_PYTHON_EVODIST" "$treefile")

        if (( $(echo "$full_dist < $MAX_EVO_DIST" | bc -l) )); then
            echo "Distance ($full_dist) inférieure à la limite ($MAX_EVO_DIST)."
            treefileValidation=true
        else
            echo "Distance ($full_dist) supérieure à la limite ($MAX_EVO_DIST). Fichier ignoré."
        fi
    else
        echo "Fichier treefile manquant pour $base_name."
    fi

    # Vérification du fichier mafft
    mafft_file="$INPUT_DIR/${base_name}_mafft.fa"
    if [ -f "$mafft_file" ]; then
        echo "Calcul de la taille de l'alignement sur le fichier $mafft_file."
        align_size=$(python3 "$SCRIPT_PYTHON_ALIGN" "$mafft_file")

        if (( $(echo "$MIN_ALIGN < $align_size" | bc -l) && $(echo "$align_size < $MAX_ALIGN" | bc -l) )); then
            echo "Taille de l'alignement ($align_size) comprise entre $MIN_ALIGN et $MAX_ALIGN."
            mafftValidation=true
        else
            echo "Taille de l'alignement ($align_size) hors limites. Fichier ignoré."
        fi
    else
        echo "Fichier mafft manquant pour $base_name."
    fi

    # Enregistrement si les deux validations sont réussies
    if [[ $treefileValidation == true && $mafftValidation == true ]]; then
        echo "$base_name" >> "$output_file"
    fi
done

echo "Tous les individus valides ont été enregistrés dans : $output_file"
