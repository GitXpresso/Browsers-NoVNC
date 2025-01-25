#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
wget https://archive.seamonkey-project.org/releases/2.53.20/linux-x86_64/en-US/seamonkey-2.53.20.en-US.linux-x86_64.tar.bz2 && sudo tar -xvf seamonkey-2.53.20.en-US.linux-x86_64.tar.bz2 -C /usr/lib && sudo rm -rf seamonkey-2.53.20.en-US.linux-x86_64.tar.bz2
cat << EOF > ~/seamonkey.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=seamonkey
Icon=/usr/lib/seamonkey/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/seamonkey/seamonkey %u
Name=Seamonkey
Comment=Seamonkey Browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/seamonkey.desktop /usr/share/applications/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
/usr/lib/seamonkey/seamonkey --start-maximized --display=:0
echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
