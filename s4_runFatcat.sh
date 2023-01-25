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

SPLIT_DIR=${BASE_DIR}alignments/splits/${SPECIES1}_${SPECIES2}/
FATCAT_DIR1=${BASE_DIR}alignments/${SPECIES1}_${SPECIES2}/fatcat
FATCAT_DIR2=${BASE_DIR}alignments/${SPECIES2}_${SPECIES1}/fatcat
OUT_DIR=${BASE_DIR}fatcat/out/${SPECIES1}_${SPECIES2}/

mkdir ${FATCAT_DIR1}
ln -s ${FATCAT_DIR1} ${FATCAT_DIR2}
mkdir ${OUT_DIR}

for filename_path in ${SPLIT_DIR}*
do
	filename=$(basename "$filename_path")
	sbatch ${BASE_DIR}support_scripts/split_fatcat.sh ${SPECIES1} ${SPECIES2} ${SPLIT_DIR}$filename ${OUT_DIR}$filename
done

date                          #optional, prints out timestamp when the job ends
#End of file
