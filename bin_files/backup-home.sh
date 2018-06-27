#!/bin/bash
# This script will attempt to mount a backup media and backup home

# Check if device is plugged in:
if [ -e /dev/disk/by-label/BAKHOME ]; then
  # MOUNT BACKUP DRIVE AND PREPARE DRIVES
  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : Mounting backup drive:"
  sync
  sleep 2
  mount /dev/disk/by-label/BAKHOME
  
  # BACKUP FILES AND FOLDERS
  rsync -ahvv --delete-during --delete-excluded \
    /home/ /mnt/BACKUP/HOME/
  
  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : Backup of /home completed, unmounting external drive:"
  # WRITE ALL CHANGES TO DISK AND UNMOUNT BACKUP DRIVE
  sync
  sleep 2
  umount /mnt/BACKUP/HOME

  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : /home folder backup routine completed"
else
  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : Backup drive not found, aborting"
fi

