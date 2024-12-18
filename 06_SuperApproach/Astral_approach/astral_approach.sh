#####################################################################################

# Inférence phylogénétique de l'arbre d'espèce à partir des arbres de gènes

#####################################################################################


# Run astral on the gene trees
file_with_all_gene_trees=file_with_all_gene_trees
output_tree_name=astral_output_bigTree
output_log_name=Log_astralTree

cat without_num/*.treefile > $file_with_all_gene_trees # Créer un seul fichier avec tous les arbres de gènes
astral -i $file_with_all_gene_trees -o $output_tree_name 2> $output_log_name # Lance l'inférence