#!/bin/bash

#CHOICE=`zenity --width 300 --height 300 --list --text="電源選項" --column "動作" "關機" "暫停" "重啟" "登出"`
CHOICE=$(zenity --info --no-wrap \
        --icon-name dialog-question \
        --title '電源選項' \
        --text '請選擇要做的動作' \
        --ok-label "取消" \
        --extra-button "鎖定"  \
        --extra-button "登出" \
        --extra-button "暫停" \
        --extra-button "重啟" \
        --extra-button "關機")

case "$CHOICE" in
    鎖定)
        xflock4
        ;;
    登出)
        i3-msg exit
        ;;
    暫停)
        xflock4 && loginctl suspend
        ;;
    重啟)
        loginctl reboot
        ;;
    關機)
        loginctl poweroff
        ;;
esac

