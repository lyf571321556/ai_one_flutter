#!/bin/bash
set -e

echo "Build Env Info:Build FLUTTER_VERSION:$FLUTTER_VERSION,Build FLUTTER_CHANNEL:$FLUTTER_CHANNEL"
echo "Build Params Info:Build Dir:$GITHUB_WORKSPACE,Build Tag:$CURRENT_TAG,Build Branch:$CURRENT_BRANCH,Build BUILD_REVISION:$BUILD_REVISION"
bundle install --gemfile android/Gemfile
flutter pub get
cd $GITHUB_WORKSPACE/android

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "===Building Android Release==="
#    flutter build apk --no-tree-shake-icons --release --flavor production -t lib/main.dart
#    cp "./build/app/outputs/flutter-apk/app-production-release.apk" "$GITHUB_WORKSPACE/ones-ai-mobile-$CURRENT_TAG.apk"
    bundle exec fastlane release --verbose
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]] || [ "${CURRENT_BRANCH}" == "flutter_beta_migration" ]; then
    echo "===Building Android Beta==="
#    flutter build apk --verbose --no-tree-shake-icons --release --flavor preview -t lib/main.dart --dart-define=username=wuxingjuan@ones.ai --dart-define=password=juan1997 --dart-define=isdev=true --dart-define=projectServerUrl=https://devapi.myones.net/project/F8032 --dart-define=wikiServerUrl=https://dev.myones.net/wiki/F8032
#    cp "./build/app/outputs/apk/preview/release/app-preview-release.apk"  "$GITHUB_WORKSPACE/ones-ai-mobile-$CURRENT_BRANCH.apk"
#    sh $GITHUB_WORKSPACE/android/fastlane/build_beta.sh
    bundle exec fastlane beta --verbose
fi
exit 0