#!/bin/bash

# Script rotates screen 90deg on every run, and also rotates touchscreen and wacom input.
# In modes other than normal, touchpad is deactivated.

# AD: edit added manual screen calibration on each flip (use xinput_calibrator to
#     find appropriate settings)

current_orientation(){
    xrandr|grep " connected" |awk '{print $5}'
}
#orientation=`current_orientation`
case $( current_orientation ) in
    "(normal" )
        echo "Current layot is 'normal', switching to left"
        xrandr -o left
        xsetwacom set "Wacom ISDv4 EC Pen stylus" rotate ccw
        xsetwacom set "Wacom ISDv4 EC Pen eraser" rotate ccw
        synclient TouchpadOff=1
        #xinput set-prop --type=int --format=8 "ELAN Touchscreen" "Evdev Axes Swap" "1"
        #xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 1 0
        xinput set-prop "ELAN Touchscreen" "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
        #xsetwacom --set 11 "Area" -71 -31 27625 15633
        #xsetwacom --set 11 "Area" 201 79 27675 15687
        wacom_manual_calibration.sh
        onboard &
        TPYoga_PenInOut.sh &
        ;;
    "inverted" )
        # I have disabled right layout because I never use it...
        if true; then # Use this to switch back to normal
          echo "Current layot is 'inverted', switching to normal"
          xrandr -o normal
          xsetwacom set "Wacom ISDv4 EC Pen stylus" rotate none
          xsetwacom set "Wacom ISDv4 EC Pen eraser" rotate none
          synclient TouchpadOff=0
          xinput set-prop --type=int --format=8 "ELAN Touchscreen" "Evdev Axes Swap" "0"
          xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 0 0
          xinput set-prop "ELAN Touchscreen" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
          #xsetwacom --set 11 "Area" 102 -16 27749 15277 # use script instead:
          wacom_manual_calibration.sh
          killall onboard
          killall TPYoga_PenInOut.sh
        fi

        if false; then
          echo "Current layot is 'inverted', switching to right"
          xrandr -o right

          xsetwacom set "Wacom ISDv4 EC Pen stylus" rotate cw
          xsetwacom set "Wacom ISDv4 EC Pen eraser" rotate cw
          xinput set-prop --type=int --format=8 "ELAN Touchscreen" "Evdev Axes Swap" "1"
          #xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 0 1
          xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 1 0
          #xinput set-prop "ELAN Touchscreen" "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
          xsetwacom --set 11 "Area" 223 1 27833 15678
        fi
        ;;
    "right" )
        echo "Current layot is 'right', switching to normal"
        xrandr -o normal
        xsetwacom set "Wacom ISDv4 EC Pen stylus" rotate none
        xsetwacom set "Wacom ISDv4 EC Pen eraser" rotate none
        synclient TouchpadOff=0
        xinput set-prop --type=int --format=8 "ELAN Touchscreen" "Evdev Axes Swap" "0"
        xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 0 0
        xinput set-prop "ELAN Touchscreen" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
        #xsetwacom --set 11 "Area" 102 -16 27749 15277 # use script instead:
        wacom_manual_calibration.sh
        killall onboard
        killall TPYoga_PenInOut.sh
        ;;
    "left" )
        echo "Current layot is 'left', switching to inverted"
        xrandr -o inverted
        xsetwacom set "Wacom ISDv4 EC Pen stylus" rotate half
        xsetwacom set "Wacom ISDv4 EC Pen eraser" rotate half
        xinput set-prop --type=int --format=8 "ELAN Touchscreen" "Evdev Axes Swap" "0"
        #xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 1 1
        xinput set-prop "ELAN Touchscreen" "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
        wacom_manual_calibration.sh
        ;;
    * )
        synclient TouchpadOff=0
        echo "c est autre chose"
        current_orientation
        echo $orientation
        ;;
esac
