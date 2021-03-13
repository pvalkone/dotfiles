#!/bin/sh

if [ -z "${CUSTOM_PORTS_DIR}" ]; then
  1>&2 echo "CUSTOM_PORTS_DIR not specified!"
  exit 1
fi

portshaker && \
for port in ${BLACKLISTED_PORTS}; do echo "IGNORE=Blacklisted by ${0}" | tee "/usr/ports/${port}/Makefile.local"; done && \
CUSTOM_PORTS=$(find "${CUSTOM_PORTS_DIR}" -type d -not -path "*/\.*" -not -path '*/py-*' -mindepth 2 -maxdepth 2 | sed "s|\\${CUSTOM_PORTS_DIR}/||")
PORTS_TO_BUILD=$(echo "${ADDITIONAL_PORTS} ${CUSTOM_PORTS}" | grep -vE "($(echo "${IGNORED_PORTS}" | tr -d '\n' | tr ' ' '|'))" | ghead -c -1 | tr '\n' ' ')
echo "Building ${PORTS_TO_BUILD} using Synth"
eval "synth just-build ${PORTS_TO_BUILD}" && \
synth rebuild-repository
