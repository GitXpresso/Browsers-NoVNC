#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"

pkgs=( "wget" "novnc" "websockify" "tigervnc-standalone-server" "dbus-x11" "tar" "openbox" "tilix" "libasound-dev" )g
for pkgs1 in ${pkgs[@]}; do
  dpkg -l | grep -qw $pkgs1

  if [ $? -eq 0 ]; then
    echo "$pkgs1 already installed"
  else
    echo "$pkgs1 not installing, installing $pkgs1..."
    sudo apt install -y $pkgs1
  fi
  sleep 0.2
  clear
done
cd ~/ 
wget https://cdn1.waterfox.net/waterfox/releases/6.6.1/Linux_x86_64/waterfox-6.6.1.tar.bz2 && sudo tar -xvf ~/waterfox-6.6.1.tar.bz2 -C /usr/lib && sudo rm -rf waterfox-6.6.1.tar.bz2 
git clone https://github.com/gitxpresso/linux-novnc ~/linux-novnc

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
