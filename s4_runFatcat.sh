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
BASE_DIR="$PWD/"
########################



SPLIT_DIR=${BASE_DIR}alignments/splits/${SPECIES1}_${SPECIES2}/
FATCAT_DIR1=${BASE_DIR}alignments/${SPECIES1}_${SPECIES2}/fatcat
FATCAT_DIR2=${BASE_DIR}alignments/${SPECIES2}_${SPECIES1}/fatcat

mkdir ${FATCAT_DIR1}
ln -s ${FATCAT_DIR1} ${FATCAT_DIR2}

# FATCAT executable needs permission to run
# Don't run an executable if you don't trust the source
chmod +777 fatcat/FATCAT

for filename_path in ${SPLIT_DIR}*
do
	filename=$(basename "$filename_path")
        echo "sbatch ${BASE_DIR}split_fatcat.sh ${SPECIES1} ${SPECIES2} alignments/splits/${SPECIES1}_${SPECIES2}/$filename"
	sbatch ${BASE_DIR}split_fatcat.sh ${SPECIES1} ${SPECIES2} alignments/splits/${SPECIES1}_${SPECIES2}/$filename
done

date                          #optional, prints out timestamp when the job ends
#End of file
