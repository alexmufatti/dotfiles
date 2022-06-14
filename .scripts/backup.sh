#!/bin/bash

LANG=en-US
TMP=$(mktemp -d)
DATETIME=$(LANG=en-US date +%F_%X)
FILE=home
SNAR=${FILE}.snar
TAR=${FILE}-${DATETIME}.tar.gz
FOLDER=/home/mua

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [[ $(arp 192.168.252.254) != *"00:11:32:3f:8c:53"* ]]
  then echo "Not in out home network"
  exit 
fi

echo "Mounting share"
mount -t cifs //rico/home "$TMP" -o credentials=/root/.ricopass,uid=$(id -u),gid=$(id -g)

if [ "$1" = "full" ] || [ ! -f $TMP/backup/linux/current/$SNAR ]
  then
  echo "Removing old backups"
  rm -rf $TMP/backup/linux/old/*
  mv $TMP/backup/linux/current/* $TMP/backup/linux/old/
  echo "Preparing full backup"
  tar --exclude-from=.backupignore -czg $TMP/backup/linux/current/$SNAR -f "$TMP/backup/linux/current/full-$TAR" $FOLDER /etc
  echo "Backup size: $(stat --printf="%s" $TMP/backup/linux/current/full-$TAR)"
else
  echo "Preparing incremental backup"
  tar --exclude-from=.backupignore -czg $TMP/backup/linux/current/$SNAR -f "$TMP/backup/linux/current/incr-$TAR" $FOLDER /etc
  echo "Backup size: $(stat --printf="%s" $TMP/backup/linux/current/incr-$TAR)"
fi

chown mua:mua $TMP/backup/linux/current/*
echo "Unmounting share"
umount "$TMP"
echo "Remving temp dir"
rmdir $TMP

