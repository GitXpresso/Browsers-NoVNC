#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix dbus-x11
cd ~/
wget https://github.com/Alex313031/thorium/releases/download/M128.0.6613.189/thorium-browser_128.0.6613.189_AVX.deb && sudo apt install -y ./thorium-browser_128.0.6613.189_AVX.deb && sudo rm -rf thorium-browser_128.0.6613.189_AVX.deb
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo -e "thorium has started go to https://localhost:6080 to access your vnc session"
thorium-browser --in-process-gpu --no-sandbox --test-type --disable-dev-shm-usage --start-maximized --display=:0
