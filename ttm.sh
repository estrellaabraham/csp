####################################################

sub-install-nomachine ()
{
 echo ""
 echo ""
 echo "================================================================="
 echo " Install NoMachine v8.4.1 amd64  "
 echo "-----------------------------------------------------------------"
 read -p "Proceed ? (Y/n)" choice
 if [ "$choice" = "n" ]
    then 
        echo "Bypassing...." 
    elif [ "$choice" = "N" ]
	then
       echo "Bypassing...." 
    else 
       echo "Running..."
       sudo wget https://download.nomachine.com/download/8.4/Linux/nomachine_8.4.2_1_amd64.deb
       sudo apt install -f ./nomachine_8.4.2_1_amd64.deb
fi
}

####################################################

sub-configue-nomachine-user ()
{
 echo ""
 echo ""
 echo "================================================================="
 echo " Set up nomachine user & lock root user"
 echo "-----------------------------------------------------------------"
 read -p "Proceed ? (Y/n)" choice
 if [ "$choice" = "n" ]
    then 
        echo "Bypassing...." 
    elif [ "$choice" = "N" ]
	then
       echo "Bypassing...." 
    else 
    echo "Running..."
    sudo adduser nomachine
         #(example password : paste  se7ye8pc5hs0  )
    sudo usermod -aG sudo,adm,lp,sys,lpadmin nomachine
    sudo passwd --delete --lock rootuser
fi
}

####################################################

sub-brave ()
{
 echo ""
 echo ""
 echo "================================================================="
 echo " Install brave"
 echo "-----------------------------------------------------------------"
 read -p "Proceed ? (Y/n)" choice
 if [ "$choice" = "n" ]
    then 
        echo "Bypassing...." 
    elif [ "$choice" = "N" ]
	then
       echo "Bypassing...." 
    else 
    echo "Running..."
    sudo apt install curl
    
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser
fi
}

####################################################

sudo apt update
sudo apt install xfce4
sudo apt install stacer
sudo apt install mmv
sudo apt install firefox
sudo apt install qdirstat
sub-install-nomachine
sub-configue-nomachine-user
sub-brave
sudo reboot
clear

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
read -p "choose ngrok region: " CRP
./ngrok tcp --region $CRP 4000 &>/dev/null &
sleep 1

if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok; fi
echo "NoMachine: https://www.nomachine.com/download"
echo Done! NoMachine Information:
echo IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' 
echo "VM can't connect? Restart Cloud Shell then Re-run script."
seq 1 43200 | while read i; do echo -en "\r Running .     $i s /43200 s";sleep 0.1;echo -en "\r Running ..    $i s /43200 s";sleep 0.1;echo -en "\r Running ...   $i s /43200 s";sleep 0.1;echo -en "\r Running ....  $i s /43200 s";sleep 0.1;echo -en "\r Running ..... $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1;echo -en "\r Running  .... $i s /43200 s";sleep 0.1;echo -en "\r Running   ... $i s /43200 s";sleep 0.1;echo -en "\r Running    .. $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1; done
