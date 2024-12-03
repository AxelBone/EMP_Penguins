#!/bin/bash

# Définir les répertoires source et destination
SOURCE_DIR="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data"
DEST_DIR="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data/dezip"

# Vérifier si le répertoire de destination existe, sinon le créer
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

# Parcourir tous les fichiers .gbff.gz dans le répertoire source
for file in "$SOURCE_DIR"/*.gbff.gz; do
    if [ -f "$file" ]; then
        # Décompresser chaque fichier dans le répertoire de destination
        gunzip -c "$file" > "$DEST_DIR/$(basename "${file%.gz}")"
        echo "Décompressé : $file -> $DEST_DIR/$(basename "${file%.gz}")"
    fi
done

echo "Tous les fichiers ont été décompressés."
