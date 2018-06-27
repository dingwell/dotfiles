#!/bin/bash
# Returns the sum of the sizes of the listed files in MB
# (calculated with KB precision)

#echo $@

# List all files with sizes in units of KB, only keep the numbers
LIST_OF_SIZES=$(ls -s --block-size=KB $@|egrep -o '[0-9]*kB '|egrep -o '[0-9]*');

# Calculate the sum of the KB sizes:
SUM_KB=$(echo $LIST_OF_SIZES|sed 's/\s/+/g'|bc)

# Convert to MB (the +500 is emulate round-to-nearest in bc, which really only truncates)
SUM_MB=$(echo "($SUM_KB+500)/1000"|bc)

echo "${SUM_MB}MB"
