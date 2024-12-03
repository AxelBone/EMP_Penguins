import sys
import os
from Bio import SeqIO

def extract_cds_from_gbff(input_file, output_dir):
    """
    Extracts CDS features from a GenBank file and writes them to a FASTA file in the specified directory.
    :param input_file: Path to the .gbff file.
    :param output_dir: Directory to save the output FASTA file.
    """
    all_entries = []

    # Extract CDS and write to a FASTA file
    with open(input_file, "r") as GBfile:
        GBcds = SeqIO.InsdcIO.GenBankCdsFeatureIterator(GBfile)

        for cds in GBcds:
            if cds.seq is not None:
                cds.id = cds.name
                cds.description = ""
                all_entries.append(cds)

    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    # Generate the output file path
    base_name = os.path.basename(input_file)
    fasta_output = os.path.join(output_dir, f'{base_name}.fasta')

    # Write the FASTA file
    SeqIO.write(all_entries, fasta_output, "fasta")
    print(f"FASTA file written: {fasta_output}")


if __name__ == "__main__":
    # Ensure the script is called with the correct arguments
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_file.gbff> <output_directory>")
        sys.exit(1)

    # Get the input file and output directory from the command line
    input_file = sys.argv[1]
    output_dir = sys.argv[2]

    extract_cds_from_gbff(input_file, output_dir)
