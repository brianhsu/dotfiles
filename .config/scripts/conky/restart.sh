#!/bin/bash
killall -9 conky
while pgrep -u $UID -x conky >/dev/null; do sleep 1; done
OUTPUTS=`i3-msg -t get_outputs`
echo $OUTPUTS
if [[ $OUTPUTS == *"DisplayPort-0"* ]]; then
  conky -c ~/.config/conky/vertical.lua &
fi

if [[ $OUTPUTS == *"HDMI-A-0"* ]]; then
  conky -c ~/.config/conky/horizontal.lua &
fi


