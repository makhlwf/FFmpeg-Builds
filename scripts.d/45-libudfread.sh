#!/bin/bash

SCRIPT_REPO="https://code.videolan.org/videolan/libudfread.git"
SCRIPT_COMMIT="b0bc6957e7e07d5f35391f210596d9eb71cffdd9"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    # stop the static library from exporting symbols when linked into a shared lib
    sed -i 's/-DUDFREAD_API_EXPORT/-DUDFREAD_API_EXPORT_DISABLED/g' src/meson.build

    mkdir build && cd build

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --cross-file=/cross.meson
        -Ddefault_library=static
        -Denable_examples=false
    )

    meson setup "${myconf[@]}" ..
    ninja -j$(nproc)
    DESTDIR="$FFBUILD_DESTDIR" ninja install

    ln -s libudfread.pc "$FFBUILD_DESTPREFIX"/lib/pkgconfig/udfread.pc
}
