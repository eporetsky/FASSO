#!/bin/bash
#SBATCH --job-name="FASSO"
#SBATCH --partition=partition_name
#SBATCH --account=account_name
#SBATCH --mem=16GB
#SBATCH -t 24:00:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"
#SBATCH --mail-user=elly.poretsky@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

date	#optional, prints out timestamp at the start of the job in stdout file

########################
#Change these parameters
SPECIES1=$1
SPECIES2=$2
BASE_DIR="$PWD/"
########################

TARGET_DB=${SPECIES2}DB
QUERY_DIR=${BASE_DIR}pdb/${SPECIES1}/
NAME=${SPECIES1}_${SPECIES2}
TARGET_DIR=${BASE_DIR}foldseek/db/${TARGET_DB}
SPLIT_DIR=${BASE_DIR}alignments/splits/${SPECIES1}/
OUT_DIR=${BASE_DIR}alignments/${NAME}/foldseek/

mkdir ${BASE_DIR}alignments/${NAME}
mkdir ${OUT_DIR}

# might need to change permission (chmod) on fatcat/FATCAT to be able to run the executable

for filename_path in ${SPLIT_DIR}*
do
	filename=$(basename "$filename_path")
	echo "sbatch ${BASE_DIR}support_scripts/foldseek_split_alignments.sh ${SPLIT_DIR}${filename} ${QUERY_DIR} ${TARGET_DIR} ${OUT_DIR}"
	sbatch ${BASE_DIR}foldseek_split_alignments.sh ${SPLIT_DIR}${filename} ${QUERY_DIR} ${TARGET_DIR} ${OUT_DIR}
done

TARGET_DB=${SPECIES1}DB
QUERY_DIR=${BASE_DIR}pdb/${SPECIES2}/
NAME=${SPECIES2}_${SPECIES1}
TARGET_DIR=${BASE_DIR}foldseek/db/${TARGET_DB}
SPLIT_DIR=${BASE_DIR}alignments/splits/${SPECIES2}/
OUT_DIR=${BASE_DIR}alignments/${NAME}/foldseek/

mkdir ${BASE_DIR}alignments/${NAME}
mkdir ${OUT_DIR}

for filename_path in ${SPLIT_DIR}*
do
	filename=$(basename "$filename_path")
	echo "sbatch ${BASE_DIR}support_scripts/foldseek_split_alignments.sh ${SPLIT_DIR}${filename} ${QUERY_DIR} ${TARGET_DIR} ${OUT_DIR}"
	sbatch ${BASE_DIR}foldseek_split_alignments.sh ${SPLIT_DIR}${filename} ${QUERY_DIR} ${TARGET_DIR} ${OUT_DIR}
done

date                          #optional, prints out timestamp when the job ends
#End of file

# Input /90daydata/small_grains/FASSO_EP_WIP/foldseek/db/arabidopsisDB/ does not exist

