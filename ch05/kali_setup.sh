#!/bin/bash
set -x

cd ~

sudo DEBIAN_FRONTEND=noninteractive dpkg --configure -a
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y kali-linux-default 
wget https://gitlab.com/kalilinux/recipes/kali-scripts/-/raw/main/xfce4.sh 
chmod +x xfce4.sh 
sudo DEBIAN_FRONTEND=noninteractive ./xfce4.sh 
sudo systemctl enable xrdp --now 
echo kali:kali | sudo chpasswd


sudo DEBIAN_FRONTEND=noninteractive apt install -y tigervnc-standalone-server 
VNCPASS=kali123 
printf "$VNCPASS\n$VNCPASS\n\n" | vncpasswd
sudo DEBIAN_FRONTEND=noninteractive apt install -y novnc


sudo apt install dbus-x11 -y
