#!/bin/bash

SITE=celsius
#SITE=temperatur.nu

if [ $SITE == "celsius" ]; then
  # PAGE ADDRESS
  SITE=http://celsius.met.uu.se/uppsala/obs.htm

  # GET LINE WITH TEMP DATA
  LINE=$(curl -s $SITE|grep Temperature)

  # EXTRACT INFORMATION
  TEMP=$(echo $LINE|sed 's/.*Temperature:\s*//'|sed 's/\s*&.*//')
elif [ $SITE == "temperatur.nu" ]; then
  # PAGE ADDRESS
  SITE=http://www.temperatur.nu/uppsala.html

  # GET LINE WITH TEMP DATA
  LINE=$(curl -s $SITE|grep favoritTemp)

  # EXTRACT INFORMATION
  TEMP=$(echo $LINE|sed 's/.*Temp>//'|sed 's/\&.*//'|sed 's/,/./')
fi

# Write output:
echo $TEMP
