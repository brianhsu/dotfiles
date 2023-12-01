#!/bin/bash
# If remontoire is running, kill it.  Otherwise start it.

remontoire_PID=$(pidof remontoire)

if [ -z "$remontoire_PID" ]; then
    remontoire -s $(printenv I3SOCK) -t ~/.config/remontoire/style.css &
else
    kill $remontoire_PID
fi
