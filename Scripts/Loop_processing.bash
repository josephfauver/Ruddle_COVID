#!/bin/sh
for file in `cat list.txt`
do
  ./get_variants.bash $file
done
