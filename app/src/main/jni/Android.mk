LOCAL_PATH := $(call my-dir)

#include $(call all-subdir-makefiles)

#static version of libavcodec
include $(CLEAR_VARS)
LOCAL_MODULE:= libavcodec_static
LOCAL_SRC_FILES:= ./build/lib/libavcodec.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libavformat
include $(CLEAR_VARS)
LOCAL_MODULE:= libavformat_static
LOCAL_SRC_FILES:= ./build/lib/libavformat.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libswscale
include $(CLEAR_VARS)
LOCAL_MODULE:= libswscale_static
LOCAL_SRC_FILES:= ./build/lib/libswscale.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libavutil
include $(CLEAR_VARS)
LOCAL_MODULE:= libavutil_static
LOCAL_SRC_FILES:= ./build/lib/libavutil.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libavdevice
include $(CLEAR_VARS)
LOCAL_MODULE:= libavdevice_static
LOCAL_SRC_FILES:= ./build/lib/libavdevice.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libavfilter
include $(CLEAR_VARS)
LOCAL_MODULE:= libavfilter_static
LOCAL_SRC_FILES:= ./build/lib/libavfilter.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libswresample
include $(CLEAR_VARS)
LOCAL_MODULE:= libswresample_static
LOCAL_SRC_FILES:= ./build/lib/libswresample.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libpostproc
include $(CLEAR_VARS)
LOCAL_MODULE:= libpostproc_static
LOCAL_SRC_FILES:= ./build/lib/libpostproc.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

#static version of libx264
include $(CLEAR_VARS)
LOCAL_MODULE:= libx264_static
LOCAL_SRC_FILES:= ./build/lib/libx264.a
LOCAL_CFLAGS := -march=armv7-a -mfloat-abi=softfp -mfpu=neon -O3 -ffast-math -funroll-loops
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := ffmpeg
LOCAL_C_INCLUDES := ./build/include \
LOCAL_SRC_FILES := decoder.c encoder.c
LOCAL_LDLIBS := -llog -lz
LOCAL_CFLAGS := -march=armv7-a -mfloat-abi=softfp -mfpu=neon -O3 -ffast-math -funroll-loops
LOCAL_WHOLE_STATIC_LIBRARIES := libavformat_static \
						libavcodec_static \
						libavutil_static \
						libpostproc_static \
						libswscale_static \
						libswresample_static \
						libx264_static \
						libavfilter_static \
						libavdevice_static \
						
include $(BUILD_SHARED_LIBRARY)

###############################
#libffmpeg_main
###############################
include $(CLEAR_VARS)

FFMPEG_ROOT=./ffmpeg
LOCAL_C_INCLUDES := $(FFMPEG_ROOT) \

LOCAL_MODULE := ffmpeg_cmd
LOCAL_SRC_FILES :=  \
	libffmpeg_main/ffmpeg_cmd.c \
	libffmpeg_main/ffmpeg_cmd_wrapper.c \
	libffmpeg_main/cmdutils.c \
	libffmpeg_main/ffmpeg.c \
	$(FFMPEG_ROOT)/ffmpeg_opt.c \
	$(FFMPEG_ROOT)/ffmpeg_filter.c

LOCAL_LDLIBS := -llog -lz -ldl
LOCAL_SHARED_LIBRARIES := libffmpeg

LOCAL_CFLAGS := -march=armv7-a -mfloat-abi=softfp -mfpu=neon -O3 -ffast-math -funroll-loops -DFFMPEG_RUN_LIB -DLOG_TAG=\"FFMPEG\"

include $(BUILD_SHARED_LIBRARY)
