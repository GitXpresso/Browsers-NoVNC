#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
cd ~/
git clone https://github.com/gitxpresso/linux-novnc
wget https://icecatbrowser.org/assets/icecat/115.18.0/icecat-115.18.0.en-US.linux-x86_64.tar.bz2 && sudo tar -xvf icecat-115.18.0.en-US.linux-x86_64.tar.bz2 -C ~/ && sudo rm -rf icecat-115.18.0.en-US.linux-x86_64.tar.bz2 
cat << EOF > ~/icecat.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=icecat
Icon=~/icecat/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=~/icecat/icecat %u
Name=Icecat 
Comment=Icecat browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/icecat.desktop /usr/share/applications/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
~/icecat/icecat --display=:0
echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
