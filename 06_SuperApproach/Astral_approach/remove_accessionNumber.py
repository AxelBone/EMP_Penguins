import re
import argparse

# Fonction pour nettoyer les feuilles
def clean_leaf(leaf):
    return re.sub(r'_\w+\.\d+', '', leaf)

# Fonction pour parcourir et nettoyer l'arbre
def clean_tree(tree_str):
    # Utiliser une expression régulière pour trouver toutes les feuilles
    pattern = re.compile(r'([a-z_]+_[a-z_]+)_\w+\.\d+')
    return pattern.sub(lambda m: clean_leaf(m.group(1)), tree_str)

# Exemple d'utilisation
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Suppression des numéros d'accession dans les fichiers Newick.")
    parser.add_argument("-i", "--input", required=True, help="Fichier d'entrée au format Newick.")

    args = parser.parse_args()

    # Lire le contenu du fichier d'entrée
    with open(args.input, 'r') as file:
        tree_data = file.read()

    # Nettoyer les feuilles de l'arbre
    cleaned_data = clean_tree(tree_data)

    # Afficher le résultat
    print(cleaned_data)
