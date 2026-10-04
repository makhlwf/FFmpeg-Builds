#!/bin/bash

SCRIPT_REPO="https://github.com/FFmpeg/nv-codec-headers.git"
SCRIPT_COMMIT="eddcea9e27f6b772057c9b3f87de2cc1737faffc"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerdl() {
    default_dl ffnvcodec
}

ffbuild_dockerbuild() {
    cd ffnvcodec
    make PREFIX="$FFBUILD_PREFIX" DESTDIR="$FFBUILD_DESTDIR" install
}

ffbuild_configure() {
    echo --enable-ffnvcodec --enable-cuda-llvm
}

ffbuild_unconfigure() {
    echo --disable-ffnvcodec --disable-cuda-llvm
}

ffbuild_cflags() {
    return 0
}

ffbuild_ldflags() {
    return 0
}
