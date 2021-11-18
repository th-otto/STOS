		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "equates.inc"
		.include "lib.inc"

MD_REPLACE = 0

MAX_PTSIN = 64

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
	dc.w	libex-lib45

para:
	dc.w	45			; number of library routines
	dc.w	45			; number of extension commands

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


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,1               ; _falc pen
        .dc.b   I,',',I,',',I,1,1,0
l002:	.dc.b I,1,1,0             ; _falc xcurs
l003:	.dc.b 0,I,1               ; _falc paper
        .dc.b   I,',',I,',',I,1,1,0
l004:	.dc.b I,1,1,0             ; _falc ycurs
l005:	.dc.b 0,I,',',I,1,1,0     ; _falc locate
l006:	.dc.b I,1,1,0             ; _stos charwidth
l007:	.dc.b 0,S,1,1,0           ; _falc print
l008:	.dc.b I,1,1,0             ; _stos charheight
l009:	.dc.b 0,I,1,1,0           ; _stosfont
l010:	.dc.b I,1,1,0             ; _falc multipen status
l011:	.dc.b 0,1,1,0             ; _falc multipen off
l012:	.dc.b I,I,1,1,0           ; _charset addr
l013:	.dc.b 0,I,1               ; _falc multipen on
        .dc.b   I,',',I,',',I,1,1,0
l014:	.dc.b I,I,',',I,',',I,1,1,0   ; _tc rgb
l015:	.dc.b 0,I,1               ; _falc ink
        .dc.b   I,',',I,',',I,1,1,0
l016:	.dc.b I,1,1,0
l017:	.dc.b 0,I,1,1,0           ; _falc draw mode
l018:	.dc.b I,I,',',I,1,1,0     ; _get pixel
l019:	.dc.b 0,I,1,1,0           ; _def linepattern
l020:	.dc.b I,1,1,0
l021:	.dc.b 0,I,1,1,0           ; _def stipple
l022:	.dc.b I,1,1,0
l023:	.dc.b 0,I,',',I,1,1,0     ; _falc plot
l024:	.dc.b I,1,1,0
l025:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc line
l026:	.dc.b I,1,1,0
l027:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc box
l028:	.dc.b I,1,1,0
l029:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc bar
l030:	.dc.b I,1,1,0
l031:	.dc.b 0,I,',',I,1,1,0     ; _falc polyline
l032:	.dc.b I,1,1,0
l033:	.dc.b 0,S,1,1,0           ; _falc centre
l034:	.dc.b I,1,1,0
l035:	.dc.b 0,I,',',I,1,1,0     ; _falc polyfill
l036:	.dc.b I,1,1,0
l037:	.dc.b 0,I,',',I,',',I,1,1,0 ; _falc contourfill
l038:	.dc.b I,1,1,0
l039:	.dc.b 0,I,',',I,',',I,1,1,0 ; _falc circle
l040:	.dc.b I,1,1,0
l041:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc ellipse
l042:	.dc.b I,1,1,0
l043:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,1,1,0  ; _falc earc
l044:	.dc.b I,1,1,0
l045:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0  ; _falc arc

		.even

entry:
	bra.w init

params:
	ds.l 1
lineavars: ds.l 1
cliprect: ds.w 4
logic: ds.l 1
currcolor: ds.w 1
wrt_mode: ds.w 1
colormask: ds.w 1
stipple_ptr: ds.l 1
stipple_mask: ds.w 1
stipple_default: ds.l 1

	.include "patterns.inc"
	.include "sintab.inc"


drawbox:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        get_logic
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
		lea.l      drawbox_coords(pc),a4
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
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawbox_coords: ds.w 4

drawbar:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        get_logic
		cmp.w      d0,d2
		bcc.s      drawbar1
		exg        d0,d2
drawbar1:
		cmp.w      d1,d3
		bcc.s      drawbar2
		exg        d1,d3
drawbar2:
		lea.l      cliprect(pc),a1
		cmp.w      (a1),d0
		bcc.s      drawbar3
		move.w     (a1),d0
drawbar3:
		cmp.w      4(a1),d2
		bcs.s      drawbar4
		move.w     4(a1),d2
drawbar4:
		cmp.w      2(a1),d1
		bcc.s      drawbar5
		move.w     2(a1),d1
drawbar5:
		cmp.w      6(a1),d3
		bcs.s      drawbar6
		move.w     6(a1),d3
drawbar6:
		movea.l    stipple_ptr(pc),a2
		cmpi.l     #-1,(a2)
		beq.s      drawbar7
		bra.s      drawbar12
drawbar7:
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a1
		cmp.w      d0,d2
		beq.s      drawbar8
		cmp.w      d1,d3
		bne.s      drawbar9
drawbar8:
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar9:
		move.w     currcolor(pc),d6
		sub.w      d1,d3
		subq.w     #1,d3
		move.w     V_BYTES_LIN(a1),d5
		mulu.w     d5,d1
		adda.l     d1,a0
		add.w      d2,d2
drawbar10:
		move.w     d0,d4
drawbar11:
		move.w     d6,0(a0,d4.w)
		addq.w     #2,d4
		cmp.w      d4,d2
		bgt.s      drawbar11
		adda.l     d5,a0
		dbf        d3,drawbar10
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar12:
		lea.l      drawbar_coords(pc),a4
		movem.w    d0-d3,(a4)
		cmp.w      d0,d2
		beq.s      drawbar14
		cmp.w      d1,d3
		beq.s      drawbar14
		move.w     0(a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr.s      drawline
drawbar13:
		addq.w     #1,2(a4)
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr        draw_back
		move.w     6(a4),d0
		cmp.w      2(a4),d0
		bne.s      drawbar13
		move.w     (a4),d0
		move.w     6(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr.s      drawline
drawbar14:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawbar_coords: ds.w 4

drawline:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        get_logic
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
		movea.l    lineavars(pc),a6
		move.w     V_BYTES_LIN(a6),d6
		mulu.w     d6,d1
		movea.l    logic(pc),a0
		adda.l     d1,a0
		asl.w      #1,d0
		adda.l     d0,a0
		move.w     currcolor(pc),(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_back:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     d0,d4
		move.w     d1,d5
		move.w     d2,d6
		move.w     d3,d7
		movea.l    logic(pc),a0
		cmp.w      d4,d6
		bcc.s      drawhi_back1
		exg        d4,d6
drawhi_back1:
		cmp.w      d5,d7
		bcc.s      drawhi_back2
		exg        d5,d7
drawhi_back2:
		cmp.w      d5,d7
		beq.s      drawhi_back4
drawhi_back3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawhi_back4:
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

get_logic:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		lea.l      logic(pc),a0
		move.l     d0,(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

init:
		movem.l    d0-d7/a0-a6,-(a7)
		dc.w       0xa000 /* linea_init */
		lea.l      entry(pc),a4
		move.l     a0,lineavars-entry(a4)
		move.w     #1,currcolor-entry(a4)
		move.w     #MD_REPLACE,wrt_mode-entry(a4)
		move.w     #-1,colormask-entry(a4)
		lea.l      stipple_default-entry(a4),a0
		move.l     #-1,(a0)
		move.l     a0,stipple_ptr-entry(a4)
		clr.w      stipple_mask-entry(a4)
		moveq.l    #S_falc_initfont,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		lea exit(pc),a2
		rts

exit:
		rts

/*
 * Syntax:   _falc pen COL_REG
 *           _falc pen RED,GREEN,BLUE
 */
lib1:
	dc.w	0			; no library calls
falc_pen:
		subq.w     #1,d0
		beq.s      falc_pen2
		subq.w     #1,d0
		bne.s      falc_pen4
		move.l     (a6)+,d3
		andi.w     #31,d3
		move.l     (a6)+,d2
		andi.w     #31,d2
		lsl.w      #6,d2
		move.l     (a6)+,d1
		andi.w     #31,d1
		lsl.w      #6,d1
		lsl.w      #5,d1
		or.w       d3,d2
		or.w       d2,d1
		bra.s      falc_pen3
falc_pen2:
		move.l     (a6)+,d1
		andi.w     #255,d1
falc_pen3:
		moveq.l    #S_falc_pen,d0
		trap       #5
falc_pen4:
		rts

/*
 * Syntax:   X=_falc xcurs
 */
lib2:
	dc.w	0			; no library calls
falc_xcurs:
		moveq.l    #S_falc_xcurs,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc paper COL_REG
 *           _falc paper RED,GREEN,BLUE
 *           _falc paper -1
 */
lib3:
	dc.w	0			; no library calls
falc_paper:
		cmpi.w     #1,d0
		beq.s      falc_paper2
		cmpi.w     #2,d0
		beq.s      falc_paper1
		rts
falc_paper1:
		move.l     (a6)+,d3
		andi.w     #31,d3
		move.l     (a6)+,d2
		andi.w     #31,d2
		lsl.w      #6,d2
		move.l     (a6)+,d1
		andi.l     #31,d1
		lsl.w      #6,d1
		lsl.w      #5,d1
		or.w       d3,d2
		or.w       d2,d1
		bra.s      falc_paper3
falc_paper2:
		move.l     (a6)+,d1
falc_paper3:
		moveq.l    #S_falc_paper,d0
		trap       #5
		rts

/*
 * Syntax:   Y=_falc ycurs
 */
lib4:
	dc.w	0			; no library calls
falc_ycurs:
		moveq.l    #S_falc_ycurs,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc locate X,Y
 */
lib5:
	dc.w	0			; no library calls
falc_locate:
		move.l     (a6)+,d3
		move.l     (a6)+,d1
		swap       d1
		move.w     d3,d1
		moveq.l    #S_falc_locate,d0
		trap       #5
		rts

/*
 * Syntax:   CHAR_WIDTH=_stos charwidth
 */
lib6:
	dc.w	0			; no library calls
stos_charwidth:
		moveq.l    #S_charwidth,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc print A$
 */
lib7:
	dc.w	0			; no library calls
falc_print:
		move.l     (a6)+,a0
		moveq.l    #S_falc_print,d0
		trap       #5
		rts

/*
 * Syntax:   CHAR_HEIGHT=_stos charheight
 */
lib8:
	dc.w	0			; no library calls
stos_charheight:
		moveq.l    #S_charheight,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _stosfont FNT_NUM
 */
lib9:
	dc.w	0			; no library calls
stosfont:
		move.l     (a6)+,d1
		andi.l     #255,d1
		subq.w     #1,d1
		bmi.s      stosfont1
		cmpi.w     #2,d1
		bgt.s      stosfont1
		moveq.l    #S_stosfont,d0
		trap       #5
stosfont1:
		rts

/*
 * Syntax:   X=_falc multipen status
 */
lib10:
	dc.w	0			; no library calls
falc_multipen_status:
		moveq.l    #S_multipen_status,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc multipen off
 */
lib11:
	dc.w	0			; no library calls
falc_multipen_off:
		moveq.l    #S_multipen_off,d0
		trap       #5
		rts

/*
 * Syntax:   ADDR=_charset addr(CHAR_SET)
 */
lib12:
	dc.w	0			; no library calls
charset_addr:
		move.l     (a6)+,d0
		andi.w     #15,d0
		subq.w     #1,d0
		cmpi.w     #3,d0
		bcs.s      charset_addr2
		clr.l      d0
charset_addr2:
		movem.l    a0-a6,-(a7)
		move.w     #W_getcharset,d7
		trap       #3
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc multipen on STEP
 *           _falc multipen on R_INC,GR_INC,BL_INC
 */
lib13:
	dc.w	0			; no library calls
falc_multipen_on:
		subq.w     #1,d0
		beq.s      falc_multipen_on1
		subq.w     #1,d0
		bne.s      falc_multipen_on3
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		andi.w     #31,d2
		andi.w     #31,d3
		andi.w     #31,d4
		bra.s      falc_multipen_on2
falc_multipen_on1:
		move.l     (a6)+,d2
		andi.w     #255,d2
falc_multipen_on2:
		moveq.l    #S_multipen_on,d0
		trap       #5
falc_multipen_on3:
		rts

/*
 * Syntax:   RGB=_tc rgb(RED,GREEN,BLUE)
 */
lib14:
	dc.w	0			; no library calls
tc_rgb:
		move.l     (a6)+,d0
		andi.w     #31,d0
		move.l     (a6)+,d1
		andi.w     #31,d1
		asl.w      #6,d1
		move.l     (a6)+,d3
		andi.w     #31,d2
		asl.w      #6,d2
		asl.w      #5,d2
		moveq.l    #0,d3
		move.w     d2,d3
		or.w       d0,d3
		or.w       d1,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   _falc ink COL_REG
 *           _falc ink RED,GREEN,BLUE
 */
lib15:
	dc.w	0			; no library calls
falc_ink:
		movem.l    a0-a5,-(a7)
		movea.l    debut(a5),a4
		movea.l    0(a4,d1.w),a4
		subq.w     #1,d0
		beq.s      falc_ink2
		subq.w     #1,d0
		bne.s      falc_ink4
		move.l     (a6)+,d0
		andi.w     #31,d0
		move.l     (a6)+,d1
		andi.w     #31,d1
		lsl.w      #6,d1
		move.l     (a6)+,d3
		andi.w     #31,d3
		lsl.w      #6,d3
		lsl.w      #5,d3
		or.w       d0,d3
		or.w       d1,d3
		bra.s      falc_ink3
falc_ink2:
		move.l     (a6)+,d3
		andi.w     #255,d3
falc_ink3:
		move.w     d3,currcolor-entry(a4)
falc_ink4:
		movem.l    (a7)+,a0-a5
		rts

lib16:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc draw mode GR_MODE
 */
lib17:
	dc.w	0			; no library calls
falc_draw_mode:
		move.l     (a6)+,d3
		movem.l    a0-a5,-(a7)
		movea.l    debut(a5),a4
		movea.l    0(a4,d1.w),a4
		subq.l     #1,d3
		bmi.s      falc_draw_mode1
		andi.w     #3,d3
		move.w     d3,wrt_mode-entry(a4)
falc_draw_mode1:
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax:   COL_REG=_get pixel(X,Y)
 */
lib18:
	dc.w	0			; no library calls
get_pixel:
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		movea.l    lineavars-entry(a6),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      get_pixel1
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		add.w      d4,d4
		movea.l    lineavars-entry(a6),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.w     d4,a0
		moveq      #0,d0
		move.w     (a0),d0
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts
get_pixel1:
		lea.l      get_pixel_x(pc),a1
		movem.w    d4-d5,(a1)
		move.l     LA_PTSIN(a0),-(a7)
		move.l     a1,LA_PTSIN(a0)
		move.l     a0,-(a7)
		dc.w       0xa002 /* get_pixel */
		move.l     (a7)+,a0
		move.l     (a7)+,LA_PTSIN(a0)
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts

get_pixel_x: ds.w 1
get_pixel_y: ds.w 1

/*
 * Syntax:   _def linepattern PATTERN
 */
lib19:
	dc.w	0			; no library calls
def_linepattern:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.w     d3,colormask-entry(a6)
		movem.l    (a7)+,a0-a6
		rts

lib20:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _def stipple STIPPLE
 */
lib21:
	dc.w	0			; no library calls
def_stipple:
		movem.l    a0-a5,-(a7)
		movea.l    debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      patterns-entry(a4),a1
		move.l     (a6)+,d3
		beq.s      def_stipple1
		bmi.s      def_stipple1
		cmpi.l     #24,d3
		bgt.s      def_stipple1
		subq.l     #1,d3
		asl.l      #5,d3
		adda.l     d3,a1
		move.l     a1,stipple_ptr-entry(a4)
		move.w     #15,stipple_mask-entry(a4)
		movem.l    (a7)+,a0-a5
		rts
def_stipple1:
		move.l     d3,stipple_default-entry(a4)
		move.l     a1,stipple_ptr-entry(a4)
		clr.w      stipple_mask-entry(a4)
		movem.l    (a7)+,a0-a5
		rts

lib22:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc plot X,Y
 */
lib23:
	dc.w	0			; no library calls
falc_plot:
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		movea.l    lineavars-entry(a6),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      falc_plot1
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		add.w      d4,d4
		movea.l    lineavars-entry(a6),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		move.w     currcolor-entry(a6),(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts
falc_plot1:
		lea.l      get_pixel_x(pc),a1
		movem.w    d4-d5,(a1)
		move.l     LA_PTSIN(a0),-(a7)
		move.l     a1,LA_PTSIN(a0)
		lea.l      currcolor-entry(a6),a1
		move.l     LA_INTIN(a0),-(a7)
		move.l     a1,LA_INTIN(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		move.l     a0,-(a7)
		dc.w       0xa001 /* put_pixel */
		move.l     (a7)+,a0
		move.l     (a7)+,LA_INTIN(a0)
		move.l     (a7)+,LA_PTSIN(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_plot_x: ds.w 1
falc_plot_y: ds.w 1

lib24:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc line X1,Y1,X2,Y2
 */
lib25:
	dc.w	0			; no library calls
falc_line:
		movem.l    d0-d7/a0-a5,-(a7)
		movea.l    debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		movea.l    lineavars-entry(a4),a0
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_line1
		movem.w    d0-d3,LA_X1(a0)
		movem.w    d0-d3,LA_XMN_CLIP(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     currcolor-entry(a4),d0
		lea        linea_setcolor-entry(a4),a1
		jsr        (a1)
		move.w     colormask-entry(a4),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a4),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a5
		rts
falc_line1:
		lea        drawline-entry(a4),a1
		jsr        (a1)
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib26:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc box X1,Y1,X2,Y2
 */
lib27:
	dc.w	0			; no library calls
falc_box:
		movem.l    d0-d7/a0-a5,-(a7)
		movea.l    debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		movea.l    lineavars-entry(a6),a0
		lea.l      cliprect-entry(a6),a1
		clr.l      (a1)+
		move.l     DEV_TAB(a0),(a1)
		lea.l      falc_box_coords(pc),a1
		movem.w    d0-d3,(a1)
		cmpi.w     #16,LA_PLANES(a0)
		beq        falc_box_hi
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a4),a1
		jsr        (a1)
		lea.l      falc_box_coords(pc),a1
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
		movem.l    (a7)+,d0-d7/a0-a5
		rts

linea_drawline:
		movem.l    a0-a1,-(a7)
		movem.w    d1-d4,LA_X1(a0)
		movem.w    d1-d4,LA_XMN_CLIP(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,a0-a1
		rts

falc_box_hi:
		lea        drawbox-entry(a4),a1
		jsr        (a1)
		movem.l    (a7)+,d0-d7/a0-a5
		rts

falc_box_coords: ds.w 4


lib28:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc bar X1,Y1,X2,Y2
 */
lib29:
	dc.w	0			; no library calls
falc_bar:
		movem.l    d0-d7/a0-a5,-(a7)
		movea.l    debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		movea.l    lineavars-entry(a4),a0
		lea.l      cliprect-entry(a4),a1
		clr.l      (a1)+
		move.l     DEV_TAB(a0),(a1)
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_bar_hi

		movem.w    d0-d3,LA_X1(a0)
		movem.w    d0-d3,LA_XMN_CLIP(a0)
		move.w     currcolor-entry(a4),d0
		lea        linea_setcolor-entry(a4),a1
		jsr        (a1)

		move.w     wrt_mode-entry(a4),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		movea.l    stipple_ptr-entry(a4),a5
		move.w     stipple_mask-entry(a4),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		clr.w      LA_MULTIFILL(a0)
		dc.w       0xa005 /* filled_rect */
		movem.l    (a7)+,d0-d7/a0-a5
		rts

falc_bar_hi:
		lea        drawbar-entry(a4),a0
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib30:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc polyline varptr(XY_ARRAY(0)),PTS
 */
lib31:
	dc.w	0			; no library calls
falc_polyline:
		move.l     (a6)+,d3
		subq.l     #1,d3
		bmi        falc_polyline2
		cmpi.l     #MAX_PTSIN,d3
		bgt        falc_polyline2
		lea.l      polyline_pts(pc),a0
		move.l     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_polyline2
		lea.l      polyline_array(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		movea.l    lineavars-entry(a6),a0
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a6),a1
		jsr        (a1)
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
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyline1
falc_polyline3:
		movem.l    (a7)+,a0-a6
falc_polyline2:
		rts

polyline_pts: ds.l 1
polyline_array: ds.l 1

lib32:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc centre A$
 */
lib33:
	dc.w	0			; no library calls
falc_centre:
		move.l     (a6)+,a0
		movem.l    d0-d7/a1-a6,-(a7)
		moveq.l    #S_falc_centre,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a1-a6
		rts

lib34:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc polyfill varptr(XY_ARRAY(0)),PTS
 */
lib35:
	dc.w	0			; no library calls
falc_polyfill:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_polyfill4
		cmpi.l     #MAX_PTSIN,d3
		bgt        falc_polyfill4
		lea.l      polyfill_pts(pc),a0
		move.l     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_polyfill4
		lea.l      polyfill_array(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		movea.l    lineavars-entry(a6),a0
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a6),a1
		jsr        (a1)
		movem.l    a0-a6,-(a7)
		lea.l      pptsin(pc),a4
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
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		lea.l      control(pc),a4
		move.l     a4,LA_CONTROL(a0)
		lea.l      pptsin(pc),a4
		move.l     a4,LA_PTSIN(a0)
		movea.l    stipple_ptr-entry(a6),a5
		move.w     stipple_mask-entry(a6),d0
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
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyfill3
falc_polyfill5:
		movem.l    (a7)+,a0-a6
falc_polyfill4:
		rts

find_miny:
		movem.l    a0-a6,-(a7)
		lea.l      pptsin+2(pc),a0
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
		lea.l      pptsin+2(pc),a0
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

control: ds.w 10

pptsin: ds.w MAX_PTSIN*2

lib36:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc contourfill X,Y,COLOR
 */
lib37:
	dc.w	0			; no library calls
falc_contourfill:
		move.l     (a6)+,d3
		andi.w     #15,d3
		move.w     d3,30(a0) /* BUG: relies on layout of internal VDI structure */
		move.l     (a6)+,d3
		lea.l      contourfill_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      contourfill_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		movea.l    lineavars-entry(a6),a0
		move.l     LA_INTIN(a0),-(a7)
		move.l     LA_PTSIN(a0),-(a7)
		lea.l      contourfill_intin(pc),a5
		move.l     a5,LA_INTIN(a0)
		lea.l      contourfill_x(pc),a5
		move.l     a5,LA_PTSIN(a0)
* set fill color in vdi workstation
		move.l     CUR_WORK(a0),a5
		move.w     30(a5),-(a7)
		move.w     d7,30(a5)
		move.l     a0,-(a7)
		lea.l      fill_abort(pc),a5
		move.l     a5,LA_FILL_ABORT(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-entry(a6),a5
		move.w     stipple_mask-entry(a6),d0
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


lib38:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc circle X,Y,R
 */
lib39:
	dc.w	0			; no library calls
falc_circle:
		move.l     (a6)+,d3
		lea.l      circle_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		move.l     (a6)+,d3
		lea.l      circle_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      circle_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		lea.l      sintab-entry(a6),a4
		movea.l    lineavars-entry(a6),a0
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
		movea.l    lineavars-entry(a6),a0
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a6),a1
		jsr        (a1)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-entry(a6),a5
		move.w     stipple_mask-entry(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		clr.w      LA_MULTIFILL(a0)
		lea.l      circle_coords(pc),a3
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
		movea.l    lineavars-entry(a6),a0
		movem.w    circle_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa004 /* horizontal_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #360,d7
		blt        falc_circle2
		movem.l    (a7)+,a0-a6
		lea.l      circle_coords(pc),a3
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
		movea.l    lineavars-entry(a6),a0
		movem.w    circle_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
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

lib40:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc ellipse X,Y,X_RAD,Y_RAD
 */
lib41:
	dc.w	0			; no library calls
falc_ellipse:
		move.l     (a6)+,d3
		lea.l      ellipse_rad+2(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      ellipse_rad(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      ellipse_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      ellipse_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		lea.l      sintab-entry(a6),a4
		movea.l    lineavars-entry(a6),a0
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
		movea.l    lineavars-entry(a6),a0
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a6),a1
		jsr        (a1)
		movem.l    a0-a6,-(a7)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-entry(a6),a5
		move.w     stipple_mask-entry(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		clr.w      LA_MULTIFILL(a0)
		clr.w      LA_CLIP(a0)
		lea.l      ellipse_coords(pc),a3
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
		movea.l    lineavars-entry(a6),a0
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
		movea.l    lineavars-entry(a6),a0
		movem.w    ellipse_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
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

lib42:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc earc X,Y,X_RAD,Y_RAD,BEG_ANGLE,END_ANGLE
 */
lib43:
	dc.w	0			; no library calls
falc_earc:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		cmpi.l     #3600,d3
		bgt        falc_earc3
		lea.l      earc_end_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		cmpi.l     #3600,d3
		bgt        falc_earc3
		lea.l      earc_beg_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      earc_yrad(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      earc_xrad(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		lea.l      earc_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		lea.l      earc_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		lea.l      sintab-entry(a6),a4
		movea.l    lineavars-entry(a6),a0
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
		movea.l    lineavars-entry(a6),a0
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a6),a1
		jsr        (a1)
		lea.l      earc_coords(pc),a3
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
		movea.l    lineavars-entry(a6),a0
		movem.w    earc_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      earc_end_angle(pc),d7
		blt        falc_earc2
		movem.l    (a7)+,a0-a6
falc_earc3:
		rts

earc_beg_angle: ds.w 1
earc_end_angle: ds.w 1
earc_xrad: ds.w 1
earc_yrad: ds.w 1
earc_x: ds.w 1
earc_y: ds.w 1
earc_coords: ds.w 4

lib44:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc arc X,Y,R,BEG_ANGLE,END_ANGLE
 */
lib45:
	dc.w	0			; no library calls
falc_arc:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		cmpi.l     #3600,d3
		bgt        falc_arc3
		lea.l      arc_end_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		cmpi.l     #3600,d3
		bgt        falc_arc3
		lea.l      arc_beg_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      arc_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		lea.l      arc_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		lea.l      arc_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		lea.l      sintab-entry(a6),a4
		movea.l    lineavars-entry(a6),a0
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
		movea.l    lineavars-entry(a6),a0
		move.w     currcolor-entry(a6),d0
		lea        linea_setcolor-entry(a6),a1
		jsr        (a1)
		lea.l      arc_coords(pc),a3
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
		movea.l    lineavars-entry(a6),a0
		movem.w    arc_coords(pc),d0-d3
		movem.w    d0-d3,LA_X1(a0)
		clr.w      LA_LSTLIN(a0)
		move.w     colormask-entry(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-entry(a6),LA_WRT_MODE(a0)
		clr.w      LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      arc_end_angle(pc),d7
		blt        falc_arc2
		movem.l    (a7)+,a0-a6
falc_arc3:
		rts

arc_beg_angle: ds.w 1
arc_end_angle: ds.w 1
arc_rad: ds.w 2
arc_x: ds.w 1
arc_y: ds.w 1
arc_coords: ds.w 4


libex:
	dc.w 0
