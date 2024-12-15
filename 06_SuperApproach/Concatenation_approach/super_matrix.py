import argparse
import os
import re
from collections import defaultdict


def create_super_matrix(input_dir, output_file):
    """
    Crée une super matrice en combinant les séquences de mêmes noms provenant de plusieurs fichiers FASTA.
    Toutes les séquences sont supposées présentes dans chaque fichier.

    Args:
        input_dir (str): Chemin du dossier contenant les fichiers FASTA.
        output_file (str): Chemin du fichier de sortie contenant la super matrice.
    """
    sequences = defaultdict(list)  # Stocke les séquences par nom dans l'ordre des fichiers
    fasta_files = [os.path.join(input_dir, f) for f in os.listdir(input_dir) if f.endswith('.fa')]

    if not fasta_files:
        print("Aucun fichier FASTA trouvé dans le dossier spécifié.")
        return

    # Lire chaque fichier FASTA
    for fasta_file in fasta_files:
        with open(fasta_file, 'r') as infile:
            current_name = None
            for line in infile:
                if line.startswith('>'):
                    # Extraire le nom de genre et d'espèce
                    match = re.match(r">([a-zA-Z]+_[a-zA-Z]+)", line)
                    if match:
                        current_name = match.group(1)
                        if current_name not in sequences:
                            sequences[current_name] = []
                elif current_name:
                    # Ajouter la séquence à la liste pour ce nom
                    sequences[current_name].append(line.strip())

    # Créer la super matrice
    with open(output_file, 'w') as outfile:
        for name in sorted(sequences.keys()):
            # Concaténer toutes les séquences pour ce nom
            concatenated_sequence = ''.join(sequences[name])
            outfile.write(f">{name}\n{concatenated_sequence}\n")


def main():
    # Configurer les arguments de ligne de commande
    parser = argparse.ArgumentParser(description="Créer une super matrice à partir de fichiers FASTA.")
    parser.add_argument(
        "-i", "--input_dir", required=True, help="Dossier contenant les fichiers FASTA."
    )
    parser.add_argument(
        "-o", "--output_file", required=True, help="Fichier de sortie pour la super matrice."
    )

    args = parser.parse_args()

    # Appeler la fonction pour créer la super matrice
    create_super_matrix(args.input_dir, args.output_file)

if __name__ == "__main__":
    main()