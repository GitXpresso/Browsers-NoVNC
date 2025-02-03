#!/bin/bash
echo "updating system to successfully install required packages"
wget -qO- http://repos.codelite.org/CodeLite.asc | sudo tee /etc/apt/trusted.gpg.d/CodeLite.asc
sudo apt-add-repository -y 'deb https://repos.codelite.org/ubuntu/ jammy universe'
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix codelite
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
codelite
echo -e "codelite has started go to https://localhost:6080 to access your vnc session"
