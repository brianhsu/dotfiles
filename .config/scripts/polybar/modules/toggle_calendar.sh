#!/bin/bash
SERVICE="zenity"
if pgrep -x "$SERVICE" >/dev/null
then
    killall $SERVICE
else
    $SERVICE --calendar --title 月曆 &
fi
