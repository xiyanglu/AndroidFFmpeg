package org.wi.androidffmpeg;

import android.util.Log;

import java.util.ArrayList;
import java.util.Locale;

/**
 * Created by guohe on 16/6/24.
 */
public class FFmpegCmd {
    public static final String TAG = "FFmpegUtils";
    public static final int R_SUCCESS = 0;
    public static final int R_FAILED = -1;
    private static final String STR_DEBUG_PARAM = "-d";

    public static boolean mEnableDebug = false;

    static {
        System.loadLibrary("ffmpeg");
        System.loadLibrary("ffmpeg_cmd");
    }

    public native static int run(String[] cmd);

    public static void setEnableDebug(boolean enable) {
        mEnableDebug = enable;
    }

    /**
     * Muxing video stream and audio stream.
     * This interface is quite complex which is only for adding audio effect.
     *
     * @param srcVideoName      Input video file name.
     * @param fvVolume          Input video volume, should not be negative, default is 1.0f.
     * @param srcAudioName      Input audio file name.
     * @param faVolume          Input audio volume, should not be negative, default is 1.0f.
     * @param desVideoName      Output video file name.
     * @param callback          Completion callback.
     *
     * @return Negative : Failed
     *         else : Success.
     */
    public static int mixAV(final String srcVideoName, final float fvVolume, final String srcAudioName, final float faVolume,
                            final String desVideoName, final OnCompletionListener callback) {
        if (srcAudioName == null || srcAudioName.length() <= 0
                || srcVideoName == null || srcVideoName.length() <= 0
                || desVideoName == null || desVideoName.length() <= 0) {
            return R_FAILED;
        }

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                ArrayList<String> cmds = new ArrayList<String>();
                cmds.add("ffmpeg");
                cmds.add("-i");
                cmds.add(srcVideoName);
                cmds.add("-i");
                cmds.add(srcAudioName);

                //Copy Video Stream
                cmds.add("-c:v");
                cmds.add("copy");
                cmds.add("-map");
                cmds.add("0:v:0");

                //Deal With Audio Stream
                cmds.add("-strict");
                cmds.add("-2");

                if (fvVolume <= 0.001f) {
                    //Replace audio stream
                    cmds.add("-c:a");
                    cmds.add("aac");

                    cmds.add("-map");
                    cmds.add("1:a:0");

                    cmds.add("-shortest");

                    if (faVolume < 0.99 || faVolume > 1.01) {
                        cmds.add("-vol");
                        cmds.add(String.valueOf((int) (faVolume * 100)));
                    }
                } else if (fvVolume > 0.001f && faVolume > 0.001f){
                    //Merge audio streams
                    cmds.add("-filter_complex");
                    cmds.add(String.format("[0:a]aformat=sample_fmts=fltp:sample_rates=48000:channel_layouts=stereo,volume=%f[a0]; " +
                            "[1:a]aformat=sample_fmts=fltp:sample_rates=48000:channel_layouts=stereo,volume=%f[a1];" +
                            "[a0][a1]amix=inputs=2:duration=first[aout]", fvVolume, faVolume));

                    cmds.add("-map");
                    cmds.add("[aout]");

                } else {
                    Log.w(TAG, String.format(Locale.getDefault(), "Illigal volume : SrcVideo = %.2f, SrcAudio = %.2f",fvVolume, faVolume));
                    if (callback != null) {
                        callback.onCompletion(R_FAILED);
                    }
                    return;
                }

                cmds.add("-f");
                cmds.add("mp4");
                cmds.add("-y");
                cmds.add("-movflags");
                cmds.add("faststart");
                cmds.add(desVideoName);

                if (mEnableDebug) {
                    cmds.add(STR_DEBUG_PARAM);
                }

                String[] commands = cmds.toArray(new String[cmds.size()]);

                int result = FFmpegCmd.run(commands);

                if (callback != null) {
                    callback.onCompletion(result);
                }
            }
        };

        new Thread(runnable).start();

        return R_SUCCESS;
    }

    public interface OnCompletionListener {
        void onCompletion(int result);
    }
}
