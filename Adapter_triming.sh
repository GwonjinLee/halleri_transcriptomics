#!/bin/bash

#Adapter, Quality and length trimming using trimmomatic
#run from pflaphy-cdtol

#$ -t 1-72
#$ -cwd
#$ -v PATH=/vol/biotools/bin:/usr/bin
#$ -N trimmomatic
#$ -l vf=2G
#$ -l arch=lx-amd64
#$ -l idle=1
#$ -P denbi
#$ -pe multislot 6


# Set working directory
cd /prj/pflaphy-cdtol/RNAseq/


file=$(cat test.txt | head -n $SGE_TASK_ID | tail -n 1)
trimmomatic PE -threads 12 -phred33 $file.R1.fq.gz $file.R2.fq.gz \
/prj/pflaphy-cdtol/RNAseq/libraries/trim/paired/$file.R1.fq.gz \
/prj/pflaphy-cdtol/RNAseq/libraries/trim/unpaired/$file.R1.fq.gz \
/prj/pflaphy-cdtol/RNAseq/libraries/trim/paired/$file.R2.fq.gz \
/prj/pflaphy-cdtol/RNAseq/libraries/trim/unpaired/$file.R2.fq.gz \
ILLUMINACLIP:/prj/pflaphy-cdtol/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:120
