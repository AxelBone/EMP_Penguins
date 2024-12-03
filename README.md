# EMP_Sharks
Phylogenetic analyses of sharks species

Ce dossier ne contient que les scripts pour l'analyse phylogénétique.

Les étapes : 

1) Setup conda env
2) Télécharger les génomes (format : gbff)
3) unzip
4) extraction des traductions des régions codantes 
5) *subset* - étape optionnelle
6) orthofinder

...




Liste des scripts brics : 

- download_species.sh = Téléchargement des génomes assemblés au format gbff de différentes espèces de requins pour l'étude.
- extract_cds_translation.py = Script python pour extraire les traductions des cds dans les fichiers gbff. s'utilise en ligne de commande de cette façon, python extract_cds_translation.py <input_file.gbff> <output_path_filename>
- unzip_gbff.sh = Script bash pour unzip chaque fichier gbff.
- random_prot_extractionfasta.sh = Script bash qui permet de faire un tirage aléatoire d'un certain nombre de protéines dans un fichier fasta

Liste des scripts pour lancer le pipeline :

- main.sh = **Contiendra** le pipeline général qui lancera orthofinder et le reste des commandes
- from_download_to_subset.sh = pipeline à partir des données brutes au format .gbff.gz jusqu'à orthofinder. Ce pipeline va dézipper, extraire les régions cds traduites, faire un sous-échantillonnage à 10 % et lancer orthofinder.

