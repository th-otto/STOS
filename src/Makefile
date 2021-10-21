BUILD_CC = gcc
BUILD_CFLAGS = -O2 -fomit-frame-pointer -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wunused -Werror
BUILD_LDFLAGS =

ASM56K = asm56k

all: tracker.inc

tracker.inc: tracker.asm bin2c
	$(ASM56K) -s -p tracker.p56 $<
	./bin2c -b -a tracker.p56 $@
	rm -f tracker.p56

bin2c:: bin2c.c
	$(BUILD_CC) $(BUILD_CFLAGS) $(BUILD_LDFLAGS) -o $@ $<
