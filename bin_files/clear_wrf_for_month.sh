#!/bin/bash

# Script used to delete all data under given subdirectory
# originally used for WRF data, assuming the following
# directory tree:
# 
# ./[month]/[day]/wrfout*

if [ $# -ge 1 ]; then
  echo "$# input arguments, assuming each is a month"
else
  echo "1 input argument expected, got $#"
  exit 1
fi


for MONTH in $@; do
  echo "Clearing data under ./$MONTH/*/*"
  for i in $MONTH/*/wrfout*; do
    rm -v $i
  done
done
