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

INPUT_DIR=${BASE_DIR}diamond/data/${SPECIES1}PDB.fa
DIAMOND=${BASE_DIR}diamond/db/${SPECIES2}DB
DIR1=${BASE_DIR}top_hits/${SPECIES1}_${SPECIES2}
OUT=${DIR1}/${SPECIES1}_${SPECIES2}_diamond_allhits.txt

mkdir ${DIR1}

#Run Diamond and save top ten results
diamond blastp -d ${DIAMOND} -q ${INPUT_DIR} -b12 -c1 -o ${OUT}
php ./php/make_top_ten.php ${OUT} >  ${DIR1}/${SPECIES1}_${SPECIES2}_diamond_top10.txt

#If compraing two species - switch target and query and run Diamond and save top ten results
if [ "$SPECIES1" != "$SPECIES2" ]
then
	DIR2=${BASE_DIR}top_hits/${SPECIES2}_${SPECIES1}
	mkdir ${DIR2}

	INPUT_DIR=${BASE_DIR}diamond/data/${SPECIES2}PDB.fa
	DIAMOND=${BASE_DIR}diamond/db/${SPECIES1}DB
	OUT=${DIR2}/${SPECIES2}_${SPECIES1}_diamond_allhits.txt

	diamond blastp -d ${DIAMOND} -q ${INPUT_DIR} -b12 -c1 -o ${OUT}
	php ./php/make_top_ten.php ${OUT} >  ${DIR2}/${SPECIES2}_${SPECIES1}_diamond_top10.txt
fi

date                          #optional, prints out timestamp when the job ends
#End of file
