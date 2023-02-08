#!/bin/bash
#SBATCH --job-name="FASSO"
#SBATCH --partition=partition_name
#SBATCH --account=account_name
#SBATCH --mem=320GB
#SBATCH -t 24:00:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48

date	#optional, prints out timestamp at the start of the job in stdout file

########################
BASE_DIR="$PWD/"

QUERY_FILE=$1
QUERY_DIR=$2
TARGET_DB=$3
OUTPUT_DIR=$4

parallel -j12 -a ${QUERY_FILE} foldseek easy-search --threads 4 ${QUERY_DIR}{1} ${TARGET_DB} ${OUTPUT_DIR}{1}.m8 ./foldseek/tmp/{1}

date                          #optional, prints out timestamp when the job ends
#End of file
