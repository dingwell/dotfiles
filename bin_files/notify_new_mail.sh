#!/bin/bash
# Script which can be run by the claws-mail notification plugin, when new email is recieved

#ICON=$HOME'/.icons/Drakfire\ Evolution\ Inverted\ Custom/scalable/apps/mail-inbox.png'

# Check where new mail was found:
# INBOX
new_INBOX=$(claws-mail --status INBOX | sed 's/ [0-9].*//') # delete all but first number
unread_INBOX=$(claws-mail --status INBOX | sed 's/.* \([0-9]*\) .*/\1/')    # Only keep second number
STR_INBOX=$( printf "\t\t%03d\t\t%03d" $new_INBOX $unread_INBOX )

# CNDS
new_CNDS=$(claws-mail --status CNDS | sed 's/ [0-9].*//') # delete all but first number
unread_CNDS=$(claws-mail --status CNDS | sed 's/.* \([0-9]*\) .*/\1/')    # Only keep second number
STR_CNDS=$( printf "\t\t%03d\t\t%03d" $new_CNDS $unread_CNDS )

# Geolist
new_Geolist=$(claws-mail --status Geolist | sed 's/ [0-9].*//') # delete all but first number
unread_Geolist=$(claws-mail --status Geolist | sed 's/.* \([0-9]*\) .*/\1/')    # Only keep second number
STR_Geolist=$( printf "\t\t%03d\t\t%03d" $new_Geolist $unread_Geolist )

# Metlist
new_Metlist=$(claws-mail --status Metlist | sed 's/ [0-9].*//') # delete all but first number
unread_Metlist=$(claws-mail --status Metlist | sed 's/.* \([0-9]*\) .*/\1/')    # Only keep second number
STR_Metlist=$( printf "\t\t%03d\t\t%03d" $new_Metlist $unread_Metlist )

# SLURM
new_SLURM=$(claws-mail --status SLURM | sed 's/ [0-9].*//') # delete all but first number
unread_SLURM=$(claws-mail --status SLURM | sed 's/.* \([0-9]*\) .*/\1/')    # Only keep second number
STR_SLURM=$( printf "\t\t%03d\t\t%03d" $new_SLURM $unread_SLURM )

STR_header=$( printf "Mail notice\tnew\t\tunread")
MESSAGE='INBOX:'$STR_INBOX'
CNDS:'$STR_CNDS'
Geolist:'$STR_Geolist'
Metlist:'$STR_Metlist'
SLURM:'$STR_SLURM

notify-send -u normal -t 5000 \
    -i /usr/share/pixmaps/claws-mail-64x64.png \
    "$STR_header" "$MESSAGE"
