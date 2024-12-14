import os

# Dossier contenant les fichiers d'alignement
input_directory = "short_example/"  # Remplace "dossier" par le chemin réel du dossier contenant les fichiers
output_file = "supermatrice.fa"

# Dictionnaire pour stocker les séquences par espèce, cumulées
sequences_by_species = {}

# Lecture des fichiers d'alignement
for file_name in os.listdir(input_directory):
    if file_name.endswith(".fa"):
        file_path = os.path.join(input_directory, file_name)

        with open(file_path, 'r', encoding='utf-8-sig') as file:
            current_species = None
            current_sequence = []
            for line in file:
                line = line.strip()

                if line.startswith(">"):
                    # Nettoyer le nom de l'espèce
                    current_species = line.split("_")[0][1:].strip()  # Enlève le préfixe et les caractères spéciaux
                    current_sequence = []
                else:
                    current_sequence.append(line)
                
                # Enregistrement de la séquence pour l'espèce
                if current_species and current_sequence:
                    if current_species in sequences_by_species:
                        sequences_by_species[current_species] += ''.join(current_sequence)
                    else:
                        sequences_by_species[current_species] = ''.join(current_sequence)

print(sequences_by_species)
# Écriture des séquences dans un fichier de supermatrice
with open(output_file, 'w') as output:
    for species, sequence in sequences_by_species.items():
        output.write(f">{species}\n{sequence}\n")

print(f"Supermatrice générée : {output_file}")
