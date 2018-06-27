#!/bin/bash

# this is a script to transform a PDF containing a scanned book
#  into a beautiful searchable PDF :-)
# depends on convert (ImageMagick), ghostscript, pdftk, pdfjam, cuneiform and hocr2pdf (ExactImage)
# $ sudo apt-get install imagemagick ghostscript pdftk pdfjam exactimage
# get Cuneiform from their homepage

echo "usage: process document.pdf orientation split left top right bottom lang author title"
# where orientation is one of 0,1,2,3, meaning the amount of rotation by 90°
# and split is either 0 (already single-paged) or 1 (2 book-pages per pdf-page)
# and (left top right bottom) are the coordinates to crop (after rotation!)
# and lang is a language as in "cuneiform -l".
# and author,title are used for the PDF metadata
# all values relative to a resolution of 300dpi
#
# usage examples:
# ./process.sh SomeFile.pdf 0 0 0 0 2500 2000 ger SomeAuthor SomeTitle
# will process a PDF with one page per pdf-page, cropping to width 2500 and height 2000

pdftk "$1" burst dont_ask
for f in pg_*.pdf
do
echo "pre-processing $f ..."
convert -quiet -rotate $[90*$2] -monochrome -normalize -density 300 "$f" "$f.png"
convert -quiet -crop $6x$7+$4+$5 "$f.png" "$f.png"
if [ "1" = "$3" ];
then
    convert -quiet -crop $[$6/2]x$7+0+0 "$f.png" "$f.1.png"
    convert -quiet -crop 0x$7+$[$6/2]+0 "$f.png" "$f.2.png"
    rm -f "$f.png"
else
    echo no splitting
fi
rm -f "$f"
done

for f in pg_*.png
do
echo "processing $f ..."
convert "$f" "$f.bmp"
cuneiform -l $8 -f hocr -o "$f.hocr" "$f.bmp"
convert -blur 0.4 "$f" "$f.bmp"
hocr2pdf -i "$f.bmp" -s -o "$f.pdf" < "$f.hocr"
rm -f "$f" "$f.bmp" "$f.hocr"
done

echo "InfoKey: Author" > in.info
echo "InfoValue: $9" >> in.info
echo "InfoKey: Title" >> in.info
echo "InfoValue: $10" >> in.info
echo "InfoKey: Creator" >> in.info
echo "InfoValue: PDF OCR scan script" >> in.info
pdfjoin --fitpaper --tidy --outfile "$1.ocr1.pdf" "pg_*.png.pdf"
rm -f pg_*.png.pdf
pdftk "$1.ocr1.pdf" update_info doc_data.txt output "$1.ocr2.pdf"
pdftk "$1.ocr2.pdf" update_info in.info output "$1-ocr.pdf"
rm -f "$1.ocr1.pdf" "$1.ocr2.pdf" doc_data.txt in.info
rm -rf pg_*_files
