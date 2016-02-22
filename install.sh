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

# Start with main dotfiles (directly under $HOME)
SUBDIR=files
FILES=$(ls $SUBDIR|grep -v '~'$) # list all files not ending with '~'

for i in $FILES; do
  # Backup original file (if it exists)
  FILE_ORIG="$HOME/.$i"
  if [ -e "$FILE_ORIG" ]; then	# File exists (as file or directory)
    mv -vi "$FILE_ORIG" "$BAKDIR/"
  elif [ -L "$FILE_ORIG" ]; then  # File is a symbolic link
    rm -v "$FILE_ORIG"
  fi
  # Create a link to the file in the repository
  ln -sv $WORKDIR/$SUBDIR/$i "$FILE_ORIG"
done

# For files under ./config -- play it safe -- don't link entire directories
# stick with files!
SUBDIR=config_files
if [ -d "$SUBDIR" ]; then
  echo "Working with $HOME/.config, I'll try to be careful!"
  echo "STILL TESTING!"

  # List all files under any level of sub-directories to $SUBDIR
  FILES=$(cd $SUBDIR && find * -type f)

  for i in $FILES; do
    FILE_ORIG="$HOME/.config/$i"  # Get target file+path

    # Backup target file (if it already exists):
    if [ -f "$FILE_ORIG" ]; then  # Target exists as file
      SUBDIR_BAK=$(dirname $i)
      mkdir -vp "$BAKDIR/.config/$SUBDIR_BAK"
      mv -v $FILE_ORIG "$BAKDIR/.config/$SUBDIR_BAK/"
    elif [ -L "$FILE_ORIG" ]; then # Target exists as link
      rm -v $FILE_ORIG
    fi

    ln -sv $WORKDIR/$SUBDIR/$i "$FILE_ORIG"
  done
else
  echo "No directory named '$SUBDIR', good, I will not do anything with '$HOME/.config'"
fi
