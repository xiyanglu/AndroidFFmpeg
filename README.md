
# AndroidFFmpeg
本项目的主要内容有：
    - Android平台移植/编译FFmpeg，x264
    - 将ffmpeg可执行文件改造成库文件，通过JNI实现Java执行ffmpeg命令
    - 实现了一个简单音视频混合程序，用于测试ffmpeg命令

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
- 把项目导入AndroidStudio，然后编译运行

# 运行结果

![这里写图片描述](http://img.blog.csdn.net/20170225141546144?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbWF0cml4X2xhYm9yYXRvcnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170225141604316?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbWF0cml4X2xhYm9yYXRvcnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

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




