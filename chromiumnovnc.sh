echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11
cd ~/
echo "Removing Ubuntu chromium packages"
sudo apt remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
cat << EOF > /etc/apt/sources.list.d/debian.list with the following content:
deb [arch=amd64 signed-by=/usr/share/keyrings/debian-buster.gpg] http://deb.debian.org/debian buster main
deb [arch=amd64 signed-by=/usr/share/keyrings/debian-buster-updates.gpg] http://deb.debian.org/debian buster-updates main
deb [arch=amd64 signed-by=/usr/share/keyrings/debian-security-buster.gpg] http://deb.debian.org/debian-security buster/updates main
EOF
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A
echo "Storeing GPG keys in /usr/share/keyrings"

sudo apt-key export 77E11517 | sudo gpg --dearmour -o /usr/share/keyrings/debian-buster.gpg
sudo apt-key export 22F3D138 | sudo gpg --dearmour -o /usr/share/keyrings/debian-buster-updates.gpg
sudo apt-key export E562B32A | sudo gpg --dearmour -o /usr/share/keyrings/debian-security-buster.gpg
sudo cat << EOF > /etc/apt/preferences.d/chromium.pref 
# Note: 2 blank lines are required between entries
Package: *
Pin: release a=eoan
Pin-Priority: 500

Package: *
Pin: origin "deb.debian.org"
Pin-Priority: 300

# Pattern includes 'chromium', 'chromium-browser' and similarly
# named dependencies:
Pin: origin "deb.debian.org"
Pin-Priority: 700
EOF
sudo apt update && sudo apt install chromium -y
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
export DISPLAY=:0
chromium --display=:0
echo -e "Chromium has started go to https://localhost:6080 to access your vnc session"
