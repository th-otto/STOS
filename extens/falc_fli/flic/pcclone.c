/* pcclone.c - This file contains all the machine specific bits of the
 * flic reader.  It's job is to set up data structures and routines for
 * the screen, Clock, and Key structures,  and the Machine structure
 * that contains them all.
 *
 * For optimum performance a flic-reader should be coded in assembler.
 * However you can get significantly greater performance merely by
 * recoding in assembler the three routines: screen_copy_seg(), 
 * screen_repeat_one() and screen_repeat_two().
 *
 * Copyright (c) 1992 Jim Kent.  This file may be freely used, modified,
 * copied and distributed.  This file was first published as part of
 * an article for Dr. Dobb's Journal March 1993 issue.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include "pcclone.h"
#include "flic.h"
#include "readflic.h"

#ifndef O_BINARY
#  ifdef _O_BINARY
#    define O_BINARY _O_BINARY
#  else
#    define O_BINARY 0
#  endif
#endif


static Display *display;
static int screenno;
static Window w;
static Visual *visual;
static Atom xa_wm_delete_window;

#define E_MASK KeyPressMask|KeyReleaseMask|ButtonPressMask	\
		|ButtonReleaseMask|\
		 EnterWindowMask|LeaveWindowMask|ExposureMask

static GC gc;
static Colormap cmap;
static Visual *vis;
static unsigned long palette[256];
static XImage *backimage;

#define SCR_WIDTH  320
#define SCR_HEIGHT 200


/** screen oriented stuff. **/

/* Put machine into graphics mode and fill out screen structure. */
ErrCode screen_open(screen *s)
{
	XSetWindowAttributes xa;
	unsigned long attrvaluemask;
	Atom protocols[1];
	
	display = XOpenDisplay(NULL);
	/* If got to here have failed.  Restore old video mode and return
	 * failure code. */
	if (display == NULL)
		return ErrDisplay;
	screenno = XDefaultScreen(display);
	attrvaluemask = 0;
	visual = DefaultVisual(display, screenno);

	s->is_open = 1;				/* Now it's open. */
	s->width = SCR_WIDTH;
	s->height = SCR_HEIGHT;
	
	w = XCreateWindow(display, RootWindow(display, screenno), 0, 0, s->width, s->height, 0, DefaultDepth(display, screenno), InputOutput, visual, attrvaluemask, &xa);
	
	XSelectInput(display, w, E_MASK);
		 
	xa_wm_delete_window = XInternAtom(display, "WM_DELETE_WINDOW", False);
	protocols[0] = xa_wm_delete_window;
	XSetWMProtocols(display, w, protocols, 1);

	backimage = XCreateImage(display, visual, DefaultDepth(display, screenno), ZPixmap, 0, NULL, s->width, s->height, 32, 0);
	backimage->data = calloc(s->height, backimage->bytes_per_line);
		
	XMapWindow(display, w);
	
	gc = XCreateGC(display, w, 0, NULL);
	
	vis = DefaultVisual(display, screenno);
	
	cmap = XCreateColormap(display, w, vis, AllocNone);
	
	return Success;
}


void screen_resize(screen *s, int width, int height)
{
	if (width == s->width && height == s->height)
		return;
	if (backimage)
	{
		free(backimage->data);
		backimage->data = NULL;
		XDestroyImage(backimage);
	}
	s->width = width;
	s->height = height;
	backimage = XCreateImage(display, visual, DefaultDepth(display, screenno), ZPixmap, 0, NULL, s->width, s->height, 32, 0);
	backimage->data = calloc(s->height, backimage->bytes_per_line);
	XResizeWindow(display, w, width, height);
}


/* Close screen.  Restore original display mode. */
void screen_close(screen *s)
{
	if (s->is_open)						/* Don't do this twice... */
	{
		XCloseDisplay(display);
		ClearStruct(s);					/* Discourage use after it's closed... */
	}
}


/* Return width of screen. */
int screen_width(screen *s)
{
	return s->width;
}


/* Return height of screen. */
int screen_height(screen *s)
{
	return s->height;
}


/* Set one dot. */
void screen_put_dot(screen *s, int x, int y, Pixel color)
{
	/* First clip it. */
	if (x < 0 || y < 0 || x >= s->width || y >= s->height)
		return;

	/* Then set it. */
	XPutPixel(backimage, x, y, palette[color]);
}


/* Clip a horizontal line segment so that it fits on the screen.
 * Return FALSE if clipped out entirely. */
static int line_clip(screen *s, int *px, int *py, int *pwidth)
{
	int x = *px;
	int y = *py;
	int width = *pwidth;
	int xend = x + width;

	if (y < 0 || y >= s->height || xend < 0 || x >= s->width)
		return 0;					/* Clipped off screen. */
	if (x < 0)
	{
		*pwidth = width = width + x;	/* and shortens width. */
		*px = 0;
	}
	if (xend > s->width)
	{
		*pwidth = width = width - (xend - s->width);
	}
	if (width < 0)
		return 0;
	return 1;
}


/* Copy pixels from memory into screen. */
void screen_copy_seg(screen *s, int x, int y, Pixel *pixels, int count)
{
	int unclipped_x = x;
	int dx;

	/* First let's do some clipping. */
	if (!line_clip(s, &x, &y, &count))
		return;

	dx = x - unclipped_x;				/* Clipping change in start position. */
	if (dx != 0)
		pixels += dx;					/* Advance over clipped pixels. */

	/* Copy pixels to display. */
	while (--count >= 0)
	{
		XPutPixel(backimage, x, y, palette[*pixels]);
		x++;
		pixels++;
	}
}


/* Draw a horizontal line of a solid color */
void screen_repeat_one(screen *s, int x, int y, Pixel color, int count)
{
	/* First let's do some clipping. */
	if (!line_clip(s, &x, &y, &count))
		return;

	/* Repeat pixel on display. */
	while (--count >= 0)
	{
		XPutPixel(backimage, x, y, palette[color]);
		x++;
	}
}


/* Repeat 2 pixels count times on screen. */
void screen_repeat_two(screen *s, int x, int y, Pixel *pixels2, int count)
{
	int is_odd;

	/* First let's do some clipping. */
	count <<= 1;						/* Convert from word to pixel count. */
	if (!line_clip(s, &x, &y, &count))
		return;
	is_odd = (count & 1);				/* Did it turn odd after clipping?  Ack! */
	count >>= 1;						/* Convert back to word count. */

	while (--count >= 0)				/* Go set screen 2 pixels at a time. */
	{
		XPutPixel(backimage, x, y, palette[pixels2[0]]);
		x++;
		XPutPixel(backimage, x, y, palette[pixels2[1]]);
		x++;
	}
	
	if (is_odd)							/* Deal with pixel at end of screen if needed. */
	{
		XPutPixel(backimage, x, y, palette[pixels2[0]]);
	}
}


/* Set count colors in color map starting at start.  RGB values
 * go from 0 to 255. */
void screen_put_colors(screen *s, int start, const unsigned char *colors, int count)
{
	int end = start + count;
	int ix;
	XColor col;
	
	for (ix = start; ix < end; ++ix)
	{
		col.red = colors[0] << 8;
		col.green = colors[1] << 8;
		col.blue = colors[2] << 8;
		col.flags = DoRed | DoGreen | DoBlue;
		XAllocColor(display, cmap, &col);
		palette[ix] = col.pixel;
		colors += 3;
	}
}


/* Set count colors in color map starting at start.  RGB values
 * go from 0 to 64. */
void screen_put_colors_64(screen *s, int start, const unsigned char *colors, int count)
{
	int end = start + count;
	int ix;
	XColor col;

	for (ix = start; ix < end; ++ix)
	{
		col.red = colors[0] << 10;
		col.green = colors[1] << 10;
		col.blue = colors[2] << 10;
		col.flags = DoRed | DoGreen | DoBlue;
		XAllocColor(display, cmap, &col);
		palette[ix] = col.pixel;
		colors += 3;
	}
}


void screen_finish(screen *s)
{
	XPutImage(display, w, gc, backimage, 0, 0, 0, 0, s->width, s->height);
}


/** Clock oriented stuff. **/

#define CMODE	0x43
#define CDATA	0x40

/* Set up clock and store speed of clock.  */
ErrCode clock_open(Clock *c)
{
	struct timespec now;
	
	clock_gettime(CLOCK_MONOTONIC, &now);
	c->now = now.tv_sec * 1000 + now.tv_nsec / 1000000l;
	return Success;
}


/* Return clock to normal. */
void clock_close(Clock *c)
{
}


/* Get current clock tick. */
unsigned long clock_ticks(Clock *c)
{
	struct timespec now;
	
	clock_gettime(CLOCK_MONOTONIC, &now);
	return now.tv_sec * 1000 + now.tv_nsec / 1000000l - c->now;
}



/** Keyboard oriented stuff. **/

/* Set up keyboard. */
ErrCode key_open(Key *key)
{
	return Success;						/* Pretty easy */
}


/* Close keyboard. */
void key_close(Key *key)
{
	return;								/* Also very easy */
}


/* See if a key is ready. */
int key_ready(Key *key)
{
	XEvent ev;
	char buf[20];
	KeySym ksym;
	
	if (key->scancode != 0)
		return 1;
	while (XPending(display))
	{
		XNextEvent(display, &ev);
		switch (ev.type)
		{
		case KeyPress:
			buf[0] = 0;
			XLookupString(&ev.xkey, buf, sizeof(buf), &ksym, NULL);
			key->scancode = ksym;
			key->ascii = buf[0];
			break;
		case KeyRelease:
			key->scancode = 0;
			break;
		}
	}
	return key->scancode != 0;
}


/* Get next key. */
unsigned char key_read(Key *key)
{
	XEvent ev;
	
	while (!key_ready(key))
	{
		XPeekEvent(display, &ev);
	}
	return key->ascii;
}


/** Stuff for reading files - regular and over 64k blocks at a time. **/

/* Open a binary file to read. */
ErrCode file_open_to_read(FileHandle *phandle, const char *name)
{
	if ((*phandle = open(name, O_RDONLY | O_BINARY)) < 0)
		return ErrOpen;
	else
		return Success;
}


/* Read in a block.  If read less than size return error code. */
ErrCode file_read_block(FileHandle handle, void *block, size_t size)
{
	if (read(handle, block, size) != size)
		return ErrRead;
	else
		return Success;
}

/** Machine oriented stuff - open and close the whole banana. **/

/* Open up machine: keyboard, clock, and screen. */
ErrCode machine_open(Machine *machine)
{
	ErrCode err;

	ClearStruct(machine);				/* Start it in a known state. */
	if ((err = key_open(&machine->key)) >= Success)
	{
		if ((err = clock_open(&machine->clock)) >= Success)
		{
			if ((err = screen_open(&machine->screen)) >= Success)
				return Success;
			clock_close(&machine->clock);
		}
		key_close(&machine->key);
	}
	return err;
}


/* Close down machine. */
void machine_close(Machine *machine)
{
	screen_close(&machine->screen);
	clock_close(&machine->clock);
	key_close(&machine->key);
}
