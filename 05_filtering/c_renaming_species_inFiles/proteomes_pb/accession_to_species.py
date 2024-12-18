#####################################################################################

# Attribue pour chaque numéro d'accession d'un protéome le nom de genre et l'espèce

#####################################################################################

import re
import argparse

# Fonction pour extraire les numéros d'accession depuis un fichier FASTA
def extract_accession_numbers(file_path):
    """
    Extrait les numéros d'accession des en-têtes d'un fichier FASTA.

    Paramètre :
        file_path (str) : Le chemin du fichier FASTA.

    Retourne :
        list : Une liste de numéros d'accession extraits des lignes d'en-tête.
    """

    accession_numbers = []

    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith('>'):  # Ligne d'en-tête FASTA
                match = re.match(r'>\s*([\w\.]+)', line) # Regex pour détecter numéro d'accession
                if match:
                    # Ajouter le numéro d'accession extrait à la liste
                    accession_numbers.append(match.group(1))

    # Retourner la liste des numéros d'accession
    return accession_numbers

# Fonction pour créer un dictionnaire accession -> espèce
def create_accession_species_dict(file_path, species_name):
    """
    Crée un dictionnaire associant chaque numéro d'accession à un nom d'espèce standardisé.

    Paramètres :
        file_path (str) : Le chemin du fichier FASTA.
        species_name (str) : Le nom de l'espèce à associer aux numéros d'accession.

    Retourne :
        dict : Un dictionnaire où les clés sont les numéros d'accession et les valeurs sont le nom d'espèce.
    """
    # Transformer le nom de l'espèce en format standardisé
    species_name = species_name.lower().replace(' ', '_')
    accession_numbers = extract_accession_numbers(file_path)
    
    # Associer chaque numéro d'accession au nom d'espèce
    accession_species_dict = {acc: species_name for acc in accession_numbers}
    
    return accession_species_dict

# Fonction principale
def main():
    parser = argparse.ArgumentParser(description="Associer des numéros d'accession à un nom d'espèce.")
    parser.add_argument("-f", "--file", required=True, help="Fichier FASTA à traiter.")
    parser.add_argument("-n", "--name_species", required=True, help="Nom de l'espèce à associer.")
    
    args = parser.parse_args()
    
    # Créer le dictionnaire accession -> espèce
    accession_species_dict = create_accession_species_dict(args.file, args.name_species)
    
    # Afficher ou sauvegarder le dictionnaire
    for accession, species in accession_species_dict.items():
        print(f"{accession}: {species}")

if __name__ == "__main__":
    main()
