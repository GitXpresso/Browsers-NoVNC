if [ -d ~/basilisk* ]; then 
echo "installing required packages for ${BBlack}"basilisk""
sudo apt install -y libgtk-3-0 libdbus-glib-1-2 libx11-6 libx11-xcb1 yaru-theme-gtk yaru-theme-icon yaru-theme-sound
else 
echo "The directory "basilisk" does not exist"
fi
if [ -d ~/palemoon* ]; then
echo "installing required packages for ${BBlack}"Palemoon${NoColor}""
sudo apt install -y libgtk-3-0 libdbus-glib-1-2 libx11-6 libx11-xcb1 yaru-theme-gtk yaru-theme-icon yaru-theme-sound
else
echo "The directory "basilisk" does not exist"
fi