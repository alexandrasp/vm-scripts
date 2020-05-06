#!/bin/bash

# enable and start service
services="sshd dhcpcd haveged"
systemctl enable $services
systemctl start $services

# place ssh public key
mkdir .ssh
cat id_rsa.pub > .ssh/authorized_keys

# create a user
useradd -m user -G wheel
mkdir /home/user/.ssh
cat id_rsa.pub > /home/user/.ssh/authorized_keys
echo "fish" >> /home/user/.bashrc
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# fill the fstab
echo "shared_folder /root/host 9p trans=virtio 0 0" >> /etc/fstab

reboot
