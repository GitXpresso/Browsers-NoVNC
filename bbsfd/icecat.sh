#!/bin/bash
sudo apt install -y wget tar dbus-x11
wget https://icecatbrowser.org/assets/icecat/115.18.0/icecat-115.18.0.en-US.linux-x86_64.tar.bz2 && sudo tar -xvf icecat-115.18.0.en-US.linux-x86_64.tar.bz2 -C ~/ && sudo rm -rf icecat-115.18.0.en-US.linux-x86_64.tar.bz2 
sudo ln -s ~/icecat/icecat /usr/bin/icecat
