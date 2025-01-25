#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils
cd ~/
wget https://github.com/GitXpresso/Browsers-NoVNC/releases/download/tor/tor-browser-linux-x86_64.tar.xz && tar -xvf tor-browser-linux-x86_64.tar.xz -C ~/ && sudo rm -rf tor-browser-linux-x86_64.tar.xz
git clone https://github.com/gitxpresso/linux-novnc.git ~/linux-novnc
sudo mv -f ~/tor-browser/Browser/torbrowser.desktop /usr/share/applications/
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo "Tor and NoVNC has started Now go to https://localhost:5900 to access tor on the vnc server"
~/tor-browser/Browser/start-tor-browser --start-fullscreen --kiosk --display=:0
