#!/bin/bash
# This script will be run regularly as a cronjob to recieve output
# data from WRF runs on UPPMAX.  If this is to work it requires the
# ssh directory uppmax to be mounted and the external data storage 
# to be connected and mounted.
# 
# Supports up to three domains
# Will not move the latest output file (for each domain)
# since this file could contain unfinished data

set -e

LOCAL_DATA_ROOT=/mnt/WRF01
SOURCE=/glob/adam/MET_FINISHED

#echo "data retrieval deactivated, edit script to use"
#exit
if [ "$PS1" ]; then
  /usr/bin/keychain ~/.ssh/id_rsa
  source ~/.keychain/yourhostname-sh
fi

for N in 1 2 3
do
  # List all files (except last) for current domain:
  LIST=$(ssh tintin 'ls '"$SOURCE"'/wrfout_d0'${N}'_*' | sed '$ d')

  for i in $LIST  # For each file in list
  do
    # Get filename and destination directory:
    FILE=$(echo $i|grep -o wrfout.*)
    SUBDIR=$(echo $i|grep -o '[0-9]*-[0-9-]*' |sed 's|-|/|g')
    DEST=$LOCAL_DATA_ROOT/$SUBDIR

    # Show results:
    #echo $DEST
    #echo $FILE
    #echo $DEST/$FILE

    # Move the file:
    #mv $i $DEST/$FILE || echo "Failed, email alarm should be set up"
    rsync -hz --progress tintin:"$i" $DEST && ssh tintin 'rm -v '"$i" || exit 1
  done
done
notify-send -u normal -t 5000 "retrieve_wrf_data.sh" "Script finished succesfully"
