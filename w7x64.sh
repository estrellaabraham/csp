apt-get update
echo "Install QEMU"
apt install qemu-kvm -y
echo "Download windows files"
wget -O w7x64.img https://bit.ly/akuhnetw7X64
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
nohup ./ngrok tcp --region $CRP 3388 &>/dev/null &
echo "Starting Windows"
qemu-system-x86_64 -hda w7x64.img -m 4G -smp cores=2 -net user,hostfwd=tcp::3388-:3389 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga qxl -enable-kvm &>/dev/null &
clear
echo RDP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "===================================="
echo "Username: akuh"
echo "Password: Akuh.Net"
echo "===================================="
echo "===================================="
echo "Keep supporting akuh.net, thank you"
echo "You Got Free RDP now"
echo "Wait 2 minute to finish bot"
echo "You can close this tab"
echo "RDP runs for 50 hours"
echo "===================================="
sleep 43200
