#!/bin/bash

# Intentions with this script:
# Split a netCDF file with several record times
# into one file for each time entry.
# The output files will be placed in subfolder
# named XXX
#
# Usage: 
#   $ split_netcdf.sh [FILE]
#

FILE=$(echo $1)

# Create subfolder: 
# (filename format expected:
#   wrfout_d01_2010-04-19_18:00:00 )
FOLDERNAME=$(echo $FILE"_split")

echo $FOLDERNAME
mkdir $FOLDERNAME   

# Read length of times
NTIMES=$(ncdump -h $FILE |grep  "Time = "| sed 's/[^0-9]*//g')
    # grep return the line matching "Time = " e.g.:
    #   Time = UNLIMITED ; // (24 currently)
    # sed will delete all non-digit characters from
    # this.  e.g. the line aboe would return: 24

# Loop for each time step in file
for (( i=01; i<=$NTIMES ; i++)); do
#for i in {01..$NTIMES}; do
    T1=$(($i-1))
    echo $T1
    T2=$(($T1))
    SUFFIX=`printf "%02i" $i`
        
    OUTFILE=$(echo "./"$FOLDERNAME"/"$FILE"_"$SUFFIX)
    ncks -d Time,$T1,$T2 $FILE $OUTFILE
done # end loop

