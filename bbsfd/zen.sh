#!/bin/bash
wget https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen-x86_64.AppImage -P ~/ && sudo chmod u+x ~/zen-x86_64.AppImage && ~/zen-x86_64.AppImage --appimage-extract && sudo ln -s ~/squashfs-root/zen /usr/bin/zen
sudo mv -f ~/squashfs-root/usr/share/icons/hicolor/128x128/apps/zen.png /usr/share/icons/hicolor/128x128/apps/zen.png
