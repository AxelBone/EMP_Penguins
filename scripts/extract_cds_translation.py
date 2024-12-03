import argparse
from Bio import SeqIO

def extract_cds_translations(file_path):
    cds_entries = []

    # Lire le fichier GenBank
    for record in SeqIO.parse(file_path, "genbank"):
        for feature in record.features:
            # Vérifier si le type de feature est CDS
            if feature.type == "CDS":
                # Extraire la traduction
                if "translation" in feature.qualifiers:
                    translation = feature.qualifiers["translation"][0]
                    # Créer un identifiant unique pour chaque entrée
                    identifier = f"{record.id}_CDS_{len(cds_entries) + 1}"
                    cds_entries.append((identifier, translation))

    return cds_entries

def write_fasta(cds_entries, output_file):
    with open(output_file, 'w') as fasta_file:
        for identifier, translation in cds_entries:
            fasta_file.write(f">{identifier}\n") # Ecrire l'identifiant (simple ajout +1 pas de reprise du nom)
            # Ajouter un saut de ligne tous les 80 caractères
            for i in range(0, len(translation), 80):
                fasta_file.write(f"{translation[i:i+80]}\n")

def main():
    # Configuration de l'argument parser
    parser = argparse.ArgumentParser(description="Extraire les traductions CDS d'un fichier GenBank et les écrire dans un fichier FASTA.")
    parser.add_argument("input_file", help="Chemin vers le fichier GenBank d'entrée (GBFF).")
    parser.add_argument("output_file", help="Chemin vers le fichier FASTA de sortie.")

    # Analyse des arguments
    args = parser.parse_args()

    # Extraction des traductions CDS

    print(f"Extraction prot {args.input_file}")
    cds_translations = extract_cds_translations(args.input_file)
    
    # Écriture dans le fichier FASTA
    write_fasta(cds_translations, args.output_file)

    print(f"Les traductions CDS ont été écrites dans le fichier {args.output_file}.")

if __name__ == "__main__":
    main()