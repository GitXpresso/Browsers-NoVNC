#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get wget install build-essential devscripts debhelper -y
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
export TAR_DIR="zen"
export TAR_EXEC="zen"
export DEB_DIR="zen-1.7.6b"
export NAME_OF_IMAGE="zen"
wget -P ~/ ${TAR_URL} && tar -xvf ~/*.tar.xz -C ~/ && sudo rm -f ~/*.tar.xz
mkdir ~/${DEB_DIR}
mkdir -p ~/${DEB_DIR}/DEBIAN
# You are going to have to edit the following contents below 
cat << EOF >~/${DEB_DIR}/DEBIAN/control
Package: zen
Version: 1.7.6b
Section: base
Priority: optional
Architecture: all
Maintainer: William G
Description: Zen browser .deb file

EOF
mkdir -p ~/${DEB_DIR}/usr/bin
mkdir -p ~/${DEB_DIR}/usr/lib/zen
mkdir -p ~/${DEB_DIR}/usr/lib
mkdir -p ~/${DEB_DIR}/usr/share/applications/
mkdir -p ~/${DEB_DIR}/usr/share/icons/hicolor/48x48/apps/
echo -e "copying executable files to zen-1.7.6b"
cp -r ~/${TAR_DIR}/${TAR_EXEC} ~/${DEB_DIR}/usr/bin/
echo "copying zen.png to zen-1.7.6b"
cat << EOF >~/${DEB_DIR}/usr/share/applications/zen.desktop
[Desktop Entry]
Version=1.0
# Edit "zen" to the executable file from the tar
# Edit zen.png to a diffrent file name if you want
StartupWMClass=zen 
Icon=/usr/share/icons/hicolor/48x48/apps/zen.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/bin/zen %u
Name=Zen browser
Comment=Zen Browser is a free and open-source web browser based on Mozilla Firefox. It focuses on privacy and customizability, and is designed to enhance performance while avoiding the Google Chromium framework.
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
echo "copying zen.png to zen-1.7.6b"
cp -r ~/${TAR_DIR}/* ~/${DEB_DIR}/usr/lib/zen/
cp -r ~/${TAR_DIR}/lib*.so ~/${DEB_DIR}/usr/lib/
cp -r ~/${TAR_DIR}/browser/chrome/icons/default/default48.png ~/${DEB_DIR}/usr/share/icons/hicolor/48x48/apps/${NAME_OF_IMAGE}.png
dpkg-deb --build ~/${DEB_DIR}