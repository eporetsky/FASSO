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
SPECIES=$1
PDB_FILE=$2
BASE_DIR="$PWD/"
N=1500 #The number of proteins per file when splitting the proteome
########################

INPUT_DIR=${BASE_DIR}pdb/${SPECIES}
FASTA_DIR=${BASE_DIR}fasta/${SPECIES}
PDB_DIR=${BASE_DIR}pdb/${SPECIES}

#Get dataset, untar, unzip
mkdir ${INPUT_DIR}
mkdir ${FASTA_DIR}
cd ${INPUT_DIR}
tar -xf ${PDB_FILE}
rm *.cif.gz
gunzip *.gz
rm *.gz
rm *.tar


#Create individual fasta files for each protein
for filename_path in ${INPUT_DIR}/*.pdb
do
	filename=$(basename "$filename_path")
	#echo ${INPUT_DIR}/${filename}
	python ${BASE_DIR}pdb2fasta/pdb2fasta.py ${INPUT_DIR}/${filename} > ${FASTA_DIR}/${filename}.fa
done


#Create Diamond database
#module load diamond/2.0.6
cat ${FASTA_DIR}/* > ${BASE_DIR}diamond/data/${SPECIES}PDB.fa
diamond makedb --in ${BASE_DIR}diamond/data/${SPECIES}PDB.fa -d ${BASE_DIR}diamond/db/${SPECIES}DB

#Split data for parallel analysis
mkdir ${BASE_DIR}alignments/splits/${SPECIES}/
ls ${PDB_DIR}/*.pdb | xargs -n 1 basename > ${BASE_DIR}alignments/fasta_files/${SPECIES}PDB_list.txt
split -l ${N} ${BASE_DIR}alignments/fasta_files/${SPECIES}PDB_list.txt ${BASE_DIR}alignments/splits/${SPECIES}/${SPECIES}.
echo "./foldseek/bin/foldseek createdb ${PDB_DIR}/ ${BASE_DIR}/foldseek/db/${SPECIES}DB"
# ${BASE_DIR}foldseek/bin/foldseek createdb ${PDB_DIR}/ ${BASE_DIR}/foldseek/db/${SPECIES}DB
foldseek createdb ${PDB_DIR}/ ${BASE_DIR}/foldseek/db/${SPECIES}DB

cd ../..
date                          #optional, prints out timestamp when the job ends
#End of file
