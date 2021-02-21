#!/bin/bash
set -e
pwd
cd $GITHUB_WORKSPACE/android
bundle exec fastlane beta --verbose