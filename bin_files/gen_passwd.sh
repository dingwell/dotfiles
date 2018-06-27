#!/bin/bash
#
# Usage:
#
# gen_passwd.sh [N]
#
# N   Number of characters (default = 16)
#

N=$1
[ "$N" == "" ] && N=16
tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${N} | xargs
