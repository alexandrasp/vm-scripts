#!/bin/bash

frame_dir=/root/host/scripts/test_vimc/frames
config_top="python2 mug-config_topology.py"
width=640
height=480

function gen_img {
	format=$1
	$config_top $format
	gst-launch-1.0 v4l2src num-buffers=1 \
		! video/x-raw,format=$format,width=$width,height=$height ! multifilesink
	mv 00000 "frame.$format"
}

function test_image {
	diff -q frame.$1 $frame_dir/frame.$1
}

function show_image {
	gst-launch-1.0 filesrc location=$1  ! \
		rawvideoparse use-sink-caps=false width=640 height=480 format=$2 \
		! imagefreeze ! videoconvert ! ximagesink	
}

export PATH="/root/host/yavta:$PATH"
cd /root/host/mug-scripts/

# config all topology
$config_top total_top

# remove all old frames
rm frame.*

# generate RGB
gen_img RGB

# generate scaled RGB
gst-launch-1.0 v4l2src device="/dev/video2" num-buffers=1 ! \
	video/x-raw,format=RGB,width=1920,height=1440 ! multifilesink
mv 00000 frame.RGB_scaled

# generate BGR
gen_img BGR

# generate ARGB
gen_img ARGB

echo "Testing RGB"
test_image RGB

echo "Testing BGR"
test_image BGR

echo "Testing ARGB"
test_image ARGB

echo "Testing scaled RGB"
test_image RGB_scaled
