#!/bin/bash
SERVICE="xfce4-appfinder"
if pgrep -x "$SERVICE" >/dev/null
then
    killall $SERVICE
else
    xfce4-appfinder -r --disable-server &
fi
