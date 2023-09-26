echo "Download ngrok"
wget -O ngrok.tgz https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
tar -xf ngrok.tgz > /dev/null 2>&1
read -p "Ctrl + V Authtoken: " CRP 
./ngrok authtoken $CRP 
clear
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
nohup ./ngrok tcp --region $CRP 3389 &>/dev/null &
echo Please wait for installing...
sudo apt update -y > /dev/null 2>&1
echo "Installing QEMU (2-3m)..."
sudo apt install qemu-kvm -y > /dev/null 2>&1
echo "Download windows files"
docker pull thuonghai2711/qemu-kvm-2012r2
echo "Windows 2012 On Google Colab"
docker run --name w2012r2 --privileged -d -p 3389:3389 thuonghai2711/qemu-kvm-2012r2:latest > /dev/null 2>&1
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
sleep 43200
