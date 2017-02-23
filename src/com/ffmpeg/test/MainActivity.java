package com.ffmpeg.test;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

public class MainActivity extends Activity {

    static {
        System.loadLibrary("ffmpeg");
    }
    
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
//        String base = Environment.getExternalStorageDirectory().getPath();
//        Log.e("PATH", base);
//        String[] commands = new String[9];
//        commands[0] = "ffmpeg";
//        commands[1] = "-i";
//        commands[2] = base + "/input.mp4";
//        commands[3] = "-i";
//        commands[4] = base + "/input.mp3";
//        commands[5] = "-strict";
//        commands[6] = "-2";
//        commands[7] = "-y";
//        commands[8] = base + "/merge.mp4";
        String result = FFmpegKit.run();
        Log.e("RESULT", result + "**********************");
    }
}