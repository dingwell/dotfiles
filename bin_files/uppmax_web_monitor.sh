#!/bin/bash

# UPPMAX START PAGE
SITE=http://www.uppmax.uu.se/

# GET UPPMAX STATUS ELEMENT
LINE=$(curl -s $SITE |grep Kalkyl |grep Used)

# EXTRACT INFORMATION
# Only interested in first part (KALKYL)
KALKYL=$(echo $LINE|sed 's/.*\(Kalkyl.*\)<h4>Tintin.*/\1/')

# Get no. of CPU's in use per cluster (1st should be Kalkyl)
AVAIL=$(echo $KALKYL|sed 's/.*Total\: //'|sed 's/ CPU.*//')

# Get load bar
BAR=$(echo $KALKYL|sed 's/.*width://'|sed 's/px.*//')

# Get no. of pending jobs
PENDING=$(echo $KALKYL|sed 's/.*Pending: //'|sed 's/<.*//')

echo $BAR
echo -e "Queue:\t$PENDING"
echo -e "Load:\t$AVAIL cores"
echo -e "     \t$((100*$AVAIL))%"
