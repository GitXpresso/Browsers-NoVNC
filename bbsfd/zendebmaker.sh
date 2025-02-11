cat >>~/.bashrc <<EOF 
DEBEMAIL="wg9797@outlook.com" 
DEBFULLNAME="William G." 
export DEBEMAIL DEBFULLNAME 
EOF
.~/.bashrc
sudo apt update && sudo apt-get install build-essential dh-make debhelper &&cd ~/ && mkdir zen; cd zen/ && wget https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz && tar -xvf zen.linux-x86_64.tar.xz && dh_make -p zen_1.7.6b -f ../zen.linux-x86_64.tar.xz
