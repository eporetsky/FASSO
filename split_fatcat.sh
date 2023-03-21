#!/bin/bash
#SBATCH --job-name="FASSO"
#SBATCH --partition=partition
#SBATCH --account=account
#SBATCH --mem=96GB                  # Real memory (RAM) required (MB), 0 is the whole-node memory
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --nodes=1
#SBATCH -t 100:00:00           #time allocated for this job hours:mins:seconds
#SBATCH -o "./log/stdinn.%j.%N"     # standard output, %j adds job number to output file name and %N adds the node name
#SBATCH -e ./log/"stderr.%j.%N"     #optional, prints our standard error

date                          #optional, prints out timestamp at the start of the job in stdout file


SPECIES1=$1
SPECIES2=$2
QUERY_FILE=alignments/splits/${SPECIES1}_${SPECIES2}/$3
OUTPUT=alignments/${SPECIES1}_${SPECIES2}/fatcat/
FATCAT=fatcat/FATCAT
PDB1=pdb/${SPECIES1}/
PDB2=pdb/${SPECIES2}/

# use -m to output a single alignment file per comparison
# without -m multiple files are created for each comparison and the number of files can be too much to handle later
# otherwise re-write so every node outputs into tmp folder then mergex
echo "parallel -j48 --colsep '\t' -a ${QUERY_FILE} fatcat/FATCAT -p1 ${PDB1}{1}.pdb -p2 ${PDB2}{2}.pdb -o ${OUTPUT}{1}.{2} -m"
parallel -j48 --colsep '\t' -a ${QUERY_FILE} fatcat/FATCAT -p1 ${PDB1}{1}.pdb -p2 ${PDB2}{2}.pdb -o ${OUTPUT}{1}.{2} -m

date                          #optional, prints out timestamp when the job ends
#End of file
	
