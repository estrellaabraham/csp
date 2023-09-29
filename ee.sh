wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt update
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt install --assume-yes vivaldi-stable
