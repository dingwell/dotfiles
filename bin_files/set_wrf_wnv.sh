#!/bin/sh
#
# This script is used to set the environment before any task in configure or compiling WRF_NMM
#

if test ${#} -eq 0 ; then
  echo "Set EM as default"
  export WRF_NMM_CORE=0
  export WRF_EM_CORE=1
elif test "${1}" = "nmm" ; then
  export WRF_NMM_CORE=1
  export WRF_NMM_NEST=1
  export WRF_EM_CORE=1
elif test "${1}" = "em" ; then
  export WRF_NMM_CORE=0
  export WRF_EM_CORE=1
else
  echo "Usage"
  echo ". my_environment_script  [nmm|em] "
fi

export WRFIO_NCD_LARGE_FILE_SUPPORT=1

echo "Assuming NETCDF is installed under /usr"
export NETCDF=/usr

if test -e /usr/lib64/libjasper.so ; then
  export JASPERLIB=/usr/lib64
  echo "libjasper found under /usr/lib64"
elif test -e /usr/lib/libjasper.so ; then
  export JASPERLIB=/usr/lib
  echo "libjasper found under /usr/lib"
elif test -e /usr/lib/x86_64-linux-gnu/libjasper.so ; then
  export JASPERLIB=/usr/lib/x86_64-linux-gnu/
  echo "libjasper found under /usr/lib/x86_64-linux-gnu/"
else
  echo "libjasper.so not found under /usr/"
fi

if test -d /usr/include/jasper ; then
  export JASPERINC=/usr/include/jasper
  echo "jasper include files found under /usr/include/"
else
  echo "jasper include files not found under /usr/include"
fi

export COMPILER_PATH=/usr/bin
echo $COMPILER_PATH
