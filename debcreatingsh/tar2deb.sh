#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential devscripts debhelper busybox -y
clear
# Edit the Export Variables in order for this file to work successfully
export TAR_EXEC="zen"
export TAR_EXEC2="zen-bin"
read -p "Please enter the url of the tar file: " TAR_URL
if [[ ! "${TAR_URL}" == *[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\-\_\/\&\?\:\.\=]* ]]; then
    echo "Invalid URL that is NOT allowed."
else
    echo "Valid URL grabbing download tar url with wget"
fi
tarfile=$(wget -P ~/ -nv $TAR_URL 2>&1 | cut -d\" -f2) && TAR_DIR=$(tar -xvf $tarfile -C ~/  | cut -d / -f1 | uniq) && sudo rm -f $tarfile
echo -n "enter the name of your package: "
read DEB_DIR
mkdir ~/$DEB_DIR
mkdir -p ~/$DEB_DIR/DEBIAN
Package="$(echo $DEB_DIR | sed 's/[^a-z]*//g')"
curl -fsSL https://raw.githubusercontent.com/GitXpresso/Browsers-NoVNC/refs/heads/main/tar2debversionprompt.sh | bash
read -p "what is your package about?; or just type anything: " Description
cat << EOF >~/$DEB_DIR/DEBIAN/control
Package: $Package
Version: $Version
Section: base
Priority: optional
Architecture: all
Maintainer: $Name
Description: $Description

EOF
mkdir -p ~/$DEB_DIR/usr/bin/
mkdir -p ~/$DEB_DIR/usr/lib/$TAR_DIR
mkdir -p ~/$DEB_DIR/usr/lib/
mkdir -p ~/$DEB_DIR/usr/share/applications/
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/
echo -e "copying executable files to zen-1.7.6b"
echo "copying zen.png to zen-1.7.6b"
cp -r ~/$TAR_DIR/* ~/$DEB_DIR/usr/lib/$TAR_DIR/
cp -r ~/$TAR_DIR/lib*.so ~/$DEB_DIR/usr/lib/
cp -r ~/$TAR_DIR/browser/chrome/icons/default/default48.png ~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/${NAME_OF_IMAGE}.png
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/${TAR_EXEC} ~/$DEB_DIR/usr/bin 
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/${TAR_EXEC2} ~/$DEB_DIR/usr/bin
dpkg-deb --build ~/$DEB_DIR
