#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tar openbox kdialog zenity tilix apt-utils
cd ~/
wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.3/kasmvncserver_bookworm_1.3.3_amd64.deb
sudo apt update
sudo apt install -y ./kasmvncserver_*.deb
wget https://www.torproject.org/dist/torbrowser/14.0.4/tor-browser-linux-x86_64-14.0.4.tar.xz && tar -xvf tor-browser-linux-x86_64-14.0.4.tar.xz -C ~/ && sudo rm -rf tor-browser-linux-x86_64-14.0.4.tar.xz
git clone https://github.com/gitxpresso/linux-novnc.git
vncserver -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
~/tor-browser/Browser/start-tor-browser --display=:0
echo "Tor and NoVNC has started Now go to https://localhost:5900 to access tor on the vnc server"
