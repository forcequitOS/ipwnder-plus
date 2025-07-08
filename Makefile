CC=gcc
CFLAGS=-DDEBUG -lusb-1.0 -I.

.SILENT: pwnedDFU

pwnedDFU: exploit.o usb.o payload_gen.o
	$(CC) *.o $(CFLAGS) -o pwnedDFU

clean:
	rm -f *.o pwnedDFU

