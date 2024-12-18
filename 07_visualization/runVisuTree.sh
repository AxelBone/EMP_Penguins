#!/bin/bash

#####################################################################################

# Executeur pour générer un visuel d'arbres d'espèce

#####################################################################################

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59986/EMP_env || {
	echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
	exit 1
}

# Executeur
python3 visu_arbre.py