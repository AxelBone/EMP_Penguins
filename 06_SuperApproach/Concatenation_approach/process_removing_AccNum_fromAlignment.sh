#!/bin/bash

# Chemins vers les dossiers
INPUT_DIR=$1  # Dossier contenant les fichiers d'entrée
OUTPUT_DIR=$2 # Dossier pour enregistrer les fichiers modifiés
PYTHON_SCRIPT=$3 # Chemin vers le script Python

# Vérifier que les arguments sont fournis
if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ] || [ -z "$PYTHON_SCRIPT" ]; then
  echo "Usage: $0 <input_dir> <output_dir> <python_script>"
  exit 1
fi

# Créer le dossier de sortie s'il n'existe pas
mkdir -p "$OUTPUT_DIR"

# # Liste des noms d'espèces (à adapter selon vos besoins)
# SPECIES_LIST=\"balearica_regulorum,charadrius_vociferus,chauna_torquata,eublepharis_macularius,eurypyga_helias,gavia_stellata,opisthocomus_hoazin,pelecanus_crispus,phaethon_lepturus,phoca_vitulina,pygoscelis_adeliae,thalassarche_chlororhynchos\"

# Parcourir tous les fichiers dans le dossier d'entrée
for FILE in "$INPUT_DIR"/*_mafft.fa; do
  if [ -f "$FILE" ]; then
    FILE_NAME=$(basename "$FILE")
    OUTPUT_FILE="$OUTPUT_DIR/$FILE_NAME"

    # Exécuter le script Python sur chaque fichier
    python3 "$PYTHON_SCRIPT" -i "$FILE" > "$OUTPUT_FILE"
  fi
done

echo "Traitement terminé. Les fichiers modifiés sont dans $OUTPUT_DIR."
