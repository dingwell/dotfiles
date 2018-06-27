#!/bin/bash
# This script will check which the SSID of the current WiFi network
# The address which is used by owncloud to connect to my home server
# will be updated depending on whether I'm connected to my home network
# or not
INTERFACE=wlan1   # Network interface to check for SSID
SSID=ADHe_FAT     # SSID of my home network
LAN_ADDRESS=192.168.1.100/owncloud        # Server address on my home network
WAN_ADDRESS=metnix.duckdns.org/owncloud   # Server address when connecting from the internet

PATH_OWNCLOUD="$HOME/.local/share/data/ownCloud"          # Path to owncloud configuration files
PATH_TEMPLATE="$PATH_OWNCLOUD/owncloud.cfg-template"  # Template configuration file (simply a copy of the config file)

set_address ()
{
  # Function to set the address used by owncloud-client to connect to my home server
  ADDRESS="$1"

  # Stop owncloud while updating config file
  killall owncloud

  # Update config file
  cat "$PATH_TEMPLATE" \
    | sed 's|\(url=https://\).*|\1'"$ADDRESS"'|'  \
    > $PATH_OWNCLOUD/owncloud.cfg

  # Start owncloud with new configurations
  owncloud &
  disown "%owncloud"
}


if [ $(iwlist $INTERFACE scanning|grep $SSID) ];then
  set_address "$LAN_ADDRESS"
else
  set_address "$WAN_ADDRESS"
fi
