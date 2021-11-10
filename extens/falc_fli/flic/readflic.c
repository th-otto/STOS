/* readflic.c -- Routines to read and decompress a flic. Assumes Intel byte
 * ordering, but otherwise should be fairly portable. Calls machine-specific
 * stuff in pcclone.c. This file starts with the low-level decompression
 * routines: first for colors, then for pixels. It then goes to higher-level

 * exported flic_xxxx routines as prototyped in readflic.h.
 * Copyright (c) 1992 Jim Kent. This file may be freely used, modified,
 * copied and distributed. This file was first published as part of
 * an article for Dr. Dobb's Journal March 1993 issue.
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include "flic.h"
#include "readflic.h"


/* This is the type of output parameter to our decode_color below.
 * Not coincidently screen_put_color is of this type. */
typedef void ColorOut(screen *s, int start, const unsigned char *colors, int count);


/* Decode color map. Put results into output. Two color compressions
 * are identical except that RGB values are 0-63 or 0-255. Passing in
 * an output that does appropriate shifting on way to real pallete lets
 * us use the same code for both COLOR_64 and COLOR_256 compression. */
static void decode_color(unsigned char *data, Flic *flic, screen *s, ColorOut *output)
{
	int start = 0;
	unsigned char *cbuf = data;
	short ops;
	int count;

	ops = le16tocpu(cbuf);
	cbuf += 2;
	while (--ops >= 0)
	{
		start += *cbuf++;
		if ((count = *cbuf++) == 0)
			count = 256;
		(*output) (s, start, cbuf, count);
		cbuf += 3 * count;
		start += count;
	}
}


/* Decode COLOR_256 chunk. */
static void decode_color_256(unsigned char *data, Flic *flic, screen *s)
{
	decode_color(data, flic, s, screen_put_colors);
}


/* Decode COLOR_64 chunk. */
static void decode_color_64(unsigned char *data, Flic *flic, screen *s)
{
	decode_color(data, flic, s, screen_put_colors_64);
}


	/* Byte-run-length decompression. */
static void decode_byte_run(unsigned char *data, Flic *flic, screen *s)
{
	int x, y;
	int width = flic->head.width;
	int height = flic->head.height;
	signed char psize;
	unsigned char *cpt = data;
	int end;

	y = flic->yoff;
	end = flic->xoff + width;
	while (--height >= 0)
	{
		x = flic->xoff;
		cpt += 1;						/* skip over obsolete opcount byte */
		psize = 0;
		while ((x += psize) < end)
		{
			psize = *cpt++;
			if (psize >= 0)
			{
				screen_repeat_one(s, x, y, *cpt++, psize);
			} else
			{
				psize = -psize;
				screen_copy_seg(s, x, y, (Pixel *) cpt, psize);
				cpt += psize;
			}
		}
		y++;
	}
}


/* Fli style delta decompression. */
static void decode_delta_fli(unsigned char *data, Flic *flic, screen *s)
{
	int xorg = flic->xoff;
	int yorg = flic->yoff;
	unsigned char *cpt = data;
	int x, y;
	short lines;
	unsigned char opcount;
	char psize;

	y = yorg + le16tocpu(cpt);
	lines = le16tocpu(cpt + 2);
	cpt += 4;
	while (--lines >= 0)
	{
		x = xorg;
		opcount = *cpt++;
		while (opcount > 0)
		{
			x += *cpt++;
			psize = *cpt++;
			if (psize < 0)
			{
				psize = -psize;
				screen_repeat_one(s, x, y, *cpt++, psize);
				x += psize;
				opcount -= 1;
			} else
			{
				screen_copy_seg(s, x, y, (Pixel *) cpt, psize);
				cpt += psize;
				x += psize;
				opcount -= 1;
			}
		}
		y++;
	}
}


/* Flc-style delta decompression. Data is word-oriented. Much control info
 * (how far to skip, how many words to copy) are still byte-oriented. */
static void decode_delta_flc(unsigned char *data, Flic *flic, screen *s)
{
	int xorg = flic->xoff;
	int yorg = flic->yoff;
	int width = flic->head.width;
	int x, y;
	short lp_count;
	short opcount;
	int psize;
	int lastx;

	lastx = xorg + width - 1;
	lp_count = le16tocpu(data);
	data += 2;
	y = yorg;
	goto LPACK;
  SKIPLINES:							/* Advance over some lines. */
	y -= opcount;
  LPACK:
  	opcount = le16tocpu(data);			/* do next line */
	data += 2;
	if (opcount >= 0)
		goto DO_SS2OPS;
	if (opcount & 0x4000)	/* skip lines */
		goto SKIPLINES;
	screen_put_dot(s, (unsigned char) opcount, lastx, y);	/* eol dot with low byte */
	opcount = le16tocpu(data);
	data += 2;
	if (opcount == 0)
	{
		++y;
		if (--lp_count > 0)
			goto LPACK;
		goto OUT;
	}
  DO_SS2OPS:
	x = xorg;
  PPACK:								/* do next packet */
	x += *data++;
	psize = (signed char)*data++;
	if ((psize += psize) >= 0)
	{
		screen_copy_seg(s, x, y, data, psize);
		x += psize;
		data += psize;
		if (--opcount != 0)
			goto PPACK;
		++y;
		if (--lp_count > 0)
			goto LPACK;
	} else
	{
		psize = -psize;
		screen_repeat_two(s, x, y, data, psize >> 1);
		data += 2;
		x += psize;
		if (--opcount != 0)
			goto PPACK;
		++y;
		if (--lp_count > 0)
			goto LPACK;
	}
  OUT:
	return;
}


 /* Decode a BLACK chunk. Set frame to solid color 0 one line at a time. */
static void decode_black(unsigned char *data, Flic *flic, screen *s)
{
	Pixel black[2];
	int i;
	int height = flic->head.height;
	int width = flic->head.width;
	int x = flic->xoff;
	int y = flic->yoff;

	black[0] = black[1] = 0;
	for (i = 0; i < height; ++i)
	{
		screen_repeat_two(s, x, y + i, black, width / 2);
		if (width & 1)					/* if odd set last pixel */
			screen_put_dot(s, x + width - 1, y + i, 0);
	}
}


/* Decode a LITERAL chunk. Copy data to screen one line at a time. */
static void decode_literal(unsigned char *data, Flic *flic, screen *s)
{
	int i;
	int height = flic->head.height;
	int width = flic->head.width;
	int x = flic->xoff;
	int y = flic->yoff;

	for (i = 0; i < height; ++i)
	{
		screen_copy_seg(s, x, y + i, data, width);
		data += width;
	}
}


/* Open flic file. Read header, verify it's a flic. Seek to first frame. */
ErrCode flic_open(Flic *flic, const char *name)
{
	ErrCode err;
	unsigned char head[128];
	
	ClearStruct(flic);					/* Start at a known state. */
	if ((err = file_open_to_read(&flic->handle, name)) >= Success)
	{
		if ((err = file_read_block(flic->handle, head, sizeof(head))) >= Success)
		{
			flic->head.size = le32tocpu(head + 0);
			flic->head.type = le16tocpu(head + 4);
			flic->head.frames = le16tocpu(head + 6);
			flic->head.width = le16tocpu(head + 8);
			flic->head.height = le16tocpu(head + 10);
			flic->head.depth = le16tocpu(head + 12);
			flic->head.flags = le16tocpu(head + 14);
			flic->head.speed = le32tocpu(head + 16);
			flic->head.created = le32tocpu(head + 22);
			flic->head.creator = le32tocpu(head + 26);
			flic->head.updated = le32tocpu(head + 30);
			flic->head.updater = le32tocpu(head + 34);
			flic->head.aspect_dx = le16tocpu(head + 38);
			flic->head.aspect_dy = le16tocpu(head + 40);
			flic->head.ext_flag= le16tocpu(head + 42);
			flic->head.keyframes = le16tocpu(head + 44);
			flic->head.totalframes = le16tocpu(head + 46);
			flic->head.req_memory = le32tocpu(head + 48);
			flic->head.max_regions = le16tocpu(head + 52);
			flic->head.transp_num = le16tocpu(head + 54);
			flic->head.oframe1 = le32tocpu(head + 80);
			flic->head.oframe2 = le32tocpu(head + 84);

			flic->name = name;			/* Save name for future use. */
			if (flic->head.type == FLC_TYPE)
			{
				/* Seek frame 1. */
				lseek(flic->handle, flic->head.oframe1, SEEK_SET);
				if (flic->head.speed == 0)
					flic->head.speed = 20;
				return Success;
			}
			if (flic->head.type == FLI_TYPE)
			{
				/* Do some conversion work here. */
				flic->head.oframe1 = sizeof(head);
				flic->head.speed = flic->head.speed * 1000L / 70L;
				if (flic->head.speed == 0)
					flic->head.speed = 20;
				return Success;
			} else
			{
				err = ErrBadFlic;
			}
		}
		flic_close(flic);				/* Close down and scrub partially opened flic. */
	}
	return err;
}


/* Close flic file and scrub flic. */
void flic_close(Flic *flic)
{
	close(flic->handle);
	ClearStruct(flic);					/* Discourage use after close. */
}


/* Decode a frame that is in memory already into screen. Here we
 * loop through each chunk calling appropriate chunk decoder. */
static ErrCode decode_frame(Flic *flic, FrameHead *frame, unsigned char *data, screen *s)
{
	int i;
	int32_t size;
	int16_t type;
	unsigned char *chunk;

	for (i = 0; i < frame->chunks; ++i)
	{
		size = le32tocpu(data);
		type = le16tocpu(data + 4);
		chunk = data + 6;
		data += size;
		switch (type)
		{
		case COLOR_256:
			decode_color_256(chunk, flic, s);
			break;
		case DELTA_FLC:
			decode_delta_flc(chunk, flic, s);
			break;
		case COLOR_64:
			decode_color_64(chunk, flic, s);
			break;
		case DELTA_FLI:
			decode_delta_fli(chunk, flic, s);
			break;
		case BLACK:
			decode_black(chunk, flic, s);
			break;
		case BYTE_RUN:
			decode_byte_run(chunk, flic, s);
			break;
		case LITERAL:
			decode_literal(chunk, flic, s);
			break;
		default:
			break;
		}
	}
	screen_finish(s);
	return Success;
}


/* Advance to next frame of flic. */
ErrCode flic_next_frame(Flic *flic, screen *screen)
{
	FrameHead head;
	unsigned char headbuf[16];
	ErrCode err;
	void *bb;
	long size;

	if ((err = file_read_block(flic->handle, headbuf, sizeof(headbuf))) >= Success)
	{
		head.size = le32tocpu(headbuf + 0);
		head.type = le16tocpu(headbuf + 4);
		head.chunks = le16tocpu(headbuf + 6);
		if (head.type == FRAME_TYPE)
		{
			size = head.size - sizeof(headbuf);	/* Don't include head. */
			if (size > 0)
			{
				if ((bb = malloc(size)) != NULL)
				{
					if ((err = file_read_block(flic->handle, bb, size)) >= Success)
					{
						err = decode_frame(flic, &head, bb, screen);
					}
					free(bb);
				}
			}
		} else
		{
			err = ErrBadFrame;
		}
	}
	return err;
}


/* Little helper subroutine to find out when to start on next frame. */
static unsigned long calc_end_time(unsigned long millis, Clock *clock)
{
	return clock_ticks(clock) + millis;
}


/* This waits until key is hit or end_time arrives. Return Success if timed
 * out, ErrCancel if key hit. Insures keyboard poll at least once. */
static ErrCode wait_til(unsigned long end_time, Machine *machine)
{
	do
	{
		if (key_ready(&machine->key))
		{
			key_read(&machine->key);
			return ErrCancel;
		}
	} while (clock_ticks(&machine->clock) < end_time);
	return Success;
}


/* Play a flic through once. */
ErrCode flic_play_once(Flic *flic, Machine *machine)
{
	ErrCode err = Success;
	int i;
	unsigned long end_time;

	for (i = 0; i < flic->head.frames; ++i)
	{
		end_time = calc_end_time(flic->head.speed, &machine->clock);
		if ((err = flic_next_frame(flic, &machine->screen)) < Success)
			break;
		if ((err = wait_til(end_time, machine)) < Success)
			break;
	}
	return err;
}


/* This determines where second frame of flic is (useful for a loop). */
static ErrCode fill_in_frame2(Flic *flic)
{
	unsigned char head[16];
	ErrCode err;

	lseek(flic->handle, flic->head.oframe1, SEEK_SET);
	if ((err = file_read_block(flic->handle, head, sizeof(head))) < Success)
		return err;
	flic->head.oframe2 = flic->head.oframe1 + le32tocpu(head);
	return Success;
}


/* Play a flic until key is pressed. */
ErrCode flic_play_loop(Flic *flic, Machine *machine)
{
	int i;
	unsigned long end_time;
	ErrCode err;

	if (flic->head.oframe2 == 0)
	{
		fill_in_frame2(flic);
	}
	/* Seek to first frame. */
	lseek(flic->handle, flic->head.oframe1, SEEK_SET);
	/* Save time to move on. */
	end_time = calc_end_time(flic->head.speed, &machine->clock);
	/* Display first frame. */
	if ((err = flic_next_frame(flic, &machine->screen)) < Success)
		return err;
	for (;;)
	{
		/* Seek to second frame */
		lseek(flic->handle, flic->head.oframe2, SEEK_SET);
		/* Loop from 2nd frame thru ring frame */
		for (i = 0; i < flic->head.frames; ++i)
		{
			if (wait_til(end_time, machine) < Success)
				return Success;			/* Time out is a success here. */
			if ((err = flic_next_frame(flic, &machine->screen)) < Success)
				return err;
			end_time = calc_end_time(flic->head.speed, &machine->clock);
		}
	}
}


static char *err_strings[] = {
	"Unspecified error",
	"Not enough memory",
	"Not a flic file",
	"Bad frame in flic",
	NULL,
	NULL,
	"Couldn't open display",
	"Couldn't open keyboard",
	"User canceled action",
};


/* Return a string that describes an error. */
char *flic_err_string(ErrCode err)
{
	if (err >= Success)
		return "Success";				/* Shouldn't happen really... */
	if (err == ErrOpen || err == ErrRead)
		return strerror(errno);			/* Get Disk IO error from DOS. */
	err = -err;
	err -= 1;
	if (err > ArrayEls(err_strings))
		return "Unknown error";
	return err_strings[err];
}
