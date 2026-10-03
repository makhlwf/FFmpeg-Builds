#!/bin/bash

SCRIPT_REPO="https://github.com/cisco/openh264.git"
SCRIPT_COMMIT="8b2d28faade10d74d99ac80e199aef664c9c5a3b"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    local myconf=(
        PREFIX="$FFBUILD_PREFIX"
        INCLUDE_PREFIX="$FFBUILD_PREFIX"/include/wels
        BUILDTYPE=Release
        DEBUGSYMBOLS=False
        LIBDIR_NAME=lib
        CC="$CC"
        CXX="$CXX"
        AR="$AR"
    )

    myconf+=(
        OS=mingw_nt
        ARCH=x86_64
    )

    make -j$(nproc) "${myconf[@]}" install-static DESTDIR="$FFBUILD_DESTDIR"
}

ffbuild_configure() {
    echo --enable-libopenh264
}

ffbuild_unconfigure() {
    echo --disable-libopenh264
}
