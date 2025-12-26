#!/bin/sh

backup() {
  source=$1
  shift
  rest="$*"
  if [ -z "$rest" ]; then
    rest=".git"
  fi
  excludes=$(for e in $rest; do /bin/echo " --exclude '$e'" | tr -d '\n'; done)
  prefix=$(echo "$source" | sed -e 's|[/\.]|_|g')

  echo "Backing up $source"

  eval "/opt/bin/snapbak2 \
    --cachedir /var/cache/tarsnap \
    --type daily \
    --prefix $prefix \
    $excludes \
    --keep 14 \
    $source"
}

backup "/boot/loader.conf"
backup "/root" ".cache" "dead.letter"
backup "/etc"
backup "/usr/home" "*.git" ".cache" "dead.letter" "pvalkone/dotfiles"
backup "/usr/local/etc"
backup "/usr/local/git" "dummy-value-to-keep-snapbak2-happy"
backup "/var/backups"
backup "/var/cron/tabs"
backup "/var/db/ports"
backup "/var/db/sshguard"
backup "/var/webhook"
backup "/opt/etc"
