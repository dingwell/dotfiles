#!/bin/bash

exec_path=$(pwd)

cd $HOME
Xephyr -ac -br -noreset -screen 1024x768 :1.0 &
sleep 1
DISPLAY=:1.0 awesome -c .config/awesome/rc.lua

cd $exec_path
