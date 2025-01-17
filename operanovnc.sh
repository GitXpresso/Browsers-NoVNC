#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
sudo apt update
sudo apt install opera-stable
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/lib/waterfox/waterfox -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
opera-stable --display=:0
echo "Finished, Your VNC Server is now running on port 6080"