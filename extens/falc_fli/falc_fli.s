	.include "system.inc"
	.include "errors.inc"
	.include "window.inc"
	.include "sprites.inc"
	.include "fli.inc"

V_BYTES_LIN = -2

	.text

        bra.w load
        even
        dc.b $80
tokens:
		dc.b "_fli bank",$80
		dc.b "_fli framewidth",$81
		dc.b "_fli screen",$82
		dc.b "_fli frameheight",$83
		dc.b "_fli play",$84
		dc.b "_fli frames",$85
		dc.b "_fli stop",$86
		dc.b "_fli frame",$87
        dc.b 0
        even

jumps:  dc.w 8
		dc.l fli_bank
		dc.l fli_framewidth
		dc.l fli_screen
		dc.l fli_frameheight
		dc.l fli_play
		dc.l _fli_frames
		dc.l fli_stop
		dc.l fli_frame
		
welcome:
		dc.b 10
		dc.b "Falcon 030 FLI/FLC Player Extension v0.25 ",$bd," A.Hoskin.",0
		dc.b 10
		dc.b "Falcon 030 Extension de FLI/FLC Player v0.25 ",$bd," A.Hoskin.",0
		.even

table: dc.l 0
returnpc: dc.l 0

	dc.w       0

mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
	dc.l 0

cookieid: dc.l 0
cookievalue: dc.l 0
	dc.l 0
mode: dc.l 0

load:
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts

cold:
		move.l     a0,table
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		swap       d0
		lea.l      mode(pc),a0
		move.l     d0,(a0) /* BUG: word only */
		lea.l      mch_cookie(pc),a0
		clr.l      (a0)+
		clr.l      (a0)+
		move.l     #1,(a0)+
		clr.l      (a0)+
		lea.l      cookieid(pc),a1
		move.l     #0x5F4D4348,(a1) /* '_MCH' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold1
		lea.l      cookievalue(pc),a1
		lea.l      mch_cookie(pc),a0
		move.l     (a1),(a0)
cold1:
		lea.l      cookieid(pc),a1
		move.l     #0x5F56444F,(a1) /* '_VDO' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold2
		lea.l      cookievalue(pc),a1
		lea.l      vdo_cookie(pc),a0
		move.l     (a1),(a0)
cold2:
		dc.w 0xa000
		lea.l      lineavars(pc),a1
		move.l     a0,(a1)
		pea.l      installvbl(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		clr.w      x10a58
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		rts

installvbl:
		move.w     #0x2300,sr
		move.l     #0,playing
		/* movea.l    #0x00000070,a0 */
		dc.w 0x207c,0,112 /* XXX */
		movea.l    #gooldvbl+2,a1
		move.l     (a0),(a1)
		move.l     #newvbl,(a0)
		move.w     #0x2700,sr
		rts

warm:
		move.l     #0,playing
		clr.w      x10a58
		rts

getcookie:
		/* movea.l    #0x000005A0.l,a0 */
		dc.w 0x207c,0,0x5a0 /* XXX */
		lea.l      cookievalue(pc),a5
		clr.l      (a5)
		lea.l      cookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      getcookie3
		movea.l    d0,a0
		clr.l      d4
getcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      getcookie3
		cmp.l      d3,d0
		beq.s      getcookie2
		addq.w     #1,d4
		bra.s      getcookie1
getcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      getcookie3
		move.l     d1,(a5)
getcookie3:
		move.l     d0,d7
		rts

getinteger:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne.s      typemismatch
		jmp        (a0)

getstring: /* unused */
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bge.s      typemismatch
		jmp        (a0)

addrofbank:
		movem.l    a0-a2,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_addrofbank(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a2
		rts

malloc: /* FIXME: unused */
		movea.l    table(pc),a0
		movea.l    sys_demand(a0),a0
		jsr        (a0)
		rts

dummy: /* unused */
		move.l     (a7)+,returnpc
		bra.s      syntax
		clr.l      d0
		bra.s      goerror

syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
illfunc: /* unused */
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror

typemismatch:
		moveq.l    #E_typemismatch,d0
		bra.s      goerror

diskerror: /* FIXME: unused */
		moveq.l    #E_diskerror,d0

goerror:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      mode(pc),a0
		move.w     (a0),d0
		cmpi.w     #2,d0
		beq.s      goerror1
		move.w     d0,-(a7)
		move.l     #-1,-(a7)
		move.l     #-1,-(a7)
		move.w     #5,-(a7)
		trap       #14
		lea.l      12(a7),a7
		moveq.l    #S_initmode,d0
		trap       #5
		moveq.l    #W_initmode,d7
		trap       #3
goerror1:
		movem.l    (a7)+,d0-d7/a0-a6
		movea.l    table(pc),a0
		movea.l    sys_error(a0),a0
		jmp        (a0)

		moveq.l    #0,d0 /* unused */
		bra.s      printerr
illfalconfunc:
		moveq.l    #0,d0
		bra.s      printerr
invalidbank:
		moveq.l    #1,d0
		bra.s      printerr
invaliddata:
		moveq.l    #2,d0
		bra.s      printerr
		nop

printerr:
		movem.l    d0-d7/a0-a6,-(a7)
		tst.w      d0
		beq.s      printerr1
		lea.l      mode(pc),a0
		move.w     (a0),d0
		cmpi.w     #2,d0
		beq.s      printerr1
		move.w     d0,-(a7)
		move.l     #-1,-(a7)
		move.l     #-1,-(a7)
		move.w     #5,-(a7)
		trap       #14
		lea.l      12(a7),a7
		moveq.l    #S_initmode,d0
		trap       #5
		moveq.l    #W_initmode,d7
		trap       #3
printerr1:
		movem.l    (a7)+,d0-d7/a0-a6
		lea.l      errormsgs(pc),a2
		lsl.w      #1,d0
printerr2:
		/* tst.b     (a2)+ */
		dc.w 0x0c1a,0
		bne.s      printerr2
		subq.w     #1,d0
		bpl.s      printerr2
		movea.l    table(pc),a1
		movea.l    sys_err2(a1),a1
		jmp        (a1)

errormsgs:
		dc.b 0
		dc.b "Illegal Command/Function (use only on Falcon 030)",0
		dc.b "Illegal Command/Function (use only on Falcon 030)",0
		dc.b "Bank does not contain FLI/FLC movie data.",0
		dc.b "Bank does not contain FLI/FLC movie data.",0
		dc.b "Invalid FLI/FLC movie data.",0
		dc.b "Invalid FLI/FLC movie data.",0
		.even

/*
 * Syntax:   _fli bank BNK
 */
fli_bank:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #15,d3 /* XXX */
		lea.l      banknum(pc),a0
		move.w     d3,(a0)
		bsr        addrofbank
		movea.l    d3,a0
		cmpi.w     #FLI_MAGIC,fli_type(a0)
		beq.s      fli_bank1
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		bne        invalidbank
fli_bank1:
		clr.w      x10a58
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   FLI_W=_fli framewidth
 */
fli_framewidth:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		moveq.l    #0,d3
		move.w     banknum(pc),d3
		bsr        addrofbank
		movea.l    d3,a0
		cmpi.w     #FLI_MAGIC,fli_type(a0)
		beq.s      fli_framewidth1
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		bne        invalidbank
fli_framewidth1:
		moveq.l    #0,d3
		move.w     fli_width(a0),d3
		rol.w      #8,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _fli screen SCRN[,X_OFFSET,Y_OFFSET]
 */
fli_screen:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		lea.l      screen_offsets(pc),a1
		move.l     #0,(a1) /* XXX */
		cmpi.b     #1,d0
		beq.s      fli_screen1
		cmpi.b     #3,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,2(a1)
		bsr        getinteger
		move.w     d3,ZERO(a1)
fli_screen1:
		bsr        getinteger
		moveq.l    #0,d0
		moveq.l    #0,d1
		movea.l    lineavars(pc),a2
		move.w     V_BYTES_LIN(a2),d0
		mulu.w     2(a1),d0
		move.w     ZERO(a1),d1
		asl.w      #1,d1
		add.l      d1,d0
		add.l      d0,d3
		/* BUG: screen number not converted to address */
		lea.l      screenstart(pc),a0
		move.l     d3,(a0)
		moveq.l    #0,d3
		move.w     banknum(pc),d3
		bsr        addrofbank
		movea.l    d3,a0
		cmpi.w     #FLI_MAGIC,fli_type(a0)
		beq.s      fli_screen2
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		bne        invalidbank
fli_screen2:
		clr.w      x10a58
		move.w     fli_frames(a0),d0
		rol.w      #8,d0
		move.w     d0,num_frames
		move.w     #1,curr_frame
		lea.l      playtimer(pc),a1
		move.w     fli_speed(a0),d0
		rol.w      #8,d0
		move.w     #3,ZERO(a1)
		move.w     #0,2(a1)
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		beq.s      fli_screen3
		tst.w      d0
		beq.s      fli_screen3
		cmpi.w     #3,d0
		ble.s      fli_screen3
		cmpi.w     #5,d0
		bge.s      fli_screen3
		move.w     d0,ZERO(a1)
fli_screen3:
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
		bne.s      fli_screen4
		move.l     #fli_headersize,d0
fli_screen4:
		adda.l     d0,a0
		move.l     a0,framestart
		move.l     a0,firstframe
		movea.l    lineavars(pc),a0
		move.w     V_BYTES_LIN(a0),d0
		move.w     d0,(a1)
		movea.l    returnpc(pc),a0
		jmp        (a0)

screen_offsets: ds.w 2


/*
 * Syntax:   FLI_H=_fli frameheight
 */
fli_frameheight:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		moveq.l    #0,d3
		move.w     banknum(pc),d3
		bsr        addrofbank
		movea.l    d3,a0
		cmpi.w     #FLI_MAGIC,fli_type(a0)
		beq.s      fli_frameheight1
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		bne        invalidbank
fli_frameheight1:
		moveq.l    #0,d3
		move.w     fli_height(a0),d3
		rol.w      #8,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _fli play
 */
fli_play:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		move.w     #-1,playing
		movea.l    returnpc(pc),a0
		jmp        (a0)

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

/*
 * Syntax:   FRAMES=_fli frames
 */
_fli_frames:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		moveq.l    #0,d3
		move.w     banknum(pc),d3
		bsr        addrofbank
		movea.l    d3,a0
		cmpi.w     #FLI_MAGIC,fli_type(a0)
		beq.s      _fli_frames1
		cmpi.w     #FLC_MAGIC,fli_type(a0)
		bne        invalidbank
_fli_frames1:
		moveq.l    #0,d3
		move.w     fli_frames(a0),d3
		rol.w      #8,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _fli stop
 */
fli_stop:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		move.l     #0,playing
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   FRAME=_fli frame
 */
fli_frame:
		move.l     (a7)+,returnpc
		move.w     vdo_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		clr.l      d2
		clr.l      d3
		clr.l      d4
		move.w     curr_frame(pc),d3
		movea.l    returnpc(pc),a0
		jmp        (a0)

	.bss
lineavars: ds.l 1 /* 10a54 */
x10a58: ds.w 1
playing: ds.w 2
playtimer: ds.w 2
banknum: ds.w 1 /* 10a62 */
screenstart: ds.l 1 /* 10a64 */
bytes_lin: ds.w 1 /* 10a68 */
fliwidth: ds.w 1 /* 10a6a */
fliheight: ds.w 1 /* 10a6c */
framestart: ds.l 1 /* 10a6e */
firstframe: ds.l 1 /* 10a72 */
curr_frame: ds.w 1 /* 10a76 */
num_frames: ds.w 1 /* 10a78 */
	ds.b 14
palette: ds.w 256

ZERO equ 0

	ds.w 256
finprg: /* 10e88 */
	ds.l 1
