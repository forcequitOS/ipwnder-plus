CFLAGS = -DDEBUG -I.

OS := $(shell uname -s)
ARCH := $(shell uname -m)

ifeq ($(OS),Darwin)
	CC = clang
	PREFIX := $(shell brew --prefix libusb)
	CFLAGS += -I$(PREFIX)/include -mmacos-version-min=10.11
	LDFLAGS = $(PREFIX)/lib/libusb-1.0.a -framework IOKit -framework CoreFoundation -framework Security
else
	CC = gcc
	CFLAGS += $(shell pkg-config --cflags libusb-1.0)
	LDFLAGS = $(shell pkg-config --libs-only-L libusb-1.0 | sed 's/-L//')/libusb-1.0.a -ludev -lpthread
endif

.SILENT: ipwnder-plus

ipwnder-plus: exploit.o usb.o payload_gen.o
	$(CC) *.o $(LDFLAGS) -o ipwnder-plus
	@echo "Successfully built ipwnder-plus for $(OS) $(ARCH)!"

clean:
	rm -f *.o ipwnder-plus
	@echo "Cleaned!"
