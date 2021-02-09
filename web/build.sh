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

WEB_OUTPUT_FILE="$GITHUB_WORKSPACE/ones-ai-mobile-web-$TRAVIS_TAG.tar.gz"

pkg_to_tarfile() {
    pwd
    echo "start package..."
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

build_mobile_web
pkg_to_tarfile

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "start upload artifact to tag $CURRENT_TAG"
    echo "upload package $WEB_OUTPUT_FILE ......"
    echo "finish upload artifact to tag $CURRENT_TAG"
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]]; then
    echo "ignore artifact for branch $CURRENT_BRANCH"
fi
exit 0