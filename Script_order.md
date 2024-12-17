L'ordre des scripts est le suivant 

# Préparation environnement
00_conda/setup_conda.sh (à compléter)

# Téléchargmenet espèces
01_download_sp/01_download_species.sh

# Dézippage
02_unzip/unzip.sh

# Orthofinder
03_orthofinder/orthofinder.sh

# Arbres de gènes
04_gene_trees/gene_trees_with_trimal.sh

# renommage des fichiers pour avoir genre_espèce_NumAccession
05_filtering/c_renaming_species_inFiles/proteomes_pb/process_proteomes_renaming.sh # Crée un dictionnaire des numéros d'accession et des espèces associés

05_filtering/c_renaming_species_inFiles/renaming_files/processing_renaming.sh # Utilise le dictionnaire pour renommer chaque numéro d'accession en ajoutnat le nom de genre et d'espèce au début.


# calcul des statistiques
05_filtering/a_distribution_alignment/run_all_means.sh # Calcul pour les longueurs d'alignemnt
05_filtering/b_distribution_fulldist/run_all_fulldist.sh # Calcul pour les distances évolutives

Observation des distributions et décision des seuils.

# Filtrations

05_filtering/d_keepingOrNot/keepingRejectingStep.sh # Crée un fichier dans lequel on a l'ensemble des fichiers qui valident les filtres demandés.

05_filtering/d_keepingOrNot/copying_files.sh # Permet de copier les fichiers qui passent les filtres dans un autre dossier.

# approche supermatrice
06_SuperApproach/....

