/* Flic.h - header file containing structure of a flic file. 
 *
 * Copyright (c) 1992 Jim Kent.  This file may be freely used, modified,
 * copied and distributed.  This file was first published as part of
 * an article for Dr. Dobb's Journal March 1993 issue.
 */

#ifndef FLIC_H							/* Keep this from being included twice */
#define FLIC_H

#include <inttypes.h>

/* Flic Header */
typedef struct
{
	int32_t size;						/* Size of flic including this header. */
	uint16_t type;						/* Either FLI_TYPE or FLC_TYPE below. */
	uint16_t frames;					/* Number of frames in flic. */
	uint16_t width;						/* Flic width in pixels. */
	uint16_t height;					/* Flic height in pixels. */
	uint16_t depth;						/* Bits per pixel.  (Always 8 now.) */
	uint16_t flags;						/* FLI_FINISHED | FLI_LOOPED ideally. */
	int32_t speed;						/* Delay between frames. */
	int16_t reserved1;					/* Set to zero. */
	uint32_t created;					/* Date of flic creation. (FLC only.) */
	uint32_t creator;					/* Serial # of flic creator. (FLC only.) */
	uint32_t updated;					/* Date of flic update. (FLC only.) */
	uint32_t updater;					/* Serial # of flic updater. (FLC only.) */
	uint16_t aspect_dx;					/* Width of square rectangle. (FLC only.) */
	uint16_t aspect_dy;					/* Height of square rectangle. (FLC only.) */
	uint16_t ext_flag;                  /* EGI: flags for specific EGI extensions */
	uint16_t keyframes;                 /* EGI: key-image frequency */
	uint16_t totalframes;               /* EGI: total number of frames (segments) */
	uint32_t req_memory;                /* EGI: maximum chunk size (uncompressed) */
	uint16_t max_regions;               /* EGI: max. number of regions in a CHK_REGION chunk */
	uint16_t transp_num;                /* EGI: number of transparent levels */
	char reserved2[24];					/* Set to zero. */
	uint32_t oframe1;					/* Offset to frame 1. (FLC only.) */
	uint32_t oframe2;					/* Offset to frame 2. (FLC only.) */
	char reserved3[40];					/* Set to zero. */
} FlicHead;

/* Values for FlicHead.type */
#define FLI_TYPE 0xAF11u				/* 320x200 .FLI type ID */
#define FLC_TYPE 0xAF12u				/* Variable rez .FLC type ID */
#define FLH_TYPE 0xAF144u
/* Values for FlicHead.flags */
#define FLI_FINISHED 0x0001
#define FLI_LOOPED	 0x0002

/* Optional Prefix Header */
typedef struct
{
	int32_t size;						/* Size of prefix including header. */
	uint16_t type;						/* Always PREFIX_TYPE. */
	int16_t chunks;						/* Number of subchunks in prefix. */
	char reserved[8];					/* Always 0. */
} PrefixHead;

/* Value for PrefixHead.type */
#define PREFIX_TYPE  0xF100u

/* Frame Header */
typedef struct
{
	int32_t size;						/* Size of frame including header. */
	uint16_t type;						/* Always FRAME_TYPE */
	int16_t chunks;						/* Number of chunks in frame. */
	char reserved[8];					/* Always 0. */
} FrameHead;

/* Value for FrameHead.type */
#define FRAME_TYPE 0xF1FAu

/* Chunk Header */
typedef struct
{
	int32_t size;						/* Size of chunk including header. */
	uint16_t type;						/* Value from ChunkTypes below. */
} ChunkHead;

#undef BLACK

enum ChunkTypes
{
	COLOR_256 = 4,						/* 256 level color pallette info. (FLC only.) */
	DELTA_FLC = 7,						/* Word-oriented delta compression. (FLC only.) */
	COLOR_64 = 11,						/* 64 level color pallette info. */
	DELTA_FLI = 12,						/* Byte-oriented delta compression. */
	BLACK = 13,							/* whole frame is color 0 */
	BYTE_RUN = 15,						/* Byte run-length compression. */
	LITERAL = 16,						/* Uncompressed pixels. */
	PSTAMP = 18,						/* "Postage stamp" chunk. (FLC only.) */
};

static inline uint16_t le16tocpu(const unsigned char *data)
{
	return data[0] | (data[1] << 8);
}

static inline uint16_t le32tocpu(const unsigned char *data)
{
	uint32_t val = *data++;
	val |= (uint32_t)*data++ << 8;
	val |= (uint32_t)*data++ << 16;
	val |= (uint32_t)*data++ << 24;
	return val;
}

#endif /* FLIC_H */
