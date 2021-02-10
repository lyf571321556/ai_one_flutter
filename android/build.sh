#!/bin/bash
set -e

echo "build wordspace:$GITHUB_WORKSPACE"
echo "CURRENT_TAG:$CURRENT_TAG"
echo "CURRENT_BRANCH:$CURRENT_BRANCH"
flutter doctor
flutter pub get
BUILD_REVISION=`git rev-list HEAD --count`

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "===Building Android Release==="
    flutter build apk --no-tree-shake-icons --release --flavor production -t lib/main.dart
    cp "./build/app/outputs/apk/release/app-release.apk" "$GITHUB_WORKSPACE/ones-mobile-$CURRENT_TAG-$BUILD_REVISION.apk"
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]]; then
    echo "===Building Android Beta==="
    flutter build apk --verbose --no-tree-shake-icons --release --flavor preview -t lib/main.dart --dart-define=username=wuxingjuan@ones.ai --dart-define=password=juan1997 --dart-define=isdev=true --dart-define=projectServerUrl=https://devapi.myones.net/project/F8032 --dart-define=wikiServerUrl=https://dev.myones.net/wiki/F8032
    cp "./build/app/outputs/apk/preview/release/app-preview-release.apk"  "$GITHUB_WORKSPACE/ones-mobile-$CURRENT_BRANCH-$BUILD_REVISION.apk"
fi
exit 0