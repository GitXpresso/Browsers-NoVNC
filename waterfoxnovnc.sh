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

sudo $(curl -fsSL https://bit.ly/WaterfoxDesktopFile) >> /usr/share/applications/waterfox.desktop
clear
while true; do
  read -p "do you want to add a password to the novnc server? (yes/no/y/n) " yesorno
   if [[ "$yesorno" = "yes" || "$yesorno" == "y" ]]; then
     vncpasswd
     tigervncserver -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
     websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
     sudo ln -s /usr/lib/waterfox/waterfox /usr/bin/waterfox
     export DISPLAY=:0
     echo "waterfox is running on port :6080"
     waterfox
   elif [[ "$yesorno" = "no" || "$yesorno" == "n" ]]; then
     tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
     websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
     sudo ln -s /usr/lib/waterfox/waterfox /usr/bin/waterfox
     echo "waterfox is running on port :6080"
     export DISPLAY=:0
     waterfox
   else
     echo "invalid option, try again..."
     sleep 0.5
     clear
   fi
done
exit 1
fi
