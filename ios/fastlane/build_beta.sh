echo "===Building iOS Beta==="
pwd
#构建flutter代码和资源，必须自定义一个new_scheme,以及对应的build configuration（Release-new_scheme_name）,不然会报错(The Xcode project does not define custom schemes. You cannot use the --flavor option.)
flutter build --verbose ios --no-tree-shake-icons --release --no-codesign --flavor Beta -t lib/main.dart --dart-define=username=wuxingjuan@ones.ai --dart-define=password=juan1997 --dart-define=isdev=true --dart-define=projectServerUrl=https://devapi.myones.net/project/F8032 --dart-define=wikiServerUrl=https://dev.myones.net/wiki/F8032
cd $GITHUB_WORKSPACE/ios
pwd
bundle exec pod install --repo-update
bundle exec fastlane beta --verbose