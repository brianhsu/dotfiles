#!/bin/sh
xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate right --rate 144
~/.config/scripts/sound/outputToRightMonitor.sh
sleep 2
~/.config/scripts/polybar/restart.sh
~/.config/scripts/conky/restart.sh
