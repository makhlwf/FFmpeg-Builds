#!/bin/bash

SCRIPT_REPO="https://github.com/ARMmbed/mbedtls.git"
SCRIPT_COMMIT="v4.2.0"
SCRIPT_TAGFILTER="v4.*"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerdl() {
    default_dl .
    echo "git submodule update --init --recursive --depth=1"
}

ffbuild_dockerbuild() {
    mkdir build && cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" \
        -DENABLE_PROGRAMS=OFF -DENABLE_TESTING=OFF -DGEN_FILES=ON \
        -DUSE_STATIC_MBEDTLS_LIBRARY=ON -DUSE_SHARED_MBEDTLS_LIBRARY=OFF -DINSTALL_MBEDTLS_HEADERS=ON \
        ..
    make -j$(nproc)
    make install DESTDIR="$FFBUILD_DESTDIR"

    echo "Libs.private: -lws2_32 -lbcrypt -lwinmm -lgdi32" >> "$FFBUILD_DESTPREFIX"/lib/pkgconfig/mbedcrypto.pc
}
