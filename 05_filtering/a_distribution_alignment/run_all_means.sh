#!/bin/bash

#####################################################################################

# Execute le calcul de la distribution des longueurs d'alignements 
# Lance une représentation sous la forme d'un histogramme

#####################################################################################

# Activer Conda
. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Vérifier que le bon nombre d'arguments est passé
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 fasta_len.py chemin/vers/fichier"
    exit 1
fi

# Variables pour le script
SCRIPT_PYTHON=$1
INPUT_DIR=$2
output_file="mean_lengthsAlignment.txt"
> "$output_file"  # Effacer le fichier s'il existe déjà

# Boucle sur chaque fichier dans le répertoire correspondant
for fasta_file in "$INPUT_DIR"*_mafft.fa; do
    if [ -f "$fasta_file" ]; then
        echo "Processing $fasta_file..."
        mean_length=$(python3 "$SCRIPT_PYTHON" "$fasta_file") # Stocke la longueur de l'alignement calculée par le script "fasta_len.py".
        echo "$mean_length" >> "$output_file" # stocke toutes les longueurs d'alignement dans un fichier
    else
        echo "Le fichier $fasta_file n'existe pas ou est inaccessible."
    fi
done

echo "Toutes les valeurs moyennes ont été sauvegardées dans : $output_file"


echo "Calcul distrib"

python3 /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/scripts_exec/05_filtering/a_distribution_alignment/plot_distribution.py "$output_file" # Lance la représentation de la distribution sur l'ensemble des données calculées
