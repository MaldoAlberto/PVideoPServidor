#!/bin/bash
#clear


luajit -b pruebas_sillas.lua pruebas_sillas.o

gcc -w -c -Wall -Wl,-E -fpic cluaf.c -lluajit -lluaT -lTH -lm -ldl -L /home/alberto/torch/install/lib -I'/home/alberto/torch/install/include' -lluaT -ltorch-lua-static -lTH  -lnn  -ltorch -lnnx -limage -limgraph -lluaT -ltorch-lua-static -lTH -lnn  -ltorch -lnnx -limage -limgraph -ldl -lpthread

gcc -shared cluaf.o pruebas_sillas.o -L'/home/alberto/torch/install/lib'  -lluajit -lluaT -lTH -lm -ldl -Wl,-E -o libcluaf.so 

#g++ -I/usr/local/include/opencv -I/usr/local/include/opencv2 -L/usr/local/lib/ -g -o binary  main.cpp -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_contrib -lopencv_legacy -lopencv_stitching -L. -Wall  -lcluaf

#g++  -I/usr/local/include/opencv -I/usr/local/include/opencv2 -I/usr/lib/jvm/java-8-oracle/include -I/usr/lib/jvm/java-8-oracle/include/linux -L/usr/local/lib/ -g  -o libTorchMain.so -shared -fPIC torchMain.cpp -lcluaf -L. -Wall  -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_gpu -lopencv_contrib -lopencv_legacy -lopencv_stitching


g++ -I/usr/lib/jvm/java-8-oracle/include -I/usr/lib/jvm/java-8-oracle/include/linux -L/usr/local/lib/ -g  -o libTorchMain.so -shared -fPIC torchMain.cpp -lcluaf -L. -Wall



javac  *.java

java Main
