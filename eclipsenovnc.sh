#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
cd ~/
wget https://filebin.net/j28u1cihlw76hu0p/eclipse-inst-jre-linux64.tar.gz && tar -xvf eclipse-inst-jre-linux64.tar.gz -C ~/ && sudo rm -rf eclipse-inst-jre-linux64.tar.gz
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
sudo ln -s ~/eclipse-installer/eclipse-inst /usr/bin/eclipse-inst
eclipse-inst
echo -e "eclipse has started go to https://localhost:6080 to access your vnc session"