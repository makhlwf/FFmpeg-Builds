#!/bin/bash

SCRIPT_REPO="https://github.com/lv2/sratom.git"
SCRIPT_COMMIT="9e8ee84eed502e6030ce8bb49694fd28542b08fc"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    mkdir build && cd build

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --cross-file=/cross.meson
        --buildtype=release
        --default-library=static
        -Ddocs=disabled
        -Dtests=disabled
    )

    meson "${myconf[@]}" ..
    ninja -j"$(nproc)"
    DESTDIR="$FFBUILD_DESTDIR" ninja install
}
