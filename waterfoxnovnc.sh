#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo  apt install -y wget novnc websockify tigervnc-standalone-server tar
cd ~/
wget https://cdn1.waterfox.net/waterfox/releases/6.5.3/Linux_x86_64/waterfox-6.5.3.tar.bz2 && sudo tar -xf waterfox-6.5.3.tar.bz2
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver -xstartup ~/waterfox/waterfox -geometry 800x600 -localhost no :0 
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"
