#!/bin/bash

#Count reads
#run from pflaphy-cdtol

#$ -t 1-72
#$ -cwd
#$ -v PATH=/vol/biotools/bin:/usr/bin
#$ -N Counting
#$ -l vf=2G
#$ -l arch=lx-amd64
#$ -l idle=1
#$ -P denbi
#$ -pe multislot 6


# Set working directory
cd /prj/pflaphy-cdtol/RNAseq/

file=$(cat test.txt | head -n $SGE_TASK_ID | tail -n 1)

./qualimap comp-counts command with some options (-pe : for paired-ends)
          ../../../software/qualimap_v2.2.1/./qualimap comp-counts \
         -algorithm proportional \
         -bam $file'.out.sam_corrected.bam' \
         -gtf ../../../genomes/Aha_kent_annotation.gtf \
         -id gene_id \
         -out ../CountedReads2/$file'_count.txt' \
         -p non-strand-specific \
         -pe -s \
         -type gene
