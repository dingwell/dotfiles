#!/bin/bash
# I use this from my data drive (~/data/FLX01) to check for output files with too
# few record entries which may end up on my desktop after sloppy crash handling.
# It's probably good to sort these out before the post processing, I think the post 
# processor should detect them, but I'm not sure, it was a while ago since I wrote it
# and it could simple end with a long run crashing after a couple of hours which is not 
# desireable, even though it's better than letting these values seep through and mess with
# the final result.
BAD_FILES_DETECTED=false
mv log.txt log.txt.old

echo "Checking will soon begin in 3 s, output dumped to both shell and log.txt"
sleep 3
for i in flxout_d02_*_VEI*_P*.nc; do
  N=$(ncdump -h $i|grep "Time ="|grep -o "[0-9][0-9]")
  echo "$i has $N records" >> log.txt
  echo "$i has $N records"
  #if (( "$N" < "96" )); then
  if [ "$N" -lt "96" ]; then
    echo "!!! Too few records detected !!!" >> log.txt
    echo "!!! Too few records detected !!!"
    BAD_FILES_DETECTED=true
  elif [ "$N" -gt "96" ]; then
    echo "!!! Too many records detected !!!" >> log.txt
    echo "!!! Too many records detected !!!"
    BAD_FILES_DETECTED=true
  fi
done
if $BAD_FILES_DETECTED; then
  echo "One or several bad files detected"
  echo "You can use the following commands to move the files to the backup folder:"
  echo 'mv -v $(grep '"'!!!'"' -B 1 log.txt |grep flxout|sed '"'"'s/ .*//'"'"') bak/'
  echo "Also, be careful when setting up the post processor as we now have gaps in the time series!"
else
  echo "No bad files detected"
fi
notify-send -u normal -t 5000 "check_missing_record.sh" "Script finished succesfully"
