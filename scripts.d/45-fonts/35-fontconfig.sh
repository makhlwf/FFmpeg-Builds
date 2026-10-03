#!/bin/bash

SCRIPT_REPO="https://gitlab.freedesktop.org/fontconfig/fontconfig.git"
SCRIPT_COMMIT="bd8f7b597de96761750d0365abb49b19d2f8d5c3"

ffbuild_depends() {
    echo base
    echo libxml2
    echo libiconv
}

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    mkdir build && cd build

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --buildtype=release
        --default-library=static
        -Ddoc=disabled
        -Diconv=enabled
        -Dxml-backend=libxml2
        -Dtools=disabled
        -Dcache-build=disabled
        -Dtests=disabled
    )

    myconf+=(
        --cross-file=/cross.meson
    )

    meson setup "${myconf[@]}" ..
    ninja -j"$(nproc)"
    DESTDIR="$FFBUILD_DESTDIR" ninja install

    rm -rf "$FFBUILD_DESTPREFIX"/{var,share,etc}
}

ffbuild_configure() {
    echo --enable-fontconfig
}

ffbuild_unconfigure() {
    echo --disable-fontconfig
}
