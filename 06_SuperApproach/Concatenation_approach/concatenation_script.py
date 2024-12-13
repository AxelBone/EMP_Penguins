import os

# Dossier contenant les fichiers d'alignement
input_directory = "votre_dossier_alignements"
output_file = "supermatrice_concatenee.fasta"

# Liste pour stocker les fichiers d'alignement
alignment_files = [f for f in os.listdir(input_directory) if f.endswith('.fasta')]

# Fonction pour concaténer les séquences d'un fichier
def concatener_sequences(file_path):
    concatenated_sequence = ""
    current_species = ""
    
    with open(file_path, 'r') as infile:
        for line in infile:
            if line.startswith(">"):
                if current_species:
                    # Ajouter la séquence de l'espèce précédente à la supermatrice
                    concatenated_sequence += f">{current_species}\n{sequence}\n"
                current_species = line.strip().split()[0][1:]  # Nom de l'espèce sans le ">"
                sequence = ""
            else:
                sequence += line.strip()
        
        # Ajouter la dernière séquence
        concatenated_sequence += f">{current_species}\n{sequence}\n"
    
    return concatenated_sequence

# Ouvrir le fichier de sortie
with open(output_file, 'w') as outfile:
    for filename in alignment_files:
        full_file_path = os.path.join(input_directory, filename)
        concatenated_data = concatener_sequences(full_file_path)
        outfile.write(concatenated_data)

print(f"Supermatrice concaténée générée et enregistrée dans {output_file}")
