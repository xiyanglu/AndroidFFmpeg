
# AndroidFFmpeg
本项目的主要内容有：
    - Android平台移植/编译FFmpeg，x264
    - 将ffmpeg可执行文件改造成库文件，通过JNI实现Java执行ffmpeg命令

项目具体介绍参见
[Android 编译FFmpeg x264](http://blog.csdn.net/matrix_laboratory/article/details/56490404)
[Android Java调用ffmpeg命令](http://blog.csdn.net/matrix_laboratory/article/details/56677084)

# 编译
- 设置NDK环境变量
```
export NDK=YOUR_NDK_PATH
```
- 执行项目中build_ffmpeg_with_x264.sh脚本
```
./build_ffmpeg_with_x264.sh
```

# License
Copyright 2015 Taylor Guo <lovenight@126.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.




