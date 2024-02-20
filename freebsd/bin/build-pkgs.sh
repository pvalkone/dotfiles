#!/bin/sh

if [ -z "${CUSTOM_PORTS_DIR}" ]; then
  1>&2 echo "CUSTOM_PORTS_DIR not specified!"
  exit 1
fi

BUILD_LIST_FILE="/usr/local/etc/poudriere.d/12-amd64.list"

/usr/local/bin/portshaker -q && \
for port in ${BLACKLISTED_PORTS}; do echo "IGNORE=Blacklisted by ${0}" | tee "/usr/local/poudriere/ports/main/${port}/Makefile.local"; done && \
CUSTOM_PORTS=$(find "${CUSTOM_PORTS_DIR}" -type d -not -path "*/\.*" -not -path '*/py-*' -mindepth 2 -maxdepth 2 | sed "s|\\${CUSTOM_PORTS_DIR}/||") && \
PORTS_TO_BUILD=$(printf "$(echo "${ADDITIONAL_PORTS}" | tr ' ' '\n')\n${CUSTOM_PORTS}" | grep -vE "($(echo "${IGNORED_PORTS}" | tr -d '\n' | tr ' ' '|'))" | sort) && \
echo "${PORTS_TO_BUILD}" > "${BUILD_LIST_FILE}" && \
/usr/local/bin/poudriere -N bulk -j 12-amd64 -p main -f "${BUILD_LIST_FILE}" -J 1:2 -t
