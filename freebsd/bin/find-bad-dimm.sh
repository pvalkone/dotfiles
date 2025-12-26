#!/bin/sh
#
# Identify the physical DIMM from an MCA memory error address
#
set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 <physical_address>"
  exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
  echo "Error: Must run as root"
  exit 1
fi

# Normalize address
FAULT_ADDR=$(echo "$1" | sed 's/^0x//' | tr 'a-f' 'A-F')
FAULT_ADDR_DEC=$(printf "%d" "0x${FAULT_ADDR}" 2> /dev/null)

echo "Looking for DIMM containing address: 0x${FAULT_ADDR} (${FAULT_ADDR_DEC} bytes / $((FAULT_ADDR_DEC / 1024 / 1024 / 1024)) GB)"

# Find matching memory region and physical device handle
DEVICE_HANDLE=$(dmidecode -t 20 | awk -v fault="$FAULT_ADDR_DEC" '
    /Starting Address:/ {
        start_str = $3
        if (start_str ~ /^0x/) {
            gsub(/^0x/, "", start_str)
            cmd = "printf \"%d\" 0x" start_str
            cmd | getline start
            close(cmd)
        }
    }
    /Ending Address:/ {
        end_str = $3
        if (end_str ~ /^0x/) {
            gsub(/^0x/, "", end_str)
            cmd = "printf \"%d\" 0x" end_str
            cmd | getline end
            close(cmd)
        }
    }
    /Physical Device Handle:/ {
        phys_handle = $4
        if (fault >= start && fault <= end) {
            printf "Range: 0x%X - 0x%X\n", start, end > "/dev/stderr"
            printf "Physical Device Handle: %s\n", phys_handle > "/dev/stderr"
            print phys_handle
            exit
        }
    }
')

if [ -z "$DEVICE_HANDLE" ]; then
  echo "ERROR: Could not find memory region containing this address"
  exit 1
fi

# Look up the DIMM details
dmidecode -t 17 | awk -v target="$DEVICE_HANDLE" '
    /^Handle / {
        handle = $2
        gsub(/,/, "", handle)
        in_target = (handle == target)
    }
    in_target && /Locator:/ { gsub(/^[ \t]+/, ""); print }
    in_target && /Serial Number:/ { gsub(/^[ \t]+/, ""); print }
'
