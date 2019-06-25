#!/bin/bash
bash /root/host/scripts/test_vimc/config_vimc.sh
frame_dir=/root/host/scripts/test_vimc/frames

gst-launch-1.0 -q videotestsrc num-buffers=50 pattern=colors ! video/x-raw,width=640,height=480,format=RGB,framerate=30/1 ! v4l2sink device=/dev/video2 &
gst-launch-1.0 -q v4l2src device=/dev/video3 num-buffers=1 ! video/x-raw,format=RGB,width=1920,height=1440 ! multifilesink location=frame

sleep 2
diff -q frame $frame_dir/frame.loopback
