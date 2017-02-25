#!/bin/bash

# Detect NDK
if [[  -z "$NDK"  ]]; then
	echo "The NDK dir is empty, If the shell can not run normally, you should set the NDK variable to your local ndk.dir"
	exit 1
fi

# Detect OS
OS=`uname`
HOST_ARCH=`uname -m`
export CCACHE=; type ccache >/dev/null 2>&1 && export CCACHE=ccache
if [ $OS == 'Linux' ]; then
	export HOST_SYSTEM=linux-$HOST_ARCH
elif [ $OS == 'Darwin' ]; then
	export HOST_SYSTEM=darwin-$HOST_ARCH
fi

# 配置 SYSROOT 和 CROSS_PREFIX
SYSROOT=$NDK/platforms/android-16/arch-arm
CROSS_PREFIX=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/$HOST_SYSTEM/bin/arm-linux-androideabi-

ROOT_DIR=`pwd`/
COMMOND_DIR=command_source
echo $ROOT_DIR

PREFIX=$ROOT_DIR/build
if [[ ! -d "$PREFIX" ]]; then
	mkdir $PREFIX
fi

#### 编译步骤 开始 ####
#1、编译X264
#2、编译ffmpeg
#3、拷贝x264静态库和头文件到jni下相应目录
#4、拷贝ffmpeg静态库和头文件到jni下相应目录
#5、ndk-build
#### 编译步骤 结束 ####

#预先编译X264，编译类型为静态库#
X264_SOURCE_DIR=x264
if [[ ! -d "$X264_SOURCE_DIR" ]]; then
	git clone http://git.videolan.org/git/x264.git $X264_SOURCE_DIR
	cp $ROOT_DIR$COMMOND_DIR/build_x264_for_android.sh $X264_SOURCE_DIR/build_x264_for_android.sh
fi
TARGET_X264_DIR=$ROOT_DIR$X264_SOURCE_DIR
source $X264_SOURCE_DIR/build_x264_for_android.sh

#编译ffmpeg，编译为多个静态库#
FFMPEG_SOURCE_DIR=ffmpeg
if [[ ! -d "$FFMPEG_SOURCE_DIR" ]]; then
	git clone git://source.ffmpeg.org/ffmpeg.git $FFMPEG_SOURCE_DIR
	cp $ROOT_DIR$COMMOND_DIR/build_for_android.sh $FFMPEG_SOURCE_DIR/build_for_android.sh
fi
TARGET_FFMPEG_DIR=$ROOT_DIR$FFMPEG_SOURCE_DIR

source $FFMPEG_SOURCE_DIR/build_ffmpeg_for_android.sh


#拷贝x264静态库和头文件到jni下相应目录
#libx264.a->lib/libx264.a
#x264.h->libx264/x264.h x264_config.h->libx264/x264_config.h
if [[ ! -d "./lib" ]]; then
	mkdir ./lib
fi
if [[ ! -d "./libx264" ]]; then
	mkdir ./libx264
fi


#拷贝ffmpeg静态库和头文件到jni下相应目录
#$PREFIX/lib/*.a->./lib
#$PREFIX/include/*->./
cp $PREFIX/lib/*.a ./lib
cp -r $PREFIX/include/* ./

#执行ndk-build
$NDK/ndk-build
