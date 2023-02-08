#!/bin/bash
#SBATCH --job-name="FASSO"
#SBATCH --partition=partition_name
#SBATCH --account=account_name
#SBATCH --mem=16GB
#SBATCH -t 10:00:00
#SBATCH -o "./log/stdinn.%j.%N"
#SBATCH -e "./log/stderr.%j.%N"

date    #optional, prints out timestamp at the start of the job in stdout file

########################
#Change these parameters
SPECIES=$1   # arg input 1
PDB_FILE=$2  # arg input 2
BASE_DIR="$PWD/"
N=1500 #The number of proteins per file when splitting the proteome
########################

INPUT_DIR=${BASE_DIR}pdb/${SPECIES}
FASTA_DIR=${BASE_DIR}fasta/${SPECIES}
PDB_DIR=${BASE_DIR}pdb/${SPECIES}

# Get dataset, untar, unzip
mkdir ${FASTA_DIR}
cd ${INPUT_DIR}
tar -xzf ${PDB_FILE}
rm *.tar.gz

# Create individual fasta files for each protein
find ${PDB_DIR}/ -maxdepth 1 -name "*.pdb" | xargs -n 1 -P 48  -I{} python ${BASE_DIR}pdb2fasta/pdb2fasta.py ${FASTA_DIR}/ {}

# Create a combined fasta file containing all species-specific protein sequences
# Using find .. instead of cat .. to avoid "Argument list too long" error. Might also be faster.
find ${FASTA_DIR}/ -maxdepth 1 -name "*" -print0 | xargs -0 -n1 -P 48 cat > ${BASE_DIR}diamond/data/${SPECIES}PDB.fa

# Create Diamond database
# module load diamond/2.0.6 | or | conda install -c bioconda diamond
diamond makedb --in ${BASE_DIR}diamond/data/${SPECIES}PDB.fa -d ${BASE_DIR}diamond/db/${SPECIES}DB

# Split data for parallel analysis
mkdir ${BASE_DIR}alignments/splits/${SPECIES}/

# Create a text file containing all the file names for each species
# Using find .. instead of ls .. to avoid "Argument list too long" error
find ${PDB_DIR}/ -maxdepth 1 -name "*.pdb" -print0 | xargs -0 -n 1 -P 48 basename > ${BASE_DIR}alignments/fasta_files/${SPECIES}PDB_list.txt

split -l ${N} ${BASE_DIR}alignments/fasta_files/${SPECIES}PDB_list.txt ${BASE_DIR}alignments/splits/${SPECIES}/${SPECIES}.
echo "./foldseek/bin/foldseek createdb ${PDB_DIR}/ ${BASE_DIR}/foldseek/db/${SPECIES}DB"
# ${BASE_DIR}foldseek/bin/foldseek createdb ${PDB_DIR}/ ${BASE_DIR}/foldseek/db/${SPECIES}DB
foldseek createdb ${PDB_DIR}/ ${BASE_DIR}/foldseek/db/${SPECIES}DB

cd ../..
date                          #optional, prints out timestamp when the job ends
