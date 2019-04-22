#!/bin/bash

frame_dir=/root/host/scripts/test_vimc/frames
config_top="python2 mug-config_topology.py"

echo "Multiplanar format render tests"

$config_top total_top
cd /root/host/v4l-grab
rm frame.*
./grab

echo "Testing YVU420M"
diff -q frame.yv12 $frame_dir/frame.yv12

echo "Testing NV12M"
diff -q frame.nv12 $frame_dir/frame.nv12
