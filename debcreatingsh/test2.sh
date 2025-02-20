echo ${!VAR} >> test2.sh | sed -n 11p
while read line; do [ -z "$line" ] && continue ;echo ${line##* }; done < test2.sh


cat << EOF >~/$DEB_DIR/DEBIAN/control














EOF




grep -oE '[^ ]+$' test2.sh |
Description:

rev < test2.sh | cut -d" " -f1 | rev | tr -d "." | tr "\n" ","
Description: test
