#!/bin/bash

declare -a options=("bash 
 i3 
 zsh
 vim
 termite 
 quit ")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit a config file: ')

	if [ "$choice" == ' quit ' ]; then
		echo "Program terminated."
	fi
	if [ "$choice" == ' awesome ' ]; then
        exec termite -e "vim $HOME/.config/awesome/rc.lua"
	fi
	if [ "$choice" == ' bash ' ]; then
        exec termite -e "vim $HOME/.bashrc"
	fi
	if [ "$choice" == ' i3 ' ]; then
        exec termite -e "vim $HOME/.config/i3/config"
	fi
	if [ "$choice" == ' termite ' ]; then
        exec termite -e "vim $HOME/.config/termite/config"
	fi
	if [ "$choice" == ' zsh ' ]; then
        exec termite -e "vim $HOME/.zshrc"
	fi
	if [ "$choice" == ' vim ' ]; then
        exec termite -e "vim $HOME/.vimrc"
	fi
