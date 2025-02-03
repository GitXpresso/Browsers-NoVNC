#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt-add-repository -y 'deb http://cz.archive.ubuntu.com/ubuntu bionic main universe'
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix libwebkit2gtk-4.1-dev
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
wget https://github.com/loft-sh/devpod/releases/latest/download/  && sudo chmod u+x ./DevPod_linux_amd64.AppImage && ./DevPod_linux_amd64.AppImage --appimage-extract && sudo rm -rf DevPod_linux_amd64.AppImage
cd ~/squashfs-root/usr/lib && sudo mv -f * /usr/lib
sudo ln -s ~/squashfs-root/usr/bin/DevPod /usr/bin/DevPod
cat << EOF > ~/DevPod.desktop
[Desktop Entry]
Categories=Development;
Comment=Spin up dev environments in any infra
Exec=/usr/bin/DevPod
Icon=~/squashfs-root/DevPod.png
Name=DevPod
Terminal=false
Type=Application
EOF
sudo mv -f ~/DevPod.desktop /usr/share/applications
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
echo -e "devpod has started go to https://localhost:6080 to access your vnc session"
DevPod
