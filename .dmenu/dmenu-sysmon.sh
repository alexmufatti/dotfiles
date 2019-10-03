#!/bin/bash
#  ____ _____ 
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/ 
# |____/ |_| 
#
# Dmenu script for launching system monitoring programs.


declare -a options=(" htop 
 glances 
 gtop 
 iftop 
 iotop 
 iptraf-ng 
 nmon 
 s-tui 
 quit ")

choice=$(echo -e "${options[@]}" | dmenu -l -i -p 'System monitors: ')

	if [ "$choice" == ' quit ' ]; then
		echo "Program terminated."
	fi
	if [ "$choice" == ' htop ' ]; then
        exec termite -e htop
	fi
	if [ "$choice" == ' glances ' ]; then
        exec termite -e glances
	fi
	if [ "$choice" == ' gtop ' ]; then
        exec termite -e gtop
	fi
	if [ "$choice" == ' iftop ' ]; then
        exec termite -e gksu iftop
	fi
	if [ "$choice" == ' iotop ' ]; then
        exec termite -e gksu iotop
	fi
	if [ "$choice" == ' iptraf-ng ' ]; then
        exec termite -e gksu iptraf-ng
	fi
	if [ "$choice" == ' nmon ' ]; then
        exec termite -e nmon
	fi
	if [ "$choice" == ' s-tui ' ]; then
        exec termite -e s-tui
	fi
