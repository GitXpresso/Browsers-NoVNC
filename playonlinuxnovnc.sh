echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y curl wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix winbind
wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget http://deb.playonlinux.com/playonlinux_cosmic.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo dpkg --add-architecture i386 
sudo apt-get install playonlinux -y
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:
playonlinux 