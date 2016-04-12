#!/bin/bash
# This script will backup original dot-files in the home directory.
# It then creates symlinks to all dot-files in the 'files' directory. 
# Files in the 'files' directory should not have a leading '.' as this
# will be added automatically when linking.
# (This is in order to keep the files "visible" in the working directory)

#cd files

WORKDIR=$(pwd)

# Create a directory for backing up old dotfiles
DATE=$(date "+%Y-%m-%d_%H:%M:%S")
BAKDIR="$HOME/dotfiles_$DATE"
echo "Creating backup directory: '$BAKDIR'"
mkdir $BAKDIR

# Global variables
export WORKDIR BAKDIR

# Two methods to install: careless and cautious
careless_install(){
  # Will replace entire directories 
  local DIR=$1

  local FILES=$(ls $DIR|grep -v '~'$) # list all files not ending with '~'

  for i in $FILES; do
    # Backup original file (if it exists)
    local FILE_ORIG="$HOME/.$i"
    if [ -e "$FILE_ORIG" ]; then	# File exists (as file or directory)
      mv -vi "$FILE_ORIG" "$BAKDIR/"
    elif [ -L "$FILE_ORIG" ]; then  # File is a symbolic link
      rm -v "$FILE_ORIG"
    fi
    # Create a link to the file in the repository
    ln -sv $WORKDIR/$DIR/$i "$FILE_ORIG"
  done
}

cautious_install(){
  # Will only replace files within directories, not entire directories
  local DIR_IN=$1
  local DIR_OUT=".$(echo "$DIR_IN"|sed 's/_files$//')"
  if [ -d "$DIR_IN" ]; then
    echo "Working with $HOME/$DIR_OUT, I'll try to be careful!"
    echo "STILL TESTING!"

    # List all files under any level of sub-directories to $SUBDIR
    local FILES=$(cd $DIR_IN && find * -type f)

    for i in $FILES; do
      local FILE_ORIG="$HOME/$DIR_OUT/$i"  # Get target file+path

      # Ensure that target directory exists:
      CONFIG_DIR=".$DIR_IN/$(dirname $i)"  # Path relative to ~ or backup root
      if [[ -d $HOME/$CONFIG_DIR ]]; then # Directory does not exist
        mkdir -vp "$HOME/$CONFIG_DIR"
      fi

      # Backup target file (if needed):
      if [[ -f $FILE_ORIG ]]; then  # Target exists as file
        mkdir -vp "$BAKDIR/$CONFIG_DIR"
        mv -v $FILE_ORIG "$BAKDIR/$CONFIG_DIR/"
      elif [[ -L $FILE_ORIG ]]; then # Target exists as link
        rm -v $FILE_ORIG
      fi

      ln -sv $WORKDIR/$DIR_IN/$i "$FILE_ORIG"
    done
  else
    echo "No directory named '$DIR_IN', good, I will not do anything with '$HOME/$DIR_OUT'"
  fi
}

# Start with main dotfiles (directly under $HOME)
SUBDIR=files
careless_install "$SUBDIR"

# For files under ./config -- play it safe -- don't link entire directories
# stick with files!
SUBDIR=config_files
cautious_install "$SUBDIR"

# For files under ./local -- play it safe:
SUBDIR=local_files
cautious_install "$SUBDIR"

