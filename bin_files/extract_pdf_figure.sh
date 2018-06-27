#!/bin/bash
# Converts figures created by NCL in pdf.
# A single file can contain multiple pages
# so a page attribut must sent to the script
# with one figure per page, the given page
# is converted to svg, opened in inkscape,
# and resized to fit only the figure.
# The tight fitted svg is then exported to
# pdf.
#
# Usage:
#   extract_pdf_figure.sh input.pdf P
#
#   where, input.pdf is the input file
#   and P is the page number

INFILE=$1                   # Input file
PAGE=$2                     # Page to extract
SVGFILE=$INFILE.svg         # Intermediate file
NAME=$(echo $INFILE | rev | sed 's/fdp\.//' | rev)
    # searches the string $FILENAME backwards for the first fpd.
    # (.pdf backwards) and deletes it, we get the filename w/o
    # suffix
OUTFILE=$NAME'_'$PAGE.pdf

# extract page and convert to svg:
pdf2svg $INFILE $SVGFILE $PAGE

# Fit page to figure:
inkscape $SVGFILE --verb=FitCanvasToDrawing --verb=FileSave --verb=FileQuit

# Export to PDF
inkscape -f $SVGFILE --export-pdf=$OUTFILE

# Clean up
rm $SVGFILE
