#!/bin/bash

#Unique name given to each library. This will be provided in a list file for each library.  
file_base=$1

mkdir ${file_base}
mkdir ${file_base}/Unaligned 

cat Run_1/Project_Cbv7/Sample_${file_base}/*R1_001.fastq.gz Run_2/Project_Cbv7/Sample_${file_base}/*R1_001.fastq.gz > ${file_base}_cat_L001_R1_001.fastq.gz
cat Run_1/Project_Cbv7/Sample_${file_base}/*R2_001.fastq.gz Run_2/Project_Cbv7/Sample_${file_base}/*R2_001.fastq.gz > ${file_base}_cat_L001_R2_001.fastq.gz

mv ${file_base}_cat_L001_R1_001.fastq.gz ${file_base}/Unaligned/
mv ${file_base}_cat_L001_R2_001.fastq.gz ${file_base}/Unaligned/
