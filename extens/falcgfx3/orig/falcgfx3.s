		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"

MD_REPLACE = 0

		.text

        bra.w load

        dc.b $80
tokens:
		dc.b "_falc pen",$80
		dc.b "_falc xcurs",$81
		dc.b "_falc paper",$82
		dc.b "_falc ycurs",$83
		dc.b "_falc locate",$84
		dc.b "_stos charwidth",$85
		dc.b "_falc print",$86
		dc.b "_stos charheight",$87
		dc.b "_stosfont",$88
		dc.b "_falc multipen status",$89
		dc.b "_falc multipen off",$8a
		dc.b "_charset addr",$8b
		dc.b "_falc multipen on",$8c
		dc.b "_tc rgb",$8d
		dc.b "_falc ink",$8e
		/* $8f unused */
		dc.b "_falc draw mode",$90
		dc.b "_get pixel",$91
		dc.b "_def linepattern",$92
		/* $93 unused */
		dc.b "_def stipple",$94
		/* $95 unused */
		dc.b "_falc plot",$96
		/* $97 unused */
		dc.b "_falc line",$98
		/* $99 unused */
		dc.b "_falc box",$9a
		/* $9b unused */
		dc.b "_falc bar",$9c
		/* $9d unused */
		dc.b "_falc polyline",$9e
		/* $9f unused */
		dc.b "_falc centre",$a0
		/* $a1 unused */
		dc.b "_falc polyfill",$a2
		/* $a3 unused */
		dc.b "_falc contourfill",$a4
		/* $a5 unused */
		dc.b "_falc circle",$a6
		/* $a7 unused */
		dc.b "_falc ellipse",$a8
		/* $a9 unused */
		dc.b "_falc earc",$aa
		/* $ab unused */
		dc.b "_falc arc",$ac
        dc.b 0
        even


jumps:  dc.w 45
		dc.l falc_pen
		dc.l falc_xcurs
		dc.l falc_paper
		dc.l falc_ycurs
		dc.l falc_locate
		dc.l stos_charwidth
		dc.l falc_print
		dc.l stos_charheight
		dc.l stosfont
		dc.l falc_multipen_status
		dc.l falc_multipen_off
		dc.l charset_addr
		dc.l falc_multipen_on
		dc.l tc_rgb
		dc.l falc_ink
		dc.l dummy
		dc.l falc_draw_mode
		dc.l get_pixel
		dc.l def_linepattern
		dc.l dummy
		dc.l def_stipple
		dc.l dummy
		dc.l falc_plot
		dc.l dummy
		dc.l falc_line
		dc.l dummy
		dc.l falc_box
		dc.l dummy
		dc.l falc_bar
		dc.l dummy
		dc.l falc_polyline
		dc.l dummy
		dc.l falc_centre
		dc.l dummy
		dc.l falc_polyfill
		dc.l dummy
		dc.l falc_contourfill
		dc.l dummy
		dc.l falc_circle
		dc.l dummy
		dc.l falc_ellipse
		dc.l dummy
		dc.l falc_earc
		dc.l dummy
		dc.l falc_arc

welcome:
		dc.b 10
		dc.b "Falcon 030 GRAFIX (III) Extension v0.32",$9e," ",$bd," Anthony Hoskin.",0
		dc.b 10
		dc.b "Falcon 030 Extension de GRAFIX (III) v0.32",$9e," ",$bd," Anthony Hoskin.",0
		.even

table: dc.l 0
returnpc: dc.l 0
	ds.w 1 /* unused */
mch_cookie: dc.l 0
vdo_cookie: dc.l 0 /* FIXME: no longer used */
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0
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
		move.l     d0,(a0)
		lea.l      mch_cookie(pc),a0
		clr.l      (a0)+
		clr.l      (a0)+
		move.l     #1,(a0)+
		lea.l      cookieid(pc),a1
		move.l     #0x5F4D4348,(a1)
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
		move.l     #0x5F56444F,(a1)
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
		lea.l      cookieid(pc),a1
		move.l     #0x5F534E44,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold3
		lea.l      cookievalue(pc),a1
		lea.l      snd_cookie(pc),a0
		move.l     (a1),(a0)
cold3:
		move.l     a1,(a0)
		dc.w       0xa000 /* linea_init */
		lea.l      lineavars(pc),a1
		move.l     a0,(a1)
		lea.l      currcolor(pc),a0
		move.w     #1,(a0)
		lea.l      wrt_mode(pc),a0
		move.w     #MD_REPLACE,(a0)
		lea.l      colormask(pc),a0
		move.w     #-1,(a0)
		lea.l      stipple_ptr(pc),a0
		lea.l      stipple_default(pc),a1
		move.l     #-1,(a1)
		move.l     a1,(a0)
		lea.l      stipple_mask(pc),a0
		move.w     #0,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #S_falc_initfont,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		bsr.s      check_spritelib
		tst.w      d7
		bmi.s      cold4
		beq.s      cold4
		bra        spritelib_err
cold4:
		rts

check_spritelib:
		movem.l    d0-d6/a0-a6,-(a7)
		movea.l    0x00000094,a1 ; vector for trap #5
		suba.w     #(spritelib_id_end-spritelib_id),a1
		lea.l      spritelib_id(pc),a0
		moveq.l    #spritelib_id_end-spritelib_id-1,d7
check_spritelib1:
		cmpm.b     (a0)+,(a1)+
		bne.s      check_spritelib2
		dbf        d7,check_spritelib1
check_spritelib2:
		movem.l    (a7)+,d0-d6/a0-a6
		rts

spritelib_id:
	dc.b "FALCON 030 STOS Sprite 5.8",0,0
spritelib_id_end:

warm:
		movem.l    a0-a6,-(a7)
		lea.l      currcolor(pc),a0
		move.w     #1,(a0)
		lea.l      wrt_mode(pc),a0
		move.w     #MD_REPLACE,(a0)
		lea.l      colormask(pc),a0
		move.w     #-1,(a0)
		lea.l      stipple_ptr(pc),a0
		lea.l      stipple_default(pc),a1
		move.l     #-1,(a1)
		move.l     a1,(a0)
		lea.l      stipple_mask(pc),a0
		move.w     #0,(a0)
		moveq.l    #S_falc_initfont,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		rts

getcookie:
		movea.l    #0x000005A0,a0
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
		cmp.l      #ZERO,d0
		beq.s      getcookie3
		cmp.l      d3,d0
		beq.s      getcookie2
		addq.w     #1,d4
		bra.s      getcookie1
getcookie2:
		cmpa.l     #ZERO,a5
		beq.s      getcookie3
		move.l     d1,(a5)
getcookie3:
		rts

drawline:
		movem.l    d0-d7/a0-a6,-(a7)
		andi.l     #0x0000FFFF,d0
		andi.l     #0x0000FFFF,d1
		andi.l     #0x0000FFFF,d2
		andi.l     #0x0000FFFF,d3
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a6
		cmp.w      d0,d2
		beq.s      drawline1
		cmp.w      d1,d2 /* BUG: should be d3 */
		beq.s      drawline1
		bra        drawline_hi1
drawline1:
		lea.l      line_coords(pc),a0
		movem.w    d0-d3,(a0)
		movea.l    logic(pc),a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.w     line_coords(pc),d4
		move.w     line_coords+2(pc),d5
		move.w     line_coords+4(pc),d6
		move.w     line_coords+6(pc),d7
		cmp.w      d4,d6
		bcc.s      drawline2
		exg        d4,d6
drawline2:
		cmp.w      d5,d7
		bcc.s      drawline3
		exg        d5,d7
drawline3:
		cmp.w      d4,d6
		beq.s      drawline_hi_ver
		cmp.w      d5,d7
		beq.s      drawline_hi_hor
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_hi_ver:
		movea.l    lineavars(pc),a1
		move.w     d5,d0
		sub.w      d5,d7
		move.w     d5,d2
		moveq.l    #0,d1
		move.w     V_BYTES_LIN(a1),d1
		mulu.w     d1,d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
		move.w     colormask(pc),d3
drawline_hi_ver1:
		move.w     currcolor(pc),d2
		cmpi.w     #-1,d3
		beq.s      drawline_hi_ver2
		move.w     d0,d4
		andi.w     #15,d4
		neg.w      d4
		addi.w     #15,d4
		btst       d4,d3
		bne.s      drawline_hi_ver2
		not.w      d2
		move.w     d2,(a0)
		bra.s      drawline_hi_ver3
drawline_hi_ver2:
		move.w     d2,(a0)
drawline_hi_ver3:
		addq.w     #1,d0
		adda.w     d1,a0
		dbf        d7,drawline_hi_ver1
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_hi_hor:
		movea.l    lineavars(pc),a1
		move.w     d4,d0
		sub.w      d4,d6
		move.w     d5,d2
		mulu.w     V_BYTES_LIN(a1),d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
		move.w     colormask(pc),d3
drawline_hi_hor1:
		move.w     currcolor(pc),d1
		cmpi.w     #-1,d3
		beq.s      drawline_hi_hor2
		move.w     d0,d4
		andi.w     #15,d4
		neg.w      d4
		addi.w     #15,d4
		btst       d4,d3
		bne.s      drawline_hi_hor2
		not.w      d1
		move.w     d1,(a0)+
		bra.s      drawline_hi_hor3
drawline_hi_hor2:
		move.w     d1,(a0)+
drawline_hi_hor3:
		addq.w     #1,d0
		dbf        d6,drawline_hi_hor1
		movem.l    (a7)+,d0-d7/a0-a6
		rts

line_coords: ds.w 4

* diagonal draw
drawline_hi1:
		lea.l      drawline_coords(pc),a0
		movem.w    d0-d3,(a0)
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		lea        line_dirs(pc),a3
		move.w     drawline_coords(pc),d0
		move.w     drawline_coords+2(pc),d1
		move.w     drawline_coords+4(pc),d2
		move.w     drawline_coords+6(pc),d3
		sub.w      d0,d2
		sub.w      d1,d3
		move.w     d2,d4
		move.w     d3,d5
		move.w     drawline_coords(pc),d0
		move.w     drawline_coords+2(pc),d1
		tst.w      d4
		bpl.s      drawline7
		neg.w      d4
		move.w     #-1,(a3)
		bra.s      drawline8
drawline7:
		move.w     #1,(a3)
drawline8:
		tst.w      d5
		bpl.s      drawline9
		neg.w      d5
		move.w     #-1,2(a3)
		bra.s      drawline10
drawline9:
		move.w     #1,2(a3)
drawline10:
		tst.w      d5
		bne.s      drawline11
		move.w     #-1,4(a3)
		bra.s      drawline12
drawline11:
		move.w     #0,4(a3)
drawline12:
		cmp.w      drawline_coords+4(pc),d0
		bne.s      drawline13
		cmp.w      drawline_coords+6(pc),d1
		beq.s      drawline16
drawline13:
		move.w     4(a3),d6
		tst.w      d6
		bge.s      drawline14
		add.w      (a3),d0
		add.w      d5,4(a3)
		bra.s      drawline15
drawline14:
		add.w      2(a3),d1
		sub.w      d4,4(a3)
drawline15:
		bsr.s      setpixel
		bra.s      drawline12
drawline16:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_coords: ds.w 4
line_dirs: ds.w 3


setpixel:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a6),d6
		mulu.w     d6,d1
		movea.l    logic(pc),a0
		adda.l     d1,a0
		asl.w      #1,d0
		adda.l     d0,a0
		move.w     currcolor(pc),(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

linea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      linea_setcolor1
		bset       #0,LA_FG_1+1(a0)
linea_setcolor1:
		btst       #1,d0
		beq.s      linea_setcolor2
		bset       #0,LA_FG_2+1(a0)
linea_setcolor2:
		btst       #2,d0
		beq.s      linea_setcolor3
		bset       #0,LA_FG_3+1(a0)
linea_setcolor3:
		btst       #3,d0
		beq.s      linea_setcolor4
		bset       #0,LA_FG_4+1(a0)
linea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      linea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      linea_setcolor5
		bset       #0,LA_FG_5+1(a0)
linea_setcolor5:
		btst       #5,d0
		beq.s      linea_setcolor6
		bset       #0,LA_FG_6+1(a0)
linea_setcolor6:
		btst       #6,d0
		beq.s      linea_setcolor7
		bset       #0,LA_FG_7+1(a0)
linea_setcolor7:
		btst       #7,d0
		beq.s      linea_setcolor8
		bset       #0,LA_FG_8+1(a0)
linea_setcolor8:
		rts

drawbar:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    stipple_ptr(pc),a2
		cmpi.l     #-1,(a2)
		beq.s      drawbar1
		bra.s      drawbar6
drawbar1:
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a1
		cmp.w      d0,d2
		beq.s      drawbar2
		cmp.w      d1,d3
		beq.s      drawbar2
		bra.s      drawbar3
drawbar2:
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar3:
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     currcolor(pc),d6
		sub.w      d1,d3
		subq.w     #1,d3
		move.w     V_BYTES_LIN(a1),d5
		mulu.w     d5,d1
		adda.l     d1,a0
drawbar4:
		move.w     d0,d4
drawbar5:
		move.w     d6,0(a0,d4.l*2) ; 68020+ only
		addq.w     #1,d4
		cmp.w      d4,d2
		bgt.s      drawbar5
		adda.l     d5,a0
		dbf        d3,drawbar4
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar6:
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a6
		lea.l      drawbar_coords(pc),a4
		movem.w    d0-d3,(a4)
		move.w     0(a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr        drawline
drawbar7:
		addq.w     #1,2(a4)
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr        draw_back
		move.w     6(a4),d0
		cmp.w      2(a4),d0
		bne.s      drawbar7
		move.w     (a4),d0
		move.w     6(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_back:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.w     d0,d4
		move.w     d1,d5
		move.w     d2,d6
		move.w     d3,d7
		movea.l    stipple_ptr(pc),a2
		movea.l    lineavars(pc),a1
		move.w     d4,d0
		sub.w      d4,d6
		subq.w     #2,d6
		move.w     d5,d2
		mulu.w     V_BYTES_LIN(a1),d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
		and.w      stipple_mask(pc),d5
		move.w     0(a2,d5.w*2),d3 ; 68020+ only
		move.w     currcolor(pc),(a0)+
drawhi_back5:
		move.w     currcolor(pc),d1
		move.w     d0,d4
		andi.w     #15,d4
		neg.w      d4
		addi.w     #15,d4
		btst       d4,d3
		bne.s      drawhi_back6
		move.w     #0,(a0)+
		bra.s      drawhi_back7
drawhi_back6:
		move.w     d1,(a0)+
drawhi_back7:
		addq.w     #1,d0
		dbf        d6,drawhi_back5
		move.w     currcolor(pc),(a0)+
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawbar_coords: ds.w 4

get_logic:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		lea.l      logic(pc),a0
		move.l     d0,(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

getinteger:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne.s      typemismatch
		jmp        (a0)

getstring:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bge.s      typemismatch
		jmp        (a0)

addrofbank: /* unused */
		movem.l    a0-a2,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_addrofbank(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a2
		rts

malloc:
		movea.l    table(pc),a0
		movea.l    sys_demand(a0),a0
		jsr        (a0)
		rts

dummy:
		move.l     (a7)+,returnpc
		bra.s      syntax

/* unused */
		clr.l      d0
		bra.s      goerror
syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
illfunc:
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0
		bra.s      goerror
stringtoolong: /* unused */
		moveq.l    #E_string_too_long,d0
		bra.s      goerror
diskerror: /* unused */
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

spritelib_err:
		moveq.l    #0,d0
		bra.s      printerr
illfalconfunc:
		moveq.l    #1,d0

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
		dc.b 13,10,C_inverse
		dc.b "Extension ERROR - the 'SPRIT101.BIN' file version in the STOS folder",13,10
		dc.b "is incompatible with the Falcon 030 GRAFIX (III) Extension v0.32",$9e,".           ",13,10
		dc.b "Please re-boot your system with the 'SPRIT101.BIN' version 5.8 file ",13,10
		dc.b "in the STOS folder.",C_normal,13,10,0
		dc.b 13,10,C_inverse
		dc.b "Extension ERROR - the 'SPRIT101.BIN' file version in the STOS folder        ",13,10
		dc.b "is incompatible with the Falcon 030 GRAFIX (III) Extension v0.32",$9e,". ",13,10
		dc.b "Please re-boot your system with the 'SPRIT101.BIN' version 5.8 file ",13,10
		dc.b "in the STOS folder.",C_normal,13,10,0
		dc.b "Command/Function not supported by video hardware",0
		dc.b "Command/Function not supported by video hardware",0
		.even

/*
 * Syntax:   _falc pen COL_REG
 *           _falc pen RED,GREEN,BLUE
 */
falc_pen:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		beq.s      falc_pen2
		cmp.w      #3,d0
		beq.s      falc_pen1
		bra        syntax
falc_pen1:
		bsr        getinteger
		andi.l     #31,d3
		lea.l      falc_pen_rgb(pc),a0
		move.w     d3,4(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		lea.l      falc_pen_rgb(pc),a0
		move.w     d3,2(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		rol.w      #5,d3
		lea.l      falc_pen_rgb(pc),a0
		move.w     d3,(a0)
		movem.w    (a0)+,d1-d3
		or.w       d1,d2
		or.w       d2,d3
		andi.l     #0xFFFF,d3
		bra.s      falc_pen3
falc_pen2:
		bsr        getinteger
		andi.l     #255,d3
falc_pen3:
		move.w     d3,d1
		moveq.l    #S_falc_pen,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_pen_rgb: ds.w 4

/*
 * Syntax:   X=_falc xcurs
 */
falc_xcurs:
		move.l     (a7)+,returnpc
		cmp.w      #ZERO,d0
		bne        syntax
		moveq.l    #S_falc_xcurs,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc paper COL_REG
 *           _falc paper RED,GREEN,BLUE
 *           _falc paper -1
 */
falc_paper:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		beq.s      falc_paper2
		cmp.w      #3,d0
		beq.s      falc_paper1
		bra        syntax
falc_paper1:
		bsr        getinteger
		andi.l     #31,d3
		lea.l      falc_paper_rgb(pc),a0
		move.w     d3,4(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		lea.l      falc_paper_rgb(pc),a0
		move.w     d3,2(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		rol.w      #5,d3
		lea.l      falc_paper_rgb(pc),a0
		move.w     d3,(a0)
		movem.w    (a0)+,d1-d3
		or.w       d1,d2
		or.w       d2,d3
		andi.l     #0xFFFF,d3
		bra.s      falc_paper3
falc_paper2:
		bsr        getinteger
falc_paper3:
		move.l     d3,d1
		moveq.l    #S_falc_paper,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_paper_rgb: ds.w 4

/*
 * Syntax:   Y=_falc ycurs
 */
falc_ycurs:
		move.l     (a7)+,returnpc
		cmp.w      #ZERO,d0
		bne        syntax
		moveq.l    #S_falc_ycurs,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc locate X,Y
 */
falc_locate:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		lea.l      falc_locate_coords+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_locate_coords(pc),a0
		move.w     d3,(a0)
		move.l     (a0),d1
		moveq.l    #S_falc_locate,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_locate_coords: ds.w 2

/*
 * Syntax:   CHAR_WIDTH=_stos charwidth
 */
stos_charwidth:
		move.l     (a7)+,returnpc
		cmp.w      #ZERO,d0
		bne        syntax
		moveq.l    #S_charwidth,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc print A$
 */
falc_print:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a0
		moveq.l    #S_falc_print,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   CHAR_HEIGHT=_stos charheight
 */
stos_charheight:
		move.l     (a7)+,returnpc
		cmp.w      #ZERO,d0
		bne        syntax
		moveq.l    #S_charheight,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _stosfont FNT_NUM
 */
stosfont:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #255,d3
		subq.w     #1,d3
		bmi.s      stosfont1
		cmpi.w     #2,d3
		bgt.s      stosfont1
		move.w     d3,d1
		moveq.l    #S_stosfont,d0
		trap       #5
stosfont1:
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   X=_falc multipen status
 */
falc_multipen_status:
		move.l     (a7)+,returnpc
		cmp.w      #ZERO,d0
		bne        syntax
		moveq.l    #S_multipen_status,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc multipen off
 */
falc_multipen_off:
		move.l     (a7)+,returnpc
		cmp.w      #ZERO,d0
		bne        syntax
		moveq.l    #S_multipen_off,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   ADDR=_charset addr(CHAR_SET)
 */
charset_addr:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #15,d3
		subq.w     #1,d3
		tst.w      d3
		bmi.s      charset_addr1
		cmpi.w     #2,d3
		bgt.s      charset_addr1
		bra.s      charset_addr2
charset_addr1:
		clr.l      d3
charset_addr2:
		movem.l    a0-a6,-(a7)
		move.w     d3,d0
		move.w     #W_getcharset,d7
		trap       #3
		movem.l    (a7)+,a0-a6
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc multipen on STEP
 *           _falc multipen on R_INC,GR_INC,BL_INC
 */
falc_multipen_on:
		move.l     (a7)+,returnpc
		lea.l      multipen_on_params(pc),a1
		move.w     #1,(a1)
		move.w     #1,2(a1)
		move.w     #1,4(a1)
		cmp.w      #1,d0
		beq.s      falc_multipen_on1
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		andi.l     #31,d3
		move.w     d3,4(a1)
		bsr        getinteger
		andi.l     #31,d3
		move.w     d3,2(a1)
		bsr        getinteger
		andi.l     #31,d3
		move.w     d3,(a1)
		bra.s      falc_multipen_on2
falc_multipen_on1:
		bsr        getinteger
		andi.l     #255,d3
		move.w     d3,(a1)
falc_multipen_on2:
		lea.l      multipen_on_params(pc),a1
		move.w     (a1),d2
		move.w     2(a1),d3
		move.w     4(a1),d4
		moveq.l    #S_multipen_on,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

multipen_on_params: ds.w 3

/*
 * Syntax:   RGB=_tc rgb(RED,GREEN,BLUE)
 */
tc_rgb:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		andi.l     #31,d3
		lea.l      tc_rgb_colors(pc),a0
		move.w     d3,4(a0)
		bsr        getinteger
		andi.l     #31,d3
		asl.w      #6,d3
		lea.l      tc_rgb_colors(pc),a0
		move.w     d3,2(a0)
		bsr        getinteger
		andi.l     #31,d3
		asl.w      #6,d3
		asl.w      #5,d3
		lea.l      tc_rgb_colors(pc),a0
		move.w     d3,(a0)
		moveq.l    #0,d3
		lea.l      tc_rgb_colors(pc),a0
		or.w       (a0),d3
		or.w       2(a0),d3
		or.w       4(a0),d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

tc_rgb_colors: ds.w 4

/*
 * Syntax:   _falc ink COL_REG
 *           _falc ink RED,GREEN,BLUE
 */
falc_ink:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		beq.s      falc_ink2
		cmp.w      #3,d0
		beq.s      falc_ink1
		bra        syntax
falc_ink1:
		bsr        getinteger
		andi.l     #31,d3
		lea.l      falc_ink_colors(pc),a0
		move.w     d3,4(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		lea.l      falc_ink_colors(pc),a0
		move.w     d3,2(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		rol.w      #5,d3
		lea.l      falc_ink_colors(pc),a0
		move.w     d3,(a0)
		movem.w    (a0)+,d1-d3
		or.w       d1,d2
		or.w       d2,d3
		andi.l     #0xFFFF,d3
		bra.s      falc_ink3
falc_ink2:
		bsr        getinteger
		andi.l     #255,d3
falc_ink3:
		lea.l      currcolor(pc),a0
		move.w     d3,(a0)
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_ink_colors: ds.w 4

/*
 * Syntax:   _falc draw mode GR_MODE
 */
falc_draw_mode:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		/* subq.l     #1,d3 */
		dc.w 0x0483,0,1 /* XXX */
		bmi.s      falc_draw_mode1
		lea.l      wrt_mode(pc),a0
		andi.l     #3,d3
		move.w     d3,(a0)
falc_draw_mode1:
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   COL_REG=_get pixel(X,Y)
 */
get_pixel:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		lea.l      get_pixel_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      get_pixel_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      get_pixel1
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     get_pixel_x(pc),d4
		asl.w      #1,d4
		move.w     get_pixel_y(pc),d5
		movea.l    lineavars(pc),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		move.w     (a0),d3
		movem.l    (a7)+,a0-a6
		andi.l     #0xFFFF,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
get_pixel1:
		lea.l      get_pixel_x(pc),a1
		move.l     a1,LA_PTSIN(a0)
		dc.w       0xa002 /* get_pixel */
		movem.l    (a7)+,a0-a6
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

get_pixel_x: ds.w 1
get_pixel_y: ds.w 1

/*
 * Syntax:   _def linepattern PATTERN
 */
def_linepattern:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      colormask(pc),a0
		move.w     d3,(a0)
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _def stipple STIPPLE
 */
def_stipple:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		beq.s      def_stipple1
		bmi.s      def_stipple1
		cmpi.l     #24,d3
		bgt.s      def_stipple1
		subq.l     #1,d3
		lea.l      patterns(pc),a1
		asl.l      #5,d3
		adda.l     d3,a1
		lea.l      stipple_ptr(pc),a0
		move.l     a1,(a0)
		lea.l      stipple_mask(pc),a0
		move.w     #15,(a0)
		movea.l    returnpc(pc),a0
		jmp        (a0)
def_stipple1:
		lea.l      stipple_default(pc),a1
		move.l     d3,(a1)
		lea.l      stipple_ptr(pc),a0
		move.l     a1,(a0)
		lea.l      stipple_mask(pc),a0
		move.w     #0,(a0)
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc plot X,Y
 */
falc_plot:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		lea.l      falc_plot_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_plot_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      falc_plot1
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     falc_plot_x(pc),d4
		asl.w      #1,d4
		move.w     falc_plot_y(pc),d5
		movea.l    lineavars(pc),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		move.w     currcolor(pc),(a0)
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)
falc_plot1:
		lea.l      currcolor(pc),a1
		move.l     a1,LA_INTIN(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		lea.l      falc_plot_x(pc),a1
		move.l     a1,LA_PTSIN(a0)
		dc.w       0xa001 /* put_pixel */
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_plot_x: ds.w 1
falc_plot_y: ds.w 1

/*
 * Syntax:   _falc line X1,Y1,X2,Y2
 */
falc_line:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		lea.l      falc_line_coords+6(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_line_coords+4(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_line_coords+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_line_coords+0(pc),a0
		move.w     d3,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_line1
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		lea.l      falc_line_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0) /* BUG: clip coords not set */
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)
falc_line1:
		bsr        get_logic
		lea.l      falc_line_coords(pc),a4
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_line_coords: ds.w 4

/*
 * Syntax:   _falc box X1,Y1,X2,Y2
 */
falc_box:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		lea.l      drawbox_coords+6(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      drawbox_coords+4(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      drawbox_coords+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      drawbox_coords+0(pc),a0
		move.w     d3,(a0)
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      cliprect(pc),a1
		move.w     #0,(a1)+
		move.w     #0,(a1)+
		move.w     DEV_TAB(a0),(a1)+
		move.w     DEV_TAB+2(a0),(a1)+
		cmpi.w     #16,LA_PLANES(a0)
		beq        falc_box_hi
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		lea.l      drawbox_coords(pc),a1
* left line
		move.w     (a1),d1
		move.w     2(a1),d2
		move.w     (a1),d3
		move.w     6(a1),d4
		bsr.s      linea_drawline
* top line
		move.w     (a1),d1
		move.w     2(a1),d2
		move.w     4(a1),d3
		move.w     2(a1),d4
		bsr.s      linea_drawline
* right line
		move.w     4(a1),d1
		move.w     2(a1),d2
		move.w     4(a1),d3
		move.w     6(a1),d4
		bsr.s      linea_drawline
* bottom line
		move.w     (a1),d1
		move.w     6(a1),d2
		move.w     4(a1),d3
		move.w     6(a1),d4
		bsr.s      linea_drawline
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

linea_drawline:
		movem.l    a0-a1,-(a7)
		move.w     d1,LA_X1(a0)
		move.w     d2,LA_Y1(a0)
		move.w     d3,LA_X2(a0)
		move.w     d4,LA_Y2(a0)
		move.w     d1,LA_XMN_CLIP(a0)
		move.w     d2,LA_YMN_CLIP(a0)
		move.w     d3,LA_XMX_CLIP(a0)
		move.w     d4,LA_YMX_CLIP(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,a0-a1
		rts

falc_box_hi:
		bsr        get_logic
		lea.l      drawbox_coords(pc),a4
		movem.w    (a4)+,d0-d3
		andi.l     #0x000003FF,d0 /* WTF; why clamp coordinates? */
		andi.l     #0x000001FF,d1
		andi.l     #0x000003FF,d2
		andi.l     #0x000001FF,d3
		cmp.w      d0,d2
		bcc.s      drawbox1
		exg        d0,d2
drawbox1:
		cmp.w      d1,d3
		bcc.s      drawbox2
		exg        d1,d3
drawbox2:
		lea.l      cliprect(pc),a1
		cmp.w      (a1),d0
		bcc.s      drawbox3
		move.w     (a1),d0
drawbox3:
		cmp.w      4(a1),d2
		bcs.s      drawbox4
		move.w     4(a1),d2
drawbox4:
		cmp.w      2(a1),d1
		bcc.s      drawbox5
		move.w     2(a1),d1
drawbox5:
		cmp.w      6(a1),d3
		bcs.s      drawbox6
		move.w     6(a1),d3
drawbox6:
		lea.l      falc_box_coords(pc),a4
* left line
		movem.w    d0-d3,(a4)
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     (a4),d2
		move.w     6(a4),d3
		bsr        drawline
* top line
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr        drawline
* right line
		move.w     4(a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawline
* bottom line
		move.w     (a4),d0
		move.w     6(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawline
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)


drawbox_coords: ds.w 4
falc_box_coords: ds.w 4

/*
 * Syntax:   _falc bar X1,Y1,X2,Y2
 */
falc_bar:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		lea.l      falc_bar_coords+6(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_bar_coords+4(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_bar_coords+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_bar_coords+0(pc),a0
		move.w     d3,(a0)
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      cliprect(pc),a1
		move.w     #0,(a1)+
		move.w     #0,(a1)+
		move.w     DEV_TAB(a0),(a1)+
		move.w     DEV_TAB+2(a0),(a1)+
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_bar_hi
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		lea.l      falc_bar_coords+0(pc),a4
		move.w     (a4),LA_X1(a0)
		move.w     2(a4),LA_Y1(a0)
		move.w     4(a4),LA_X2(a0)
		move.w     6(a4),LA_Y2(a0)
		move.w     (a4),LA_XMN_CLIP(a0)
		move.w     2(a4),LA_YMN_CLIP(a0)
		move.w     4(a4),LA_XMX_CLIP(a0)
		move.w     6(a4),LA_YMX_CLIP(a0)

		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		dc.w       0xa005 /* filled_rect */
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_bar_hi:
		bsr        get_logic
		lea.l      falc_bar_coords(pc),a4
		movem.w    (a4)+,d0-d3
		andi.l     #0x000003FF,d0 /* WTF; why clamp coordinates? */
		andi.l     #0x000001FF,d1
		andi.l     #0x000003FF,d2
		andi.l     #0x000001FF,d3
		cmp.w      d0,d2
		bcc.s      drawbarhi1
		exg        d0,d2
drawbarhi1:
		cmp.w      d1,d3
		bcc.s      drawbarhi2
		exg        d1,d3
drawbarhi2:
		lea.l      cliprect(pc),a1
		cmp.w      (a1),d0
		bcc.s      drawbarhi3
		move.w     (a1),d0
drawbarhi3:
		cmp.w      4(a1),d2
		bcs.s      drawbarhi4
		move.w     4(a1),d2
drawbarhi4:
		cmp.w      2(a1),d1
		bcc.s      drawbarhi5
		move.w     2(a1),d1
drawbarhi5:
		cmp.w      6(a1),d3
		bcs.s      drawbarhi6
		move.w     6(a1),d3
drawbarhi6:
		lea.l      drawbarhi_coords(pc),a4
		movem.w    d0-d3,(a4)
		move.w     0(a4),d0 /* FIXME: useless */
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawbar
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

falc_bar_coords: ds.w 4
drawbarhi_coords: ds.w 4

/*
 * Syntax:   _falc polyline varptr(XY_ARRAY(0)),PTS
 */
falc_polyline:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		subq.l     #1,d3
		bmi        illfunc
		cmpi.l     #63,d3
		bgt        illfunc
		lea.l      polyline_pts(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      polyline_array(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movea.l    polyline_array(pc),a1
		move.l     polyline_pts(pc),d7
		subq.l     #1,d7
falc_polyline1:
		move.l     (a1),d0
		move.w     d0,LA_X1(a0)
		move.l     4(a1),d0
		move.w     d0,LA_Y1(a0)
		move.l     8(a1),d0
		move.w     d0,LA_X2(a0)
		move.l     12(a1),d0
		move.w     d0,LA_Y2(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyline1
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

polyline_pts: ds.l 1
polyline_array: ds.l 1

/*
 * Syntax:   _falc centre A$
 */
falc_centre:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a0
		moveq.l    #S_falc_centre,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax:   _falc polyfill varptr(XY_ARRAY(0)),PTS
 */
falc_polyfill:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #64,d3
		bgt        illfunc
		lea.l      polyfill_pts(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      polyfill_array(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movem.l    a0-a6,-(a7)
		lea.l      ptsin(pc),a4
		movea.l    polyfill_array(pc),a2
		move.l     polyfill_pts(pc),d7
		asl.w      #1,d7
		subq.w     #1,d7
falc_polyfill1:
		move.l     (a2)+,d0
		move.w     d0,(a4)+
		dbf        d7,falc_polyfill1
		bsr        find_miny
		bsr        find_maxy
		lea.l      control(pc),a3
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		move.l     d7,(a3)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		lea.l      control(pc),a4
		move.l     a4,LA_CONTROL(a0)
		lea.l      ptsin(pc),a4
		move.l     a4,LA_PTSIN(a0)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		move.w     #0,LA_CLIP(a0)
		move.w     polyfill_y1(pc),d3
		move.w     polyfill_maxy(pc),d4
falc_polyfill2:
		movem.l    d3-d4/a0,-(a7)
		move.w     d3,LA_Y1(a0)
		dc.w       0xa006 /* filled_polygon */
		movem.l    (a7)+,d3-d4/a0
		addq.w     #1,d3
		cmp.w      d3,d4
		bne.s      falc_polyfill2
		movem.l    (a7)+,a0-a6
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movea.l    polyfill_array(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.l     #2,d7
falc_polyfill3:
		move.l     (a1),d0
		move.w     d0,LA_X1(a0)
		move.l     4(a1),d0
		move.w     d0,LA_Y1(a0)
		move.l     8(a1),d0
		move.w     d0,LA_X2(a0)
		move.l     12(a1),d0
		move.w     d0,LA_Y2(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyfill3
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

find_miny:
		movem.l    a0-a6,-(a7)
		lea.l      ptsin+2(pc),a0
		lea.l      polyfill_y1(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		move.l     #640,d0 /* BUG: should be much higher */
		move.w     d0,(a1)
find_miny1:
		move.w     (a0),d1
		cmp.w      d1,d0
		blt.s      find_miny2
		exg        d1,d0
find_miny2:
		addq.l     #4,a0
		dbf        d7,find_miny1
		move.w     d0,(a1)
		movem.l    (a7)+,a0-a6
		rts

find_maxy:
		movem.l    a0-a6,-(a7)
		lea.l      ptsin+2(pc),a0
		lea.l      polyfill_maxy(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		clr.l      d0
		move.w     d0,(a1)
find_maxy1:
		move.w     (a0),d1
		cmp.w      d1,d0
		bgt.s      find_maxy2
		exg        d1,d0
find_maxy2:
		addq.l     #4,a0
		dbf        d7,find_maxy1
		move.w     d0,(a1)
		movem.l    (a7)+,a0-a6
		rts

polyfill_pts: ds.l 1
polyfill_array: ds.l 1
polyfill_y1: ds.w 1
polyfill_maxy: ds.w 1

/*
 * Syntax:   _falc contourfill X,Y,COLOR
 */
falc_contourfill:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		andi.l     #15,d3
		lea.l      contourfill_work(pc),a0
		move.w     d3,30(a0) /* BUG: relies on layout of internal VDI structure */
		bsr        getinteger
		lea.l      contourfill_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      contourfill_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      contourfill_intin(pc),a5
		move.l     a5,LA_INTIN(a0)
		lea.l      contourfill_x(pc),a5
		move.l     a5,LA_PTSIN(a0)
		lea.l      contourfill_work(pc),a5
		move.l     a5,CUR_WORK(a0) /* BUG: relies on layout of internal VDI structure */
		lea.l      fill_abort(pc),a5
		move.l     a5,LA_FILL_ABORT(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     DEV_TAB(a0),d0
		move.w     DEV_TAB+2(a0),d1
		move.w     #1,LA_CLIP(a0) /* BUG: clip coords not set */
		move.w     #0,LA_XMN_CLIP(a0)
		move.w     #0,LA_YMN_CLIP(a0)
		move.w     d0,LA_XMX_CLIP(a0)
		move.w     d1,LA_YMX_CLIP(a0)
		dc.w       0xa00f /* seed_fill */
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

fill_abort:
		clr.l      d0
		rts

contourfill_x: ds.w 1
contourfill_y: ds.w 1
contourfill_intin: dc.w -1
contourfill_work: ds.w 16


/*
 * Syntax:   _falc circle X,Y,R
 */
falc_circle:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      circle_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		bsr        getinteger
		lea.l      circle_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      circle_x(pc),a0
		move.w     d3,(a0)
		movea.l    lineavars(pc),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_circle1
		lea.l      circle_rad+2(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_circle1:
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movem.l    a0-a6,-(a7)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		move.w     #0,LA_CLIP(a0)
		lea.l      circle_coords(pc),a3
		lea.l      sintab(pc),a4
		clr.l      d7
falc_circle2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d0
		move.w     2(a4,d6.w),d1
		neg.w      d1
		move.w     circle_rad(pc),d4
		move.w     circle_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d0
		muls.w     d5,d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      circle_x(pc),d0
		add.w      circle_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     0(a4,d6.w),d2
		neg.w      d2
		move.w     2(a4,d6.w),d3
		neg.w      d3
		move.w     circle_rad(pc),d4
		move.w     circle_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d2
		muls.w     d5,d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      circle_x(pc),d2
		add.w      circle_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      circle_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		dc.w       0xa004 /* horizontal_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #360,d7
		blt        falc_circle2
		movem.l    (a7)+,a0-a6
		lea.l      circle_coords(pc),a3
		lea.l      sintab(pc),a4
		clr.l      d7
falc_circle3:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     circle_rad(pc),d0
		muls.w     circle_rad+2(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      circle_x(pc),d0
		add.w      circle_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     circle_rad(pc),d2
		muls.w     circle_rad+2(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      circle_x(pc),d2
		add.w      circle_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      circle_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #720,d7
		blt        falc_circle3
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

circle_rad: ds.w 2
circle_x: ds.w 1
circle_y: ds.w 1
circle_coords: ds.w 4

/*
 * Syntax:   _falc ellipse X,Y,X_RAD,Y_RAD
 */
falc_ellipse:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      ellipse_rad+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      ellipse_rad(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      ellipse_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      ellipse_x(pc),a0
		move.w     d3,(a0)
		movea.l    lineavars(pc),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_ellipse1
		lea.l      ellipse_rad+2(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_ellipse1:
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movem.l    a0-a6,-(a7)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		move.w     #0,LA_CLIP(a0)
		lea.l      ellipse_coords(pc),a3
		lea.l      sintab(pc),a4
		clr.l      d7
falc_ellipse2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d0
		move.w     2(a4,d6.w),d1
		neg.w      d1
		move.w     ellipse_rad(pc),d4
		move.w     ellipse_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d0
		muls.w     d5,d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      ellipse_x(pc),d0
		add.w      ellipse_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     0(a4,d6.w),d2
		neg.w      d2
		move.w     2(a4,d6.w),d3
		neg.w      d3
		move.w     ellipse_rad(pc),d4
		move.w     ellipse_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d2
		muls.w     d5,d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      ellipse_x(pc),d2
		add.w      ellipse_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      ellipse_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		dc.w       0xa004 /* horizontal_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #360,d7
		blt        falc_ellipse2
		movem.l    (a7)+,a0-a6
		lea.l      ellipse_coords(pc),a3
		lea.l      sintab(pc),a4
		clr.l      d7
falc_ellipse3:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     ellipse_rad(pc),d0
		muls.w     ellipse_rad+2(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      ellipse_x(pc),d0
		add.w      ellipse_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     ellipse_rad(pc),d2
		muls.w     ellipse_rad+2(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      ellipse_x(pc),d2
		add.w      ellipse_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      ellipse_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #720,d7
		blt        falc_ellipse3
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

ellipse_rad: ds.w 2
ellipse_x: ds.w 1
ellipse_y: ds.w 1
ellipse_coords: ds.w 4

/*
 * Syntax:   _falc earc X,Y,X_RAD,Y_RAD,BEG_ANGLE,END_ANGLE
 */
falc_earc:
		move.l     (a7)+,returnpc
		cmp.w      #6,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #3600,d3
		bgt        illfunc
		lea.l      earc_end_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #3600,d3
		bgt        illfunc
		lea.l      earc_beg_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      earc_yrad(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #511,d3 /* BUG: why clamp? */
		lea.l      earc_xrad(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      earc_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      earc_x(pc),a0
		move.w     d3,(a0)
		movea.l    lineavars(pc),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_earc1
		lea.l      earc_yrad(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_earc1:
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		lea.l      earc_coords(pc),a3
		lea.l      sintab(pc),a4
		move.w     earc_beg_angle(pc),d7
falc_earc2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     earc_xrad(pc),d0
		muls.w     earc_yrad(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      earc_x(pc),d0
		add.w      earc_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     earc_xrad(pc),d2
		muls.w     earc_yrad(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      earc_x(pc),d2
		add.w      earc_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      earc_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      earc_end_angle(pc),d7
		blt        falc_earc2
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

earc_beg_angle: ds.w 1
earc_end_angle: ds.w 1
earc_xrad: ds.w 1
earc_yrad: ds.w 1
earc_x: ds.w 1
earc_y: ds.w 1
earc_coords: ds.w 4

/*
 * Syntax:   _falc arc X,Y,R,BEG_ANGLE,END_ANGLE
 */
falc_arc:
		move.l     (a7)+,returnpc
		cmp.w      #5,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #3600,d3
		bgt        illfunc
		lea.l      arc_end_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #3600,d3
		bgt        illfunc
		lea.l      arc_beg_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #511,d3 /* BUG: why clamp? */
		lea.l      arc_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      arc_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      arc_x(pc),a0
		move.w     d3,(a0)
		movea.l    lineavars(pc),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_arc1
		lea.l      arc_rad+2(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_arc1:
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		lea.l      arc_coords(pc),a3
		lea.l      sintab(pc),a4
		move.w     arc_beg_angle(pc),d7
falc_arc2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     arc_rad(pc),d0
		muls.w     arc_rad+2(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      arc_x(pc),d0
		add.w      arc_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     arc_rad(pc),d2
		muls.w     arc_rad+2(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      arc_x(pc),d2
		add.w      arc_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      arc_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      arc_end_angle(pc),d7
		blt        falc_arc2
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

arc_beg_angle: ds.w 1
arc_end_angle: ds.w 1
arc_rad: ds.w 2
arc_x: ds.w 1
arc_y: ds.w 1
arc_coords: ds.w 4

	.data
patterns:
	dc.w 0x4444,0x0000,0x1111,0x0000,0x4444,0x0000,0x1111,0x0000,0x4444,0x0000,0x1111,0x0000,0x4444,0x0000,0x1111,0x0000
	dc.w 0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000
	dc.w 0x5555,0x2222,0x5555,0x8888,0x5555,0x2222,0x5555,0x8888,0x5555,0x2222,0x5555,0x8888,0x5555,0x2222,0x5555,0x8888
	dc.w 0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa
	dc.w 0xdddd,0xaaaa,0x7777,0xaaaa,0xdddd,0xaaaa,0x7777,0xaaaa,0xdddd,0xaaaa,0x7777,0xaaaa,0xdddd,0xaaaa,0x7777,0xaaaa
	dc.w 0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa
	dc.w 0xffff,0xbbbb,0xffff,0xeeee,0xffff,0xbbbb,0xffff,0xeeee,0xffff,0xbbbb,0xffff,0xeeee,0xffff,0xbbbb,0xffff,0xeeee
	dc.w 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
	dc.w 0x8080,0x8080,0x8080,0xffff,0x0808,0x0808,0x0808,0xffff,0x8080,0x8080,0x8080,0xffff,0x0808,0x0808,0x0808,0xffff
	dc.w 0x4040,0x8080,0x4141,0x2222,0x1414,0x0808,0x1010,0x2020,0x4040,0x8080,0x4141,0x2222,0x1414,0x0808,0x1010,0x2020
	dc.w 0x0000,0x1010,0x2828,0x0000,0x0000,0x0101,0x8282,0x0000,0x0000,0x1010,0x2828,0x0000,0x0000,0x0101,0x8282,0x0000
	dc.w 0x0202,0xaaaa,0x5050,0x2020,0x2020,0xaaaa,0x0505,0x0202,0x0202,0xaaaa,0x5050,0x2020,0x2020,0xaaaa,0x0505,0x0202
	dc.w 0x8080,0x0000,0x0808,0x0404,0x0202,0x0000,0x2020,0x4040,0x8080,0x0000,0x0808,0x0404,0x0202,0x0000,0x2020,0x4040
	dc.w 0xc6c6,0xd8d8,0x1818,0x8181,0x8db1,0x0c33,0x6000,0x6606,0xc6c6,0xd8d8,0x1818,0x8181,0x8db1,0x0c33,0x6000,0x6606
	dc.w 0x0000,0x0400,0x0000,0x0010,0x0000,0x8000,0x0000,0x0000,0x0000,0x0400,0x0000,0x0010,0x0000,0x8000,0x0000,0x0000
	dc.w 0x6c6c,0xc6c6,0x8f8f,0x1f1f,0x3636,0x6363,0xf1f1,0xf8f8,0x6c6c,0xc6c6,0x8f8f,0x1f1f,0x3636,0x6363,0xf1f1,0xf8f8
	dc.w 0x0000,0x8888,0x1414,0x2222,0x4141,0x8888,0x0000,0xaaaa,0x0000,0x8888,0x1414,0x2222,0x4141,0x8888,0x0000,0xaaaa
	dc.w 0x0000,0xaaaa,0x0000,0x0808,0x0000,0x8888,0x0000,0x0808,0x0000,0xaaaa,0x0000,0x0808,0x0000,0x8888,0x0000,0x0808
	dc.w 0x9898,0xf8f8,0xf8f8,0x7777,0x8989,0x8f8f,0x8f8f,0x7777,0x9898,0xf8f8,0xf8f8,0x7777,0x8989,0x8f8f,0x8f8f,0x7777
	dc.w 0x8080,0x4141,0x3e3e,0x0808,0x0808,0x1414,0xe3e3,0x8080,0x8080,0x4141,0x3e3e,0x0808,0x0808,0x1414,0xe3e3,0x8080
	dc.w 0x4242,0x2424,0x1818,0x0606,0x0101,0x8080,0x8080,0x8181,0x4242,0x2424,0x1818,0x0606,0x0101,0x8080,0x8080,0x8181
	dc.w 0xf0f0,0xf0f0,0xf0f0,0x0f0f,0x0f0f,0x0f0f,0x0f0f,0xf0f0,0xf0f0,0xf0f0,0xf0f0,0x0f0f,0x0f0f,0x0f0f,0x0f0f,0xf0f0
	dc.w 0x1c1c,0x3e3e,0x7f7f,0xffff,0x7f7f,0x3e3e,0x1c1c,0x0808,0x1c1c,0x3e3e,0x7f7f,0xffff,0x7f7f,0x3e3e,0x1c1c,0x0808
	dc.w 0x2222,0x4444,0xffff,0x8888,0x4444,0x2222,0xffff,0x1111,0x2222,0x4444,0xffff,0x8888,0x4444,0x2222,0xffff,0x1111

sintab:
	dc.w -1,1000
	dc.w -9,999
	dc.w -18,999
	dc.w -27,999
	dc.w -35,999
	dc.w -44,999
	dc.w -53,998
	dc.w -62,998
	dc.w -70,997
	dc.w -79,996
	dc.w -88,996
	dc.w -96,995
	dc.w -105,994
	dc.w -114,993
	dc.w -122,992
	dc.w -131,991
	dc.w -140,990
	dc.w -148,989
	dc.w -157,987
	dc.w -166,986
	dc.w -174,984
	dc.w -183,983
	dc.w -191,981
	dc.w -200,979
	dc.w -208,978
	dc.w -217,976
	dc.w -225,974
	dc.w -234,972
	dc.w -242,970
	dc.w -251,968
	dc.w -259,965
	dc.w -268,963
	dc.w -276,961
	dc.w -285,958
	dc.w -293,956
	dc.w -301,953
	dc.w -310,951
	dc.w -318,948
	dc.w -326,945
	dc.w -334,942
	dc.w -343,939
	dc.w -351,936
	dc.w -359,933
	dc.w -367,930
	dc.w -375,927
	dc.w -383,923
	dc.w -391,920
	dc.w -399,917
	dc.w -407,913
	dc.w -415,909
	dc.w -423,906
	dc.w -431,902
	dc.w -439,898
	dc.w -447,894
	dc.w -454,891
	dc.w -462,887
	dc.w -470,882
	dc.w -478,878
	dc.w -485,874
	dc.w -493,870
	dc.w -501,866
	dc.w -508,861
	dc.w -516,857
	dc.w -523,852
	dc.w -530,848
	dc.w -538,843
	dc.w -545,838
	dc.w -552,833
	dc.w -560,829
	dc.w -567,824
	dc.w -574,819
	dc.w -581,814
	dc.w -588,809
	dc.w -595,803
	dc.w -602,798
	dc.w -609,793
	dc.w -616,788
	dc.w -623,782
	dc.w -630,777
	dc.w -637,771
	dc.w -643,766
	dc.w -650,760
	dc.w -657,754
	dc.w -663,748
	dc.w -670,743
	dc.w -676,737
	dc.w -683,731
	dc.w -689,725
	dc.w -695,719
	dc.w -701,713
	dc.w -708,707
	dc.w -714,700
	dc.w -720,694
	dc.w -726,688
	dc.w -732,681
	dc.w -738,675
	dc.w -744,669
	dc.w -749,662
	dc.w -755,656
	dc.w -761,649
	dc.w -767,642
	dc.w -772,636
	dc.w -778,629
	dc.w -783,622
	dc.w -789,615
	dc.w -794,608
	dc.w -799,601
	dc.w -804,594
	dc.w -810,587
	dc.w -815,580
	dc.w -820,573
	dc.w -825,566
	dc.w -830,559
	dc.w -834,551
	dc.w -839,544
	dc.w -844,537
	dc.w -849,529
	dc.w -853,522
	dc.w -858,515
	dc.w -862,507
	dc.w -867,499
	dc.w -871,492
	dc.w -875,484
	dc.w -879,477
	dc.w -883,469
	dc.w -888,461
	dc.w -892,453
	dc.w -895,446
	dc.w -899,438
	dc.w -903,430
	dc.w -907,422
	dc.w -910,414
	dc.w -914,406
	dc.w -918,398
	dc.w -921,390
	dc.w -924,382
	dc.w -928,374
	dc.w -931,366
	dc.w -934,358
	dc.w -937,350
	dc.w -940,342
	dc.w -943,333
	dc.w -946,325
	dc.w -949,317
	dc.w -952,309
	dc.w -954,300
	dc.w -957,292
	dc.w -959,284
	dc.w -962,275
	dc.w -964,267
	dc.w -966,258
	dc.w -969,250
	dc.w -971,241
	dc.w -973,233
	dc.w -975,224
	dc.w -977,216
	dc.w -979,207
	dc.w -980,199
	dc.w -982,190
	dc.w -984,182
	dc.w -985,173
	dc.w -987,165
	dc.w -988,156
	dc.w -990,147
	dc.w -991,139
	dc.w -992,130
	dc.w -993,121
	dc.w -994,113
	dc.w -995,104
	dc.w -996,95
	dc.w -997,87
	dc.w -997,78
	dc.w -998,69
	dc.w -999,61
	dc.w -999,52
	dc.w -1000,43
	dc.w -1000,34
	dc.w -1000,26
	dc.w -1000,17
	dc.w -1000,8
	dc.w -1001,-1
	dc.w -1000,-9
	dc.w -1000,-18
	dc.w -1000,-27
	dc.w -1000,-35
	dc.w -1000,-44
	dc.w -999,-53
	dc.w -999,-62
	dc.w -998,-70
	dc.w -997,-79
	dc.w -997,-88
	dc.w -996,-96
	dc.w -995,-105
	dc.w -994,-114
	dc.w -993,-122
	dc.w -992,-131
	dc.w -991,-140
	dc.w -990,-148
	dc.w -988,-157
	dc.w -987,-166
	dc.w -985,-174
	dc.w -984,-183
	dc.w -982,-191
	dc.w -980,-200
	dc.w -979,-208
	dc.w -977,-217
	dc.w -975,-225
	dc.w -973,-234
	dc.w -971,-242
	dc.w -969,-251
	dc.w -966,-259
	dc.w -964,-268
	dc.w -962,-276
	dc.w -959,-285
	dc.w -957,-293
	dc.w -954,-301
	dc.w -952,-310
	dc.w -949,-318
	dc.w -946,-326
	dc.w -943,-334
	dc.w -940,-343
	dc.w -937,-351
	dc.w -934,-359
	dc.w -931,-367
	dc.w -928,-375
	dc.w -924,-383
	dc.w -921,-391
	dc.w -918,-399
	dc.w -914,-407
	dc.w -910,-415
	dc.w -907,-423
	dc.w -903,-431
	dc.w -899,-439
	dc.w -895,-447
	dc.w -892,-454
	dc.w -888,-462
	dc.w -883,-470
	dc.w -879,-478
	dc.w -875,-485
	dc.w -871,-493
	dc.w -867,-501
	dc.w -862,-508
	dc.w -858,-516
	dc.w -853,-523
	dc.w -849,-530
	dc.w -844,-538
	dc.w -839,-545
	dc.w -834,-552
	dc.w -830,-560
	dc.w -825,-567
	dc.w -820,-574
	dc.w -815,-581
	dc.w -810,-588
	dc.w -804,-595
	dc.w -799,-602
	dc.w -794,-609
	dc.w -789,-616
	dc.w -783,-623
	dc.w -778,-630
	dc.w -772,-637
	dc.w -767,-643
	dc.w -761,-650
	dc.w -755,-657
	dc.w -749,-663
	dc.w -744,-670
	dc.w -738,-676
	dc.w -732,-683
	dc.w -726,-689
	dc.w -720,-695
	dc.w -714,-701
	dc.w -708,-708
	dc.w -701,-714
	dc.w -695,-720
	dc.w -689,-726
	dc.w -682,-732
	dc.w -676,-738
	dc.w -670,-744
	dc.w -663,-749
	dc.w -657,-755
	dc.w -650,-761
	dc.w -643,-767
	dc.w -637,-772
	dc.w -630,-778
	dc.w -623,-783
	dc.w -616,-789
	dc.w -609,-794
	dc.w -602,-799
	dc.w -595,-804
	dc.w -588,-810
	dc.w -581,-815
	dc.w -574,-820
	dc.w -567,-825
	dc.w -560,-830
	dc.w -552,-834
	dc.w -545,-839
	dc.w -538,-844
	dc.w -530,-849
	dc.w -523,-853
	dc.w -516,-858
	dc.w -508,-862
	dc.w -500,-867
	dc.w -493,-871
	dc.w -485,-875
	dc.w -478,-879
	dc.w -470,-883
	dc.w -462,-888
	dc.w -454,-892
	dc.w -447,-895
	dc.w -439,-899
	dc.w -431,-903
	dc.w -423,-907
	dc.w -415,-910
	dc.w -407,-914
	dc.w -399,-918
	dc.w -391,-921
	dc.w -383,-924
	dc.w -375,-928
	dc.w -367,-931
	dc.w -359,-934
	dc.w -351,-937
	dc.w -343,-940
	dc.w -334,-943
	dc.w -326,-946
	dc.w -318,-949
	dc.w -310,-952
	dc.w -301,-954
	dc.w -293,-957
	dc.w -285,-959
	dc.w -276,-962
	dc.w -268,-964
	dc.w -259,-966
	dc.w -251,-969
	dc.w -242,-971
	dc.w -234,-973
	dc.w -225,-975
	dc.w -217,-977
	dc.w -208,-979
	dc.w -200,-980
	dc.w -191,-982
	dc.w -183,-984
	dc.w -174,-985
	dc.w -166,-987
	dc.w -157,-988
	dc.w -148,-990
	dc.w -140,-991
	dc.w -131,-992
	dc.w -122,-993
	dc.w -114,-994
	dc.w -105,-995
	dc.w -96,-996
	dc.w -88,-997
	dc.w -79,-997
	dc.w -70,-998
	dc.w -62,-999
	dc.w -53,-999
	dc.w -44,-1000
	dc.w -35,-1000
	dc.w -27,-1000
	dc.w -18,-1000
	dc.w -9,-1000
	dc.w 0,-1001
	dc.w 8,-1000
	dc.w 17,-1000
	dc.w 26,-1000
	dc.w 34,-1000
	dc.w 43,-1000
	dc.w 52,-999
	dc.w 61,-999
	dc.w 69,-998
	dc.w 78,-997
	dc.w 87,-997
	dc.w 95,-996
	dc.w 104,-995
	dc.w 113,-994
	dc.w 121,-993
	dc.w 130,-992
	dc.w 139,-991
	dc.w 147,-990
	dc.w 156,-988
	dc.w 165,-987
	dc.w 173,-985
	dc.w 182,-984
	dc.w 190,-982
	dc.w 199,-980
	dc.w 207,-979
	dc.w 216,-977
	dc.w 224,-975
	dc.w 233,-973
	dc.w 241,-971
	dc.w 250,-969
	dc.w 258,-966
	dc.w 267,-964
	dc.w 275,-962
	dc.w 284,-959
	dc.w 292,-957
	dc.w 300,-954
	dc.w 309,-952
	dc.w 317,-949
	dc.w 325,-946
	dc.w 333,-943
	dc.w 342,-940
	dc.w 350,-937
	dc.w 358,-934
	dc.w 366,-931
	dc.w 374,-928
	dc.w 382,-924
	dc.w 390,-921
	dc.w 398,-918
	dc.w 406,-914
	dc.w 414,-910
	dc.w 422,-907
	dc.w 430,-903
	dc.w 438,-899
	dc.w 446,-895
	dc.w 453,-892
	dc.w 461,-888
	dc.w 469,-883
	dc.w 477,-879
	dc.w 484,-875
	dc.w 492,-871
	dc.w 500,-867
	dc.w 507,-862
	dc.w 515,-858
	dc.w 522,-853
	dc.w 529,-849
	dc.w 537,-844
	dc.w 544,-839
	dc.w 551,-834
	dc.w 559,-830
	dc.w 566,-825
	dc.w 573,-820
	dc.w 580,-815
	dc.w 587,-810
	dc.w 594,-804
	dc.w 601,-799
	dc.w 608,-794
	dc.w 615,-789
	dc.w 622,-783
	dc.w 629,-778
	dc.w 636,-772
	dc.w 642,-767
	dc.w 649,-761
	dc.w 656,-755
	dc.w 662,-749
	dc.w 669,-744
	dc.w 675,-738
	dc.w 682,-732
	dc.w 688,-726
	dc.w 694,-720
	dc.w 700,-714
	dc.w 707,-708
	dc.w 713,-701
	dc.w 719,-695
	dc.w 725,-689
	dc.w 731,-682
	dc.w 737,-676
	dc.w 743,-670
	dc.w 748,-663
	dc.w 754,-657
	dc.w 760,-650
	dc.w 766,-643
	dc.w 771,-637
	dc.w 777,-630
	dc.w 782,-623
	dc.w 788,-616
	dc.w 793,-609
	dc.w 798,-602
	dc.w 803,-595
	dc.w 809,-588
	dc.w 814,-581
	dc.w 819,-574
	dc.w 824,-567
	dc.w 829,-560
	dc.w 833,-552
	dc.w 838,-545
	dc.w 843,-538
	dc.w 848,-530
	dc.w 852,-523
	dc.w 857,-516
	dc.w 861,-508
	dc.w 866,-500
	dc.w 870,-493
	dc.w 874,-485
	dc.w 878,-478
	dc.w 882,-470
	dc.w 887,-462
	dc.w 891,-454
	dc.w 894,-447
	dc.w 898,-439
	dc.w 902,-431
	dc.w 906,-423
	dc.w 909,-415
	dc.w 913,-407
	dc.w 917,-399
	dc.w 920,-391
	dc.w 923,-383
	dc.w 927,-375
	dc.w 930,-367
	dc.w 933,-359
	dc.w 936,-351
	dc.w 939,-343
	dc.w 942,-334
	dc.w 945,-326
	dc.w 948,-318
	dc.w 951,-310
	dc.w 953,-301
	dc.w 956,-293
	dc.w 958,-285
	dc.w 961,-276
	dc.w 963,-268
	dc.w 965,-259
	dc.w 968,-251
	dc.w 970,-242
	dc.w 972,-234
	dc.w 974,-225
	dc.w 976,-217
	dc.w 978,-208
	dc.w 979,-200
	dc.w 981,-191
	dc.w 983,-183
	dc.w 984,-174
	dc.w 986,-166
	dc.w 987,-157
	dc.w 989,-148
	dc.w 990,-140
	dc.w 991,-131
	dc.w 992,-122
	dc.w 993,-114
	dc.w 994,-105
	dc.w 995,-96
	dc.w 996,-88
	dc.w 996,-79
	dc.w 997,-70
	dc.w 998,-62
	dc.w 998,-53
	dc.w 999,-44
	dc.w 999,-35
	dc.w 999,-27
	dc.w 999,-18
	dc.w 999,-9
	dc.w 1000,0
	dc.w 999,8
	dc.w 999,17
	dc.w 999,26
	dc.w 999,34
	dc.w 999,43
	dc.w 998,52
	dc.w 998,61
	dc.w 997,69
	dc.w 996,78
	dc.w 996,87
	dc.w 995,95
	dc.w 994,104
	dc.w 993,113
	dc.w 992,121
	dc.w 991,130
	dc.w 990,139
	dc.w 989,147
	dc.w 987,156
	dc.w 986,165
	dc.w 984,173
	dc.w 983,182
	dc.w 981,190
	dc.w 979,199
	dc.w 978,207
	dc.w 976,216
	dc.w 974,224
	dc.w 972,233
	dc.w 970,241
	dc.w 968,250
	dc.w 965,258
	dc.w 963,267
	dc.w 961,275
	dc.w 958,284
	dc.w 956,292
	dc.w 953,300
	dc.w 951,309
	dc.w 948,317
	dc.w 945,325
	dc.w 942,333
	dc.w 939,342
	dc.w 936,350
	dc.w 933,358
	dc.w 930,366
	dc.w 927,374
	dc.w 923,382
	dc.w 920,390
	dc.w 917,398
	dc.w 913,406
	dc.w 909,414
	dc.w 906,422
	dc.w 902,430
	dc.w 898,438
	dc.w 894,446
	dc.w 891,453
	dc.w 887,461
	dc.w 882,469
	dc.w 878,477
	dc.w 874,484
	dc.w 870,492
	dc.w 866,500
	dc.w 861,507
	dc.w 857,515
	dc.w 852,522
	dc.w 848,529
	dc.w 843,537
	dc.w 838,544
	dc.w 833,551
	dc.w 829,559
	dc.w 824,566
	dc.w 819,573
	dc.w 814,580
	dc.w 809,587
	dc.w 803,594
	dc.w 798,601
	dc.w 793,608
	dc.w 788,615
	dc.w 782,622
	dc.w 777,629
	dc.w 771,636
	dc.w 766,642
	dc.w 760,649
	dc.w 754,656
	dc.w 748,662
	dc.w 743,669
	dc.w 737,675
	dc.w 731,681
	dc.w 725,688
	dc.w 719,694
	dc.w 713,700
	dc.w 707,707
	dc.w 700,713
	dc.w 694,719
	dc.w 688,725
	dc.w 681,731
	dc.w 675,737
	dc.w 669,743
	dc.w 662,748
	dc.w 656,754
	dc.w 649,760
	dc.w 642,766
	dc.w 636,771
	dc.w 629,777
	dc.w 622,782
	dc.w 615,788
	dc.w 608,793
	dc.w 601,798
	dc.w 594,803
	dc.w 587,809
	dc.w 580,814
	dc.w 573,819
	dc.w 566,824
	dc.w 559,829
	dc.w 551,833
	dc.w 544,838
	dc.w 537,843
	dc.w 529,848
	dc.w 522,852
	dc.w 515,857
	dc.w 507,861
	dc.w 499,866
	dc.w 492,870
	dc.w 484,874
	dc.w 477,878
	dc.w 469,882
	dc.w 461,887
	dc.w 453,891
	dc.w 446,894
	dc.w 438,898
	dc.w 430,902
	dc.w 422,906
	dc.w 414,909
	dc.w 406,913
	dc.w 398,917
	dc.w 390,920
	dc.w 382,923
	dc.w 374,927
	dc.w 366,930
	dc.w 358,933
	dc.w 350,936
	dc.w 342,939
	dc.w 333,942
	dc.w 325,945
	dc.w 317,948
	dc.w 309,951
	dc.w 300,953
	dc.w 292,956
	dc.w 284,958
	dc.w 275,961
	dc.w 267,963
	dc.w 258,965
	dc.w 250,968
	dc.w 241,970
	dc.w 233,972
	dc.w 224,974
	dc.w 216,976
	dc.w 207,978
	dc.w 199,979
	dc.w 190,981
	dc.w 182,983
	dc.w 173,984
	dc.w 165,986
	dc.w 156,987
	dc.w 147,989
	dc.w 139,990
	dc.w 130,991
	dc.w 121,992
	dc.w 113,993
	dc.w 104,994
	dc.w 95,995
	dc.w 87,996
	dc.w 78,996
	dc.w 69,997
	dc.w 61,998
	dc.w 52,998
	dc.w 43,999
	dc.w 34,999
	dc.w 26,999
	dc.w 17,999
	dc.w 8,999
	dc.w 0,1000


	.bss

lineavars: ds.l 1 /* 131ee */
logic: ds.l 1 /* 131f2 */
cliprect: ds.w 4 /* 131f6 */
currcolor: ds.w 1 /* 131fe */
wrt_mode: ds.w 1 /* 13200 */
colormask: ds.w 1 /* 13202 */
stipple_ptr: ds.l 1 /* 13204 */
stipple_mask: ds.w 1 /* 13208 */
stipple_default: ds.l 1 /* 1320a */
control: ds.w 42 /* 1320e */

ptsin: ds.w 96*2 /* 13262 */

finprg: /* 133e2 */
	ds.w 1

ZERO equ 0

