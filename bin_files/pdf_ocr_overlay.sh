#!/bin/bash
# Run OCR on a multi-page PDF file and create a new pdf with the
# extracted text in hidden layer. Requires cuneiform, hocr2pdf, gs.
# Usage: ./dwim.sh input.pdf output.pdf

set -e

input="$1"
output="$2"

tmpdir="$(mktemp -d)"

# extract images of the pages (note: resolution hard-coded)
gs -SDEVICE=tiffg4 -r300x300 -sOutputFile="$tmpdir/page-%04d.tiff" -dNOPAUSE -dBATCH -- "$input"

# OCR each page individually and convert into PDF
for page in "$tmpdir"/page-*.tiff
do
  base="${page%.tiff}"
    cuneiform -f hocr -o "$base.html" "$page"
    hocr2pdf -i "$page" -o "$base.pdf" < "$base.html"
done

# combine the pages into one PDF
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$output" "$tmpdir"/page-*.pdf

rm -rf -- "$tmpdir"
