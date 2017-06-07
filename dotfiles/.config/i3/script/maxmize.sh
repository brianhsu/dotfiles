#!/bin/bash
SCRIPT_DIR=$(dirname $0)
WIN_ID=$(xdotool getwindowfocus)

SIZE=$($SCRIPT_DIR/windowinfo.py size 2>/dev/null)
POSITION=$($SCRIPT_DIR/windowinfo.py position 2>/dev/null)

xdotool windowsize $WIN_ID $SIZE
xdotool windowmove $WIN_ID $POSITION
