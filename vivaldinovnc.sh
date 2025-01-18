echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix
wget https://downloads.vivaldi.com/stable/vivaldi-stable_7.0.3495.29-1_amd64.deb && sudo apt install -y ./vivaldi-stable_7.0.3495.29-1_amd64.deb && sudo rm -f vivaldi-stable_7.0.3495.29-1_amd64.deb
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
vivaldi-stable --display=:0
echo -e "vivaldi has started go to https://localhost:6080 to access your vnc session"