{FS=","}
$2 != "" {url="https://www.usamls.net/southwestva/?content=expanded&search_content=results&this_format=3&mls_number="$2}
# {print url}
{printf("%s\n", system("curl -s '" url "'"))}