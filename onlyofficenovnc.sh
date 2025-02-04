#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix libgbm-dev
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb && sudo apt install -y ./onlyoffice-desktopeditors_amd64.deb && sudo rm -rf onlyoffice-desktopeditors_amd64.deb
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo -e "onlyoffice has started go to https://localhost:6080 to access your vnc session"
onlyoffice-desktopeditors