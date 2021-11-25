#!/bin/bash


for i in $(ls /tmp/listings*.csv); do
filenum=$(grep -o '[0-9]\+' <(echo $i))
echo $filenum
awk -f getpropertydetails.awk $i | grep -A3 -e '<span class="expanded_field_heading">\(Listing Office\|Listing Agent\|Zip Code\|Apx Total Acreage\|Area\|Property Type\|City\|MLS Number\):</span>' | sed -E 's/<span class="expanded_field_value">//g;s/<\/span>//g;s/<span class="expanded_field_heading">//g;s/^--$//g'| sed -E 's/^[[:space:]]*$/;/g' | tr -d '\n' | tr -d '' | tr -d ',' | sed -E 's/(MLS Number:)/\
\1/g;s/[ ]{2,}//g;s/(:;|;;)/,/g' | sed -E 's/(;|,)$//g' | tee /tmp/listingdetails${filenum}.csv

done
