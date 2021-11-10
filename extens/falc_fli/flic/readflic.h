/* Readflic.h -- Prototypes and other structural info for readflic program.
 * Copyright (c) 1992 Jim Kent.  This file may be freely used, modified,
 * copied and distributed.  This file was first published as part of
 * an article for Dr. Dobb's Journal March 1993 issue.  */

#include "pcclone.h"

/* Some handy macros I use in lots of programs: */

/* Count up number of elements in an array */
#define ArrayEls(a) (sizeof(a)/sizeof((a)[0]))

/* Clear a block of memory. */
#define ClearMem(buf,size)  memset(buf, 0, size)

/* Clear a structure (pass in pointer) */
#define ClearStruct(pt) ClearMem(pt, sizeof(*(pt)))

/* Data structures peculiar to readflic program: */
typedef struct {
    FlicHead head;  /* Flic file header. */
    int handle;     /* File handle. */
    int frame;      /* Current frame in flic. */
    const char *name;     /* Name from flic_open. */
    int xoff,yoff;  /* Offset to display flic at. */
} Flic;

/* Prototypes peculiar to readflic program: */

/* Open flic file.  Read header and verify it's a flic. */
ErrCode flic_open(Flic *flic, const char *name);

/* Close flic file and scrub flic. */
void flic_close(Flic *flic);

/* Play a flic through once. */
ErrCode flic_play_once(Flic *flic, Machine *machine);

/* Play a flic until key is pressed. */
ErrCode flic_play_loop(Flic *flic, Machine *machine);

/* Advance to next frame of flic. */
ErrCode flic_next_frame(Flic *flic, screen *screen);

/* Various error codes flic reader can get. */
#define Success     0
#define Error		-1		/* Unclassified error. */
#define ErrNoMemory -2      /* Not enough memory. */
#define ErrBadFlic  -3      /* File isn't a flic. */
#define ErrBadFrame -4      /* Bad frame in flic. */
#define ErrOpen     -5      /* Couldn't open file.  Check errno. */
#define ErrRead     -6      /* Couldn't read file.  Check errno. */
#define ErrDisplay  -7      /* Couldn't open display. */
#define ErrClock    -8      /* Couldn't open clock. */
#define ErrKey      -9      /* Couldn't open keyboard. */
#define ErrCancel   -10     /* User cancelled. */
char *flic_err_string(ErrCode err);
