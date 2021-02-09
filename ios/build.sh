set -e

echo "build wordspace:$GITHUB_WORKSPACE"
echo "CURRENT_TAG:$CURRENT_TAG"
echo "CURRENT_BRANCH:$CURRENT_BRANCH"
flutter doctor
bundle install --gemfile $GITHUB_WORKSPACE/ios/Gemfile
flutter pub get

rm -rf ~/Library/MobileDevice/Provisioning\ Profiles*

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    sh $GITHUB_WORKSPACE/ios/fastlane/build_release.sh
else [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]]
    sh $GITHUB_WORKSPACE/ios/fastlane/build_beta.sh
fi
exit 0