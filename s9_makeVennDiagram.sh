#!/bin/bash
#SBATCH --job-name="FASSO"
#SBATCH --partition=partition_name
#SBATCH --account=account_name
#SBATCH --mem=16GB
#SBATCH -t 24:00:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"

date	#optional, prints out timestamp at the start of the job in stdout file

########################
#Change these parameters
SPECIES1=$1
SPECIES2=$2
SPECIES1_PROTEOME_SIZE=`ls -1q pdb/${SPECIES1} | wc -l`
SPECIES2_PROTEOME_SIZE=`ls -1q pdb/${SPECIES2} | wc -l`
BASE_DIR="$PWD/"
########################

#pip install scipy, matplotlib, matplotlib_venn

echo "python ${BASE_DIR}python/make_venn_image.py ${SPECIES1} ${SPECIES2} ${SPECIES1_PROTEOME_SIZE} ${BASE_DIR}venn/ ${BASE_DIR}venn/"
python ${BASE_DIR}python/make_venn_image.py ${SPECIES1} ${SPECIES2} ${SPECIES1_PROTEOME_SIZE} ${BASE_DIR}venn/ ${BASE_DIR}venn/

echo "python ${BASE_DIR}python/make_venn_image.py ${SPECIES2} ${SPECIES1} ${SPECIES2_PROTEOME_SIZE} ${BASE_DIR}venn/ ${BASE_DIR}venn/"
python ${BASE_DIR}python/make_venn_image.py ${SPECIES2} ${SPECIES1} ${SPECIES2_PROTEOME_SIZE} ${BASE_DIR}venn/ ${BASE_DIR}venn/

date                          #optional, prints out timestamp when the job ends
#End of file
