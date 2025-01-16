#!/bin/bash
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.bz2 && sudo tar -xzvf zen.linux-x86_64.tar.bz2 -C /usr/lib/
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/lib/zen/zen -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900