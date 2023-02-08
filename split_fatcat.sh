#!/bin/bash
#SBATCH --job-name="FASSO"
#SBATCH --partition=partition_name
#SBATCH --account=account_name
#SBATCH --mem=10GB                  # Real memory (RAM) required (MB), 0 is the whole-node memory
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --nodes=1
#SBATCH -t 48:00:00           #time allocated for this job hours:mins:seconds
#SBATCH -o "./log/stdinn.%j.%N"     # standard output, %j adds job number to output file name and %N adds the node name
#SBATCH -e ./log/"stderr.%j.%N"     #optional, prints our standard error

date                          #optional, prints out timestamp at the start of the job in stdout file


SPECIES1=$1
SPECIES2=$2
QUERY_FILE=$3
OUTPUT=alignments/${SPECIES1}_${SPECIES2}/fatcat/
FATCAT=fatcat/FATCAT
PDB1=pdb/${SPECIES1}/
PDB2=pdb/${SPECIES2}/

echo "parallel --colsep '\t' -a ${QUERY_FILE} fatcat/FATCAT -p1 ${PDB1}{1}.pdb -p2 ${PDB2}{2}.pdb -o ${OUTPUT}{1}.{2} -m -t"
parallel --colsep '\t' -a ${QUERY_FILE} fatcat/FATCAT -p1 ${PDB1}{1}.pdb -p2 ${PDB2}{2}.pdb -o ${OUTPUT}{1}.{2} -m -t

date                          #optional, prints out timestamp when the job ends
#End of file
	
