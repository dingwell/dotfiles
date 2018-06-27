#!/bin/bash
#
#Attempts to launch /media/adam/KeePass.exe
#

# Check which structure is used in /media
if [ -d /media/$USER ]; then
  # New/Ubuntu-style path
  KEEPASS=/media/$USER/KEEPER/KeePass/KeePass.exe
else
  # Old-style path
  KEEPASS=/media/KEEPER/KeePass/KeePass.exe
fi

if [ -e "$KEEPASS" ]; then
  if [ $(pgrep awesome) ]; then
    mono "$KEEPASS"
  else
    mono "$KEEPASS"
  fi
else
  TITLE="External KeePass"
  MSG="Couldn't find:\n$KEEPASS\nPlease ensure drive is mounted"
  notify-send -u critical -t 5000 -a "keepass2" \
  "$TITLE" "$MSG"
fi
