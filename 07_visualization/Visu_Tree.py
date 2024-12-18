#####################################################################################

# Génère la représentation d'un arbre d'espèce au format newick

#####################################################################################

import os
from ete3 import Tree

# Définir une variable d'environnement pour désactiver l'interface graphique (nécessaire pour les systèmes sans GUI)
os.environ["QT_QPA_PLATFORM"] = "offscreen"

# Chemins des fichiers
output_rooted_tree = "/scratch/tp59986/arbre_rooted_phoca_10b.tree"  # Fichier de sortie pour l'arbre enraciné
output_image = "/scratch/tp59986/arbre_rooted_phoca_10b.png"  # Fichier de sortie pour l'image de l'arbre

# Charger l'arbre à partir du fichier Newick
tree = Tree("/scratch/tp59986/superMatrix_cleaned.fa.treefile")

# Essayer d'enraciner l'arbre en utilisant "phoca_vitulina" comme taxon
try:
    tree.set_outgroup("phoca_vitulina")  # Spécifier le taxon à utiliser comme racine
except:
    # Si le taxon spécifié n'est pas trouvé dans l'arbre, afficher un message d'erreur
    print("Le taxon n'existe pas dans l'arbre.")

# Sauvegarder l'arbre enraciné dans un fichier
tree.write(outfile=output_rooted_tree)

# Générer une image de l'arbre enraciné et la sauvegarder
tree.render(output_image, w=800, h=600)  # Dimensions de l'image : largeur = 800 px, hauteur = 600 px

# Afficher un message de confirmation avec les chemins des fichiers générés
print(f"L'arbre enraciné a été sauvegardé dans {output_rooted_tree} et {output_image}")


