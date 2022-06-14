#!/bin/bash

HOME=/home/mua
echo "Starting backup" | tee $HOME/.rsync_backup/log-$(date +%u)
if [[ ! -d $HOME/.rsync_backup ]]
then
  mkdir $HOME/.rsync_backup
fi

if [[ -f $HOME/.rsync_backup/last_rsync && $(cat $HOME/.rsync_backup/last_rsync) == $(date +%F) ]]
then
  echo "backup has been already executed today" | tee $HOME/.rsync_backup/log-$(date +%u)
  exit 0
fi

if [[ $1 == "-p" ]]
then
  ping -c 1 192.168.252.254 > /dev/null
  if [[ $? != 0 ]]
  then 
    echo "Not in out home network (ping)" | tee $HOME/.rsync_backup/log-$(date +%u)
    exit 0
  fi
else
  if [[ $(arp 192.168.252.254) != *"00:11:32:3f:8c:53"* ]]
  then 
    echo "Not in out home network" | tee $HOME/.rsync_backup/log-$(date +%u)
    exit 0
  fi
fi



rsync --dry-run -r -t -p -o -g -x --delete -l -z -s -e ssh --exclude-from=/home/mua/.backupignore --log-file=$HOME/.rsync_backup/rsync-log-$(date +%u)  -h /home/mua mua@192.168.252.254::NetBackup/$(date +%u)/
if [ $? -ne 0 ]
then
  echo "Backup Error" | tee $HOME/.rsync_backup/log-$(date +%u)
else
  date +%F > $HOME/.rsync_backup/last_rsync
  echo "Backup ended" | tee $HOME/.rsync_backup/log-$(date +%u)
fi
