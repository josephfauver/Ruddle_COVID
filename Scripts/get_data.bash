#!/bin/bash

#Unique name given to each library. This will be provided in a list file for each library.  
file_base=$1

cd ${file_base}/Unaligned/ 

cp ${file_base}_variants.tsv /home/jrf69/project/SARS-CoV-2_Seq/data_transfer/CV030
cp ${file_base}_consensus.fa /home/jrf69/project/SARS-CoV-2_Seq/data_transfer/CV030
cp ${file_base}_frequency_count.txt /home/jrf69/project/SARS-CoV-2_Seq/data_transfer/CV030

