#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential devscripts debhelper busybox -y
clear
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
export TAR_EXEC="zen"
export TAR_EXEC2="zen-bin"
read -p "Please enter the url of the tar file: " TAR_URL
if [[ ! "${TAR_URL}" == *[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\.]* ]]; then
    echo "Invalid URL that is NOT allowed."
else
    echo "Valid URL grabbing download tar url with wget"
fi
tarfile=$(wget -P ~/ -nv $TAR_URL 2>&1 | cut -d\" -f2) && TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq) && sudo rm -f $tarfile
echo -n "enter the name of your package: "
read DEB_DIR
mkdir ~/$DEB_DIR/
mkdir -p ~/$DEB_DIR/DEBIAN
Package="$(echo $DEB_DIR | sed 's/[^a-z]*//g')"
clear
echo

# Function to check if input is a number
is_number() {
    [[ "$1" =~ ^[0-9+\.]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter a Version for your package: " Version
    if is_number "$Version"; then
        clear
        echo "The version of your package is: $Version"
        read -p "do you want to change the version of your package? (yes/no)" yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debversionprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing package version"
    break
    else
    echo "Not a number."
    exit 1
    fi
        break
    else
        echo "Invalid input. Please enter a valid number."
    fi
done
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
echo -e "copying executable files to $DEB_DIR"
echo "copying image files to $DEB_DIR"
cp -r ~/$TAR_DIR/* ~/$DEB_DIR/usr/lib/$TAR_DIR/
cp -r ~/$TAR_DIR/lib*.so ~/$DEB_DIR/usr/lib/
cp -r ~/$TAR_DIR/browser/chrome/icons/default/default48.png ~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/${NAME_OF_IMAGE}.png
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/${TAR_EXEC} ~/$DEB_DIR/usr/bin 
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/${TAR_EXEC2} ~/$DEB_DIR/usr/bin
dpkg-deb --build ~/$DEB_DIR
