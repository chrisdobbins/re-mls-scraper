BEGIN { FS=","; filename = ("listings" filenum ".csv"); print filenum }
NR==2 { gsub(/:/, ""); printf("%s,%s,%s,%s,%s,%s\n", $1,$3,$5,$7,$9,"Status") > filename} 
$0 != "" {printf("%s,%s,%s,%s,%s,%s\n", $2,$4,$6,$8,$10,$11) >> filename} 
#{print }