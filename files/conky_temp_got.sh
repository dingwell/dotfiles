#!/bin/bash

# UPPMAX START PAGE
SITE=http://www.temperatur.nu/sodra_gottsunda.html

# GET LINE WITH TEMP DATA
LINE=$(curl -s $SITE|grep favoritTemp)

# EXTRACT INFORMATION
TEMP=$(echo $LINE|sed 's/.*Temp>//'|sed 's/\&.*//'|sed 's/,/./')

# Write output:
echo $TEMP
