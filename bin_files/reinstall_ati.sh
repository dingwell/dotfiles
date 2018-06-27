#!/bin/bash
#sudo /usr/share/ati/fglrx-uninstall.sh  # (if it exists)
#sudo apt-get remove --purge fglrx*
#sudo apt-get remove --purge xserver-xorg-video-ati xserver-xorg-video-radeon 
#sudo apt-get install xserver-xorg-video-ati
sudo apt-get install --reinstall libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core
sudo dpkg-reconfigure xserver-xorg
