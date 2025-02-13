#!/bin/bash
# Install Zen Browser to create .deb package
wget https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz && tar -xvf zen.linux-x86_64.tar.xz -C ~/
mkdir -p ~/zen-1.7.6b
mkdir -p ~/zen-1.7.6b/DEBIAN
cat << EOF >~/zen-1.7.6b/DEBIAN/control
Package: zen
Version: 1.7.6b
Section: base
Priority: optional
Architecture: all
Maintainer: William G
Description: Zen browser .deb file
EOF
mkdir -p ~/zen-1.7.6b/usr/bin
mkdir -p ~/zen-1.7.6b/usr/lib/zen
mkdir -p ~/zen-1.7.6b/usr/lib
mkdir -p ~/zen-1.7.6b/usr/share/applications
mkdir -p ~/zen-1.7.6b/usr/share/icons/hicolor/48x48/apps
echo -e "copying executable files to zen-1.7.6b"
cp -r ~/zen/zen ~/zen-1.7.6b/usr/bin/
cp -r ~/zen/zen-bin ~/zen-1.7.6b/usr/bin/
echo "copying zen.png to zen-1.7.6b"
cat << EOF >~/zen-1.7.6b/usr/share/applications/zen.desktop
[Desktop Entry]
Version=1.0
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
echo "copying zen.png"
cp -r ~/zen/ ~/zen-1.7.6b/usr/lib/zen
cp -r ~/zen/lib*.so ~/zen-1.7.6b/usr/lib
cp -r ~/zen/browser/chrome/icons/default/default48.png ~/zen-1.7.6b/usr/share/icons/hicolor/48x48/apps/zen.png
dpkg-deb --build ~/zen-1.7.6b