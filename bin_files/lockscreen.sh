#!/bin/bash
sleep 0.1 #This will somehow prevent xtrlock from crashing when run using a keyboard shortcut, wierd huh?

xtrlock #&> $HOME/log/xtrlock.log
