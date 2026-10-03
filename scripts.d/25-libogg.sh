#!/bin/bash

SCRIPT_REPO="https://github.com/xiph/ogg.git"
SCRIPT_COMMIT="06a5e0262cdc28aa4ae6797627a783b5010440f0"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    ./autogen.sh

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --host="$FFBUILD_TOOLCHAIN"
        --disable-shared
        --enable-static
        --with-pic
    )

    ./configure "${myconf[@]}"
    make -j$(nproc)
    make install DESTDIR="$FFBUILD_DESTDIR"
}
