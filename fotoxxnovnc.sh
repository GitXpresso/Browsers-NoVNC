#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install wget -y
cd ~/
wget https://rawtherapee.com/shared/builds/linux/RawTherapee_5.11_release.AppImage && chmod u+x RawTherapee_5.11_release.AppImage && ./RawTherapee_5.11_release.AppImage --appimage-extract && sudo rm -rf RawTherapee_5.11_release.AppImage
sudo mkdir /opt/rawtherapee && sudo mv -f ~/squashfs-root /opt/rawtherapee 
sudo mv -f /opt/rawtherapee/squashfs-root/rawtherapee.desktop /usr/share/applications
sudo ln -s /opt/rawtherapee/squashfs-root/usr/bin/rawtherapee /usr/bin/rawtherapee
sudo ln -s /opt/rawtherapee/squashfs-root/usr/bin/rawtherapee-cli /usr/bin/rawtherapee-cli
cd /opt/rawtherapee/squashfs-root/usr/lib && sudo rm -rf /opt/rawtherapee/squashfs-root/usr/lib/girepository-1.0 && sudo mv -f * /usr/lib
sudo apt install -y novnc websockify tigervnc-standalone-server tar openbox dbus-x11 pixmap ffmpeg growisofs fotoxx tilix 
cd ~/
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo -e "fotoxx has started go to https://localhost:6080 to access your vnc session"
fotoxx