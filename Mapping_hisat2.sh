#!/bin/bash

#Mapping
#run from pflaphy-cdtol

#$ -t 1-72
#$ -cwd
#$ -v PATH=/vol/biotools/bin:/usr/bin
#$ -N mapping
#$ -l vf=2G
#$ -l arch=lx-amd64
#$ -l idle=1
#$ -P denbi
#$ -pe multislot 6


# Set working directory
cd /prj/pflaphy-cdtol/RNAseq/

file=$(cat test.txt | head -n $SGE_TASK_ID | tail -n 1)

/prj/pflaphy-cdtol/software/hisat2-2.1.0/hisat2 \
     -p 8 \
     --summary-file Mapping_output2/Mapping_Summary/$file.summary.txt \
     --no-unal \ --dta \
     -x /prj/pflaphy-cdtol/genomes/Aha_W302_index/Aha_W302_index \
     -1 $file.R1.clean.fq.gz \
     -2 $file.R2.clean.fq.gz \
     -S Mapping_output2/$file.out.sam
