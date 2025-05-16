#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils
cd ~/
https://www.torproject.org/dist/torbrowser/14.5.1/tor-browser-linux-x86_64-14.5.1.tar.xz && tar -xvf tor-browser-linux-x86_64-14.5.1.tar.xz -C ~/ && sudo rm -rf tor-browser-linux-x86_64-14.5.1.tar.xz
cat << EOF > ~/torbrowser.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=torbrowser
Icon=~/tor-browser/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=~/tor-browser/Browser/start-tor-browser %u
Name=Tor browser
Comment=browse privately using the onion routing
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv -f ~/torbrowser.desktop /usr/share/applications/
git clone https://github.com/gitxpresso/linux-novnc.git ~/linux-novnc
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s ~/tor-browser/Browser/start-tor-browser /usr/bin/starttor
export DISPLAY=:0
starttor
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s ~/tor-browser/Browser/start-tor-browser /usr/bin/starttor
export DISPLAY=:0
starttor
else
