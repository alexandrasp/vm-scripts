#!/bin/bash

function show_image {
	gst-launch-1.0 filesrc location=frame.$1  ! rawvideoparse use-sink-caps=false width=640 height=480 format=$2 ! imagefreeze ! videoconvert ! ximagesink	
}

show_image RGB rgb
show_image BGR bgr
show_image ARGB argb
show_image nv12 nv12
show_image yv12 yv12
