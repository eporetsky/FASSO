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

mkdir ${BASE_DIR}alignments/flag/${SPECIES1}_${SPECIES2}
mkdir ${BASE_DIR}alignments/flag/${SPECIES2}_${SPECIES1}

mkdir ${BASE_DIR}alignments/matrix/${SPECIES1}_${SPECIES2}
mkdir ${BASE_DIR}alignments/matrix/${SPECIES2}_${SPECIES1}


if [ "$SPECIES1" = "$SPECIES2" ]
then
	sbatch ${BASE_DIR}support_scripts/alignments_merge.sh ${SPECIES1} ${SPECIES2} second
fi

if [ "$SPECIES1" != "$SPECIES2" ]
then
	sbatch ${BASE_DIR}support_scripts/alignments_merge.sh ${SPECIES2} ${SPECIES1} first
	sbatch ${BASE_DIR}support_scripts/alignments_merge.sh ${SPECIES1} ${SPECIES2} second
fi
date                          #optional, prints out timestamp when the job ends
#End of file
