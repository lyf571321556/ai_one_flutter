set -e
echo "Build Env Info:Build FLUTTER_VERSION:$FLUTTER_VERSION,Build FLUTTER_CHANNEL:$FLUTTER_CHANNEL"
echo "Build Params Info:Build Dir:$GITHUB_WORKSPACE,Build Tag:$CURRENT_TAG,Build Branch:$CURRENT_BRANCH,Build BUILD_REVISION:$BUILD_REVISION"

bundle install --gemfile ios/Gemfile
flutter pub get
cd $GITHUB_WORKSPACE/ios
bundle exec pod install --repo-update

rm -rf ~/Library/MobileDevice/Provisioning\ Profiles*

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "===Building iOS Release==="
#    sh $GITHUB_WORKSPACE/ios/fastlane/build_release.sh
#    cp "$GITHUB_WORKSPACE/ios/fastlane/ipas/ones_mobile.ipa" "$GITHUB_WORKSPACE/ones-ai-mobile-$CURRENT_TAG.ipa"
    bundle exec fastlane release --verbose
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]]; then
    echo "===Building iOS Beta==="
#    sh $GITHUB_WORKSPACE/ios/fastlane/build_beta.sh
#    cp "$GITHUB_WORKSPACE/ios/fastlane/ipas/ones_mobile.ipa"  "$GITHUB_WORKSPACE/ones-ai-mobile-$CURRENT_BRANCH.ipa"
    bundle exec fastlane beta --verbose
fi
exit 0