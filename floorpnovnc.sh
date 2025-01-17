echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget https://github.com/Floorp-Projects/Floorp/releases/latest/download/v11.22.0/floorp-11.22.0.linux-x86_64.tar.bz2 && sudo tar -xvf floorp-11.22.0.linux-x86_64.tar.bz2
