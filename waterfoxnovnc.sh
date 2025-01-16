
echo "Installing the required packages in order for the script to worl properly"
sudo  apt install -y wget novnc websockify tigervnc-standalone-server tar
cd ~/
wget https://cdn1.waterfox.net/waterfox/releases/6.5.3/Linux_x86_64/waterfox-6.5.3.tar.bz2 && sudo tar -xf waterfox-6.5.3.tar.bz2
git clone https://github.com/gitxpresso/linux-novnc.git
