#!/bin/bash

# Terminate already running bar instances
killall -9 polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

COUNTER=0
CURRENT_MONITOR=""
# Launch Polybar, using default config location ~/.config/polybar/config
for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$monitor polybar -c ~/.config/polybar/bottom.ini --reload mybar_${monitor} &
    MONITOR=$monitor polybar -c ~/.config/polybar/launcher.ini --reload launcher_${monitor} &
    MONITOR=$monitor polybar -c ~/.config/polybar/window.ini --reload window_${monitor} &
    MONITOR=$monitor polybar -c ~/.config/polybar/clock.ini --reload clock_${monitor} &
    CURRENT_MONITOR=$monitor
    COUNTER=$[$COUNTER +1]
done

echo "==========="
echo $COUNTER
echo "==========="

if [ "$COUNTER" -eq "1" ]; then
    MONITOR=$CURRENT_MONITOR polybar -c ~/.config/polybar/systray.ini --reload systray_${CURRENT_MONITOR} &
else
    MONITOR="DisplayPort-0" polybar -c ~/.config/polybar/systray.ini --reload systray_"DisplayPort-0" &
fi

