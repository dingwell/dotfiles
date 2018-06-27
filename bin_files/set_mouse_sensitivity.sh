#!/bin/bash

MNAME="Areson USB Device"
echo "set_mouse_sensitivity.sh: Setting mouse sensitivity for device: $MNAME"

# Find matching devices:
DEVICES=$(xinput --list --short|grep "$MNAME"|sed 's/.*id=\([0-9][0-9]*\)\s.*/\1/')

for d in $DEVICES; do
  xinput --set-prop $d "Device Accel Constant Deceleration" 3.2
  xinput --set-prop $d "Evdev Wheel Emulation Inertia" 1
  xinput --set-prop $d "Evdev Wheel Emulation Timeout" 2000
done
