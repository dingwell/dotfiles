#!/bin/bash
# Usage:
#
#  run_once.sh [COMMAND]
#
#  run_once.sh will check if there is a running process
#  matching the command/application name, if not the command
#  will be run
pgrep $@ > /dev/null || ($@ &)