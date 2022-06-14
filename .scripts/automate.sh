#!/bin/bash

for i in *; do
  echo -ne "Testing $i:"
  for s in $HOME/.scripts/automation.d/*.sh; do
      echo -ne "$(basename $s) ("
    $s "$i"
    echo -ne "), "
  done
  echo -ne "\n"
done



