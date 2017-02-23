#!/bin/bash

echo "###### 开始编译 ffmpeg ######"

SOURCE=$TARGET_FFMPEG_DIR
cd $SOURCE

# Detect stagefight
#ANDROID_SOURCE=./android-source
#ANDROID_LIBS=./android-libs
#ABI="armeabi-v7a"

ADD_H264_FEATURE="--enable-encoder=aac \
    --enable-decoder=aac \
    --enable-gpl \
    --enable-encoder=libx264 \
    --enable-libx264 \
    --extra-cflags=-I$PREFIX/include \
    --extra-ldflags=-L$PREFIX/lib "

####### stagefright 相关 开始 ######
#EXTRA_CFLAGS="-I$ANDROID_SOURCE/frameworks/base/include -I$ANDROID_SOURCE/system/core/include"
#EXTRA_CFLAGS="$EXTRA_CFLAGS -I$ANDROID_SOURCE/frameworks/base/media/libstagefright"
#EXTRA_CFLAGS="$EXTRA_CFLAGS -I$ANDROID_SOURCE/frameworks/base/include/media/stagefright/openmax"
#EXTRA_CFLAGS="$EXTRA_CFLAGS -I$NDK/sources/cxx-stl/gnu-libstdc++/4.9/include -I$NDK/sources/cxx-stl/gnu-libstdc++/4.9/libs/$ABI/include"
#EXTRA_CFLAGS="$EXTRA_CFLAGS -march=armv7-a -mfloat-abi=softfp -mfpu=neon"
#
#EXTRA_LDFLAGS="-Wl,--fix-cortex-a8 -L$ANDROID_LIBS -Wl,-rpath-link,$ANDROID_LIBS -L$NDK/sources/cxx-stl/gnu-libstdc++/4.9/libs/$ABI"
#
#EXTRA_CXXFLAGS="-Wno-multichar -fno-exceptions -fno-rtti"
####### stagefright 相关 结束 ######

###### stagefright添加到./configure中的内容 ######
#--enable-libstagefright-h264 \
#--enable-decoder=libstagefright_h264 \
#--extra-cflags="$EXTRA_CFLAGS" \
#--extra-ldflags="$EXTRA_LDFLAGS" \
#--extra-cxxflags="$EXTRA_CXXFLAGS"
###### stagefright添加到./configure中的内容 ######

function build_one_so
{
    ./configure \
        --prefix=$PREFIX \
        --disable-shared \
        --enable-pthreads \
        --enable-gpl \
        --enable-version3 \
        --enable-nonfree \
        --enable-static \
        --enable-ffmpeg \
        --disable-ffplay \
        --enable-ffprobe \
        --disable-ffserver \
        --disable-doc \
        --disable-symver \
        --enable-avdevice \
        --enable-avfilter \
        --enable-small \
        --enable-asm \
        --enable-neon \
        --cross-prefix=$CROSS_PREFIX \
        --target-os=linux \
        --arch=arm \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        --enable-parsers \
        --disable-encoders \
        --enable-encoder=h264 \
        --enable-encoder=mp3 \
        --enable-encoder=aac \
        --enable-encoder=pcm_s16le \
        --disable-decoders \
        --enable-decoder=h264 \
        --enable-decoder=mp3 \
        --enable-decoder=aac \
        --enable-decoder=pcm_s16le \
        --disable-network \
        --enable-protocols \
        --enable-protocol=file \
        --enable-filters \
        --extra-cflags="-mfloat-abi=softfp -mfpu=vfpv3-d16 -marm -march=armv7-a" \
        $ADD_H264_FEATURE
        
    make clean
    make -j4
    make install
}

build_one_so

cd ../

