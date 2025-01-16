sudo apt update
sudo apt install software-properties-common apt-transport-https curl -y

curl -fsSL https://download.opensuse.org/repositories/home:hawkeye116477:waterfox/xUbuntu_24.04/Release.key | sudo gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_hawkeye116477_waterfox.gpg > /dev/null
echo 'deb http://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/xUbuntu_24.04/ /' | sudo tee /etc/apt/sources.list.d/home:hawkeye116477:waterfox.list

sudo apt update
sudo apt install waterfox
