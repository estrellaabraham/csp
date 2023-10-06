sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/toikik1995 --gecos "User" toikik1995
sudo usermod -aG sudo,adm,lp,sys,lpadmin toikik1995
echo "toikik1995:toikik1995" | sudo chpasswd

wget -O ng.sh https://github.com/kmille36/Docker-Ubuntu-Desktop-NoMachine/raw/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh

function goto
{
    label=$1
    cd 
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP
./ngrok authtoken $CRP 

clear
echo "Repo: https://github.com/kmille36/Docker-Ubuntu-Desktop-NoMachine"
echo "======================="
echo "choose ngrok region (for better connection)."
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "choose ngrok region: " CRM
./ngrok tcp --region $CRM 4000 &>/dev/null &
sleep 1
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok; fi

####################################################

sub-install-Brave ()
{
 echo ""
 echo ""
 echo "================================================================="
 echo " Install Brave  "
 echo "-----------------------------------------------------------------"
 sudo apt install curl
 sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
 echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
 sudo DEBIAN_FRONTEND=noninteractive \ 
     apt update
 sudo DEBIAN_FRONTEND=noninteractive \ 
     apt --fix-broken install --assume-yes brave-browser
}

####################################################

sub-install-nomachine ()
{
 echo ""
 echo ""
 echo "================================================================="
 echo " Install NoMachine v8.4.1 amd64  "
 echo "-----------------------------------------------------------------"
 echo "Running..."
 sudo wget https://download.nomachine.com/download/8.4/Linux/nomachine_8.4.2_1_amd64.deb
 sudo apt install -f ./nomachine_8.4.2_1_amd64.deb
}

####################################################

echo "===================================="
echo "Install RDP"
echo "===================================="
sudo apt update && apt upgrade -y
echo "===================================="
sudo DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver
echo "===================================="
sub-install-Brave
sub-install-nomachine
clear
echo "===================================="
echo "Start RDP"
echo "===================================="
echo "Username : user"
echo "Password : root"
echo RDP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Don't close this tab to keep RDP running"
echo "Wait 1 minute to finish bot"
echo "VM can't connect? Restart Cloud Shell then Re-run script."
sleep 43200
