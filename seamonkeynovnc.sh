#!/bin/bash
echo "updating system to successfully install required packages"
sudo apt update
echo "Installing required packages"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox dbus-x11
printf 'deb [signed-by=/usr/share/keyrings/ubuntuzilla.gpg] https://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main\n' | sudo tee /etc/apt/sources.list.d/ubuntuzilla.list >/dev/null
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/ubuntuzilla.gpg --keyserver keyserver.ubuntu.com --recv-keys 2667CA5C
sudo apt update
sudo apt install seamonkey-mozilla-build