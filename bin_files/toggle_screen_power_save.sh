#!/bin/bash
# Script will toggle DPMS settings using xset

# Check is DPMS is active:
#DPMSSTRING=$(xset -q | grep "DPMS is Enabled")
DPMSSTRING=$(xset -q | grep -q "DPMS is Enabled")
# If the string "DPMS is Enabled" is found, then $? -eq 0
# In that case we want to turn DPMS off

if [ $? -eq 0 ] ; then
  xset s 6000 s noblank -dpms
  #xset s 6000
  notify-send -u critical -t 3000 "Monitor power save mode is now Disabled"
  echo "Monitor power save mode is now Disabled"
else
  xset s 600 s blank +dpms
  notify-send -t 3000 "Monitor power save mode is now Enabled"
  echo "Monitor power save mode is now Enabled"
fi



