#!/bin/bash

# KALKYL has been taken out of service
LIST1=$(ssh triolith 'squeue -u $USER -ho "%.7i %.2t %.10j %.9L"')
LIST2=$(ssh rackham 'squeue -u $USER -ho "%.7i %.2t %.10j %.9L"')
LIST="$LIST1\n$LIST2"

# Running jobs
echo -e "$LIST"|grep " R " && echo "—————————————————————————————————"
# Pending jobs
echo -e "$LIST"|grep " PD" #| cut -c 1-10 #|sed 's/ PD//'
