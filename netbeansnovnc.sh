#!/bin/bash
echo "updating system to successfully install required packages"
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu focal universe"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix netbeans
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo -e "netbeans has started go to https://localhost:6080 to access your vnc session"
netbeans
