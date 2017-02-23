package com.example.jnidemo;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		String path = "/sdcard/test/test.mp4";
		info(path);
	}

	private native void info(String path);

	static {
		System.loadLibrary("ffmpeg");
	}

}
