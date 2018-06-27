#!/bin/bash
#
# This script will wait for a given process to end and then run a given command.
# Usage:
#   start_at_exit.sh PNAME COMMAND
#
# Where:
#   PNAME   name of the process we are waiting for to end (as displayed by ps)
#   COMMAND the command that will be executed when no running process is detected anymore

PNAME=$1
COMMAND=$2

if [ "$#" -ne 2 ]; then
  echo "Number of arguments are $#, expected 2"
  exit 10
fi

echo "Waiting for all processes matching pattern '$PNAME' to finish..."
while [ ! -z "$(ps -A|grep $PNAME)" ]; do
  sleep 10;
done

STR="No more processes detected after $SECONDS s, will now execute command:\n$COMMAND"
echo -e $STR
notify-send -u normal "start_at_exit.sh" "$STR"

exec $COMMAND
