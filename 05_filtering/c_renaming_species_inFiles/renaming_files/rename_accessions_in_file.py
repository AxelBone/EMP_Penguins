#####################################################################################

# Renomme les noms des séquences d'un fichier fasta (d'alignement ou pas) ou d'un fichier filetree
# Sauvegarde le fichier renommé dans un autre fichier de sortie

#####################################################################################

import argparse
from Bio import Phylo
from io import StringIO

def rename_accessions_in_tree(input_file, output_file, accession_to_species):
    """
    Renomme les numéros d'accession dans un arbre phylogénétique Newick en les associant à leur espèce.

    Paramètres :
        input_file (str) : Le chemin du fichier Newick d'entrée.
        output_file (str) : Le chemin du fichier Newick de sortie avec les noms mis à jour.
        accession_to_species (dict) : Un dictionnaire associant les numéros d'accession aux noms d'espèces.

    Retourne :
        None : Le fichier Newick modifié est sauvegardé dans le fichier de sortie.
    """
    # Lire le fichier Newick
    with open(input_file, 'r') as f:
        newick_data = f.read()
    
    # Parse le fichier avec Biopython
    tree = Phylo.read(StringIO(newick_data), "newick")
    
    # Fonction interne pour renommer les taxons dans l'arbre
    def rename_clade(clade):
        """
        Renomme un clade en utilisant le dictionnaire accession_to_species.

        Paramètre :
            clade : Un objet Clade de Biopython représentant un noeud ou une feuille de l'arbre.
        """
        if clade.name in accession_to_species:
            species_name = accession_to_species[clade.name]  # Nom d'espèce sans espace
            clade.name = f"{species_name}_{clade.name}"  # Format "nom_espèce_num_accession"
    
    for clade in tree.find_clades():
        rename_clade(clade)
    
    # Sauvegarde du fichier avec les noms mis à jour
    with open(output_file, 'w') as f:
        Phylo.write(tree, f, "newick")

def rename_accessions_in_alignment(input_file, output_file, accession_to_species):
    """
    Renomme les numéros d'accession dans un fichier FASTA avec les noms d'espèces.

    :param input_file: Chemin vers le fichier d'alignement FASTA d'entrée.
    :param output_file: Chemin vers le fichier d'alignement FASTA de sortie.
    :param accession_to_species: Dictionnaire {numéro accession: nom espèce}.
    """
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        accession = None
        for line in infile:
            if line.startswith('>'):
                accession = line[1:].strip().split()[0]  # Extraire le numéro d'accession
                if accession in accession_to_species:
                    species_name = accession_to_species[accession].replace(' ', '')
                    new_header = f">{species_name}_{accession}\n"
                    outfile.write(new_header)
                else:
                    outfile.write(line)  # Garder la ligne inchangée si non trouvé
            else:
                outfile.write(line)  # Séquences non modifiées

def main():
    parser = argparse.ArgumentParser(description="Renomme les numéros d'accession par les noms d'espèces dans un fichier Newick ou un fichier d'alignement FASTA.")
    parser.add_argument("-i", "--input", required=True, help="Fichier d'entrée au format Newick ou FASTA.")
    parser.add_argument("-o", "--output", required=True, help="Fichier de sortie avec les noms d'espèces renommés.")
    parser.add_argument("-d", "--dict", required=True, help="Fichier dictionnaire (numéro accession -> nom espèce) au format CSV (séparateur: :).")
    parser.add_argument("-f", "--format", required=True, choices=["newick", "fasta"], help="Format du fichier d'entrée : 'newick' pour arbre phylogénétique, 'fasta' pour alignement.")

    args = parser.parse_args()

    # Charger le dictionnaire et formater les noms d'espèce
    accession_to_species = {}
    with open(args.dict, 'r') as f:
        for line in f:
            try:
                accession, species = line.strip().split(':')
                accession_to_species[accession] = species.replace(' ', '')  # Remplacement des espaces par '_'
            except ValueError:
                print(f"Erreur dans la ligne : {line.strip()}. Veuillez vérifier le format.")

    # Renommer les accès selon le format
    if args.format == "newick":
        rename_accessions_in_tree(args.input, args.output, accession_to_species)
    elif args.format == "fasta":
        rename_accessions_in_alignment(args.input, args.output, accession_to_species)

if __name__ == "__main__":
    main()
