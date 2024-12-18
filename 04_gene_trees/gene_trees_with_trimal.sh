#!/bin/bash
#SBATCH --job-name=gene_trees_test  # Name of the job
#SBATCH --output=gene_trees_test.log  # Log file
#SBATCH --cpus-per-task=20  # Number of CPUs per task
#SBATCH --mem=30G

#####################################################################################

# Inférence des arbres de gènes après alignements et nettoyage de cet alignement.

#####################################################################################

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Répertoire contenant les fichiers d'entrée
#INDIR="/scratch-new/tp59985/EMP_scratch_complet/Results_Dec05/Single_Copy_Orthologue_Sequences/"

INDIR="/scratch-new/tp59985/ortho_scg_output_test/"

# Nombre de threads à utiliser
THREADS=20

OUTDIR="/scratch-new/tp59985/gene_tree_with_trimal_test/"

# Modèle pour IQ-TREE
MODEL="TEST"

# Vérifier si le répertoire d'entrée existe :
if [ ! -d "$INDIR" ]; then
    echo "Error: Input directory $INDIR does not exist." >&2
    exit 1
fi


# Crée le répertoire de sortie si nécessaire
mkdir -p "$OUTDIR"


# Boucle sur les fichiers dans le répertoire d'entrée
ls $INDIR | sort -R | while read file; do
    # Extraire l'ID du fichier (sans extension)
    ID=`basename $file .fa`
    
    # Étape 1 : Alignement avec MAFFT
    echo "Alignement de $file avec MAFFT..."
    mafft --thread $THREADS --auto --anysymbol "$INDIR/$file" > "$OUTDIR/$ID""_mafft.fa"
    
    # Étape 2 : Nettoyage de l'alignement avec trimAl
    echo "Nettoyage de l'alignement avec trimAl pour $ID..."
    trimal -in "$OUTDIR/$ID""_mafft.fa" -out "$OUTDIR/$ID""_trimmed.fa" -gappyout
    
    # Étape 3 : Reconstruction phylogénétique avec IQ-TREE
    echo "Analyse phylogénétique avec IQ-TREE pour $ID..."
    iqtree -T $THREADS -s "$OUTDIR/$ID""_trimmed.fa" -m $MODEL -pre $OUTDIR/$ID
    
    echo "Traitement terminé pour $ID."
done

