#!/bin/bash

SCRIPT_REPO="https://aomedia.googlesource.com/aom"
SCRIPT_COMMIT="b4ce2cd097b00921b0327bfb5f07b5f8361ade99"

ffbuild_depends() {
    echo base
}

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    mkdir cmbuild && cd cmbuild

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" -DBUILD_SHARED_LIBS=OFF -DENABLE_EXAMPLES=NO -DENABLE_TESTS=NO -DENABLE_TOOLS=NO -DCONFIG_TUNE_VMAF=0 ..
    make -j$(nproc)
    make install DESTDIR="$FFBUILD_DESTDIR"
}

ffbuild_configure() {
    echo --enable-libaom
}

ffbuild_unconfigure() {
    echo --disable-libaom
}
