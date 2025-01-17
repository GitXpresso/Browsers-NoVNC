wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.3/kasmvncserver_bookworm_1.3.3_amd64.deb
sudo apt update
sudo apt install ./kasmvncserver_*.deb

if sudo addgroup $USER ssl-cert ; then
    echo -e "sudo addgroup $USER ssl-cert succeeded don't have to do usermod"
else
    sudo usermod -aG ssl-cert $usermod
fi