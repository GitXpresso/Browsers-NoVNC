#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
wget https://cdn1.waterfox.net/waterfox/releases/6.5.3/Linux_x86_64/waterfox-6.5.3.tar.bz2 && sudo tar -xf waterfox-6.5.3.tar.bz2 -C /usr/lib/
cd ~/
echo "creating waterfox.desktop using the cat here document"
cat << EOF > /usr/share/applications
[Desktop Entry]
Version=1.0
Type=Application
Exec=/usr/lib/waterfox/waterfox
Terminal=false
X-MultipleArgs=false
Icon=/usr/lib/waterfox/chrome/icons/default/default48.png
StartupWMClass=waterfox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=application/json;application/pdf;application/rdf+xml;application/rss+xml;application/x-xpinstall;application/xhtml+xml;application/xml;audio/flac;audio/ogg;audio/webm;image/avif;image/gif;image/jpeg;image/png;image/svg+xml;image/webp;text/html;text/xml;video/ogg;video/webm;x-scheme-handler/chrome;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/mailto;
StartupNotify=true
Actions=new-window;new-private-window;open-profile-manager;
EOF
git clone https://github.com/gitxpresso/linux-novnc.git
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/lib/zen/zen -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"