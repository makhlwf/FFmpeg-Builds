#!/bin/bash

SCRIPT_REPO="https://chromium.googlesource.com/webm/libvpx"
SCRIPT_COMMIT="5e680f30801d03c21078f8c4b772464752516211"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    local myconf=(
        --disable-shared
        --enable-static
        --enable-pic
        --disable-examples
        --disable-tools
        --disable-docs
        --disable-unit-tests
        --enable-vp9-highbitdepth
        --prefix="$FFBUILD_PREFIX"
        --target=x86_64-win64-gcc
    )

    export CROSS="$FFBUILD_CROSS_PREFIX"

    ./configure "${myconf[@]}"
    make -j$(nproc)
    make install DESTDIR="$FFBUILD_DESTDIR"

    # Work around strip breaking LTO symbol index
    "$RANLIB" "$FFBUILD_DESTPREFIX"/lib/libvpx.a
}

ffbuild_configure() {
    echo --enable-libvpx
}

ffbuild_unconfigure() {
    echo --disable-libvpx
}
