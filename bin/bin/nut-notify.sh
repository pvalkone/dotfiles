#!/bin/sh

HOSTNAME=$(hostname)
RECIPIENT="petteri.valkonen@iki.fi"
SUBJECT="UPS event '${NOTIFYTYPE}' on ${HOSTNAME}"
STAT=$(upsc "${UPSNAME}" ups.status)
BATT=$(upsc "${UPSNAME}" battery.charge)
RUNTIME=$(upsc "${UPSNAME}" battery.runtime)
UPSLOG=$(grep "${HOSTNAME} ups" /var/log/messages | tail -10)

printf "Message: %s\nUPS status: %s\nBattery charge: %d%%\nUPS runtime: %d seconds\nLog:\n%s" \
    "${1}" "${STAT}" "${BATT}" "${RUNTIME}" "${UPSLOG}" | \
    mail -s "${SUBJECT}" "${RECIPIENT}"

exit 0
