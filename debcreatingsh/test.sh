#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install wget build-essential devscripts debhelper busybox -y
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
export TAR_EXEC="zen"
export TAR_EXEC2="zen-bin"
echo "Please enter the url of the tar file" 
echo -e "example: https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
echo -n "tar url:"
read TAR_URL
wget -P ~/ $TAR_URL && tar -xvf ~/*.tar.xz -C ~/ && sudo rm -f ~/*.tar.xz
echo -n "Please enter the tar directory name: "
read TAR_DIR
echo -n "Please enter the executable file when directory was create from tar file: "
read TAR_EXEC
echo -n "Please enter your base directory name: "
read DEB_DIR

mkdir ~/$DEB_DIR
mkdir -p ~/$DEB_DIR/DEBIAN
# You are going to have to edit the following contents below 
#!/bin/bash

echo "Please enter your input (type 'EOF' on a new line to finish):"
cat << EOF >~/$DEB_DIR/control
Package: $TAR_EXEC
Version: latest
Section: base
Priority: optional
Architecture: all
Maintainer: William G
Description: $TAR_EXEC .deb file

EOF