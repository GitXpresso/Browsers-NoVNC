#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
sudo mv ~/palemoon.desktop /usr/share/applications/
wget https://cdn1.waterfox.net/waterfox/releases/6.5.3/Linux_x86_64/waterfox-6.5.3.tar.bz2 && sudo tar -xvf waterfox-6.5.3.tar.bz2 -C /usr/lib && sudo rm -rf waterfox-6.5.3.tar.bz2 
git clone https://github.com/gitxpresso/linux-novnc.git
cat << EOF > ~/waterfox.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=waterfox
Icon=/usr/lib/waterfox/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/waterfox/waterfox %u
Name=Waterfox
Comment=Waterfox Web Browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv -f ~/waterfox.desktop /usr/share/applications/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
/usr/lib/waterfox/waterfox --display=:0
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"

