		.include "system.inc"
		.include "errors.inc"

SCREEN_WIDTH  = 320
SCREEN_HEIGHT = 200

PSG  =	 $ffff8800

vbl_vec    = $0070
_frclock   = $0466

		.text

		bra.w        load

        dc.b $80
tokens:
        dc.b "fastcopy",$80
        dc.b "col",$81
        dc.b "floprd",$82
        dc.b "mediach",$83
        dc.b "flopwrt",$84
        dc.b "hardkey",$85
        dc.b "dot",$86
        dc.b "ndrv",$87
        dc.b "mouseoff",$88
        dc.b "freq",$89
        dc.b "mouseon",$8a
        dc.b "resvalid",$8b
        dc.b "skopy",$8c
        dc.b "aesin",$8d
        dc.b "setrtim",$8e
        dc.b "rtim",$8f
        dc.b "warmboot",$90
        dc.b "blitter",$91
        dc.b "silence",$92
        dc.b "kbshift",$93
        dc.b "kopy",$94

        dc.b 0
        even

jumps: dc.w 21
		dc.l fastcopy
		dc.l col
		dc.l floprd
		dc.l mediach
		dc.l flopwrt
		dc.l hardkey
		dc.l dot
		dc.l ndrv
		dc.l mouseoff
		dc.l freq
		dc.l mouseon
		dc.l resvalid
		dc.l skopy
		dc.l aesin
		dc.l setrtim
		dc.l rtim
		dc.l warmboot
		dc.l blitter
		dc.l silence
		dc.l kbshift
		dc.l kopy
		
welcome:
	dc.b 10,13
	dc.b "          Misty Extension",10,13
	dc.b "       ",$9c,"5 registration fee to",10,13
	dc.b "Billy Allan       or      Colin Watt",10,13
	dc.b "66 Highmains Ave     14 Lanrig Place",10,13
	dc.b "Dumbarton                   Muirhead",10,13
	dc.b "Scotland                    Scotland",10,13
	dc.b "G82 2PT                      G69 9AT",0
	dc.b 10,13
	dc.b "           Extention Misty",10,13
	dc.b $9c,"5 enregistrement r",$82,"mun",$82,"ration prep ",$86,10,13
	dc.b "Billy Allan    ou bien    Colin Watt",10,13
	dc.b "66 Highmains Ave     14 Lanrig Place",10,13
	dc.b "Dumbarton                   Muirhead",10,13
	dc.b "Scotland                    Scotland",10,13
	dc.b "G82 2PT                      G69 9AT",0
	.even

table: ds.l 1
returnpc: ds.l 1


load:
		lea.l      finprg,a0
		lea.l      cold,a1
		rts

cold:
		move.l     a0,table
		lea.l      welcome,a0
		lea.l      warm,a1
		lea.l      tokens,a2
		lea.l      jumps,a3
		rts

warm:
		clr.l      0x000004D2.l /* XXX */
		rts

getinteger:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne.s      typemismatch
		jmp        (a0)

syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0
		bra.s      goerror
illfunc:
		moveq.l    #E_illegalfunc,d0
		nop /* XXX */

goerror:
		movea.l    table(pc),a0
		movea.l    sys_error(a0),a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: FASTCOPY Screen1,Screen2
 */
fastcopy:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne.s      syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr.s      getinteger
		movea.l    d3,a1
		bsr.s      getinteger
		movea.l    d3,a0
		/* cmpa.l     #10000,a1 */
		dc.w 0xb3fc,0,10000 /* XXX */
		ble.s      illfunc
		move.w     #50-1,d0
fastcopy1:
		movem.l    ZERO(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,ZERO(a1)
		movem.l    48(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,48(a1)
		movem.l    96(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,96(a1)
		movem.l    144(a0),d1-d4
		movem.l    d1-d4,144(a1)
		movem.l    160(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,160(a1)
		movem.l    208(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,208(a1)
		movem.l    256(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,256(a1)
		movem.l    304(a0),d1-d4
		movem.l    d1-d4,304(a1)
		movem.l    320(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,320(a1)
		movem.l    368(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,368(a1)
		movem.l    416(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,416(a1)
		movem.l    464(a0),d1-d4
		movem.l    d1-d4,464(a1)
		movem.l    480(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,480(a1)
		movem.l    528(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,528(a1)
		movem.l    576(a0),d1-d7/a2-a6
		movem.l    d1-d7/a2-a6,576(a1)
		movem.l    624(a0),d1-d4
		movem.l    d1-d4,624(a1)
		lea.l      640(a0),a0
		lea.l      640(a1),a1
		dbf        d0,fastcopy1
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: C=COL(Screen,X,Y)
 */
col:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,d1
		bsr        getinteger
		move.w     d3,d0
		bsr        getinteger
		movea.l    d3,a0
		clr.w      d2
		mulu.w     #160,d1
		move.w     d0,d3
		lsr.w      #1,d3
		and.w      #-8,d3
		add.w      d3,d1
		adda.w     d1,a0
		and.w      #15,d0
		neg.w      d0
		add.w      #15,d0
		moveq.l    #0,d4
		moveq.l    #4-1,d3
col1:
		move.w     (a0)+,d1
		btst       d0,d1
		bne.s      col2
		bclr       d4,d2
		bra.s      col3
col2:
		bset       d4,d2
col3:
		/* addq.w     #1,d4 */
		dc.w 0xd87c,1 /* XXX */
		dbf        d3,col1
		move.w     d2,d3
		clr.w      d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: FLOPRD Buffer,NumSecs,Side,Track,Sector,Drive
 */
floprd:
		move.l     (a7)+,returnpc
		cmp.w      #6,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,flop_drive
		bsr        getinteger
		move.w     d3,flop_sector
		bsr        getinteger
		move.w     d3,flop_track
		bsr        getinteger
		move.w     d3,flop_side
		bsr        getinteger
		move.w     d3,flop_numsecs
		bsr        getinteger
		move.l     d3,flop_buffer
		move.w     flop_numsecs,-(a7)
		move.w     flop_side,-(a7)
		move.w     flop_track,-(a7)
		move.w     flop_sector,-(a7)
		move.w     flop_drive,-(a7)
		clr.l      -(a7)
		move.l     flop_buffer,-(a7)
		move.w     #8,-(a7) ; Floprd
		trap       #14
		lea.l      20(a7),a7
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: X=MEDIACH (D)
 */
mediach:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,-(a7)
		move.w     #9,-(a7) ; Mediach
		trap       #13
		addq.l     #4,a7
		move.l     d0,d3
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: FLOPWRT Buffer,NumSecs,Side,Track,Sector,Drive
 */
flopwrt:
		move.l     (a7)+,returnpc
		cmp.w      #6,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,flop_drive
		bsr        getinteger
		move.w     d3,flop_sector
		bsr        getinteger
		move.w     d3,flop_track
		bsr        getinteger
		move.w     d3,flop_side
		bsr        getinteger
		move.w     d3,flop_numsecs
		bsr        getinteger
		move.l     d3,flop_buffer
		move.w     flop_numsecs,-(a7)
		move.w     flop_side,-(a7)
		move.w     flop_track,-(a7)
		move.w     flop_sector,-(a7)
		move.w     flop_drive,-(a7)
		clr.l      -(a7)
		move.l     flop_buffer,-(a7)
		move.w     #9,-(a7) ; Flopwrt
		trap       #14
		lea.l      20(a7),a7
		movea.l    returnpc,a0
		jmp        (a0)

flop_numsecs: ds.w 1
flop_side: ds.w 1
flop_track: ds.w 1
flop_sector: ds.w 1
flop_drive: ds.w 1
flop_buffer: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: C=HARDKEY
 */
hardkey:
		move.l     (a7)+,returnpc
		moveq.l    #0,d3
		moveq.l    #0,d2
		move.b     0xFFFFFC02.l,d3 /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: DOT Scr,X,Y,C
 */
dot:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		move.w     d3,dot_color
		bsr        getinteger
		move.w     d3,dot_y
		bsr        getinteger
		move.w     d3,dot_x
		bsr        getinteger
		move.l     d3,dot_screen
		movea.l    dot_screen,a0
		move.w     dot_x,d0
		move.w     dot_y,d1
		move.w     dot_color,d2
		mulu.w     #160,d1
		move.w     d0,d3
		lsr.w      #1,d3
		and.w      #-8,d3
		add.w      d3,d1
		adda.w     d1,a0
		and.w      #15,d0
		neg.w      d0
		add.w      #15,d0
		moveq.l    #3,d3
dot1:
		move.w     (a0),d1
		lsr.w      #1,d2
		bcs.s      dot2
		bclr       d0,d1
		bra.s      dot3
dot2:
		bset       d0,d1
dot3:
		move.w     d1,(a0)+
		dbf        d3,dot1
		movea.l    returnpc,a0
		jmp        (a0)

dot_x: ds.w 1
dot_y: ds.w 1
dot_color: ds.w 1
dot_screen: ds.w 1 ; BUG: must be .l

; -----------------------------------------------------------------------------

/*
 * Syntax: D=NDRV
 */
ndrv:
		move.l     (a7)+,returnpc
		moveq.l    #0,d2
		moveq.l    #0,d3
		move.w     0x000004A6.l,d3 /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: MOUSEOFF
 */
mouseoff:
		move.l     (a7)+,returnpc
		move.b     #0x12,0xFFFFFC02.l /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: F=FREQ
 */
freq:
		move.l     (a7)+,returnpc
		moveq.l    #0,d3
		move.b     0xFFFF820A.l,d3 /* XXX */
		btst       #1,d3
		beq.s      freq1
		/* moveq.l    #50,d3 */
		dc.w 0x263c,0,50 /* XXX */
		bra.s      freq2
freq1:
		/* moveq.l    #60,d3 */
		dc.w 0x263c,0,60 /* XXX */
freq2:
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: MOUSEON
 */
mouseon:
		move.l     (a7)+,returnpc
		move.b     #0x08,0xFFFFFC02.l /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: R=RESVALID
 */
resvalid:
		move.l     (a7)+,returnpc
		moveq.l    #0,d2
		moveq.l    #0,d3
		move.l     0x00000426.l,d0 /* XXX */
		cmpi.l     #0x31415926,d0
		bne.s      resvalid1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
resvalid1:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: SKOPY N,Scr1,X1,Y1,X2,Y2,Scr2,XDST,YDST
 */
skopy:
		move.l     (a7)+,returnpc
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		cmp.w      #9,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,skopy_ydst
		bsr        getinteger
		move.l     d3,skopy_xdst
		bsr        getinteger
		move.l     d3,skopy_dst
		bsr        getinteger
		move.l     d3,skopy_y2
		bsr        getinteger
		move.l     d3,skopy_x2
		bsr        getinteger
		move.l     d3,skopy_y1
		bsr        getinteger
		move.l     d3,skopy_x1
		bsr        getinteger
		move.l     d3,skopy_src
		bsr        getinteger
		move.l     d3,skopy_nplanes
		movea.l    skopy_src,a0
		movea.l    skopy_dst,a1
		move.l     skopy_x1,d0
		move.l     skopy_y1,d1
		move.l     skopy_x2,d2
		move.l     skopy_y2,d3
		move.l     skopy_xdst,d4
		move.l     skopy_ydst,d5
		move.l     skopy_nplanes,d6
		subq.l     #1,d3
		cmpi.l     #10,d6
		ble.s      skopy_clipped
		subi.l     #10,d6
		move.l     d6,skopy_nplanes
		bra        skopy_unclipped

skopy_clipped:
		/* tst.w      d0 */
		dc.w 0x0c40,0 /* XXX */
		bge.s      skopy_clipped1
		moveq.l    #0,d0
skopy_clipped1:
		cmpi.w     #SCREEN_WIDTH,d0
		ble.s      skopy_clipped2
		move.l     #SCREEN_WIDTH,d0
skopy_clipped2:
		/* tst.w      d1 */
		dc.w 0x0c41,0 /* XXX */
		bge.s      skopy_clipped3
		moveq.l    #0,d1
skopy_clipped3:
		cmpi.w     #SCREEN_HEIGHT-1,d1
		ble.s      skopy_clipped4
		move.l     #SCREEN_HEIGHT-1,d1
skopy_clipped4:
		/* tst.w      d2 */
		dc.w 0x0c42,0 /* XXX */
		bge.s      skopy_clipped5
		moveq.l    #0,d2
skopy_clipped5:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      skopy_clipped6
		move.l     #SCREEN_WIDTH,d2
skopy_clipped6:
		/* tst.w      d3 */
		dc.w 0x0c43,0 /* XXX */
		bge.s      skopy_clipped7
		moveq.l    #0,d3
skopy_clipped7:
		cmpi.w     #SCREEN_HEIGHT-1,d3
		ble.s      skopy_clipped8
		move.l     #SCREEN_HEIGHT-1,d3
skopy_clipped8:
		moveq.l    #0,d6
		move.l     d2,d6
		sub.l      d0,d6
		/* tst.w      d4 */
		dc.w 0x0c44,0 /* XXX */
		bge.s      skopy_clipped9
		sub.l      d4,d0
		moveq.l    #0,d4
		moveq.l    #0,d6
		move.l     d2,d6
		sub.l      d0,d6
		bra.s      skopy_clipped10
skopy_clipped9:
		move.w     d4,d7
		add.l      d6,d7
		cmpi.w     #SCREEN_WIDTH,d7
		blt.s      skopy_clipped10
		sub.w      #SCREEN_WIDTH,d7
		sub.w      d7,d2
		moveq.l    #0,d6
		move.l     d2,d6
		sub.l      d0,d6
skopy_clipped10:
		divu.w     #4,d6
		/* tst.w      d6 */
		dc.w 0xbc7c,0 /* XXX */
		bgt.s      skopy_clipped11
		bra        skopy_ret
skopy_clipped11:
		cmp.w      #SCREEN_WIDTH/4,d6
		ble.s      skopy_clipped12
		bra        skopy_ret
skopy_clipped12:
		/* tst.w      d5 */
		dc.w 0x0c45,0 /* XXX */
		bge.s      skopy_clipped13
		neg.w      d5
		add.l      d5,d1
		moveq.l    #0,d5
		move.l     d3,d7
		sub.l      d1,d7
		bra.s      skopy_clipped14
skopy_clipped13:
		move.l     d3,d7
		sub.l      d1,d7
		moveq.l    #0,d6
		move.l     d5,d6
		add.l      d7,d6
		cmpi.w     #SCREEN_HEIGHT-1,d6
		ble.s      skopy_clipped14
		sub.l      #SCREEN_HEIGHT-1,d6
		sub.l      d6,d3
		move.l     d3,d7
		sub.l      d1,d7
skopy_clipped14:
		/* tst.w      d7 */
		dc.w 0xbe7c,0 /* XXX */
		bge.s      skopy_clipped15
		bra        skopy_ret
skopy_clipped15:
		cmp.w      #SCREEN_HEIGHT-1,d7
		ble.s      skopy_unclipped
		move.l     #SCREEN_HEIGHT-1,d7

skopy_unclipped:
		moveq.l    #0,d6
		move.l     d2,d6
		sub.l      d0,d6
		lsr.l      #2,d6 ; d6 = number of words to copy for 4 planes
		and.w      #-16,d0
		lsr.l      #1,d0
		and.w      #-16,d4
		lsr.l      #1,d4
		adda.l     d0,a0
		adda.l     d4,a1
		move.l     d3,d7
		sub.l      d1,d7 ; d7 = number of screenlines
		mulu.w     #160,d1
		mulu.w     #160,d5
		adda.l     d1,a0
		adda.l     d5,a1
		move.l     skopy_nplanes,d5
		cmp.w      #1,d5
		beq.s      skopy_1plane_unclipped
		cmp.w      #2,d5
		beq        skopy_2planes_unclipped
		cmp.w      #3,d5
		beq        skopy_3planes_unclipped
		cmp.w      #4,d5
		beq        skopy_4planes_unclipped
		bsr        illfunc

skopy_1plane_unclipped:
		cmpi.w     #4,d6
		beq        skopy_1plane_4words
		cmpi.w     #8,d6
		beq        skopy_1plane_8words
		cmpi.w     #12,d6
		beq        skopy_1plane_12words
		cmpi.w     #16,d6
		beq        skopy_1plane_16words
		cmpi.w     #20,d6
		beq        skopy_1plane_20words
		cmpi.w     #24,d6
		beq        skopy_1plane_24words
		cmpi.w     #28,d6
		beq        skopy_1plane_28words
		cmpi.w     #32,d6
		beq        skopy_1plane_32words
		cmpi.w     #36,d6
		beq        skopy_1plane_36words
		cmpi.w     #40,d6
		beq        skopy_1plane_40words
		cmpi.w     #44,d6
		beq        skopy_1plane_44words
		cmpi.w     #48,d6
		beq        skopy_1plane_48words
		cmpi.w     #52,d6
		beq        skopy_1plane_52words
		cmpi.w     #56,d6
		beq        skopy_1plane_56words
		cmpi.w     #60,d6
		beq        skopy_1plane_60words
		cmpi.w     #64,d6
		beq        skopy_1plane_64words
		cmpi.w     #68,d6
		beq        skopy_1plane_68words
		cmpi.w     #72,d6
		beq        skopy_1plane_72words
		cmpi.w     #76,d6
		beq        skopy_1plane_76words
		cmpi.w     #80,d6
		beq        skopy_1plane_80words
		bra        skopy_ret

skopy_1plane_4words:
		move.w     ZERO(a0),ZERO(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_4words
		bra        skopy_ret

skopy_1plane_8words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_8words
		bra        skopy_ret

skopy_1plane_12words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_12words
		bra        skopy_ret

skopy_1plane_16words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_16words
		bra        skopy_ret

skopy_1plane_20words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_20words
		bra        skopy_ret

skopy_1plane_24words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_24words
		bra        skopy_ret

skopy_1plane_28words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_28words
		bra        skopy_ret

skopy_1plane_32words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_32words
		bra        skopy_ret

skopy_1plane_36words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_36words
		bra        skopy_ret

skopy_1plane_40words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_40words
		bra        skopy_ret

skopy_1plane_44words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_44words
		bra        skopy_ret

skopy_1plane_48words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_48words
		bra        skopy_ret

skopy_1plane_52words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_52words
		bra        skopy_ret

skopy_1plane_56words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_56words
		bra        skopy_ret

skopy_1plane_60words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		move.w     112(a0),112(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_60words
		bra        skopy_ret

skopy_1plane_64words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		move.w     112(a0),112(a1)
		move.w     120(a0),120(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_64words
		bra        skopy_ret

skopy_1plane_68words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		move.w     112(a0),112(a1)
		move.w     120(a0),120(a1)
		move.w     128(a0),128(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_68words
		bra        skopy_ret

skopy_1plane_72words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		move.w     112(a0),112(a1)
		move.w     120(a0),120(a1)
		move.w     128(a0),128(a1)
		move.w     136(a0),136(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_72words
		bra        skopy_ret

skopy_1plane_76words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		move.w     112(a0),112(a1)
		move.w     120(a0),120(a1)
		move.w     128(a0),128(a1)
		move.w     136(a0),136(a1)
		move.w     144(a0),144(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_76words
		bra        skopy_ret

skopy_1plane_80words:
		move.w     ZERO(a0),ZERO(a1)
		move.w     8(a0),8(a1)
		move.w     16(a0),16(a1)
		move.w     24(a0),24(a1)
		move.w     32(a0),32(a1)
		move.w     40(a0),40(a1)
		move.w     48(a0),48(a1)
		move.w     56(a0),56(a1)
		move.w     64(a0),64(a1)
		move.w     72(a0),72(a1)
		move.w     80(a0),80(a1)
		move.w     88(a0),88(a1)
		move.w     96(a0),96(a1)
		move.w     104(a0),104(a1)
		move.w     112(a0),112(a1)
		move.w     120(a0),120(a1)
		move.w     128(a0),128(a1)
		move.w     136(a0),136(a1)
		move.w     144(a0),144(a1)
		move.w     152(a0),152(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_1plane_80words
		bra        skopy_ret


skopy_2planes_unclipped:
		cmpi.w     #4,d6
		beq        skopy_2planes_4words
		cmpi.w     #8,d6
		beq        skopy_2planes_8words
		cmpi.w     #12,d6
		beq        skopy_2planes_12words
		cmpi.w     #16,d6
		beq        skopy_2planes_16words
		cmpi.w     #20,d6
		beq        skopy_2planes_20words
		cmpi.w     #24,d6
		beq        skopy_2planes_24words
		cmpi.w     #28,d6
		beq        skopy_2planes_28words
		cmpi.w     #32,d6
		beq        skopy_2planes_32words
		cmpi.w     #36,d6
		beq        skopy_2planes_36words
		cmpi.w     #40,d6
		beq        skopy_2planes_40words
		cmpi.w     #44,d6
		beq        skopy_2planes_44words
		cmpi.w     #48,d6
		beq        skopy_2planes_48words
		cmpi.w     #52,d6
		beq        skopy_2planes_52words
		cmpi.w     #56,d6
		beq        skopy_2planes_56words
		cmpi.w     #60,d6
		beq        skopy_2planes_60words
		cmpi.w     #64,d6
		beq        skopy_2planes_64words
		cmpi.w     #68,d6
		beq        skopy_2planes_68words
		cmpi.w     #72,d6
		beq        skopy_2planes_72words
		cmpi.w     #76,d6
		beq        skopy_2planes_76words
		cmpi.w     #80,d6
		beq        skopy_2planes_80words
		bra        skopy_ret

skopy_2planes_4words:
		move.l     ZERO(a0),ZERO(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_4words
		bra        skopy_ret

skopy_2planes_8words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_8words
		bra        skopy_ret

skopy_2planes_12words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_12words
		bra        skopy_ret

skopy_2planes_16words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_16words
		bra        skopy_ret

skopy_2planes_20words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_20words
		bra        skopy_ret

skopy_2planes_24words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_24words
		bra        skopy_ret

skopy_2planes_28words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_28words
		bra        skopy_ret

skopy_2planes_32words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_32words
		bra        skopy_ret

skopy_2planes_36words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_36words
		bra        skopy_ret

skopy_2planes_40words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_40words
		bra        skopy_ret

skopy_2planes_44words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_44words
		bra        skopy_ret

skopy_2planes_48words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_48words
		bra        skopy_ret

skopy_2planes_52words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_52words
		bra        skopy_ret

skopy_2planes_56words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_56words
		bra        skopy_ret

skopy_2planes_60words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		move.l     112(a0),112(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_60words
		bra        skopy_ret

skopy_2planes_64words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		move.l     112(a0),112(a1)
		move.l     120(a0),120(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_64words
		bra        skopy_ret

skopy_2planes_68words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		move.l     112(a0),112(a1)
		move.l     120(a0),120(a1)
		move.l     128(a0),128(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_68words
		bra        skopy_ret

skopy_2planes_72words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		move.l     112(a0),112(a1)
		move.l     120(a0),120(a1)
		move.l     128(a0),128(a1)
		move.l     136(a0),136(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_72words
		bra        skopy_ret

skopy_2planes_76words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		move.l     112(a0),112(a1)
		move.l     120(a0),120(a1)
		move.l     128(a0),128(a1)
		move.l     136(a0),136(a1)
		move.l     144(a0),144(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_76words
		bra        skopy_ret

skopy_2planes_80words:
		move.l     ZERO(a0),ZERO(a1)
		move.l     8(a0),8(a1)
		move.l     16(a0),16(a1)
		move.l     24(a0),24(a1)
		move.l     32(a0),32(a1)
		move.l     40(a0),40(a1)
		move.l     48(a0),48(a1)
		move.l     56(a0),56(a1)
		move.l     64(a0),64(a1)
		move.l     72(a0),72(a1)
		move.l     80(a0),80(a1)
		move.l     88(a0),88(a1)
		move.l     96(a0),96(a1)
		move.l     104(a0),104(a1)
		move.l     112(a0),112(a1)
		move.l     120(a0),120(a1)
		move.l     128(a0),128(a1)
		move.l     136(a0),136(a1)
		move.l     144(a0),144(a1)
		move.l     152(a0),152(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_2planes_80words
		bra        skopy_ret


skopy_3planes_unclipped:
		cmpi.w     #4,d6
		beq        skopy_3planes_4words
		cmpi.w     #8,d6
		beq        skopy_3planes_8words
		cmpi.w     #12,d6
		beq        skopy_3planes_12words
		cmpi.w     #16,d6
		beq        skopy_3planes_16words
		cmpi.w     #20,d6
		beq        skopy_3planes_20words
		cmpi.w     #24,d6
		beq        skopy_3planes_24words
		cmpi.w     #28,d6
		beq        skopy_3planes_28words
		cmpi.w     #32,d6
		beq        skopy_3planes_32words
		cmpi.w     #36,d6
		beq        skopy_3planes_36words
		cmpi.w     #40,d6
		beq        skopy_3planes_40words
		cmpi.w     #44,d6
		beq        skopy_3planes_44words
		cmpi.w     #48,d6
		beq        skopy_3planes_48words
		cmpi.w     #52,d6
		beq        skopy_3planes_52words
		cmpi.w     #56,d6
		beq        skopy_3planes_56words
		cmpi.w     #60,d6
		beq        skopy_3planes_60words
		cmpi.w     #64,d6
		beq        skopy_3planes_64words
		cmpi.w     #68,d6
		beq        skopy_3planes_68words
		cmpi.w     #72,d6
		beq        skopy_3planes_72words
		cmpi.w     #76,d6
		beq        skopy_3planes_76words
		cmpi.w     #80,d6
		beq        skopy_3planes_80words
		bra        skopy_ret

skopy_3planes_4words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_4words
		bra        skopy_ret

skopy_3planes_8words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_8words
		bra        skopy_ret

skopy_3planes_12words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_12words
		bra        skopy_ret

skopy_3planes_16words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_16words
		bra        skopy_ret

skopy_3planes_20words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_20words
		bra        skopy_ret

skopy_3planes_24words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_24words
		bra        skopy_ret

skopy_3planes_28words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_28words
		bra        skopy_ret

skopy_3planes_32words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_32words
		bra        skopy_ret

skopy_3planes_36words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_36words
		bra        skopy_ret

skopy_3planes_40words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_40words
		bra        skopy_ret

skopy_3planes_44words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_44words
		bra        skopy_ret

skopy_3planes_48words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_48words
		bra        skopy_ret

skopy_3planes_52words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_52words
		bra        skopy_ret

skopy_3planes_56words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_56words
		bra        skopy_ret

skopy_3planes_60words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		move.l     112(a0),112(a1)
		move.w     116(a0),116(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_60words
		bra        skopy_ret

skopy_3planes_64words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		move.l     112(a0),112(a1)
		move.w     116(a0),116(a1)
		move.l     120(a0),120(a1)
		move.w     124(a0),124(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_64words
		bra        skopy_ret

skopy_3planes_68words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		move.l     112(a0),112(a1)
		move.w     116(a0),116(a1)
		move.l     120(a0),120(a1)
		move.w     124(a0),124(a1)
		move.l     128(a0),128(a1)
		move.w     132(a0),132(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_68words
		bra        skopy_ret

skopy_3planes_72words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		move.l     112(a0),112(a1)
		move.w     116(a0),116(a1)
		move.l     120(a0),120(a1)
		move.w     124(a0),124(a1)
		move.l     128(a0),128(a1)
		move.w     132(a0),132(a1)
		move.l     136(a0),136(a1)
		move.w     140(a0),140(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_72words
		bra        skopy_ret

skopy_3planes_76words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		move.l     112(a0),112(a1)
		move.w     116(a0),116(a1)
		move.l     120(a0),120(a1)
		move.w     124(a0),124(a1)
		move.l     128(a0),128(a1)
		move.w     132(a0),132(a1)
		move.l     136(a0),136(a1)
		move.w     140(a0),140(a1)
		move.l     144(a0),144(a1)
		move.w     148(a0),148(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_76words
		bra        skopy_ret

skopy_3planes_80words:
		move.l     ZERO(a0),ZERO(a1)
		move.w     4(a0),4(a1)
		move.l     8(a0),8(a1)
		move.w     12(a0),12(a1)
		move.l     16(a0),16(a1)
		move.w     20(a0),20(a1)
		move.l     24(a0),24(a1)
		move.w     28(a0),28(a1)
		move.l     32(a0),32(a1)
		move.w     36(a0),36(a1)
		move.l     40(a0),40(a1)
		move.w     44(a0),44(a1)
		move.l     48(a0),48(a1)
		move.w     52(a0),52(a1)
		move.l     56(a0),56(a1)
		move.w     60(a0),60(a1)
		move.l     64(a0),64(a1)
		move.w     68(a0),68(a1)
		move.l     72(a0),72(a1)
		move.w     76(a0),76(a1)
		move.l     80(a0),80(a1)
		move.w     84(a0),84(a1)
		move.l     88(a0),88(a1)
		move.w     92(a0),92(a1)
		move.l     96(a0),96(a1)
		move.w     100(a0),100(a1)
		move.l     104(a0),104(a1)
		move.w     108(a0),108(a1)
		move.l     112(a0),112(a1)
		move.w     116(a0),116(a1)
		move.l     120(a0),120(a1)
		move.w     124(a0),124(a1)
		move.l     128(a0),128(a1)
		move.w     132(a0),132(a1)
		move.l     136(a0),136(a1)
		move.w     140(a0),140(a1)
		move.l     144(a0),144(a1)
		move.w     148(a0),148(a1)
		move.l     152(a0),152(a1)
		move.w     156(a0),156(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,skopy_3planes_80words
		bra        skopy_ret


skopy_4planes_unclipped:
		cmpi.w     #4,d6
		beq        skopy_4planes_4words
		cmpi.w     #8,d6
		beq        skopy_4planes_8words
		cmpi.w     #12,d6
		beq        skopy_4planes_12words
		cmpi.w     #16,d6
		beq        skopy_4planes_16words
		cmpi.w     #20,d6
		beq        skopy_4planes_20words
		cmpi.w     #24,d6
		beq        skopy_4planes_24words
		cmpi.w     #28,d6
		beq        skopy_4planes_28words
		cmpi.w     #32,d6
		beq        skopy_4planes_32words
		cmpi.w     #36,d6
		beq        skopy_4planes_36words
		cmpi.w     #40,d6
		beq        skopy_4planes_40words
		cmpi.w     #44,d6
		beq        skopy_4planes_44words
		cmpi.w     #48,d6
		beq        skopy_4planes_48words
		cmpi.w     #52,d6
		beq        skopy_4planes_52words
		cmpi.w     #56,d6
		beq        skopy_4planes_56words
		cmpi.w     #60,d6
		beq        skopy_4planes_60words
		cmpi.w     #64,d6
		beq        skopy_4planes_64words
		cmpi.w     #68,d6
		beq        skopy_4planes_68words
		cmpi.w     #72,d6
		beq        skopy_4planes_72words
		cmpi.w     #76,d6
		beq        skopy_4planes_76words
		cmpi.w     #80,d6
		beq        skopy_4planes_80words
		bra        skopy_ret

skopy_4planes_4words:
		movem.l    (a0),d0-d1
		movem.l    d0-d1,(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_4words
		bra        skopy_ret

skopy_4planes_8words:
		movem.l    (a0),d0-d3
		movem.l    d0-d3,(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_8words
		bra        skopy_ret

skopy_4planes_12words:
		movem.l    (a0),d0-d5
		movem.l    d0-d5,(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_12words
		bra        skopy_ret

skopy_4planes_16words:
		movem.l    (a0),d0-d6/a3
		movem.l    d0-d6/a3,(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_16words
		bra        skopy_ret

skopy_4planes_20words:
		movem.l    (a0),d0-d6/a3-a5
		movem.l    d0-d6/a3-a5,(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_20words
		bra        skopy_ret

skopy_4planes_24words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		move.l     44(a0),d0
		move.l     d0,44(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_24words
		bra        skopy_ret

skopy_4planes_28words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d2
		movem.l    d0-d2,44(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_28words
		bra        skopy_ret

skopy_4planes_32words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d4
		movem.l    d0-d4,44(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_32words
		bra        skopy_ret

skopy_4planes_36words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6
		movem.l    d0-d6,44(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_36words
		bra        skopy_ret

skopy_4planes_40words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a4
		movem.l    d0-d6/a3-a4,44(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_40words
		bra        skopy_ret

skopy_4planes_44words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_44words
		bra        skopy_ret

skopy_4planes_48words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d1
		movem.l    d0-d1,88(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_48words
		bra        skopy_ret

skopy_4planes_52words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d3
		movem.l    d0-d3,88(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_52words
		bra        skopy_ret

skopy_4planes_56words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d5
		movem.l    d0-d5,88(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_56words
		bra        skopy_ret

skopy_4planes_60words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3
		movem.l    d0-d6/a3,88(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_60words
		bra        skopy_ret

skopy_4planes_64words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a5
		movem.l    d0-d6/a3-a5,88(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_64words
		bra        skopy_ret

skopy_4planes_68words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		move.l     132(a0),d0
		move.l     d0,132(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_68words
		bra        skopy_ret

skopy_4planes_72words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d2
		movem.l    d0-d2,132(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_72words
		bra.s      skopy_ret

skopy_4planes_76words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d4
		movem.l    d0-d4,132(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_76words
		bra.s      skopy_ret

skopy_4planes_80words:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d6
		movem.l    d0-d6,132(a1)
		/* adda.l     #160,a0 */
		/* adda.l     #160,a1 */
		dc.w 0xd1fc,0,160 /* XXX */
		dc.w 0xd3fc,0,160 /* XXX */
		dbf        d7,skopy_4planes_80words
		nop

skopy_ret:
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

skopy_x1: ds.l 1
skopy_y1: ds.l 1
skopy_x2: ds.l 1
skopy_y2: ds.l 1
skopy_xdst: ds.l 1
skopy_ydst: ds.l 1
skopy_src: ds.l 1
skopy_dst: ds.l 1
skopy_nplanes: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: GEM=AESIN
 */
aesin:
		move.l     (a7)+,returnpc
* BUG: no parameter check
		move.b     0x00000030.l,d0 ; XXX WTF?
		/* tst.b      d0 */
		dc.w 0xb03c,0 /* XXX */
		beq.s      aesin1
		clr.l      d3
		bra.s      aesin2
aesin1:
		move.l     0xFFFFFFFF.l,d3 ; XXX BUG missing #
aesin2:
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: SETRTIM x
 */
setrtim:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,_frclock.l /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: X=RTIM
 */
rtim:
		move.l     (a7)+,returnpc
* BUG: no parameter check
		move.l     _frclock.l,d3 /* XXX */
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: WARMBOOT
 */
warmboot:
		move.l     (a7)+,returnpc
* BUG: no parameter check
		move.l     4.l,d0 /* XXX */
		move.l     d0,vbl_vec.l /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: X=BLITTER
 */
blitter:
		move.l     (a7)+,returnpc
* BUG: no parameter check
		move.w     #-1,-(a7)
		move.w     #64,-(a7)
		trap       #14 ; Blitmode
		addq.l     #4,a7
		btst       #1,d0
		beq.s      blitter1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
		bra.s      blitter2
blitter1:
		clr.l      d3
blitter2:
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: SILENCE
 */
silence:
		move.l     (a7)+,returnpc
* BUG: no parameter check
		move.l     #0x08000000,PSG.l /* XXX */
		move.l     #0x09000000,PSG.l /* XXX */
		move.l     #0x0A000000,PSG.l /* XXX */
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: X=KBSHIFT
 */
kbshift:
		move.l     (a7)+,returnpc
* BUG: no parameter check
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		move.w     #-1,-(a7)
		move.w     #11,-(a7)
		trap       #13
		addq.l     #4,a7
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: KOPY Src, Dst, Size
 */
kopy:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,skopy_y1
		bsr        getinteger
		move.l     d3,skopy_dst
		bsr        getinteger
		move.l     d3,skopy_src
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		movea.l    skopy_dst,a1
		movea.l    skopy_src,a0
		move.l     skopy_y1,d0
		move.l     d0,d1
		moveq.l    #10,d2
		lsr.l      d2,d1
		bra        kopy2
kopy1:
; 256 repetitions
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
kopy2:
		dbf        d1,kopy1
		move.l     d0,d1
		and.w      #1024-4,d0
		lsr.w      #1,d0
		neg.w      d0
		lea.l      kopyrest+512(pc),a2
		jmp        0(a2,d0.w)
		move.b     d0,d0
kopyrest:
; 256 repetitions
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		move.l     (a0)+,(a1)+
		and.w      #2,d1
		beq.s      kopy3
		move.w     (a0)+,(a1)+
kopy3:
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; space for registers d5-d6/a1-a6
saveregs: ds.l 8
saveregsend:

	ds.l 1 /* unused */

finprg:

ZERO = 0
