#####################################################################################

# Calcul de la longueur moyenne de l'alignement

#####################################################################################

import sys
from Bio import SeqIO

with open(sys.argv[1], 'r') as FastaFile:
    total_length=0 
    count =0

    for rec in SeqIO.parse(FastaFile, 'fasta'):
        name = rec.id # Stocke le nom
        seqLen = len(rec.seq)  # Obtenir la longueur de la séquence
        total_length += seqLen # Ajout de la longueur 
        count +=1
        
    if count > 0:
        average_length = total_length / count # Calcul longueur moyenne
        print(average_length)
    else: 
        print("\nAucune séquence trouvée dans le fichier.")

# PS : chaque séquence dans un alignement a la même longueur en théorie. Prendre la longueur de la première séquence serait suffisante. 
# Cette autre approche permet d'être utilisable sur les fichiers non alignés en plus.. 