#!/bin/bash

multiplanar=$1

qemu-system-x86_64 \
	-boot order=a -drive file=arch_disk.raw,if=virtio \
	-nographic -kernel \
 	/home/tonyk/codes/linux/arch/x86/boot/bzImage \
	-append "root=/dev/vda rw console=ttyS0 loglevel=7 vimc_capture.multiplanar=$multiplanar" \
	-fsdev local,id=fs1,path=/home/tonyk/codes,security_model=none \
	-device virtio-9p-pci,fsdev=fs1,mount_tag=shared_folder \
	--enable-kvm -m 2G -smp 1 -cpu host \
	-net nic -net user,hostfwd=tcp::1337-:22
