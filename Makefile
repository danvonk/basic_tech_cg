#
# Makefile for CG exercises for Linux and MacOS X
# On Windows Visual Studio can be used (you will have to build 
# a project file yourself).
#
CC     = cc
CPP    = c++
CPPFLAGS = -I../libs/glfw/include -I../libs/glloadgen -I../libs/glm -pthread -O2 -Wall -std=c++11

GROUP = assignment

#
# OS detection
#
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
EXTRA_DEFINES  = -DLINUX
LIBS	 = ../libs/glfw/src/libglfw3.a
LFLAGS       = $(LIB_LINUX) -lXrandr -lGL -lXi -pthread -lm -lX11 -lXxf86vm
endif
ifeq ($(UNAME), Darwin)
EXTRA_DEFINES  = -DLION
LIBS	 = ../libs/glfw/src/libglfw3.a
LFLAGS       = $(LIB_MAC) -framework Cocoa -framework OpenGL -framework IOKit
endif

OBJECTFILES      = main.o $(GROUP).o ../libs/glloadgen/gl_core_32.o ../libs/glloadgen/KHR_debug_emulator.o

assignment: $(OBJECTFILES) $(LIBS)
	$(CPP) $(OBJECTFILES) $(LIBS) $(LFLAGS) -o $(GROUP)

main.o: main.cpp
	$(CPP) $(CPPFLAGS) $(EXTRA_DEFINES) -c main.cpp -o main.o

../libs/glloadgen/gl_core_32.o: ../libs/glloadgen/gl_core_32.cc
	$(CPP) $(CPPFLAGS) -Wno-write-strings -c ../libs/glloadgen/gl_core_32.cc -o ../libs/glloadgen/gl_core_32.o

../libs/glloadgen/KHR_debug_emulator.o: ../libs/glloadgen/KHR_debug_emulator.cc
	$(CPP) $(CPPFLAGS) -Wno-write-strings -c ../libs/glloadgen/KHR_debug_emulator.cc -o ../libs/glloadgen/KHR_debug_emulator.o

%.o: %.cpp
	$(CPP) $(CPPFLAGS) -c $<

../libs/glfw/src/libglfw3.a:
	( cd ../libs/glfw && cmake CMakeLists.txt && make )

clean:
	rm -f *.o
	rm -f $(GROUP)

mrproper:
	rm -f *.o
	rm -f $(GROUP)
	rm -f ../libs/shared/tools.o
	rm -f ../libs/glloadgen/gl_core_32.o
	rm -f ../libs/glfw/lib/cocoa/libglfw.a
	rm -f ../libs/glfw/lib/x11/libglfw.a



