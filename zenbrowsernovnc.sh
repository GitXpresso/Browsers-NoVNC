#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
yesorno() {
if [ "$yesorno" = "yes" ]; then
wget https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz && sudo tar -xvf zen.linux-x86_64.tar.xz -C /usr/lib && sudo rm -rf zen.linux-x86_64.tar.xz
elif [[ "$yesorno" = "no" ]]; then
exit 1
fi
}
arch=$(uname -p)
if [ "$arch" = "x86_64" ]; then
wget https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz && sudo tar -xvf zen.linux-x86_64.tar.xz -C /usr/lib && sudo rm -rf zen.linux-x86_64.tar.xz
else
read -p "your linux architecture is not "x86_64" do you still want to continue? (yes/no) " yesorno
yesorno
fi
git clone https://github.com/gitxpresso/linux-novnc.git
cat << EOF > ~/zen.desktop
[Desktop Entry]
Version=1.0
StartupWMClass=zen
Icon=/usr/lib/zen/browser/chrome/icons/default/default48.png
Type=Application
Categories=Network;WebBrowser;
Exec=/usr/lib/zen/zen %u
Name=Zen browser
Comment=Zen Browser
Terminal=false
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/qute;
Keywords=Browser;
EOF
sudo mv ~/zen.desktop /usr/share/applications/
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
sudo ln -s /usr/lib/zen/zen /usr/bin/startzen
startzen
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
sudo ln -s /usr/lib/zen/zen /usr/bin/startzen
startzen
else
echo "invalid input"
exit 1
fi