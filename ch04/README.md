## Preparing the necessary components and prerequisites

```
gcloud config get-value project

gcloud config set project secure-network-environments


cd ~ 
mkdir kali_keys && cd kali_keys


ssh-keygen -t rsa -C kali -f ./kali-ssh


cat kali-ssh.pub
```

## Setting up the target VM Instance

```
wget -O target_boot_script.tpl \
https://raw.githubusercontent.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/main/ch04/pentest_lab/target_vm/target_boot_script.tpl

cat target_boot_script.tpl


wget -O wait_for_boot.tpl \ 
https://raw.githubusercontent.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/main/ch04/pentest_lab/target_vm/wait_for_boot.tpl

cat wait_for_boot.tpl
```

```
gsutil cp kl_image.tar.gz \ 
gs://$BUCKET_NAME/kl_image.tar.gz


IMAGE_NAME=kali-linux-2023-000 gcloud compute images create $IMAGE_NAME \
    --source-uri gs://$BUCKET_NAME/kl_image.tar.gz \
    --family kali-linux
    
gcloud compute images list --no-standard-images
```

## Manually setting up the attacker VM instance

```
NEW_USER="kali"
if ! id -u $NEW_USER > /dev/null 2>&1; then
    adduser --disabled-password --gecos "" $NEW_USER
fi

mkdir -p /home/$NEW_USER/.ssh
chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh
chmod 700 /home/$NEW_USER/.ssh


SSH_KEY="<SSH PUBLIC KEY VALUE>"
echo $SSH_KEY > /home/$NEW_USER/.ssh/authorized_keys
cat /home/$NEW_USER/.ssh/authorized_keys


chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh/authorized_keys
chmod 600 /home/$NEW_USER/.ssh/authorized_keys
systemctl restart ssh


usermod -aG sudo $NEW_USER
echo '$NEW_USER ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/$NEW_USER-nopasswd
chmod 440 /etc/sudoers.d/$NEW_USER-nopasswd


su kali
cd ~


sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y kali-linux-default


cd ~
wget https://gitlab.com/kalilinux/recipes/kali-scripts/-/raw/main/xfce4.sh
chmod +x xfce4.sh
sudo DEBIAN_FRONTEND=noninteractive ./xfce4.sh


sudo systemctl enable xrdp --now


echo kali:kali | sudo chpasswd

sudo apt install -y tigervnc-standalone-server
VNCPASS=kali123
printf "$VNCPASS\n$VNCPASS\n\n" | vncpasswd
sudo DEBIAN_FRONTEND=noninteractive apt install -y novnc


which vncserver
/usr/share/novnc/utils/novnc_proxy --help


EDITOR=vim crontab -e -u kali


@reboot /usr/bin/vncserver
@reboot /usr/share/novnc/utils/novnc_proxy --listen 0.0.0.0:8081 --vnc localhost:5901 >/dev/null 2>&1 &


ssh -L 8081:localhost:8081 -N -i <INSERT KEY NAME> kali@<ATTACKER VM IP>
```
