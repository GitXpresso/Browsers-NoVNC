echo Description: >> test2.sh | sed -n 11p
while read line; do [ -z "$line" ] && continue ;echo ${line##* }; done < test2.sh







grep -oE '[^ ]+$' test2.sh |
Description:

rev < test2.sh | cut -d" " -f1 | rev | tr -d "." | tr "\n" ","
