#!/bin/bash

###################

# Téléchargement des espèces de l'étude

####################

ENV_PATH="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/"

. /local/env/envconda.sh

conda activate "$ENV_PATH/EMP_env"

#CetMax -x
datasets download genome accession GCA_964194155.1 --include gbff --filename data/raw_data/CetMax.zip

#HepPerl-x
datasets download genome accession GCF_035084215.1 --include gbff --filename data/raw_data/HepPer.zip

#SphMok -x
datasets download genome accession GCA_024679065.1 --include gbff --filename data/raSphMok.zip

# HetFra -x
datasets download genome accession GCF_036365525.1 --include gbff --filename data/raw_data/HetFra.zip

#SqaSqa -x
datasets download genome accession GCA_031763465.1 --include gbff --filename data/raw_data/SqaSqa.zip

#SqaAca -x
datasets download genome accession GCA_030390025.1 --include gbff --filename data/raw_data/SqaAca.zip

#CarCar - x
datasets download genome accession GCA_024679065.1 --include gbff --filename data/raw_data/CarCar.zip

#LatCha -x
datasets download genome accession GCF_037176945.1 --include gbff --filename data/raw_data/LatCha.zip



