#!/bin/bash

#Unique name given to each library. This will be provided in a list file for each library.  
file_base=$1

#Creates a log for each processing step for each library 
log=${file_base}.metagenomic.pipeline.log

{

echo "***********************************" 
echo "begin metagenomic consensus generation: $file_base" 
echo "***********************************" 

cd ${file_base}/Unaligned/

#variables set of each read
f1=${file_base}_AH723KDSXY_L003_R1_001.fastq.gz
f2=${file_base}_AH723KDSXY_L003_R2_001.fastq.gz

reference_genome=/home/jrf69/project/SARS-CoV-2_Seq/References/SARS-CoV-2_Reference_Genome/nCoV_2019_V3_reference.fa

echo "**********************************"
echo "Total reads in metagenomic sample: $file_base"
echo $(cat $f1 | wc -l)/4*2|bc
echo "**********************************"

#Align paired end reads to the reference covid virus genome
bwa mem -t 16 $reference_genome $f1 $f2 | samtools view -b -F 4 -F 2048 | samtools sort -o ${file_base}_aln_sorted.bam

#index for consensus generation
samtools index ${file_base}_aln_sorted.bam

#Use samtools to identify variants in reads compared to references, call consensus sequence with ivar
samtools mpileup -A -d 0 -Q 0 ${file_base}_aln_sorted.bam | ivar consensus -t 0.75 -p ${file_base}_consensus

#Use samtools to identify variants in reads compared to reference, output variants in tsv
samtools mpileup -A -d 0 -Q 0 ${file_base}_aln_sorted.bam | ivar variants -p ${file_base}_variants -q 20 -t 0.1 -r $reference_genome

#generate Depth of Coverage file for each position
samtools depth -a ${file_base}_aln_sorted.bam > ${file_base}_DOC.txt

#total reads that remain after removing human reads
echo "**********************************"
echo "Total reads that align to reference for sample: $file_base"
samtools view -c -F 260 ${file_base}_aln_sorted.bam
echo "**********************************"

echo "***********************************" 
echo "finished metagenomic consensus generation: $file_base" 
echo "***********************************" 

#finish log file for pipeline 
} 2>&1  | tee -a $log
