import sys
from Bio import SeqIO



with open(sys.argv[1], 'r') as FastaFile:
    total_length=0
    count =0


    for rec in SeqIO.parse(FastaFile, 'fasta'):
        name = rec.id
        seqLen = len(rec.seq)  # Obtenir la longueur de la séquence
        total_length += seqLen
        count +=1
        
    if count > 0:
        average_length = total_length / count
        print(average_length)
    else: 
        print("\nAucune séquence trouvée dans le fichier.")
