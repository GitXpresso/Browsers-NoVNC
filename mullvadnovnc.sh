echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y curl wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11 tilix zenity kdialog
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "Adding the Mullvad repository server to apt"
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
echo -e "Installing the package(mullvad)"
sudo apt update
sudo apt install mullvad-browser -y
cd ~/
read -p "do you want to add a password to the novnc server? (yes/no) " yesorno
if [[ "$yesorno" = "yes" ]]; then
vncpasswd
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE  -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Mullvad browser has started go to https://localhost:5900 to access mullvad"
mullvad-browser --start-maximized --display=:0
elif [[ "$yesorno" = "no" ]]; then
tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Mullvad browser has started go to https://localhost:5900 to access mullvad"
mullvad-browser --start-maximized --display=:0
else