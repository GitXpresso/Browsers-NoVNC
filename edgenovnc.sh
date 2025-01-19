#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix
cd ~/
wget https://filebin.net/x2v6mw0ke7y3wigc/microsoft-edge-stable_132.0.2957.115-1_amd64.deb && sudo apt install -y ./microsoft-edge-stable_132.0.2957.115-1_amd64.deb && sudo rm -rf microsoft-edge-stable_132.0.2957.115-1_amd64.deb
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
microsoft-edge-stable --display=:0
echo "Tor and NoVNC has started Now go to https://localhost:5900 to access tor on the vnc server"
