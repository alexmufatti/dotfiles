#!/bin/bash
TMP=$(mktemp -d)
FOLDER=$(LANG=en-US date +%u-%a)
sudo tar czvf /home/mua/.backup/etc.tar.gz /etc
sudo mount -t cifs //rico/home "$TMP" -o credentials=/root/.ricopass,uid=$(id -u),gid=$(id -g)
rsync -avzh --delete --no-links -s \
    --exclude='.local/share/JetBrains' \
    --exclude='Projects' \
    --exclude='SynologyDrive' \
    --exclude='Vms' \
    --exclude='tmp' \
    --exclude='Downloads' \
    --exclude='shared VM' \
    --exclude='.cache' \
    /home/mua/ "$TMP/backup/linux/$FOLDER"
sudo umount "$TMP"
rmdir $TMP
