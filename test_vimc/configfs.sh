#!/bin/bash

echo "file drivers/media/platform/vimc/* +p" > /sys/kernel/debug/dynamic_debug/control
echo 15 > /proc/sys/kernel/printk

mount -t configfs none /configfs
mkdir /configfs/vimc/mdev
mkdir /configfs/vimc/mdev/entities/vimc-sensor:my-sensor
mkdir /configfs/vimc/mdev/entities/vimc-capture:my-capture
mkdir "/configfs/vimc/mdev/links/my-sensor:0->my-capture:0"
echo 3 > "/configfs/vimc/mdev/links/my-sensor:0->my-capture:0/flags"
echo 1 > /configfs/vimc/mdev/hotplug
