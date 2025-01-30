#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
wget https://github.com/pulse-browser/browser/releases/download/1.0.0-a.87/pulse-browser.linux.tar.bz2 && tar -xvf pulse-browser.linux.tar.bz2 -C ~/ && sudo rm -rf pulse-browser.linux.tar.bz2
git clone https://github.com/gitxpresso/linux-novnc.git
cat << EOF > ~/pulse.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=zen
Icon=/usr/lib/pulse-browser/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/pulse-browser/pulse-browser %u
Name=Pulse Browser
Comment=experimental forked firefox based browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/pulse.desktop /usr/share/applications/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s ~/pulse-browser/pulse-browser /usr/bin/startpulse
export DISPLAY=:0
startpulse