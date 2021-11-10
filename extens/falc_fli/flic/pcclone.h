/* pcclone.h - machine specific parts of readflic.  Structures and
 * prototypes for polling the keyboard,  checking the time, 
 * writing to the video screen, allocating large blocks of memory
 * and reading files.
 *
 * Copyright (c) 1992 Jim Kent.  This file may be freely used, modified,
 * copied and distributed.  This file was first published as part of
 * an article for Dr. Dobb's Journal March 1993 issue.
 */

#ifndef PCCLONE_H						/* Prevent file from being included twice. */
#define PCCLONE_H

typedef unsigned char Pixel;			/* Pixel type. */

typedef struct
{
	int width, height;					/* Dimensions of screen. (320x200) */
	int old_mode;						/* Mode screen was in originally. */
	int is_open;						/* Is screen open? */
} screen;								/* Device specific screen type. */

typedef int ErrCode;
typedef int FileHandle;


/* Prototypes for routines that work on display screen. */

/* Put machine into graphics mode and fill out screen structure. */
ErrCode screen_open(screen *s);

/* Close screen.  Restore original display mode. */
void screen_close(screen *s);

/* Return width of screen. */
int screen_width(screen *s);

/* Return height of screen. */
int screen_height(screen *s);

void screen_resize(screen *s, int width, int height);


/* Set one dot. */
void screen_put_dot(screen *s, int x, int y, Pixel color);

/* Copy pixels from memory into screen. */
void screen_copy_seg(screen *s, int x, int y, Pixel *pixels, int count);

/* Draw a horizontal line of a solid color */
void screen_repeat_one(screen *s, int x, int y, Pixel color, int count);

/* Repeat 2 pixels count times on screen. */
void screen_repeat_two(screen *s, int x, int y, Pixel *pixels2, int count);

/* Set count colors in color map starting at start.  RGB values
 * go from 0 to 255. */
void screen_put_colors(screen *s, int start, const unsigned char *colors, int count);

/* Set count colors in color map starting at start.  RGB values
 * go from 0 to 64. */
void screen_put_colors_64(screen *s, int start, const unsigned char *colors, int count);

void screen_finish(screen *s);


/* Clock structure and routines. */

typedef struct
{
	unsigned long now;						/* time since start. */
} Clock;


/* Set up millisecond clock. */
ErrCode clock_open(Clock *clock);

/* Return clock to normal. */
void clock_close(Clock *clock);

/* Get time in terms of clock->speed. */
unsigned long clock_ticks(Clock *clock);


/* Keyboard structure and routines. */

typedef struct
{
	unsigned char ascii;
	unsigned int scancode;
} Key;

/* Set up keyboard. */
ErrCode key_open(Key *key);

/* Close keyboard. */
void key_close(Key *key);

/* See if a key is ready. */
int key_ready(Key *key);

/* Get next key. */
unsigned char key_read(Key *key);


/** Stuff for reading files - regular and over 64k blocks at a time. **/

/* Open a binary file to read. */
ErrCode file_open_to_read(FileHandle *phandle, const char *name);


/* Read in a block.  If read less than size return error code. */
ErrCode file_read_block(FileHandle handle, void *block, size_t size);



/** Machine structure - contains all the machine dependent stuff. **/

typedef struct
{
	screen screen;
	Clock clock;
	Key key;
} Machine;

/* Open up machine: keyboard, clock, screen. */
ErrCode machine_open(Machine *machine);

/* Close down machine. */
void machine_close(Machine *machine);

#endif /* PCCLONE_H */
