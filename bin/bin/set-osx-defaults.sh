#!/bin/sh

# Hide filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool false && \
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true && \
# Don't default to saving documents to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false && \
killall Finder

# Top right screen corner → Start screen saver
defaults write com.apple.dock wvous-tr-corner -int 5 && \
defaults write com.apple.dock wvous-tr-modifier -int 0 && \
defaults write com.apple.dock wvous-br-corner -int 0 && \
# Autohide the Dock when the mouse is out
defaults write com.apple.dock autohide -bool true && \
# Speed up autohide
defaults write com.apple.dock autohide-time-modifier -float 0.15 && \
killall Dock
