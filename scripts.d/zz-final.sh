#!/bin/bash

SCRIPT_SKIP="1"

ffbuild_depends() {
    echo libiconv
    echo zlib
    echo fribidi
    echo gmp
    echo libxml2
    echo openssl
    echo xz
    echo fonts
    echo lcevcdec
    echo lcms2
    echo libvorbis
    echo opencl
    echo vulkan
    echo amf
    echo aom
    echo avisynth
    echo chromaprint
    echo dav1d
    echo davs2
    echo dvd
    echo fdk-aac
    echo ffnvcodec
    echo frei0r
    echo gme
    echo libaribb24
    echo libaribcaption
    echo libass
    echo libbluray
    echo libcurl
    echo libjxl
    echo libmp3lame
    echo libopus
    echo libplacebo
    echo libpng
    echo librsvg
    echo libtheora
    echo libvpx
    echo libwebp
    echo lilv
    echo onevpl
    echo openapv
    echo openjpeg
    echo openmpt
    echo rubberband
    echo schannel
    echo sdl
    echo snappy
    echo soxr
    echo srt
    echo svtav1
    echo twolame
    echo uavs3d
    echo vapoursynth
    echo vidstab
    echo vvenc
    echo x264
    echo x265
    echo xavs2
    echo xvid
    echo zimg
    echo zvbi
}

ffbuild_enabled() {
    return 0
}

ffbuild_dockerfinal() {
    return 0
}

ffbuild_dockerdl() {
    return 0
}

ffbuild_dockerlayer() {
    return 0
}

ffbuild_dockerstage() {
    return 0
}

ffbuild_dockerbuild() {
    return 0
}

ffbuild_ldexeflags() {
    return 0
}
