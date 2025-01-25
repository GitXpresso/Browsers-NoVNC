#!/bin/bash
# To revert changes after testing waterfoxnovnc service
# tigervncserver  -SecurityTypes none  --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0
# websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/ 
wget https://github.com/GitXpresso/Browsers-NoVNC/releases/download/waterfox/waterfox-6.5.3.tar.bz2 && sudo tar -xvf waterfox-6.5.3.tar.bz2 -C /usr/lib && sudo rm -rf waterfox-6.5.3.bz2
sudo mv -f /usr/lib/waterfox.desktop /usr/share/applications
echo -e "to automatically have waterfox launch on startup do "sudo service waterfoxnovnc start""
/usr/lib/waterfox --display=:0
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"

