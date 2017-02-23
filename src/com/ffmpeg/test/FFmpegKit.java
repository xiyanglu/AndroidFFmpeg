package com.ffmpeg.test;

import java.util.ArrayList;

public class FFmpegKit {
    
    private ArrayList<String> commands;
    
    
    public FFmpegKit() {
//        this.commands = new ArrayList<String>();
//        this.commands.add("ffmpeg");
    }

    public native static String run();
}