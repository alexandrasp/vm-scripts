#!/bin/bash
disk_space='5G'
disk_name='arch_disk.raw'

extra_packs='vim fish git'
mug_packs='python2 graphviz evince'
v4l2_packs='qt5-base glu gstreamer gst-plugins-base gst-plugins-good'
xforwarding_packs='xorg-xauth xorg-xclock openssh xorg-fonts-type1 haveged'

all_packs="$extra_packs $mug_packs $v4l2_packs $xforwarding_packs"

# allocate and format disk file
# dd if=/dev/zero of=$disk_name bs=512MB count=8
# truncate -s $disk_space $disk_name
mkfs.ext4 $disk_name

# mount disk
mkdir mnt
sudo mount $disk_name mnt

# install basic system
sudo pacstrap mnt base base-devel $all_packs

# configure ssh
sudo chown $USER -R mnt
sudo mkdir mnt/root/.ssh
sudo cat ~/.ssh/id_rsa_collabora.pub > mnt/root/.ssh/authorized_keys

# create bootstrap script
sudo echo "systemctl enable dhcpcd" > mnt/root/start.sh
sudo echo "systemctl enable sshd" >> mnt/root/start.sh
sudo echo "reboot" >> mnt/root/start.sh

sudo echo "shared_folder /root/host 9p trans=virtio 0 0" >> mnt/etc/fstab

# umount disk
sudo umount mnt
