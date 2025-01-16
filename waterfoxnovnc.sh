#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
wget https://cdn1.waterfox.net/waterfox/releases/6.5.3/Linux_x86_64/waterfox-6.5.3.tar.bz2 && sudo tar -xf waterfox-6.5.3.tar.bz2 -C /usr/lib/
cd ~/
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /workspaces/linux-novnc/waterfox/waterfox -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"