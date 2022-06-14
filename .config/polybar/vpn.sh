#!/bin/bash

connection=$(nmcli c show --active | grep -i VPN | awk '{print $1}')

if [ -n "$connection" ]; then
    echo "VPN $connection"
else 
    echo ""
fi
