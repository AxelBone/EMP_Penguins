#!/bin/bash

. /local/env/envconda.sh

conda activate /home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/EMP_env

#PÈlican frisÈ (Pelecanus crispus)
datasets download genome accession GCF_000687375.1 --include protein --filename data/raw_data/Pelecanus.zip

#Albatros ‡ nez jaune de l'ocÈan Atlantique (Thalassarche chlororhynchos)
datasets download genome accession GCA_013400895.1 --include protein --filename data/raw_data/Thalassarche.zip

#Manchot AdÈlie (Pygoscelis adeliae)
datasets download genome accession GCF_000699105.1 --include protein --filename data/raw_data/Pygoscelis.zip

# Plongeon catmarin (Gavia stellata )
datasets download genome accession GCF_030936135.1 --include protein --filename data/raw_data/Gavia.zip

#Caurale soleil (Eurypyga helias)
datasets download genome accession GCF_000690775.1 --include protein --filename data/raw_data/Eurypyga.zip

#PhaÈton ‡ bec jaune (Phaethon lepturus)
datasets download genome accession GCF_000687285.1 --include protein --filename data/raw_data/Phaethon.zip

#Engoulevent ‡ queue en ciseaux (Hydropsalis torquata)   Chauna torquata
datasets download genome accession GCA_013399475.1 --include protein --filename data/raw_data/Chauna.zip

#Pluvier kildir (Charadrius vociferus)
datasets download genome accession GCF_000708025.1 --include protein --filename data/raw_data/Charadrius.zip

#Grue royale (Balearica regulorum gibbericeps)
datasets download genome accession GCF_000709895.1 --include protein --filename data/raw_data/Balearica.zip

#Hoazin huppÈ (Opisthocomus hoazin)
datasets download genome accession GCF_000692075.1 --include protein --filename data/raw_data/Opisthocomus.zip

#Gecko lÈopard (Eublepharis macularius)
datasets download genome accession GCF_028583425.1 --include protein --filename data/raw_data/Eublepharis.zip

#Phoque commun (Phoca vitulina)
datasets download genome accession GCF_004348235.1 --include protein --filename data/raw_data/Phoca.zip

conda deactivate
