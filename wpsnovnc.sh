#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils
cd ~/
git clone https://github.com/iykrichie/wps-office-19-missing-fonts-on-Linux.git && cd wps-office-19-missing-fonts-on-Linux && sudo mv -f * /usr/share/icons
wget https://filebin.net/tzozgjou4uagdx92/wps-office_11.1.0.11723.XA_amd64.deb && sudo apt install -y ./wps-office_11.1.0.11723.XA_amd64.deb && sudo rm -rf wps-office_11.1.0.11723.XA_amd64.deb
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s ~/blender-4.3.2-linux-x64/blender /usr/bin/blender
export DISPLAY=:0
wps-office