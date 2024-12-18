#!/bin/bash
#####################################################################################

# Inférence phylogénétique de l'arbre d'espèce à partir de la super matrice

#####################################################################################

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59986/EMP_env || {
	echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
	exit 1
}

# Déterminer le modèle a utiliser à partir d'une liste préselectionnée
iqtree -s superMatrix_cleaned.fa -m MFP -mset LG,WAG,JTT -nt AUTO -b 10

# Inférence phylogénétique avec 10 bootstraps et le modèle précédemment déterminé comme le plus adéquat à nos données
iqtree -s superMatrix_cleaned.fa -m JTT+F+I+R3 -nt AUTO -b 10
