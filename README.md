# dotfiles

## Install instructions:
From this directory, run _./install.sh_
The install script will create a backup folder under _$HOME_ named
_backup[DATE]_.
All original dotfile will be moved to the backup directory.
Symlinks will be deleted, not moved (since the target file should is safely
stored somewhere else).
Do *NOT* delete this directory after installation! the files are only linked
and the originals must be kept for the setup to work.

## Adding more files to the repository
The _install.sh_ script will scan the contents of _./files._ and create
corresponding symlinks under _$HOME_.
The _$HOME/.config_ directory could be added as any other file within
_./files._, however, this is not recommended since sharing application
settings between systems can be buggy. Some sub-directories to
_$HOME/.config_ are fairly safe. A good approach would be to manage _.config_
separately (i.e. create a separate folder next to _./files_) and only replace
individual sub-directories, known to be safe.
This would require some updates _./install.sh_.

