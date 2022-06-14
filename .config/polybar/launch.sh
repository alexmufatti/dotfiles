#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')
# Launch bar1
if type "xrandr"; then
  PRIMARY=$(xrandr --query | grep " connected" |grep " primary" | cut -d" " -f1)
  OTHER=$(xrandr --query | grep " connected" |grep -v " primary" | cut -d" " -f1)

  MONITOR=$PRIMARY polybar --reload top &
  for m in $OTHER; do
    MONITOR=$m polybar --reload secondary &
  done
else
  polybar --reload top &
fi

echo "Bars launched..."
