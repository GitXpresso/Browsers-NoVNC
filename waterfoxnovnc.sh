#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"

pkgs=[ "wget" "novnc" "websockify" "tigervnc-standalone-server" "dbus-x11" "tar" "openbox" "tilix" "libasound-dev" ]
cd ~/ 
wget https://cdn1.waterfox.net/waterfox/releases/6.6.1/Linux_x86_64/waterfox-6.6.1.tar.bz2 && sudo tar -xvf ~/waterfox-6.6.1.tar.bz2 -C /usr/lib && sudo rm -rf waterfox-6.6.1.tar.bz2 
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
cat << EOF > ~/waterfox.desktop
[Desktop Entry]
Version=6.5.5
StartupWMClass=waterfox
Icon=/usr/lib/waterfox/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/waterfox/waterfox %u
Name=Waterfox
Comment=Waterfox Web Browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv -f ~/waterfox.desktop /usr/share/applications/
clear
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s /usr/lib/waterfox/waterfox /usr/bin/startwaterfox
export DISPLAY=:0
startwaterfox
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
sudo ln -s /usr/lib/waterfox/waterfox /usr/bin/startwaterfox
export DISPLAY=:0
startwaterfox
else
echo "invalid option"
exit 1
fi
