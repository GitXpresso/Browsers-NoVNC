#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 dialog tilix
cd ~/
wget https://github.com/Floorp-Projects/Floorp/releases/latest/download/floorp-11.22.0.linux-x86_64.tar.bz2 && sudo tar -xvf floorp-11.22.0.linux-x86_64.tar.bz2 -C /usr/lib && sudo rm -rf floorp-11.22.0.linux-x86_64.tar.bz2 
cat << EOF > ~/floorp.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=floorp
Icon=/usr/lib/floorp/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/floorp/floorp %u
Name=Floorp
Comment=firefox based browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/floorp.desktop /usr/share/applications/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
/usr/lib/floorp/floorp --display=:0
echo "floorp has started go to https://localhost:5900 to access floorp in the vnc session"
