sudo apt install --assume-yes curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt update
echo "======================="
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt --fix-broken install --assume-yes brave-browser
