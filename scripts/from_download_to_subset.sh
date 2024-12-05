#!/bin/bash

# Une fois téléchargé à partir du script :
# Le premier script qui est lancé : 01_download_species.sh > data/raw_data/

# FAIRE : 
# Les fichiers sont décompressés avec la commande : gunzip data/raw_data/RhinTyp.gbff.gz data/raw_data/dezip/
# Les fichiers gbff téléchargés sont ensuite filtrés pour extraire les protéines avec le script
# Il faudra subset les fichiers
# Lancer orthofinder

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env || {
    echo "Erreur: Impossible d'activer l'environnement Conda. Assurez-vous que le chemin est correct."
    exit 1
}

# Définir les répertoires source et destination
WD="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8"
SOURCE_DIR="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data"
DEST_DIR_DEZIP="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data/dezip"
DEST_DIR_PROTEINS="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data/proteomes"
DEST_DIR_SUBSET="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data/proteomes_subset"
DEST_DIR_ORTHO="/scratch/tp59985"


# Vérifier si le répertoire de destination existe, sinon le créer
if [ ! -d "$DEST_DIR_DEZIP" ]; then
    mkdir -p "$DEST_DIR_DEZIP"
fi

echo "Début du pipeline de traitement ..." 

# Etape 1 : Décompressez les fichiers .gbff.gz
echo "Décompression des fichiers..." 

# for file in "$SOURCE_DIR"/*.gbff.gz; do
#     if [ -f "$file" ]; then
#         # Décompresser chaque fichier dans le répertoire de destination
#         gunzip -c "$file" > "$DEST_DIR_DEZIP/$(basename "${file%.gz}")"
#         echo "Décompressé : $file -> $DEST_DIR_DEZIP/$(basename "${file%.gz}")"
#     fi
# done

echo "Tous les fichiers ont été décompressés."

# Etape 2 : extraction des CDS et traduction en protéines
echo "Extraction des CDS et traduction..."

for gbff_file in "$DEST_DIR_DEZIP"/*.gbff; do
    if [ -f "$gbff_file" ]; then
        output_protein_file="$DEST_DIR_PROTEINS/$(basename "${gbff_file%.gbff}.fa")"
        
        if python3 $WD/scripts_exec/extract_cds_translation.py "$gbff_file" "$output_protein_file"; then
            echo "Extraction réussie : $gbff_file -> $output_protein_file"
        else
            echo "Erreur lors de l'extraction pour : $gbff_file"
        fi
    else
        echo "Aucun fichier .gbff trouvé dans $DEST_DIR_DEZIP."
    fi
done            


# Etape 3 : Subset des protéines 
# On va prendre 15 % du protéome 

echo "Sous-échantillonnage des protéines à hauteur de 10 % du protéome ..."

for protein_file in "$DEST_DIR_PROTEINS"/*.fa; do
    if [ -f "$protein_file" ]; then
        # Calculer 10 % des séquences
        total_sequences=$(grep -c "^>" "$protein_file")
        subset_size=$((total_sequences * 10 / 100))

        output_subset_file="$DEST_DIR_SUBSET/$(basename "$protein_file")"

        # Reformater, mélanger, et extraire un sous-ensemble
        cat "$protein_file" | awk '/^>/ {printf("\n%s\n",$0); next;} {printf("%s",$0);} END {printf("\n");}' | tail -n +2 \
            | paste - - | sort -R | head -n "$subset_size" | tr "\t" "\n" > "$output_subset_file"
        
        echo "Sous-échantillonnage terminé : $protein_file -> $output_subset_file ($subset_size séquences)"
    else
        echo "Aucun fichier de protéines trouvé dans $DEST_DIR_PROTEINS."
    fi
done


# ETAPE 4 : Orthofinder

# echo "Orthofinder avec les données subset ..."

# threads=30

# orthofinder -t $threads -M dendroblast -S diamond -1 -X -o $DEST_DIR_ORTHO -f $DEST_DIR_SUBSET

# echo "Pipeline complet terminé avec succès !"




