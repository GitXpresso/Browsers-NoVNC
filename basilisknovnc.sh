#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox kdialog zenity tilix apt-utils libdbus-glib-1-2:amd64 libgtk2.0-0
cd ~/
wget -P ~/ https://dl.basilisk-browser.org/basilisk-20250220145130.linux-x86_64-gtk3.tar.xz && tar -xvf ~/basilisk-20250220145130.linux-x86_64-gtk3.tar.xz -C ~/ && sudo rm -rf ~/basilisk-20250220145130.linux-x86_64-gtk3.tar.xz
cat << EOF > ~/basilisk.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=basilisk
Icon=~/basilisk/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=~/basilisk/basilisk %u
Name=Basilisk
Comment=Basilisk Browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/basilisk.desktop /usr/share/applications/
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
sudo ln -s ~/basilisk/basilisk /usr/bin/startbasilisk
startbasilisk
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
sudo ln -s ~/basilisk/basilisk /usr/bin/startbasilisk
startbasilisk
else
echo "invalid input"
exit 1
fi
