#!/bin/bash
# Script used to convert journal names to abbreviated versions
# based on rules by:
# http://www.issn.org/services/online-services/access-to-the-ltwa/

cat bibliography.bib \
  |sed 's/journal\(\s*=\)/Journal\1/' \
  |sed 's/\(Journal \s*=.*\)[aA]cadem[a-z]*\.*/\1acad./' \
  |sed 's/\(Journal \s*=.*\)[aA]gricult[a-z]*\.*/\1agric./' \
  |sed 's/\(Journal \s*=.*\)[aA]merica[a-z]*\.*/\1am./' \
  |sed 's/\(Journal \s*=.*\)[aA]pplica[a-z]*\.*/\1appl./' \
  |sed 's/\(Journal \s*=.*\)[aA]ssoci[a-z]*\.*/\1Assoc./' \
  |sed 's/\(Journal \s*=.*\)[aA]stronom[a-z]*\.*/\1astron./' \
  |sed 's/\(Journal \s*=.*\)[aA]tmospher[a-z]*\.*/\1atmos./' \
  |sed 's/\(Journal \s*=.*\)[aA]nnu[a-z]*\.*/\1Annu./' \
  |sed 's/\(Journal \s*=.*\)[bB]ulletin/\1Bull./'  \
  |sed 's/\(Journal \s*=.*\)[cC]hemist[a-z]*\.*/\1chem./' \
  |sed 's/\(Journal \s*=.*\)[cC]ontrol[a-z][a-z]*/\1Control./'  \
  |sed 's/\(Journal \s*=.*\)[cC]limatol[a-z]*\.*/\1Climatol./' \
  |sed 's/\(Journal \s*=.*\)[cC]limat[ie][a-z]*\.*/\1clim./' \
  |sed 's/\(Journal \s*=.*\)[cC]omput[a-z]*\.*/\1Comput./' \
  |sed 's/\(Journal \s*=.*\)[cC]osmochimi[a-z]*\.*/\1Cosmochim./' \
  |sed 's/\(Journal \s*=.*\)[dD]evelop[a-z]*\.*/\1dev./'  \
  |sed 's/\(Journal \s*=.*\)[dD]iscussi[a-z]*\.*/\1discuss./'  \
  |sed 's/\(Journal \s*=.*\)[dD]ynamic[a-z]*\.*/\1dyn./'  \
  |sed 's/\(Journal \s*=.*\)[eE]nvironment[a-z]*\.*/\1Environ./' \
  |sed 's/\(Journal \s*=.*\)[eE]xplor[a-z]*\.*/\1Explor./' \
  |sed 's/\(Journal \s*=.*\)[fF]orecast[a-z][a-z]*\.*/\1Forecast./' \
  |sed 's/\(Journal \s*=.*\)[gG]eochim[a-z]*\.*/\1Geochim./' \
  |sed 's/\(Journal \s*=.*\)[gG]chem[a-z]*\.*/\1Geochem./' \
  |sed 's/\(Journal \s*=.*\)[gG]eograph[a-z]*\.*/\1geogr./' \
  |sed 's/\(Journal \s*=.*\)[gG]eolog[a-z]*\.*/\1geol./' \
  |sed 's/\(Journal \s*=.*\)[gG]eophys[a-z]*\.*/\1geophys./' \
  |sed 's/\(Journal \s*=.*\)[gG]eoscien[a-z]*\.*/\1Geosci./' \
  |sed 's/\(Journal \s*=.*\)[gG]eotherm[a-z]*\.*/\1Geotherm./' \
  |sed 's/\(Journal \s*=.*\)[gG]lobal[a-z]*\.*/\1glob./' \
  |sed 's/\(Journal \s*=.*\)[jJ]ournal/\1j./' \
  |sed 's/\(Journal \s*=.*\)[lL]etter[a-z]*/\1lett./'  \
  |sed 's/\(Journal \s*=.*\)[mM]athemat[a-z]*\.*/\1math./'  \
  |sed 's/\(Journal \s*=.*\)[mM]eteorolog[a-z]*\.*/\1meteorol./'  \
  |sed 's/\(Journal \s*=.*\)[mM]odell[a-z]*\.*/\1model./'  \
  |sed 's/\(Journal \s*=.*\)[mM]onth[a-z]*\.*/\1Mon./'  \
  |sed 's/\(Journal \s*=.*\)[nN]ature/\1nat./' \
  |sed 's/\(Journal \s*=.*\)[nN]atural[a-z]*\.*/\1nat./' \
  |sed 's/\(Journal \s*=.*\)[nN]atural[a-z]*\.*/\1nat./' \
  |sed 's/\(Journal \s*=.*\)[nN]ational[a-z]*\.*/\1natl./' \
  |sed 's/\(Journal \s*=.*\)[nN]ew Zealand[a-z]*\.*/\1N. Z./' \
  |sed 's/\(Journal \s*=.*\)[pP]acific[a-z]*\.*/\1Pac./' \
  |sed 's/\(Journal \s*=.*\)[pP]lanetary/\1planet./' \
  |sed 's/\(Journal \s*=.*\)[pP]hilosoph[a-z]*\.*/\1philos./' \
  |sed 's/\(Journal \s*=.*\)[pP]hysic[a-z]*\.*/\1phys./' \
  |sed 's/\(Journal \s*=.*\)[pP]ollution/\1pollut./'  \
  |sed 's/\(Journal \s*=.*\)[pP]rocess/\1Process./'  \
  |sed 's/\(Journal \s*=.*\)[pP]rogress/\1prog./'  \
  |sed 's/\(Journal \s*=.*\)[qQ]uarterly/\1q./' \
  |sed 's/\(Journal \s*=.*\)[rR]emote[a-z][a-z]*/\1Remote./'  \
  |sed 's/\(Journal \s*=.*\)[rR]esearch[a-z]*/\1res./'  \
  |sed 's/\(Journal \s*=.*\)[rR]eview/\1rev./'  \
  |sed 's/\(Journal \s*=.*\)[sS]ensing/\1sens./' \
  |sed 's/\(Journal \s*=.*\)[sS]cienc[a-z]*\.*/\1sci./' \
  |sed 's/\(Journal \s*=.*\)[sS]ociet[a-z]*\.*/\1soc./' \
  |sed 's/\(Journal \s*=.*\)[sS]tatist[a-z]*\.*/\1stat./' \
  |sed 's/\(Journal \s*=.*\)[sS]ystem[a-z]*\.*/\1syst./' \
  |sed 's/\(Journal \s*=.*\)[tT]echni[a-z]*\.*/\1Tech./' \
  |sed 's/\(Journal \s*=.*\)[tT]ransact[a-z]*\.*/\1trans./' \
  |sed 's/\(Journal \s*=.*\)[vV]olcanol[a-z]*\.*/\1Volcanol./' \
  > bibliography_new.bib
