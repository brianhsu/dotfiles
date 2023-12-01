#!/bin/bash
killall -9 picom

while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

picom --config ~/.config/picom/picom.conf &
