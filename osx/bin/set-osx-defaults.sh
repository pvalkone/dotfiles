#!/bin/sh

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Not OS X!" >&2
  exit 1
fi

# Hide filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool false
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Don't default to saving documents to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Top right screen corner → Start screen saver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
# Autohide the Dock when the mouse is out
defaults write com.apple.dock autohide -bool true
# Speed up autohide
defaults write com.apple.dock autohide-time-modifier -float 0.15

# Hide battery information in menu bar
defaults write $HOME/Library/Preferences/com.apple.controlcenter.plist \
  "NSStatusItem Visible Battery" -bool false

# F1, F2, etc. behave as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Disable creating .DS_Store files on USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

for app in "Finder" "Dock"; do
  killall "${app}"
done
