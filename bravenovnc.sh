#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox curl tilix dbus-x11
curl -fsS https://dl.brave.com/install.sh | sh
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
brave-browser --no-sandbox --test-type --disable-dev-shm-usage --start-maximized --display=:0
echo -e "brave has started go to https://localhost:6080 to access your vnc session"
