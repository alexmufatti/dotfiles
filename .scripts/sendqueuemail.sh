#!/bin/sh

STATE=`nmcli networking connectivity`

if [ $STATE = 'full' ]
then
    /home/mua/.scripts/msmtp-runqueue.sh
    exit 0
fi
echo "No internet connection."
exit 0
