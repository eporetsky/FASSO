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
INPUT_DIR=${BASE_DIR}structure_orthologs/
VENN_DIR=${BASE_DIR}venn/
echo "${BASE_DIR}php/create_platinum_and_venn.php ${INPUT_DIR}${NAME1}_orthologs_diamond.txt  ${INPUT_DIR}${NAME1}_orthologs_fatcat.txt ${INPUT_DIR}${NAME1}_orthologs_foldseek.txt ${INPUT_DIR}${NAME1}_FASSO.tsv ${INPUT_DIR}${NAME1}_working_set.tsv > ${VENN_DIR}${NAME1}_venn.txt"
php ${BASE_DIR}php/create_platinum_and_venn.php ${INPUT_DIR}${NAME1}_orthologs_diamond.txt  ${INPUT_DIR}${NAME1}_orthologs_fatcat.txt ${INPUT_DIR}${NAME1}_orthologs_foldseek.txt ${INPUT_DIR}${NAME1}_FASSO.tsv ${INPUT_DIR}${NAME1}_working_set.tsv > ${VENN_DIR}${NAME1}_venn.txt

echo "php ${BASE_DIR}php/create_platinum_and_venn.php ${INPUT_DIR}${NAME2}_orthologs_diamond.txt  ${INPUT_DIR}${NAME2}_orthologs_fatcat.txt ${INPUT_DIR}${NAME2}_orthologs_foldseek.txt ${INPUT_DIR}${NAME2}_FASSO.tsv ${INPUT_DIR}${NAME2}_working_set.tsv > ${VENN_DIR}${NAME2}_venn.txt"
php ${BASE_DIR}php/create_platinum_and_venn.php ${INPUT_DIR}${NAME2}_orthologs_diamond.txt  ${INPUT_DIR}${NAME2}_orthologs_fatcat.txt ${INPUT_DIR}${NAME2}_orthologs_foldseek.txt ${INPUT_DIR}${NAME2}_FASSO.tsv ${INPUT_DIR}${NAME2}_working_set.tsv > ${VENN_DIR}${NAME2}_venn.txt

date                          #optional, prints out timestamp when the job ends
#End of file
