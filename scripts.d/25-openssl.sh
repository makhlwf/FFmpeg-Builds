#!/bin/bash

SCRIPT_REPO="https://github.com/openssl/openssl.git"
SCRIPT_COMMIT="openssl-3.6.4"
SCRIPT_TAGFILTER="openssl-3.6.*"

ffbuild_depends() {
    echo base
    echo zlib
}

ffbuild_enabled() {
    return 0
}

ffbuild_dockerdl() {
    default_dl .
    echo "git submodule update --init --recursive --depth=1"
}

ffbuild_dockerbuild() {
    local myconf=(
        threads
        zlib
        no-shared
        no-tests
        no-apps
        no-legacy
        no-ssl3
        enable-camellia
        enable-ec
        enable-srp
        --prefix="$FFBUILD_PREFIX"
        --libdir=lib
    )

    myconf+=(
        --cross-compile-prefix="$FFBUILD_CROSS_PREFIX"
        mingw64
    )

    export CFLAGS="$CFLAGS -fno-strict-aliasing"
    export CXXFLAGS="$CXXFLAGS -fno-strict-aliasing"

    # OpenSSL build system prepends the cross prefix itself
    export CC="${CC/${FFBUILD_CROSS_PREFIX}/}"
    export CXX="${CXX/${FFBUILD_CROSS_PREFIX}/}"
    export AR="${AR/${FFBUILD_CROSS_PREFIX}/}"
    export RANLIB="${RANLIB/${FFBUILD_CROSS_PREFIX}/}"

    ./Configure "${myconf[@]}"

    sed -i -e "/^CFLAGS=/s|=.*|=${CFLAGS}|" -e "/^LDFLAGS=/s|=[[:space:]]*$|=${LDFLAGS}|" Makefile

    make -j$(nproc) build_sw
    make install_sw DESTDIR="$FFBUILD_DESTDIR"
}

ffbuild_configure() {
    return 0
}
