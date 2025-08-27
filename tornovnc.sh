#!/bin/bash
if ! grep -qi "Debian" /etc/*release; then
  echo "You are using an non-debian based distro, exiting..."
  exit 1
fi
if [ ! ~/.bash_history ]; then
   touch ~/.bash_history
   history -w ~/.bash_history
fi
if grep -o -q 'sudo apt update' ~/.bash_history; then
    echo "System is already updated"
    sleep 0.5
    clear
else
echo "Updating Your System"
sudo apt update 
echo "sudo apt update" >> ~/.bash_history
sleep 0.5
clear
fi
echo "Installing the required packages in order for the script to work properly"
if [ -f /usr/bin/wget ]; then
    echo "wget is already installed."
else
    sudo apt install -y wget
    sleep 0.5
    clear
fi
if [ -f /usr/bin/novnc ]; then
    echo "novnc is already installed."
else
    sudo apt install -y novnc
    sleep 0.5
    clear
fi
if [ -f /usr/bin/websockify ]; then
    echo "websockify is already installed."
else
    sudo apt install -y websockify
    sleep 0.5
    clear
fi
if dpkg -L | grep -qw tigervnc-standalone-server; then
    echo "tigervnc-standalone-server is already installed."
else
    sudo apt install -y tigervnc-standalone-server
    sleep 0.5
    clear
fi
if [ -f /usr/bin/tar ]; then
    echo "tar is already installed."
else
    sudo apt install -y tar
    sleep 0.5
    clear
fi
if [ -f /usr/bin/openbox ]; then
    echo "openbox is already installed."
else
    sudo apt install -y openbox
    sleep 0.5
    clear
fi
if [ -f /usr/bin/kdialog ]; then
    echo "kdialog is already installed."
else
    sudo apt install -y kdialog
    sleep 0.5
    clear
fi
if [ -f /usr/bin/zenity ]; then
    echo "zenity is already installed."
else
    sudo apt install -y zenity
    sleep 0.5
    clear
fi
if [ -f /usr/bin/tilix ]; then
    echo "tilix is already installed."
else
    sudo apt install -y tilix
fi
if [ ! -d "$HOME/tor-browser" ]; then
    wget --show-progress -q -P ~/ https://dist.torproject.org/torbrowser/14.5.6/tor-browser-linux-x86_64-14.5.6.tar.xz && tar -xvf tor-browser-linux-x86_64-14.5.6.tar.xz -C ~/ && rm -rf ~/tor-browser-linux-x86_64-14.5.6.tar.xz 
else 
echo "Tor Browser is already installed."
fi
sudo $(curl -fsSL https://bit.ly/TorBrowserDesktopFile) >> /usr/share/applications/tor-browser.desktop
if [ ! -d "$HOME/linux-novnc" ]; then
  git clone https://github.com/gitxpresso/linux-novnc.git ~/linux-novnc
  sleep 0.5
  clear
else
  echo "linux-novnc exists."
  sleep 0.5
  clear
fi
sudo ss -tulnp | grep :6080 >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "novnc is already running..."
    read -p "do you want to start tor browser? (yes/no) " yesorno2
    if [[ "$yesorno2" = "yes" ]]; then
      export DISPLAY=:0
      if [ ! -f /usr/bin/tor-browser ]; then
      sudo ln -s ~/tor-browser/Browser/start-tor-browser /usr/bin/tor-browser
      fi
      tor-browser
    elif [[ "$yesorno2" = "no" ]]; then
      exit 1
fi
while true; do
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
 if [[ "$yesorno" = "yes" || "$yesorno" == "y" ]]; then
    vncpasswd
    tigervncserver -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
    websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
    sudo ln -s ~/tor-browser/Browser/start-tor-browser /usr/bin/tor-browser
    export DISPLAY=:0
    tor-browser
 elif [[ "$yesorno" = "no" || "$yesorno" == "n" ]]; then
    tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
    websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
    sudo ln -s ~/tor-browser/Browser/start-tor-browser /usr/bin/tor-browser
    echo "tor-browser is running on port :6080..."
    export DISPLAY=:0
    tor-browser
  else
     echo "invalid input, try again..."
     sleep 0.5
     clear
  fi
done
