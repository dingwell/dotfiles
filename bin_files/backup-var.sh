#!/bin/bash
# This script will attempt to mount a backup media and backup root

# Check if device is plugged in:
if [ -e /dev/disk/by-label/BAKVAR ]; then
  # MOUNT BACKUP DRIVE AND PREPARE DRIVES
  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : Mounting backup drive:"
  sync
  sleep 2
  mount /dev/disk/by-label/BAKVAR
  
  # BACKUP FILES AND FOLDERS
  # NOTE FOR MAKING RECOVERY SCRIPT, DON'T USE the option:
  # "--delete-excluded" option for recovery (unless
  # followed by recovery scripts which completely restore
  # the excluded directories!)
  #rsync -ahvv --delete --delete-excluded --delete-after \
  rsync -ahvv --delete-during --delete-excluded         \
    --exclude '/log'                                    \
    /var /mnt/BACKUP/VAR/
  
  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : Backup of /var completed, unmounting external drive:"
  # WRITE ALL CHANGES TO DISK AND UNMOUNT BACKUP DRIVE
  sync
  sleep 2
  umount /mnt/BACKUP/VAR

  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : /var backup routine completed"
else
  DATE=$(date +"%Y-%m-%d %T")
  echo "$DATE : Backup drive not found, aborting"
fi
