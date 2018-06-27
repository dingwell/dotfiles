#!/bin/bash
#
# Script will search the LD_LIBRARY_PATH for the listed libraries

echo "$@"

# Set the Internal Field Separator to work with library paths
IFS=:
for i in ${LD_LIBRARY_PATH}; do
  echo $i
done
