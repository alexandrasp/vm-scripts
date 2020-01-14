#!/bin/bash

# enable and start service
services="sshd dhcpcd haveged"
systemctl enable $services
systemctl start $services

# place ssh public key
mkdir .ssh
cat id_rsa.pub > .ssh/authorized_keys

# fill the fstab
echo "shared_folder /root/host 9p trans=virtio 0 0" >> /etc/fstab

reboot
