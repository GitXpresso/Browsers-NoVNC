#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils libdbus-glib-1-2:amd64
cd ~/
wget https://filebin.net/6gfmzir57t8tohsh/palemoon-33.5.1.linux-x86_64-gtk2.tar.xz && tar -xvf palemoon-33.5.1.linux-x86_64-gtk2.tar.xz -C ~/&& sudo rm -rf palemoon-33.5.1.linux-x86_64-gtk2.tar.xz  
git clone https://github.com/gitxpresso/linux-novnc.git ~/linux-novnc
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
~/palemoon/palemoon --display=:0
echo "Pale Moon and NoVNC has started Now go to https://localhost:5900 to access tor on the vnc server"
