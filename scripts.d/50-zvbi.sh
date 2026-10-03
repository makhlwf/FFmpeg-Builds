#!/bin/bash

SCRIPT_REPO="https://github.com/zapping-vbi/zvbi"
SCRIPT_COMMIT="d3a5ee9f2b047bf16cd1ee5ccf6ec05ee75409d0"

ffbuild_depends() {
    echo base
    echo libiconv
}

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
        --without-doxygen
        --without-x
        --disable-dvb
        --disable-bktr
        --disable-nls
        --disable-proxy
    )

    ./configure "${myconf[@]}"
    make -C src -j$(nproc)
    make -C src install DESTDIR="$FFBUILD_DESTDIR"
    make SUBDIRS=. install DESTDIR="$FFBUILD_DESTDIR"
}

ffbuild_configure() {
    echo --enable-libzvbi
}

ffbuild_unconfigure() {
    echo --disable-libzvbi
}
