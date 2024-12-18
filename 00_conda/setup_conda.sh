#!/bin/bash

#####################################################################################

# Installation des packages et création de l'environnement conda

#####################################################################################


ENV_PATH="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/"

. /local/env/envconda.sh

#conda create -p "$ENV_PATH/EMP_env" -c bioconda python=3.10 diamond=0.8.36 orthofinder ete3 tqdist mafft iqtree trimal -y

conda activate "$ENV_PATH/EMP_env"

#conda install -c conda-forge ncbi-datasets-cli -y

#conda install -c conda-forge biopython


echo "Levironnement EMP_env est activé."

