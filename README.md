# dotfiles

## Install instructions:
From this directory, run **./install.sh**
The install script will create a backup folder under **$HOME** named
**backup[DATE]**.
All original dotfile will be moved to the backup directory.
Symlinks will be deleted, not moved (since the target file should is safely
stored somewhere else).
Do *NOT* delete this directory after installation! the files are only linked
and the originals must be kept for the setup to work.

## Adding more files to the repository
The **install.sh** script will scan the contents of **./files.** and create
corresponding symlinks under **$HOME**.
The **$HOME/.config** directory could be added as any other file within
**./files.**, however, this is not recommended since sharing application
settings between systems can be buggy. Some sub-directories to
**$HOME/.config** are fairly safe. A good approach would be to manage **.config**
separately (i.e. create a separate folder next to **./files**) and only replace
individual sub-directories, known to be safe.
This would require some updates **./install.sh**.

