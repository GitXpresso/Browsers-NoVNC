#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
wget https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.bz2 && sudo tar -xvf zen.linux-x86_64.tar.bz2 -C /usr/lib && sudo rm -rf zen.linux-x86_64.tar.bz2
git clone https://github.com/gitxpresso/linux-novnc.git
echo "creating zen.desktop using cat here document"
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
/usr/lib/zen/zen --display=:0