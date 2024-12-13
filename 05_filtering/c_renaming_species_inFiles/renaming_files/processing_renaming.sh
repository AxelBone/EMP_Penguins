#!/bin/bash

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Vérifie que le nombre d'arguments est correct
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <dossier_entree> <dossier_sortie> <fichier_dictionnaire>"
    exit 1
fi

# Récupérer les arguments
DOSSIER_ENTREE="$1"
DOSSIER_SORTIE="$2"
FICHIER_DICTIONNAIRE="$3"

# Vérifie si le dossier d'entrée existe
if [ ! -d "$DOSSIER_ENTREE" ]; then
    echo "Erreur : le dossier d'entrée n'existe pas."
    exit 1
fi

# Crée le dossier de sortie s'il n'existe pas
mkdir -p "$DOSSIER_SORTIE"

# Parcourt tous les fichiers pertinents dans le dossier d'entrée
for fichier in "$DOSSIER_ENTREE"/*; do
    if [[ "$fichier" == *.treefile ]]; then
        # Fichier Newick
        nom_base=$(basename "$fichier")
        fichier_sortie="$DOSSIER_SORTIE/${nom_base%.treefile}_renamed.treefile"
        python3 script.py -i "$fichier" -o "$fichier_sortie" -d "$FICHIER_DICTIONNAIRE" -f newick
    elif [[ "$fichier" == *_mafft.fa ]]; then
        # Fichier FASTA
        nom_base=$(basename "$fichier")
        fichier_sortie="$DOSSIER_SORTIE/${nom_base%_mafft.fa}_renamed_mafft.fa"
        python3 script.py -i "$fichier" -o "$fichier_sortie" -d "$FICHIER_DICTIONNAIRE" -f fasta
    fi
done

echo "Traitement terminé. Les fichiers renommés se trouvent dans $DOSSIER_SORTIE."