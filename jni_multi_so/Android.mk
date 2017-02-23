LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := avcodec-55-prebuilt
LOCAL_SRC_FILES := ffmpeglib/libavcodec-55.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := avfilter-4-prebuilt
LOCAL_SRC_FILES := ffmpeglib/libavfilter-4.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := avformat-55-prebuilt
LOCAL_SRC_FILES := ffmpeglib/libavformat-55.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE :=  avutil-52-prebuilt
LOCAL_SRC_FILES := ffmpeglib/libavutil-52.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE :=  avswresample-0-prebuilt
LOCAL_SRC_FILES := ffmpeglib/libswresample-0.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE :=  swscale-2-prebuilt
LOCAL_SRC_FILES := ffmpeglib/libswscale-2.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := ffmpeg

LOCAL_LDLIBS := -llog -ljnigraphics -lz -landroid
LOCAL_SHARED_LIBRARIES := avcodec-55-prebuilt \
						 avfilter-4-prebuilt \
						 avformat-55-prebuilt \
						 avutil-52-prebuilt \
						 swscale-2-prebuilt \
						 avswresample-0-prebuilt

include $(BUILD_SHARED_LIBRARY)