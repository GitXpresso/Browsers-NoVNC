TAR_EXEC=`find  $TAR_DIR -executable -type f`
Package="$(echo $DEB_DIR | sed 's/[^a-z]*//g')"
EXEC="echo $DEB_DIR | sed 's/[^a-z]*//g')"
echo "${EXEC}"
cat << EOF >/workspace/Browsers-NoVNC/debcreatingsh/test3.txt

 sudo apt install -y aptitude && TEST=`aptitude search '~Ginterface::graphical regex'`

EXEC1=$(find ~/$TAR_DIR -name "$EXEC2" -executable )



find ~/ -type f -name "*.tar.xz" -exec TAR_DIR=$(tar -xvf $tarfile -C ~/  | cut -d / -f1 | uniq) \;

find ~/ -name "*.tar.xz" -print0 | TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq)
compgen -G "~/*.tar.xz" > /dev/null && 



for f in ~/*.tar.xz
do
  TAR_DIR=(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq)
done
TEST="$(compgen -G "~/*.tar.xz" > /dev/null && TAR_DIR=`tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq`)"


TEST=$(find ~/ -type f -name "*.tar.xz" -print0 | 

EOF
export TAR_DIR="tar-31"
printf '%s\n' "${TAR_DIR//[[:digit:]]}" && printf '%s\n' "${TAR_DIR//-}"

export DESCRIPTION="test"
export DESCRIPTION="test"
echo $VAR >> test2.sh | sed -n 11p

DS2="Description: "
VAR="$DS2 $DESCRIPTION"

printf '%s\n' "${TAR_DIR//-}"

echo Description: >> test.sh | sed -n 11p >> test.sh && echo ${!Description} >> test.sh | sed -n 11p

hat
hat
hat
Description:
Description:
hat
Description:
Description:
Description:
Description:
Description:
mv -t ~/$DEB_DIR/usr/bin/ $EXEC
