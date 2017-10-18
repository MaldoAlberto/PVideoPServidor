// g++ -I/usr/lib/jvm/java-8-oracle/include -I/usr/lib/jvm/java-8-oracle/include/linux -o libTorchMain.so -shared -fPIC torchMain.cpp

#include <jni.h>
#include <iostream>
#include "Servidor.h"
#include "cluaf.h"
#include <iostream> 
#include <stdio.h>
#include <string.h>
#include <time.h>

#include <dlfcn.h>
#include <stdio.h>




//#include <cv.h>
//#include <highgui.h>
#include <stdio.h>
//#include <opencv2/core/core.hpp>
//#include <opencv2/imgproc/imgproc_c.h>
//#include "opencv2/highgui/highgui.hpp"
//#include "opencv2/imgproc/imgproc.hpp"



//using namespace cv;
using namespace std;
/*JNIEXPORT jintArray JNICALL Java_Servidor_callTorch
  (JNIEnv * env, jobject, jbyteArray array)
{
printf("entando al array");
 jintArray ret = env->NewIntArray(10);

jint fill[10];
 for (int i = 0; i < 10; i++) {
     fill[i] = 10-i; // put whatever logic you want to populate the values here.
 }
 // move from the temp structure to the java structure
 env->SetIntArrayRegion( ret, 0, 10, fill);

int len = env->GetArrayLength (array);
    unsigned char* buf = new unsigned char[len];
    env->GetByteArrayRegion (array, 0, len, reinterpret_cast<jbyte*>(buf));



          return ret;
}


*/

long estado=-1;

float tiempo( clock_t t1,clock_t t2)
{
	float difference= (((float)t2)-((float)t1)); // gives the time elapsed since t1 in milliseconds

    // now get the time elapsed in seconds

    float seconds = difference/1000; // float value of seconds
	return seconds;
}

JNIEXPORT void JNICALL Java_Servidor_startTorch
  (JNIEnv * env, jobject, jint opc)
{

	    void* handle = dlopen("libluajit.so", RTLD_LAZY|RTLD_GLOBAL);
		if(handle == 0)
		{
			fputs ("\nerror load lib\n", stderr);
			fputs (dlerror(), stderr);
		}
		else
		{
			printf("\n bien lib %s\n", "libluajit.so");
		}


	estado= iniciar(opc);  
	//f(estado);
}

JNIEXPORT void JNICALL Java_Servidor_reporte
  (JNIEnv * env, jobject)
{
	reporte();
}


//JNIEXPORT jintArray JNICALL Java_Servidor_callTorch (JNIEnv * env, jobject, jintArray array)
  JNIEXPORT jint JNICALL Java_Servidor_callTorch (JNIEnv * env, jobject, jint opc)

{
 //clock_t t1,t2;

//   t1=clock(); 

//jintArray ret = env->NewIntArray(1);

/*
jintArray ret = env->NewIntArray(1);

jint fill[1];
 



	int len = env->GetArrayLength (array);
 	int* buf = new int[len];
 	env->GetIntArrayRegion (array, 0, len, (buf));
*/

//printf("\nbuf %d %d %d %d",buf[0],buf[1],buf[2],len);
/*for(int i=0;i<len/3;i++)
{
buf[i*3]=255;buf[i*3+1]=0;buf[i*3+2]=0;
}*/
/*
Mat imgout;
//Mat img =  imread("llega.jpg", CV_LOAD_IMAGE_COLOR);
Mat img(240, 320, CV_8UC3, Scalar(0, 0, 0));

for(int y=0;y<240;y++)
{
    for(int x=0;x<320;x++)
    {
        // get pixel
        //Vec3b color = image.at<Vec3b>(Point(x,y));

        int  xx =x/2;
					int yy =y/2;
					
					int YY=buf[320*y+x];
					int uu=buf[(320*240)+(160*yy+xx)];
					int vv=buf[(320*240+160*120)+(160*yy+xx)];
					
					   int r = (int) (YY + 1.402*(vv-128));
					   int g = (int) (YY - 0.344*(uu-128) - 0.714*(vv-128));
					   int b = (int) (YY + 1.772*(uu-128));
					if(r<0)
					r=0;
					if(g<0)
					g=0;
					if(b<0)
					b=0;

       Vec3b color;
       color.val[0]=b;
       color.val[1]=g;
       color.val[2]=r;
       //if(x==0 && y==0)
		//printf("\nrgb %d %d %d yuv %d %d %d",r,g,b,YY,uu,vv);
        // set pixel
        img.at<Vec3b>(Point(x,y)) = color;
    }
}

// Mat image= Mat(480, 640, CV_8UC3, buf),imgout;

    // image = imread("opencv.jpg", CV_LOAD_IMAGE_UNCHANGED);  

  imwrite( "llega.jpg", img);

resize(img, imgout, Size(32, 32), 0, 0, INTER_CUBIC); // resize to 1024x768 resolution



  imwrite( "profile.png", imgout);
//printf("se %d  ss %d\n",image.rows,imgout.rows);

    if(! imgout.data )                           
    {
        cout <<  "Could not open or find the image" << std::endl ;
    }
    

int r; 

hola();


r=detec(imgout.data,imgout.rows,imgout.cols,imgout.channels(),estado);

printf("salida %d",r);

fill[0]=r;

 env->SetIntArrayRegion( ret, 0, 1, fill);




*/
	estado = iniciar(opc);
     jint ret = hola(estado);

          return ret;
}

