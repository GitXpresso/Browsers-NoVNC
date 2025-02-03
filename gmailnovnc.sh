#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
wget https://github.com/timche/gmail-desktop/releases/download/v2.25.3/gmail-desktop-2.25.3-linux.tar.bz2 && tar -xvf gmail-desktop-2.25.3-linux.tar.bz2 -C ~/ && sudo rm -rf gmail-desktop-2.25.3-linux.tar.bz2 && sudo mv -f gmail-desktop-2.25.3-linux gmail-desktop
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
~/gmail-desktop/gmail-desktop --in-process-gpu --display=:0
echo -e "Gmail Desktop and NoVNC has started go to https://localhost:6080 to access NoVNC and Gmail Desktop"
