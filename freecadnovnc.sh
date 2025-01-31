#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils freecad
cd ~/
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
tigervncseruver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
wget https://github.com/FreeCAD/FreeCAD/releases/download/1.0.0/FreeCAD_1.0.0-conda-Linux-x86_64-py311.AppImage && sudo chmod u+x FreeCAD_1.0.0-conda-Linux-x86_64-py311.AppImage && ./FreeCAD_1.0.0-conda-Linux-x86_64-py311.AppImage 