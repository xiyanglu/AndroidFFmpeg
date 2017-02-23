/*
 * com_ffmpeg_test.c
 *
 *  Created on: 2016-3-28
 *      Author: edgardo
 */

#include <string.h>
#include <stdio.h>
#include <android/log.h>
#include <jni.h>
#include <libavcodec/avcodec.h>

/*
 * Class:     com_ffmpeg_test_FFmpegKit
 * Method:    run
 * Signature: (Ljava/lang/String;)I
 */
JNIEXPORT jstring JNICALL Java_com_ffmpeg_test_FFmpegKit_run(JNIEnv* env, jobject thiz) {

	char str[25];
	sprintf(str, "%d", avcodec_version());

	jstring jstr = (*env)->NewStringUTF(env, str);
	return jstr;
}
