package com.example.jnidemo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class SampleActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.activity_sample);
	}
	
	public void decode(View v) {
		startActivity(new Intent(this, MainActivity.class));
	}
	
	public void encode(View v){
		startActivity(new Intent(this, EncoderActivity.class));
	}
	
}
