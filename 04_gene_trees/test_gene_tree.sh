#!/bin/bash


. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

INDIR="/scratch/tp59985/gene_tree_test"
OUTDIR="/scratch/tp59985/output_gene_tree"
MODEL="TEST"
THREADS=20



# Vérifier si le répertoire d'entrée existe :
if [ ! -d "$INDIR" ]; then
    echo "Error: Input directory $INDIR does not exist." >&2
    exit 1
fi

# Crée le répertoire de sortie si nécessaire
mkdir -p "$OUTDIR"


find "$INDIR" -type f -name "*.fa" | sort -R | while read file; do
    ID=$(basename $file .fasta)

    echo $ID
    echo $file

    # Exécute MAFFT et place le résultat dans le répertoire de sortie
    # mafft --thread $THREADS --auto --anysymbol $file > "$OUTDIR/$ID""_mafft.fa"

done
