#!/bin/bash

package_variant() {
    IN="$1"
    OUT="$2"

    mkdir -p "$OUT"/bin
    cp "$IN"/bin/* "$OUT"/bin

    if [[ -d "$IN"/share/doc/ffmpeg ]]; then
        mkdir -p "$OUT/doc"
        cp -r "$IN"/share/doc/ffmpeg/* "$OUT"/doc
    fi

    mkdir -p "$OUT/presets"
    cp "$IN"/share/ffmpeg/*.ffpreset "$OUT"/presets
}
