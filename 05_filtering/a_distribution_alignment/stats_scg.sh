#!/bin/bash

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 chemin_vers_fichier.fasta"
    exit 1
fi


FASTA_FILE=$1

if [ ! -f "$FASTA_FILE" ]; then
    echo "Erreur : le fichier $FASTA_FILE n'existe pas."
    exit 1
fi


python3 scripts_exec/fasta_len.py "$FASTA_FILE"

