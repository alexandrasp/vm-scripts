#!/bin/bash

qemu-system-x86_64 \
	-boot order=a -drive file=debian.vm,format=raw,if=virtio \
	-nographic -kernel \
 	/home/alexandra/dev/collabora/linux/arch/x86/boot/bzImage \
	-append "root=/dev/vda rw console=ttyS0 loglevel=7 raid=noautodetect" \
	-fsdev local,id=fs1,path=/home/alexandra/dev/collabora,security_model=none \
	-device virtio-9p-pci,fsdev=fs1,mount_tag=shared_folder \
	--enable-kvm -m 2G -smp 2 -cpu host \
	-net nic -net user,hostfwd=tcp::1337-:22
