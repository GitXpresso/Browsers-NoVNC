#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dialog tilix dbus-x11
cd ~/
wget https://filebin.net/f6atxfnca1z89hua/opera-stable_116.0.5366.35_amd64.deb && sudo apt install -y ./opera-stable_116.0.5366.35_amd64.deb && sudo rm -rf opera-stable_116.0.5366.35_amd64.deb 
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
opera-stable --display=:0
echo "Opera started go to https://localhost:6080 to access NoVNC and Opera, and No it is not opera gx"
