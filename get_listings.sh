#!/bin/bash
if [[ $1 -ne "" ]]; then
   PAGENUM=$1
else
   PAGENUM=1
fi
FILE='/tmp/listings'$PAGENUM'.txt'
TMPCSV='/tmp/listings'$PAGENUM'.csv'
start=
end=

# get MLS info for properties
curl -o $FILE -s "https://www.usamls.net/southwestva/default.asp?content=results&menu_id=196764&this_format=3&query_id=194272278&page=${PAGENUM}&sortby=2&sort_dir=asc"

#find the relevant parts of the HTML
linenums=($(grep -n '<section class="results-detailed">\|</section>' $FILE | head -n 2 | cut -d: -f1 | tr '\n' ' '))

for i in ${!linenums[@]}; do
    if [[ $i -eq 0 ]]; then
        start=${linenums[$i]}
    else
        end=${linenums[$i]}
    fi
done

numoflines=$(echo "${end} - ${start}" | bc -l)

# snip HTML and put into new file for further processing
tail -n +$start $FILE | head -n $numoflines > listings$PAGENUM.html

# extract data and put into CSV
grep -A1 -e 'label for="\(MLS Number\|Address\|County\|Ttl Acrg\|List Price\)"' -e '\(Pending\|Active\) Property Status' listings$PAGENUM.html\
| sed 's/<div.*">//g;s/<\/div>//g;s/<label.*">//g;s/<\/label>//g;s/^--$//g;s/<a.*>//g;s/<.*>//g'\
| tr "\n" " " \
| sed -E 's///g;s/([0-9]),([0-9])/\1\2/g;s/[[:space:]]{3,}/,/g;s/MLS Number:/\
MLS Number:/g' | sed 's/^,//g;s/,$//g' | grep -v 'Pending' | tee $TMPCSV
