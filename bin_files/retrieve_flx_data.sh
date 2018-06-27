#!/bin/bash
# This script will be run regularly as a cronjob to recieve output
# data from WRF runs on UPPMAX.  If this is to work it requires the
# ssh directory uppmax to be mounted and the external data storage 
# to be connected and mounted.
# 
# Supports up to two domains
# Will not move the latest output file (for each domain)
# since this file could contain unfinished data

set -e

LOCAL_DATA_ROOT=/mnt/DATA/FLX01/
SOURCE=/glob/adam/FLX_FINISHED

#echo "PS1=$PS1"
#if [ "$PS1" ]; then
  #source ~/.profile
  #source ~/.bashrc
  #keychain --clear
  #ls "~/.keychain/" || echo "skip"
  #keychain ~/.ssh/id_rsa.uppmax
  #ls "~/.keychain/$HOSTNAME-sh"
  #source "~/.keychain/$HOSTNAME-sh"
  #echo "Sourced"
#fi

for N in 1 2  # Fixed domain 01 in v3.1 running on TINTIN
#for N in 2  # since domain 01 is messed up...
do
  # List all files (except last) for current domain:
  #LIST=$(ssh uppmax "$SOURCE/flxout_d0${N}_*" | sed '$ d')
  echo "Retrieving list of files"
  LIST=$(ssh tintin 'ls /glob/adam/FLX_FINISHED/flxout_d0'${N}'*' |head -n -48)
  #LIST=$(ssh tintin 'ls /glob/adam/FLX_FINISHED/flxout_d0'${N}'*' )
  # Note: the last 48 files are skipped, to make sure we don't try to copy files
  #       which are only partially complete.  (48=[P]*[VEI]*[HOUR]=3*4*4)

    #LIST=$(ssh uppmax 'ls '"$SOURCE"'/wrfout_d0'${N}'_*' | sed '$ d')

  echo "Copying files"
  for i in $LIST  # For each file in list
  do
    #echo $i
    scp tintin:"$i" "$LOCAL_DATA_ROOT" && ssh tintin "rm -v $i" || exit 1
  done
  #scp -v uppmax:/glob/adam/FLX_FINISHED/flxout_* $LOCAL_DATA_ROOT && ssh uppmax "rm -v /glob/adam/FLX_FINISHED/flxout_*"

    #echo "Checking if destination directory exists"
    #ls $DEST || {echo "missing, will attempt to create it now"; mkdir -p $DEST}
    echo "done"
    # Show results:
    #echo $DEST
    #echo $FILE
    #echo $DEST/$FILE

    # Move the file:
    #mv $i $DEST/$FILE || echo "Failed, email alarm should be set up"
  #done
done
notify-send -u normal -t 5000 "retrieve_flx_data.sh" "Script finished succesfully"
