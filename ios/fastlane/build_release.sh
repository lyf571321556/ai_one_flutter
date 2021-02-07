echo "===Building iOS Release==="
pwd
flutter build ios --no-tree-shake-icons --release --no-codesign --flavor Beta -t lib/main.dart
cd $GITHUB_WORKSPACE/ios
pwd
bundle exec pod install --repo-update
bundle exec fastlane release --verbose