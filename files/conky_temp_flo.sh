#!/bin/bash
#SITE=celsius
SITE=temperatur.nu

if [ $SITE == "celsius" ]; then
  # PAGE ADDRESS
  SITE=http://save35.dyndns.org/last.htm

  # GET LINE WITH TEMP DATA
  LINE=$(curl -s $SITE|grep -A 1 Temperature|tail -n 1)

  # EXTRACT INFORMATION
  TEMP=$(echo $LINE|sed 's/.*">//'|sed 's/<.*//')
elif [ $SITE == "temperatur.nu" ]; then
  # PAGE ADDRESS
  SITE=http://www.temperatur.nu/flogsta.html

  # GET LINE WITH TEMP DATA
  LINE=$(curl -s $SITE|grep favoritTemp)

  # EXTRACT INFORMATION
  TEMP=$(echo $LINE|sed 's/.*Temp>//'|sed 's/\&.*//'|sed 's/,/./')
fi

# Write output:
echo $TEMP
