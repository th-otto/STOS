		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "equates.inc"
		.include "lib.inc"

MAXPAL = 512 /* ?? why 512? */

MON_MONO		= 0
MON_COLOR		= 1
MON_VGA			= 2
MON_TV			= 3

BPS1			= 0x00
BPS2			= 0x01
BPS4			= 0x02
BPS8			= 0x03
BPS16			= 0x04
BPS32			= 0x05	/* SuperVidel's RGBx truecolour (4 bytes per pixel) */
BPS8C			= 0x07	/* SuperVidel's 8-bit chunky mode */
COL80			= 0x08	/* 80 column if set, else 40 column */
COL40			= 0x00
VGA				= 0x10	/* VGA if set, else TV mode */
TV				= 0x00
PAL				= 0x20	/* PAL if set, else NTSC */
NTSC			= 0x00
OVERSCAN		= 0x40	/* Multiply X&Y rez by 1.2, ignored on VGA */
STMODES			= 0x80	/* ST compatible */
VERTFLAG		= 0x100	/* double-line on VGA, interlace on ST/TV */

		.text

* Define extension addresses

start:
	dc.l	para-start		; parameter definitions
	dc.l	entry-start		; reserve data area for program
	dc.l	lib1-start		; start of library

catalog:
	dc.w	lib2-lib1
	dc.w	lib3-lib2
	dc.w	lib4-lib3
	dc.w	lib5-lib4
	dc.w	lib6-lib5
	dc.w	lib7-lib6
	dc.w	lib8-lib7
	dc.w	lib9-lib8
	dc.w	lib10-lib9
	dc.w	lib11-lib10
	dc.w	lib12-lib11
	dc.w	lib13-lib12
	dc.w	lib14-lib13
	dc.w	lib15-lib14
	dc.w	lib16-lib15
	dc.w	lib17-lib16
	dc.w	lib18-lib17
	dc.w	lib19-lib18
	dc.w	lib20-lib19
	dc.w	lib21-lib20
	dc.w	lib22-lib21
	dc.w	lib23-lib22
	dc.w	lib24-lib23
	dc.w	lib25-lib24
	dc.w	lib26-lib25
	dc.w	lib27-lib26
	dc.w	lib28-lib27
	dc.w	lib29-lib28
	dc.w	lib30-lib29
	dc.w	lib31-lib30
	dc.w	lib32-lib31
	dc.w	lib33-lib32
	dc.w	lib34-lib33
	dc.w	lib35-lib34
	dc.w	lib36-lib35
	dc.w	lib37-lib36
	dc.w	lib38-lib37
	dc.w	lib39-lib38
	dc.w	lib40-lib39
	dc.w	lib41-lib40
	dc.w	lib42-lib41
	dc.w	lib43-lib42
	dc.w	lib44-lib43
	dc.w	lib45-lib44
	dc.w	lib46-lib45
	dc.w	lib47-lib46
	dc.w	libex-lib47

para:
	dc.w	47			; number of library routines
	dc.w	47			; number of extension commands

	.dc.w l001-para
	.dc.w l002-para
	.dc.w l003-para
	.dc.w l004-para
	.dc.w l005-para
	.dc.w l006-para
	.dc.w l007-para
	.dc.w l008-para
	.dc.w l009-para
	.dc.w l010-para
	.dc.w l011-para
	.dc.w l012-para
	.dc.w l013-para
	.dc.w l014-para
	.dc.w l015-para
	.dc.w l016-para
	.dc.w l017-para
	.dc.w l018-para
	.dc.w l019-para
	.dc.w l020-para
	.dc.w l021-para
	.dc.w l022-para
	.dc.w l023-para
	.dc.w l024-para
	.dc.w l025-para
	.dc.w l026-para
	.dc.w l027-para
	.dc.w l028-para
	.dc.w l029-para
	.dc.w l030-para
	.dc.w l031-para
	.dc.w l032-para
	.dc.w l033-para
	.dc.w l034-para
	.dc.w l035-para
	.dc.w l036-para
	.dc.w l037-para
	.dc.w l038-para
	.dc.w l039-para
	.dc.w l040-para
	.dc.w l041-para
	.dc.w l042-para
	.dc.w l043-para
	.dc.w l044-para
	.dc.w l045-para
	.dc.w l046-para
	.dc.w l047-para


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,1,1,0           ; vsetmode
l002:	.dc.b I,1,1,0             ; vgetmode
l003:	.dc.b 0,I,1,1,0           ; _falc cls
l004:	.dc.b I,I,1,1,0           ; vgetsize
l005:	.dc.b 0,I,1,1,0           ; vgetpalt
l006:	.dc.b I,1,1,0             ; montype
l007:	.dc.b 0,I,1,1,0           ; vsetpalt
l008:	.dc.b I,I,',',I,',',I,1   ; whichmode
        .dc.b   I,',',I,',',I,',',I,1,1,0
l009:	.dc.b 0,1,1,0             ; _get spritepalette
l010:	.dc.b I,1,1,0             ; scr width
l011:	.dc.b 0,I,1,1,0           ; _hardphysic
l012:	.dc.b I,1,1,0             ; scr height
l013:	.dc.b 0,I,',',I,1         ; setcolour
        .dc.b   I,',',I,',',I,',',I,1,1,0
l014:	.dc.b I,I,1,1,0           ; _getcolour
l015:	.dc.b 0,I,1               ; _get st palette
        .dc.b   I,',',I,1,1,0
l016:	.dc.b I,I,1,1,0           ; _falc rgb
l017:	.dc.b 0,1,1,0             ; palfade in
l018:	.dc.b I,I,1,1,0           ; _falc palt BUG: count parameter missing
l019:	.dc.b 0,1,1,0             ; palfade out
l020:	.dc.b I,1,1,0             ; darkest
l021:	.dc.b 0,I,',',I,1,1,0     ; quickwipe
l022:	.dc.b I,1,1,0             ; brightest
l023:	.dc.b 0,I,1,1,0           ; ilbmpalt
l024:	.dc.b I,I,1,1,0           ; _get red
l025:	.dc.b 0,1,1,0             ; _shift off
l026:	.dc.b I,I,1,1,0           ; _get green
l027:	.dc.b 0,I,',',I,1,1,0     ; _shift
l028:	.dc.b I,I,1,1,0           ; _get blue
l029:	.dc.b 0,1,1,0
l030:	.dc.b I,I,1               ; vget ilbm mode
        .dc.b   I,',',I,1,1,0
l031:	.dc.b 0,1,1,0
l032:	.dc.b I,I,',',I,1,1,0     ; dpack ilbm
l033:	.dc.b 0,1,1,0
l034:	.dc.b I,I,1,1,0           ; fmchunk
l035:	.dc.b 0,1,1,0
l036:	.dc.b I,I,1,1,0           ; _falc zone
l037:	.dc.b 0,1,1,0
l038:	.dc.b I,I,1,1,0           ; ilbmchunk
l039:	.dc.b 0,1,1,0             ; _reset falc zone
l040:	.dc.b I,I,1,1,0           ; bmhdchunk
l041:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0  ; _set falc zone
l042:	.dc.b I,I,1,1,0           ; cmapchunk
l043:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1  ; _paste pi1
        .dc.b   I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0
l044:	.dc.b I,I,1,1,0           ; bodychunk
l045:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0  ; _bitblit
l046:	.dc.b I,1,1,0
l047:	.dc.b 0,I,',',I,1         ; _convert pi1
        .dc.b   I,',',I,',',I,1,1,0

		.even

entry:
	bra.w init

params_offset: dc.l params-entry
switchmode_offset: dc.l switchmode-entry
getilbmchunks_offset: dc.l getilbmchunks-entry
modetable_offset: dc.l modetable-entry
convert2rgb_offset: dc.l convert2rgb-entry
installvbl_offset: dc.l installvbl-entry
restorevbl_offset: dc.l restorevbl-entry


params: /* 1022a */
ilbm_form: ds.l 1
ilbm_ilbm: ds.l 1
ilbm_bmhd: ds.l 1
ilbm_cmap: ds.l 1
ilbm_body: ds.l 1
ilbm_width: ds.w 1 /* 20 */
ilbm_height: ds.w 1 /* 22 */
ilbm_xorigin: ds.w 1 /* 24 */
ilbm_yorigin: ds.w 1 /* 26 */
ilbm_planes: ds.w 1 /* 28 */
ilbm_compression: ds.b 2 /* 30 */
ilbm_cmapsize: ds.w 1 /* 32 */
ilbm_size:	ds.l 1 /* 34 */
	ds.l 1 /* unused */
ilbm_addr: ds.l 1 /* 42 */
dpack_ptr: ds.l 1
ilbm_height2: ds.w 1 /* 50 */
ilbm_bytes: ds.w 1 /* 52 */
ilbm_bytes_lin: ds.w 1 /* 54 */
ilbm_planes2: ds.w 1
ilbm_nxwd: ds.l 1 /* 58 */
	ds.w 1 /* unused */

falcon_mode: ds.w 1 /* 1407a, 64 */
	ds.l 1

fade1tab: ds.l 256
fade2tab: ds.l 256
fade3tab: ds.l 256

	ds.b 478 /* unused */

modetable:
          /* mode                            width,height, bytes,scanl,planes,hht,hbb,hbe, hdb,hde,hss, vft, vbb,vbe,vdb, vde, vss,vco, vmc */
		dc.w STMODES+PAL+BPS4,                 320,   200,   160,   80,     4, 62, 50,  9, 575, 28, 52, 625, 613, 47,111, 511, 619,  0,$083
		dc.w STMODES+PAL+COL80+BPS2,           640,   200,   160,   80,     2, 62, 50,  9, 575, 28, 52, 625, 613, 47,111, 511, 619,  4,$083
		dc.w VERTFLAG+STMODES+PAL+COL80+BPS1,  640,   400,    80,   40,     1,510,409, 80,1007,160,434, 624, 613, 47,126, 526, 619,  6,$183
		dc.w PAL+BPS8,                         320,   200,   320,  160,     8,254,203, 39,  28,125,216, 625, 613, 47,127, 527, 619,  0,$183
		dc.w PAL+BPS16,                        320,   200,   640,  320,    16,254,203, 39,  46,143,216, 625, 613, 47,127, 527, 619,  0,$183
		dc.w VERTFLAG+PAL+BPS4,                320,   400,   160,   80,     4,254,203, 39,  12,109,216, 624, 613, 47,126, 526, 619,  2,$183
		dc.w VERTFLAG+PAL+BPS8,                320,   400,   320,  160,     8,254,203, 39,  28,125,216, 624, 613, 47,126, 526, 619,  2,$183
		dc.w VERTFLAG+PAL+BPS16,               320,   400,   640,  320,    16,254,203, 39,  46,143,216, 624, 613, 47,126, 526, 619,  2,$183
		dc.w PAL+OVERSCAN+BPS4,                384,   240,   192,   96,     4,254,203, 39, 748,141,216, 625, 613, 47, 87, 567, 619,  0,$183
		dc.w PAL+OVERSCAN+BPS8,                384,   240,   384,  192,     8,254,203, 39, 764,157,216, 625, 613, 47, 87, 567, 619,  0,$183
		dc.w PAL+OVERSCAN+BPS16,               384,   240,   768,  384,    16,254,203, 39,  14,175,216, 625, 613, 47, 87, 567, 619,  0,$183
		dc.w VERTFLAG+PAL+OVERSCAN+BPS4,       384,   480,   192,   96,     4,254,203, 39, 748,141,216, 624, 613, 47, 86, 566, 619,  2,$183
		dc.w VERTFLAG+PAL+OVERSCAN+BPS8,       384,   480,   384,  192,     8,254,203, 39, 764,157,216, 624, 613, 47, 86, 566, 619,  2,$183
		dc.w VERTFLAG+PAL+OVERSCAN+BPS16,      384,   480,   768,  384,    16,254,203, 39,  14,175,216, 624, 613, 47, 86, 566, 619,  2,$183
		dc.w PAL+COL80+BPS4,                   640,   200,   320,  160,     4,510,409, 80,  77,254,434, 625, 613, 47,127, 527, 619,  4,$183
		dc.w PAL+COL80+BPS8,                   640,   200,   640,  320,     8,510,409, 80,  93,270,434, 625, 613, 47,127, 527, 619,  4,$183
		dc.w PAL+COL80+BPS16,                  640,   200,  1280,  640,    16,510,409, 80, 113,290,434, 625, 613, 47,127, 527, 619,  4,$183
		dc.w PAL+COL80+$1000+BPS4,             640,   240,   320,  160,     4,510,409, 80,  77,254,434, 625, 613, 47, 87, 567, 619,  4,$183
		dc.w PAL+COL80+$1000+BPS8,             640,   240,   640,  320,     8,510,409, 80,  93,270,434, 625, 613, 47, 87, 567, 619,  4,$183
		dc.w VERTFLAG+PAL+COL80+BPS2,          640,   400,   160,   80,     2, 62, 48,  8,   2, 32, 52, 624, 613, 47,126, 526, 619,  6,$183
		dc.w VERTFLAG+PAL+COL80+BPS4,          640,   400,   320,  160,     4,510,409, 80,  77,254,434, 624, 613, 47,126, 526, 619,  6,$183
		dc.w VERTFLAG+PAL+COL80+BPS8,          640,   400,   640,  320,     8,510,409, 80,  93,270,434, 624, 613, 47,126, 526, 619,  6,$183
		dc.w VERTFLAG+PAL+COL80+BPS16,         640,   400,  1280,  640,    16,510,409, 80, 113,290,434, 624, 613, 47,126, 526, 619,  6,$183
		dc.w VERTFLAG+PAL+COL80+$1000+BPS4,    640,   480,   320,  160,     4,510,409, 80,  77,254,434, 672, 577, 97, 96, 576, 669,  6,$183
		dc.w VERTFLAG+PAL+COL80+$1000+BPS8,    640,   480,   640,  320,     8,510,409, 80,  93,270,434, 672, 577, 97, 96, 576, 669,  6,$183
		dc.w VERTFLAG+PAL+COL80+$1000+BPS16,   640,   480,  1280,  640,    16,510,409, 80, 113,290,434, 672, 576, 97, 96, 576, 669,  6,$183
		dc.w PAL+COL80+OVERSCAN+BPS4,          768,   240,   384,  192,     4,510,360, 80,  13,318,418, 625, 613, 47, 87, 567, 624,  4,$183
		dc.w PAL+COL80+OVERSCAN+BPS8,          768,   240,   768,  384,     8,510,409, 80,  35,340,422, 625, 613, 47, 87, 567, 619,  4,$183
		dc.w PAL+COL80+OVERSCAN+BPS16,         768,   240,  1536,  768,    16,510,409, 80,  49,354,434, 625, 613, 47, 87, 567, 619,  4,$183
		dc.w VERTFLAG+PAL+COL80+OVERSCAN+BPS4, 768,   480,   384,  192,     4,510,409, 80,  13,318,434, 624, 613, 47, 86, 566, 619,  6,$183
		dc.w VERTFLAG+PAL+COL80+OVERSCAN+BPS8, 768,   480,   768,  384,     8,510,409, 80,  29,334,434, 624, 613, 47, 86, 566, 619,  6,$183
		dc.w VERTFLAG+PAL+COL80+OVERSCAN+BPS16,768,   480,  1536,  768,    16,510,409, 80,  49,354,434, 624, 613, 47, 86, 566, 619,  6,$183
		dc.w VERTFLAG+PAL+VGA+BPS4,            320,   240,   160,   80,     4,198,141, 21, 650,107,150,1049,1023, 63, 63,1023,1045,  5,$186
		dc.w VERTFLAG+PAL+VGA+BPS8,            320,   240,   320,  160,     8,198,141, 21, 666,123,150,1049,1023, 63, 63,1023,1045,  5,$186
		dc.w VERTFLAG+PAL+VGA+BPS16,           320,   240,   640,  320,    16,198,141, 21, 684,145,150,1049,1023, 63, 63,1023,1045,  5,$186
		dc.w PAL+VGA+BPS4,                     320,   480,   160,   80,     4,198,141, 21, 650,107,150,1049,1023, 63, 63,1023,1045,  4,$186
		dc.w PAL+VGA+BPS8,                     320,   480,   320,  160,     8,198,141, 21, 666,123,150,1049,1023, 63, 63,1023,1045,  4,$186
		dc.w PAL+VGA+BPS16,                    320,   480,   640,  320,    16,198,141, 21, 684,145,150,1049,1023, 63, 63,1023,1045,  4,$186
		dc.w VERTFLAG+PAL+VGA+COL80+BPS2,      640,   240,   160,   80,     2, 23, 18,  1, 526, 13, 17,1049,1023, 63, 63,1023,1045,  9,$186
		dc.w VERTFLAG+PAL+VGA+COL80+BPS4,      640,   240,   320,  160,     4,198,141, 21, 675,124,140,1049,1023, 63, 63,1023,1045,  9,$186
		dc.w VERTFLAG+PAL+VGA+COL80+BPS8,      640,   240,   640,  320,     8,198,141, 21, 683,132,140,1049,1023, 63, 63,1023,1045,  9,$186
		dc.w PAL+VGA+COL80+BPS1,               640,   480,    80,   40,     1,198,141, 21, 627, 80,150,1049,1023, 63, 63,1023,1045,  8,$186
		dc.w PAL+VGA+COL80+BPS2,               640,   480,   160,   80,     2, 23, 18,  1, 526, 13, 17,1049,1023, 63, 63,1023,1045,  8,$186
		dc.w PAL+VGA+COL80+BPS4,               640,   480,   320,  160,     4,198,141, 21, 675,124,140,1049,1023, 63, 63,1023,1045,  8,$186
		dc.w PAL+VGA+COL80+BPS8,               640,   480,   640,  320,     8,198,141, 21, 683,132,140,1049,1023, 63, 63,1023,1045,  8,$186
		dc.w PAL+VGA+$2000+BPS16,              640,   480,  1280,  640,    16,386,295, 43, 894,295,293,1033,1025, 65, 65,1025,1029,  4,$182
		dc.w VERTFLAG+PAL+VGA+COL80+$2000+BPS4,768,   240,   384,  192,     4,236,178, 23, 724,168,172,1049,1023, 63, 63,1023,1045,  9,$182
		dc.w VERTFLAG+PAL+VGA+COL80+$2000+BPS8,768,   240,   768,  384,     8,236,171, 23, 725,168,160,1049,1023, 63, 63,1023,1045,  9,$182
		dc.w PAL+VGA+COL80+$2000+BPS4,         768,   480,   384,  192,     4,236,177, 23, 723,168,172,1049,1023, 63, 63,1023,1045,  8,$182
		dc.w PAL+VGA+COL80+$2000+BPS8,         768,   480,   768,  384,     8,236,169, 23, 723,168,161,1049,1023, 63, 63,1023,1045,  8,$182
		dc.w VERTFLAG+PAL+VGA+COL80+$3000+BPS4,800,   320,   400,  200,     4,240,181, 23, 719,168,173,1345,1305, 15, 25,1306,1306,  9,$182
		dc.w VERTFLAG+PAL+VGA+COL80+$3000+BPS8,800,   320,   800,  400,     8,241,180, 23, 728,171,172,1345,1329, 45, 49,1330,1332,  9,$182
modetable_end:
		dc.w -1,-1


switchmode:
		movem.l    a0-a6,-(a7)
		lea.l      modetable(pc),a5
		lea.l      modetable_end(pc),a6
switchmode1:
		cmpa.l     a5,a6
		beq        switchmode4
		move.w     (a5),d0
		cmp.w      d0,d3
		beq.s      switchmode2
		lea.l      40(a5),a5
		bra.s      switchmode1
switchmode2:
		nop
		move.w     2(a5),d1 /* width */
		move.w     4(a5),d2 /* height */
		movem.l    d1-d2/a5,-(a7)
		dc.w       0xa000 /* linea_init */
		movem.l    (a7)+,d1-d2/a5
		movea.l    d0,a0
		move.w     d1,DEV_TAB(a0)
		/* subq.w     #1,DEV_TAB(a0) */
		dc.w 0x0468,1,DEV_TAB /* XXX */
		move.w     d1,V_REZ_HZ(a0)
		move.w     #0,LA_XMN_CLIP(a0)
		move.w     #0,LA_YMN_CLIP(a0)
		move.w     d1,LA_XMX_CLIP(a0)
		/* subq.w     #1,LA_XMX_CLIP(a0) */
		dc.w 0x0468,1,LA_XMX_CLIP /* XXX */
		move.w     d2,LA_YMX_CLIP(a0)
		/* subq.w     #1,LA_YMX_CLIP(a0) */
		dc.w 0x0468,1,LA_YMX_CLIP /* XXX */
		move.w     #-1,LA_CLIP(a0)
		move.w     10(a5),LA_PLANES(a0)
		move.w     4(a5),DEV_TAB+2(a0)
		/* subq.w     #1,DEV_TAB+2(a0) */
		dc.w 0x0468,1,DEV_TAB+2 /* XXX */
		move.w     4(a5),V_REZ_VT(a0)
		move.w     d1,d0
		lsr.w      #3,d0
		subq.w     #1,d0
		move.w     d0,V_CEL_MX(a0)
		move.w     V_CEL_HT(a0),d0
		move.w     4(a5),d1
		ext.l      d1
		divs.w     d0,d1
		/* subq.w     #1,d1 */
		dc.w 0x0441,1 /* XXX */
		move.w     d1,V_CEL_MY(a0)
		move.w     6(a5),d2 /* bytes_lin */
		move.w     d2,V_BYTES_LIN(a0)
		move.w     d2,LA_LIN_WR(a0)
		muls.w     d0,d2
		move.w     d2,V_CEL_WR(a0)
		move.w     10(a5),d3 /* planes */
		move.w     #2,DEV_TAB+26(a0)
		move.w     #2,DEV_TAB+78(a0)
		cmpi.w     #1,d3
		beq.s      switchmode3
		move.w     #4,DEV_TAB+26(a0)
		move.w     #4,DEV_TAB+78(a0)
		cmpi.w     #2,d3
		beq.s      switchmode3
		move.w     #16,DEV_TAB+26(a0)
		move.w     #16,DEV_TAB+78(a0)
		cmpi.w     #4,d3
		beq.s      switchmode3
		move.w     #256,DEV_TAB+26(a0)
		move.w     #256,DEV_TAB+78(a0)
		cmpi.w     #8,d3
		beq.s      switchmode3
		move.w     #256,DEV_TAB+26(a0)
		move.w     #0,DEV_TAB+78(a0)
switchmode3:
		lea.l      scanline_width,a4 /* BUG: absolute address */
		move.w     8(a5),(a4)
		pea.l      set_scanline(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
switchmode4:
		movem.l    (a7)+,a0-a6
		rts

set_scanline:
		lea.l      scanline_width,a4 /* BUG: not allowed to trash a4 */ /* BUG: absolute address */
		move.w     (a4),d0
		move.w     d0,($FFFF8210).w
		rts

scanline_width: dc.w       0

getilbmchunks:
		movem.l    a0-a6,-(a7)
		bsr.s      ilbm_find_form
		tst.l      d7
		bne.s      getilbmchunks1
		bsr.s      ilbm_find_ilbm
		tst.l      d7
		bne.s      getilbmchunks1
		bsr        ilbm_find_bmhd
		tst.l      d7
		bne.s      getilbmchunks1
		bsr        ilbm_find_cmap
		tst.l      d7
		bne.s      getilbmchunks1
		bsr        ilbm_find_body
		tst.l      d7
		bne.s      getilbmchunks1
		movem.l    (a7)+,a0-a6
		rts
getilbmchunks1:
		movem.l    (a7)+,a0-a6
		moveq.l    #-1,d7
		rts


/* FIXME: walk through list of chunks instead */
ilbm_find_form:
		lea.l      params(pc),a6
		movea.l    ilbm_addr-params(a6),a0
		move.l     ilbm_size-params(a6),d7
ilbm_find_form1:
		tst.l      d7
		beq.s      ilbm_find_form2
		subq.l     #1,d7
		cmpi.b     #'F',(a0)+
		bne.s      ilbm_find_form1
		cmpi.b     #'O',(a0)
		bne.s      ilbm_find_form1
		cmpi.b     #'R',1(a0)
		bne.s      ilbm_find_form1
		cmpi.b     #'M',2(a0)
		bne.s      ilbm_find_form1
		subq.l     #1,a0
		move.l     a0,ilbm_form-params(a6)
		moveq.l    #0,d7
		rts
ilbm_find_form2:
		moveq.l    #-1,d7
		rts


/* FIXME: walk through list of chunks instead */
ilbm_find_ilbm:
		lea.l      params(pc),a6
		movea.l    ilbm_addr-params(a6),a0
		move.l     ilbm_size-params(a6),d7
ilbm_find_ilbm1:
		tst.l      d7
		beq.s      ilbm_find_ilbm2
		subq.l     #1,d7
		cmpi.b     #'I',(a0)+
		bne.s      ilbm_find_ilbm1
		cmpi.b     #'L',(a0)
		bne.s      ilbm_find_ilbm1
		cmpi.b     #'B',1(a0)
		bne.s      ilbm_find_ilbm1
		cmpi.b     #'M',2(a0)
		bne.s      ilbm_find_ilbm1
		subq.l     #1,a0
		move.l     a0,ilbm_ilbm-params(a6)
		moveq.l    #0,d7
		rts
ilbm_find_ilbm2:
		moveq.l    #-1,d7
		rts

/* FIXME: walk through list of chunks instead */
ilbm_find_bmhd:
		lea.l      params(pc),a6
		movea.l    ilbm_addr-params(a6),a0
		move.l     ilbm_size-params(a6),d7
ilbm_find_bmhd1:
		tst.l      d7
		beq.s      ilbm_find_bmhd2
		subq.l     #1,d7
		cmpi.b     #'B',(a0)+
		bne.s      ilbm_find_bmhd1
		cmpi.b     #'M',(a0)
		bne.s      ilbm_find_bmhd1
		cmpi.b     #'H',1(a0)
		bne.s      ilbm_find_bmhd1
		cmpi.b     #'D',2(a0)
		bne.s      ilbm_find_bmhd1
		subq.l     #1,a0
		move.l     a0,ilbm_bmhd-params(a6)
		move.w     8(a0),ilbm_width-params(a6)
		move.w     10(a0),ilbm_height-params(a6)
		move.w     10(a0),ilbm_height2-params(a6)
		move.w     12(a0),ilbm_xorigin-params(a6)
		move.w     14(a0),ilbm_yorigin-params(a6)
		move.b     16(a0),d5
		andi.w     #255,d5
		move.w     d5,ilbm_planes-params(a6)
		move.b     18(a0),ilbm_compression-params(a6)
		moveq.l    #0,d7
		rts
ilbm_find_bmhd2:
		moveq.l    #-1,d7
		rts

/* FIXME: walk through list of chunks instead */
ilbm_find_cmap:
		lea.l      params(pc),a6
		movea.l    ilbm_addr-params(a6),a0
		move.l     ilbm_size-params(a6),d7
ilbm_find_cmap1:
		tst.l      d7
		beq.s      ilbm_find_cmap2
		subq.l     #1,d7
		cmpi.b     #'C',(a0)+
		bne.s      ilbm_find_cmap1
		cmpi.b     #'M',(a0)
		bne.s      ilbm_find_cmap1
		cmpi.b     #'A',1(a0)
		bne.s      ilbm_find_cmap1
		cmpi.b     #'P',2(a0)
		bne.s      ilbm_find_cmap1
		subq.l     #1,a0
		move.l     a0,ilbm_cmap-params(a6)
		move.l     4(a0),d0
		divu.w     #3,d0
		move.w     d0,ilbm_cmapsize-params(a6)
		moveq.l    #0,d7
		rts
ilbm_find_cmap2:
		moveq.l    #-1,d7
		rts

/* FIXME: walk through list of chunks instead */
ilbm_find_body:
		lea.l      params(pc),a6
		movea.l    ilbm_addr-params(a6),a0
		move.l     ilbm_size-params(a6),d7
ilbm_find_body1:
		tst.l      d7
		beq.s      ilbm_find_body2
		subq.l     #1,d7
		cmpi.b     #'B',(a0)+
		bne.s      ilbm_find_body1
		cmpi.b     #'O',(a0)
		bne.s      ilbm_find_body1
		cmpi.b     #'D',1(a0)
		bne.s      ilbm_find_body1
		cmpi.b     #'Y',2(a0)
		bne.s      ilbm_find_body1
		subq.l     #1,a0
		move.l     a0,ilbm_body-params(a6)
		moveq.l    #0,d7
		rts
ilbm_find_body2:
		moveq.l    #-1,d7
		rts



convert2rgb:
		clr.l      d2
		clr.l      d3
		move.w     d0,d1
		move.w     d0,d2
		move.w     d0,d3
		andi.l     #0x00000F00,d1
		lsl.l      #8,d1
		lsl.l      #5,d1
		andi.l     #0x000000F0,d2
		lsl.l      #5,d2
		lsl.l      #4,d2
		andi.l     #15,d3
		lsl.l      #5,d3
		or.l       d3,d2
		or.l       d2,d1
		move.l     d1,d0
		rts

installvbl:
		lea        vblstart(pc),a1
		move.l     d0,(a1)
		move.w     shift_flag(pc),d0
		tst.w      d0
		bne.s      installvbl1
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		andi.l     #7,d0
		cmpi.w     #BPS8,d0
		bne.s      installvbl1
		andi.l     #3,d0
		moveq.l    #1,d7
		asl.l      d0,d7
		moveq.l    #1,d6
		asl.l      d7,d6
		move.l     d6,d7
		andi.l     #MAXPAL-1,d7
		lea.l      rgbpalette(pc),a0
		move.l     a0,-(a7)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		pea.l      sinstallvbl(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      shift_flag(pc),a0
		move.w     #-1,(a0)
installvbl1:
		rts

sinstallvbl:
		lea.l      gooldvbl+2(pc),a0
		move.l     $00000070.l,(a0) /* XXX */
		lea.l      newvbl(pc),a1
		move.l     a1,$00000070.l /* XXX */
		lea        vblcount(pc),a1
		clr.w      (a1)
		rts

restorevbl:
		move.w     shift_flag(pc),d0
		tst.w      d0
		beq.s      restorevbl1
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		andi.l     #7,d0
		cmpi.w     #BPS8,d0
		bne.s      restorevbl1
		pea.l      srestorevbl(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		pea.l      rgbpalette(pc)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		lea.l      shift_flag(pc),a0
		move.w     #0,(a0)
restorevbl1:
		rts

srestorevbl:
		movea.l    gooldvbl+2(pc),a0
		/* movea.w    #$0070,a1 */
		dc.w 0x227c,0,0x70 /* XXX */
		move.l     a0,(a1)
		lea        vblcount(pc),a1
		clr.w      (a1)
		rts

newvbl:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      vblcount(pc),a4
		/* addq.w     #1,(a4) */
		dc.w 0x0654,1 /* XXX */
		move.w     (a4),d0
		cmp.w      vbldelay(pc),d0
		blt.s      newvbl2
		movea.l    #$00FF9800,a0 /* XXX */
		move.l     #255-1,d6
		clr.l      d7
		move.w     vblstart(pc),d7
		sub.w      d7,d6
		asl.l      #2,d7
		adda.l     d7,a0
		lea.l      4(a0),a1
		move.l     (a0),d5
newvbl1:
		move.l     (a1)+,(a0)+
		dbf        d6,newvbl1
		move.l     d5,(a0)
		clr.w      (a4)
newvbl2:
		movem.l    (a7)+,d0-d7/a0-a6
gooldvbl: jmp        0.l

vblstart: dc.w 0
vbldelay: dc.w 0
vblcount: dc.w 0

shift_flag: dc.w 0

rgbpalette: ds.l 256 /* 11ca2 */


init:
		lea exit(pc),a2
		rts

exit:
		rts


/*
 * Syntax:   vsetmode VID_MDE
 */
lib1:
	dc.w	0			; no library calls
vsetmode:
		move.l     (a6)+,d3
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		movem.l    d1-d3/a0-a6,-(a7)
		lea.l      vsetmode_mode(pc),a1
		move.w     d3,(a1)
		btst       #7,d3 /* ST-compatible? */
		bne.s      vsetmode1
		move.w     #S_hide,d0
		moveq.l    #0,d1
		trap       #5
vsetmode1:
		move.w     vsetmode_mode(pc),d0
		andi.l     #$1ff,d0
		move.w     d0,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.w     #89,-(a7) /* VgetMonitor */
		trap       #14
		addq.l     #2,a7
		lea.l      vsetmode_montype(pc),a1
		andi.l     #3,d0
		move.w     d0,(a1)
		movem.l    (a7)+,d1-d3/a0-a6
		move.l     debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     modetable_offset-entry(a0),d2
		add.l      d2,a0
		lea        ptr_modetable(pc),a1
		move.l     a0,(a1)
		movem.l    d1-d3/a0-a6,-(a7)
		pea.l      initvidel(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d3/a0-a6
		move.l     debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     switchmode_offset-entry(a0),d0
		adda.l     d0,a0
		move.w     vsetmode_mode(pc),d3
		jsr        (a0)
		move.w     vsetmode_mode(pc),d1
		andi.l     #$1ff,d1
		move.l     falcon_screensize(pc),d2
		moveq.l    #S_falc_initmode,d0
		trap       #5
		rts

ptr_modetable: dc.l 0

initvidel:
		lea        falcon_screensize(pc),a0
		move.l     #32768,(a0)
		move.l     ptr_modetable(pc),a4
		move.w     vsetmode_mode(pc),d3
initvidel1:
		cmpi.l     #-1,(a4)
		beq.s      initvidel3
		cmp.w      ZERO(a4),d3
		beq.s      initvidel2
		lea.l      40(a4),a4
		bra.s      initvidel1
initvidel2:
		lea.l      12(a4),a3
		move.w     (a3)+,($FFFF8282).w
		move.w     (a3)+,($FFFF8284).w
		move.w     (a3)+,($FFFF8286).w
		move.w     (a3)+,($FFFF8288).w
		move.w     (a3)+,($FFFF828A).w
		move.w     (a3)+,($FFFF828C).w
		move.w     (a3)+,($FFFF82A2).w
		move.w     (a3)+,($FFFF82A4).w
		move.w     (a3)+,($FFFF82A6).w
		move.w     (a3)+,($FFFF82A8).w
		move.w     (a3)+,($FFFF82AA).w
		move.w     (a3)+,($FFFF82AC).w
		move.w     (a3)+,($FFFF82C2).w
		move.w     (a3)+,($FFFF82C0).w
		moveq.l    #0,d0
		move.w     6(a4),d0
		mulu.w     4(a4),d0
		lea.l      falcon_screensize(pc),a0
		move.l     d0,(a0)
initvidel3:
		rts

vsetmode_mode: dc.w 0
vsetmode_montype: dc.w 0
falcon_screensize: ds.l 1 /* 14036 */

/*
 * Syntax:   VID_MDE=vgetmode
 */
lib2:
	dc.w	0			; no library calls
vgetmode:
		movem.l    a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _falc cls SCR_ADDRESS
 */
lib3:
	dc.w lib3_1-lib3
	dc.w	0
falc_cls:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      falc_cls1
		movem.l    a0-a1,-(a7) /* XXX useless */
		move.l     d3,-(a6)
lib3_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1 /* XXX useless */
falc_cls1:
		lea.l      cls_address(pc),a1
		move.l     d3,(a1)
		movem.l    d1-d7/a0-a6,-(a7)
		moveq.l    #S_st_mouse_stat,d0
		trap       #5
		lea.l      cls_mousestat(pc),a0
		move.w     d1,(a0)
		tst.w      d1
		beq.s      falc_cls2
		moveq.l    #S_st_mouse_off,d0
		trap       #5
falc_cls2:
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.w     d0,-(a7)
		move.w     #91,-(a7) /* VgetSize */
		trap       #14
		addq.l     #4,a7
		asr.l      #5,d0
		lea.l      cls_zeroes(pc),a0
		movem.l    (a0)+,d1-d4/a1-a4
		movea.l    cls_address(pc),a0
falc_cls3:
		move.l     d1,(a0)+
		move.l     d2,(a0)+
		move.l     d3,(a0)+
		move.l     d4,(a0)+
		move.l     a1,(a0)+
		move.l     a2,(a0)+
		move.l     a3,(a0)+
		move.l     a4,(a0)+
		dbne       d0,falc_cls3
		moveq.l    #S_falc_initfont,d0
		trap       #5
		moveq.l    #0,d1
		moveq.l    #S_falc_locate,d0
		trap       #5
		moveq      #S_multipen_off,d0 /* BUG: why? */
		trap       #5
		move.w     cls_mousestat(pc),d0
		tst.w      d0
		beq.s      falc_cls4
		moveq.l    #S_st_mouse_on,d0
		trap       #5
falc_cls4:
		movem.l    (a7)+,d1-d7/a0-a6
		rts

cls_mousestat: dc.w 0
cls_address: dc.l 0
cls_zeroes: ds.l 8

/*
 * Syntax:   VID_SIZE=vgetsize(VID_MDE)
 */
lib4:
	dc.w	0			; no library calls
vgetsize:
		move.l     (a6)+,d3
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		cmpi.w     #0x1ff,d3
		bge.s      vgetsize1
		movem.l    d1/a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #91,-(a7) /* VGetSize */
		trap       #14
		addq.l     #4,a7
		move.l     d0,d3
		movem.l    (a7)+,d1/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
vgetsize1:
		movem.l    d1/a0-a6,-(a7)
		exg        d3,d0
		move.l     #0x00008000,d3
		move.l     debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     modetable_offset-entry(a0),d2
		add.l      d2,a0
vgetsize2:
		cmpi.l     #-1,(a0)
		beq.s      vgetsize4
		move.w     (a0),d2
		cmp.w      d2,d0
		beq.s      vgetsize3
		lea.l      40(a0),a0
		bra.s      vgetsize2
vgetsize3:
		moveq.l    #0,d3
		move.w     6(a0),d3 /* bytes_lin */
		mulu.w     4(a0),d3 /* height */
vgetsize4:
		movem.l    (a7)+,d1/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
/*
 * Syntax:   vgetpalt RGB_BUFF
 */
lib5:
	dc.w lib5_1-lib5
	dc.w	0
vgetpalt:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      vgetpalt1
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib5_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
vgetpalt1:
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VSetMode */
		trap       #14
		addq.l     #4,a7
		andi.l     #7,d0
		move.l     (a7)+,d3
		cmpi.w     #2,d0
		beq.s      vgetpalt2
		cmpi.w     #3,d0
		beq.s      vgetpalt3
		movem.l    (a7)+,a0-a6
		rts
vgetpalt2:
		move.l     d3,-(a7)
		move.w     #16,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		rts
vgetpalt3:
		move.l     d3,-(a7)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   MON_TYPE=montype
 */
lib6:
	dc.w	0			; no library calls
montype:
		movem.l    a0-a6,-(a7)
		move.w     #89,-(a7) /* VgetMonitor */
		trap       #14
		addq.l     #2,a7
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   vsetpalt RGB_BUFF
 */
lib7:
	dc.w lib7_1-lib7
	dc.w	0
vsetpalt:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      vsetpalt1
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib7_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
vsetpalt1:
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VgetMode */
		trap       #14
		addq.l     #4,a7
		andi.l     #7,d0
		move.l     (a7)+,d3
		cmpi.w     #2,d0
		beq.s      vsetpalt2
		cmpi.w     #3,d0
		beq.s      vsetpalt3
		movem.l    (a7)+,a0-a6
		rts
vsetpalt2:
		move.l     d3,-(a7)
		move.w     #16,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		rts
vsetpalt3:
		move.l     d3,-(a7)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   VID_MDE=whichmode(SCR_WIDTH,SCR_HEIGHT,N_COLOURS[,DEV_FLG])
 */
lib8:
	dc.w	0			; no library calls
whichmode:
		lea.l      dev_flg(pc),a1
		move.w     #0,(a1)
		cmpi.b     #1,d0
		beq.s      whichmode2
		cmpi.w     #2,d0
		beq.s      whichmode1
		rts
whichmode1:
		move.l     (a6)+,d3
		lea.l      dev_flg(pc),a1
		andi.l     #3,d3
		move.w     d3,(a1)
whichmode2:
		move.l     (a6)+,d3
		move.w     #1,d4
		cmpi.l     #2,d3
		beq.s      whichmode3
		move.w     #2,d4
		cmpi.l     #4,d3
		beq.s      whichmode3
		move.w     #4,d4
		cmpi.l     #16,d3
		beq.s      whichmode3
		move.w     #8,d4
		cmpi.l     #256,d3
		beq.s      whichmode3
		move.w     #16,d4
		cmpi.l     #-1,d3
		beq.s      whichmode3
		bra        whichmode6
whichmode3:
		move.l     (a6)+,d3
		cmpi.l     #200,d3
		beq.s      whichmode4
		cmpi.l     #240,d3
		beq.s      whichmode4
		cmpi.l     #320,d3
		beq.s      whichmode4
		cmpi.l     #400,d3
		beq.s      whichmode4
		cmpi.l     #480,d3
		beq.s      whichmode4
		bra        whichmode6
whichmode4:
		move.w     d3,d0
		swap       d0
		move.l     (a6)+,d3
		cmpi.l     #320,d3
		beq.s      whichmode5
		cmpi.l     #384,d3
		beq.s      whichmode5
		cmpi.l     #640,d3
		beq.s      whichmode5
		cmpi.l     #768,d3
		beq.s      whichmode5
		cmpi.l     #800,d3
		beq.s      whichmode5
		bra        whichmode6
whichmode5:
		move.w     d3,d0
		swap       d0
		move.l     debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     modetable_offset-entry(a0),d2
		adda.l     d2,a0
		movem.l    d0-d2/a0-a6,-(a7)
		lea.l      dev_flg(pc),a1
		exg        d4,d1
		bsr.s      getmode
		movem.l    (a7)+,d0-d2/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
whichmode6:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

dev_flg: dc.w 0

getmode:
		cmpi.w     #2,(a1)
		beq.s      getmode6
		cmpi.w     #1,(a1)
		beq.s      getmode1
		cmpi.w     #3,(a1)
		beq.s      getmode1
		movem.l    d0-d6/a0-a6,-(a7)
		move.w     #89,-(a7) /* VgetMonitor */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		move.l     d0,d7
		movem.l    (a7)+,d0-d6/a0-a6
		cmp.w      #MON_VGA,d7
		beq.s      getmode6
getmode1:
		movea.l    a0,a4
getmode2:
		cmpi.l     #-1,(a4)
		beq.s      getmode4
		move.w     (a4),d3
		btst       #4,d3 /* VGA-mode? */
		bne.s      getmode3
		cmp.l      2(a4),d0
		bne.s      getmode3
		cmp.w      10(a4),d1
		beq.s      getmode5
getmode3:
		lea.l      40(a4),a4
		bra.s      getmode2
getmode4:
		move.l     #STMODES+PAL+COL80+BPS2,d3
getmode5:
		andi.l     #0x0000FFFF,d3
		rts
getmode6:
		move.l     a0,a4
getmode7:
		cmpi.l     #-1,(a4)
		beq.s      getmode9
		move.w     (a4),d3
		btst       #4,d3 /* VGA-mode? */
		beq.s      getmode8
		cmp.l      2(a4),d0
		bne.s      getmode8
		cmp.w      10(a4),d1
		beq.s      getmode10
getmode8:
		lea.l      40(a4),a4
		bra.s      getmode7
getmode9:
		move.l     #VERTFLAG+STMODES+PAL+VGA+COL80+BPS2,d3
getmode10:
		andi.l     #0x0000FFFF,d3
		rts

/*
 * Syntax:   _get spritepalette
 */
lib9:
	dc.w lib9_1-lib9
	dc.w	0
get_spritepalette:
		movem.l    a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VSetMode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		andi.l     #0xFFFF,d0
		cmpi.w     #STMODES+PAL+BPS4,d0
		beq.s      get_spritepalette1
		cmpi.w     #STMODES+PAL+COL80+BPS2,d0
		beq.s      get_spritepalette1
		cmpi.w     #VERTFLAG+STMODES+PAL+COL80+BPS1,d0
		beq.s      get_spritepalette1
		rts
get_spritepalette1:
		move.l     #1,-(a6)
lib9_1:	jsr        L_addrofbank.l
		movea.l    d3,a0
		/* FIXME: check for valid bank removed */
get_spritepalette2:
		movem.l    a1-a6,-(a7)
		move.l     a0,-(a7)
		move.w     #2,-(a7) /* Physbase */ /* BUG: may clobber d2 */
		trap       #14
		addq.l     #2,a7
		addi.l     #32000,d0
		movea.l    d0,a1
		movea.l    (a7)+,a0
		sub.l      d3,d2 /* WTF? where was d2 set? */
		lsr.l      #1,d2
		subq.l     #1,d2
get_spritepalette3:
		move.w     (a0),d1
		swap       d1
		move.w     2(a0),d1
		addq.l     #2,a0
		cmpi.l     #0x50414C54,d1 /* 'PALT' */
		beq.s      get_spritepalette4
		subq.l     #1,d2
		bne.s      get_spritepalette3
		bra.s      get_spritepalette6
get_spritepalette4:
		addq.l     #2,a0
		move.w     #16-1,d7
get_spritepalette5:
		move.w     (a0)+,(a1)+
		dbf        d7,get_spritepalette5
		move.l     d0,-(a7)
		move.w     #6,-(a7) /* Setpalette */
		trap       #14
		addq.l     #6,a7
get_spritepalette6:
		movem.l    (a7)+,a1-a6
		rts

/*
 * Syntax:   SCR_WIDTH=scr width
 */
lib10:
	dc.w	0			; no library calls
scr_width:
		movem.l    a0-a6,-(a7)
/* FIXME: just use always linea vars */
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VSetMode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		andi.l     #0x0000FFFF,d0
		btst       #7,d0 /* ST-Compatible? */
		bne.s      scr_width1
		movem.l    a0-a6,-(a7)
		dc.w       0xa000 /* linea_init */
		movea.l    d0,a0
		move.w     DEV_TAB(a0),d3
		/* addq.w     #1,d3 */
		dc.w 0x0643,1 /* XXX */
		andi.l     #0x0000FFFF,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
scr_width1:
		movem.l    a0-a6,-(a7)
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		asl.w      #1,d0
		lea.l      scrwidth_tab(pc),a1
		move.w     0(a1,d0.w),d3
		andi.l     #0x0000FFFF,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
scrwidth_tab: dc.w 320,640,640

/*
 * Syntax:   _hardphysic ADDR
 */
lib11:
	dc.w lib11_1-lib11
	dc.w	0
hardphysic:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      hardphysic1
		move.l     d3,-(a6)
lib11_1:	jsr        L_addrofbank.l
hardphysic1:
		movem.l    a0-a6,-(a7)
		lea.l      hardphysic_addr(pc),a6
		move.l     d3,(a6)
		pea.l      setphysaddr(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		move.w     #37,-(a7) /* Vsync */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,a0-a6
		rts

setphysaddr:
		move.l     hardphysic_addr(pc),d1
		movea.l    #$00FF8200,a1 /* XXX */
		swap       d1
		move.b     d1,1(a1)
		swap       d1
		asr.l      #8,d1
		move.b     d1,3(a1)
		asl.l      #8,d1 /* BUG: will always clear d1.b */
		move.b     d1,13(a1)
		rts

hardphysic_addr: dc.l 0

/*
 * Syntax:   SCR_HEIGHT=scr height
 */
lib12:
	dc.w	0			; no library calls
scr_height:
		movem.l    a0-a6,-(a7)
* FIXME: just use always linea vars */
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		andi.l     #0x0000FFFF,d0
		btst       #7,d0 /* ST-Compatible? */
		bne.s      scr_height1
		movem.l    a0-a6,-(a7)
		dc.w       0xa000 /* linea_init */
		movea.l    d0,a0
		move.w     DEV_TAB+2(a0),d3
		/* addq.w     #1,d3 */
		dc.w 0x0643,1 /* XXX */
		andi.l     #0x0000FFFF,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
scr_height1:
		movem.l    a0-a6,-(a7)
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		asl.w      #1,d0
		lea.l      scrheight_tab(pc),a1
		move.w     0(a1,d0.w),d3
		andi.l     #0x0000FFFF,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

scrheight_tab: dc.w 200,200,400

/*
 * Syntax:   _setcolour C,RGB
 *           _setcolour C,RED,GREEN,BLUE
 */
lib13:
	dc.w	0			; no library calls
setcolour:
		cmpi.b     #1,d0
		beq.s      setcolour2
		cmpi.w     #2,d0
		beq.s      setcolour1
		rts
setcolour1:
		move.l     (a6)+,d5
		andi.l     #63,d5
		move.l     (a6)+,d4
		andi.l     #63,d4
		move.l     (a6)+,d3
		andi.l     #63,d3
		asl.l      #8,d3
		asl.l      #8,d3
		andi.l     #$003F0000,d3 /* FIXME: already done above */
		asl.l      #8,d4
		andi.l     #$00003F00,d4 /* FIXME: already done above */
		or.l       d5,d4
		or.l       d4,d3
		bra.s      setcolour3
setcolour2:
		move.l     (a6)+,d3
setcolour3:
		lea.l      setcolor_rgb(pc),a3
		move.l     d3,(a3)
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.l     (a7)+,d3
		andi.l     #0x0000FFFF,d0 /* FIXME: useless */
		btst       #7,d0 /* ST-compatible? */
		bne.s      setcolour4
		lea.l      setcolor_rgb(pc),a0
		move.l     (a0),d0
		andi.l     #$003F3F3F,d0
		asl.l      #2,d0
		move.l     d0,(a0)
		pea.l      setcolor_rgb(pc)
		move.w     #1,-(a7)
		move.w     d3,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		rts
setcolour4:
		move.l     setcolor_rgb(pc),d0
		andi.l     #0x00000FFF,d0
		move.w     d0,-(a7)
		move.w     d3,-(a7)
		move.w     #7,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		rts

setcolor_rgb: ds.l 1

/*
 * Syntax:   RGB=_getcolour (C)
 */
lib14:
	dc.w	0			; no library calls
getcolour:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.l     (a7)+,d3
		andi.l     #0x0000FFFF,d0 /* FIXME: useless */
		btst       #7,d0 /* ST-compatible? */
		bne.s      getcolour1
		pea.l      getcolor_rgb(pc)
		move.w     #1,-(a7)
		move.w     d3,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		move.l     getcolor_rgb(pc),d3
		andi.l     #0x00FCFCFC,d3
		asr.l      #2,d3
		move.l     d3,-(a6)
		clr.l      d2
		rts
getcolour1:
		move.w     #-1,-(a7)
		move.w     d3,-(a7)
		move.w     #7,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		andi.l     #0x0000FFFF,d0
		move.l     d0,-(a6)
		clr.l      d2
		rts

getcolor_rgb: dc.l 0

/*
 * Syntax:   _get st palette BANK[,COL_REG]
 */
lib15:
	dc.w lib15_1-lib15
	dc.w	0
get_st_palette:
		lea        palette_colreg(pc),a1
		move.l     #0,(a1)
		cmpi.b     #1,d0
		beq.s      get_st_palette2
		cmpi.w     #2,d0
		beq.s      get_st_palette1
		rts
get_st_palette1:
		move.l     (a6)+,d3
		andi.l     #0x000000F0,d3
		asl.w      #2,d3
		move.l     d3,(a1)
get_st_palette2:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      get_st_palette3
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib15_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
get_st_palette3:
		movem.l    a0-a6,-(a7)
		addi.l     #32000,d3
		movea.l    d3,a0
		movem.l    a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		andi.l     #0x0000FFFF,d0 /* FIXME: useless */
		btst       #7,d0 /* ST-compatible? */
		bne        get_st_palette7
		andi.l     #3,d0
		moveq.l    #1,d7
		asl.l      d0,d7
		cmpi.w     #8,d7
		beq.s      get_st_palette4
		cmpi.w     #16,d7
		beq.s      get_st_palette6
		lea        palette_colreg(pc),a1
		move.l     #0,(a1)
get_st_palette4:
		moveq.l    #1,d6
		asl.l      d7,d6
		move.l     d6,d7
		andi.l     #MAXPAL-1,d7
		movem.l    a0-a2,-(a7)
		lea.l      st_palette_rgb(pc),a0
		move.l     a0,-(a7)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a2
		lea.l      st_palette_rgb(pc),a1
		move.l     palette_colreg(pc),d0
		adda.l     d0,a1
		move.w     #16-1,d4
get_st_palette5:
		clr.l      d0
		move.w     (a0)+,d0
		bsr.s      convert2rgb_st
		move.l     d0,(a1)+
		dbf        d4,get_st_palette5
		pea.l      st_palette_rgb(pc)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		.IFNE 0 /* FIXME: missing */
		move.w     #37,-(a7) /* Vsync */
		trap       #14
		addq.l     #2,a7
		.ENDC
get_st_palette6:
		movem.l    (a7)+,a0-a6
		rts
get_st_palette7:
		move.l     a0,-(a7)
		move.w     #6,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		rts

/* FIXME: duplicate code */
convert2rgb_st:
		clr.l      d2
		clr.l      d3
		move.w     d0,d1
		move.w     d0,d2
		move.w     d0,d3
		andi.l     #0x00000F00,d1
		lsl.l      #8,d1
		lsl.l      #5,d1
		andi.l     #0x000000F0,d2
		lsl.l      #5,d2
		lsl.l      #4,d2
		andi.l     #15,d3
		lsl.l      #5,d3
		or.l       d3,d2
		or.l       d2,d1
		move.l     d1,d0
		rts

palette_colreg: dc.l 0
st_palette_rgb: ds.l 256

/*
 * Syntax:   NEW_RGB=_falc rgb(OLD_RGB)
 */
lib16:
	dc.w	0			; no library calls
falc_rgb:
		move.l     (a6)+,d3
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     convert2rgb_offset-entry(a0),d0
		adda.l     d0,a0
		move.l     d3,d0
		andi.l     #0x00000777,d0
		jsr        (a0)
		movem.l    (a7)+,d1-d7/a0-a6
		asr.l      #2,d0
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   palfade in BANK
 */
lib17:
	dc.w	0			; no library calls
palfade_in:
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		andi.l     #7,d0
		movem.l    (a7)+,d1-d7/a0-a6
		cmpi.w     #3,d0
		beq.s      palfade_in1
		rts
palfade_in1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		lea.l      fade3tab-params(a6),a0
		lea.l      fade2tab-params(a6),a1
		move.w     #256-1,d7
palfade_in2:
		move.l     #0,(a0)+
		move.l     #0x00010101,(a1)+
		dbf        d7,palfade_in2
		move.w     #256-1,d6
palfade_in3:
		lea.l      fade3tab-params(a6),a0
		lea.l      fade2tab-params(a6),a1
		lea.l      fade1tab-params(a6),a2
		move.l     #256-1,d7
palfade_in4:
		move.l     (a0),d0
		move.l     (a1),d1
		move.l     (a2)+,d2
		bsr.s      fadein_red
		bsr.s      fadein_green
		bsr.s      fadein_blue
		add.l      d1,d0
		move.l     d1,(a1)+
		move.l     d0,(a0)+
		dbf        d7,palfade_in4
		movem.l    d0-d7/a0-a6,-(a7)
		pea.l      fade3tab-params(a6)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,d0-d7/a0-a6
		dbf        d6,palfade_in3
		movem.l    (a7)+,a0-a6
		rts

fadein_red:
		move.l     d0,d4
		andi.l     #0x00FF0000,d4
		move.l     d2,d5
		andi.l     #0x00FF0000,d5
		cmp.l      d4,d5
		bne.s      fadein_red1
		andi.l     #0x0000FFFF,d1
fadein_red1:
		rts

fadein_green:
		move.l     d0,d4
		andi.l     #0x0000FF00,d4
		move.l     d2,d5
		andi.l     #0x0000FF00,d5
		cmp.l      d4,d5
		bne.s      fadein_green1
		andi.l     #0x00FF00FF,d1
fadein_green1:
		rts

fadein_blue:
		move.l     d0,d4
		andi.l     #0x000000FF,d4
		move.l     d2,d5
		andi.l     #0x000000FF,d5
		cmp.l      d4,d5
		bne.s      fadein_blue1
		andi.l     #0x00FFFF00,d1
fadein_blue1:
		rts

/*
 * Syntax:   X=_falc palt(ADDR,COUNT)
 */
lib18:
	dc.w	0			; no library calls
falc_palt:
		move.l     (a6)+,d7
		move.l     (a6)+,d3
		movea.l    d3,a0
		/* BUG: missing bank translation */
falc_palt1:
		movem.l    d1-d6/a0-a6,-(a7)
		move.l     (a0),d0
		andi.l     #0x00000FFF,d0
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     convert2rgb_offset-entry(a0),d2
		adda.l     d2,a0
		jsr        (a0)
		movem.l    (a7)+,d1-d6/a0-a6
		move.l     d0,(a0)+
		dbf        d7,falc_palt1
		moveq.l    #0,d3
		clr.l      d2
		/* move.l     d3,-(a6) BUG: missing */
		rts

/*
 * Syntax:   palfade out
 */
lib19:
	dc.w	0			; no library calls
palfade_out:
		movem.l    a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		btst       #7,d0 /* ST-compatible? */
		bne.s      palfade_out1
		andi.l     #7,d0
		cmpi.w     #2,d0
		beq.s      palfade_out2
		cmpi.w     #BPS8,d0
		beq        fadeout_256
palfade_out1:
		movem.l    (a7)+,a0-a6
		rts
palfade_out2:
		lea.l      fadeout2tab(pc),a0
		move.w     #16-1,d7
palfade_out3:
		move.l     #0x00010101,(a0)+
		dbf        d7,palfade_out3
		pea.l      fadeout3tab(pc)
		move.w     #16,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		move.w     #256-1,d6
palfade_out4:
		lea.l      fadeout3tab(pc),a0
		lea.l      fadeout2tab(pc),a1
		moveq.l    #16-1,d7
palfade_out5:
		move.l     (a0),d0
		move.l     (a1),d1
		bsr.s      fadeout_red
		bsr.s      fadeout_green
		bsr.s      fadeout_blue
		sub.l      d1,d0
		move.l     d1,(a1)+
		move.l     d0,(a0)+
		dbf        d7,palfade_out5
		movem.l    d0-d7/a0-a6,-(a7)
		move.l     #0x00001FFF,d6
palfade_out6:
		/* subq.l     #1,d6 */
		dc.w 0x0486,0,1 /* XXX */
		bpl.s      palfade_out6
		pea.l      fadeout3tab(pc)
		move.w     #16,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,d0-d7/a0-a6
		dbf        d6,palfade_out4
		movem.l    (a7)+,a0-a6
		rts

fadeout_red:
		move.l     d0,d2
		andi.l     #0x00FF0000,d2
		/* tst.l      d2 */
		dc.w 0x0c82,0,0 /* XXX */
		bne.s      fadeout_red1
		andi.l     #0x0000FFFF,d1
fadeout_red1:
		rts

fadeout_green:
		move.l     d0,d2
		andi.l     #0x0000FF00,d2
		/* tst.l      d2 */
		dc.w 0x0c82,0,0 /* XXX */
		bne.s      fadeout_green1
		andi.l     #0x00FF00FF,d1
fadeout_green1:
		rts

fadeout_blue:
		move.l     d0,d2
		andi.l     #0x000000FF,d2
		/* tst.l      d2 */
		dc.w 0x0c82,0,0 /* XXX */
		bne.s      fadeout_blue1
		andi.l     #0x00FFFF00,d1
fadeout_blue1:
		rts

fadeout_256:
		lea.l      fadeout2tab(pc),a0
		move.w     #256-1,d7
fadeout_256_1:
		move.l     #0x00010101,(a0)+
		dbf        d7,fadeout_256_1
		pea.l      fadeout3tab(pc)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		move.w     #256-1,d6
fadeout_256_2:
		lea.l      fadeout3tab(pc),a0
		lea.l      fadeout2tab(pc),a1
		move.l     #256-1,d7
fadeout_256_3:
		move.l     (a0),d0
		move.l     (a1),d1
		bsr.s      fadeout_256_red
		bsr.s      fadeout_256_green
		bsr.s      fadeout_256_blue
		sub.l      d1,d0
		move.l     d1,(a1)+
		move.l     d0,(a0)+
		dbf        d7,fadeout_256_3
		movem.l    d0-d7/a0-a6,-(a7)
		pea.l      fadeout3tab(pc)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,d0-d7/a0-a6
		dbf        d6,fadeout_256_2
		movem.l    (a7)+,a0-a6
		rts

fadeout_256_red:
		move.l     d0,d2
		andi.l     #0x00FF0000,d2
		/* tst.l      d2 */
		dc.w 0x0c82,0,0 /* XXX */
		bne.s      fadeout_256_red1
		andi.l     #0x0000FFFF,d1
fadeout_256_red1:
		rts

fadeout_256_green:
		move.l     d0,d2
		andi.l     #0x0000FF00,d2
		/* tst.l      d2 */
		dc.w 0x0c82,0,0 /* XXX */
		bne.s      fadeout_256_green1
		andi.l     #0x00FF00FF,d1
fadeout_256_green1:
		rts

fadeout_256_blue:
		move.l     d0,d2
		andi.l     #0x000000FF,d2
		/* tst.l      d2 */
		dc.w 0x0c82,0,0 /* XXX */
		bne.s      fadeout_256_blue1
		andi.l     #0x00FFFF00,d1
fadeout_256_blue1:
		rts

fadeout2tab:
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
	dc.l 0x010101
fadeout3tab: ds.l 256

/*
 * Syntax:   D=darkest
 */
lib20:
	dc.w	0			; no library calls
darkest:
		movem.l    d4-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		btst       #7,d0 /* ST-compatible? */
		bne        darkest4
		andi.l     #7,d0
		moveq.l    #1,d7
		asl.l      d0,d7 /* BUG: wrong for chunky mode (BPS8C) and truecolor */
		moveq.l    #1,d6
		asl.l      d7,d6
		move.l     d6,d7
		andi.l     #MAXPAL-1,d7 /* FIXME: useless */
		cmpi.w     #16,d7
		beq        darkest11
		lea.l      darkest_table(pc),a0
		move.l     a0,-(a7)
		move.w     #256,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		lea.l      darkest_table(pc),a0
		lea.l      darkest_color(pc),a1
		move.l     #0x00010101,(a1)
		clr.l      d2
		clr.l      d3
darkest1:
		cmp.w      d7,d2
		beq.s      darkest3
		move.l     (a0),d0
		move.l     (a1),d1
		sub.l      d1,d0
		cmp.l      d1,d0
		blt.s      darkest2
		exg        d1,d0
		move.l     d2,d3
darkest2:
		addq.w     #1,d2 /* BUG: a0 not incremented, (a1) not updated */
		bra.s      darkest1
darkest3:
		movem.l    (a7)+,d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

darkest_color: dc.l 0x010101,0
darkest_table: ds.l 256 /* FIXME */

darkest4:
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		moveq.l    #16,d7
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		beq.s      darkest5
		moveq.l    #4,d7
		cmpi.w     #1,d0
		beq.s      darkest5
		moveq.l    #2,d7
darkest5:
		move.w     d7,-(a7)
		move.w     #2,-(a7) /* Physbase */
		trap       #14
		addq.l     #2,a7
		addi.l     #32000,d0
		movea.l    d0,a0
		move.w     (a7)+,d7
		clr.l      d3
		move.w     (a0)+,d0
		move.w     (a0),d1
		cmp.w      d0,d1
		bgt.s      darkest6
		move.w     d1,d2
		addq.w     #1,d3
		bra.s      darkest7
darkest6:
		move.w     d0,d2
darkest7:
		move.w     #1,d4
darkest8:
		move.w     (a0)+,d0
		cmp.w      d0,d2
		bgt.s      darkest9
		bra.s      darkest10
darkest9:
		move.w     d0,d2
		move.w     d4,d3
darkest10:
		addq.w     #1,d4
		cmp.w      d7,d4
		blt.s      darkest8
		movem.l    (a7)+,d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
darkest11:
		movem.l    (a7)+,d4-d7/a0-a6
		clr.l      d2
		move.l     #0,-(a6)
		rts

/*
 * Syntax:   quickwipe START_ADDRESS,LENGTH
 */
lib21:
	dc.w	0			; no library calls
quickwipe:
		move.l     (a6)+,d3
		move.l     d3,d7
		move.l     (a6)+,d3
		movea.l    d3,a0
		adda.l     d7,a0
		asr.l      #7,d7
		subq.l     #1,d7
		moveq.l    #0,d1
		moveq.l    #0,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
quickwipe1:
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		movem.l    d1-d4,-(a0)
		dbf        d7,quickwipe1
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #0,d1
		moveq.l    #S_falc_locate,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		rts

/*
 * Syntax:   B=brightest
 */
lib22:
	dc.w	0			; no library calls
brightest:
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		btst       #7,d0 /* ST-compatible? */
		bne        brightest6
		andi.l     #7,d0
		moveq.l    #1,d7
		asl.l      d0,d7 /* BUG: wrong for chunky mode (BPS8C) and truecolor */
		cmpi.w     #16,d7
		beq        brightest13
		moveq.l    #1,d6
		asl.l      d7,d6
		move.l     d6,d7
		andi.l     #MAXPAL-1,d7 /* FIXME: useless */
		move.l     d7,-(a7)
		pea        brightest_table(pc)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		lea.l      brightest_table(pc),a0
		move.l     (a7)+,d7
		clr.l      d3
		move.l     (a0)+,d0
		move.l     (a0),d1
		cmp.l      d0,d1
		bmi.s      brightest1
		move.l     d1,d2
		addq.w     #1,d3
		bra.s      brightest2
brightest1:
		move.l     d0,d2
brightest2:
		move.w     #1,d4
brightest3:
		move.l     (a0)+,d0
		cmp.l      d0,d2
		bmi.s      brightest4
		bra.s      brightest5
brightest4:
		move.l     d0,d2
		move.w     d4,d3
brightest5:
		addq.w     #1,d4
		cmp.w      d7,d4
		blt.s      brightest3
		exg        d3,d0
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

brightest_table: ds.l 256 /* FIXME */

brightest6:
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		moveq.l    #16,d7
		/* tst.w d0 */
		dc.w 0x0c40,0 /* XXX */
		beq.s      brightest7
		moveq.l    #4,d7
		cmpi.w     #1,d0
		beq.s      brightest7
		moveq.l    #2,d7
brightest7:
		move.w     d7,-(a7)
		move.w     #2,-(a7) /* Physbase */
		trap       #14
		addq.l     #2,a7
		addi.l     #32000,d0
		movea.l    d0,a0
		move.w     (a7)+,d7
		clr.l      d3
		move.w     (a0)+,d0
		move.w     (a0),d1
		cmp.w      d0,d1
		bmi.s      brightest8
		move.w     d1,d2
		addq.w     #1,d3
		bra.s      brightest9
brightest8:
		move.w     d0,d2
brightest9:
		move.w     #1,d4
brightest10:
		move.w     (a0)+,d0
		cmp.w      d0,d2
		bmi.s      brightest11
		bra.s      brightest12
brightest11:
		move.w     d0,d2
		move.w     d4,d3
brightest12:
		addq.w     #1,d4
		cmp.w      d7,d4
		blt.s      brightest10
		move.l     d3,d0
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts
brightest13:
		move.l     #0x0000FFDF,d0
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts

/*
 * Syntax:   ilbmpalt S
 */
lib23:
	dc.w lib23_1-lib23
	dc.w	0
ilbmpalt:
		move.l     (a6)+,d3
		move.l     d3,d2
		addi.l     #256,d2
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      ilbmpalt1
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib23_1:		jsr        L_addrofbank.l
		/* BUG: d2 not updated */
		movem.l    (a7)+,a0-a1
ilbmpalt1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		move.l     d3,ilbm_addr-params(a6)
		sub.l      d3,d2
		move.l     d2,ilbm_size-params(a6)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     getilbmchunks_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		tst.l      d7
		bne.s      ilbmpalt2
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,d1-d7/a0-a6
		andi.l     #0x0000FFFF,d0
		btst       #7,d0 /* ST-compatible? */
		bne.s      ilbmpalt4
		bra        ilbmpalt7
ilbmpalt2:
		movem.l    (a7)+,a0-a6
		rts
ilbmpalt4:
		move.w     ilbm_planes-params(a6),d1
		andi.l     #255,d1
		cmpi.b     #4,d1
		ble.s      ilbmpalt5
		movem.l    (a7)+,a0-a6
		rts
ilbmpalt5:
		movea.l    ilbm_cmap-params(a6),a4
		addq.l     #8,a4
		move.w     ilbm_cmapsize-params(a6),d7
		clr.w      d6
ilbmpalt6:
		move.b     (a4)+,d1
		asr.b      #5,d1
		andi.l     #15,d1
		asl.l      #8,d1
		move.b     (a4)+,d2
		asr.b      #5,d2
		andi.l     #15,d2
		asl.l      #4,d2
		move.b     (a4)+,d3
		asr.b      #5,d3
		andi.l     #15,d3
		or.l       d2,d1
		or.l       d3,d1
		andi.l     #0x00000777,d1
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     d1,-(a7)
		move.w     d6,-(a7)
		move.w     #7,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d6
		cmp.w      d6,d7
		bne.s      ilbmpalt6
		movem.l    (a7)+,a0-a6
		rts
ilbmpalt7:
		move.w     ilbm_planes-params(a6),d1
		andi.l     #255,d1
		cmpi.b     #4,d1
		beq.s      ilbmpalt8
		cmpi.b     #8,d1
		beq        ilbmpalt10
		movem.l    (a7)+,a0-a6
		rts
ilbmpalt8:
		movea.l    ilbm_cmap-params(a6),a4
		addq.l     #8,a4
		lea.l      fade3tab-params(a6),a5
		move.w     ilbm_cmapsize-params(a6),d7
		clr.w      d6
ilbmpalt9:
		move.b     (a4)+,d1
		asr.b      #5,d1
		andi.l     #15,d1
		asl.l      #8,d1
		move.b     (a4)+,d2
		asr.b      #5,d2
		andi.l     #15,d2
		asl.l      #4,d2
		move.b     (a4)+,d3
		asr.b      #5,d3
		andi.l     #15,d3
		or.l       d2,d1
		or.l       d3,d1
		move.l     d1,d0
		andi.l     #0x00000FFF,d0
		/* FIXME: duplicate code of convert2rgb */
		clr.l      d2
		clr.l      d3
		move.w     d0,d1
		move.w     d0,d2
		move.w     d0,d3
		andi.l     #0x00000F00,d1
		lsl.l      #8,d1
		lsl.l      #5,d1
		andi.l     #0x000000F0,d2
		lsl.l      #5,d2
		lsl.l      #4,d2
		andi.l     #15,d3
		lsl.l      #5,d3
		or.l       d3,d2
		or.l       d2,d1
		move.l     d1,d0
		move.l     d0,(a5)+
		addq.w     #1,d6
		cmp.w      d6,d7
		bne.s      ilbmpalt9
		lea.l      fade3tab-params(a6),a0
		move.l     a0,-(a7)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		move.w     #37,-(a7) /* Vsync */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,a0-a6
		rts
ilbmpalt10:
		movea.l    ilbm_cmap-params(a6),a4
		addq.l     #8,a4
		lea.l      fade3tab-params(a6),a5
		move.w     ilbm_cmapsize-params(a6),d7
		clr.w      d6
ilbmpalt11:
		clr.l      d1
		move.b     (a4)+,d1
		asl.l      #8,d1
		move.b     (a4)+,d1
		asl.l      #8,d1
		move.b     (a4)+,d1
		andi.l     #0x00FFFFFF,d1
		move.l     d1,(a5)+
		addq.w     #1,d6
		cmp.w      d6,d7
		bne.s      ilbmpalt11
		lea.l      fade3tab-params(a6),a0
		move.l     a0,-(a7)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #93,-(a7) /* VsetRGB */
		trap       #14
		lea.l      10(a7),a7
		move.w     #37,-(a7) /* Vsync */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   RED=_get red(COL_INDEX)
 */
lib24:
	dc.w	0			; no library calls
get_red:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.l     (a7)+,d3
		andi.l     #0x0000FFFF,d0
		btst       #7,d0 /* ST-compatible? */
		bne.s      get_red2
		andi.l     #7,d0
		cmpi.w     #BPS16,d0
		beq.s      get_red1
		pea.l      get_red_rgb(pc)
		move.w     #1,-(a7)
		move.w     d3,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		lea.l      get_red_rgb(pc),a0
		move.l     (a0),d0
		asr.l      #2,d0
		asr.l      #8,d0
		asr.l      #8,d0
		andi.l     #0x0000003F,d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		rts
get_red1:
		movem.l    (a7)+,a0-a6
		move.l     #0,-(a6)
		rts
get_red2:
		move.w     #-1,-(a7)
		move.w     d3,-(a7)
		move.w     #7,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		asr.l      #8,d0
		andi.l     #15,d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		rts

get_red_rgb: ds.l 1


/*
 * Syntax:   _shift off
 */
lib25:
	dc.w	0			; no library calls
shift_off:
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     restorevbl_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		movem.l    (a7)+,d1-d7/a0-a6
		rts

/*
 * Syntax:   GREEN=_get green(COL_INDEX)
 */
lib26:
	dc.w	0			; no library calls
get_green:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.l     (a7)+,d3
		andi.l     #0x0000FFFF,d0
		btst       #7,d0 /* ST-compatible? */
		bne.s      get_green2
		andi.l     #7,d0
		cmpi.w     #BPS16,d0
		beq.s      get_green1
		pea.l      get_green_rgb(pc)
		move.w     #1,-(a7)
		move.w     d3,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		lea.l      get_green_rgb(pc),a0
		move.l     (a0),d0
		asr.l      #2,d0
		asr.l      #8,d0
		andi.l     #0x0000003F,d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		rts
get_green1:
		movem.l    (a7)+,a0-a6
		move.l     #0,-(a6)
		rts
get_green2:
		move.w     #-1,-(a7)
		move.w     d3,-(a7)
		move.w     #7,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		asr.w      #4,d0
		andi.l     #15,d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		rts

get_green_rgb: dc.l 0

/*
 * Syntax:   _shift DELAY,START
 */
lib27:
	dc.w	0			; no library calls
_shift:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        shift2
		cmpi.l     #254,d3
		bgt        shift2
		lea        vblstart_param(pc),a0
		move.w     d3,(a0)+
		move.l     (a6)+,d3
		andi.l     #127,d3
		tst.l      d3
		beq        shift2
		move.w     d3,(a0)+
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     installvbl_offset-entry(a0),d2
		adda.l     d2,a0
		lea        vblstart_param(pc),a1
		move.l     (a1),d0
		jsr        (a0)
shift1:
		movem.l    (a7)+,a0-a6
shift2:
		rts

vblstart_param: dc.w 0
vbldelay_param: dc.w 0

/*
 * Syntax:   BLUE=_get blue(COL_INDEX)
 */
lib28:
	dc.w	0			; no library calls
get_blue:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		move.l     d3,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		move.l     (a7)+,d3
		andi.l     #0x0000FFFF,d0
		btst       #7,d0 /* ST-compatible? */
		bne.s      get_blue2
		andi.l     #7,d0
		cmpi.w     #BPS16,d0
		beq.s      get_blue1
		pea.l      get_blue_rgb(pc)
		move.w     #1,-(a7)
		move.w     d3,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		lea.l      get_blue_rgb(pc),a0
		move.l     (a0),d0
		asr.l      #2,d0
		andi.l     #0x0000003F,d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		rts
get_blue1:
		movem.l    (a7)+,a0-a6
		move.l     #0,-(a6)
		rts
get_blue2:
		move.w     #-1,-(a7)
		move.w     d3,-(a7)
		move.w     #7,-(a7) /* Setcolor */
		trap       #14
		addq.l     #6,a7
		andi.l     #15,d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		rts

get_blue_rgb: dc.l 0

lib29:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   VID_MDE=vget ilbm mode(ADDR[,MONTYPE])
 */
lib30:
	dc.w lib30_1-lib30
	dc.w	0
vget_ilbm_mode:
		lea.l      ilbm_mode_montype(pc),a1
		move.w     #MON_MONO,(a1)
		cmpi.b     #1,d0
		beq.s      vget_ilbm_mode2
		cmpi.w     #2,d0
		beq.s      vget_ilbm_mode1
		rts
vget_ilbm_mode1:
		move.l     (a6)+,d3
		lea.l      ilbm_mode_montype(pc),a1
		andi.l     #3,d3
		move.w     d3,(a1)
vget_ilbm_mode2:
		move.l     (a6)+,d3
		move.l     d3,d2
		addi.l     #256,d2
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      vget_ilbm_mode3
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib30_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
		/* BUG: d2 not updated */
vget_ilbm_mode3:
		movem.l    d1/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		move.l     d3,ilbm_addr-params(a6)
		sub.l      d3,d2
		move.l     d2,ilbm_size-params(a6)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     getilbmchunks_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		tst.l      d7
		bne.s      vget_ilbm_mode4
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     modetable_offset-entry(a0),d2
		add.l      d2,a0
		lea.l      ilbm_mode_montype(pc),a1
		bsr.s      find_ilbm_mode
		clr.l      d2
		movem.l    (a7)+,d1/a0-a6
		move.l     d3,-(a6)
		rts
vget_ilbm_mode4:
		move.w     #89,-(a7) /* VgetMonitor */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		cmp.w      #MON_VGA,d0
		beq.s      vget_ilbm_mode5
		move.l     #STMODES+PAL+COL80+BPS2,d3
		bra.s      vget_ilbm_mode6
vget_ilbm_mode5:
		move.l     #VERTFLAG+STMODES+PAL+VGA+COL80+BPS2,d3
vget_ilbm_mode6:
		movem.l    (a7)+,d1/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

ilbm_mode_montype: dc.w 0

find_ilbm_mode:
		cmpi.w     #MON_VGA,(a1)
		beq.s      find_ilbm_mode6
		cmpi.w     #MON_COLOR,(a1)
		beq.s      find_ilbm_mode1
		cmpi.w     #MON_TV,(a1)
		beq.s      find_ilbm_mode1
		movem.l    d0-d6/a0-a6,-(a7)
		move.w     #89,-(a7) /* VgetMonitor */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		move.l     d0,d7
		movem.l    (a7)+,d0-d6/a0-a6
		cmp.w      #MON_VGA,d7
		beq.s      find_ilbm_mode6
find_ilbm_mode1:
		move.l     ilbm_width-params(a6),d0
		move.w     ilbm_planes-params(a6),d1
		move.l     a0,a4
find_ilbm_mode2:
		cmpi.l     #-1,(a4)
		beq.s      find_ilbm_mode4
		move.w     (a4),d3
		btst       #4,d3 /* VGA-mode? */
		bne.s      find_ilbm_mode3
		cmp.l      2(a4),d0
		bne.s      find_ilbm_mode3
		cmp.w      10(a4),d1
		beq.s      find_ilbm_mode5
find_ilbm_mode3:
		lea.l      40(a4),a4
		bra.s      find_ilbm_mode2
find_ilbm_mode4:
		move.l     #STMODES+PAL+COL80+BPS2,d3
find_ilbm_mode5:
		andi.l     #0x0000FFFF,d3
		rts
find_ilbm_mode6:
		move.l     ilbm_width-params(a6),d0
		move.w     ilbm_planes-params(a6),d1
		move.l     a0,a4
find_ilbm_mode7:
		cmpi.l     #-1,(a4)
		beq.s      find_ilbm_mode9
		move.w     (a4),d3
		btst       #4,d3 /* VGA-mode? */
		beq.s      find_ilbm_mode8
		cmp.l      2(a4),d0
		bne.s      find_ilbm_mode8
		cmp.w      10(a4),d1
		beq.s      find_ilbm_mode10
find_ilbm_mode8:
		lea.l      40(a4),a4
		bra.s      find_ilbm_mode7
find_ilbm_mode9:
		move.l     #VERTFLAG+STMODES+PAL+VGA+COL80+BPS2,d3
find_ilbm_mode10:
		andi.l     #0x0000FFFF,d3
		rts

lib31:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   X=dpack ilbm(SRC_ADDR,DEST_ADDR)
 */
lib32:
	dc.w lib32_1-lib32
	dc.w lib32_2-lib32
	dc.w	0
dpack_ilbm:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      dpack_ilbm1
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib32_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
dpack_ilbm1:
		lea.l      dpack_dst(pc),a1
		move.l     d3,(a1)
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      dpack_ilbm2
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib32_2:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
dpack_ilbm2:
		lea.l      dpack_src(pc),a1
		move.l     d3,(a1)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		move.l     d3,ilbm_addr-params(a6)
		sub.l      d3,d2 /* WTF? where was d2 set? */
		move.l     d2,ilbm_size-params(a6)
		lea.l      dpack_dst(pc),a1
		move.l     (a1),dpack_ptr-params(a6)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     getilbmchunks_offset-entry(a0),d0
		add.l      d0,a0
		jsr        (a0)
		tst.l      d7
		bne.s      dpack_ilbm3
		bsr.s      unpack_ilbm
		bsr.s      dpack_palette
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
dpack_ilbm3:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

dpack_src: dc.l 0
dpack_dst: dc.l 0

unpack_ilbm:
		bsr        ilbm_calc_params
		tst.b      ilbm_compression-params(a6)
		bne.s      uncompress_ilbm
		clr.l      d3
		rts

dpack_palette:
		move.w     ilbm_planes-params(a6),d1
		andi.l     #255,d1
		cmpi.b     #8,d1
		beq.s      dpack_palette1
		rts
dpack_palette1:
		movea.l    ilbm_cmap-params(a6),a4
		addq.l     #8,a4
		lea.l      fade1tab-params(a6),a3
		move.w     ilbm_cmapsize-params(a6),d7
		clr.w      d6
dpack_palette2:
		clr.l      d1
		move.b     (a4)+,d1
		asl.l      #8,d1
		move.b     (a4)+,d1
		asl.l      #8,d1
		move.b     (a4)+,d1
		andi.l     #0x00FFFFFF,d1
		move.l     d1,(a3)+
		addq.w     #1,d6
		cmp.w      d6,d7
		bne.s      dpack_palette2
		rts

uncompress_ilbm:
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    ilbm_body-params(a6),a0
		addq.l     #8,a0
		move.l     a0,ilbm_addr-params(a6)
		movea.l    dpack_ptr-params(a6),a1
		movea.l    a0,a2
		movea.l    a1,a3
		clr.l      d7
uncompress_ilbm1:
		clr.l      d1
		movea.l    dpack_ptr-params(a6),a1
		move.w     ilbm_bytes_lin-params(a6),d1
		mulu.w     d7,d1
		adda.l     d1,a1
		movea.l    a1,a3
		clr.l      d6
uncompress_ilbm2:
		clr.l      d5
uncompress_ilbm3:
		clr.l      d4
		move.b     (a2),d4
		ext.w      d4
		ext.l      d4
		bmi.s      uncompress_ilbm4
		bsr.s      uncompress_literal
		bra.s      uncompress_ilbm5
uncompress_ilbm4:
		bsr.s      uncompress_rle
uncompress_ilbm5:
		cmp.w      ilbm_bytes-params(a6),d5
		bne.s      uncompress_ilbm3
		addq.l     #2,a1
		movea.l    a1,a3
		addq.w     #1,d6
		cmp.w      ilbm_planes2-params(a6),d6
		bne.s      uncompress_ilbm2
		addq.w     #1,d7
		cmp.w      ilbm_height2-params(a6),d7
		bne.s      uncompress_ilbm1
		nop
		movem.l    (a7)+,d1-d7/a0-a6
		moveq.l    #-1,d3
		rts

uncompress_literal:
		addq.w     #1,d4
		addq.l     #1,a2
		clr.l      d3
uncompress_literal1:
		move.b     (a2),(a3)
		move.l     a3,d2
		btst       #0,d2
		beq.s      uncompress_literal2
		adda.l     ilbm_nxwd-params(a6),a3
uncompress_literal2:
		addq.l     #1,a3
		addq.l     #1,a2
		addq.w     #1,d5
		addq.w     #1,d3
		cmp.w      d4,d3
		bne.s      uncompress_literal1
		rts

uncompress_rle:
		neg.l      d4
		addq.w     #1,d4
		addq.l     #1,a2
		clr.l      d3
uncompress_rle1:
		move.b     (a2),(a3)
		move.l     a3,d2
		btst       #0,d2
		beq.s      uncompress_rle2
		adda.l     ilbm_nxwd-params(a6),a3
uncompress_rle2:
		addq.l     #1,a3
		addq.w     #1,d5
		addq.w     #1,d3
		cmp.w      d4,d3
		bne.s      uncompress_rle1
		addq.l     #1,a2
		rts


ilbm_calc_params:
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     ilbm_height-params(a6),ilbm_height2-params(a6)
		move.w     ilbm_planes-params(a6),d3
		andi.l     #255,d3
		move.w     d3,ilbm_planes2-params(a6)
		cmpi.w     #1,d3
		beq.s      ilbm_calc_params1
		cmpi.w     #2,d3
		beq.s      ilbm_calc_params2
		cmpi.w     #4,d3
		beq.s      ilbm_calc_params3
		cmpi.w     #8,d3
		beq.s      ilbm_calc_params4
ilbm_calc_params1:
		move.w     #80,ilbm_bytes_lin-params(a6)
		move.w     #80,ilbm_bytes-params(a6)
		move.l     #0,ilbm_nxwd-params(a6)
		movem.l    (a7)+,d1-d7/a0-a6
		rts
ilbm_calc_params2:
		move.w     ilbm_width-params(a6),d0
		asr.w      #3,d0
		move.w     d0,ilbm_bytes-params(a6)
		mulu.w     d3,d0
		move.w     d0,ilbm_bytes_lin-params(a6)
		move.l     #2,ilbm_nxwd-params(a6)
		movem.l    (a7)+,d1-d7/a0-a6
		rts
ilbm_calc_params3:
		move.w     ilbm_width-params(a6),d0
		asr.w      #3,d0
		move.w     d0,ilbm_bytes-params(a6)
		mulu.w     d3,d0
		move.w     d0,ilbm_bytes_lin-params(a6)
		move.l     #6,ilbm_nxwd-params(a6)
		movem.l    (a7)+,d1-d7/a0-a6
		rts
ilbm_calc_params4:
		move.w     ilbm_width-params(a6),d0
		asr.w      #3,d0
		move.w     d0,ilbm_bytes-params(a6)
		mulu.w     d3,d0
		move.w     d0,ilbm_bytes_lin-params(a6)
		move.l     #14,ilbm_nxwd-params(a6)
		movem.l    (a7)+,d1-d7/a0-a6
		rts

lib33:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   ADR=fmchunk(BANK)
 */
lib34:
	dc.w lib34_1-lib34
	dc.w	0
fmchunk:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      fmchunk1
		move.l     d3,-(a6)
lib34_1:	jsr        L_addrofbank.l
fmchunk1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    d3,a0
		
/* FIXME: walk through list of chunks instead */
		move.l     #256,d7
fmchunk2:
		tst.l      d7
		beq.s      fmchunk3
		subq.l     #1,d7
		cmpi.b     #'F',(a0)+
		bne.s      fmchunk2
		cmpi.b     #'O',(a0)
		bne.s      fmchunk2
		cmpi.b     #'R',1(a0)
		bne.s      fmchunk2
		cmpi.b     #'M',2(a0)
		bne.s      fmchunk2
		subq.l     #1,a0
		move.l     a0,ilbm_form-params(a6)
		moveq.l    #0,d7
		bra.s      fmchunk4
fmchunk3:
		moveq.l    #-1,d7
fmchunk4:
		tst.l      d7
		bne.s      fmchunk5
		move.l     a0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
fmchunk5:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

lib35:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   ZNE=_falc zone(N)
 */
lib36:
	dc.w	0			; no library calls
falc_zone:
		move.l     (a6)+,d1
		andi.l     #15,d1
		move.w     #S_zone,d0
		trap       #5
		andi.l     #0x000003FF,d1 /* BUG */
		clr.l      d2
		move.l     d1,-(a6)
		rts

lib37:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   ADR=ilbmchunk(BANK)
 */
lib38:
	dc.w lib38_1-lib38
	dc.w	0
ilbmchunk:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      ilbmchunk1
		move.l     d3,-(a6)
lib38_1:	jsr        L_addrofbank.l
ilbmchunk1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    d3,a0
/* FIXME: walk through list of chunks instead */
		move.l     #256,d7
ilbmchunk2:
		tst.l      d7
		beq.s      ilbmchunk3
		subq.l     #1,d7
		cmpi.b     #'I',(a0)+
		bne.s      ilbmchunk2
		cmpi.b     #'L',(a0)
		bne.s      ilbmchunk2
		cmpi.b     #'B',1(a0)
		bne.s      ilbmchunk2
		cmpi.b     #'M',2(a0)
		bne.s      ilbmchunk2
		subq.l     #1,a0
		move.l     a0,ilbm_ilbm-params(a6)
		moveq.l    #0,d7
		bra.s      ilbmchunk4
ilbmchunk3:
		moveq.l    #-1,d7
ilbmchunk4:
		tst.l      d7
		bne.s      ilbmchunk5
		move.l     a0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
ilbmchunk5:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _reset falc zone
 */
lib39:
	dc.w	0			; no library calls
reset_falc_zone:
		movem.l    a0-a6,-(a7)
		move.w     #S_initzones,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   ADR=bmhdchunk(BANK)
 */
lib40:
	dc.w lib40_1-lib40
	dc.w	0
bmhdchunk:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      bmhdchunk1
		move.l     d3,-(a6)
lib40_1:		jsr        L_addrofbank.l
bmhdchunk1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    d3,a0
/* FIXME: walk through list of chunks instead */
		move.l     #256,d7
bmhdchunk2:
		tst.l      d7
		beq.s      bmhdchunk3
		subq.l     #1,d7
		cmpi.b     #'B',(a0)+
		bne.s      bmhdchunk2
		cmpi.b     #'M',(a0)
		bne.s      bmhdchunk2
		cmpi.b     #'H',1(a0)
		bne.s      bmhdchunk2
		cmpi.b     #'D',2(a0)
		bne.s      bmhdchunk2
		subq.l     #1,a0
		move.l     a0,ilbm_bmhd-params(a6)
		moveq.l    #0,d7
		bra.s      bmhdchunk4
bmhdchunk3:
		moveq.l    #-1,d7
bmhdchunk4:
		tst.l      d7
		bne.s      bmhdchunk5
		move.l     a0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
bmhdchunk5:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _set falc zone ZNE,X1,Y1,X2,Y2
 */
lib41:
	dc.w	0			; no library calls
set_falc_zone:
		move.l     (a6)+,d3
		lea.l      zone_params+8(pc),a0
		addi.w     #400,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      zone_params+4(pc),a0
		addi.w     #640,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      zone_params+6(pc),a0
		addi.w     #400,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      zone_params+2(pc),a0
		addi.w     #640,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		lea.l      zone_params(pc),a0
		move.w     d3,(a0)
		movem.w    (a0)+,d1-d5
		move.w     #S_setzone,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		rts

zone_params: ds.w 5

/*
 * Syntax:   ADR=cmapchunk(BANK)
 */
lib42:
	dc.w lib42_1-lib42
	dc.w	0
cmapchunk:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      cmapchunk1
		move.l     d3,-(a6)
lib42_1:	jsr        L_addrofbank.l
cmapchunk1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    d3,a0
/* FIXME: walk through list of chunks instead */
		move.l     #256,d7
cmapchunk2:
		tst.l      d7
		beq.s      cmapchunk3
		subq.l     #1,d7
		cmpi.b     #'C',(a0)+
		bne.s      cmapchunk2
		cmpi.b     #'M',(a0)
		bne.s      cmapchunk2
		cmpi.b     #'A',1(a0)
		bne.s      cmapchunk2
		cmpi.b     #'P',2(a0)
		bne.s      cmapchunk2
		subq.l     #1,a0
		move.l     a0,ilbm_cmap-params(a6)
		moveq.l    #0,d7
		bra.s      cmapchunk4
cmapchunk3:
		moveq.l    #-1,d7
cmapchunk4:
		tst.l      d7
		bne.s      cmapchunk5
		move.l     a0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
cmapchunk5:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _paste pi1 SRCE,SX,SY,W,H,DEST,DX,DY[,COL_REG]
 */
lib43:
	dc.w lib43_1-lib43
	dc.w lib43_2-lib43
	dc.w	0
paste_pi1:
		lea.l      paste_colreg(pc),a1
		move.w     #0,(a1)
		cmpi.b     #1,d0
		beq.s      paste_pi1_1
		cmpi.w     #2,d0
		beq.s      paste_pi0
		rts
paste_pi0:
		lea.l      paste_colreg(pc),a1
		move.l     (a6)+,d3
		andi.l     #0x000000F0,d3
		move.w     d3,(a1)
paste_pi1_1:
		lea.l      paste_dx(pc),a3
		move.l     (a6)+,d3
		tst.l      d3
		bpl.s      paste_pi1_2
		clr.l      d3
paste_pi1_2:
		move.w     d3,paste_dy-paste_dx(a3)
		move.l     (a6)+,d3
		tst.l      d3
		bpl.s      paste_pi1_3
		clr.l      d3
paste_pi1_3:
		move.w     d3,(a3)
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      paste_pi1_4
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib43_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
paste_pi1_4:
		lea.l      paste_dst(pc),a1
		move.l     d3,(a1)
		lea.l      paste_width(pc),a3
		move.l     (a6)+,d3
		cmpi.l     #200,d3
		ble.s      paste_pi1_5
		move.l     #200,d3
paste_pi1_5:
		move.w     d3,paste_height-paste_width(a3)
		move.l     (a6)+,d3
		cmpi.l     #320,d3
		ble.s      paste_pi1_6
		move.l     #320,d3
paste_pi1_6:
		move.w     d3,(a3)
		lea.l      paste_sx(pc),a3
		move.l     (a6)+,d3
		tst.l      d3
		bpl.s      paste_pi1_7
		clr.l      d3
paste_pi1_7:
		cmpi.l     #200-1,d3
		ble.s      paste_pi1_8
		move.l     #200-1,d3
paste_pi1_8:
		move.w     d3,paste_sy-paste_sx(a3)
		move.l     (a6)+,d3
		tst.l      d3
		bpl.s      paste_pi1_9
		clr.l      d3
paste_pi1_9:
		cmpi.l     #320-1,d3
		ble.s      paste_pi1_10
		move.l     #320-1,d3
paste_pi1_10:
		move.w     d3,(a3)
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      paste_pi1_11
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib43_2:		jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
paste_pi1_11:
		lea.l      paste_src(pc),a1
		move.l     d3,(a1)
		movem.l    a0-a6,-(a7)
		movem.l    d1/a5,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,d1/a5
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     modetable_offset-entry(a0),d2
		adda.l     d2,a0
		movea.l    a0,a4
paste_pi1_12:
		cmpi.l     #-1,(a4)
		beq.s      paste_pi1_14
		cmp.w      (a4),d0
		bne.s      paste_pi1_13
		move.w     6(a4),d1 /* bytes */
		move.w     10(a4),d2 /* planes */
		bra.s      paste_pi1_15
paste_pi1_13:
		lea.l      40(a4),a4
		bra.s      paste_pi1_12
paste_pi1_14:
		movem.l    (a7)+,a0-a6
		rts
paste_pi1_15:
		lea.l      paste_src(pc),a0
		lea.l      bitblt(pc),a1
		move.w     d2,d6
		asl.w      #1,d2
		movem.l    d2/d6/a0-a3,-(a7)
		dc.w       0xa000 /* linea_init */
		movea.l    d0,a0
		move.w     DEV_TAB(a0),d3
		/* addq.w     #1,d3  */
		dc.w 0x0643,1 /* XXX */
		andi.l     #0x0000FFFF,d3
		move.w     DEV_TAB+2(a0),d4
		/* addq.w     #1,d4 */
		dc.w 0x0644,1 /* XXX */
		movem.l    (a7)+,d2/d6/a0-a3
		move.w     d3,d7
		move.w     paste_dx-paste_src(a0),d0
		move.w     paste_width-paste_src(a0),d5
		sub.w      d0,d7
		cmp.w      d7,d5
		ble.s      paste_pi1_16
		move.w     d7,paste_width-paste_src(a0)
paste_pi1_16:
		move.w     d4,d7
		move.w     paste_dy-paste_src(a0),d0
		move.w     paste_height-paste_src(a0),d5
		sub.w      d0,d7
		cmp.w      d7,d5
		ble.s      paste_pi1_17
		move.w     d7,paste_height-paste_src(a0)
paste_pi1_17:
		cmpi.w     #16,d6
		beq        paste_hi
		cmpi.w     #8,d6
		blt.s      paste_pi1_18
		movem.l    d0-d7/a0-a1,-(a7)
		bsr        calc_optab
		move.w     paste_width-paste_src(a0),(a1)+ /* b_wd */
		move.w     paste_height-paste_src(a0),(a1)+ /* b_ht */
		move.w     #4,(a1)+ /* plane_cnt */
		move.w     #12,(a1)+ /* fg_col */
		move.w     #10,(a1)+ /* bg_col */
		move.l     d0,(a1)+ /* op_tab */
		move.w     paste_sx-paste_src(a0),(a1)+ /* s_xmin */
		move.w     paste_sy-paste_src(a0),(a1)+ /* s_ymin */
		move.l     paste_dst-paste_src(a0),d6
		/* addq.l     #8,d6 */
		dc.w 0x0686,0,8 /* XXX */
		move.l     d6,(a1)+ /* s_form */
		move.w     #8,(a1)+ /* s_nxwd */
		move.w     #160,(a1)+ /* s_nxln */
		move.w     #2,(a1)+ /* s_nxpl */
		move.w     paste_dx-paste_src(a0),(a1)+ /* d_xmin */
		move.w     paste_dy-paste_src(a0),(a1)+ /* d_ymin */
		move.l     paste_dst-paste_src(a0),d6
		/* addq.l     #8,d6 */
		dc.w 0x0686,0,8 /* XXX */
		move.l     d6,(a1)+ /* d_form */
		move.w     d2,(a1)+ /* d_nxwd */
		move.w     d1,(a1)+ /* d_nxln */
		move.w     #2,(a1)+ /* d_nxpl */
		move.l     #0,(a1)+ /* p_addr */
		lea.l      bitblt(pc),a6
		dc.w       0xa007 /* bit_blt */
		movem.l    (a7)+,d0-d7/a0-a1
paste_pi1_18:
		move.w     paste_width-paste_src(a0),(a1)+ /* b_wd */
		move.w     paste_height-paste_src(a0),(a1)+ /* b_ht */
		move.w     #4,(a1)+ /* plane_cnt */
		move.w     #1,(a1)+ /* fg_col */
		move.w     #0,(a1)+ /* bg_col */
		move.l     #0x03030303,(a1)+ /* op_tab 4 x S_ONLY */
		move.w     paste_sx-paste_src(a0),(a1)+ /* s_xmin */
		move.w     paste_sy-paste_src(a0),(a1)+ /* s_ymin */
		move.l     (a0),(a1)+ /* s_form */
		move.w     #8,(a1)+ /* s_nxwd */
		move.w     #160,(a1)+ /* s_nxln */
		move.w     #2,(a1)+ /* s_nxpl */
		move.w     paste_dx-paste_src(a0),(a1)+ /* d_xmin */
		move.w     paste_dy-paste_src(a0),(a1)+ /* d_ymin */
		move.l     paste_dst-paste_src(a0),(a1)+ /* d_form */
		move.w     d2,(a1)+ /* d_nxwd */
		move.w     d1,(a1)+ /* d_nxln */
		move.w     #2,(a1)+ /* d_nxpl */
		move.l     #0,(a1)+ /* p_addr */
		lea.l      bitblt(pc),a6
		dc.w       0xa007 /* bit_blt */
		movem.l    (a7)+,a0-a6
		rts

paste_src: dc.l 0
paste_sx: dc.w 0
paste_sy: dc.w 0
paste_width: dc.w 0
paste_height: dc.w 0
paste_dst: dc.l 0
paste_dx: dc.w 0
paste_dy: dc.w 0
paste_colreg: dc.w 0

calc_optab:
		moveq.l    #0,d0
		move.w     paste_colreg-paste_src(a0),d3
		btst       #4,d3
		beq.s      calc_optab1
		ori.l      #0x0F000000,d0
calc_optab1:
		btst       #5,d3
		beq.s      calc_optab2
		ori.l      #0x000F0000,d0
calc_optab2:
		btst       #6,d3
		beq.s      calc_optab3
		ori.l      #0x00000F00,d0
calc_optab3:
		btst       #7,d3
		beq.s      calc_optab4
		ori.l      #0x0000000F,d0
calc_optab4:
		rts

paste_hi:
		moveq.l    #0,d0
		moveq.l    #0,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
		move.w     d1,d4
		move.l     d4,d5
		moveq.l    #0,d1
		move.w     paste_sx-paste_src(a0),d0
		move.w     paste_sy-paste_src(a0),d1
		move.w     paste_dx-paste_src(a0),d2
		move.w     paste_dy-paste_src(a0),d3
		movea.l    (a0),a1
		movea.l    paste_dst-paste_src(a0),a2
		lea.l      32000(a1),a5
		mulu.w     d3,d5
		asl.w      #1,d2
		add.l      d2,d5
		adda.l     d5,a2
		move.w     #200-1,d7 /* BUG: ignores height */
paste_hi1:
		moveq.l    #0,d6
		lea.l      ZERO(a1),a3
		lea.l      ZERO(a2),a4
paste_hi2:
		moveq.l    #0,d5
paste_hi3:
		moveq.l    #0,d0
		bftst      0(a3,d6.w*8){d5:1} ; 68020+ only
		beq.s      paste_hi4
		bset       #0,d0
paste_hi4:
		bftst      2(a3,d6.w*8){d5:1} ; 68020+ only
		beq.s      paste_hi5
		bset       #1,d0
paste_hi5:
		bftst      4(a3,d6.w*8){d5:1} ; 68020+ only
		beq.s      paste_hi6
		bset       #2,d0
paste_hi6:
		bftst      6(a3,d6.w*8){d5:1} ; 68020+ only
		beq.s      paste_hi7
		bset       #3,d0
paste_hi7:
		move.w     0(a5,d0.w*2),d0 ; 68020+ only
		move.w     d0,d1
		move.w     d0,d2
		andi.w     #0x0700,d0
		rol.w      #5,d0
		andi.w     #0x0070,d1
		rol.w      #4,d1
		andi.w     #0x0007,d2
		rol.w      #2,d2
		or.w       d2,d1
		or.w       d1,d0
		move.w     d0,(a4)+
		addq.w     #1,d5
		cmpi.w     #16,d5
		bne.s      paste_hi3
		addq.w     #1,d6
		cmpi.w     #20,d6 /* BUG: ignores width */
		bne.s      paste_hi2
		lea.l      160(a1),a1
		adda.l     d4,a2
		dbf        d7,paste_hi1
		movem.l    (a7)+,a0-a6
		rts

bitblt: ds.b 78 /* 13fe8 */

/*
 * Syntax:   ADR=bodychunk(BANK)
 */
lib44:
	dc.w lib44_1-lib44
	dc.w	0
bodychunk:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      bodychunk1
		move.l     d3,-(a6)
lib44_1:		jsr        L_addrofbank.l
bodychunk1:
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    d3,a0
/* FIXME: walk through list of chunks instead */
		move.l     #256,d7
bodychunk2:
		tst.l      d7
		beq.s      bodychunk3
		subq.l     #1,d7
		cmpi.b     #'B',(a0)+
		bne.s      bodychunk2
		cmpi.b     #'O',(a0)
		bne.s      bodychunk2
		cmpi.b     #'D',1(a0)
		bne.s      bodychunk2
		cmpi.b     #'Y',2(a0)
		bne.s      bodychunk2
		subq.l     #1,a0
		move.l     a0,ilbm_body-params(a6)
		moveq.l    #0,d7
		bra.s      bodychunk4
bodychunk3:
		moveq.l    #-1,d7
bodychunk4:
		tst.l      d7
		bne.s      bodychunk5
		move.l     a0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
bodychunk5:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _bitblit SOURCE,S_X,S_Y,WIDTH,HEIGHT,DEST,D_X,D_Y,OP
 */
lib45:
	dc.w lib45_1-lib45
	dc.w lib45_2-lib45
	dc.w	0
bitblit:
		move.l     (a6)+,d3
		lea.l      bitblit_op(pc),a1
		move.l     d3,(a1)
		move.l     (a6)+,d3
		tst.l      d3
		bpl.w      bitblit1 /* XXX */
		clr.l      d3
bitblit1:
		lea.l      bitblit_dy(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		tst.l      d3
		bpl.w      bitblit2 /* XXX */
		clr.l      d3
bitblit2:
		lea.l      bitblit_dx(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      bitblit3
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib45_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
bitblit3:
		lea.l      bitblit_dst(pc),a1
		move.l     d3,(a1)
		move.l     (a6)+,d3
		lea.l      bitblit_height(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		lea.l      bitblit_width(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		tst.l      d3
		bpl.s      bitblit4
		clr.l      d3
bitblit4:
		cmpi.l     #200-1,d3
		ble.s      bitblit5
		move.l     #200-1,d3
bitblit5:
		lea.l      bitblit_sy(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		tst.l      d3
		bpl.s      bitblit6
		clr.l      d3
bitblit6:
		cmpi.l     #320-1,d3
		ble.s      bitblit7
		move.l     #320-1,d3
bitblit7:
		lea.l      bitblit_sx(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      bitblit8
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib45_2:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
bitblit8:
		lea.l      bitblit_src(pc),a1
		move.l     d3,(a1)
		movem.l    a0-a6,-(a7)
		lea.l      bitblit_src(pc),a0
		lea.l      bitblt2,a1 /* BUG: absolute address */
		movem.l    a0-a1,-(a7)
		dc.w       0xa000
		movea.l    d0,a0
		move.w     V_BYTES_LIN(a0),d1
		move.w     ZERO(a0),d2 /* LA_PLANES */
		move.w     d2,d6
		asl.w      #1,d2
		move.w     DEV_TAB(a0),d3
		/* addq.w     #1,d3 */
		dc.w 0x0643,1 /* XXX */
		andi.l     #0x0000FFFF,d3
		move.w     DEV_TAB+2(a0),d4
		/* addq.w     #1,d4 */
		dc.w 0x0644,1 /* XXX */
		movem.l    (a7)+,a0-a1
		move.w     d3,d7
		move.w     bitblit_dx-bitblit_src(a0),d0
		move.w     bitblit_width-bitblit_src(a0),d5
		sub.w      d0,d7
		cmp.w      d7,d5
		ble.s      bitblit13
		move.w     d7,bitblit_width-bitblit_src(a0)
bitblit13:
		move.w     d4,d7
		move.w     bitblit_dy-bitblit_src(a0),d0
		move.w     bitblit_height-bitblit_src(a0),d5
		sub.w      d0,d7
		cmp.w      d7,d5
		ble.s      bitblit14
		move.w     d7,bitblit_height-bitblit_src(a0)
bitblit14:
		cmpi.w     #8,d6
		ble.s      bitblit15
		movem.l    (a7)+,a0-a6
		rts
bitblit15:
		lea.l      bitblit_op(pc),a3
		move.w     bitblit_width-bitblit_src(a0),(a1)+ /* b_wd */
		move.w     bitblit_height-bitblit_src(a0),(a1)+ /* b_ht */
		move.w     d6,(a1)+ /* plane_cnt */
		move.w     #12,(a1)+ /* fg_col */
		move.w     #10,(a1)+ /* bg_col */
		move.l     (a3),d0
		asl.l      #2,d0
		move.l     bitblit_optab-bitblit_op(a3,d0.l),(a1)+ /* op_tab */
		move.w     bitblit_sx-bitblit_src(a0),(a1)+ /* s_xmin */
		move.w     bitblit_sy-bitblit_src(a0),(a1)+ /* s_ymin */
		move.l     (a0),(a1)+ /* s_form */
		move.w     d2,(a1)+ /* s_nxwd */
		move.w     d1,(a1)+ /* s_nxln */
		move.w     #2,(a1)+ /* s_nxpl */
		move.w     bitblit_dx-bitblit_src(a0),(a1)+ /* d_xmin */
		move.w     bitblit_dy-bitblit_src(a0),(a1)+ /* d_ymin */
		move.l     bitblit_dst-bitblit_src(a0),(a1)+ /* d_form */
		move.w     d2,(a1)+ /* d_nxwd */
		move.w     d1,(a1)+ /* d_nxln */
		move.w     #2,(a1)+ /* d_nxpl */
		move.l     #0,(a1)+ /* p_addr */
		lea.l      bitblt2,a6 /* BUG: absolute address */
		dc.w       0xa007 /* bit_blt */
		movem.l    (a7)+,a0-a6
		rts

bitblit_src: dc.l 0
bitblit_sx: dc.w 0
bitblit_sy: dc.w 0
bitblit_width: dc.w 0
bitblit_height: dc.w 0
bitblit_dst: dc.l 0
bitblit_dx: dc.w 0
bitblit_dy: dc.w 0
bitblit_op: dc.l 0

bitblit_optab:
           dc.b 0,0,0,0
           dc.b 1,1,1,1
           dc.b 2,2,2,2
           dc.b 3,3,3,3
           dc.b 4,4,4,4
           dc.b 5,5,5,5
           dc.b 6,6,6,6
           dc.b 7,7,7,7
           dc.b 8,8,8,8
           dc.b 9,9,9,9
           dc.b 10,10,10,10
           dc.b 11,11,11,11
           dc.b 12,12,12,12
           dc.b 13,13,13,13
           dc.b 14,14,14,14
           dc.b 15,15,15,15

bitblt2: ds.b 78 /* 13fe8 */

lib46:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _convert pi1 SRCE,DEST[,COL_REG]
 */
lib47:
	dc.w lib47_1-lib47
	dc.w lib47_2-lib47
	dc.w	0
convert_pi1:
		lea        convert_colreg(pc),a1
		move.l     #0,(a1)
		cmpi.b     #1,d0
		beq.s      convert_pi1_1
		cmpi.w     #2,d0
		beq.s      convert_pi0
		rts
convert_pi0:
		move.l     (a6)+,d3
		andi.l     #0x000000F0,d3
		move.b     d3,(a1)
convert_pi1_1:
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      convert_pi1_2
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib47_1:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
convert_pi1_2:
		lea.l      convert_dst(pc),a1
		move.l     d3,(a1)
		move.l     (a6)+,d3
		cmpi.l     #MAX_BANKS-1,d3
		bgt.s      convert_pi1_3
		movem.l    a0-a1,-(a7)
		move.l     d3,-(a6)
lib47_2:	jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a1
convert_pi1_3:
		lea.l      convert_src(pc),a1
		move.l     d3,(a1)
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		btst       #7,d0 /* ST-compatible? */
		bne.s      convert_pi1_7
		btst       #3,d0 /* 80 columns? */
		beq.s      convert_pi1_7
		btst       #4,d0 /* VGA-mode? */
		bne.s      convert_pi1_4
		btst       #8,d0 /* double-scan? */
		bne.s      convert_pi1_7
		bra.s      convert_pi1_5
convert_pi1_4:
		btst       #8,d0 /* double-scan? */
		beq.s      convert_pi1_7
convert_pi1_5:
		moveq.l    #S_st_mouse_stat,d0
		trap       #5
		lea.l      convert_mousestat(pc),a0
		move.w     d1,(a0)
		tst.w      d1
		beq.s      convert_pi1_6
		moveq.l    #S_st_mouse_off,d0
		trap       #5
convert_pi1_6:
		dc.w       0xa000 /* linea_init */
		movea.l    d0,a2
		movea.l    convert_src(pc),a0
		movea.l    convert_dst(pc),a1
		move.w     ZERO(a2),d5 /* LA_PLANES */
		cmpi.w     #4,d5
		beq.s      convert_4planes
		cmpi.w     #8,d5
		beq        convert_8planes
		cmpi.w     #16,d5
		beq        convert_hi
		move.w     convert_mousestat(pc),d0
		tst.w      d0
		beq.s      convert_pi1_7
		moveq.l    #S_st_mouse_on,d0
		trap       #5
convert_pi1_7:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

convert_src: dc.l 0
	ds.w 4
convert_dst: dc.l 0
	dc.l 0
convert_mousestat: dc.w 0

convert_4planes:
		moveq.l    #0,d2
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.l     #160,d4
		move.w     ZERO(a2),d2 /* LA_PLANES */
		asl.w      #1,d2
		move.w     V_BYTES_LIN(a2),d6
		move.w     #200,d7
		subq.w     #1,d7
convert_4planes1:
		moveq.l    #4-1,d3
		lea.l      ZERO(a0),a2
		lea.l      ZERO(a1),a3
convert_4planes2:
		moveq.l    #20-1,d1
		lea.l      ZERO(a2),a4
		lea.l      ZERO(a3),a5
convert_4planes3:
		move.w     ZERO(a4),d0
		movem.l    d7,-(a7)
		moveq.l    #15,d7
		moveq.l    #0,d5
convert_4planes4:
		rol.w      #1,d0
		bcs.s      convert_4planes5
		andi.b     #0xFC,d5
		bra.s      convert_4planes6
convert_4planes5:
		ori.b      #0x03,d5
convert_4planes6:
		rol.l      #2,d5
		dbf        d7,convert_4planes4
		ror.l      #2,d5
		movem.l    (a7)+,d7
		swap       d5
		move.w     d5,(a5)
		adda.l     d2,a5
		swap       d5
		move.w     d5,(a5)
		adda.l     d2,a5
		addq.l     #8,a4
		dbf        d1,convert_4planes3
		addq.l     #2,a2
		addq.l     #2,a3
		dbf        d3,convert_4planes2
		adda.l     d4,a0
		adda.l     d6,a1
		dbf        d7,convert_4planes1
		move.w     convert_mousestat(pc),d0
		tst.w      d0
		beq.s      convert_4planes7
		moveq.l    #S_st_mouse_on,d0
		trap       #5
convert_4planes7:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

convert_8planes:
		bsr        calc_8planes
		moveq.l    #0,d2
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.l     #160,d4
		move.w     ZERO(a2),d2 /* LA_PLANES */
		asl.w      #1,d2
		move.w     V_BYTES_LIN(a2),d6
		move.w     #200,d7
		subq.w     #1,d7
		lea.l      plane8pixels(pc),a6
convert_8planes1:
		moveq.l    #3,d3
		lea.l      ZERO(a0),a2
		lea.l      ZERO(a1),a3
convert_8planes2:
		moveq.l    #19,d1
		lea.l      ZERO(a2),a4
		lea.l      ZERO(a3),a5
convert_8planes3:
		move.w     ZERO(a4),d0
		movem.l    d7,-(a7)
		moveq.l    #15,d7
		moveq.l    #0,d5
convert_8planes4:
		rol.w      #1,d0
		bcs.s      convert_8planes5
		andi.b     #0xFC,d5
		bra.s      convert_8planes6
convert_8planes5:
		ori.b      #0x03,d5
convert_8planes6:
		rol.l      #2,d5
		dbf        d7,convert_8planes4
		ror.l      #2,d5
		movem.l    (a7)+,d7
		swap       d5
		move.w     d5,(a5)
		tst.w      d3
		bne.s      convert_8planes7
		move.w     ZERO(a6),2(a5)
		move.w     2(a6),4(a5)
		move.w     4(a6),6(a5)
		move.w     6(a6),8(a5)
convert_8planes7:
		adda.l     d2,a5
		swap       d5
		move.w     d5,(a5)
		tst.w      d3
		bne.s      convert_8planes8
		move.w     ZERO(a6),2(a5)
		move.w     2(a6),4(a5)
		move.w     4(a6),6(a5)
		move.w     6(a6),8(a5)
convert_8planes8:
		adda.l     d2,a5
		addq.l     #8,a4
		dbf        d1,convert_8planes3
		addq.l     #2,a2
		addq.l     #2,a3
		dbf        d3,convert_8planes2
		adda.l     d4,a0
		adda.l     d6,a1
		dbf        d7,convert_8planes1
		move.w     convert_mousestat(pc),d0
		tst.w      d0
		beq.s      convert_8planes9
		moveq.l    #S_st_mouse_on,d0
		trap       #5
convert_8planes9:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

convert_hi:
		moveq.l    #0,d4
		move.w     V_BYTES_LIN(a2),d4
		lea.l      32000(a0),a4
		move.w     #200-1,d7
convert_hi1:
		moveq.l    #0,d6
		lea.l      ZERO(a0),a2
		lea.l      ZERO(a1),a3
convert_hi2:
		moveq.l    #0,d5
convert_hi3:
		moveq.l    #0,d0
		bftst      0(a2,d6.w*8){d5:1} ; 68020+ only
		beq.s      convert_hi4
		bset       #0,d0
convert_hi4:
		bftst      2(a2,d6.w*8){d5:1} ; 68020+ only
		beq.s      convert_hi5
		bset       #1,d0
convert_hi5:
		bftst      4(a2,d6.w*8){d5:1} ; 68020+ only
		beq.s      convert_hi6
		bset       #2,d0
convert_hi6:
		bftst      6(a2,d6.w*8){d5:1} ; 68020+ only
		beq.s      convert_hi7
		bset       #3,d0
convert_hi7:
		move.w     0(a4,d0.w*2),d0 ; 68020+ only
		move.w     d0,d1
		move.w     d0,d2
		andi.w     #0x0700,d0
		rol.w      #5,d0
		andi.w     #0x0070,d1
		rol.w      #4,d1
		andi.w     #0x0007,d2
		rol.w      #2,d2
		or.w       d2,d1
		or.w       d1,d0
		move.w     d0,(a3)+
		move.w     d0,(a3)+
		addq.w     #1,d5
		cmpi.w     #16,d5
		bne.s      convert_hi3
		addq.w     #1,d6
		cmpi.w     #20,d6
		bne.s      convert_hi2
		lea.l      160(a0),a0
		adda.l     d4,a1
		dbf        d7,convert_hi1
		move.w     convert_mousestat(pc),d0
		tst.w      d0
		beq.s      convert_hi8
		moveq.l    #S_st_mouse_on,d0
		trap       #5
convert_hi8:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

calc_8planes:
		lea.l      plane8pixels(pc),a5
		move.b     convert_colreg(pc),d6
		moveq.l    #4,d7
calc_8planes1:
		moveq.l    #0,d2
		btst       d7,d6
		beq.s      calc_8planes2
		move.w     #-1,d2
calc_8planes2:
		move.w     d2,(a5)+
		addq.w     #1,d7
		cmpi.w     #8,d7
		bne.s      calc_8planes1
		rts

convert_colreg: dc.b 0,0

plane8pixels: ds.w 4
	ds.l 1 /* unused */



libex:
	ds.w 1

ZERO equ 0
