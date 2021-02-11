#!/bin/bash

#FastQC libraries quality check
#run from pflaphy-cdtol

#$ -t 1-72
#$ -cwd
#$ -v PATH=/vol/biotools/bin:/usr/bin
#$ -N FastQC
#$ -l vf=2G
#$ -l arch=lx-amd64
#$ -l idle=1
#$ -P denbi
#$ -pe multislot 6


# Set working directory
cd /prj/pflaphy-cdtol/RNAseq/


ls *.gz |xargs fastqc -t 25 -o FastQCreports/        ### makes fastqc quality check with all libraries at once saving output in folder FastQCreports
