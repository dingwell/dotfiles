#!/bin/bash
# THIS SCRIPT HAS BEEN MARKED NOT EXCECUTABLE SINCE IT IS NOT UP
# TO DATE AND SHOULD NOT BE RUN BY MISTAKE WHETHER IT IS OR NOT.

if [ -d /media/Backup/adam ]; then
echo "Backup drive is mounted, restoring backup..."
rsync -ahv /media/Backup/adam/Documents/ /home/adam/Documents/
rsync -ahv /media/Backup/magnus /home/adam/magnus-filer
#rsync -ahv /medi
else
echo "Backup drive is not mounted, aborting."
fi

#rsync -ahv /media/
