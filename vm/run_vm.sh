#!/bin/bash

qemu-system-x86_64 \
	-boot order=a -hda debian.vm \
	-nographic -kernel \
 	/home/alexandra/dev/collabora/linux/arch/x86/boot/bzImage \
	-append "root=/dev/sda rw console=ttyS0 loglevel=7 raid=noautodetect" \
	-fsdev local,id=fs1,path=/home/alexandra/dev/collabora/linux,security_model=none \
	-device virtio-9p-pci,fsdev=fs1,mount_tag=shared_folder \
	--enable-kvm -m 2G -smp 2 -cpu host \
	-net nic -net user,hostfwd=tcp::1337-:22
