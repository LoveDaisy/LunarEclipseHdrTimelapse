rm -rf build/*
g++ src/filters_generator.cpp /Users/zhangjiajie/Codes/Halide/halide/tools/GenGen.cpp -g -std=c++11 -fno-rtti \
    -I /Users/zhangjiajie/Codes/Halide/halide/include \
    -L /Users/zhangjiajie/Codes/Halide/halide/bin \
    -lHalide -lpthread -ldl \
    -o build/generate
DYLD_LIBRARY_PATH=/Users/zhangjiajie/Codes/Halide/halide/bin ./build/generate \
	-g blend2 \
	-o build \
	target=host auto_schedule=true

g++ src/main.cpp build/*.a \
	-g -std=c++11 -fno-rtti \
	-I build \
	-I /Users/zhangjiajie/Codes/Halide/halide/include \
	-I /Users/zhangjiajie/Codes/Halide/halide/tools \
	-L /Users/zhangjiajie/Codes/Halide/halide/bin \
	`libpng-config --cflags --ldflags` -ljpeg -lHalide \
	-o build/main
