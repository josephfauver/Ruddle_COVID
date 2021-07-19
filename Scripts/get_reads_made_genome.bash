#!/bin/bash

#Unique name given to each library. This will be provided in a list file for each library.  
file_base=$1

cd ${file_base}/Unaligned/

samtools view -c -F 260 ${file_base}_aln_trimmed_sorted.bam > ${file_base}_reads_for_consensus.txt
