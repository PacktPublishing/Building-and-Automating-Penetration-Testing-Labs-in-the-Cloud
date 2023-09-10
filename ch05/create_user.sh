NEW_USER=new_user
adduser --disabled-password --gecos "" $NEW_USER
echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers >/dev/null

mkdir -p /home/$NEW_USER/.ssh
chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh
chmod 700 /home/$NEW_USER/.ssh
echo "$NEW_USER:password" | chpasswd
systemctl restart ssh