#!/bin/sh

export REPOSITORY_DIR="/Volumes/workspace/repository"
export APP_ROOT_DIR="$REPOSITORY_DIR/VibeCooking"
echo $GOOGLE_SERVICE_INFO_PLIST > $APP_ROOT_DIR/GoogleService-Info.plist
