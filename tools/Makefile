CC= gcc
CFLAGS = -O2 -fomit-frame-pointer -Wall
LDFLAGS =


PROGRAMS =
PROGRAMS += stoslist

all:: $(PROGRAMS)

stoslist: stoslist.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

clean::
	rm -f *.o $(PROGRAMS)
