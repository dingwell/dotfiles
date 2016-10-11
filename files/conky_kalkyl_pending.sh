#!/bin/bash

# UPPMAX START PAGE
SITE=http://www.uppmax.uu.se/

# GET UPPMAX STATUS ELEMENT
LINE=$(curl -s $SITE |grep Kalkyl |grep Used)

# EXTRACT INFORMATION
# Only interested in first part (KALKYL)
KALKYL=$(echo $LINE|sed 's/.*\(Kalkyl.*\)<h4>Tintin.*/\1/')

# Get no. of pending jobs
PENDING=$(echo $KALKYL|sed 's/.*Pending: //'|sed 's/<.*//')

# Write output:
echo $PENDING
