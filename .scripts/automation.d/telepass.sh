#!/bin/bash

DEST="$HOME/SynologyDrive/Documents/Documenti Lavoro"

function rename_and_move () {
  DATA=`pdftotext "$1" - | awk '/DATA/ { getline; print $3 }'`
  YEAR=`echo $DATA | cut -d'-' -f 3`
  MONTH=`echo $DATA | cut -d'-' -f 2`
  DAY=`echo $DATA | cut -d'-' -f 1`
  [[ ! -f "$DEST/$YEAR/Spese/$MONTH" ]] && mkdir -p "$DEST/$YEAR/Spese/$MONTH" 
  mv $1 "$DEST/$YEAR/Spese/$MONTH/$YEAR-$MONTH-$DAY-telepass-testcamp.pdf"
}

FILE=$1


if [[ ! -f $FILE ]] || [[ ! ${FILE: -4} == ".pdf" ]]; then echo -ne "N"; exit 0;fi

MATCH=$(pdftotext "$FILE" - | grep TELEPASS)
if [ ! -z "$MATCH" ]; then
  rename_and_move "$FILE"
  echo -ne "Y"
else
    echo -ne "N"
fi
