#!/bin/bash
# Script for testing rc.lua configurations (AWM) in virtual Xscreen
Xephyr -ac -br -noreset -screen 800x600 :1 &
sleep 1
DISPLAY=:1.0 awesome

