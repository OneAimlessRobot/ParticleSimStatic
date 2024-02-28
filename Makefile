BINARY= ParticleSimStatic.exe
CURRDIR = $(shell pwd)



LDLIBS := -L$(CURRDIR)/SDL2/lib $(CURRDIR)/SDL2/lib/libSDL2.a  $(CURRDIR)/SDL2/lib/libSDL2_mixer.a -lm -ldl -lpthread
LDLIBS += -I$(CURRDIR)/SDL2/include -Wl,-rpath,$(CURRDIR)/SDL2/lib -Wl,--enable-new-dtags -lSDL2 -lSDL2_mixer



INCLUDE= ./Includes .
SOURCES= . ./Sources
RESDIR= ./resources
 
CXX= g++
DEPFLAGS= -MP -MD

CXXFLAGS= -Wall  -DPROGRAMPATHAUX="$(CURRDIR)"  -Wextra -g $(foreach D, $(INCLUDE), -I$(D)) $(DEPFLAGS)

SOURCEFILES=$(foreach D,$(SOURCES), $(wildcard $(D)/*.cpp))


RESOURCEFILES=$(wildcard $(RESDIR)/*.o)


OBJECTS=$(patsubst %.cpp,%.o,$(SOURCEFILES))

ALLMODULES= $(RESOURCEFILES) $(OBJECTS)

DEPFILES= $(patsubst %.cpp,%.d,$(SOURCEFILES))

all: $(BINARY)
	echo $(LDLIBS)
	echo $(CURRDIR)


$(BINARY): $(OBJECTS)
	$(CXX) -g -v  $(CXXFLAGS) -o  $@ $^ $(RESOURCEFILES)  $(LDLIBS)


%.o:%.c
	$(CXX) -g  $(CXXFLAGS) -c -o $@ $<  $(LDLIBS)
	echo $(CXXFLAGS)

clean:
	rm -rf $(BINARY) $(ALLMODULES) $(DEPFILES)
