#!/bin/bash
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.bz2 && sudo tar -xvf zen.linux-x86_64.tar.bz2 -C /usr/lib
git clone https://github.com/gitxpresso/linux-novnc.git
echo "creating zen.desktop using cat here document"
sudo cat << EOF > /usr/share/applications/zen.desktop
[Desktop Entry]
Version=1.0
Type=Application
Exec=/usr/lib/zen/zen
Terminal=false
X-MultipleArgs=false
Icon=/usr/lib/zen/chrome/icons/default/default48.png
StartupWMClass=zen
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=application/json;application/pdf;application/rdf+xml;application/rss+xml;application/x-xpinstall;application/xhtml+xml;application/xml;audio/flac;audio/ogg;audio/webm;image/avif;image/gif;image/jpeg;image/png;image/svg+xml;image/webp;text/html;text/xml;video/ogg;video/webm;x-scheme-handler/chrome;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/mailto;
StartupNotify=true
Actions=new-window;new-private-window;open-profile-manager;
EOF
sudo mv -f ~/zen.desktop /usr/share/applications/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/lib/zen/zen -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900