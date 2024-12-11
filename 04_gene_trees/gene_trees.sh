#!/bin/bash
#SBATCH --job-name=gene_trees  # Name of the job
#SBATCH --output=gene_trees.log  # Log file
#SBATCH --cpus-per-task=20  # Number of CPUs per task
#SBATCH --mem=50G


. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

INDIR="/scratch-new/tp59985/EMP_scratch_complet/Results_Dec05/Single_Copy_Orthologue_Sequences"
OUTDIR="/scratch-new/tp59985/gene_tree_result"
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
    ID=$(basename $file .fa)

    # Exécute MAFFT et place le résultat dans le répertoire de sortie
    mafft --thread $THREADS --auto --anysymbol $file > "$OUTDIR/$ID""_mafft.fa"

    # Exécute IQ-TREE et place les résultats dans le répertoire de sortie
    iqtree -T $THREADS -s "$OUTDIR/$ID""_mafft.fa" -m $MODEL -pre "$OUTDIR/$ID"
done

# possible options:
# -m TESTONLY
# -m TEST
# -quiet
# ... 2> /dev/null

