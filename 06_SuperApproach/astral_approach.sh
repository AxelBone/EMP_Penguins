# 1) install astral
# conda install -c bioconda astral-tree

# 2) use "Exemple_5" script to build gene trees from the "Exemple 7a" clusters (ortho_strict)

# 3) run astral on the gene trees
file_with_all_gene_trees=/scratch-new/tp59985/06_SuperApproach/Astral/full_trees_orthologuous
output_tree_name=/scratch-new/tp59985/06_SuperApproach/Astral/astral_output_bigTree
output_log_name=/scratch-new/tp59985/06_SuperApproach/Astral/Log_astralTree

cat /scratch-new/tp59985/renamed_gene_with_trimal/*.treefile > $file_with_all_gene_trees
astral -i $file_with_all_gene_trees -o $output_tree_name 2> $output_log_name