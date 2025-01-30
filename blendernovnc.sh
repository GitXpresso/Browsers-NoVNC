#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils
cd ~/
wget https://mirrors.iu13.net/blender/release/Blender4.3/blender-4.3.2-linux-x64.tar.xz && tar -xvf blender-4.3.2-linux-x64.tar.xz -C ~/ && sudo rm -f blender-4.3.2-linux-x64.tar.xz 
sudo mv -f ~/blender-4.3.2-linux-x64/blender.desktop /usr/share/applications
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s ~/blender-4.3.2-linux-x64/blender /usr/bin/blender
export DISPLAY=:0
blender