#!/bin/bash
sudo apt install -y wget tar dbus-x11
wget https://github.com/Floorp-Projects/Floorp/releases/latest/download/floorp-11.22.0.linux-x86_64.tar.bz2 && sudo tar -xvf floorp-11.22.0.linux-x86_64.tar.bz2 -C ~/ && sudo rm -rf floorp-11.22.0.linux-x86_64.tar.bz2 
sudo ln -s ~/floorp/floorp /usr/bin/floorp