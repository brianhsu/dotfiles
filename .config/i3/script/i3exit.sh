#!/bin/sh
lock() {
    xflock4
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        loginctl suspend
        ;;
    reboot)
        loginctl reboot
        ;;
    shutdown)
        loginctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
        exit 2
esac
exit 0
