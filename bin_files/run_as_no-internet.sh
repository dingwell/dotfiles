#!/bin/bash
# Runs applications as group: "no-internet"
# Used this guide to prevent internet access for user "no-internet":
# http://ubuntuforums.org/showthread.php?t=1188099
GROUP=no-internet

sg $GROUP "$@"
