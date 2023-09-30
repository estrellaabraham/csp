wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
echo "======================="
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
echo "======================="
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
echo "======================="
sudo wget -O- https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | gpg --dearmor | sudo tee /usr/share/keyrings/yandex.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/yandex.gpg] http://repo.yandex.ru/yandex-browser/deb stable main | sudo tee /etc/apt/sources.list.d/yandex-stable.list
echo "======================="
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt update
sudo apt --fix-broken install firefox
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt --fix-broken install --assume-yes vivaldi-stable
echo "======================="
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt --fix-broken install --assume-yes brave-browser
echo "======================="
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt --fix-broken install --assume-yes microsoft-edge-dev
echo "======================="
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt --fix-broken install --assume-yes yandex-browser-stable
echo "======================="
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
echo deb https://deb.opera.com/opera-stable/ stable non-free | sudo tee /etc/apt/sources.list.d/opera.list
echo "======================="
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt update
sudo DEBIAN_FRONTEND=noninteractive \ 
    apt --fix-broken install --assume-yes opera-stable
