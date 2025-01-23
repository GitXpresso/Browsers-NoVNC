#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget tar openbox kdialog zenity tilix apt-utils xpra
cd ~/
wget https://www.torproject.org/dist/torbrowser/14.0.4/tor-browser-linux-x86_64-14.0.4.tar.xz && tar -xvf tor-browser-linux-x86_64-14.0.4.tar.xz -C ~/ && sudo rm -rf tor-browser-linux-x86_64-14.0.4.tar.xz
git clone https://github.com/gitxpresso/linux-novnc.git ~/linux-novnc
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
git clone https://github.com/gitxpresso/linux-novnc.git
mkdir -p ~/.xdg 
mkdir -p ~/.Xauthority 
xpra start --no-daemon --bind-tcp=0.0.0.0:8989 -dbus-launch=no --start=openbox --socket-dir=~/.xdg :0
export DISPLAY=:0
~/tor-browser/Browser/start-tor-browser --display=:0
echo "Tor and NoVNC has started Now go to https://localhost:5900 to access tor on the vnc server"

