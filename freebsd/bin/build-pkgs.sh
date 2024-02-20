#!/bin/sh -e

export LANG=en_US.UTF-8
export LC_ALL=${LANG}

if [ -z "${CUSTOM_PORTS_DIR}" ]; then
  1>&2 echo "CUSTOM_PORTS_DIR not specified!"
  exit 1
fi

JAIL_NAME="13-amd64"
BUILD_LIST_FILE="/usr/local/etc/poudriere.d/$JAIL_NAME.list"

/usr/local/bin/portshaker -q && \
for port in ${BLACKLISTED_PORTS}; do echo "IGNORE=Blacklisted by ${0}" | tee "/usr/local/poudriere/ports/main/${port}/Makefile.local"; done && \
CUSTOM_PORTS=$(find "${CUSTOM_PORTS_DIR}" -type d -not -path "*/\.*" -not -path '*/py-*' -mindepth 2 -maxdepth 2 | sed "s|\\${CUSTOM_PORTS_DIR}/||") && \
PORTS_TO_BUILD=$(printf "$(echo "${ADDITIONAL_PORTS}" | tr ' ' '\n')\n${CUSTOM_PORTS}" | grep -vE "($(echo "${IGNORED_PORTS}" | tr -d '\n' | tr ' ' '|'))" | sort) && \
echo "${PORTS_TO_BUILD}" > "${BUILD_LIST_FILE}" && \
/usr/local/bin/poudriere -N bulk -j $JAIL_NAME -p main -f "${BUILD_LIST_FILE}" -J 1:2 -t
