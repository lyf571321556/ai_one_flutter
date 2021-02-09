#!/bin/bash
set -e

echo "build wordspace:$GITHUB_WORKSPACE"
echo "CURRENT_TAG:$CURRENT_TAG"
echo "CURRENT_BRANCH:$CURRENT_BRANCH"
flutter doctor
flutter pub get

if  [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "===Building Android Release==="
    flutter build apk --no-tree-shake-icons --release --flavor production -t lib/main.dart
else [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]]
    echo "===Building Android Beta==="
    flutter build apk --verbose --no-tree-shake-icons --release --flavor preview -t lib/main_dev.dart --dart-define=username=wuxingjuan@ones.ai --dart-define=password=juan1997 --dart-define=isdev=true --dart-define=projectServerUrl=https://devapi.myones.net/project/F8032 --dart-define=wikiServerUrl=https://dev.myones.net/wiki/F8032
fi

exit 0