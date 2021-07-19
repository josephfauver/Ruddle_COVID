#!/bin/bash

# memory requirement
#SBATCH --mem=20g 

#Unique name given to each library. This will be provided in a list file for each library.  
file_base=$1

module load BWA

module load SAMtools

module load BEDTools

#Creates a log for each processing step for each library 
log=${file_base}.remove_human.pipeline.log

{

echo "***********************************" 
echo "begin removing human reads for sample: $file_base" 
echo "***********************************" 

cd ${file_base}/Unaligned/

#variables set of each read
f1=${file_base}_AH723KDSXY_L003_R1_001.fastq.gz
f2=${file_base}_AH723KDSXY_L003_R2_001.fastq.gz

Human_Ref=/home/jrf69/project/SARS-CoV-2_Seq/References/human/GRCh38_latest_genomic.fna.gz
DENV_Ref=/home/jrf69/scratch60/DENV_FLDOH/References/DENV_1234.fasta

#Map reads to reference
bwa mem -t 16 $Human_Ref $f1 $f2 > ${file_base}_aln.sam

#.sam to .bam
samtools view -S -b ${file_base}_aln.sam > ${file_base}_aln.bam 

#keep only unmapped reads
samtools view -b -f 4 ${file_base}_aln.bam > ${file_base}_unmapped.bam

#sort final unmapped reads by query name 
samtools sort -n ${file_base}_unmapped.bam -o ${file_base}_unmapped_sorted.bam

#get reads that did not map to human genome
bedtools bamtofastq -i ${file_base}_unmapped_sorted.bam -fq ${file_base}_R1_unmapped.fq -fq2 ${file_base}_R2_unmapped.fq

#total reads that remain after removing human reads
echo "**********************************"
echo "Total reads that remain after aligning to human genome for sample: $file_base"
echo $(cat ${file_base}_R1_unmapped.fq | wc -l)/4*2|bc
echo "**********************************"

rm ${file_base}_aln.sam
rm ${file_base}_aln.bam
rm ${file_base}_unmapped.bam

echo "***********************************" 
echo "finished removing human reads for sample: $file_base" 
echo "***********************************" 

#finish log file for pipeline 
} 2>&1  | tee -a $log

