echo "===Building iOS Beta==="
pwd
flutter build --verbose ios --no-tree-shake-icons --release --no-codesign --flavor Beta -t lib/main_dev.dart --dart-define=username=wuxingjuan@ones.ai --dart-define=password=juan1997 --dart-define=isdev=true --dart-define=projectServerUrl=https://devapi.myones.net/project/F8032 --dart-define=wikiServerUrl=https://dev.myones.net/wiki/F8032
cd $MOBILE_ROOT/ios
pwd
bundle exec pod install --repo-update
bundle exec fastlane beta --verbose