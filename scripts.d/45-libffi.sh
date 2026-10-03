#!/bin/bash

SCRIPT_REPO="https://github.com/libffi/libffi.git"
SCRIPT_COMMIT="bc553867367246d140cd156f060bd0409f57f157"

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
        --disable-docs
        --disable-multi-os-directory
    )

    ./configure "${myconf[@]}"
    make -j$(nproc)
    make install DESTDIR="$FFBUILD_DESTDIR"
}
