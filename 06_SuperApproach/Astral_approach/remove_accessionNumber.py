#####################################################################################

# Retrait des numéros d'accession des noms des séquences pour un arbre de gène

#####################################################################################


import re
import argparse

# Fonction pour nettoyer les feuilles
def clean_leaf(leaf):
    """
    Supprime les numéros d'accession dans le nom d'une feuille.
    
    Paramètre :
        leaf (str) : Le nom de la feuille contenant un numéro d'accession.
    
    Retourne :
        str : Le nom de la feuille sans le numéro d'accession.
    """
    return re.sub(r'_\w+\.\d+', '', leaf)

# Fonction pour parcourir et nettoyer l'arbre
def clean_tree(tree_str):
    """
    Parcourt l'arbre Newick et nettoie les noms des feuilles en supprimant les numéros d'accession.

    Paramètre :
        tree_str (str) : Une chaîne contenant l'arbre au format Newick.
    
    Retourne :
        str : Une chaîne contenant l'arbre Newick avec des noms de feuilles nettoyés.
    """
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
