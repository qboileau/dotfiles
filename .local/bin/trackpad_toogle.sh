#!/bin/bash
current=$(synclient -l | grep "TouchpadOff" | cut -d = -f 2)
if [ $current -eq 0 ] ; then
    synclient TouchpadOff=1
    notify-send "Touchpad" "Disable" -t 1000 -u low
else
    synclient TouchpadOff=0
    notify-send "Touchpad" "Enable" -t 1000 -u low
fi
