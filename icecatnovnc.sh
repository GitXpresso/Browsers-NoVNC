#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
cd ~/
git clone https://github.com/gitxpresso/linux-novnc
wget https://icecatbrowser.org/assets/icecat/115.18.0/icecat-115.18.0.en-US.linux-x86_64.tar.bz2 && sudo tar -xvf icecat-115.18.0.en-US.linux-x86_64.tar.bz2 -C ~/ && sudo rm -rf icecat-115.18.0.en-US.linux-x86_64.tar.bz2 
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
~/icecat/icecat --display=:0
echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
