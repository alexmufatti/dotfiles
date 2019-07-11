#!/bin/bash

PINGS=2
TESTIP=1.1.1.1

while !( ping -c $PINGS $TESTIP >/dev/null 2>&1 ) do
   # echo "you are offline"
   sleep 10
done

~/Projects/outlook-linux-x64/outlook &> /dev/null &
