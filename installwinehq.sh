sudo apt update
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -sc)/winehq-$(lsb_release -sc).sources
sudo apt update
sudo apt install -y --install-recommends wine-stable
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
winecfg 
wget https://github.com/GitXpresso/Browsers-NoVNC/releases/download/winehq/OperaGXSetup.exe
wine OperaGXSetup.exe --display=:0