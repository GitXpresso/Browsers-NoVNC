#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils libdbus-glib-1-2:amd64 libgtk2.0-0
cd ~/
cat << EOF > ~/palemoon.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=palemoon
Icon=/usr/lib/palemoon/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/palemoon/palemoon %u
Name=Pale Moon
Comment=Pale Moon Web Browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/palemoon.desktop /usr/share/applications/
wget https://filebin.net/6gfmzir57t8tohsh/palemoon-33.5.1.linux-x86_64-gtk2.tar.xz && sudo tar -xvf palemoon-33.5.1.linux-x86_64-gtk2.tar.xz -C ~/ && sudo rm -rf palemoon-33.5.1.linux-x86_64-gtk2.tar.xz  
git clone https://github.com/gitxpresso/linux-novnc.git ~/linux-novnc
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Pale Moon and NoVNC has started Now go to https://localhost:5900 to access tor on the vnc server"
export DISPLAY=:0
sudo ln -s ~/palemoon/palemoon /usr/bin/startpalemoo
startpalemoon