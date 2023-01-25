#!/bin/bash
#SBATCH --job-name="job_name"
#SBATCH --partition=partition_name
#SBATCH --account=account_name
#SBATCH --mem=16GB
#SBATCH -t 1:00:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"

date	#optional, prints out timestamp at the start of the job in stdout file

########################
#Change these parameters
SPECIES1=$1
SPECIES2=$2
BASE_DIR="$PWD/"
########################
PDB_DIR=${BASE_DIR}alignments/fasta_files/${SPECIES1}PDB_list.txt

php ${BASE_DIR}php/make_pairwise_annotations.php ${SPECIES1} ${SPECIES2} ${PDB_DIR} ${BASE_DIR}

date                          #optional, prints out timestamp when the job ends
#End of file
