#!/bin/bash

FRAME_DIR=/root/host/scripts/test_vimc/frames

echo "Multiplanar format render tests"

cd /root/host/v4l-grab
rm frame.*
./grab

echo "Testing YVU420M"
diff -q frame.yuvu $FRAME_DIR/frame.yuvu

echo "Testing NV12M"
diff -q frame.nv12 $FRAME_DIR/frame.nv12
