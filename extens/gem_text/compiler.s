		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "tokens.inc"
		.include "equates.inc"
		.include "lib.inc"

SCRATCHBUF_SIZE equ 1024

MD_REPLACE = 0
MD_TRANS   = 1

TXT_LIGHT = 2

		.text

stext:

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
	dc.w	libex-lib17

para:
	dc.w	17			; number of library routines
	dc.w	17			; number of extension commands
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


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,1,1,0             ; gemtext init
l002:	.dc.b S,1,1,0             ; gemfont name$
l003:	.dc.b 0,I,',',I,1,1,0     ; gemtext color
l004:	.dc.b I,1,1,0             ; gemfont cellwidth
l005:	.dc.b 0,I,1,1,0           ; gemtext mode
l006:	.dc.b I,1,1,0             ; gemfont cellheight
l007:	.dc.b 0,I,1,1,0           ; gemtext style
l008:	.dc.b I,S,1,1,0           ; gemtext stringwidth
l009:	.dc.b 0,I,1,1,0           ; gemtext angle
l010:	.dc.b I,I,1,1,0           ; gemfont convert
l011:	.dc.b 0,I,1               ; gemtext font
        .dc.b   I,',',I,1,1,0
l012:	.dc.b I,1,1,0             ; gemfont info
l013:	.dc.b 0,I,1,1,0           ; gemtext scale
l014:	.dc.b I,1,1,0
l015:	.dc.b 0,I,',',I,',',S,1,1,0 ; gemtext
l016:	.dc.b I,1,1,0
l017:	.dc.b 0,S,',',I,1,1,0     ; gemfont load

		.even

entry:
		bra.w      init
initvars_offset: dc.l   initvars-entry /* 108f0 */
gemtext_offset: dc.l   realgemtext-entry /* 10910 */

fontbankptr: ds.l 1 /* 12 */
fontptr: ds.l 1 /* 16 */
fontnum: ds.w 1 /* 20 */
text_style: ds.w 1 /* 22 */
fgcolor: dc.w 1 /* 24 */
bgcolor: ds.w 1 /* 26 */
wrt_mode: ds.w 1 /* 28 */
text_rotation: ds.w 1 /* 30 */
text_double: ds.w 1 /* 32 */
string_x: ds.w 1 /* 34 */
string_y: ds.w 1 /* 36 */
save_clip: ds.w 1 /* 38 */
string_len: ds.w 1 /* 40 */
string_ptr: ds.l 1 /* 42 */
scratchbuf: ds.w SCRATCHBUF_SIZE

	.ds.b 20

initvars:
		move.l     a0,-(a7)
		lea.l      fontbankptr(pc),a0
		clr.l      (a0)+             /* fontbankptr */
		clr.l      (a0)+             /* fontptr */
		move.l     #0x00040000,(a0)+ /* fontnum/text_style */
		move.l     #0x00010000,(a0)+ /* fgcolor/bgcolor */
		clr.l      (a0)+             /* wrt_mode/text_rotation */
		clr.w      (a0)+             /* text_double */
		clr.l      (a0)+             /* string_x/string_y */
		movea.l    (a7)+,a0
		rts

realgemtext:
		movem.l    d1-d7/a1-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      gemtext1
		bsr.s      gemtexthi
		movem.l    (a7)+,d1-d7/a1-a6
		rts
gemtext1:
		bsr        gemtextplanes
		movem.l    (a7)+,d1-d7/a1-a6
		rts


gemtexthi:
		movem.l    a1-a6,-(a7)
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		lea.l      fontptrhi(pc),a2
		move.l     d0,logic-fontptrhi(a2)
		movem.l    a2-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		movem.l    (a7)+,a2-a6
		move.w     V_BYTES_LIN(a0),bytes_lin-fontptrhi(a2)
		move.w     DEV_TAB(a0),d0
		andi.l     #0x0000FFFF,d0 /* FIXME useless */
		move.w     d0,maxx-fontptrhi(a2)
		move.w     DEV_TAB+2(a0),d0
		andi.l     #0x0000FFFF,d0 /* FIXME useless */
		move.w     d0,maxy-fontptrhi(a2)
		move.w     fontnum(pc),d0
		movea.l    0(a1,d0.w),a3
		move.l     fontptr(pc),d1
		tst.l      d1
		beq.s      gemtexthi1
		movea.l    fontptr(pc),a3
		move.l     a3,d1
gemtexthi1:
		lea.l      fontptrhi(pc),a2
		move.l     a3,(a2)
		move.l     font_off_table(a3),d0
		add.l      d1,d0
		move.l     d0,offtablehi-fontptrhi(a2)
		move.l     font_dat_table(a3),d0
		add.l      d1,d0
		move.l     d0,dattablehi-fontptrhi(a2)
		move.w     font_form_width(a3),formwhi-fontptrhi(a2)
		move.w     font_form_height(a3),formhhi-fontptrhi(a2)
		lea.l      string_x(pc),a5
		movea.l    string_ptr(pc),a6
gemtexthi2:
		tst.w      string_len(pc) /* BUG 68020 only addressing mode */
		beq        gemtexthi10
		lea.l      string_len(pc),a4
		/* subq.w     #1,(a4) */
		dc.w 0x0454,1 /* XXX */
		move.b     (a6)+,d0
		andi.l     #255,d0
		cmp.w      font_last_ade(a3),d0
		bgt.s      gemtexthi2
		sub.w      font_first_ade(a3),d0
		blt.s      gemtexthi2
		lea.l      fontptrhi(pc),a2
		movea.l    logic-fontptrhi(a2),a1
		movea.l    offtablehi-fontptrhi(a2),a4
		move.w     d0,charnum-fontptrhi(a2)
		move.w     0(a4,d0.w*2),charoffhi-fontptrhi(a2) /* BUG 68020 only addressing mode */
		btst       #3,font_flags+1(a3) /* monospaced? */
		beq.s      gemtexthi3
		move.w     font_max_cell_width(a3),charwhi-fontptrhi(a2)
		bra.s      gemtexthi4
gemtexthi3:
		move.w     2(a4,d0.w*2),d1 ; 68020+ only
		sub.w      0(a4,d0.w*2),d1 ; 68020+ only
		move.w     d1,charwhi-fontptrhi(a2)
gemtexthi4:
		movem.l    d6-d7/a2-a6,-(a7)
		move.w     ZERO(a5),d4
		move.w     2(a5),d5
		cmp.w      maxy(pc),d5
		bhi.s      gemtexthi9
		cmp.w      maxx(pc),d4
		bhi.s      gemtexthi9
		asl.w      #1,d4
		move.w     2(a5),d5 /* FIXME already there */
		mulu.w     bytes_lin(pc),d5
		adda.l     d5,a1
		adda.w     d4,a1
		move.l     #0x55555555,d0 /* FIXME: use font_lighten from font header */
		btst       #1,text_style+1(pc) /* light text? */ /* BUG 68020 only addressing mode */
		bne.s      gemtexthi5
		moveq.l    #-1,d0
gemtexthi5:
		move.w     ZERO(a5),d4
		move.w     2(a5),d5
		movea.l    dattablehi(pc),a0
		move.w     formhhi-fontptrhi(a2),d7
		subq.w     #1,d7
gemtexthi6:
		bsr.s      drawchar
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      gemtexthi7
		adda.w     bytes_lin(pc),a1
		bsr.s      drawchar
		addq.w     #1,d5
		cmp.w      maxy(pc),d5
		bhi.s      gemtexthi8
gemtexthi7:
		adda.w     formwhi(pc),a0
		adda.w     bytes_lin(pc),a1
		addq.w     #1,d5
		cmp.w      maxy(pc),d5
		bhi.s      gemtexthi8
		dbf        d7,gemtexthi6
gemtexthi8:
		movem.l    (a7)+,d6-d7/a2-a6
		move.w     charwhi(pc),d1
		add.w      d1,(a5)
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq        gemtexthi2
		add.w      d1,(a5)
		bra        gemtexthi2
gemtexthi9:
		movem.l    (a7)+,d6-d7/a2-a6
gemtexthi10:
		movem.l    (a7)+,a1-a6
		rts

maxy: ds.w 1
maxx: ds.w 1
logic: ds.l 1
bytes_lin: ds.w 1
fontptrhi: ds.l 1
offtablehi: ds.l 1
dattablehi: ds.l 1
charwhi: ds.w 1
formwhi: ds.w 1
formhhi: ds.w 1
charoffhi: ds.w 1
charnum: ds.w 1 /* unused */

drawchar:
		movem.l    d4-d5/a1,-(a7)
		moveq.l    #0,d1
		moveq.l    #0,d3
		move.w     charwhi-fontptrhi(a2),d3
		move.w     charoffhi-fontptrhi(a2),d1
		bfextu     ZERO(a0){d1:d3},d2 ; 68020+ only
		and.l      d0,d2
		btst       #0,text_style+1(pc) /* bold? */
		beq.s      drawchar1
		move.l     d2,d1
		asr.l      #1,d1
		or.l       d1,d2
drawchar1:
		subq.w     #1,d3
		/* tst.w     bgcolor(pc) */ ; BUG: 68020 only addressing mode
		dc.w 0x0c7a,0,wrt_mode-stext-(*-stext)-4 /* XXX */
		beq.s      drawchar_repl
		cmpi.w     #1,wrt_mode(pc) ; BUG: 68020 only addressing mode
		beq.s      drawchar_trans
		cmpi.w     #2,wrt_mode(pc) ; BUG: 68020 only addressing mode
		beq        drawchar_xor
		cmpi.w     #3,wrt_mode(pc) ; BUG: 68020 only addressing mode
		beq        drawchar_erase

drawchar_repl:
		nop
drawchar_repl1:
		btst       d3,d2
		beq.s      drawchar_repl2
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_repl3
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		bra.s      drawchar_repl3
drawchar_repl2:
		move.w     bgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_repl3
		move.w     bgcolor(pc),(a1)+
		addq.w     #1,d4
drawchar_repl3:
		cmp.w      maxx-fontptrhi(a2),d4
		bhi.s      drawchar_repl4
		dbf        d3,drawchar_repl1
drawchar_repl4:
		movem.l    (a7)+,d4-d5/a1
		rol.l      #1,d0
		rts

drawchar_trans:
		nop
drawchar_trans1:
		btst       d3,d2
		beq.s      drawchar_trans2
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_trans3
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		bra.s      drawchar_trans3
drawchar_trans2:
		addq.l     #2,a1
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_trans3
		addq.l     #2,a1
		addq.w     #1,d4
drawchar_trans3:
		cmp.w      maxx-fontptrhi(a2),d4
		bhi.s      drawchar_trans4
		dbf        d3,drawchar_trans1
drawchar_trans4:
		movem.l    (a7)+,d4-d5/a1
		rol.l      #1,d0
		rts

drawchar_xor:
		nop
drawchar_xor1:
		btst       d3,d2
		beq.s      drawchar_xor2
		move.w     fgcolor(pc),d1
		eor.w      d1,(a1)+
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_xor3
		eor.w      d1,(a1)+
		addq.w     #1,d4
		bra.s      drawchar_xor3
drawchar_xor2:
		move.w     bgcolor(pc),d1
		eor.w      d1,(a1)+
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_xor3
		eor.w      d1,(a1)+
		addq.w     #1,d4
drawchar_xor3:
		cmp.w      maxx-fontptrhi(a2),d4
		bhi.s      drawchar_xor4
		dbf        d3,drawchar_xor1
drawchar_xor4:
		movem.l    (a7)+,d4-d5/a1
		rol.l      #1,d0
		rts

drawchar_erase:
		nop
drawchar_erase1:
		btst       d3,d2
		beq.s      drawchar_erase2
		addq.l     #2,a1
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_erase3
		addq.l     #2,a1
		addq.w     #1,d4
		bra.s      drawchar_erase3
drawchar_erase2:
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      text_double(pc) /* BUG 68020 only addressing mode */
		beq.s      drawchar_erase3
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
drawchar_erase3:
		cmp.w      maxx-fontptrhi(a2),d4
		bhi.s      drawchar_erase4
		dbf        d3,drawchar_erase1
drawchar_erase4:
		movem.l    (a7)+,d4-d5/a1
		rol.l      #1,d0
		rts

gemtextplanes:
		movem.l    a1-a6,-(a7)
		move.w     fontnum(pc),d0
		movea.l    0(a1,d0.w),a3
		move.l     fontptr(pc),d1
		tst.l      d1
		beq.s      gemtextplanes1
		movea.l    fontptr(pc),a3
		move.l     a3,d1
gemtextplanes1:
		move.l     font_dat_table(a3),d0
		add.l      d1,d0
		move.l     d0,LA_FBASE(a0)
		move.w     wrt_mode(pc),LA_WRT_MODE(a0)
		move.w     #-1,LA_DDA_INC(a0)
		move.w     #1,LA_T_SCLSTS(a0)
		move.w     font_flags(a3),LA_MONO_STAT(a0)
		clr.w      LA_SRCY(a0)
		move.w     font_form_width(a3),LA_FWIDTH(a0)
		move.w     font_form_height(a3),LA_DELY(a0)
		move.w     text_style(pc),LA_STYLE(a0)
		move.w     font_lighten(a3),LA_LITEMASK(a0)
		move.w     font_skew(a3),LA_SKEWMASK(a0)
		move.w     font_left_offset(a3),LA_L_OFF(a0)
		move.w     font_right_offset(a3),LA_R_OFF(a0)
		move.w     font_thicken(a3),LA_WEIGHT(a0)
		move.w     text_double(pc),LA_DOUBLE(a0)
		tst.w      LA_DOUBLE(a0)
		beq.s      gemtextplanes2
		asl.w      LA_L_OFF(a0)
		asl.w      LA_R_OFF(a0)
gemtextplanes2:
		move.w     text_rotation(pc),LA_CHUP(a0)
		move.w     fgcolor(pc),LA_TEXTFG(a0)
		move.w     bgcolor(pc),LA_TEXTBG(a0)
		lea.l      scratchbuf(pc),a6
		move.l     a6,LA_SCRTCHP(a0)
		move.w     #SCRATCHBUF_SIZE,LA_SCRPT2(a0)
		lea.l      save_clip(pc),a6
		move.w     LA_CLIP(a0),(a6)
		move.w     #0,LA_XMN_CLIP(a0)
		move.w     #0,LA_YMN_CLIP(a0)
		move.w     DEV_TAB(a0),LA_XMX_CLIP(a0)
		move.w     DEV_TAB+2(a0),LA_YMX_CLIP(a0)
		move.w     #-1,LA_CLIP(a0)
		movea.l    string_ptr(pc),a6
		lea        string_len(pc),a2
gemtextplanes3:
		tst.w      (a2)
		beq        gemtextplanes7
		/* subq.w     #1,(a2) */
		dc.w 0x0452,1 /* XXX */
		move.b     (a6)+,d0
		andi.l     #255,d0
		cmp.w      font_last_ade(a3),d0
		bgt.s      gemtextplanes3
		sub.w      font_first_ade(a3),d0
		blt.s      gemtextplanes3
		move.l     fontptr(pc),d1
		add.w      d0,d0
		movea.l    font_off_table(a3),a4
		adda.l     d1,a4
		move.w     0(a4,d0.w),LA_SRCX(a0)
		btst       #3,LA_MONO_STAT+1(a0) /* monospaced? */
		beq.s      gemtextplanes4
		move.w     font_max_cell_width(a3),LA_DELX(a0)
		bra.s      gemtextplanes5
gemtextplanes4:
		move.w     2(a4,d0.w),d1
		sub.w      0(a4,d0.w),d1
		move.w     d1,LA_DELX(a0)
gemtextplanes5:
		move.l     font_hor_table(a3),d2
		beq.s      gemtextplanes6
		move.l     fontptr(pc),d1
		add.l      d1,d2
		movea.l    d2,a5
		move.w     LA_DESTX(a0),d1
		add.w      0(a5,d0.w),d1
		move.w     d1,LA_DESTX(a0)
gemtextplanes6:
		movem.l    a0-a6,-(a7)
		lea.l      string_x(pc),a3
		move.w     (a3),LA_DESTX(a0)
		move.w     2(a3),LA_DESTY(a0)
		bsr.s      incxpos
		move.w     #0x8000,LA_XACC_DDA(a0)
		dc.w 0xa008 /* text_blt */
		movem.l    (a7)+,a0-a6
		bra        gemtextplanes3
gemtextplanes7:
		lea.l      save_clip(pc),a6
		move.w     (a6),LA_CLIP(a0)
		bra.s      gemtextplanes8
/* dead code */
		move.w     #S_hide,d0
		move.w     #1,d1
		trap       #5
		move.w     #S_screentoback,d0
		trap       #5
		move.w     #S_show,d0
		move.w     #1,d1
		trap       #5
gemtextplanes8:
		clr.l      d0
		movem.l    (a7)+,a1-a6
		rts

incxpos:
		move.w     LA_DELX(a0),d1
		move.w     LA_DOUBLE(a0),d0
		or.w       LA_STYLE(a0),d0
		tst.w      d0
		beq.s      incxpos3
		add.w      LA_WEIGHT(a0),d1
		move.w     LA_R_OFF(a0),d2
		cmpi.w     #20,LA_STYLE(a0)
		blt.s      incxpos2
		tst.w      LA_DOUBLE(a0)
		beq.s      incxpos1
		asr.w      #1,d2
		sub.w      LA_WEIGHT(a0),d1
incxpos1:
		add.w      d2,d1
incxpos2:
		tst.w      LA_DOUBLE(a0)
		beq.s      incxpos3
		asl.w      #1,d1
incxpos3:
		lea        text_rotation(pc),a2
		tst.w      (a2)
		beq.s      incxpos4
		cmpi.w     #1800,(a2)
		beq.s      incxpos4
		add.w      d1,2(a3)
		rts
incxpos4:
		add.w      d1,(a3)
		rts


init:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        initvars
		movem.l    (a7)+,d0-d7/a0-a6
		lea exit(pc),a2
		rts

exit:
		rts
		

/*
 * Syntax:   gemtext init
 */
lib1:
	dc.w	0			; no library calls
gemtext_init:
		move.l     debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     initvars_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		rts

/*
 * Syntax:   NAME$=gemfont name$
 */
lib2:
	dc.w lib2_1-lib2
	dc.w	0
gemfont_name:
		movem.l    a2-a6,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a1
		move.l     a1,-(a7)
		movem.l    a3-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		movem.l    (a7)+,a3-a6
		move.w     fontnum-entry(a3),d0
		movea.l    0(a1,d0.w),a2
		movea.l    (a7)+,a1
		move.l     (a1),d1
		tst.l      d1
		beq.s      gemfont_name1
		movea.l    d1,a2
gemfont_name1:
		addq.l     #4,a2
		movea.l    a2,a0
		clr.l      d3
gemfont_name2:
		tst.b      (a0)+
		beq.s      gemfont_name3
		addq.l     #1,d3
		bra.s      gemfont_name2
gemfont_name3:
lib2_1: jsr        L_malloc.l
		move.w     d3,(a0)+
		subq.w     #1,d3
gemfont_name4:
		move.b     (a2)+,(a0)+
		dbf        d3,gemfont_name4
gemfont_name5:
		movem.l    (a7)+,a2-a6
		move.l     a1,-(a6) /* BUG: not set */
		rts

/*
 * Syntax:   gemtext color FG,BG
 */
lib3:
	dc.w	0			; no library calls
gemtext_color:
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fgcolor-entry(a3),a1
		move.l     (a6)+,d3
		tst.l      d3
		bmi        gemtext_color1
		move.w     d3,bgcolor-fgcolor(a1)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        gemtext_color1
		move.w     d3,(a1)
		rts
gemtext_color1:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

/*
 * Syntax:   W=gemfont cellwidth
 */
lib4:
	dc.w	0			; no library calls
gemfont_cellwidth:
		movem.l    a2-a6,-(a7)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        text_double-entry(a3),a1
		move.w     (a1),d3
		lea        ctext_double(pc),a1
		move.w     d3,(a1)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a1
		move.l     a1,-(a7)
		movem.l    a3-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		movem.l    (a7)+,a3-a6
		move.w     fontnum-entry(a3),d0
		movea.l    0(a1,d0.w),a2
		move.l     (a7)+,a1
		move.l     (a1),d1
		tst.l      d1
		beq.s      gemfont_cellwidth1
		movea.l    d1,a2
gemfont_cellwidth1:
		move.w     font_max_cell_width(a2),d0
		andi.l     #0x0000FFFF,d0
		lea        ctext_double(pc),a5
		tst.w      (a5)
		beq.s      gemfont_cellwidth2
		asl.w      #1,d0
gemfont_cellwidth2:
		movem.l    (a7)+,a2-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts

ctext_double: ds.w 1

/*
 * Syntax:   gemtext mode N
 */
lib5:
	dc.w	0			; no library calls
gemtext_mode:
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        wrt_mode-entry(a3),a1
		move.l     (a6)+,d3
		tst.l      d3
		bmi        gemtext_mode1
		cmpi.l     #3,d3
		bgt        gemtext_mode1
		move.w     d3,(a1)
		rts
gemtext_mode1:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

/*
 * Syntax:   H=gemfont cellheight
 */
lib6:
	dc.w	0			; no library calls
gemfont_cellheight:
		movem.l    a2-a6,-(a7)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        text_double-entry(a3),a1
		move.w     (a1),d3
		lea        ctext_double2(pc),a1
		move.w     d3,(a1)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a1
		move.l     a1,-(a7)
		movem.l    a3-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		movem.l    (a7)+,a3-a6
		move.w     fontnum-entry(a3),d0
		movea.l    0(a1,d0.w),a2
		move.l     (a7)+,a1
		move.l     (a1),d1
		tst.l      d1
		beq.s      gemfont_cellheight1
		movea.l    d1,a2
gemfont_cellheight1:
		move.w     font_form_height(a2),d0
		andi.l     #0x0000FFFF,d0
		lea        ctext_double2(pc),a5
		tst.w      (a5)
		beq.s      gemfont_cellheight2
		asl.w      #1,d0
gemfont_cellheight2:
		movem.l    (a7)+,a2-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts

ctext_double2: ds.w 1

/*
 * Syntax:   gemtext style N
 */
lib7:
	dc.w	0			; no library calls
gemtext_style:
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        text_style-entry(a3),a1
		move.l     (a6)+,d3
		tst.l      d3
		bmi        gemtext_style1
		cmpi.l     #31,d3
		bgt        gemtext_style1
		move.w     d3,(a1)
		rts
gemtext_style1:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

/*
 * Syntax:   STRW=gemtext stringwidth(A$)
 */
lib8:
	dc.w	0			; no library calls
gemtext_stringwidth:
		move.l     (a6)+,a0
		lea        wstring_ptr(pc),a2
		move.w     (a0)+,d7
		andi.l     #$0000FFFF,d7 /* FIXME: useless */
		move.w     d7,wstring_len-wstring_ptr(a2)
		move.l     a0,(a2)
		movem.l    a2-a6,-(a7)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        text_double-entry(a3),a1
		move.w     (a1),d3
		lea        wtext_double(pc),a1
		move.w     d3,(a1)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a1
		move.l     a1,-(a7)
		movem.l    a3-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		movem.l    (a7)+,a3-a6
		move.w     fontnum-entry(a3),d0
		movea.l    0(a1,d0.w),a2
		movea.l    (a7)+,a1
		move.l     (a1),d1
		tst.l      d1 /* XXX */
		beq.s      gemtext_stringwidth1
		movea.l    d1,a2
gemtext_stringwidth1:
		movea.l    a2,a3
		move.l     font_off_table(a3),d0
		add.l      d1,d0
		movea.l    d0,a2
		lea.l      wstring_len(pc),a4
		movea.l    wstring_ptr(pc),a6
		moveq.l    #0,d3
gemtext_stringwidth2:
		tst.w      (a4)
		beq.s      gemtext_stringwidth5
		/* subq.w     #1,(a4) */
		dc.w 0x0454,1 /* XXX */
		move.b     (a6)+,d0
		andi.l     #255,d0
		cmp.w      font_last_ade(a3),d0
		bgt.s      gemtext_stringwidth2
		sub.w      font_first_ade(a3),d0
		blt.s      gemtext_stringwidth2
		btst       #3,font_flags+1(a3) /* monospaced? */
		beq.s      gemtext_stringwidth3
		add.w      font_max_cell_width(a3),d3
		bra.s      gemtext_stringwidth4
gemtext_stringwidth3:
		asl.w      #1,d0
		move.w     2(a2,d0.w),d1
		sub.w      0(a2,d0.w),d1
		add.w      d1,d3
gemtext_stringwidth4:
		bra.s      gemtext_stringwidth2
gemtext_stringwidth5:
		andi.l     #$0000FFFF,d3 /* FIXME: useless */
		lea        wtext_double(pc),a5
		tst.w      (a5)
		beq.s      gemtext_stringwidth6
		asl.w      #1,d3
gemtext_stringwidth6:
		movem.l    (a7)+,a2-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

wstring_ptr: ds.l 1
wstring_len: ds.w 1
  ds.w 1
wtext_double: ds.w 1

/*
 * Syntax:   gemtext angle N
 */
lib9:
	dc.w	0			; no library calls
gemtext_angle:
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        text_rotation-entry(a3),a1
		move.l     (a6)+,d3
		tst.l      d3
		bmi        gemtext_angle1
		cmpi.l     #270,d3
		bgt        gemtext_angle1
		andi.l     #$0000FFFF,d3
		move.l     d3,d4
		divu.w     #90,d4
		swap       d4
		tst.w      d4
		bne        gemtext_angle1
		mulu.w     #10,d3
		move.w     d3,(a1)
		rts
gemtext_angle1:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

/*
 * Syntax:   Z=gemfont convert(BNK)
 */
lib10:
	dc.w lib10_1-lib10
	dc.w	0
gemfont_convert:
		move.l     (a6)+,d3
		tst.l      d3
		beq        gemfont_convert6
		bmi        gemfont_convert6
		cmpi.l     #3,d3
		blt        gemfont_convert6
		cmpi.l     #15,d3
		bgt        gemfont_convert6
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    a0-a5,-(a7)
		move.l     d3,-(a6)
lib10_1:		jsr        L_addrofbank.l
		movea.l    d3,a0
		movea.l    a0,a1
		moveq.l    #0,d3
		cmpi.l     #0x56444946,(a0) /* 'VDIF' */
		bne.s      gemfont_convert1
		cmpi.w     #0x6E54,4(a0) /* 'nT' */
		bne.s      gemfont_convert1
		bra        gemfont_convert4 /* already converted */
gemfont_convert1:
		lea.l      gemtext_id(pc),a5
		move.w     #(gemtext_id_end-gemtext_id-1),d7
		addq.l     #2,a0
gemfont_convert2:
		cmpm.b     (a0)+,(a5)+
		bne        gemfont_convert5
		subq.w     #1,d7
		bne.s      gemfont_convert2
		movea.l    a1,a0
		lea.l      22(a0),a0
		move.l     font_hor_table(a0),d0
		subi.l     #22,d0
		move.l     d0,font_hor_table(a0)
		move.l     font_off_table(a0),d0
		subi.l     #22,d0
		move.l     d0,font_off_table(a0)
		move.l     font_dat_table(a0),d0
		subi.l     #22,d0
		move.l     d0,font_dat_table(a0)
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d2
		moveq.l    #0,d3
		move.w     font_form_width(a0),d0
		mulu.w     font_form_height(a0),d0
		addi.l     #sizeof_FONTHDR+2,d0
		move.w     font_last_ade(a0),d3
		sub.w      font_first_ade(a0),d3
		addq.w     #1,d3
		move.l     font_hor_table(a0),d1
		beq.s      gemfont_convert2_1
		add.l      d3,d0
gemfont_convert2_1:
		move.l     font_off_table(a0),d2
		add.l      d3,d0
		add.l      d3,d0
		move.b     #'V',(a1)+
		move.b     #'D',(a1)+
		move.b     #'I',(a1)+
		move.b     #'F',(a1)+
		move.b     #'n',(a1)+
		move.b     #'T',(a1)+
		move.w     #1,(a1)+ /* number of fonts */
		move.l     #16,(a1)+ /* size of header */
		move.l     d0,(a1)+ /* size of data */
gemfont_convert3:
		move.b     (a0)+,(a1)+
		subq.l     #1,d0
		bne.s      gemfont_convert3
gemfont_convert4:
		moveq.l    #-1,d3
gemfont_convert5:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts
gemfont_convert6:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

gemtext_id:
		dc.b 'STOS GEM FONT 110553'
gemtext_id_end:
		dc.b 0
		.even

/*
 * Syntax:   gemtext font N
 *           gemtext font B,N
 */
lib11:
	dc.w lib11_1-lib11
	dc.w lib11_2-lib11
	dc.w	0
gemtext_font:
		cmpi.w     #1,d0
		beq.s      gemtext_font1
		cmpi.w     #2,d0
		beq        gemtext_font5
		rts
gemtext_font1:
		move.l     (a6)+,d3
		tst.l      d3
		beq        gemtext_font10
		bmi        gemtext_font10
		cmpi.l     #1,d3
		blt        gemtext_font10
		cmpi.l     #15,d3
		bgt        gemtext_font10
		movem.l    d1-d7/a0-a6,-(a7)
		andi.l     #15,d3
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a0
		lea        fontnum-entry(a3),a1
		lea        fontbankptr-entry(a3),a2
		clr.l      (a0)
		clr.w      (a1)
		cmpi.w     #3,d3
		ble.w      gemtext_font3 /* XXX */
		movem.l    a0-a3,-(a7)
		move.l     d3,-(a6)
lib11_1:		jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a3
		movea.l    d3,a4
		cmpi.l     #0x56444946,(a4) /* 'VDIF' */
		bne.s      gemtext_font2
		cmpi.w     #0x6E54,4(a4) /* 'nT' */
		bne.s      gemtext_font2
		move.l     a4,(a2)
		movea.l    8(a4),a2 /* get offset to data */
		adda.l     a2,a4
		move.l     a4,(a0)+
		move.w     #0,(a0) /* fontnum */
		bra.s      gemtext_font4
gemtext_font2:
		clr.l      (a2)
		clr.l      (a0)+
		move.w     #4,(a0) /* fontnum */
		bra.s      gemtext_font4
gemtext_font3:
		clr.l      (a2)
		clr.l      (a0)+
		subq.w     #1,d3
		asl.w      #2,d3
		move.w     d3,(a0)
gemtext_font4:
		movem.l    (a7)+,d1-d7/a0-a6
		rts
gemtext_font5:
		move.l     (a6)+,d5
		tst.l      d5
		beq        gemtext_font10
		bmi        gemtext_font10
		cmpi.l     #1,d5
		blt        gemtext_font10
		cmpi.l     #15,d5
		bgt        gemtext_font10
		andi.l     #15,d5
		move.l     (a6)+,d3
		tst.l      d3
		beq.w      gemtext_font10 /* XXX */
		bmi.w      gemtext_font10 /* XXX */
		cmpi.l     #1,d3
		blt        gemtext_font10
		cmpi.l     #15,d3
		bgt        gemtext_font10
		andi.l     #15,d3
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a0
		lea        fontnum-entry(a3),a1
		lea        fontbankptr-entry(a3),a2
		clr.l      (a0)
		clr.w      (a1)
		movem.l    a0-a3,-(a7)
		move.l     d3,-(a6)
lib11_2:		jsr        L_addrofbank.l
		movem.l    (a7)+,a0-a3
		movea.l    d3,a4
		cmpi.l     #0x56444946,(a4) /* 'VDIF' */
		bne        gemtext_font2
		cmpi.w     #0x6E54,4(a4) /* 'nT' */
		bne        gemtext_font2
gemtext_font6:
		move.l     a4,(a2)
		move.w     6(a4),d6
		cmp.w      d5,d6
		bpl.s      gemtext_font8
		move.w     d6,d5
gemtext_font8:
		subq.w     #1,d5
		asl.w      #3,d5
		movea.l    8(a4,d5.w),a2 /* get offset to data */
		adda.l     a2,a4
		move.l     a4,(a0)+
		move.w     #0,(a0) /* fontnum */
gemtext_font7:
		movem.l    (a7)+,d1-d7/a0-a6
		rts
gemtext_font10:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

/*
 * Syntax:   gemfont info
 */
lib12:
	dc.w	0			; no library calls
gemfont_info:
		movem.l    d1-d7/a0-a6,-(a7)
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        fontptr-entry(a3),a1
		move.l     a1,-(a7)
		movem.l    a3-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		movem.l    (a7)+,a3-a6
		move.w     fontnum-entry(a3),d0
		move.l     0(a1,d0.w),d0
		movea.l    (a7)+,a1
		move.l     (a1),d1
		tst.l      d1
		beq.s      gemfont_info1
		move.l     d1,d0
gemfont_info1:
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts

/*
 * Syntax:   gemtext scale N
 */
lib13:
	dc.w	0			; no library calls
gemtext_scale:
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        text_double-entry(a3),a1
		move.l     (a6)+,d3
		move.w     d3,(a1)
		rts

lib14:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   gemtext X,Y,A$
 */
lib15:
	dc.w	0			; no library calls
gemtext:
		movea.l    debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        string_len-entry(a3),a1
		move.l     (a6)+,a2
		move.w     (a2),(a1)
		addq.l     #2,a2
		move.l     a2,string_ptr-string_len(a1)
		lea        string_x-entry(a3),a1
		move.l     (a6)+,d3
		ext.l      d3
		tst.l      d3
		bmi        gemtexterr
		andi.l     #0x00007FFF,d3 /* FIXME: useless */
		move.w     d3,string_y-string_x(a1)
		move.l     (a6)+,d3
		ext.l      d3
		tst.l      d3
		bmi        gemtexterr
		andi.l     #0x00007FFF,d3 /* FIXME: useless */
		move.w     d3,(a1)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     gemtext_offset-entry(a0),d0
		add.l      d0,a0
		jsr        (a0)
		rts
gemtexterr:
		moveq      #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

lib16:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   gemfont load FILENAME$,BNK
 */
lib17:
	dc.w lib17_1-lib17
	dc.w lib17_2-lib17
	dc.w lib17_3-lib17
	dc.w lib17_4-lib17
	dc.w lib17_5-lib17
	dc.w	0
gemfont_load:
		move.l     (a6)+,d3
		/* FIXME: checks removed */
		andi.l     #15,d3
		lea.l      loadbnk(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    d3,a0
		moveq.l    #0,d3
		move.w     (a0)+,d3
		subq.l     #1,d3
		lea.l      filename(pc),a1
gemfont_load1:
		move.b     (a0)+,(a1)+
		dbf        d3,gemfont_load1
		move.b     #0,(a1)
		moveq.l    #0,d3
		move.w     loadbnk(pc),d3
lib17_1: jsr L_effbank.l
lib17_2: jsr L_resbis.L
		move.w     #47,-(a7) /* Fgetdta */
		trap       #1
		addq.l     #2,a7
		lea.l      dtaptr(pc),a3
		move.l     d0,(a3)
		move.w     #-1,-(a7)
		pea.l      filename(pc)
		move.w     #78,-(a7) /* Fsfirst */
		trap       #1
		addq.l     #8,a7
		tst.l      d0
		beq.s      gemfont_load2
		moveq.l    #-1,d0
gemfont_load2:
		not.l      d0
		tst.l      d0
		beq        gemfont_load4
		movea.l    dtaptr(pc),a0
		move.l     26(a0),d3
		andi.l     #0x7FFFFFFF,d3 /* FIXME: useless */
		lea.l      filesize(pc),a0
		move.l     d3,(a0)
		lea.l      filename(pc),a0
		clr.w      -(a7)
		move.l     a0,-(a7)
		move.w     #61,-(a7) /* Fopen */
		trap       #1
		addq.l     #8,a7
		lea        filehandle(pc),a0
		move.w     d0,(a0)
		tst.w      d0
		bmi        gemfont_load5
		move.l     filesize(pc),d3
		addi.l     #16,d3
		move.w     #0x0081,d1 /* reserve as data bank */
		moveq.l    #0,d2
		move.w     loadbnk(pc),d2
lib17_3: jsr L_reservin.l
lib17_4: jsr L_resbis.l
		moveq.l    #0,d3
		move.w     loadbnk(pc),d3
		move.l     d3,-(a6)
lib17_5:	jsr        L_addrofbank.l
		lea.l      loadbnkptr(pc),a0
		move.l     d3,(a0)
		movea.l    loadbnkptr(pc),a0
		movea.l    a0,a1
		moveq.l    #31,d7
gemfont_load3:
		move.l     #0,(a1)+
		dbf        d7,gemfont_load3
		move.b     #'V',(a0)+
		move.b     #'D',(a0)+
		move.b     #'I',(a0)+
		move.b     #'F',(a0)+
		move.b     #'n',(a0)+
		move.b     #'T',(a0)+
		move.w     #1,(a0)+
		move.l     #16,(a0)+
		move.l     filesize(pc),d0
		move.l     d0,(a0)+
		movea.l    loadbnkptr(pc),a0
		lea.l      16(a0),a0
		move.l     a0,-(a7)
		move.l     d0,-(a7)
		move.w     filehandle(pc),-(a7)
		move.w     #63,-(a7) /* Fread */
		trap       #1
		lea.l      12(a7),a7
		tst.l      d0
		bmi.s      gemfont_load5 /* BUG: filehandle not closed */
		move.w     filehandle(pc),-(a7)
		move.w     #62,-(a7) /* Fclose */
		trap       #1
		addq.l     #4,a7
		movea.l    loadbnkptr(pc),a0
		lea.l      16(a0),a0
		bsr.w      swap_font /* XXX */
		movem.l    (a7)+,d0-d7/a0-a6
		rts
gemfont_load4:
		movem.l    (a7)+,d0-d7/a0-a6
		moveq.l    #E_noent,d0
		move.l     error(a5),a0
		jmp        (a0)
gemfont_load5:
		movem.l    (a7)+,d0-d7/a0-a6
		moveq.l    #E_diskerror,d0
		move.l     error(a5),a0
		jmp        (a0)


swap_font:
		btst       #2,font_flags+1(a0) /* motorola format? */
		beq.s      swap_font1
		rts
swap_font1:
		move.w     ZERO(a0),d0 /* XXX font_id */
		ror.w      #8,d0
		move.w     d0,ZERO(a0)
		move.w     font_point(a0),d0
		ror.w      #8,d0
		move.w     d0,font_point(a0)
		move.w     font_first_ade(a0),d0
		ror.w      #8,d0
		move.w     d0,font_first_ade(a0)
		move.w     font_last_ade(a0),d0
		ror.w      #8,d0
		move.w     d0,font_last_ade(a0)
		move.w     font_top(a0),d0
		ror.w      #8,d0
		move.w     d0,font_top(a0)
		move.w     font_ascent(a0),d0
		ror.w      #8,d0
		move.w     d0,font_ascent(a0)
		move.w     font_half(a0),d0
		ror.w      #8,d0
		move.w     d0,font_half(a0)
		move.w     font_descent(a0),d0
		ror.w      #8,d0
		move.w     d0,font_descent(a0)
		move.w     font_max_char_width(a0),d0
		ror.w      #8,d0
		move.w     d0,font_max_char_width(a0)
		move.w     font_max_cell_width(a0),d0
		ror.w      #8,d0
		move.w     d0,font_max_cell_width(a0)
		move.w     font_left_offset(a0),d0
		ror.w      #8,d0
		move.w     d0,font_left_offset(a0)
		move.w     font_right_offset(a0),d0
		ror.w      #8,d0
		move.w     d0,font_right_offset(a0)
		move.w     font_thicken(a0),d0
		ror.w      #8,d0
		move.w     d0,font_thicken(a0)
		move.w     font_ul_size(a0),d0
		ror.w      #8,d0
		move.w     d0,font_ul_size(a0)
		move.w     font_lighten(a0),d0
		ror.w      #8,d0
		move.w     d0,font_lighten(a0)
		move.w     font_skew(a0),d0
		ror.w      #8,d0
		move.w     d0,font_skew(a0)
		move.l     font_hor_table(a0),d0
		ror.w      #8,d0
		ror.l      #8,d0
		ror.l      #8,d0
		ror.w      #8,d0
		move.l     d0,font_hor_table(a0)
		move.l     font_off_table(a0),d0
		ror.w      #8,d0
		ror.l      #8,d0
		ror.l      #8,d0
		ror.w      #8,d0
		move.l     d0,font_off_table(a0)
		move.l     font_dat_table(a0),d0
		ror.w      #8,d0
		ror.l      #8,d0
		ror.l      #8,d0
		ror.w      #8,d0
		move.l     d0,font_dat_table(a0)
		move.w     font_form_width(a0),d0
		ror.w      #8,d0
		move.w     d0,font_form_width(a0)
		move.w     font_form_height(a0),d0
		ror.w      #8,d0
		move.w     d0,font_form_height(a0)
		movea.l    font_off_table(a0),a1
		adda.l     a0,a1
		move.w     font_last_ade(a0),d7
		sub.w      font_first_ade(a0),d7
		subq.w     #1,d7 /* BUG */
swap_font2:
		move.w     (a1),d0
		ror.w      #8,d0
		move.w     d0,(a1)+
		dbf        d7,swap_font2
		rts

loadbnk: ds.w 1 /* 137f0 */
loadbnkptr: ds.l 1 /* 137f2 */
dtaptr: ds.l 1 /* 137f6 */
filehandle: ds.w 1 /* 137fa */
filesize: ds.l 1 /* 137fc */
filename: ds.b 128


libex:
	ds.w 1

ZERO equ 0
