#!/bin/bash

DEST="$HOME/SynologyDrive/Documents/Documenti Personali/Unico"

function rename_and_move () {
  YEAR=`echo "$1" | cut -c 1-4`
  [[ ! -f "$DEST/$YEAR" ]] && mkdir -p "$DEST/$YEAR" 
  mv "$1" "$DEST/$YEAR/$(basename $1)-testcamp.pdf"
}

FILE=$1

if [[ ! -f $FILE ]] || [[ $FILE != *"spese mediche"* ]]; then echo -ne "N"; exit 0;fi

rename_and_move "$FILE"
echo -ne "Y"
