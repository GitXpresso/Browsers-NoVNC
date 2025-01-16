#!/bin/bash
echo "installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox
cd ~/
wget https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.bz2
sudo tar -xzvf zen.linux-x86_64.tar.bz2 -C /usr/lib/
