from Bio import Phylo
from itertools import combinations
from io import StringIO
import sys

def read_tree(input_file):
    """
    Lit un arbre phylogénétique à partir d'un fichier Newick ou d'une chaîne Newick.
    
    Args:
        input_file (str): Chemin vers le fichier contenant l'arbre en format Newick.

    Returns:
        tree: Objet de type Phylo.BaseTree.Tree représentant l'arbre.
    """
    with open(input_file, 'r') as file:
        newick = file.read().strip()
    tree = Phylo.read(StringIO(newick), "newick")
    return tree


def calculate_total_dist(tree):
    # Récupérer toutes les espèces
    species = [leaf.name for leaf in tree.get_terminals()]

    # Calculer les distances entre toutes les paires
    total_distance = 0
    for sp1, sp2 in combinations(species, 2):
        distance = tree.distance(sp1, sp2)
        total_distance += distance

    return total_distance


if __name__=="__main__":

    # Charger l'arbre Newick
    #newick = "(Chlamydomonas_reinhardtii:0.465348,((Selaginella_moellendorffii:0.277477,(Marchantia_polymorpha:0.298564,Physcomitrium_patens:0.29311)0.666229:0.0555791)0.636692:0.090712,(((((Cannabis_sativa:0.202265,Actinidia_chinensis:0.15654)0.379718:0.0280696,Arabidopsis_thaliana:0.21223)0.408599:0.0307308,Papaver_somniferum:0.220457)0.438792:0.030498,(Nymphaea_colorata:0.293737,Amborella_trichopoda:0.21255)0.458484:0.0322268)0.234329:0.0299599,(Ananas_comosus:0.204621,((Brachypodium_distachyon:0.0679647,(Hordeum_vulgare:0.0278043,(Triticum_aestivum:0.00130911,Aegilops_tauschii:4.44912e-06)0.527404:0.0181888)0.697407:0.0445933)0.612734:0.0346531,(Oryza_sativa:0.111293,(Eragrostis_tef:0.0916828,(Panicum_hallii:0.0484557,(Sorghum_bicolor:0.0318659,Zea_mays:0.0407459)0.823761:0.0296502)0.726288:0.0234932)0.722678:0.0287123)0.354775:0.0202053)0.715458:0.102002)0.519199:0.0541982)0.653758:0.0929885)1:0.465348);"
    
    if len(sys.argv) != 2:
        print("Usage: python script.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    # Charger l'arbre à partir du fichier
    try:
        tree = read_tree(input_file)
    except Exception as e:
        print(f"Erreur lors de la lecture de l'arbre : {e}")
        sys.exit(1)

    total_dist = calculate_total_dist(tree)
    print(total_dist)
