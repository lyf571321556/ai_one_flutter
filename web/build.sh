#!/bin/bash
set -e

echo "build wordspace:$GITHUB_WORKSPACE"
echo "CURRENT_TAG:$CURRENT_TAG"
echo "CURRENT_BRANCH:$CURRENT_BRANCH"
echo "FLUTTER_VERSION:$FLUTTER_VERSION"
echo "FLUTTER_CHANNEL:$FLUTTER_CHANNEL"
mark_last_build_revision() {
    mkdir -p "$LAST_BUILD_DIR"
    echo "$BUILD_REVISION" > "$LAST_BUILD_REVISION_FILE"
}

pkg_to_tarfile() {
    pwd
    echo "start package..."
    WEB_OUTPUT_FILE="$GITHUB_WORKSPACE/ones-ai-mobile-web-$TRAVIS_TAG.tar.gz"
#   unzip -o ./build/web/assets/assets/editor_package.zip -d ./build/web/assets/assets/editor_package > /dev/null
    echo $WEB_OUTPUT_FILE
    rm -rf ./build/web/assets/assets/editor_package.zip
    ls -al ./build/web
    tar zcvf $WEB_OUTPUT_FILE -C ./build/web .
    ls -al .
    echo "finish package..."
}

build_mobile_web() {
    echo "start build..."
    flutter doctor -v
    flutter config --enable-web
    flutter pub get
    flutter build web --release
    echo "finish build..."
}

git fetch --unshallow
BUILD_REVISION=`git rev-list HEAD --count`

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "start build web for tag $CURRENT_TAG"
    build_mobile_web
    pkg_to_tarfile
else
    echo "start build web for branch $CURRENT_BRANCH"
    build_mobile_web
fi
exit 0