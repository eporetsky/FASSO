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
NAME2=${SPECIES2}_${SPECIES1}
INDIR1=${BASE_DIR}top_hits/${NAME1}/
INDIR2=${BASE_DIR}top_hits/${NAME2}/
OUTDIR=${BASE_DIR}structure_orthologs/

TYPE=diamond
echo "php php/createRBHlist.php ${INDIR1}${NAME1}_${TYPE}_tophit.txt ${INDIR2}${NAME2}_${TYPE}_tophit.txt ${OUTDIR}${NAME1}_orthologs_${TYPE}.txt ${OUTDIR}${NAME2}_orthologs_${TYPE}.txt ${SPECIES1} ${SPECIES2} ${TYPE}"
php ${BASE_DIR}php/createRBHlist.php ${INDIR1}${NAME1}_${TYPE}_tophit.txt ${INDIR2}${NAME2}_${TYPE}_tophit.txt ${OUTDIR}${NAME1}_orthologs_${TYPE}.txt ${OUTDIR}${NAME2}_orthologs_${TYPE}.txt ${SPECIES1} ${SPECIES2} ${TYPE}

TYPE=foldseek
echo "php php/createRBHlist.php ${INDIR1}${NAME1}_${TYPE}_tophit.txt ${INDIR2}${NAME2}_${TYPE}_tophit.txt ${OUTDIR}${NAME1}_orthologs_${TYPE}.txt ${OUTDIR}${NAME2}_orthologs_${TYPE}.txt ${SPECIES1} ${SPECIES2} ${TYPE}"
php ${BASE_DIR}php/createRBHlist.php ${INDIR1}${NAME1}_${TYPE}_tophit.txt ${INDIR2}${NAME2}_${TYPE}_tophit.txt ${OUTDIR}${NAME1}_orthologs_${TYPE}.txt ${OUTDIR}${NAME2}_orthologs_${TYPE}.txt ${SPECIES1} ${SPECIES2} ${TYPE}

TYPE=fatcat
echo "php php/createRBHlist.php ${INDIR1}${NAME1}_${TYPE}_tophit.txt ${INDIR2}${NAME2}_${TYPE}_tophit.txt ${OUTDIR}${NAME1}_orthologs_${TYPE}.txt ${OUTDIR}${NAME2}_orthologs_${TYPE}.txt ${SPECIES1} ${SPECIES2} ${TYPE}"
php ${BASE_DIR}php/createRBHlist.php ${INDIR1}${NAME1}_${TYPE}_tophit.txt ${INDIR2}${NAME2}_${TYPE}_tophit.txt ${OUTDIR}${NAME1}_orthologs_${TYPE}.txt ${OUTDIR}${NAME2}_orthologs_${TYPE}.txt ${SPECIES1} ${SPECIES2} ${TYPE}

date                          #optional, prints out timestamp when the job ends
#End of file
