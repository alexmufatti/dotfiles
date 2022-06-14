#!/bin/bash
full_text="No data!"
d=$(curl --silent https://www.montalbettisrl.com/restapi.php | jq -r ".date")
full_text="No data!"
if [ -n "$d" ]
then
  d1=$(date -d "$d UTC" +%s)
  d2=$(date +%s)
  days="$(( (d2 - d1) / 86400 ))"
  minutes="$((((d2 - d1) % 86400)/3600 ))"
  full_text="${days}d ${minutes}h"
fi

echo "$full_text"
