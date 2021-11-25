#!/bin/bash

for i in $(ls /tmp/listings*.csv); do
filenum=$(grep -o '[0-9]\+' <(echo $i))
# this writes the cleaned up listing data to a CSV in this directory
# why? because the header and rows are two separate things (or something like that)
awk -v "filenum=${filenum}" -f processfilteredlistings.awk $i 
done
