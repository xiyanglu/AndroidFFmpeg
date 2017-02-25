//
// Created by 郭鹤 on 16/6/24.
//

#include "ffmpeg_cmd.h"
#include "ffmpeg_cmd_wrapper.h"
#include "jni.h"

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT jint
JNICALL Java_org_wi_androidffmpeg_FFmpegCmd_run
        (JNIEnv *env, jclass obj, jobjectArray commands)
{
    int argc = (*env)->GetArrayLength(env, commands);
    char *argv[argc];
    jstring jstr[argc];

    int i = 0;;
    for (i = 0; i < argc; i++)
    {
        jstr[i] = (jstring)(*env)->GetObjectArrayElement(env, commands, i);
        argv[i] = (char *) (*env)->GetStringUTFChars(env, jstr[i], 0);
        //CGE_LOG_INFO("argv[%d] : %s", i, argv[i]);
    }

    int status = run_cmd(argc, argv);

    for (i = 0; i < argc; ++i)
    {
        (*env)->ReleaseStringUTFChars(env, jstr[i], argv[i]);
    }

    return status;
}
#ifdef __cplusplus
}
#endif
