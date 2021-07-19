#!/bin/bash

file_base=$1

awk -F '\t' '(0.2 < $11 && $11 < 0.80) && ($14=="TRUE")' ${file_base}_variants.tsv > ${file_base}_frequency.tsv

wc -l ${file_base}_frequency.tsv > ${file_base}_frequency_count.txt
