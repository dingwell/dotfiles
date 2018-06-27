#!/bin/bash

# Script takes a .ris file as an argument, converts it
# to .bib and opens it with gedit

# Replace unicode characters with latex code (not working)
#LINES=$(cat $1 |  \
        #sed 's/Á/\\´{A}/g' | \
        #sed 's/É/\\´{E}/g' | \
        #sed 's/Í/\\´{I}/g' | \
        #sed 's/Ó/\\´{O}/g' | \
        #sed 's/Ú/\\´{U}/g' | \
        #sed 's/á/\\´{a}/g' | \
        #sed 's/é/\\´{e}/g' | \
        #sed 's/í/\\´{i}/g' | \
        #sed 's/ó/\\´{o}/g' | \
        #sed 's/ú/\\´{u}/g' | \
        #sed 's/ð/\\dh{}/g'    )

                
#echo "$LINES" | xml2bib -w -b | gedit
ris2xml "$1" | xml2bib -w -b | gedit
