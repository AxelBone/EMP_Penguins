#!/bin/bash

INPUT_DIR="/scratch-new/tp59985/gene_tree_result/"
OUTPUT_DIR="/scratch-new/tp59985/subset_gene_tree_result/"


mkdir -p $OUTPUT_DIR

# Extraire les numéros uniques
ls $INPUT_DIR | grep -oE 'N0\.HOG[0-9]+' | sort | uniq | shuf | head -n 20 | while read number; do
    # Copier tous les fichiers associés à ce numéro
    cp $INPUT_DIR/$number* $OUTPUT_DIR/
done
