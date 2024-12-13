# EMP_Manchots
Analyse phylogénétique d'espèces d'oiseaux pour découvrir quadn les manchots on perdu la capacité à voler.

Ce dossier ne contient que les scripts pour l'analyse phylogénétique.

Les étapes : 

0) Setup conda env
1) Télécharger les génomes (format : gbff)
2) Unzip
3) Orthofinder
4) Création des arbres de gènes
5) Filtration
6) Supermatrice ou super-arbres



# Etape 3 : Orthofinder

Les résultats d'Orthofinder dévoilent 1327 fichiers contenant des "Séquences orthologues simples copies". C'est sur ces données que nous travaillons par la suite. 


# Etape 4 : Création des arbres de gènes
Les arbres de gènes sont dans un premier temps créé seulement avec mafft puis iqtree dans un premier temps. Si l'on fait ça, nous avons 519 alignements vides sur 1327 soit environ 39 % des alignements qui sont inexistants. Pourquoi ces alignements ne fonctionnent ils pas ? 


# Etape 5 : Filtration
Le calcul de l'alignement est impossible pour 519 alignements vides. 