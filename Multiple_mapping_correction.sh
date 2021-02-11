#!/bin/bash

#Hisat2 error correction for multiple mapping reads
#python
#run from pflaphy-cdtol

#$ -t 1-72
#$ -cwd
#$ -v PATH=/vol/biotools/bin:/usr/bin
#$ -N hisat2-errorcorrection
#$ -l vf=2G
#$ -l arch=lx-amd64
#$ -l idle=1
#$ -P denbi
#$ -pe multislot 6


# This script was adapted from COMEX (https://github.com/bpietzenuk/COMEX)
# Python files should be downloaded from COMEX

# Set working directory
cd /prj/pflaphy-cdtol/RNAseq/Script/scripts for Tophat error correction


# File list for loop
file=$(cat test.txt | head -n $SGE_TASK_ID | tail -n 1)

input=../../mapped_hisat2/Mapping_output2/$file.out.sam

#echo "Please enter the name of sam input file: "
#read InputSam
#if [ -f $input ];
#then
#	echo "File $InputSam exists."
#else
#	echo "File $InputSam does not exist."
#	exit
#fi
#echo $InputSam
# set Internal_Field_Separator(IFS) to \. to remove .sam from end of filename
#IFS=\.
#arr=($InputSam)
#input=${arr[0]}
#echo $input
# restore the default IFS
#IFS=$OIFS

#echo "Please enter the name of TE annotation file: "
#read annotation;
#if [ -f $annotation ];
#then
#   echo "File $annotation exists."
#else
#   echo "File $annotation does not exist."
#exit

#fi

referenceGenome=../../../genomes/Ahal_W302_V2.2_Head.fasta

#echo "Please enter the name of reference genome file: aha"
#read referenceGenome;
#if [ -f $referenceGenome ];
#then
#	echo "File $referenceGenome exists."
#else
#	echo "File $referenceGenome does not exist."
#	exit
#fi
#echo $annotation
#echo $referenceGenome

#samtools view -h $InputBam >$input'.sam'

#cp Mapping_output2/$InputSam ../../mapped_hisat2/Corrected_reads/
#mv ../../mapped_hisat2/Corrected_reads/$InputSam ../../mapped_hisat2/Corrected_reads/$input'.sam' 

python toprintend1.py ../../mapped_hisat2/Mapping_output2/$input ../../mapped_hisat2/Mapping_output2/$input'_end.sam'

python Selectnonrepeated1.py ../../mapped_hisat2/Mapping_output2/$input'_end.sam' ../../mapped_hisat2/Mapping_output2/$input'_hits_nonrepeated.sam'

#python Selectmultiplemap1.py $input'_hits_nonrepeated.sam' $input'_multiplemapped_reads.sam' $input'_uniquelymapped_reads.sam'

#python new_cases1.py $input'_multiplemapped_reads.sam' $annotation >$input'_multiplecorrected.sam'

#cat $input'_multiplecorrected.sam' $input'_uniquelymapped_reads.sam' >$input'_merged.sam'

python removeEnd1.py ../../mapped_hisat2/Mapping_output2/$input'_hits_nonrepeated.sam' >../../mapped_hisat2/Mapping_output2/$input'_output_final.sam'

samtools view -bT $referenceGenome ../../mapped_hisat2/Mapping_output2/$input'_output_final.sam' >../../mapped_hisat2/Mapping_output2/$input'_corrected.bam'

rm ../../mapped_hisat2/Mapping_output2/$input'_end.sam' ../../mapped_hisat2/Mapping_output2/$input'_hits_nonrepeated.sam' ../../mapped_hisat2/Mapping_output2/$input'_output_final.sam'

#echo "All tophat-errors corrected for $Input."