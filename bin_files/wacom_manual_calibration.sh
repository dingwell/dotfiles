#!/bin/bash

# Set calibration values here: 
# order: min_x, min_y, max_x, max_y
AREA_NORMAL="100 -70 27749 15527"
AREA_INVERTED="65 -29 27754 15564"
#AREA_LEFT="328 -37 27921 15685"
AREA_LEFT="$AREA_NORMAL"


current_orientation(){
    xrandr|grep " connected" |awk '{print $5}'
}

# Area: min_x, min_y, max_x, max_y

xsetwacom --set 11 "Area" 100 -70 27749 15527

case $( current_orientation ) in
  "(normal" )
    echo "Setting Wacom area to custom normal"
    xsetwacom --set 11 "Area" $AREA_NORMAL
  ;;
  "inverted" )
    echo "Setting Wacom area to custom inverted"
    xsetwacom --set 11 "Area" $AREA_INVERTED
  ;;
  "left")
    echo "Setting Wacom area to custom left"
    xsetwacom --set 11 "Area" $AREA_LEFT
  ;;
esac


