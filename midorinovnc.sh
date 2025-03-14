#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dialog tilix dbus-x11
cd ~/
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
wget https://github.com/GitXpresso/Browsers-NoVNC/releases/download/TarAndDeb/midori_11.5_amd64.deb && sudo apt install ./midori_11.5_amd64.deb && sudo rm -rf midori_11.5_amd64.deb
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo "Midori started go to https://localhost:6080 to access NoVNC and Midori"
midori --start-maximized --display=:0
echo "Opera started go to https://localhost:6080 to access NoVNC and Opera, and No it is not opera gx"
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo "Midori started go to https://localhost:6080 to access NoVNC and Midori"
midori --start-maximized --display=:0
else
