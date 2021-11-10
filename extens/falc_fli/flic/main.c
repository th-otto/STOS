/* main.c - This module opens up a graphics display,  and sends all the
 * flics in the command line over to routines in readflic.c to play back.
 *
 * Copyright (c) 1992 Jim Kent.  This file may be freely used, modified,
 * copied and distributed.  This file was first published as part of
 * an article for Dr. Dobb's Journal March 1993 issue.
 */
#include <stdio.h>
#include "pcclone.h"
#include "flic.h"
#include "readflic.h"

static char about[] =
	"READFLIC - a program that plays back .FLI and .FLC files.  This is \n"
	"not the fastest flic player in the world.  It is an example written \n"
	"purely in C to illustrate decoding the flic file format.\n"
	"READFLIC is copyright (c) 1992 Jim Kent.  It is freely distributable.\n"
	"Please see the March 1993 Dr. Dobb's Journal for source code.\n"
	"Usage:\n" "   readflic flic1.flc ... flicN.flc\n" "Hit any key to stop the program.";

/* Set flic.xoff and flic.yoff so flic plays centered rather
 * than in upper left corner of display. */
static void center_flic(Flic *flic, screen *s)
{
	flic->xoff = (screen_width(s) - (signed) flic->head.width) / 2;
	flic->yoff = (screen_height(s) - (signed) flic->head.height) / 2;
}


/* Check command line.  If empty print usage message.  Otherwise
 * open up machine for animation (get screen, clock & keyboard)
 * and play back flics.
 */
int main(int argc, char *argv[])
{
	ErrCode err;
	char *title = argv[1];
	Flic flic;
	int i;
	Machine machine;

	/* Check command line for any flics.  If none then print usage
	 * instructions and exit. */
	if (argc < 2)
	{
		puts(about);
		return 1;
	}
	if ((err = machine_open(&machine)) >= Success)
	{
		if (argc == 2)
		{
			/* If just one flic in command line play it in loop mode. */
			title = argv[1];
			if ((err = flic_open(&flic, title)) >= Success)
			{
				screen_resize(&machine.screen, flic.head.width, flic.head.height);
				center_flic(&flic, &machine.screen);
				err = flic_play_loop(&flic, &machine);
				flic_close(&flic);
			}
		} else
		{
			/* If more than one flic play them once each, and then
			 * loop around to first one. */
			for (;;)
			{
				for (i = 1; i < argc; ++i)
				{
					title = argv[i];
					if ((err = flic_open(&flic, title)) >= Success)
					{
						center_flic(&flic, &machine.screen);
						err = flic_play_once(&flic, &machine);
						flic_close(&flic);
					}
					if (err < Success)
						break;
				}
				if (err < Success)
					break;
			}
		}
		machine_close(&machine);
	}
	/* Report errors back in text mode. */
	if (err < Success && err != ErrCancel)
	{
		printf("READFLIC had troubles with %s.\n%s.\n", title, flic_err_string(err));
	}
	return 0;
}
