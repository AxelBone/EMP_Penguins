#!/bin/bash
. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59986/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}
#conda install -c bioconda trimal
trimal -in superMatrix.fa -out superMatrix_cleaned.fa -nogaps
