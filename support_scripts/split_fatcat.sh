#!/bin/bash
#SBATCH --account=small_grains
#SBATCH --job-name="EP-FASSO"
#SBATCH --partition=atlas
#SBATCH --mem=10GB                  # Real memory (RAM) required (MB), 0 is the whole-node memory
#SBATCH --ntasks=2
#SBATCH --nodes=1
#SBATCH -t 44:00:00           #time allocated for this job hours:mins:seconds
#SBATCH -o "./log/stdinn.%j.%N"     # standard output, %j adds job number to output file name and %N adds the node name
#SBATCH -e ./log/"stderr.%j.%N"     #optional, prints our standard error

date                          #optional, prints out timestamp at the start of the job in stdout file

BASE_DIR="$PWD/"

SPECIES1=$1
SPECIES2=$2
QUERY_FILE=$3
OUTPUT_DIR=$4

	echo "perl ${BASE_DIR}fatcat/FATCATQue.pl timeused ${QUERY_FILE} ${SPECIES1} ${SPECIES2} -i ./ -m -t -ac > ${OUTPUT_DIR}"
	perl ${BASE_DIR}fatcat/FATCATQue.pl timeused ${QUERY_FILE} ${SPECIES1} ${SPECIES2} -i ./ -m -t -ac > ${OUTPUT_DIR}

date                          #optional, prints out timestamp when the job ends
#End of file
	
