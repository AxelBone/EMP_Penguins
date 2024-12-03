#!/bin/bash

# Vérification des arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_fasta_file> <output_fasta_file> <number_of_sequences>"
    exit 1
fi

# Paramètres
input_file="$1"
output_file="$2"
subset_size="$3"

# Étape 1 : Reformater, mélanger, et extraire un sous-ensemble
cat "$input_file" | awk '/^>/ {printf("\n%s\n",$0); next;} {printf("%s",$0);} END {printf("\n");}' | tail -n +2 \
    | paste - - | sort -R | head -n "$subset_size" | tr "\t" "\n" > "$output_file"

# Message de confirmation
echo "Extraction aléatoire terminée : $subset_size séquences enregistrées dans $output_file"
