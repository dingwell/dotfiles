#!/bin/bash
# This script will backup original dot-files in the home directory.
# It then creates symlinks to all dot-files in the 'files' directory. 
# Files in the 'files' directory should not have a leading '.' as this
# will be added automatically when linking.
# (This is in order to keep the files "visible" in the working directory)

#cd files

WORKDIR=$(pwd)
SUBDIR=files
FILES=$(ls $SUBDIR)

# Create a directory for backing up old dotfiles
DATE=$(date "+%Y-%m-%d_%H:%M:%S")
BAKDIR="$HOME/dotfiles_$DATE"
echo "Creating backup directory: '$BAKDIR'"
mkdir $BAKDIR

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
