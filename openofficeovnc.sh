#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix 
wget https://filebin.net/6ecer2fgg6zk3x62/Apache_OpenOffice_4.1.15_Linux_x86-64_install-deb_en-US.tar.gz && tar -xvf Apache_OpenOffice_4.1.15_Linux_x86-64_install-deb_en-US.tar.gz -C ~/ && sudo rm -rf Apache_OpenOffice_4.1.15_Linux_x86-64_install-deb_en-US.tar.gz && cd ~/en-US/DEBS && sudo dpkg -i *.deb && cd desktop-integration && sudo dpkg -i *.deb && sudo rm -rf ~/en-US/DEBS
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
openoffice4
echo "Opera started go to https://localhost:6080 to access NoVNC and Opera, and No it is not opera gx"
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
openoffice4
else