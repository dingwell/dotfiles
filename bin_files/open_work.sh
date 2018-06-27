#!/bin/bash
# Launches vim-latex, shell and pdf-viewer, used by awesome-wm (rc.lua)

# Settings
#workdir=$HOME/Documents/Shared/phd/introduction_essay
#workdir=$HOME/Documents/Shared/phd/introduction_essay/pres
#workdir=$HOME/Documents/Shared/kurser/VT-12\ Experimental\ Boundary\ Meteorology/excursion/report3
#workdir=$HOME/Documents/Shared/phd/general/WRF-meetings/pres_mphys
#workdir=$HOME/Documents/Shared/phd/general/terminsavslutning/2012-12-18
#workdir=$HOME/Documents/Shared/phd/studies/neurope/plan
workdir=$HOME/Documents/Shared/phd/studies/neurope/article
#workdir="/home/adam/Documents/Shared/phd/CNDS/2014-03-07 Academy"

TYPE=2    # 0=report, 1=pres, 2=article


if [ $TYPE -eq 0 ]; then
  pdfname=main.pdf
  texfile=document.tex
elif [ $TYPE -eq 1 ]; then
  pdfname=pres.pdf
  texfile=pres.tex
elif [ $TYPE -eq 2 ]; then
  pdfname=article.pdf
  texfile=article.tex
fi

###

cd "$workdir"
sakura --name=set_on_s1t7 &
sleep 1
sakura --name=set_on_s1t7 -e 'vim '$texfile &
sleep 1
evince --name=set_on_s1t7 $pdfname &
wait
