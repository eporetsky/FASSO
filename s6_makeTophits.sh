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
NAME1=${SPECIES1}_${SPECIES2}
TOP_DIR1=${BASE_DIR}top_hits/${NAME1}/

echo "${BASE_DIR}php/make_top_hits.php ${TOP_DIR1}${NAME1}_fatcat_foldseek_top10.txt ${TOP_DIR1}${NAME1}_fatcat_diamond_top10.txt ${SPECIES1} ${SPECIES2} ${TOP_DIR1}"
php ${BASE_DIR}php/make_top_hits.php ${TOP_DIR1}${NAME1}_fatcat_foldseek_top10.txt ${TOP_DIR1}${NAME1}_fatcat_diamond_top10.txt ${SPECIES1} ${SPECIES2} ${TOP_DIR1}

NAME2=${SPECIES2}_${SPECIES1}
TOP_DIR2=${BASE_DIR}top_hits/${NAME2}/

echo "${BASE_DIR}php/make_top_hits.php ${TOP_DIR2}${NAME2}_fatcat_foldseek_top10.txt ${TOP_DIR2}${NAME2}_fatcat_diamond_top10.txt ${SPECIES2} ${SPECIES1} ${TOP_DIR2}"
php ${BASE_DIR}php/make_top_hits.php ${TOP_DIR2}${NAME2}_fatcat_foldseek_top10.txt ${TOP_DIR2}${NAME2}_fatcat_diamond_top10.txt ${SPECIES2} ${SPECIES1} ${TOP_DIR2}

date                          #optional, prints out timestamp when the job ends
#End of file
