#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
wget https://archive.seamonkey-project.org/releases/2.53.20/linux-x86_64/en-US/seamonkey-2.53.20.en-US.linux-x86_64.tar.bz2 && sudo tar -xvf seamonkey-2.53.20.en-US.linux-x86_64.tar.bz2 
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
/usr/lib/seamonkey/seamonkey --display=:0
echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"