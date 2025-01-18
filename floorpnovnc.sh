#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 dialog
cd ~/
wget https://github.com/Floorp-Projects/Floorp/releases/latest/download/floorp-11.22.0.linux-x86_64.tar.bz2 && sudo tar -xvf floorp-11.22.0.linux-x86_64.tar.bz2 -C /usr/lib
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
/usr/lib/floorp/floorp --display=:0
echo "floorp has started go to https://localhost:5900 to access floorp in the vnc session"
