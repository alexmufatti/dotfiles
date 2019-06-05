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

echo "Mounting share"
mount -t cifs //rico/home "$TMP" -o credentials=/root/.ricopass,uid=$(id -u),gid=$(id -g)

if [ "$1" = "full" ] || [ ! -f $TMP/backup/linux/$SNAR ]
  then
      read
  echo "Removing old backups"
  rm -rf $TMP/backup/linux/*
  echo "Preparing full backup"
  tar --exclude-from=.backupignore -czg $TMP/backup/linux/$SNAR -f "$TMP/backup/linux/full-$TAR" $FOLDER /etc
  echo "Backup size: $(stat --printf="%s" $TMP/backup/linux/full-$TAR)"
else
  echo "Preparing incremental backup"
  tar --exclude-from=.backupignore -czg $TMP/backup/linux/$SNAR -f "$TMP/backup/linux/incr-$TAR" $FOLDER /etc
  echo "Backup size: $(stat --printf="%s" $TMP/backup/linux/incr-$TAR)"
fi

chown mua:mua $TMP/backup/linux/*
echo "Unmounting share"
umount "$TMP"
echo "Remving temp dir"
rmdir $TMP

