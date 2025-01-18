echo "Downloading the Mullvad signing key using curl"
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "Adding the Mullvad repository server to apt"
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
echo -e "Installing the package(mullvad)"
sudo apt update
sudo apt install mullvad-browser
