#!/bin/bash

# Le fichier contenant les noms de fichiers
input_file="test.txt"
# Le dossier de destination
output_dir="chemin/vers/votre/dossier/"

# Assurez-vous que le dossier de destination existe
mkdir -p "$output_dir"

# Copier chaque fichier avec son extension
while IFS= read -r line; do
    input_file_path="${line}.treefile"
    if [[ -f "$input_file_path" ]]; then
        cp "$input_file_path" "$output_dir"
    else
        echo "Fichier non trouvé : $input_file_path"
    fi
done < "$input_file"

echo "Copie terminée."
