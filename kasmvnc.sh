wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.3/kasmvncserver_bookworm_1.3.3_amd64.deb
sudo apt update
sudo apt install ./kasmvncserver_*.deb
sudo addgroup $USER ssl-cert
else
sudo usermod -aG ssl-cert $usermod
fi
