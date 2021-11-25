BEGIN { FS=","; filename = ("listingdetails" filenum ".csv"); print filename }
NR==2 { printf("%s,%s,%s,%s,%s,%s,%s,%s\n", $1, $3, $5, $7, $9, $11, $13, $15)  > filename }
NR>=2  {printf("%s,%s,%s,%s,%s,%s,%s,%s\n", $2, $4, $6, $8, $10, $12, $14, $16)  >> filename }

