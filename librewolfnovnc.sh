#!/bin/bash
if ! grep "Debian" /etc/*release; then
  echo "You are using a non-debian based distro which this script does not support, exiting..."
  exit
fi
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
if [ -f /usr/bin/wget ]; then
  echo "wget already installed, not installing wget..."
else
  echo "wget not installed, installing wget..."
  sudo apt install -y wget
fi
if [ -d /usr/share/novnc ]; then
  echo "novnc already installed"
else
  echo "novnc not installed, installing..."
  sudo apt install novnc -y
fi
if [ -f /usr/bin/websockify ]; then
  echo "websockify installed, not installing..."
else
  echo "websockify not installed, installing websockify..."
  sudo apt install -y websockify
fi
if dpkg -L | grep "tigervnc-standalone-server"; then
  echo "tigervnc already installed, not installing tigervnc..."
else
  echo "tigervnc not instlled, installing..."
  sudo apt install -y tigervnc-standalone-server
fi
if [ -f /usr/bin/tar ]; then
  echo "tar is installed, not installing..."
else
  echo "tar is not installed, installing..."
  sudo apt install -y tar
fi
if [ -f /usr/bin/openbox ]; then
  echo "openbox is installed, not installing..."
else
  echo "openbox is not installed, installing..."
  sudo apt install openbox -y
fi
if dpkg -L | grep "dbus-x11"; then
  echo "dbus-x11 already installed, not installing dbus-x11"
else
  echo "dbus-x11 not installed, installing dbus-x11..."
  sudo apt install dbus-x11-y
fi
if [ -f /usr/bin/tilix ]; then
  echo "Tilix is already installed, not installing tilix..."
else
  echo "Tilix is not installed, installing tilix..."
  sudo apt install tilix -y
fi
if [ -f /usr/bin/extrepo ]; then
  echo "Extrepo already installed, not installing Extrepo..."
else
  echo "Extrepo not installed, installing Leocad..."
  sudo apt install -y extrepo
fi
if [ -f /usr/bin/librewolf ]; then
  echo "Librewolf already installed, not installing librewolf..."
else
  echo "Librewolf is not installed, installing librewolf..."
  clear
  sudo extrepo enable librewolf
  sudo apt update && sudo apt install librewolf -y
fi
while true; do
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" || "$yesorno" == "y" ]]; then
  vncpasswd
  tigervncserver  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
  websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
  export DISPLAY=:0
  echo "Librewolf running on port :6080"
  librewolf --start-maximized --display=:0
  echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
elif [[ "$yesorno" = "no" || "$yesorno" == "n" ]]; then
  tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
  websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
  echo "Librewolf running on port :6080"
  export DISPLAY=:0
  librewolf --start-maximized --display=:0
  echo -e "librewolf has started go to https://localhost:6080 to access your vnc session"
else
  echo "invalid input, try again..."
  sleep 0.5
  clear
fi
