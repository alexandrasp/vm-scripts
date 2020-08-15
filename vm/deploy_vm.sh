#!/bin/bash
disk_space='20G'
disk_name='debian.vm'

extra_packs='vim fish git strace gdb dhcpcd5 e2fsprogs'
xforwarding_packs='xauth x11-apps openssh-server haveged'

all_packs="$extra_packs $xforwarding_packs"

# allocate and format disk file
truncate -s $disk_space $disk_name
/sbin/mkfs.ext4 $disk_name

# mount disk
mkdir mnt
sudo mount $disk_name mnt
sleep 3

# install basic system
sudo debootstrap stable mnt http://ftp.br.debian.org/debian/
sudo chroot mnt apt-get -y install $all_packs
sudo add-apt-repository deb "http://ftp.de.debian.org/debian buster main non-free"
sudo apt-get update
sudo apt-get install firmware-linux
sudo update-initramfs -c -k all 

# configure ssh
sudo cp ~/.ssh/id_rsa.pub mnt/root/

# copy bootstrap script
sudo cp start.sh mnt/root/

# umount disk
sudo umount mnt
