#!/bin/bash
set -e

echo "Build Env Info:Build FLUTTER_VERSION:$FLUTTER_VERSION,Build FLUTTER_CHANNEL:$FLUTTER_CHANNEL"
echo "Build Params Info:Build Dir:$GITHUB_WORKSPACE,Build Tag:$CURRENT_TAG,Build Branch:$CURRENT_BRANCH,Build BUILD_REVISION:$BUILD_REVISION"
mark_last_build_revision() {
    mkdir -p "$LAST_BUILD_DIR"
    echo "$BUILD_REVISION" > "$LAST_BUILD_REVISION_FILE"
}
#获取全部的提交记录
#git fetch --unshallow
BUILD_REVISION=`git rev-list HEAD --count`


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

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    WEB_OUTPUT_FILE="$GITHUB_WORKSPACE/ones-ai-mobile-web-$CURRENT_TAG.tar.gz"
    build_mobile_web
    pkg_to_tarfile
    echo "finish build and upload for tag $CURRENT_TAG"
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]]; then
    WEB_OUTPUT_FILE="$GITHUB_WORKSPACE/ones-ai-mobile-web-$CURRENT_BRANCH.tar.gz"
    build_mobile_web
    pkg_to_tarfile
    echo "finish build and upload for branch $CURRENT_BRANCH"
fi
exit 0