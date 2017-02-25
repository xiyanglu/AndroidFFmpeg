#include <jni.h>
#include <android/log.h>
#include <stdio.h>

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavformat/avio.h>
#include <libavutil/fifo.h>
#include <libavutil/avutil.h>
#include <libavutil/mem.h>
#include <libswscale/swscale.h>

#define  LOG_TAG    "FFMPEG INFO"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)


void SaveFrame(AVFrame *pFrame, int width, int height, int iFrame) {
  FILE* pFile;
  char szFileName[32];
  int y;

  sprintf(szFileName,"/mnt/sdcard/test/frame%d.ppm",iFrame);

  LOGI("filename : %s",szFileName);

  pFile = fopen(szFileName,"w");
  if(pFile == NULL){
      LOGI("can not open file %s",szFileName);
      return ;
  }

  fprintf(pFile,"P6\n%d %d\n255\n",width,height);

  for(y=0;y<width;++y){
      LOGI("Write file AVFrame");
      fwrite(pFrame->data[0]+y*pFrame->linesize[0],1,width*3,pFile);
  }

  fclose(pFile);
  LOGI("close file %s",szFileName);
}

JNIEXPORT void JNICALL Java_com_example_jnidemo_MainActivity_info(JNIEnv *env, jobject obj, jstring jpath){
	const jbyte* path = (*env)->GetStringUTFChars(env,jpath,NULL);
  	AVFormatContext   *pFormatCtx = NULL;
  	int               i, videoStream;
  	AVCodecContext    *pCodecCtxOrig = NULL;
  	AVCodecContext    *pCodecCtx = NULL;
  	AVCodec           *pCodec = NULL;
  	AVFrame           *pFrame = NULL;
  	AVFrame           *pFrameRGB = NULL;
  	AVPacket          packet;
  	int               frameFinished;
  	int               numBytes;
  	uint8_t           *buffer = NULL;
  	struct SwsContext *sws_ctx = NULL;

  	av_register_all();

//  	if(avformat_open_input(&pFormatCtx, path, NULL, NULL)!=0)
//  	{
//  		LOGE("Could not open the file : %s",path);
//  		return ;
//    }

  	int err_code;

  	if(err_code=avformat_open_input(&pFormatCtx, path, NULL, NULL))
  	{
  		char buf[256];
  	    av_strerror(err_code, buf, 1024);
  	    LOGE("Couldn't open file %s: %d(%s)", path, err_code, buf);
  	    return;
  	}

  	if(avformat_find_stream_info(pFormatCtx, NULL)<0)
    	return ;

  	av_dump_format(pFormatCtx, 0, path, 0);

  	videoStream=-1;
  	for(i=0; i<pFormatCtx->nb_streams; i++)
    	if(pFormatCtx->streams[i]->codec->codec_type==AVMEDIA_TYPE_VIDEO)
    	{
      		videoStream=i;
      		break;
    	}

  	if(videoStream==-1)
    	return ;

  	pCodecCtxOrig=pFormatCtx->streams[videoStream]->codec;

  	pCodec=avcodec_find_decoder(pCodecCtxOrig->codec_id);
  	if(pCodec==NULL)
  	{
    	LOGE("Unsupported codec!\n");
    	return ;
  	}

  	pCodecCtx = avcodec_alloc_context3(pCodec);
  	if(avcodec_copy_context(pCodecCtx, pCodecCtxOrig) != 0)
  	{
    	LOGE("Couldn't copy codec context");
    	return ;
  	}

    if(avcodec_open2(pCodecCtx, pCodec, NULL)<0)
    	return ;

  	pFrame=av_frame_alloc();
  	pFrameRGB=av_frame_alloc();
  	if(pFrameRGB==NULL)
    	return ;

  	numBytes=avpicture_get_size(AV_PIX_FMT_RGB24, pCodecCtx->width,pCodecCtx->height);
  	buffer=(uint8_t *)av_malloc(numBytes*sizeof(uint8_t));

  	avpicture_fill((AVPicture *)pFrameRGB, buffer, AV_PIX_FMT_RGB24,pCodecCtx->width, pCodecCtx->height);

  	sws_ctx = sws_getContext(pCodecCtx->width,
			   pCodecCtx->height,
			   pCodecCtx->pix_fmt,
			   pCodecCtx->width,
			   pCodecCtx->height,
			   AV_PIX_FMT_RGB24,
			   SWS_BILINEAR,
			   NULL,
			   NULL,
			   NULL
			   );

  	i=0;
  	while(av_read_frame(pFormatCtx, &packet)>=0) {
    	if(packet.stream_index==videoStream) {

    		avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);

    		if(frameFinished) {

				sws_scale(sws_ctx, (uint8_t const * const *)pFrame->data,
          pFrame->linesize, 0, pCodecCtx->height,
          pFrameRGB->data, pFrameRGB->linesize);

				if(++i<=5)
	  				SaveFrame(pFrameRGB, pCodecCtx->width, pCodecCtx->height, i);
      		}
    	}
    	av_free_packet(&packet);
    }
  	av_free(buffer);
  	av_frame_free(&pFrameRGB);
  	av_frame_free(&pFrame);
  	avcodec_close(pCodecCtx);
  	avcodec_close(pCodecCtxOrig);
  	avformat_close_input(&pFormatCtx);
  	(*env)->ReleaseStringUTFChars(env,jpath,path);
}
