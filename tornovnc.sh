#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget https://www.torproject.org/dist/torbrowser/14.0.4/tor-browser-linux-x86_64-14.0.4.tar.xz && sudo tar -xf tor-browser-linux-x86_64-14.0.4.tar.xz -C /usr/lib/ && sudo rm -rf tor-browser-linux-x86_64-14.0.4.tar.xz
git clone https://github.com/gitxpresso/linux-novnc.git
sudo mv -f usr/lib/tor-browser/start-tor-browser.desktop /usr/share/applications
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
/usr/lib/tor-browser/firefox --display=:0
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"