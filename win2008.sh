apt-get update
echo "Install QEMU"
apt install qemu-kvm -y
echo "Download windows files"
wget -O win2008.iso https://download.microsoft.com/download/0/A/F/0AF6A5D0-6B5B-4629-BDC9-38CD41D7655B/6002.18005.090410-1830_iso_update_sp_wave0-RTMSP2.0_DVD.iso
echo "Download bios64"
wget -O bios64.bin https://github.com/BlankOn/ovmf-blobs/raw/master/bios64.bin
echo "Create win2008.img"
qemu-img create -f raw win2008.img
qemu-img create -f raw win2008.img 30G
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
./ngrok tcp --region $CRP 5900 &>/dev/null &
sleep 1
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok; fi
clear
echo RDP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "===================================="
sleep 43200
