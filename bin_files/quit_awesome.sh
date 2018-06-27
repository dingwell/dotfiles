#!/bin/bash
# This script can be called by the window manager
# (or desktop environment) at exit to run some 
# user defined commands
#
# eg. when using the awesome wm, put
#   awesome.add_signal("exit",function() awful.util.spawn("quit_awesome.sh") end)
# in your rc.lua to call this script on exit.

STR_header="quit_awesome.sh"
#set -e

# OBSOLETE FUNCTION -- REMOVE IF "grace_killer" DOES ITS JOB:
wait_for_finish () {
  PID=$1
  i=0     # iteration count
  N=10    # Max number of iterations
  dt=3    # Sleep time at end of each iteration (s)
  while [ $i -lt $N ]; do
    sleep $dt
    if ! ps -p >&-; then  # process has ended
      #notify-send -u normal -t 3000 "$STR_header" "Success!"
      return 0
    fi
    let i=i+1
  done
  # If we didn't exit the function from the loop, the process is still running!
  #notify-send -u normal -t 3000 "$STR_header" "Fail to terminate jj"
  return 1
}

# OBSOLETE FUNCTION -- REMOVE IF "grace_killer" DOES ITS JOB:
safekill () {
  # Attempts to kill a bunch of programs, will notify if it fails
  # Input is a list of space separated process names (executable names)
  LIST=$@ 
  ELIST=$(echo $LIST|sed 's/ /|/g') # used for regex in egrep
  # Tell programs to quit and wait until all programs are killed:
  # We don't want to wait forever (which we could if killall fails)
  # so we run killall in the background and use our fail-safe function
  # to assign a maximum waiting time and tell is things went well or not
  killall -w $LIST &
  PID_KILL=$!
  if wait_for_finish $PID_KILL; then
    notify-send -u normal -t 3000 "$STR_header" "Success!"
    return 0
  else
    # killall function probably failed, so stop it:
    kill -9 $PID_KILL
    # Create a list of all programs we didn't manage to kill:
    STILL_RUNNING=$(ps x|egrep "$ELIST"\
      |head -n-1|sed '/pgrep/d'\
      |sed 's; \([0-9]*\).*/;\1 ;')
    # What the above lines do:
    # 1) Get a list of executables which still have processes running
    # 2) Filter out processes originating from egrep
    # 3) Remove excessive info and keep only PID and executable name
    MSG="Failed to terminate:\n$STILL_RUNNING\n\nLogout should be terminated!"
    notify-send -u critical "$STR_header" "$MSG"
    return 1
  fi

}

grace_killer () {
  # Looks for all windows managed by the current window manager and attempts
  # to gracefully kill them
  LIST_OF_WINDOWS=$(wmctrl -lp) # list windows by: window_id workspace pid HOSTNAME WM_NAME

  # Extract list of window IDs:
  LIST_OF_WID=$(echo -e $LIST_OF_WINDOWS|egrep -o "0x[0-9a-z]*")

  # Extract list of process IDs:
  LIST_OF_PID=$(echo -e "$LIST_OF_WINDOWS"\
    |sed 's/\s*'"$HOSTNAME"'.*//'\
    |sed 's/.*\s//'\
    |egrep -o "[1-9][0-9]*" )
  # What ^this^ does:
  #   1) Removes HOSTNAME and WM_NAME (including the white spaces in front of HOSTNAME)
  #   2) Removes anything before the last remaing whitespace (ie window_id and workspace)
  #   3) Filters out bad exceptions, eg mono-programs and conky panels have no PID of
  #      their own and thus they have PID=0, mono-programs also have no hostname, making it
  #      even messier...
  #      What the last line does is remove any PID that does not begin with a non-zero digit

  # We now need to add some special cases of PIDs to the list
  # (the ones we didn't get from "wmctrl -lp")
  LIST_OF_PID="$(echo $LIST_OF_PID) $(pidof conky) $(pidof mono)"

  # Cycle through list of windows and send a friendly "would you please die"-command:
  for i in $LIST_OF_WINDOWS; do
    wmctrl -i -c $i
  done
  
  # The applications should now know that they should shut down, but it might take
  # some time and some programs might prompt us with save dialogs or some such
  # Therefore, well give it some time and wait for everything to settle in before
  # moving on.  If it takes too long time -- abort and notify the user.
  i=0   # Iteration counter
  N=30  # Max number of iterations
  dt=1  # Time to wait before each iteration (seconds) (max wait time = N*dt)

  while [ $i -lt $N ]; do
    sleep $dt
    if ! ps $LIST_OF_PID>&-; then  # process has ended
      return 0
    fi
    let i=i+1
  done

  # Notify user that shutdown of programs has failed:
  ELIST_OF_PID="$(echo $LIST_OF_PID|sed 's/ /|/g')" # For use in regex "or"
  STILL_RUNNING=$(ps $LIST_OF_PID|egrep "$ELIST_OF_PID") # List of still running processes
  MSG="Failed to terminate:\n$STILL_RUNNING"
  notify-send -u critical "$STR_header" "$MSG"
  return 1
}

# Attempt to shut down 
notify-send -u normal -t 3000 "$STR_header" "Sending exit command to selected programs"
#OLD:
# First kill command (stuff that we can kill without any problem)
#LIST="octave tomboy firefox ubuntuone-control-panel-qt vim"
#safekill $LIST || exit  # exit if it fails
# Second kill command (stuff that requires second kill(?) or must be killed after first list(?))
# (I wonder if this is necessary anymore...)
#LIST="tomboy sakura"    # exit if it fails
#safekill $LIST || exit

#NEW:
# Special case 1: tomboy will only minimize to tray if open
killall tomboy
# Special case 2: if hamster time tracker is running, tell it to stop tracking:
hamster-cli stop || echo "skipping hamster"
# Attempt to shutdow applications running under the current WM:
grace_killer || {
  notify-send -u urgent "$STR_header" "Shutdown cancelled"
  exit 1
}

# Clean up some other stuff:
notify-send -u normal -t 3000 "$STR_header" "Removing tomboy lock"
rm ~/private/tomboy/lock

notify-send -u normal -t 3000 "$STR_header" "Unmounting encrypted FS"
fusermount -u  ~/private

notify-send -u normal -t 3000 "$STR_header" "Exit call sent to WM\n \
  when notification closes"
sleep 3
echo 'awesome.quit()' | awesome-client

# exit script
exit 0
