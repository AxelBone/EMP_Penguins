import re
import argparse

def rename_fasta_headers(input_file):
    """
    Renomme les en-têtes des séquences dans un fichier FASTA pour ne garder que
    le nom du genre et de l'espèce, en retirant les numéros d'accession.

    Args:
        input_file (str): Chemin du fichier d'entrée au format FASTA.
        output_file (str): Chemin du fichier de sortie avec les en-têtes modifiés.
    """

    modified_fasta = ""

    with open(input_file, 'r') as infile:
        for line in infile:
            if line.startswith('>'):
                # Extraire uniquement le genre et l'espèce
                match = re.match(r">([a-zA-Z]+_[a-zA-Z]+)", line)
                if match:
                    new_header = f">{match.group(1)}\n"
                    modified_fasta += new_header
                else:
                    # Si le format n'est pas attendu, réécrire tel quel
                    modified_fasta += line
            else:
                # Écrire les séquences sans modification
               modified_fasta += line

    return modified_fasta

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Suppression des numéros d'accession dans les fichiers d'alignement.")
    parser.add_argument("-i", "--input", required=True, help="Fichier d'entrée au format fasta.")

    args = parser.parse_args()
    
    modified_fasta = rename_fasta_headers(args.input)
    print(modified_fasta)