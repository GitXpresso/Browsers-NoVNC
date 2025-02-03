#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
wget https://filebin.net/7z15qnayna9ri8w6/ProtonMail-desktop-beta.deb && sudo apt install -y ./ProtonMail-desktop-beta.deb && sudo rm -rf ProtonMail-desktop-beta.deb 
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
proton-mail
echo -e "Proton Mail and NoVNC has started go to https://localhost:6080 to access NoVNC and Gmail Desktop"
