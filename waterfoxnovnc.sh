#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget https://cdn1.waterfox.net/waterfox/releases/6.5.3/Linux_x86_64/waterfox-6.5.3.tar.bz2 && sudo tar -xvf waterfox-6.5.3.tar.bz2 -C /usr/lib
echo "creating waterfox.desktop using the cat here document"
cat << EOF > ~/waterfox.desktop
[Desktop Entry]
Version=1.0
Name=Waterfox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=/usr/lib/waterfox/waterfoxTerminal=false %u
X-MultipleArgs=false
Type=Application
Icon=/usr/lib/waterfox/chrome/icons/default/default48.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=Open a New Window
Exec=/usr/lib/waterfox/waterfox -new-window

[Desktop Action new-private-window]
Name=Open a New Private Window
Exec=/usr/lib/waterfox/waterfox -private-window
EOF
sudo mv -f ~/waterfox.desktop /usr/share/applications
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/lib/waterfox/waterfox -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"