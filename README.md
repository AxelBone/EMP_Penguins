# EMP_Penguins

Analyse phylogénétique des oiseaux : Découverte des origines de la perte de vol chez les manchots

Ce projet se concentre sur l'étude phylogénétique des oiseaux afin d'élucider les événements évolutifs ayant conduit à la perte de la capacité de voler chez les manchots, un groupe d’oiseaux aquatiques appartenant à l’ordre des Sphenisciformes. Contrairement aux manchots, les oiseaux volants représentent une vaste diversité d’espèces ayant conservé cette aptitude emblématique.

L’objectif principal de cette analyse est d’identifier le groupe frère le plus proche des manchots parmi les oiseaux volants. Pour ce faire, des données protéomiques issues de plusieurs espèces d’oiseaux volants proches des Sphenisciformes ont été étudiées, permettant de retracer les relations phylogénétiques entre ces groupes et d’explorer les mécanismes évolutifs à l’origine de cette divergence majeure.

Note : Ce dossier contient exclusivement les scripts nécessaires pour l'analyse phylogénétique.

Les grandes étapes : 

0) Setup conda env
1) Télécharger les génomes (format : gbff)
2) Unzip
3) Orthofinder
4) Création des arbres de gènes (+ alignements multiples)
5) Filtration
6) Superm-Matrice et/ou Super-Arbres


# Ordre des scripts

Voici une version améliorée et mieux structurée de votre texte :  

---

## Ordre des scripts  

### 1. Préparation de l’environnement  
**`00_conda/setup_conda.sh`** : Script à compléter pour préparer l’environnement avec Conda.  

### 2. Téléchargement des espèces  
**`01_download_sp/01_download_species.sh`** : Télécharge les données des espèces sélectionnées.  

### 3. Décompression des fichiers  
**`02_unzip/unzip.sh`** : Décompresse les fichiers téléchargés.  

### 4. Analyse avec Orthofinder  
**`03_orthofinder/orthofinder.sh`** : Exécute Orthofinder pour identifier les séquences orthologues.  

### 5. Construction des arbres de gènes  
**`04_gene_trees/gene_trees_with_trimal.sh`** : Crée les arbres de gènes après alignement avec MAFFT et nettoyage des alignements avec Trimal.   

### 6. Calcul des statistiques  
- **`05_filtering/a_distribution_alignment/run_all_means.sh`** : Calcule les statistiques sur les longueurs des alignements.  
- **`05_filtering/b_distribution_fulldist/run_all_fulldist.sh`** : Calcule les distances évolutives.  
- Observation des distributions pour définir des seuils de filtration.  

### 7. Renommage des fichiers pour standardiser les noms  
- **`05_filtering/c_renaming_species_inFiles/proteomes_pb/process_proteomes_renaming.sh`** : Crée un dictionnaire associant les numéros d’accession aux noms des espèces (genre et espèce).  
- **`05_filtering/c_renaming_species_inFiles/renaming_files/processing_renaming.sh`** : Utilise ce dictionnaire pour renommer les fichiers en ajoutant le genre et l’espèce au début de chaque nom. 

### 8. Filtration des fichiers  
- **`05_filtering/d_keepingOrNot/keepingRejectingStep.sh`** : Génère une liste des fichiers qui passent les filtres définis.  
- **`05_filtering/d_keepingOrNot/copying_files.sh`** : Copie les fichiers validés dans un dossier dédié.  

### 9. Approche supermatrice  
**`06_SuperApproach/Concatenation_approach/process_removing_AccNum_fromAlignment.sh`** : Scripts pour retirer dans les numéros d'accession des noms des séquences pour conserver surement les noms de genre et d'espèce.
**`06_SuperApproach/Concatenation_approach/run_superMatrix.sh`** : Scripts pour concaténer les séquences protéiques alignées des différentes protéines orthologues d'une même espèce.
**`06_SuperApproach/Concatenation_approach/inference_superMatrice.sh`** : Script pour l'inférence phylogénétique de l'arbre d'espèce à partir de la super matrice.

### 10. Visualisation
**`07_visualization/runVisuTree.sh`** : Script pour créer une visualisation de l'arbre d'espèce généré par Astral.


