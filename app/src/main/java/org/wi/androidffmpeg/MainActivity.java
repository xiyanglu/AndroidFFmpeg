package org.wi.androidffmpeg;

import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;

import java.io.File;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void run(View view) {
        Log.d("MainActivity", "MIX AV...");
        FFmpegCmd.setEnableDebug(true);
        String folder = Environment.getExternalStorageDirectory().getPath();
        if (folder == null || folder.length() <=0) {
            return;
        }

        folder += "/libCGE";

        FFmpegCmd.mixAV(folder + "/MediaResource/test.mp4", 1.0f,
                folder + "/MediaResource/test.mp3",
                0.7f, folder + "/new_mix.mp4", new FFmpegCmd.OnCompletionListener() {
                    @Override
                    public void onCompletion(int result) {
                        Log.d("MainActivity", "MIX AV Finish : " + result);
                    }
                });
    }
}
