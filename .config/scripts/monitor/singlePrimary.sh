#!/bin/sh
xrandr --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --off
~/.config/scripts/sound/outputToLeftMonitor.sh
sleep 2
~/.config/scripts/polybar/restart.sh
~/.config/scripts/conky/restart.sh
