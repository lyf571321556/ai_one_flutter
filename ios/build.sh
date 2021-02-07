set -e

echo "build wordspace:$GITHUB_WORKSPACE"
echo "CURRENT_TAG:$CURRENT_TAG"
echo "CURRENT_BRANCH:$CURRENT_BRANCH"
flutter doctor
bundle install --gemfile $GITHUB_WORKSPACE/ios/Gemfile
flutter pub get

rm -rf ~/Library/MobileDevice/Provisioning\ Profiles*

if [ -n "${CURRENT_TAG}" ]; then
    sh $GITHUB_WORKSPACE/ios/fastlane/build_release.sh
else [ "${TRAVIS_PULL_REQUEST}" == "false" ]
    sh $GITHUB_WORKSPACE/ios/fastlane/build_beta.sh
fi
exit 0