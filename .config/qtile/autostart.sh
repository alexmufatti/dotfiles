#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
export QT_QPA_PLATFORMTHEME="qt5ct"
#run "xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal"
#run "xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 -    -primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
run "autorandr -c"
run "nm-applet"
run "pa-applet"
run "xfce4-power-manager"
run "blueman-applet"
# run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "/usr/lib/polkit-kde-authentication-agent-1"
run "/usr/lib/pam_kwallet_init"
run "numlockx on"
run "slack"
run "teams"
run "nextcloud"
run "xautolock -time 10 -locker ~/.scripts/blurlock"
run "dunst"
#run "conky -c $HOME/.config/awesome/system-overview"

#run applications from startup
#run "firefox"
#run "atom"
#run "dropbox"
#run "insync start"
#run "spotify"
