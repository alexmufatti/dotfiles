#!/bin/bash

PAUSED=$(dunstctl is-paused)
if [[ $PAUSED == "true" ]] 
then
    dunstctl set-paused toggle
    notify-send "Notifications enabled"
else
    notify-send "Notifications disabled"
    sleep 1
    dunstctl close-all  
    dunstctl set-paused toggle
fi