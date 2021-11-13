	.include "system.inc"
	.include "errors.inc"
	.include "window.inc"
	.include "sprites.inc"
	.include "equates.inc"
	.include "lib.inc"
	.include "fli.inc"

V_BYTES_LIN = -2

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
	dc.w	libex-lib8

para:
	dc.w	8			; number of library routines
	dc.w	8			; number of extension commands
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l003-para
	.dc.w l004-para
	.dc.w l005-para
	.dc.w l006-para
	.dc.w l007-para
	.dc.w l008-para

* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,1,1,0           ; _fli bank
l002:	.dc.b I,1,1,0             ; _fli framewidth
l003:	.dc.b 0,I,1               ; _fli screen
        .dc.b   I,',',I,',',I,1,1,0
l004:	.dc.b I,1,1,0             ; _fli frameheight
l005:	.dc.b 0,1,1,0             ; _fli play
l006:	.dc.b I,1,1,0             ; _fli frames
l007:	.dc.b 0,1,1,0             ; _fli stop
l008:	.dc.b I,1,1,0             ; _fli frame

		.even

entry:
	bra.w init
	
params_offset: dc.l params-entry
initscreen_offset: dc.l initscreen-entry
get_curr_frame_offset:	dc.l get_curr_frame-entry

params: /* 10068 */
	ds.l 1
lineavars: ds.l 1 /* 1006c */
banknum: ds.w 1 /* 1007c */
	ds.w 1
playing: ds.w 2 /* 10074 */
playtimer: ds.w 2 /* 10078 */
screenstart: ds.l 1 /* 1007c */

	ds.b 20

initscreen:
		movea.l    d3,a0
		cmpi.w     #FLI_MAGIC,fli_type(a0)
		beq.s      initscreen1
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		beq.s      initscreen1
		rts
initscreen1:
		move.w     fli_frames(a0),d0
		ror.w      #8,d0
		lea        curr_frame(pc),a1
		move.w     d0,num_frames-curr_frame(a1)
		move.w     #1,ZERO(a1)
		lea.l      playtimer(pc),a1
		move.w     fli_speed(a0),d0
		rol.w      #8,d0
		move.w     #3,ZERO(a1)
		move.w     #0,2(a1)
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		beq.s      initscreen2
		tst.w      d0
		beq.s      initscreen2
		cmpi.w     #3,d0
		ble.s      initscreen2
		cmpi.w     #5,d0
		bge.s      initscreen2
		move.w     d0,ZERO(a1)
initscreen2:
		lea.l      bytes_lin(pc),a1
		move.w     fli_width(a0),d0
		rol.w      #8,d0
		move.w     d0,fliwidth-bytes_lin(a1)
		move.w     fli_height(a0),d0
		rol.w      #8,d0
		move.w     d0,fliheight-bytes_lin(a1)
		move.l     fli_oframe1(a0),d0
		rol.w      #8,d0
		swap       d0
		rol.w      #8,d0
		tst.l      d0
		bne.s      initscreen3
		move.l     #fli_headersize,d0
initscreen3:
		adda.l     d0,a0
		lea        framestart(pc),a1
		move.l     a0,ZERO(a1)
		move.l     a0,firstframe-framestart(a1)
		lea        params(pc),a0
		move.l     lineavars-params(a0),a0
		lea        bytes_lin(pc),a1
		move.w     V_BYTES_LIN(a0),d0
		move.w     d0,(a1)
		rts

get_curr_frame:
		clr.l      d2
		clr.l      d3
		clr.l      d4
		move.w     curr_frame(pc),d3
		rts

newvbl:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      playing(pc),a1
		tst.w      ZERO(a1)
		beq.s      newvbl1
		lea.l      playtimer(pc),a0
		move.w     ZERO(a0),d0
		addq.w     #1,2(a0)
		cmp.w      2(a0),d0
		bne.s      newvbl1
		move.w     #0,2(a0)
		tst.w      2(a1)
		bne.s      newvbl1
		bsr.s      decode_frame
		lea.l      playing(pc),a1
		move.l     d0,(a1)
newvbl1:
		movem.l    (a7)+,d0-d7/a0-a6
gooldvbl:
		jmp        0.l

decode_frame:
		movea.l    screenstart(pc),a0
		lea.l      curr_frame(pc),a5
		movea.l    framestart(pc),a1
		lea.l      palette(pc),a2
		move.w     num_frames(pc),d3
		cmp.w      curr_frame(pc),d3
		bne.s      decode_frame1
		movea.l    firstframe(pc),a1
		move.w     #0,(a5)
decode_frame1:
		/* addq.w     #1,(a5) */
		dc.w 0x0655,1 /* XXX */
		moveq.l    #0,d2
		cmpi.w     #FLI_FRAME_MAGIC,fli_type(a1)
		beq.s      decode_frame2
		moveq.l    #0,d0
		rts
decode_frame2:
		movea.l    a1,a4
		move.l     ZERO(a1),d1 /* XXX fli_size */
		ror.w      #8,d1
		swap       d1
		ror.w      #8,d1
		adda.l     d1,a4
		lea.l      framestart(pc),a5
		move.l     a4,(a5)
		move.w     6(a1),d1 /* get number of chunks */
		ror.w      #8,d1
		subq.w     #1,d1
		bmi.s      decode_frame4
		lea.l      16(a1),a1 /* start of first chunk */
decode_frame3:
		moveq.l    #0,d0
		move.b     fli_type(a1),d0
		cmpi.w     #FLI_COLOR_64,d0
		beq        decode_color_64
		cmpi.w     #FLI_DELTA_FLI,d0
		beq        decode_delta_fli
		cmpi.w     #FLI_BLACK,d0
		beq        decode_black
		cmpi.w     #FLI_BYTE_RUN,d0
		beq        decode_byte_run
		cmpi.w     #FLI_COPY,d0
		beq        decode_literal
		cmpi.w     #FLI_COLOR_256,d0
		beq.s      decode_color_256
		cmpi.w     #FLI_DELTA_FLC,d0
		beq        decode_delta_flc
		move.l     fli_size(a1),d7
		ror.w      #8,d7
		swap       d7
		ror.w      #8,d7
		adda.l     d7,a1
		dble       d1,decode_frame3
decode_frame4:
		move.l     #0xFFFF0000,d0
		rts

decode_color_256:
		addq.l     #6,a1
		move.w     (a1)+,d7
		ror.w      #8,d7
		add.w      d7,d2
		subq.w     #1,d2
		cmpi.w     #256,d2
		blt.s      decode_color_256_1
		moveq.l    #0,d2
decode_color_256_1:
		move.w     (a1)+,d7
		ror.w      #8,d7
		tst.w      d7
		bgt.s      decode_color_256_2
		move.w     #256,d7
decode_color_256_2:
		move.b     (a1)+,d6
		andi.w     #0x00F8,d6
		lsl.w      #8,d6
		move.b     (a1)+,d5
		andi.w     #0x00FC,d5
		lsl.w      #3,d5
		or.w       d5,d6
		move.b     (a1)+,d5
		andi.b     #0xF8,d5
		lsr.w      #3,d5
		or.l       d5,d6
		move.w     d6,0(a2,d2.w*2) ; 68020+ only
		addq.w     #1,d2
		subq.w     #1,d7
		bgt.s      decode_color_256_2
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

decode_color_64:
		addq.l     #6,a1
		move.w     (a1)+,d7
		ror.w      #8,d7
		add.w      d7,d2
		subq.w     #1,d2
		cmpi.w     #256,d2
		blt.s      decode_color_64_1
		moveq.l    #0,d2
decode_color_64_1:
		move.w     (a1)+,d7
		ror.w      #8,d7
		tst.w      d7
		bgt.s      decode_color_64_2
		move.w     #256,d7
decode_color_64_2:
		move.b     (a1)+,d6
		andi.w     #0x003E,d6
		lsl.w      #8,d6
		lsl.w      #2,d6
		move.b     (a1)+,d5
		andi.w     #0x003F,d5
		lsl.w      #5,d5
		or.w       d5,d6
		move.b     (a1)+,d5
		andi.w     #0x003E,d5
		lsr.w      #1,d5
		or.w       d5,d6
		move.w     d6,0(a2,d2.w*2) ; 68020+ only
		addq.w     #1,d2
		subq.w     #1,d7
		bgt.s      decode_color_64_2
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

decode_delta_fli:
		addq.l     #6,a1
		moveq.l    #0,d6
		move.w     fliwidth(pc),d6
		moveq.l    #0,d7
		move.w     fliheight(pc),d7
		move.w     bytes_lin(pc),d5
		movea.l    a0,a4
		movem.l    d0-d4/a3,-(a7)
		move.w     (a1)+,d0  /* get y */
		ror.w      #8,d0
		move.w     (a1)+,d1 /* get #lines */
		ror.w      #8,d1
		mulu.w     d5,d0
		adda.l     d0,a0
		subq.w     #1,d1
decode_delta_fli1:
		movea.l    a0,a3
		moveq.l    #0,d3
		move.b     (a1)+,d3 /* get opcount */
		beq.s      decode_delta_fli7
		subq.w     #1,d3
decode_delta_fli2:
		moveq.l    #0,d0
		move.b     (a1)+,d0 /* get x-offset */
		add.w      d0,d0
		adda.l     d0,a0
		moveq.l    #0,d0
		moveq.l    #0,d2
		move.b     (a1)+,d2 /* get x-size */
		bmi.s      decode_delta_fli4
		beq.s      decode_delta_fli6
		subq.w     #1,d2
decode_delta_fli3:
		/* copy segment */
		move.b     (a1)+,d0
		move.w     (0.l,a2,d0.w*2),(a0)+ /* XXX */
		dbf        d2,decode_delta_fli3
		bra.s      decode_delta_fli6
decode_delta_fli4:
		/* repeat one */
		neg.b      d2
		subq.w     #1,d2
		move.b     (a1)+,d0
		move.w     (0.l,a2,d0.w*2),d0 /* XXX */
decode_delta_fli5:
		move.w     d0,(a0)+
		dbf        d2,decode_delta_fli5
decode_delta_fli6:
		dbf        d3,decode_delta_fli2
decode_delta_fli7:
		lea.l      0(a3,d5.w),a0
		dbf        d1,decode_delta_fli1
		movem.l    (a7)+,d0-d4/a3
		movea.l    a4,a0
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

decode_black:
		addq.l     #6,a1
		move.w     fliwidth(pc),d7
		move.w     fliheight(pc),d6
		move.w     (a2),d5 /* palette[0] */
decode_black1:
		move.w     d5,(a0)+
		dblt       d7,decode_black1
		move.w     fliwidth(pc),d7
		dblt       d6,decode_black1
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

decode_byte_run:
		addq.l     #6,a1
		moveq.l    #0,d6
		move.w     fliwidth(pc),d6
		move.w     fliheight(pc),d7
		moveq.l    #0,d5
		move.w     bytes_lin(pc),d5
		movem.l    d0-d4,-(a7)
		add.l      d6,d6
		sub.l      d6,d5
		subq.w     #1,d7
decode_byte_run1:
		addq.l     #1,a1
		move.l     a0,d3
		add.l      d6,d3
decode_byte_run2:
		moveq.l    #0,d2
		moveq.l    #0,d0
		move.b     (a1)+,d2
		bpl.s      decode_byte_run4
		beq.s      decode_byte_run6
		neg.b      d2
		subq.w     #1,d2
decode_byte_run3:
		move.b     (a1)+,d0
		move.w     0(a2,d0.w*2),(a0)+ ; 68020+ only
		cmpa.l     d3,a0
		bge.s      decode_byte_run7
		dbf        d2,decode_byte_run3
		bra.s      decode_byte_run6
decode_byte_run4:
		subq.w     #1,d2
		move.b     (a1)+,d0
		move.w     0(a2,d0.w*2),d0 ; 68020+ only
decode_byte_run5:
		move.w     d0,(a0)+
		cmpa.l     d3,a0
		bge.s      decode_byte_run7
		dbf        d2,decode_byte_run5
decode_byte_run6:
		cmpa.l     d3,a0
		blt.s      decode_byte_run2
decode_byte_run7:
		adda.l     d5,a0
		dbf        d7,decode_byte_run1
		movem.l    (a7)+,d0-d4
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

decode_literal:
		addq.l     #6,a1
		move.w     fliwidth(pc),d7
		move.w     fliheight(pc),d6
decode_literal1:
		move.b     (a1)+,d5
		move.w     0(a2,d5.w*2),(a0)+ ; 68020+ only
		dblt       d7,decode_literal1
		move.w     fliwidth(pc),d7
		dblt       d6,decode_literal1
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

decode_delta_flc:
		addq.l     #6,a1
		movem.l    d0-d4,-(a7)
		move.w     fliwidth(pc),d6
		move.w     fliheight(pc),d7
		moveq.l    #0,d5
		move.w     bytes_lin(pc),d5
		move.w     (a1)+,d4
		beq        decode_delta_flc12
		ror.w      #8,d4
		subq.w     #1,d4
decode_delta_flc1:
		moveq.l    #0,d3
decode_delta_flc2:
		move.w     (a1)+,d0
		ror.w      #8,d0
		tst.w      d0
		bpl.s      decode_delta_flc4
		btst       #14,d0
		beq.s      decode_delta_flc3
		neg.w      d0
		mulu.w     d5,d0
		adda.l     d0,a0
		bra.s      decode_delta_flc2
decode_delta_flc3:
		move.b     d0,d3
		swap       d3
		eor.b      d3,d3
		bra.s      decode_delta_flc2
decode_delta_flc4:
		movea.l    d3,a4
		move.w     d0,d3
		beq.s      decode_delta_flc10
		subq.w     #1,d3
		movea.l    a0,a3
decode_delta_flc5:
		moveq.l    #0,d0
		move.b     (a1)+,d0
		add.w      d0,d0
		adda.l     d0,a0
		moveq.l    #0,d2
		move.b     (a1)+,d2
		bmi.s      decode_delta_flc7
		beq.s      decode_delta_flc9
		subq.w     #1,d2
		moveq.l    #0,d0
decode_delta_flc6:
		move.b     (a1)+,d0
		move.w     0(a2,d0.w*2),(a0)+ ; 68020+ only
		move.b     (a1)+,d0
		move.w     0(a2,d0.w*2),(a0)+ ; 68020+ only
		dbf        d2,decode_delta_flc6
		bra.s      decode_delta_flc9
decode_delta_flc7:
		neg.b      d2
		subq.w     #1,d2
		moveq.l    #0,d0
		moveq.l    #0,d1
		move.b     (a1)+,d1
		move.w     0(a2,d1.w*2),d0 ; 68020+ only
		swap       d0
		move.b     (a1)+,d0
		move.w     0(a2,d0.w*2),d0 ; 68020+ only
decode_delta_flc8:
		move.l     d0,(a0)+
		dbf        d2,decode_delta_flc8
decode_delta_flc9:
		dbf        d3,decode_delta_flc5
decode_delta_flc10:
		move.l     a4,d0
		tst.b      d0
		beq.s      decode_delta_flc11
		swap       d0
		move.w     0(a2,d0.w*2),(a0)+ ; 68020+ only
decode_delta_flc11:
		lea.l      0(a3,d5.w),a0
		dbf        d4,decode_delta_flc1
decode_delta_flc12:
		movem.l    (a7)+,d0-d4
		dbf        d1,decode_frame3
		move.l     #0xFFFF0000,d0
		rts

bytes_lin: ds.w 1 /* 104c2 */
fliwidth: ds.w 1 /* 104c4 */
fliheight: ds.w 1 /* 104c6 */
framestart: ds.l 1 /* 104c8 */
firstframe: ds.l 1 /* 104cc */
curr_frame: ds.w 1 /* 104d0 */
num_frames: ds.w 1 /* 104d2 */
	ds.b 14
palette: ds.w 256

	ds.w 256

init:
		movem.l    d0-d7/a0-a6,-(a7)
		dc.w 0xa000
		lea.l      params(pc),a4
		move.l     a0,lineavars-params(a4)
		pea.l      installvbl(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a0-a6
		lea        exit(pc),a2
		rts

installvbl:
		move.w     #0x2300,sr
		lea        playing(pc),a0
		move.l     #0,(a0)
		/* movea.l    #0x00000070,a0 */
		dc.w 0x207c,0,112 /* XXX */
		lea        gooldvbl+2(pc),a1
		move.l     (a0),(a1)
		lea        newvbl(pc),a1
		move.l     a1,(a0)
		move.w     #0x2700,sr
		rts

restorevbl:
		move.w     #0x2300,sr
		/* movea.l    #0x00000070,a0 */
		dc.w 0x207c,0,112 /* XXX */
		move.l     gooldvbl+2(pc),a1
		move.l     a1,(a0)
		move.w     #0x2700,sr
		rts

exit:
		movem.l    d0-d7/a0-a6,-(a7)
		pea.l      restorevbl(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a0-a6
		rts


/*
 * Syntax:   _fli bank BNK
 */
lib1:
	dc.w	0			; no library calls
fli_bank:
		move.l     (a6)+,d3
		andi.l     #15,d3 /* XXX */
		movem.l    d1-d7/a1-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d0
		add.l      d0,a6
		move.w     d3,banknum-params(a6)
		movem.l    (a7)+,d1-d7/a1-a6
		rts

/*
 * Syntax:   FLI_W=_fli framewidth
 */
lib2:
	dc.w lib21-lib2
	dc.w	0
fli_framewidth:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     params_offset-entry(a0),d0
		add.l      d0,a0
		moveq.l    #0,d3
		move.w     banknum-params(a0),d3
		move.l     d3,-(a6)
lib21:	jsr        L_addrofbank.l
		movea.l    d3,a0
		moveq.l    #0,d3
		move.w     fli_width(a0),d3
		rol.w      #8,d3
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _fli screen SCRN[,X_OFFSET,Y_OFFSET]
 */
lib3:
	dc.w lib31-lib3
	dc.w lib32-lib3
	dc.w	0
fli_screen:
		lea.l      screen_offsets(pc),a1
		move.l     #0,(a1) /* XXX */
		cmpi.b     #1,d0
		beq.s      fli_screen2
		cmpi.w     #2,d0
		beq.s      fli_screen1
		rts
fli_screen1:
		move.l     (a6)+,d3
		move.w     d3,2(a1)
		move.l     (a6)+,d3
		move.w     d3,ZERO(a1)
fli_screen2:
		move.l     (a6)+,d3
		cmpi.l     #15,d3
		bgt.s      fli_screen3
		movem.l    d1/a0-a5,-(a7)
		move.l     d3,-(a6)
lib31:	jsr        L_addrofbank.l
		movem.l    (a7)+,d1/a0-a5
fli_screen3:
		movem.l    d0-d2/a1-a5,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     params_offset-entry(a0),d4
		add.l      d4,a0
		
		movea.l    lineavars-params(a0),a2
		lea.l      screen_offsets(pc),a3
		moveq.l    #0,d2
		move.w     V_BYTES_LIN(a2),d2
		mulu.w     2(a3),d2
		move.w     ZERO(a3),d0
		asl.w      #1,d0
		add.l      d0,d2
		add.l      d2,d3
		move.l     d3,screenstart-params(a0)
		moveq.l    #0,d3
		move.w     banknum-params(a0),d3
		move.l     d3,-(a6)
lib32:	jsr        L_addrofbank.l
		movem.l    (a7)+,d0-d2/a1-a5
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     initscreen_offset-entry(a0),d4
		adda.l     d4,a0 /* -> initscreen */
		movem.l    d1-d7/a1-a6,-(a7)
		jsr        (a0)
		movem.l    (a7)+,d1-d7/a1-a6
		rts

screen_offsets: ds.w 2


/*
 * Syntax:   FLI_H=_fli frameheight
 */
lib4:
	dc.w lib41-lib4
	dc.w	0
fli_frameheight:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     params_offset-entry(a0),d0
		add.l      d0,a0
		
		moveq.l    #0,d3
		move.w     banknum-params(a0),d3
		move.l     d3,-(a6)
lib41:  jsr        L_addrofbank.l
		movea.l    d3,a0
		moveq.l    #0,d3
		move.w     fli_height(a0),d3
		rol.w      #8,d3
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _fli play
 */
lib5:
	dc.w	0			; no library calls
fli_play:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     params_offset-entry(a0),d0
		add.l      d0,a0
		move.w     #-1,playing-params(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

/*
 * Syntax:   FRAMES=_fli frames
 */
lib6:
	dc.w lib61-lib6
	dc.w	0
_fli_frames:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     params_offset-entry(a0),d0
		add.l      d0,a0
		moveq.l    #0,d3
		move.w     banknum-params(a0),d3
		move.l     d3,-(a6)
lib61:  jsr        L_addrofbank.l
		move.l     d3,a0
		moveq.l    #0,d3
		move.w     fli_frames(a0),d3
		rol.w      #8,d3
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _fli stop
 */
lib7:
	dc.w	0			; no library calls
fli_stop:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     params_offset-entry(a0),d0
		add.l      d0,a0
		move.l     #0,playing-params(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

/*
 * Syntax:   FRAME=_fli frame
 */
lib8:
	dc.w	0			; no library calls
fli_frame:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     get_curr_frame_offset-entry(a0),d0
		add.l      d0,a0
		jsr        (a0)
		clr.l      d2
		move.l     d3,-(a6)
		rts


ZERO equ 0

libex:
	dc.w 0
