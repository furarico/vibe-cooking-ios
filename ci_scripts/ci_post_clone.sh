#!/bin/sh

defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES

export REPOSITORY_DIR="/Volumes/workspace/repository"
export APP_ROOT_DIR="$REPOSITORY_DIR/VibeCooking"
echo $GOOGLE_SERVICE_INFO_PLIST > $APP_ROOT_DIR/GoogleService-Info.plist
