#!/bin/bash

DESKTOP="acpi awesome encfs glm gvfs-gphoto2 gvfs-mtp luajit midori ninja openal pavucontrol physfs python2-gnomekeyring python2-xdg qt5-base qt5-tools sdl2_image sdl2_tff vicious xcompmgr xf86-synaptics-driver xfce4-power-manager xfce4-settings xfdesktop xorg-xbacklight "

APPLICATIONS="atril baobab bash-completion claws-mail cmake colordiff geany git gthumb inkscape kepassx2 sakura shotwell thunar xournal zim"

# NOTE: order matters for AUR_PACKS!
AUR_PACKS="arc-icon-theme cryptkeeper xinit-xsession solarus-git zsdx-git"

AUR_PATH="$HOME/source/aur"

# MISSING (not yet found) APPS:
# pybliographic screenruler xephyr XFCE

install_AUR(){
  # Takes 1 argument (package name)
  if [[ ! -d $AUR_PATH ]]; then
    mkdir -p $AUR_PATH
  fi

  export PACK_NAME=$1

  aur_error(){
    echo "installation of '$PACK_NAME' failed" 1>&2
  }

  echo "Fetching AUR-package '$PACK_NAME'"
  git clone https://aur.archlinux.org/${PACK_NAME}.git || {
    aur_error
    return 1
  }
 
  cd "$AUR_PATH/$PACK_NAME"

  echo "Building AUR-package '$PACK_NAME'"
  makepkg -s || {
    aur_error
    return 2
  }

  echo "Installing AUR-package '$PACK_NAME' (requesting root access)"
  pacman -U ${PACK_NAME}.tar.xz || {
    aur_error
    return 3
  }

  #echo "Cleaning up build-directory for AUR-package '$PACK_NAME'"
  #makepkg -c

  echo "Finished installing AUR-package '$PACK_NAME'"
}


echo "Installing desktop/system packages (requesting root access)"
sudo pacman -S $DESKTOP

echo "Installing other applications (requesting root access)"
pacman -S $APPLICATIONS

echo "Installing AUR packages (one by one)"
for i in $AUR_PACKS; do
  install_AUR $i
done
