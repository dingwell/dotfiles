#!/bin/bash
# Script used to auto-start different applications depending on the current desktop environment

if [ $DESKTOP_SESSION == "kde-plasma" ]; then
  echo "KDE detected, launching KDE-specific apps"
  nm-applet &
  ubunutu-control-panel-qt --with-icon &
  yakuake &
elif [ $DESKTOP_SESSION == "ubuntu" ]; then
  echo "Unity detected, launching Unity specific apps"
  tilda &
else
  echo "Unknown desktop environment, do nothing"
fi
