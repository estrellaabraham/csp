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
./ngrok tcp --region $CRM 5901 &>/dev/null &
sleep 1
echo "===================================="
echo "Install RDP"
echo "===================================="
docker pull accetto/ubuntu-vnc-xfce-firefox-g3
clear
echo "===================================="
echo "Start RDP"
echo "===================================="
echo "===================================="
docker run -d -p 5901:5901 --privileged --shm-size=2g -e VNC_PASSWD=password accetto/ubuntu-vnc-xfce-firefox-g3
clear
echo IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' 
echo User: ubuntu
echo Passwd: ubuntu
echo "VM can't connect? Restart Cloud Shell then Re-run script."
sleep 300
