#!/bin/bash

# Activer Conda

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Vérifier que le bon nombre d'arguments est passé
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 script_python chemin/vers/fichier"
    exit 1
fi

# Variables pour le script
SCRIPT_PYTHON=$1
INPUT_DIR=$2
output_file="mean_lengthsFullDist.txt"
> "$output_file"  # Effacer le fichier s'il existe déjà

# Boucle sur chaque fichier dans le répertoire correspondant
for newick_file in "$INPUT_DIR"*.treefile; do ### VOIR EXTENSION
    if [ -f "$newick_file" ]; then
        echo "Processing $newick_file..."
        full_dist=$(python3 "$SCRIPT_PYTHON" "$newick_file")
        echo "$full_dist" >> "$output_file"
    else
        echo "Le fichier $newick_file n'existe pas ou est inaccessible."
    fi
done

echo "Toutes les valeurs moyennes ont été sauvegardées dans : $output_file"


echo "Calcul distrib"

python3 /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/scripts_exec/05_filtering/b_distribution_fulldist/plot_distribution.py "$output_file"
