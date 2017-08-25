.PTYUTILS : clean

CPPFLAGS= -fPIC -g
LDFLAGS= -shared -lutil

OS=$(shell lsb_release -si)
ARCH=$(shell uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VER=$(shell lsb_release -sr)
SOURCES = $(shell echo *.c)
HEADERS = $(shell echo *.h)
OBJECTS=$(SOURCES:.c=.o)

ifeq ($(OS),Fedora)
	PTYUTILS_LIBDIR=/usr/lib64
else
	PTYUTILS_LIBDIR=/usr/lib/x86_64-linux-gnu
endif


TARGET=$(PTYUTILS_LIBDIR)/libptyutils.so

all: $(TARGET)

clean:
	rm -f $(OBJECTS) $(TARGET)

$(TARGET) : $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)
