#!/bin/bash

if [ ! -d "/Volumes/Accounting_fables" ]; then
	sudo mkdir /Volumes/Accounting_fables
fi

sudo mount_smbfs //'fables;mua'@192.168.5.2/Accounting /Volumes/Accounting_fables/

if [ $? = 0 ]; then
	sudo rsync -avz --iconv=utf-8-mac,utf-8 /Volumes/Accounting_fables/A2015 /Users/mua/Documents/Accounting_fables/
else
	echo "No connection with server"
fi

sudo chown -R mua:staff /Users/mua/Documents/Accounting_fables

sudo umount /Volumes/Accounting_fables
