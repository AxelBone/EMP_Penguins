#!/bin/bash

#####################################################################################

# Copier les fichiers qui passent le filtre dans un autre dossier

#####################################################################################

# Le répertoire contenant les fichiers d'entrée
input_directory=$1

# Le fichier contenant la liste des noms de fichiers
list_file=$2

# Le dossier de destination
output_dir=$3

# Assurez-vous que le dossier de destination existe
mkdir -p "$output_dir"

# Copier chaque fichier avec son extension
while IFS= read -r line; do
    input_file_path="$input_directory/${line}.treefile"
    if [[ -f "$input_file_path" ]]; then
        cp "$input_file_path" "$output_dir"
    else
        echo "Fichier non trouvé : $input_file_path"
    fi
done < "$list_file"

echo "Copie terminée."
