#!/usr/bin/env bash

function main() {
    SOURCE=$(pw-record --list-targets | sed -n 's/^*.*"\(.*\)" prio=.*$/\1/p')
    SINK=$(pw-play --list-targets | sed -n 's/^*.*"\(.*\)" prio=.*$/\1/p')
    VOLUME=$(pamixer --get-volume-human)
    IS_MUTED=$(pactl list sinks | sed -n "/${SINK}/,/Mute/ s/Mute: \(yes\)/\1/p")
    
    action=$1
    if [ "${action}" == "up" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +10%
    elif [ "${action}" == "down" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -10%
    elif [ "${action}" == "mute" ]; then
        pamixer --toggle-mute
    else
      if [ "${IS_MUTED}" != "" ]; then
        echo " $(echo $SOURCE | awk '{print $1}') |  MUTED $( echo $SINK | awk '{print $1}')"
      else
        echo " $(echo $SOURCE | awk '{print $1}') |  $VOLUME $(echo $SINK | awk '{print $1}')"
      fi
    fi
}

main "$@"
