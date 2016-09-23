# dotfiles

## Install instructions:
From root directory of dotfiles, run **./install.sh**
The install script will create a backup folder under **$HOME** named
**backup[DATE]**.
All dotfiles, which will be replaced by the install script, are first moved 
to the backup directory.
Symlinks will be deleted, not moved (since the target file should be safely
stored somewhere else).
Do *NOT* delete the root directory of dotfiles after installation!
The files are only linked and the originals must be kept for the setup to work.

## Adding more files to the repository
* The **install.sh** script will scan the contents of **./files.**,
  backup corresponding files/directories under **$HOME**
  and replace them with symlinks.
* Configuration files stored under **$HOME/.config/** are treated separately.
  Corresponding files should be placed in the config\_files directory,
  following the same folder structure as under **$HOME/.config**.
  Many files under **$HOME/.config/** are specific to the installed versions
  of software packages;
  therefore, the install script will only replace specific files
  (not entire directories).
  *Only include files that are safe to share between different
  versions of software to **config_files/** *
* Some configuration files are stored under **$HOME/.local**.
  **dotfiles** manages these files using the same rules as for
  **$HOME/.config**.
  Add files to **$HOME/.local** by adding corresponding files to
  **local\_files/**
