#!/bin/bash
disk_space='5G'
disk_name='arch_disk.raw'

extra_packs='vim fish git strace gdb'
mug_packs='python2 graphviz evince'
v4l2_packs='qt5-base glu gstreamer gst-plugins-base gst-plugins-good'
xforwarding_packs='xorg-xauth xorg-xclock openssh xorg-fonts-type1 haveged'

all_packs="$extra_packs $mug_packs $v4l2_packs $xforwarding_packs"

# allocate and format disk file
# dd if=/dev/zero of=$disk_name bs=512MB count=10
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
sudo cp ~/.ssh/id_rsa.pub mnt/root/

# copy bootstrap script
sudo cp start.sh mnt/root

# umount disk
sudo umount mnt
