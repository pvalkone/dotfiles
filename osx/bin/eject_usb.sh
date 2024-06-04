#!/bin/sh

die() {
  echo "$*" >&2
  exit 1
}

is_user_root() {
  [ "$(id -u)" -eq 0 ]
}

if [ $# -ne 1 ]; then
  echo "Usage: $(basename "$0") <USB volume>"
  exit 255
fi

volume=$1
readonly volume

[ -d "$volume" ] || die "The volume doesn't seem to be mounted."

device="$(df | grep "$volume" | awk '{print $1}')"
readonly device

[ -n "$device" ] || die "Couldn't determine device name."

if ! is_user_root; then
  sudo_cmd="$(command -v sudo)"
  readonly sudo_cmd
fi

echo "Turning off Spotlight indexing..."
$sudo_cmd mdutil -i off "$volume" > /dev/null 2>&1
echo "Cleaning up ._* files..."
$sudo_cmd dot_clean -m -n "$volume" 2> /dev/null

diskutil quiet unmount "$device" || die "Failed to unmount device."

drive="u:"
readonly drive

mtoolsrc=$HOME/.mtoolsrc
readonly mtoolsrc

echo "drive $drive file=\"$device\"" > "$mtoolsrc"
echo "Cleaning up OS X-specific directories..."
$sudo_cmd mdeltree "$drive/.Spotlight-V100" "$drive/.fseventsd" "$drive/.Trashes"
echo "Setting FAT read-only attribute on selected files..."
$sudo_cmd mattrib +r "U:/System Disks/*.img" "U:/*.img" 2>/dev/null
rm -f $mtoolsrc

echo "Sorting FAT filesystem..."
$sudo_cmd fatsort -q "$device" 2> /dev/null || die "Failed to sort disk."

echo "Done. It's now safe to remove the USB drive."
