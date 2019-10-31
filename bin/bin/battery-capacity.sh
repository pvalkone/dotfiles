#!/bin/sh
# https://vermaden.wordpress.com/2018/11/28/the-power-to-serve-freebsd-power-management/

if [ ${#} -ne 1 ]
then
  echo "usage: ${0##*/} BATTERY"
  exit
fi

if acpiconf -i ${1} 1> /dev/null 2> /dev/null
then
  DATA=$( acpiconf -i ${1} )
  MAX=$( echo "${DATA}" | grep '^Design\ capacity:'     | awk -F ':' '{print $2}' | tr -c -d '0-9' )
  NOW=$( echo "${DATA}" | grep '^Last\ full\ capacity:' | awk -F ':' '{print $2}' | tr -c -d '0-9' )
  MOD=$( echo "${DATA}" | grep '^Model\ number:'        | awk -F ':' '{print $2}' | awk '{print $1}' )
  echo -n "Battery '${1}' model '${MOD}' has efficiency: "
  printf '%1.0f%%\n' $( bc -l -e "scale = 2; ${NOW} / ${MAX} * 100" -e quit )
else
  echo "NOPE: Battery '${1}' does not exists on this system."
  echo "INFO: Most systems has only '0' or '1' batteries."
  exit 1
fi
