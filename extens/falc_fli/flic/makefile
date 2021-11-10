CFLAGS= -O2 -Wall
LDFLAGS=

OBJ = readflic.o main.o pcclone.o

all: readflic

readflic: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJ) -lX11

$(OBJ): flic.h readflic.h pcclone.h

clean::
	rm -f *.o readflic
