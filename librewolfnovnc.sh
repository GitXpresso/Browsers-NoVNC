#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
cd ~/
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
librewolf --start-maximized --display=:0
echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
librewolf --start-maximized --display=:0
echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
else
