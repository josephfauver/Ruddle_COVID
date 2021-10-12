#!/bin/sh
for file in `cat list.txt`
do
  ./run_a_script.bash $file
done
