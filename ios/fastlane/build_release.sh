echo "===Building iOS Release==="
pwd
#构建flutter代码和资源，必须自定义一个new_scheme,以及对应的build configuration（Release-new_scheme_name）,不然会报错(The Xcode project does not define custom schemes. You cannot use the --flavor option.)
flutter build ios --no-tree-shake-icons --release --no-codesign --flavor Beta -t lib/main.dart
cd $GITHUB_WORKSPACE/ios
pwd
bundle exec pod install --repo-update
bundle exec fastlane release --verbose