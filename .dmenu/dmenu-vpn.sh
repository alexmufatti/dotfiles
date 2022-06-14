#!/bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

FULL_FILES=`find /home/mua/Documents/OpenVPN -maxdepth 2 -name \*.ovpn`

FILES=""
FOLDERS=""

for i in $FULL_FILES; do
  FILES=$FILES"${basename $i}'\n'
  FOLDERS+=`dirname $i`
done

SELECTION=`echo $FILES | rofi -dmenu`

echo $SELECTION

IFS=$SAVEIFS
