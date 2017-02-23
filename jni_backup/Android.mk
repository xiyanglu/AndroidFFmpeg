LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := ffmpeg
LOCAL_CFLAGS := -march=armv7-a -mfloat-abi=softfp -mfpu=neon -O3 -ffast-math -funroll-loops 
LOCAL_SRC_FILES := libffmpeg.so
LOCAL_EXPORT_C_INCLUDES := ffmpeg

include $(PREBUILT_SHARED_LIBRARY)


include $(CLEAR_VARS)
PATH_TO_FFMPEG_SOURCE:=$(LOCAL_PATH)/ffmpeg
LOCAL_C_INCLUDES += $(PATH_TO_FFMPEG_SOURCE)
#LOCAL_LDLIBS := -lffmpeg
LOCAL_MODULE    := ffmpegtest
LOCAL_SRC_FILES := com_ffmpeg_test_FFmpegKit.c

LOCAL_SHARED_LIBRARIES := $(LOCAL_SHARED_LIBRARIES) ffmpeg

include $(BUILD_SHARED_LIBRARY)