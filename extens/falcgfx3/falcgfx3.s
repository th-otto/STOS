		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"

MD_REPLACE = 0

MAX_PTSIN = 64

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
mode: dc.w 0

load:
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts

initvars:
		move.w     #1,currcolor-lineavars(a1)
		move.w     #MD_REPLACE,wrt_mode-lineavars(a1)
		move.w     #-1,colormask-lineavars(a1)
		lea.l      stipple_default(pc),a0
		move.l     #-1,(a0)
		move.l     a0,stipple_ptr-lineavars(a1)
		clr.w      stipple_mask-lineavars(a1)
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #S_falc_initfont,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		rts

cold:
		move.l     a0,table
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		andi.w     #3,d0
		lea.l      mode(pc),a0
		move.w     d0,(a0)
		dc.w       0xa000 /* linea_init */
		lea.l      lineavars(pc),a1
		move.l     a0,(a1)
		bsr        initvars
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		bsr.s      check_spritelib
		bne        spritelib_err
		rts

check_spritelib:
		movem.l    d0-d6/a0-a6,-(a7)
		movea.l    0x00000094,a1 ; vector for trap #5
		suba.w     #(spritelib_id_end-spritelib_id),a1
		lea.l      spritelib_id(pc),a0
		moveq.l    #spritelib_id_end-spritelib_id-1,d7
check_spritelib1:
		cmpm.b     (a0)+,(a1)+
		dbne       d7,check_spritelib1
		movem.l    (a7)+,d0-d6/a0-a6
		rts

spritelib_id:
	dc.b "FALCON 030 STOS Sprite 5.8",0,0
spritelib_id_end:
	.even

warm:
		move.l     a1,-(a7)
		lea.l      lineavars(pc),a1
		bsr        initvars
		move.l     (a7)+,a1
		rts

drawline:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a6
		cmp.w      d0,d2
		beq.s      drawline1
		cmp.w      d1,d3
		beq.s      drawline1
		bra        drawline_hi1
drawline1:
		movea.l    logic(pc),a0
		move.w     d0,d4
		move.w     d1,d5
		move.w     d2,d6
		move.w     d3,d7
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

* diagonal draw
drawline_hi1:
		lea.l      drawline_coords(pc),a0
		movem.w    d0-d3,(a0)
		lea        line_dirs(pc),a3
		move.w     d2,d4
		sub.w      d0,d4
		move.w     d3,d5
		sub.w      d1,d5
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
		clr.w      4(a3)
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
		move.l     d0,LA_FG_B_PLANES(a0)
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
		bne.s      drawbar3
drawbar2:
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar3:
		move.w     currcolor(pc),d6
		sub.w      d1,d3
		subq.w     #1,d3
		move.w     V_BYTES_LIN(a1),d5
		mulu.w     d5,d1
		adda.l     d1,a0
		add.w      d2,d2
drawbar4:
		move.w     d0,d4
drawbar5:
		move.w     d6,0(a0,d4.w)
		addq.w     #2,d4
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
		clr.w      (a0)+
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
		move.l     (a7)+,a1

syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
illfunc:
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0

goerror:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     mode(pc),d0
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
		move.w     mode(pc),d0
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
		move.l     (a7)+,a1
		subq.w     #1,d0
		beq.s      falc_pen2
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.w     #31,d3
		move.w     d3,d1
		bsr        getinteger
		andi.w     #31,d3
		lsl.w      #6,d3
		move.w     d3,d0
		bsr        getinteger
		andi.w     #31,d3
		lsl.w      #6,d3
		lsl.w      #5,d3
		or.w       d0,d3
		or.w       d1,d3
		bra.s      falc_pen3
falc_pen2:
		bsr        getinteger
		andi.w     #255,d3
falc_pen3:
		move.l     a1,-(a7)
		move.w     d3,d1
		moveq.l    #S_falc_pen,d0
		trap       #5
		rts

falc_pen_rgb: ds.w 4

/*
 * Syntax:   X=_falc xcurs
 */
falc_xcurs:
		tst.w      d0
		bne        syntax
		moveq.l    #S_falc_xcurs,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   _falc paper COL_REG
 *           _falc paper RED,GREEN,BLUE
 *           _falc paper -1
 */
falc_paper:
		move.l     (a7)+,a1
		subq.w     #1,d0
		beq.s      falc_paper2
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.w     #31,d3
		move.w     d3,d0
		bsr        getinteger
		andi.w     #31,d3
		lsl.w      #6,d3
		move.w     d3,d1
		andi.l     #31,d3
		lsl.w      #6,d3
		lsl.w      #5,d3
		or.w       d0,d3
		or.w       d1,d3
		bra.s      falc_paper3
falc_paper2:
		bsr        getinteger
falc_paper3:
		move.l     a1,-(a7)
		move.l     d3,d1
		moveq.l    #S_falc_paper,d0
		trap       #5
		rts

/*
 * Syntax:   Y=_falc ycurs
 */
falc_ycurs:
		tst.w      d0
		bne        syntax
		moveq.l    #S_falc_ycurs,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   _falc locate X,Y
 */
falc_locate:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,d1
		swap       d1
		bsr        getinteger
		move.l     a1,-(a7)
		move.w     d3,d1
		moveq.l    #S_falc_locate,d0
		trap       #5
		rts

/*
 * Syntax:   CHAR_WIDTH=_stos charwidth
 */
stos_charwidth:
		tst.w      d0
		bne        syntax
		moveq.l    #S_charwidth,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   _falc print A$
 */
falc_print:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a0
		move.l     a1,-(a7)
		moveq.l    #S_falc_print,d0
		trap       #5
		rts

/*
 * Syntax:   CHAR_HEIGHT=_stos charheight
 */
stos_charheight:
		tst.w      d0
		bne        syntax
		moveq.l    #S_charheight,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   _stosfont FNT_NUM
 */
stosfont:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7)
		andi.l     #255,d3
		subq.w     #1,d3
		bmi.s      stosfont1
		cmpi.w     #2,d3
		bgt.s      stosfont1
		move.w     d3,d1
		moveq.l    #S_stosfont,d0
		trap       #5
stosfont1:
		rts

/*
 * Syntax:   X=_falc multipen status
 */
falc_multipen_status:
		tst.w      d0
		bne        syntax
		moveq.l    #S_multipen_status,d0
		trap       #5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   _falc multipen off
 */
falc_multipen_off:
		tst.w      d0
		bne        syntax
		moveq.l    #S_multipen_off,d0
		trap       #5
		rts

/*
 * Syntax:   ADDR=_charset addr(CHAR_SET)
 */
charset_addr:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7)
		andi.w     #15,d3
		subq.w     #1,d3
		cmpi.w     #3,d3
		bcs.s      charset_addr2
		clr.l      d3
charset_addr2:
		movem.l    a0-a6,-(a7)
		move.w     d3,d0
		move.w     #W_getcharset,d7
		trap       #3
		movem.l    (a7)+,a0-a6
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   _falc multipen on STEP
 *           _falc multipen on R_INC,GR_INC,BL_INC
 */
falc_multipen_on:
		move.l     (a7)+,a1
		subq.w     #1,d0
		beq.s      falc_multipen_on1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.w     #31,d3
		move.w     d3,d0
		bsr        getinteger
		andi.w     #31,d3
		move.w     d3,d1
		bsr        getinteger
		andi.w     #31,d3
		bra.s      falc_multipen_on2
falc_multipen_on1:
		bsr        getinteger
		andi.w     #255,d3
falc_multipen_on2:
		move.l     a1,-(a7)
		move.w     d3,d2
		move.w     d1,d3
		move.w     d0,d4
		moveq.l    #S_multipen_on,d0
		trap       #5
		rts

/*
 * Syntax:   RGB=_tc rgb(RED,GREEN,BLUE)
 */
tc_rgb:
		move.l     (a7)+,a1
		subq.w     #3,d0
		bne        syntax
		bsr        getinteger
		andi.w     #31,d3
		move.w     d3,d0
		bsr        getinteger
		andi.w     #31,d3
		asl.w      #6,d3
		move.w     d3,d1
		bsr        getinteger
		andi.l     #31,d3
		asl.w      #6,d3
		asl.w      #5,d3
		or.w       d0,d3
		or.w       d1,d3
		clr.l      d2
		jmp        (a1)

/*
 * Syntax:   _falc ink COL_REG
 *           _falc ink RED,GREEN,BLUE
 */
falc_ink:
		move.l     (a7)+,a1
		subq.w     #1,d0
		beq.s      falc_ink2
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.w     #31,d3
		move.w     d3,d0
		bsr        getinteger
		andi.w     #31,d3
		lsl.w      #6,d3
		move.w     d3,d1
		bsr        getinteger
		andi.w     #31,d3
		lsl.w      #6,d3
		lsl.w      #5,d3
		or.w       d0,d3
		or.w       d1,d3
		bra.s      falc_ink3
falc_ink2:
		bsr        getinteger
		andi.w     #255,d3
falc_ink3:
		move.l     a1,-(a7)
		lea.l      currcolor(pc),a0
		move.w     d3,(a0)
		rts

/*
 * Syntax:   _falc draw mode GR_MODE
 */
falc_draw_mode:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7)
		subq.l     #1,d3
		bmi.s      falc_draw_mode1
		lea.l      wrt_mode(pc),a0
		andi.w     #3,d3
		move.w     d3,(a0)
falc_draw_mode1:
		rts

/*
 * Syntax:   COL_REG=_get pixel(X,Y)
 */
get_pixel:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		lea.l      get_pixel_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		move.l     a1,-(a7)
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
		move.w     get_pixel_x(pc),d4
		asl.w      #1,d4
		move.w     get_pixel_y(pc),d5
		movea.l    lineavars(pc),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		moveq      #0,d3
		move.w     (a0),d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		rts
get_pixel1:
		lea.l      get_pixel_x(pc),a1
		move.l     a1,LA_PTSIN(a0)
		dc.w       0xa002 /* get_pixel */
		movem.l    (a7)+,a0-a6
		move.l     d0,d3
		clr.l      d2
		rts

get_pixel_x: ds.w 1
get_pixel_y: ds.w 1

/*
 * Syntax:   _def linepattern PATTERN
 */
def_linepattern:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7)
		lea.l      colormask(pc),a0
		move.w     d3,(a0)
		rts

/*
 * Syntax:   _def stipple STIPPLE
 */
def_stipple:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7)
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
		rts
def_stipple1:
		lea.l      stipple_default(pc),a1
		move.l     d3,(a1)
		lea.l      stipple_ptr(pc),a0
		move.l     a1,(a0)
		lea.l      stipple_mask(pc),a0
		clr.w      (a0)
		rts

/*
 * Syntax:   _falc plot X,Y
 */
falc_plot:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		lea.l      falc_plot_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      falc_plot_x(pc),a0
		move.w     d3,(a0)
		move.l     a1,-(a7)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      falc_plot1
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		move.w     falc_plot_x(pc),d4
		asl.w      #1,d4
		move.w     falc_plot_y(pc),d5
		movea.l    lineavars(pc),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		move.w     currcolor(pc),(a0)
		movem.l    (a7)+,a0-a6
		rts
falc_plot1:
		lea.l      currcolor(pc),a1
		move.l     a1,LA_INTIN(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		lea.l      falc_plot_x(pc),a1
		move.l     a1,LA_PTSIN(a0)
		dc.w       0xa001 /* put_pixel */
		movem.l    (a7)+,a0-a6
		rts

falc_plot_x: ds.w 1
falc_plot_y: ds.w 1

/*
 * Syntax:   _falc line X1,Y1,X2,Y2
 */
falc_line:
		move.l     (a7)+,a1
		subq.w     #4,d0
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
		move.l     a1,-(a7)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_line1
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movem.w    falc_line_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		movem.w    d0-d3,LA_XMN_CLIP(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		rts
falc_line1:
		bsr        get_logic
		movem.w    falc_line_coords(pc),d0-d3
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_line_coords: ds.w 4

/*
 * Syntax:   _falc box X1,Y1,X2,Y2
 */
falc_box:
		move.l     (a7)+,a1
		subq.w     #4,d0
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
		move.l     a1,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      cliprect(pc),a1
		clr.l      (a1)+
		move.l     DEV_TAB(a0),(a1)
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
		rts

linea_drawline:
		movem.l    a0-a1,-(a7)
		movem.w    d1-d4,LA_X1(a0)
		movem.w    d1-d4,LA_XMN_CLIP(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,a0-a1
		rts

falc_box_hi:
		bsr        get_logic
		lea.l      drawbox_coords(pc),a4
		movem.w    (a4),d0-d3
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
		movem.w    d0-d3,(a4)
* left line
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
		rts


drawbox_coords: ds.w 4

/*
 * Syntax:   _falc bar X1,Y1,X2,Y2
 */
falc_bar:
		move.l     (a7)+,a1
		subq.w     #4,d0
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
		move.l     a1,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      cliprect(pc),a1
		clr.l      (a1)+
		move.l     DEV_TAB(a0),(a1)
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_bar_hi
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movem.w    falc_bar_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		movem.w    d0-d3,LA_XMN_CLIP(a0)

		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		clr.w      LA_MULTIFILL(a0)
		dc.w       0xa005 /* filled_rect */
		movem.l    (a7)+,d1-d7/a0-a6
		rts

falc_bar_hi:
		bsr        get_logic
		lea.l      falc_bar_coords(pc),a4
		movem.w    (a4)+,d0-d3
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
		bsr        drawbar
		movem.l    (a7)+,d1-d7/a0-a6
		rts

falc_bar_coords: ds.w 4

/*
 * Syntax:   _falc polyline varptr(XY_ARRAY(0)),PTS
 */
falc_polyline:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		subq.l     #1,d3
		bmi        illfunc
		cmpi.l     #MAX_PTSIN,d3
		bgt        illfunc
		lea.l      polyline_pts(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      polyline_array(pc),a0
		move.l     d3,(a0)
		move.l     a1,-(a7)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.w     currcolor(pc),d0
		bsr        linea_setcolor
		movea.l    polyline_array(pc),a1
		move.l     polyline_pts(pc),d7
		subq.l     #1,d7
falc_polyline1:
		move.l     (a1),d0
		move.l     4(a1),d1
		move.l     8(a1),d2
		move.l     12(a1),d3
		movem.w    d0-d3,LA_X1(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyline1
		movem.l    (a7)+,a0-a6
		rts

polyline_pts: ds.l 1
polyline_array: ds.l 1

/*
 * Syntax:   _falc centre A$
 */
falc_centre:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getstring
		move.l     a1,-(a7)
		movea.l    d3,a0
		moveq.l    #S_falc_centre,d0
		trap       #5
		rts

/*
 * Syntax:   _falc polyfill varptr(XY_ARRAY(0)),PTS
 */
falc_polyfill:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #MAX_PTSIN,d3
		bgt        illfunc
		lea.l      polyfill_pts(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		lea.l      polyfill_array(pc),a0
		move.l     d3,(a0)
		move.l     a1,-(a7)
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
		clr.w      LA_MULTIFILL(a0)
		clr.w      LA_CLIP(a0)
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
		move.l     4(a1),d1
		move.l     8(a1),d2
		move.l     12(a1),d3
		movem.w    d0-d3,LA_X1(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyfill3
		movem.l    (a7)+,a0-a6
		rts

find_miny:
		movem.l    a0-a6,-(a7)
		lea.l      ptsin+2(pc),a0
		lea.l      polyfill_y1(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		moveq      #-1,d0
find_miny1:
		move.w     (a0),d1
		cmp.w      d1,d0
		bcs.s      find_miny2
		move.w     d1,d0
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
find_maxy1:
		move.w     (a0),d1
		cmp.w      d1,d0
		bgt.s      find_maxy2
		move.w     d1,d0
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
		move.l     (a7)+,a1
		subq.w     #3,d0
		bne        syntax
		bsr        getinteger
		andi.w     #15,d3
		move.w     d3,d7
		bsr        getinteger
		lea.l      contourfill_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      contourfill_x(pc),a0
		move.w     d3,(a0)
		move.l     a1,-(a7)
		movem.l    a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		move.l     LA_INTIN(a0),-(a7)
		move.l     LA_PTSIN(a0),-(a7)
		lea.l      contourfill_intin(pc),a5
		move.l     a5,LA_INTIN(a0)
		lea.l      contourfill_x(pc),a5
		move.l     a5,LA_PTSIN(a0)
* set fill color in vdi workstation
		move.l     CUR_WORK(a0),a5
		move.w     d7,30(a5)
		move.l     a0,-(a7)
		lea.l      fill_abort(pc),a5
		move.l     a5,LA_FILL_ABORT(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		movem.w    DEV_TAB(a0),d0-d1
		move.w     #1,LA_CLIP(a0)
		clr.l      LA_XMN_CLIP(a0)
		movem.w    d0-d1,LA_XMX_CLIP(a0)
		dc.w       0xa00f /* seed_fill */
* restore fill color
		move.l     (a7)+,a0
		move.l     CUR_WORK(a0),a5
		move.w     (a7)+,30(a5)
		move.l     (a7)+,LA_PTSIN(a0)
		move.l     (a7)+,LA_INTIN(a0)
		movem.l    (a7)+,a0-a6
		rts

fill_abort:
		clr.l      d0
		rts

contourfill_x: ds.w 1
contourfill_y: ds.w 1
contourfill_intin: dc.l -1


/*
 * Syntax:   _falc circle X,Y,R
 */
falc_circle:
		move.l     (a7)+,a1
		subq.w     #3,d0
		bne        syntax
		bsr        getinteger
		lea.l      circle_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		bsr        getinteger
		lea.l      circle_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      circle_x(pc),a0
		move.w     d3,(a0)
		move.l     a1,-(a7)
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
		clr.w      LA_MULTIFILL(a0)
		clr.w      LA_CLIP(a0)
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
		movem.w    circle_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
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
		movem.w    circle_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #720,d7
		blt        falc_circle3
		movem.l    (a7)+,a0-a6
		rts

circle_rad: ds.w 2
circle_x: ds.w 1
circle_y: ds.w 1
circle_coords: ds.w 4

/*
 * Syntax:   _falc ellipse X,Y,X_RAD,Y_RAD
 */
falc_ellipse:
		move.l     (a7)+,a1
		subq.w     #4,d0
		bne        syntax
		bsr        getinteger
		lea.l      ellipse_rad+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      ellipse_rad(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      ellipse_y(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      ellipse_x(pc),a0
		move.w     d3,(a0)
		move.l     a1,-(a7)
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
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		movea.l    stipple_ptr(pc),a5
		move.w     stipple_mask(pc),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		clr.w      LA_MULTIFILL(a0)
		clr.w      LA_CLIP(a0)
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
		movem.w    ellipse_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		dc.w       0xa004 /* horizontal_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #360,d7
		blt        falc_ellipse2
		movem.l    (a7)+,a0-a6
		lea.l      ellipse_coords(pc),a3
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
		movem.w    ellipse_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #720,d7
		blt        falc_ellipse3
		movem.l    (a7)+,a0-a6
		rts

ellipse_rad: ds.w 2
ellipse_x: ds.w 1
ellipse_y: ds.w 1
ellipse_coords: ds.w 4

/*
 * Syntax:   _falc earc X,Y,X_RAD,Y_RAD,BEG_ANGLE,END_ANGLE
 */
falc_earc:
		move.l     (a7)+,a1
		subq.w     #6,d0
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
		lea.l      earc_yrad(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
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
		move.l     a1,-(a7)
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
		movem.w    earc_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      earc_end_angle(pc),d7
		blt        falc_earc2
		movem.l    (a7)+,a0-a6
		rts

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
		move.l     (a7)+,a1
		subq.w     #5,d0
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
		move.l     a1,-(a7)
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
		movem.w    arc_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask(pc),LA_LN_MASK(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      arc_end_angle(pc),d7
		blt        falc_arc2
		movem.l    (a7)+,a0-a6
		rts

arc_beg_angle: ds.w 1
arc_end_angle: ds.w 1
arc_rad: ds.w 2
arc_x: ds.w 1
arc_y: ds.w 1
arc_coords: ds.w 4

	.data

	.include "patterns.inc"
	.include "sintab.inc"


	.bss

lineavars: ds.l 1
logic: ds.l 1
cliprect: ds.w 4
currcolor: ds.w 1
wrt_mode: ds.w 1
colormask: ds.w 1
stipple_ptr: ds.l 1
stipple_mask: ds.w 1
stipple_default: ds.l 1
control: ds.w 10

ptsin: ds.w MAX_PTSIN*2

finprg:
	ds.w 1
