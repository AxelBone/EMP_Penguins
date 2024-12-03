#!/bin/bash

# Activer l'environnement conda
conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Définir le répertoire de travail
WD="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/"
cd "$WD" || {
    echo "Erreur: Impossible d'accéder au répertoire de travail $WD."
    exit 1
}

# Créer le répertoire de sortie si nécessaire
mkdir -p data/raw_data/extraction || {
    echo "Erreur: Impossible de créer le répertoire data/raw_data/extraction."
    exit 1
}

# Exécuter le script Python pour l'extraction des CDS
python scripts_exec/extract_cds.py data/raw_data/RhinTyp.gbff data/raw_data/extraction/ || {
    echo "Erreur: Le script extract_cds.py a échoué."
    exit 1
}

echo "Extraction des CDS terminée avec succès."
