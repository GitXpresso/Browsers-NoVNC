#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dialog tilix dbus-x11
cd ~/
wget https://filebin.net/7e896uopsecqi68f/midori_11.5_amd64.deb && sudo apt install ./midori_11.5_amd64.deb && sudo rm -rf midori_11.5_amd64.deb
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080  sudo
export DISPLAY=:0
midori --display=:0
echo "Midori started go to https://localhost:6080 to access NoVNC and Midori"
