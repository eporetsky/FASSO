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
