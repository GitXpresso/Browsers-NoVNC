#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix 
wget https://siag.nu/pub/siag/siag-3.6.1.tar.gz && tar -xvf siag-3.6.1.tar.gz && sudo rm -rf siag-3.6.1.tar.gz
cd ~/siag-3.6.1 && ./configure && make && make install
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
openoffice4