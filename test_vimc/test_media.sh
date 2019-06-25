#!/bin/bash

media-ctl -d platform:vimc -V '"Sensor A":0[fmt:SBGGR8_1X8/640x480]'
media-ctl -d platform:vimc -V '"Debayer A":0[fmt:SBGGR8_1X8/640x480]'
media-ctl -d platform:vimc -V '"Sensor B":0[fmt:SBGGR8_1X8/640x480]'
media-ctl -d platform:vimc -V '"Debayer B":0[fmt:SBGGR8_1X8/640x480]'
v4l2-ctl -z platform:vimc -d "RGB/YUV Capture" -v width=1920,height=1440
v4l2-ctl -z platform:vimc -d "Raw Capture 0" -v pixelformat=BA81
v4l2-ctl -z platform:vimc -d "Raw Capture 1" -v pixelformat=BA81

v4l2-compliance -m platform:vimc -s5
