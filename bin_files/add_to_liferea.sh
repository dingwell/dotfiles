#!/bin/bash
# Quick wrapper for adding RSS-feeds to liferea (from e.g. firefox)

liferea -a $@ && {
  notify-send -u normal -t 5000 "add_to_liferea.sh" "RSS feed added to liferea"
}

xdotool windowactive `xdotool search --pid $(pgrep liferea) `
 
