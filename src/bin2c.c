#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <stdint.h>
#include <getopt.h>

static int include_binheader;
static int generate_asm;


#define EOFFILE ((uint32_t)-1)
#define MEMTYPE_EOF 3

static uint32_t read_word(FILE *infile)
{
	int a, b, c;
	a = getc(infile);
	b = getc(infile);
	c = getc(infile);
	if (a == EOF || b == EOF || c == EOF)
		return EOFFILE;
	return ((uint32_t)a << 16) | ((uint32_t)b << 8) | ((uint32_t)c);
}


static void usage(void)
{
	fprintf(stderr, "usage: bin2c [-b] <infile> [<outfile>]\n");
	exit(EXIT_FAILURE);
}


static struct option const long_options[] = {
	{ "bin", no_argument, NULL, 'b' },
	{ "asm", no_argument, NULL, 'a' },
	{ NULL, no_argument, NULL, 0 }
};


int main(int argc, char **argv)
{
	FILE *infile, *outfile;
	const char *infilename;
	const char *outfilename = NULL;
	int c;
	int argcount;
	
	include_binheader = 0;
	while ((c = getopt_long(argc, argv, "ab", long_options, NULL)) >= 0)
	{
		switch (c)
		{
		case 'b':
			include_binheader++;
			break;
		case 'a':
			generate_asm++;
			break;
		default:
			return EXIT_FAILURE;
		}
	}
	
	argcount = argc - optind;
	if (argcount != 1 && argcount != 2)
		usage();
	infilename = argv[optind];
	if (argcount == 2)
		outfilename = argv[optind + 1];
	
	if ((infile = fopen(infilename, "rb")) == NULL)
	{
		fprintf(stderr, "%s: %s\n", infilename, strerror(errno));
		return EXIT_FAILURE;
	}
	
	if (outfilename == NULL || strcmp(outfilename, "-") == 0)
	{
		outfile = stdout;
	} else
	{
		outfile = fopen(outfilename, "wb");
		if (outfile == NULL)
		{
			fprintf(stderr, "%s: %s\n", outfilename, strerror(errno));
			return EXIT_FAILURE;
		}
	}
	
	for (;;)
	{
		uint32_t memtype;
		uint32_t org;
		uint32_t count;
		uint32_t v;
		int online;
		int perline = 2;
		
		memtype = read_word(infile);
		if (memtype == EOFFILE || memtype == MEMTYPE_EOF)
			break;
		org = read_word(infile);
		count = read_word(infile);
		online = 0;
		fprintf(outfile, "\t/* org: %c:$%04x,$%04x */\n",
			memtype == 0 ? 'P' :
			memtype == 1 ? 'X' :
			memtype == 2 ? 'Y' : '?',
			org, count);
		if (include_binheader > 0)
		{
			if (generate_asm)
			{
				fprintf(outfile, "\t.dc.b 0x%02x,0x%02x,0x%02x\n", (memtype >> 16) & 0xff, (memtype >> 8) & 0xff, (memtype) & 0xff);
				fprintf(outfile, "\t.dc.b 0x%02x,0x%02x,0x%02x\n", (org >> 16) & 0xff, (org >> 8) & 0xff, (org) & 0xff);
				fprintf(outfile, "\t.dc.b 0x%02x,0x%02x,0x%02x\n", (count >> 16) & 0xff, (count >> 8) & 0xff, (count) & 0xff);
			} else
			{
				fprintf(outfile, "\t0x%02x, 0x%02x, 0x%02x,\n", (memtype >> 16) & 0xff, (memtype >> 8) & 0xff, (memtype) & 0xff);
				fprintf(outfile, "\t0x%02x, 0x%02x, 0x%02x,\n", (org >> 16) & 0xff, (org >> 8) & 0xff, (org) & 0xff);
				fprintf(outfile, "\t0x%02x, 0x%02x, 0x%02x,\n", (count >> 16) & 0xff, (count >> 8) & 0xff, (count) & 0xff);
			}
		}
		while (count)
		{
			v = read_word(infile);
			if (v == EOFFILE)
			{
				fprintf(stderr, "%s: premature EOF\n", infilename);
				return EXIT_FAILURE;
			}
			if (generate_asm)
			{
				if (online != 0)
					putc(',', outfile);
				else
					fputs("\t.dc.b ", outfile);
				fprintf(outfile, "0x%02x,0x%02x,0x%02x", (v >> 16) & 0xff, (v >> 8) & 0xff, (v) & 0xff);
			} else
			{
				if (online != 0)
					putc(' ', outfile);
				else
					putc('\t', outfile);
				fprintf(outfile, "0x%02x, 0x%02x, 0x%02x,", (v >> 16) & 0xff, (v >> 8) & 0xff, (v) & 0xff);
			}
			++online;
			if (online == perline)
			{
				putc('\n', outfile);
				online = 0;
			}
			count--;
		}
		if (online != 0)
			putc('\n', outfile);
	}
	
	if (include_binheader > 1)
	{
		if (generate_asm)
			fprintf(outfile, "\t.dc.b 0x%02x,0x%02x,0x%02x\n", 0, 0, MEMTYPE_EOF);
		else
			fprintf(outfile, "\t0x%02x, 0x%02x, 0x%02x,\n", 0, 0, MEMTYPE_EOF);
	}
	
	fclose(infile);
	fflush(outfile);
	if (outfile != stdout)
		fclose(outfile);
	
	return EXIT_SUCCESS;
}
