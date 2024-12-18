#!/bin/bash
#SBATCH --job-name=rename_proteins  # Name of the job
#SBATCH --output=rename_proteins.log  # Log file
#SBATCH --cpus-per-task=30  # Number of CPUs per task
#SBATCH --mem=50G

#####################################################################################

# Recherche des orthologues par OrthoFinder

#####################################################################################

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

DEST_DIR_ORTHO="/scratch/tp59985/EMP_scratch_complet/"
DEST_DIR_SUBSET="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data/proteomes"

# ETAPE 4 : Orthofinder

echo "Orthofinder avec les données subset ..."

threads=30
orthofinder -t $threads -M dendroblast -S diamond -1 -X -o $DEST_DIR_ORTHO -f $DEST_DIR_SUBSET || {
    echo "Erreur"
    exit 1
}


