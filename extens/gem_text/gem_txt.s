		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "tokens.inc"

SCRATCHBUF_SIZE equ 1024

MD_REPLACE = 0
MD_TRANS   = 1

TXT_LIGHT = 2

		.text

        bra.w load

        dc.b $80
tokens:
		dc.b "gemtext init",$80
		dc.b "gemfont name$",$81
		dc.b "gemtext color",$82
		dc.b "gemfont cellwidth",$83
		dc.b "gemtext mode",$84
		dc.b "gemfont cellheight",$85
		dc.b "gemtext style",$86
		dc.b "gemtext stringwidth",$87
		dc.b "gemtext angle",$88
		dc.b "gemfont convert",$89
		dc.b "gemtext font",$8a
		dc.b "gemfont info",$8b
		dc.b "gemtext scale",$8c
		/* $8d unused */
		dc.b "gemtext",$8e
		/* $8f unused */
		dc.b "gemfont load",$90
		/* $91 unused */
		dc.b "gemfont cmds",$92
        dc.b 0
        even

jumps:  dc.w 19
		dc.l gemtext_init
		dc.l gemfont_name
		dc.l gemtext_color
		dc.l gemfont_cellwidth
		dc.l gemtext_mode
		dc.l gemfont_cellheight
		dc.l gemtext_style
		dc.l gemtext_stringwidth
		dc.l gemtext_angle
		dc.l gemfont_convert
		dc.l gemtext_font
		dc.l gemfont_info
		dc.l gemtext_scale
		dc.l dummy
		dc.l gemtext
		dc.l dummy
		dc.l gemfont_load
		dc.l dummy
		dc.l gemfont_cmds


welcome:
		dc.b 10
		dc.b "ST(e)/TT/Falcon 030 Gemtext v0.9b ",$bd," Anthony Hoskin. [type 'gemfont cmds']",0
		dc.b 10
		dc.b "ST(e)/TT/Falcon 030 GemText v0.9b ",$bd," Anthony Hoskin. [type 'gemfont cmds']",0
		.even

load:
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts

cold:
		move.l     a0,table
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		lea.l      mode(pc),a0
		move.w     d0,(a0)
		bsr        warm
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		rts

warm:
		move.l     a0,-(a7)
		lea.l      fontptr(pc),a0
		clr.l      (a0)+
		move.l     #0x00040000,(a0)+ /* fontnum/text_style */
		move.l     #0x00010000,(a0)+ /* fgcolor/bgcolor */
		clr.l      (a0)+             /* wrt_mode/text_rotation */
		clr.w      (a0)+             /* text_double */
		clr.l      (a0)+             /* string_x/string_y */
		movea.l    (a7)+,a0
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

addrofbank:
		movem.l    a0-a2,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_addrofbank(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a2
		rts

reserve:
		movem.l    d0-d7/a1-a6,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_extjumps(a0),a0
		movea.l    4*(T_exti_reserve-$70)(a0),a0
		jsr        130(a0) /* calls reserve_entry in interpreter */
		movem.l    (a7)+,d0-d7/a1-a6
		rts

erase:
		movem.l    d0-d7/a1-a2,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_extjumps(a0),a0
		movea.l    4*(T_exti_erase-$70)(a0),a0
		jsr        20(a0) /* calls erase_entry in interpreter */
		movem.l    (a7)+,d0-d7/a1-a2
		rts

dummy:

syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
illfunc:
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0
		bra.s      goerror
enoent:
		moveq.l    #E_noent,d0
		bra.s      goerror
diskerror:
		moveq.l    #E_diskerror,d0

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

/*
 * Syntax:   gemtext init
 */
gemtext_init:
		tst.w      d0
		bne.s      syntax
		movem.l    a0-a6,-(a7)
		lea.l      fontbankptr(pc),a0
		clr.l      (a0)
		lea.l      fontptr(pc),a0
		clr.l      (a0)+
		move.l     #0x00040000,(a0)+ /* fontnum/text_style */
		move.l     #0x00010000,(a0)+ /* fgcolor/bgcolor */
		clr.l      (a0)+             /* wrt_mode/text_rotation */
		clr.w      (a0)+             /* text_double */
		clr.l      (a0)+             /* string_x/string_y */
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   NAME$=gemfont name$
 */
gemfont_name:
		tst.w      d0
		bne        syntax
		movem.l    a1-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		move.w     fontnum(pc),d0
		movea.l    0(a1,d0.w),a2
		move.l     fontptr(pc),d1
		beq.s      gemfont_name1
		movea.l    d1,a2
gemfont_name1:
		addq.l     #4,a2
		movea.l    a2,a3
		lea.l      scratchbuf(pc),a0
		movea.l    a0,a1
		moveq.l    #0,d3
		tst.b     (a2)
		bne.s      gemfont_name2
		move.w     #1,(a0)+
		move.b     #' ',(a0)+
		bra.s      gemfont_name5
gemfont_name2:
		cmpi.w     #' ',d3
		beq.s      gemfont_name3
		tst.b     (a2)+
		beq.s      gemfont_name3
		addq.w     #1,d3
		bra.s      gemfont_name2
gemfont_name3:
		move.w     d3,(a0)+
		subq.w     #1,d3
gemfont_name4:
		move.b     (a3)+,(a0)+
		dbf        d3,gemfont_name4
gemfont_name5:
		clr.b      (a0)+
		move.l     a1,d3
		move.w     #128,d2 ; returns string
		movem.l    (a7)+,a1-a6
		rts

/*
 * Syntax:   gemtext color FG,BG
 */
gemtext_color:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		move.w     d3,bgcolor
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		move.w     d3,fgcolor
		jmp        (a1)

/*
 * Syntax:   W=gemfont cellwidth
 */
gemfont_cellwidth:
		tst.w      d0
		bne        syntax
		movem.l    a1-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		move.w     fontnum(pc),d0
		movea.l    0(a1,d0.w),a3
		move.l     fontptr(pc),d1
		tst.l      d1
		beq.s      gemfont_cellwidth1
		movea.l    d1,a3
gemfont_cellwidth1:
		moveq      #0,d3
		move.w     font_max_cell_width(a3),d3
		tst.w      text_double
		beq.s      gemfont_cellwidth2
		asl.w      #1,d3
gemfont_cellwidth2:
		movem.l    (a7)+,a1-a6
		clr.l      d2
		rts

/*
 * Syntax:   gemtext mode N
 */
gemtext_mode:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.w     #3,d3
		bgt        illfunc
		move.w     d3,wrt_mode
		jmp        (a1)

/*
 * Syntax:   H=gemfont cellheight
 */
gemfont_cellheight:
		tst.w      d0
		bne        syntax
		movem.l    a1-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		move.w     fontnum(pc),d0
		movea.l    0(a1,d0.w),a3
		move.l     fontptr(pc),d1
		tst.l      d1
		beq.s      gemfont_cellheight1
		movea.l    d1,a3
gemfont_cellheight1:
		moveq      #0,d3
		move.w     font_form_height(a3),d3
		tst.w      text_double
		beq.s      gemfont_cellheight2
		asl.w      #1,d3
gemfont_cellheight2:
		movem.l    (a7)+,a1-a6
		clr.l      d2
		rts

/*
 * Syntax:   gemtext style N
 */
gemtext_style:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.w     #31,d3
		bgt        illfunc
		move.w     d3,text_style
		jmp        (a1)

/*
 * Syntax:   STRW=gemtext stringwidth(A$)
 */
gemtext_stringwidth:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getstring
		move.l     a1,-(a7)
		movem.l    a1-a6,-(a7)
		movea.l    d3,a4
		move.w     (a4)+,d7
		dc.w 0xa000 /* linea_init */
		move.w     fontnum(pc),d0
		movea.l    0(a1,d0.w),a5
		move.l     fontptr(pc),d1
		beq.s      gemtext_stringwidth1
		movea.l    d1,a5
gemtext_stringwidth1:
		move.l     font_off_table(a5),d0
		add.l      d1,d0
		movea.l    d0,a2
		moveq.l    #0,d3
gemtext_stringwidth2:
		tst.w      d7
		beq.s      gemtext_stringwidth5
		subq.w     #1,d7
		moveq      #0,d0
		move.b     (a4)+,d0
		cmp.w      font_last_ade(a5),d0
		bgt.s      gemtext_stringwidth2
		sub.w      font_first_ade(a5),d0
		blt.s      gemtext_stringwidth2
		btst       #FONTF_MONOSPACED,font_flags+1(a5) /* monospaced? */
		beq.s      gemtext_stringwidth3
		add.w      font_max_cell_width(a5),d3
		bra.s      gemtext_stringwidth4
gemtext_stringwidth3:
		asl.w      #1,d0
		move.w     2(a2,d0.w),d1
		sub.w      0(a2,d0.w),d1
		add.w      d1,d3
gemtext_stringwidth4:
		bra.s      gemtext_stringwidth2
gemtext_stringwidth5:
		move.w     text_double(pc),d2
		beq.s      gemtext_stringwidth6
		asl.w      #1,d3
gemtext_stringwidth6:
		movem.l    (a7)+,a1-a6
		clr.l      d2
		rts

/*
 * Syntax:   gemtext angle N
 */
gemtext_angle:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #270,d3
		bgt        illfunc
		andi.l     #$0000FFFF,d3
		move.l     d3,d4
		divu.w     #90,d4
		swap       d4
		tst.w      d4
		bne        illfunc
		mulu.w     #10,d3
		move.w     d3,text_rotation
		jmp        (a1)

/*
 * Syntax:   Z=gemfont convert(BNK)
 */
gemfont_convert:
		move.l     (a7)+,a1
		subq.w      #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7)
		tst.l      d3
		ble        illfunc
		cmpi.l     #3,d3
		blt        illfunc
		cmpi.l     #15,d3
		bgt        illfunc
		movem.l    a1-a6,-(a7)
		bsr        addrofbank
		movea.l    d3,a0
		movea.l    a0,a1
		moveq.l    #0,d3
		cmpi.l     #0x56444946,(a0) /* 'VDIF' */
		bne.s      gemfont_convert1
		cmpi.w     #0x6E54,4(a0) /* 'nT' */
		beq        gemfont_convert4 /* already converted */
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
		move.w     font_form_width(a0),d0
		mulu.w     font_form_height(a0),d0
		addi.l     #sizeof_FONTHDR+2,d0
		moveq.l    #0,d3
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
		movem.l    (a7)+,a1-a6
		clr.l      d2
		rts

/*
 * Syntax:   gemtext font N
 *           gemtext font B,N
 */
gemtext_font:
		move.l     (a7)+,a1
		subq.w     #1,d0
		beq.s      gemtext_font1
		subq.w     #1,d0
		beq        gemtext_font5
		bra        syntax
gemtext_font1:
		bsr        getinteger
		move.l     a1,-(a7)
		tst.l      d3
		bmi        illfunc
		cmpi.l     #1,d3
		blt        illfunc
		cmpi.l     #15,d3
		bgt        illfunc
		movem.l    a1-a6,-(a7)
		andi.w     #15,d3
		cmpi.w     #3,d3
		ble.s      gemtext_font3
		bsr        addrofbank
		movea.l    d3,a1
		cmpi.l     #0x56444946,(a1) /* 'VDIF' */
		bne.s      gemtext_font2
		cmpi.w     #0x6E54,4(a1) /* 'nT' */
		bne.s      gemtext_font2
		lea.l      fontbankptr(pc),a0
		move.l     a1,(a0)
		lea.l      fontptr(pc),a0
		movea.l    8(a1),a2 /* get offset to data */
		adda.l     a2,a1
		move.l     a1,(a0)+
		clr.w      (a0) /* fontnum */
		bra.s      gemtext_font4
gemtext_font2:
		lea.l      fontbankptr(pc),a0
		clr.l      (a0)
		lea.l      fontptr(pc),a0
		clr.l      (a0)+
		move.w     #4,(a0) /* fontnum */
		bra.s      gemtext_font4
gemtext_font3:
		lea.l      fontbankptr(pc),a0
		clr.l      (a0)
		lea.l      fontptr(pc),a0
		clr.l      (a0)+
		subq.w     #1,d3
		asl.w      #2,d3
		move.w     d3,(a0)
gemtext_font4:
		movem.l    (a7)+,a1-a6
		rts
gemtext_font5:
		bsr        getinteger
		tst.l      d3
		ble        illfunc
		cmpi.l     #1,d3
		blt        illfunc
		cmpi.l     #15,d3
		bgt        illfunc
		andi.l     #15,d3
		move.l     d3,d5
		bsr        getinteger
		move.l     a1,-(a7)
		tst.l      d3
		ble        illfunc
		cmpi.l     #1,d3
		blt        illfunc
		cmpi.l     #15,d3
		bgt        illfunc
		movem.l    a1-a6,-(a7)
		bsr        addrofbank
		movea.l    d3,a1
		cmpi.l     #0x56444946,(a1) /* 'VDIF' */
		bne.s      gemtext_font6
		cmpi.w     #0x6E54,4(a1) /* 'nT' */
		beq.s      gemtext_font7
gemtext_font6:
		lea.l      fontbankptr(pc),a0
		clr.l      (a0)
		lea.l      fontptr(pc),a0
		clr.l      (a0)+
		move.w     #4,(a0) /* fontnum */
		bra.s      gemtext_font9
gemtext_font7:
		lea.l      fontbankptr(pc),a0
		move.l     a1,(a0)
		lea.l      fontptr(pc),a0
		move.w     6(a1),d6
		cmp.w      d5,d6
		bpl.s      gemtext_font8
		move.w     d6,d5
gemtext_font8:
		subq.w     #1,d5
		asl.w      #3,d5
		movea.l    8(a1,d5.w),a2 /* get offset to data */
		adda.l     a2,a1
		move.l     a1,(a0)+
		clr.w      (a0) /* fontnum */
gemtext_font9:
		movem.l    (a7)+,a1-a6
		rts

/*
 * Syntax:   X=gemfont info
 */
gemfont_info:
		tst.w      d0
		bne        syntax
		movem.l    a1-a6,-(a7)
		dc.w 0xa000 /* linea_init */
		move.w     fontnum(pc),d0
		move.l     0(a1,d0.w),d3
		move.l     fontptr(pc),d1
		beq.s      gemfont_info1
		move.l     d1,d3
gemfont_info1:
		movem.l    (a7)+,a1-a6
		clr.l      d2
		rts

/*
 * Syntax:   gemtext scale N
 */
gemtext_scale:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,text_double
		jmp        (a1)

/*
 * Syntax:   gemtext X,Y,A$
 */
gemtext:
		move.l     (a7)+,a1
		subq.w     #3,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a0
		move.w     (a0)+,d7
		move.l     a0,string_ptr
		bsr        getinteger
		tst.w      d3
		bmi        illfunc
		move.w     d3,string_y
		bsr        getinteger
		tst.w      d3
		bmi        illfunc
		move.w     d3,string_x
		move.l     a1,-(a7)
		dc.w 0xa000 /* linea_init */
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      gemtext1
		bsr.s      gemtexthi
		rts
gemtext1:
		bsr        gemtextplanes
		rts

gemtexthi:
		movem.l    a1-a6,-(a7)
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		lea.l      fontptrhi(pc),a2
		move.l     d0,logic-fontptrhi(a2)
		dc.w 0xa000 /* linea_init */
		lea.l      fontptrhi(pc),a2
		move.w     V_BYTES_LIN(a0),bytes_lin-fontptrhi(a2)
		movem.w    DEV_TAB(a0),d0-d1
		move.w     d0,maxx-fontptrhi(a2)
		move.w     d1,maxy-fontptrhi(a2)
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
		tst.w      d7
		beq        gemtexthi10
		subq.w     #1,d7
		moveq      #0,d0
		move.b     (a6)+,d0
		cmp.w      font_last_ade(a3),d0
		bgt.s      gemtexthi2
		sub.w      font_first_ade(a3),d0
		blt.s      gemtexthi2
		lea.l      fontptrhi(pc),a2
		movea.l    logic-fontptrhi(a2),a1
		movea.l    offtablehi-fontptrhi(a2),a4
		add.w      d0,d0
		move.w     0(a4,d0.w),charoffhi-fontptrhi(a2)
		btst       #FONTF_MONOSPACED,font_flags+1(a3) /* monospaced? */
		beq.s      gemtexthi3
		move.w     font_max_cell_width(a3),charwhi-fontptrhi(a2)
		bra.s      gemtexthi4
gemtexthi3:
		move.w     2(a4,d0.w),d1
		sub.w      0(a4,d0.w),d1
		move.w     d1,charwhi-fontptrhi(a2)
gemtexthi4:
		movem.l    d6-d7/a2-a6,-(a7)
		move.w     (a5),d4
		move.w     2(a5),d5
		cmp.w      maxy(pc),d5
		bhi.s      gemtexthi9
		cmp.w      maxx(pc),d4
		bhi.s      gemtexthi9
		asl.w      #1,d4
		mulu.w     bytes_lin(pc),d5
		adda.l     d5,a1
		adda.w     d4,a1
		move.l     #0x55555555,d0 /* FIXME: use font_lighten from font header */
		btst       #1,text_style+1(pc) /* light text? */
		bne.s      gemtexthi5
		moveq.l    #-1,d0
gemtexthi5:
		move.w     (a5),d4
		move.w     2(a5),d5
		movea.l    dattablehi(pc),a0
		move.w     formhhi-fontptrhi(a2),d7
		subq.w     #1,d7
gemtexthi6:
		bsr.s      drawchar
		move.w     text_double(pc),d1
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
		move.w     text_double(pc),d0
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

drawchar:
		movem.l    d4-d5/a1,-(a7)
		moveq.l    #0,d1
		moveq.l    #0,d3
		move.w     charwhi-fontptrhi(a2),d3
		move.w     charoffhi-fontptrhi(a2),d1
		bfextu     (a0){d1:d3},d2 ; 68020+ only
		and.l      d0,d2
		btst       #0,text_style+1(pc) /* bold? */
		beq.s      drawchar1
		move.l     d2,d1
		asr.l      #1,d1
		or.l       d1,d2
drawchar1:
		move.w     text_double(pc),d5
		subq.w     #1,d3
		move.w     wrt_mode(pc),d5
		beq.s      drawchar_repl
		subq.w     #1,d5
		beq.s      drawchar_trans
		subq.w     #1,d5
		beq        drawchar_xor
		subq.w     #1,d5
		beq        drawchar_erase

drawchar_repl:
drawchar_repl1:
		btst       d3,d2
		beq.s      drawchar_repl2
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      d5
		beq.s      drawchar_repl3
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		bra.s      drawchar_repl3
drawchar_repl2:
		move.w     bgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      d5
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
drawchar_trans1:
		btst       d3,d2
		beq.s      drawchar_trans2
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      d5
		beq.s      drawchar_trans3
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		bra.s      drawchar_trans3
drawchar_trans2:
		addq.l     #2,a1
		addq.w     #1,d4
		tst.w      d5
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
drawchar_xor1:
		btst       d3,d2
		beq.s      drawchar_xor2
		move.w     fgcolor(pc),d1
		eor.w      d1,(a1)+
		addq.w     #1,d4
		tst.w      d5
		beq.s      drawchar_xor3
		eor.w      d1,(a1)+
		addq.w     #1,d4
		bra.s      drawchar_xor3
drawchar_xor2:
		move.w     bgcolor(pc),d1
		eor.w      d1,(a1)+
		addq.w     #1,d4
		tst.w      d5
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
drawchar_erase1:
		btst       d3,d2
		beq.s      drawchar_erase2
		addq.l     #2,a1
		addq.w     #1,d4
		tst.w      d5
		beq.s      drawchar_erase3
		addq.l     #2,a1
		addq.w     #1,d4
		bra.s      drawchar_erase3
drawchar_erase2:
		move.w     fgcolor(pc),(a1)+
		addq.w     #1,d4
		tst.w      d5
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
		clr.l      LA_XMN_CLIP(a0)
		movem.w    DEV_TAB(a0),d0-d1
		movem.w    d0-d1,LA_XMX_CLIP(a0)
		move.w     #-1,LA_CLIP(a0)
		movea.l    string_ptr(pc),a6
gemtextplanes3:
		tst.w      d7
		beq        gemtextplanes7
		subq.w     #1,d7
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
		btst       #FONTF_MONOSPACED,LA_MONO_STAT+1(a0) /* monospaced? */
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
		.IFNE 0
		move.w     #S_hide,d0
		move.w     #1,d1
		trap       #5
		move.w     #S_screentoback,d0
		trap       #5
		move.w     #S_show,d0
		move.w     #1,d1
		trap       #5
		.ENDC
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
		tst.w      text_rotation
		beq.s      incxpos4
		cmpi.w     #1800,text_rotation
		beq.s      incxpos4
		add.w      d1,2(a3)
		rts
incxpos4:
		add.w      d1,(a3)
		rts

/*
 * Syntax:   gemfont load FILENAME$,BNK
 */
gemfont_load:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		beq        illfunc
		cmpi.l     #15,d3
		bgt        illfunc
		lea.l      loadbnk(pc),a0
		move.w     d3,(a0)
		bsr        getstring
		move.l     a1,-(a7)
		movea.l    d3,a0
		moveq.l    #0,d3
		move.w     (a0)+,d3
		subq.l     #1,d3
		lea.l      filename(pc),a1
gemfont_load1:
		move.b     (a0)+,(a1)+
		dbf        d3,gemfont_load1
		clr.b      (a1)
		movem.l    a0-a6,-(a7)
		moveq.l    #0,d3
		move.w     loadbnk(pc),d3
		bsr        erase
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
		lea.l      filesize(pc),a0
		move.l     d3,(a0)
		lea.l      filename(pc),a0
		clr.w      -(a7)
		move.l     a0,-(a7)
		move.w     #61,-(a7) /* Fopen */
		trap       #1
		addq.l     #8,a7
		move.w     d0,filehandle
		tst.w      d0
		bmi        gemfont_load5
		move.l     filesize(pc),d3
		addi.l     #16,d3
		move.w     #0x0081,d1 /* reserve as data bank */
		moveq.l    #0,d2
		move.w     loadbnk(pc),d2
		bsr        reserve
		moveq.l    #0,d3
		move.w     loadbnk(pc),d3
		bsr        addrofbank
		lea.l      loadbnkptr(pc),a0
		move.l     d3,(a0)
		movea.l    loadbnkptr(pc),a0
		movea.l    a0,a1
		moveq.l    #31,d7
gemfont_load3:
		clr.l      (a1)+
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
		move.l     d0,d3
		move.w     filehandle(pc),-(a7)
		move.w     #62,-(a7) /* Fclose */
		trap       #1
		addq.l     #4,a7
		tst.l      d3
		bmi.s      gemfont_load5
		movea.l    loadbnkptr(pc),a0
		lea.l      16(a0),a0
		bsr.s      swap_font
		movem.l    (a7)+,a0-a6
		rts
gemfont_load4:
		movem.l    (a7)+,a0-a6
		bra        enoent
gemfont_load5:
		movem.l    (a7)+,a0-a6
		bra        diskerror


swap_font:
		btst       #FONTF_BIGENDIAN,font_flags+1(a0) /* motorola format? */
		beq.s      swap_font1
		rts
swap_font1:
		move.w     font_id(a0),d0
		ror.w      #8,d0
		move.w     d0,font_id(a0)
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
swap_font2:
		move.w     (a1),d0
		ror.w      #8,d0
		move.w     d0,(a1)+
		dbf        d7,swap_font2
		rts

/*
 * Syntax:   gemfont cmds
 */
gemfont_cmds:
		tst.w      d0
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		lea.l      helpmsgs(pc),a0
gemfont_cmds1:
		tst.b      (a0)
		beq.s      gemfont_cmds4
		movem.l    a0-a6,-(a7)
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,a0-a6
gemfont_cmds2:
		tst.b      (a0)+
		bne.s      gemfont_cmds2
gemfont_cmds3:
		movem.l    a0-a6,-(a7)
		move.w     #255,-(a7)
		move.w     #6,-(a7)
		trap       #1
		addq.l     #4,a7
		bclr       #5,d0
		movem.l    (a7)+,a0-a6
		tst.l      d0
		beq.s      gemfont_cmds3
		cmpi.b     #'Y',d0
		beq.s      gemfont_cmds1
		cmpi.b     #'N',d0
		bne.s      gemfont_cmds3
gemfont_cmds4:
		movem.l    (a7)+,d1-d7/a0-a6
		rts

etext:

	.data

sdata:

gemtext_id:
		dc.b 'STOS GEM FONT 110553'
gemtext_id_end:
		dc.b 0
		.even

helpmsgs:
		dc.b 13,10
		dc.b 'ST(e)/TT/Falcon Gemtext Extension v0.9b command reference ',$bd,' 1996, 1997, 1998',13,10
		dc.b 13,10
		dc.b '                       Anthony Hoskin.',13,10
		dc.b '                       45 Wythburn Road,',13,10
		dc.b '                       Newbold,',13,10
		dc.b '                       Chesterfield,',13,10
		dc.b '                       Derbyshire. S41 8DP. [U.K.]',13,10
		dc.b 13,10
		dc.b 'This is a quick reference only, for a more detailed description of the',13,10
		dc.b 'commands you should read the text document supplied with this extension.',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemfont cmds',13,10
		dc.b 'Action    :-   Lists this command reference.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext init',13,10
		dc.b 'Action    :-   This   command  initialises  all  the   necessary   gemtext',13,10
		dc.b '               parameters to their default values. (This is also performed',13,10
		dc.b '               automatically in the editor each time CONTROL-C is used  to',13,10
		dc.b '               break a program and/or the UNDO key is pressed).',13,10
		dc.b 13,10
		dc.b '               Default font    2 = 8*8 system font.',13,10
		dc.b '               Default colours 1 = foreground colour,',13,10
		dc.b '                               0 = background colour.',13,10
		dc.b '               Default mode    0 = replacement mode.',13,10
		dc.b '               Default style   0 = normal (no special effects).',13,10
		dc.b '               Default angle   0 = no rotation of characters.',13,10
		dc.b '               Default scale   0 = no character size scaling (normal size).',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemfont load FILENAME$,BNK',13,10
		dc.b 'Action    :-   This  command loads the specified GEM font into the  memory',13,10
		dc.b '               bank  BNK.  The memory bank need not have  been  previously',13,10
		dc.b '               reserved.  The  gemfont  load command ERASES  a  previously',13,10
		dc.b '               loaded bank.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext font',13,10
		dc.b 'Syntax    :-   The gemtext font command has two formats;',13,10
		dc.b 13,10
		dc.b '               gemtext font N      [one parameter]',13,10
		dc.b '               gemtext font B,N    [two parameters]',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b 'Action    :-   Format 1',13,10
		dc.b '               ~~~~~~~~',13,10
		dc.b 13,10
		dc.b '               gemtext font N   this command specifies the current',13,10
		dc.b '                                font to use for output of gemtext.',13,10
		dc.b 13,10
		dc.b "               N = 1       is the ST's  6x6 system font [in ROM]",13,10
		dc.b "               N = 2       is the ST's  8x8 system font [in ROM]",13,10
		dc.b "               N = 3       is the ST's 8x16 system font [in ROM]",13,10
		dc.b 13,10
		dc.b '               N = 4 to 15 points to a STOS memory bank which holds a',13,10
		dc.b '                           converted GEM font (loaded by the command',13,10
		dc.b '                           gemtext load) thus it is possible to display',13,10
		dc.b '                           many different/custom fonts on the same screen.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '               Format 2',13,10
		dc.b '               ~~~~~~~~',13,10
		dc.b 13,10
		dc.b '               gemtext font B,N this command specifies the current',13,10
		dc.b '                                font to use for output of gemtext.',13,10
		dc.b 13,10
		dc.b '               B = 1 to 15 inclusive points to a STOS memory bank which is',13,10
		dc.b '                           a JOINED_FONT_BANK. This is a special type of',13,10
		dc.b '                           memory bank which holds more than one converted',13,10
		dc.b '                           GEM font [upto a maximum of 15 fonts may be',13,10
		dc.b '                           stored in such a bank].',13,10
		dc.b 13,10
		dc.b '               N = 1 to 15 inclusive is the index # of the GEM font stored',13,10
		dc.b '                           in the JOINED_FONT_BANK. This is the index # of',13,10
		dc.b '                           the font that will be used in gemtext output.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   NAME$=gemfont name$',13,10
		dc.b 'Action    :-   This command returns the current GEM fonts face name.',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext color FG,BG',13,10
		dc.b 'Action    :-   This   command  specifies  the  FG  (foreground)   and   BG',13,10
		dc.b '               (background)   colours  that  gemtext is to  use  for   the',13,10
		dc.b '               current output of text.',13,10
		dc.b 13,10
		dc.b '     N.B.      The  background  colour chosen may not have any  effect  in',13,10
		dc.b '               text  mode 0 but some special effects can be obtained  from',13,10
		dc.b '               the background colour when text mode is specified as 1 to 3',13,10
		dc.b '               inclusive.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext mode N',13,10
		dc.b 'Action    :-   This  command  specifies  the graphics  writing  mode  that',13,10
		dc.b '               gemtext is to use for the current output of text.',13,10
		dc.b 13,10
		dc.b '               Where N   =    0    =    replacement mode,',13,10
		dc.b '                         =    1    =    transparent mode,',13,10
		dc.b '                         =    2    =    XOR mode,',13,10
		dc.b '                         =    3    =    inverse transparent.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext style N',13,10
		dc.b 'Action    :-   This  command  specifies the style of the  characters  that',13,10
		dc.b '               gemtext is to use for the current output of text.',13,10
		dc.b 13,10
		dc.b '               Where N   =    0    =    normal (no special effects),',13,10
		dc.b '                         =    1    =    bold,',13,10
		dc.b '                         =    2    =    shaded, (lightened)',13,10
		dc.b '                         =    4    =    italic,',13,10
		dc.b '                         =   16    =    outlined.',13,10
		dc.b 13,10
		dc.b '               Any combination can be made by adding together the  numbers',13,10
		dc.b '               for  the  various  effects,  e.g.,  21=outlined-italic-bold',13,10
		dc.b "               style,  the maximum value of 'N' is set to 31 as any  value",13,10
		dc.b '               higher than this is nonsensical.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext scale N',13,10
		dc.b 'Action    :-   This  command specifies the current character size  scaling',13,10
		dc.b '               to use for the current output of gemtext.',13,10
		dc.b 13,10
		dc.b '               N =     zero = normal size (no scaling),',13,10
		dc.b '               N = non-zero = twice size characters.',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext angle N',13,10
		dc.b 'Action    :-   This  command  specifies  the  angle  of  rotation  of  the',13,10
		dc.b '               characters  that gemtext is to use for the current   output',13,10
		dc.b '               of   text.  Possible  values   are;   0,   90,   180,   270',13,10
		dc.b '               degrees,  if the rotation angle is either 90 or 270 degrees',13,10
		dc.b '               the text will be displayed at positions X,Y vertically with',13,10
		dc.b '               incremented  ycoord  when the string is  greater  than  one',13,10
		dc.b '               character in length.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   gemtext X,Y,A$',13,10
		dc.b 'Action    :-   This  command  displays  a  text string  A$  at  the  pixel',13,10
		dc.b '               coordinates  X,Y  using  the  font,   colours  and  effects',13,10
		dc.b '               specified  by the above commands via the  LINE_A  emulators',13,10
		dc.b '               TEXT_BLIT routines.',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   W=gemfont cellwidth',13,10
		dc.b 'Action    :-   This  function  returns  W with the  width  of  the  widest',13,10
		dc.b '               character cell in the GEM font currently in use (set by the',13,10
		dc.b '               gemtext  font  N  command).   The  current  character  size',13,10
		dc.b '               scaling,  set by gemtext scale, is automatically taken into',13,10
		dc.b '               account.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   H=gemfont cellheight',13,10
		dc.b 'Action    :-   This  function returns H with the height of  the  character',13,10
		dc.b '               cell  in the GEM font currently in use (set by the  gemtext',13,10
		dc.b '               font N command).  The current character size  scaling,  set',13,10
		dc.b '               by gemtext scale, is automatically taken into account.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   STRW=gemtext stringwidth(A$)',13,10
		dc.b 'Action    :-   This  function returns STRW with the width (in  pixels)  of',13,10
		dc.b '               the  string  of  characters  in  A$.  This  is  useful  for',13,10
		dc.b '               determining  the  width of a line of characters  in  pixels',13,10
		dc.b '               when  you wish to centre a gemtext string  on  screen.  The',13,10
		dc.b '               current character size  scaling,  set by gemtext scale,  is',13,10
		dc.b '               automatically taken into account.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'Command   :-   Z=gemfont convert(BNK)',13,10
		dc.b 'Action    :-   This command converts an old Gemtext font to the new format.',13,10
		dc.b '               Returns Z = -1 (TRUE) if font  was  successfully  converted',13,10
		dc.b '               otherwise Z = 0 (FALSE).',13,10
		dc.b 13,10
		dc.b 'The  ST(e)/TT/Falcon  Gemtext extension uses a different structure  for  a',13,10
		dc.b 'font  bank  as  compared  to  the old  (now  obsolete)  Falcon  030  Video',13,10
		dc.b 'extension.  A  font  bank created for use with the old  extension  may  be',13,10
		dc.b 'updated to the new format with this command.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b 'Example   :-   Converting an old font (saved as binary) to the new format.',13,10
		dc.b 13,10
		dc.b '               1000 F$="MY_FONT.DAT" : rem filename of old font bank.',13,10
		dc.b '               1010 open in #1,F$ : rem open the file and',13,10
		dc.b '               1020 SIZE=lof(#1) : rem fetch length of file.',13,10
		dc.b '               1030 close #1',13,10
		dc.b '               1040 reserve as data 7,SIZE : rem reserve some storage.',13,10
		dc.b '               1050 bload F$,7 : rem load the binary font into bank #7.',13,10
		dc.b '               1060 Z=gemfont convert(7) : rem convert font and resave.',13,10
		dc.b '               1070 if Z=TRUE then bsave F$,start(7) to start(7)+SIZE',13,10
		dc.b 13,10
		dc.b 'Example   :-   Converting an old font (saved as an MBK) to the new format.',13,10
		dc.b 13,10
		dc.b '               1000 F$="MY_FONT.MBK" : rem filename of old font bank.',13,10
		dc.b '               1010 load F$,7 : rem load the MBK font into bank #7.',13,10
		dc.b '               1020 Z=gemfont convert(7) : rem convert font and resave.',13,10
		dc.b '               1030 if Z=TRUE then save F$,7',13,10
		dc.b 13,10
		dc.b 'End of command reference... Press N to exit.',13,10
		dc.b 0
		.even
		dc.w 0
		dc.w 0

edata:

	.bss
sbss:

table: ds.l 1
loadbnk: ds.w 1
loadbnkptr: ds.l 1
dtaptr: ds.l 1
filehandle: ds.w 1
filesize: ds.l 1
filename: ds.b 128

mode: ds.w 1

fontbankptr: ds.l 1
fontptr: ds.l 1
fontnum: ds.w 1
text_style: ds.w 1
fgcolor: ds.w 1
bgcolor: ds.w 1
wrt_mode: ds.w 1
text_rotation: ds.w 1
text_double: ds.w 1
string_x: ds.w 1
string_y: ds.w 1
save_clip: ds.w 1
string_ptr: ds.l 1
scratchbuf: ds.w SCRATCHBUF_SIZE


finprg:
	ds.l 1
