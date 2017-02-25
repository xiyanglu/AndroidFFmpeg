//
// Created by 郭鹤 on 16/6/24.
//

#ifndef FFMPEG_BUILD_LIB_FFMPEG_MAIN_H
#define FFMPEG_BUILD_LIB_FFMPEG_MAIN_H

#include"jni.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     org_wi_androidffmpeg_FFmpegCmd
 * Method:    run
 * Signature: ([Ljava/lang/String;)I
 */

JNIEXPORT jint
JNICALL Java_org_wi_androidffmpeg_FFmpegCmd_run
        (JNIEnv *env, jclass obj, jobjectArray commands);

#ifdef __cplusplus
}
#endif

#endif //FFMPEG_BUILD_LIB_FFMPEG_MAIN_H
