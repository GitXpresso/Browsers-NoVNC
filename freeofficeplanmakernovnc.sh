#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
wget https://www.softmaker.net/down/softmaker-freeoffice-2024_1220-01_amd64.deb && sudo apt install -y ./softmaker-freeoffice-2024_1220-01_amd64.deb && sudo rm -rf softmaker-freeoffice-2024_1220-01_amd64.deb
sudo /usr/share/freeoffice2024/add_apt_repo.sh
sudo apt update
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
planmaker24