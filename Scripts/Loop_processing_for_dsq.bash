#!/bin/sh
for file in `cat list.txt`
do
  echo bash SARS_CoV_2_Amplicon_processing_fragmented.bash $file
done > joblist.txt
