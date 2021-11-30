#!/bin/bash
pkill play
pkill pulseaudio
/usr/bin/pulseaudio --start --log-target=syslog
play -n > /dev/null
