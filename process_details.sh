#!/bin/bash

for i in $(ls /tmp/listingdetails*.csv); do
echo $i
filenum=$(grep -o '[0-9]\+' <(echo $i))
awk -v "filenum=${filenum}" -f processfiltereddetails.awk $i 
done

