#!/bin/bash
#SBATCH --job-name="EP-FASSO-0001"
#SBATCH --partition=atlas
#SBATCH --account=small_grains
#SBATCH --mem=16GB
#SBATCH -t 1:05:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"

date	#optional, prints out timestamp at the start of the job in stdout file

########################
#Change these parameters
QUERY=maize
BASE_DIR="$PWD/"
########################

PDB_DIR=${BASE_DIR}pdb/${QUERY}/
OUT_DIR=${BASE_DIR}pdb/${QUERY}_scores.txt
SUMMARY_DIR=${BASE_DIR}pdb/${QUERY}_summary.txt

echo "./php/find_pdb_quality.php ${QUERY} ${PDB_DIR} ${OUT_DIR}"
php ./php/find_pdb_quality.php ${QUERY} ${PDB_DIR} ${OUT_DIR} > ${SUMMARY_DIR}

date                          #optional, prints out timestamp when the job ends
#End of file
