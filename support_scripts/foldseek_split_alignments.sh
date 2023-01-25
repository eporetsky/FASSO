#!/bin/bash
#SBATCH --job-name="EP-FASSO-0001"
#SBATCH --partition=atlas
#SBATCH --account=small_grains
#SBATCH --mem=16GB
#SBATCH -t 1:05:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"

#date	#optional, prints out timestamp at the start of the job in stdout file

########################
BASE_DIR="$PWD/"

QUERY_FILE=$1
QUERY_DIR=$2
TARGET_DB=$3
OUTPUT_DIR=$4

while IFS= read -r file
do
	echo "foldseek easy-search ${QUERY_DIR}${file} ${TARGET_DB} ${OUTPUT_DIR}${file}.m8 ./foldseek/tmp/${file}"
	foldseek easy-search ${QUERY_DIR}${file} ${TARGET_DB} ${OUTPUT_DIR}${file}.m8 ./foldseek/tmp/${file}
done < "${QUERY_FILE}"


#date                          #optional, prints out timestamp when the job ends
#End of file
