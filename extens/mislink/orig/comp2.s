		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "equates.inc"

SCREEN_WIDTH  = 320
SCREEN_HEIGHT = 200

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
	dc.w	libex-lib31

para:
	dc.w	31			; number of library routines
	dc.w	31			; number of extension commands
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


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; joey
l002:	.dc.b I,I,',',I,1,1,0     ; b height
l003:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; blit
l004:	.dc.b I,I,',',I,1,1,0     ; b width
l005:	.dc.b 0,I,',',I,',',I,',',I,1,1,0           ; spot
l006:	.dc.b I,I,',',I,1,1,0     ; block amount
l007:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0             ; reflect
l008:	.dc.b I,1,1,0             ; compstate
l009:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; mozaic
l010:	.dc.b I,I,',',I,',',I,1,1,0             ; x limit
l011:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0             ; xy block
l012:	.dc.b I,I,',',I,',',I,1,1,0             ; y limit
l013:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0           ; text
l014:	.dc.b I,1,1,0           ; mostly harmless
l015:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0             ; wash
l016:	.dc.b I,I,1,1,0           ; real length
l017:	.dc.b 0,I,1,1,0           ; reboot
l018:	.dc.b I,I,1,1,0           ; brightest
l019:	.dc.b 0,I,',',I,',',I,1,1,0             ; bank load
l020:	.dc.b I,I,',',I,1,1,0     ; bank length
l021:	.dc.b 0,I,',',I,',',I,1,1,0             ; bank copy
l022:	.dc.b I,I,',',I,1,1,0     ; bank size
l023:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; m blit
l024:	.dc.b I,I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; win block amount
l025:	.dc.b 0,I,',',I,',',I,',',I,1,1,0     ; replace range
l026:	.dc.b I,I,',',I,',',I,',',I,',',I,',',1,1,0 ; empty FIXME
l027:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0     ; win replace blocks
l028:	.dc.b I,I,',',I,',',I,',',I,',',I,',',I,',',1,1,0 ; empty2 FIXME
l029:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0 ; win replace range
l030:	.dc.b I,I,',',I,',',I,',',I,1,1,0 ; empty3 FIXME
l031:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0     ; win xy block

		.even

entry:  bra.w init

init:
		lea        exit(pc),a2
		rts

exit:
		rts


; -----------------------------------------------------------------------------

/*
 * Syntax: JOEY X1,Y1,X2,Y2,0,0,1
 *         JOEY scr,gadr,img,x,y,colr,0
 */
lib1:
	dc.w	0			; no library calls
joey:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d6
		cmpi.w     #1,d6
		beq        joey_init
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		moveq.l    #0,d4
		move.l     d4,d5
		move.l     d4,d7
		movea.l    d4,a2
		movea.l    d4,a3
		movea.l    d4,a4
		movea.l    d4,a5
		movea.l    d4,a6
joeypatch1:
		cmpi.w     #-64,d1 ; patched with x1-64
		blt        joey_end
joeypatch2:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        joey_end
joeypatch3:
		cmpi.w     #-64,d2 ; patched with y1-64
		blt        joey_end
joeypatch4:
		cmpi.w     #SCREEN_HEIGHT,d2 ; patched with y2
		bge        joey_end
		lea.l      joeypatch55(pc),a2
		move.w     d3,2(a2)
		cmpi.l     #0x38964820,(a1)
		bne        joey_end
		move.w     4(a1),d7
		cmp.w      d7,d0
		bge        joey_end
		lsl.w      #2,d0
		lea.l      38(a1,d0.w),a2
		adda.l     (a2),a1
		move.w     (a1)+,d4
		move.w     (a1)+,d7
		moveq.l    #16,d5
		move.w     (a1)+,d3
		lsr.w      d3,d5
		move.w     d1,d3
		andi.w     #15,d3
		divu.w     d5,d3
		move.w     d3,d0
		mulu.w     (a1)+,d3
		movea.w    (a1)+,a5
		tst.w      d0
		beq.s      joey1
		sub.w      a5,d3
		bra.s      joey2
joey1:
		subi.w     #16,d4
joey2:
		adda.l     d3,a1
		cmpi.w     #99,d6
		bne.s      joey3
		lsr.w      #4,d4
		move.w     d4,d5
		bra        joey35
joey3:
joeypatch5:
		move.w     #0xdead,d5 ; patched with y1
		sub.w      d7,d5
		lea.l      joeypatch9(pc),a2
		move.w     d5,2(a2)
		lea.l      joeypatch12(pc),a2
		move.w     d7,2(a2)
joeypatch6:
		move.w     #SCREEN_HEIGHT,d5 ; patched with y2
		sub.w      d7,d5
		lea.l      joeypatch13(pc),a2
		move.w     d5,2(a2)
		lea.l      joeypatch14(pc),a2
		move.w     d5,2(a2)
joeypatch7:
		cmpi.w     #SCREEN_HEIGHT-1,d2 ; patched with y2
		blt.s      joey4
		bra        joey_end
joey4:
joeypatch8:
		cmpi.w     #0xdead,d2 ; patched with y1
		bge.s      joey6_1
joeypatch9:
		cmpi.w     #-16,d2
		bgt.s      joey5
		bra        joey_end
joey5:
joeypatch10:
		move.w     #0xdead,d7 ; patched with y1
		sub.w      d2,d7
		tst.w      d7
		bpl.s      joey6
		neg.w      d7
joey6:
		move.w     d7,d2
		lsl.w      #2,d2
		adda.w     d2,a1
joeypatch11:
		move.w     #0xdead,d2 ; patched with y1
joeypatch12:
		move.w     #-16,d6
		sub.w      d7,d6
		move.w     d6,d7
		bra.s      joey7
joey6_1:
joeypatch13:
		cmpi.w     #SCREEN_HEIGHT-16,d2
		ble.s      joey7
		move.w     d2,d6
joeypatch14:
		subi.w     #SCREEN_HEIGHT-16,d6
		sub.w      d6,d7
joey7:
		lsr.w      #3,d4
		lea.l      joey_jtab(pc),a2
		adda.w     0(a2,d4.w),a2
		jmp        (a2)

joey_jtab:
		dc.w joey34-joey_jtab
		dc.w joey30-joey_jtab
		dc.w joey25-joey_jtab
		dc.w joey18-joey_jtab
; BUG? missing entry, joey9 cannot be reached                      

joey9:
joeypatch15:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      joey13
joeypatch16:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      joey10
		adda.w     a5,a1
		moveq.l    #3,d5
joeypatch17:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey10:
joeypatch18:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      joey11
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #2,d5
joeypatch19:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey11:
joeypatch20:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt.s      joey12
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
joeypatch21:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey12:
joeypatch22:
		cmpi.w     #-64,d1 ; patched with x1-64
		ble        joey_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
joeypatch23:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey13:
joeypatch24:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        joey_end
joeypatch25:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      joey14
		moveq.l    #0,d5
		bra        joey35
joey14:
joeypatch26:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      joey15
		moveq.l    #1,d5
		bra        joey35
joey15:
joeypatch27:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      joey16
		moveq.l    #2,d5
		bra        joey35
joey16:
joeypatch28:
		cmpi.w     #SCREEN_WIDTH-64,d1 ; patched with x2-64
		blt.s      joey17
		moveq.l    #3,d5
		bra        joey35
joey17:
		moveq.l    #4,d5
		bra        joey35
joey18:
joeypatch29:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      joey21
joeypatch30:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      joey19
		adda.w     a5,a1
		moveq.l    #2,d5
joeypatch31:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey19:
joeypatch32:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      joey20
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
joeypatch33:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey20:
joeypatch34:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt        joey_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
joeypatch35:
		move.w     #0xdead,d1 ; patched with x1
		bra        joey35
joey21:
joeypatch36:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        joey_end
joeypatch37:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      joey22
		moveq.l    #0,d5
		bra        joey35
joey22:
joeypatch38:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      joey23
		moveq.l    #1,d5
		bra        joey35
joey23:
joeypatch39:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      joey24
		moveq.l    #2,d5
		bra        joey35
joey24:
		moveq.l    #3,d5
		bra        joey35
joey25:
joeypatch40:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      joey27
joeypatch41:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      joey26
		adda.w     a5,a1
		moveq.l    #1,d5
joeypatch42:
		move.w     #0xdead,d1 ; patched with x1
		bra.s      joey35
joey26:
joeypatch43:
		cmpi.w     #-32,d1 ; patched with x1-32
		ble        joey_end
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
joeypatch44:
		move.w     #0xdead,d1 ; patched with x1
		bra.s      joey35
joey27:
joeypatch45:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        joey_end
joeypatch46:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      joey28
		moveq.l    #0,d5
		bra.s      joey35
joey28:
joeypatch47:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      joey29
		moveq.l    #1,d5
		bra.s      joey35
joey29:
		moveq.l    #2,d5
		bra.s      joey35
joey30:
joeypatch48:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      joey31
joeypatch49:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt        joey_end
		adda.w     a5,a1
		moveq.l    #0,d5
joeypatch50:
		move.w     #0xdead,d1 ; patched with x1
		bra.s      joey35
joey31:
joeypatch51:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		blt.s      joey32
		bra        joey_end
joey32:
joeypatch52:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      joey33
		moveq.l    #0,d5
		bra.s      joey35
joey33:
		moveq.l    #1,d5
		bra.s      joey35
joey34:
joeypatch53:
		cmpi.w     #0xdead,d1 ; patched with x1
		blt        joey_end
joeypatch54:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        joey_end
		moveq.l    #0,d5
joey35:
		andi.w     #-16,d1
		lsr.w      #1,d1
		add.w      d2,d2
		lea.l      lineoffset_table(pc),a2
		adda.w     0(a2,d2.w),a0
		adda.w     d1,a0
		subq.w     #1,d7
		movea.l    a0,a2
		move.w     d7,d6
		movea.l    a1,a3
joeypatch55:
		move.w     #0xdead,d3
		andi.w     #15,d3
		add.w      d3,d3
		lea.l      joey_jtab2(pc),a4
		adda.w     0(a4,d3.w),a4
		jmp        (a4)

joey_jtab2:
		dc.w joey36-joey_jtab2
		dc.w joey37-joey_jtab2
		dc.w joey38-joey_jtab2
		dc.w joey39-joey_jtab2
		dc.w joey40-joey_jtab2
		dc.w joey41-joey_jtab2
		dc.w joey42-joey_jtab2
		dc.w joey43-joey_jtab2
		dc.w joey44-joey_jtab2
		dc.w joey45-joey_jtab2
		dc.w joey46-joey_jtab2
		dc.w joey47-joey_jtab2
		dc.w joey48-joey_jtab2
		dc.w joey49-joey_jtab2
		dc.w joey50-joey_jtab2
		dc.w joey51-joey_jtab2
 
joey36:
		move.l     (a1)+,d1
		not.l      d1
		and.l      d1,(a0)+
		and.l      d1,(a0)
		lea.l      156(a0),a0
		dbf        d7,joey36
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey36
		bra        joey_end
joey37:
		move.l     (a1)+,d0
		or.w       d0,(a0)+
		not.l      d0
		and.l      d0,(a0)+
		and.w      d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey37
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey37
		bra        joey_end
joey38:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d1,(a0)
		lea.l      156(a0),a0
		dbf        d7,joey38
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey38
		bra        joey_end
joey39:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.l       d0,(a0)+
		and.l      d1,(a0)
		lea.l      156(a0),a0
		dbf        d7,joey39
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey39
		bra        joey_end
joey40:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey40
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey40
		bra        joey_end
joey41:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey41
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey41
		bra        joey_end
joey42:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey42
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey42
		bra        joey_end
joey43:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.l       d0,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey43
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey43
		bra        joey_end
joey44:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.l      d1,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey44
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey44
		bra        joey_end
joey45:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey45
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey45
		bra        joey_end
joey46:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey46
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey46
		bra        joey_end
joey47:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey47
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey47
		bra        joey_end
joey48:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.l      d1,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		dbf        d7,joey48
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey48
		bra        joey_end
joey49:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		dbf        d7,joey49
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey49
		bra        joey_end
joey50:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,joey50
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,joey50
		bra        joey_end
joey51:
		moveq.l    #63,d6
		sub.w      d7,d6
		move.w     d6,d7
		lsl.w      #3,d6
		add.w      d7,d6
		add.w      d7,d6
joey52:
		lea.l      joey53(pc,d6.w),a4
		jmp        (a4)
joey53:
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		or.l       d0,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		dbf        d5,joey52
joey_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

joey_init:
		addq.w     #8,a6 ; skip dummy args
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x2
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		bge.s      joey_init1
		moveq.l    #0,d0
joey_init1:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      joey_init2
		move.w     #SCREEN_WIDTH,d2
joey_init2:
		/* tst.w     d1 */
		dc.w 0x0c41,0 /* XXX */
		bge.s      joey_init3
		moveq.l    #0,d1
joey_init3:
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.s      joey_init4
		move.w     #SCREEN_HEIGHT,d3
joey_init4:
		andi.w     #-16,d0
		andi.w     #-16,d2
		lea.l      joeypatch8(pc),a0
		move.w     d1,2(a0)
		lea.l      joeypatch11(pc),a0
		move.w     d1,2(a0)
		lea.l      joeypatch10(pc),a0
		move.w     d1,2(a0)
		lea.l      joeypatch5(pc),a0
		move.w     d1,2(a0)
		subi.w     #64,d1
		lea.l      joeypatch3(pc),a0
		move.w     d1,2(a0)
		lea.l      joeypatch7(pc),a0
		move.w     d3,2(a0)
		lea.l      joeypatch6(pc),a0
		move.w     d3,2(a0)
		lea.l      joeypatch4(pc),a0
		move.w     d3,2(a0)
		lea.l      joeypatch48(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch53(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch40(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch42(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch44(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch50(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch29(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch31(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch33(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch35(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch15(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch17(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch19(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch21(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch23(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      joeypatch49(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch41(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch30(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch16(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      joeypatch43(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch32(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch18(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      joeypatch34(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch20(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      joeypatch22(pc),a0 ; BUG: not patched
		lea.l      joeypatch1(pc),a0
		move.w     d0,2(a0)
		lea.l      joeypatch51(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch45(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch36(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch54(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch24(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch2(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      joeypatch52(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch46(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch37(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch25(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      joeypatch47(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch38(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch26(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      joeypatch39(pc),a0
		move.w     d2,2(a0)
		lea.l      joeypatch27(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      joeypatch28(pc),a0
		move.w     d2,2(a0)

		movem.l    (a7)+,a0-a5
		rts

lineoffset_table:
	dc.w 0*160
	dc.w 1*160
	dc.w 2*160
	dc.w 3*160
	dc.w 4*160
	dc.w 5*160
	dc.w 6*160
	dc.w 7*160
	dc.w 8*160
	dc.w 9*160
	dc.w 10*160
	dc.w 11*160
	dc.w 12*160
	dc.w 13*160
	dc.w 14*160
	dc.w 15*160
	dc.w 16*160
	dc.w 17*160
	dc.w 18*160
	dc.w 19*160
	dc.w 20*160
	dc.w 21*160
	dc.w 22*160
	dc.w 23*160
	dc.w 24*160
	dc.w 25*160
	dc.w 26*160
	dc.w 27*160
	dc.w 28*160
	dc.w 29*160
	dc.w 30*160
	dc.w 31*160
	dc.w 32*160
	dc.w 33*160
	dc.w 34*160
	dc.w 35*160
	dc.w 36*160
	dc.w 37*160
	dc.w 38*160
	dc.w 39*160
	dc.w 40*160
	dc.w 41*160
	dc.w 42*160
	dc.w 43*160
	dc.w 44*160
	dc.w 45*160
	dc.w 46*160
	dc.w 47*160
	dc.w 48*160
	dc.w 49*160
	dc.w 50*160
	dc.w 51*160
	dc.w 52*160
	dc.w 53*160
	dc.w 54*160
	dc.w 55*160
	dc.w 56*160
	dc.w 57*160
	dc.w 58*160
	dc.w 59*160
	dc.w 60*160
	dc.w 61*160
	dc.w 62*160
	dc.w 63*160
	dc.w 64*160
	dc.w 65*160
	dc.w 66*160
	dc.w 67*160
	dc.w 68*160
	dc.w 69*160
	dc.w 70*160
	dc.w 71*160
	dc.w 72*160
	dc.w 73*160
	dc.w 74*160
	dc.w 75*160
	dc.w 76*160
	dc.w 77*160
	dc.w 78*160
	dc.w 79*160
	dc.w 80*160
	dc.w 81*160
	dc.w 82*160
	dc.w 83*160
	dc.w 84*160
	dc.w 85*160
	dc.w 86*160
	dc.w 87*160
	dc.w 88*160
	dc.w 89*160
	dc.w 90*160
	dc.w 91*160
	dc.w 92*160
	dc.w 93*160
	dc.w 94*160
	dc.w 95*160
	dc.w 96*160
	dc.w 97*160
	dc.w 98*160
	dc.w 99*160
	dc.w 100*160
	dc.w 101*160
	dc.w 102*160
	dc.w 103*160
	dc.w 104*160
	dc.w 105*160
	dc.w 106*160
	dc.w 107*160
	dc.w 108*160
	dc.w 109*160
	dc.w 110*160
	dc.w 111*160
	dc.w 112*160
	dc.w 113*160
	dc.w 114*160
	dc.w 115*160
	dc.w 116*160
	dc.w 117*160
	dc.w 118*160
	dc.w 119*160
	dc.w 120*160
	dc.w 121*160
	dc.w 122*160
	dc.w 123*160
	dc.w 124*160
	dc.w 125*160
	dc.w 126*160
	dc.w 127*160
	dc.w 128*160
	dc.w 129*160
	dc.w 130*160
	dc.w 131*160
	dc.w 132*160
	dc.w 133*160
	dc.w 134*160
	dc.w 135*160
	dc.w 136*160
	dc.w 137*160
	dc.w 138*160
	dc.w 139*160
	dc.w 140*160
	dc.w 141*160
	dc.w 142*160
	dc.w 143*160
	dc.w 144*160
	dc.w 145*160
	dc.w 146*160
	dc.w 147*160
	dc.w 148*160
	dc.w 149*160
	dc.w 150*160
	dc.w 151*160
	dc.w 152*160
	dc.w 153*160
	dc.w 154*160
	dc.w 155*160
	dc.w 156*160
	dc.w 157*160
	dc.w 158*160
	dc.w 159*160
	dc.w 160*160
	dc.w 161*160
	dc.w 162*160
	dc.w 163*160
	dc.w 164*160
	dc.w 165*160
	dc.w 166*160
	dc.w 167*160
	dc.w 168*160
	dc.w 169*160
	dc.w 170*160
	dc.w 171*160
	dc.w 172*160
	dc.w 173*160
	dc.w 174*160
	dc.w 175*160
	dc.w 176*160
	dc.w 177*160
	dc.w 178*160
	dc.w 179*160
	dc.w 180*160
	dc.w 181*160
	dc.w 182*160
	dc.w 183*160
	dc.w 184*160
	dc.w 185*160
	dc.w 186*160
	dc.w 187*160
	dc.w 188*160
	dc.w 189*160
	dc.w 190*160
	dc.w 191*160
	dc.w 192*160
	dc.w 193*160
	dc.w 194*160
	dc.w 195*160
	dc.w 196*160
	dc.w 197*160
	dc.w 198*160
	dc.w 199*160

; -----------------------------------------------------------------------------

/*
 * Syntax: h = B HEIGHT (gadr,img)
 */
lib2:
	dc.w	0			; no library calls
b_height:
		move.l     a1,-(a7)
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		moveq.l    #0,d3
		cmpi.l     #0x38964820,(a1)
		bne        b_height1
		move.w     4(a1),d7
		cmp.w      d7,d0
		bge        b_height1
		lsl.w      #2,d0
		lea.l      38(a1,d0.w),a2
		adda.l     (a2),a1
		move.w     2(a1),d3
b_height1:
		move.l     d3,-(a6)
		movea.l    (a7)+,a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: BLIT scr1,x1,y1,x2,y2,scr2,x3,y3
 */
lib3:
	dc.w	0			; no library calls
blit:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		move.l     (a6)+,a1
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		subq.w     #1,d3
		tst.w      d2
		bge.s      blit1
		moveq.l    #0,d2
blit1:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      blit2
		move.w     #SCREEN_WIDTH,d2
blit2:
		tst.w      d3
		bge.s      blit3
		moveq.l    #0,d3
blit3:
		cmpi.w     #SCREEN_HEIGHT-1,d3
		ble.s      blit4
		move.w     #SCREEN_HEIGHT-1,d3
blit4:
		andi.w     #-16,d4
		move.w     d2,d6
		tst.w      d6
		bmi.s      blit5
		sub.w      d0,d6
		bra.s      blit6
blit5:
		add.w      d0,d6
blit6:
		tst.w      d4
		bge.s      blit7
		sub.w      d4,d0
		moveq.l    #0,d4
		moveq.l    #0,d6
		move.w     d2,d6
		sub.w      d0,d6
		bra.s      blit8
blit7:
		move.w     d4,d7
		add.w      d6,d7
		cmpi.w     #SCREEN_WIDTH,d7
		blt.s      blit8
		subi.w     #SCREEN_WIDTH,d7
		sub.w      d7,d2
		moveq.l    #0,d6
		move.w     d2,d6
		sub.w      d0,d6
blit8:
		lsr.w      #2,d6
		tst.w      d6
		bgt.s      blit9
		bra        blit_end
blit9:
		cmpi.w     #SCREEN_WIDTH/4,d6
		ble.s      blit10
		bra        blit_end
blit10:
		tst.w      d5
		bge.s      blit11
		neg.w      d5
		add.w      d5,d1
		moveq.l    #0,d5
		move.w     d3,d7
		sub.w      d1,d7
		bra.s      blit12
blit11:
		move.w     d3,d7
		sub.w      d1,d7
		moveq.l    #0,d6
		move.w     d5,d6
		add.w      d7,d6
		cmpi.w     #SCREEN_HEIGHT-1,d6
		ble.s      blit12
		subi.w     #SCREEN_HEIGHT-1,d6
		sub.w      d6,d3
		move.w     d3,d7
		sub.w      d1,d7
blit12:
		tst.w      d7
		bge.s      blit13
		bra        blit_end
blit13:
		cmpi.w     #SCREEN_HEIGHT-1,d7
		ble.s      blit14
		move.w     #SCREEN_HEIGHT-1,d7
blit14:
		andi.w     #-16,d0
		andi.w     #-16,d2
		move.w     d2,d6
		sub.w      d0,d6
		lsr.w      #4,d6
		add.w      d6,d6
		lsr.w      #1,d0
		lsr.w      #1,d4
		adda.w     d0,a0
		adda.w     d4,a1
		move.w     d3,d7
		sub.w      d1,d7
		add.w      d1,d1
		add.w      d5,d5
		lea.l      lineoffset_table2(pc),a3
		adda.w     0(a3,d1.w),a0
		adda.w     0(a3,d5.w),a1
		lea.l      blit_jtab(pc),a3
		adda.w     0(a3,d6.w),a3
		jmp        (a3)

blit_jtab:
	dc.w blit_end-blit_jtab
	dc.w blit15-blit_jtab
	dc.w blit16-blit_jtab
	dc.w blit17-blit_jtab
	dc.w blit18-blit_jtab
	dc.w blit19-blit_jtab
	dc.w blit20-blit_jtab
	dc.w blit21-blit_jtab
	dc.w blit22-blit_jtab
	dc.w blit23-blit_jtab
	dc.w blit24-blit_jtab
	dc.w blit25-blit_jtab
	dc.w blit26-blit_jtab
	dc.w blit27-blit_jtab
	dc.w blit28-blit_jtab
	dc.w blit29-blit_jtab
	dc.w blit30-blit_jtab
	dc.w blit31-blit_jtab
	dc.w blit32-blit_jtab
	dc.w blit33-blit_jtab
	dc.w blit34-blit_jtab

blit15:
		movem.l    (a0),d0-d1
		movem.l    d0-d1,(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit15
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit16:
		movem.l    (a0),d0-d3
		movem.l    d0-d3,(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit16
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit17:
		movem.l    (a0),d0-d5
		movem.l    d0-d5,(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit17
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit18:
		movem.l    (a0),d0-d6/a3
		movem.l    d0-d6/a3,(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit18
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit19:
		movem.l    (a0),d0-d6/a3-a5
		movem.l    d0-d6/a3-a5,(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit19
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit20:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		move.l     44(a0),d0
		move.l     d0,44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit20
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit21:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d2
		movem.l    d0-d2,44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit21
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit22:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d4
		movem.l    d0-d4,44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit22
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit23:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6
		movem.l    d0-d6,44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit23
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit24:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a4
		movem.l    d0-d6/a3-a4,44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit24
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit25:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit25
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit26:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d1
		movem.l    d0-d1,88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit26
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit27:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d3
		movem.l    d0-d3,88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit27
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit28:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d5
		movem.l    d0-d5,88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit28
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit29:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3
		movem.l    d0-d6/a3,88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit29
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit30:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a5
		movem.l    d0-d6/a3-a5,88(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit30
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit31:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		move.l     132(a0),d0
		move.l     d0,132(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit31
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit32:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d2
		movem.l    d0-d2,132(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit32
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit33:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d4
		movem.l    d0-d4,132(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit33
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts
blit34:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d6
		movem.l    d0-d6,132(a1)
		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,blit34

blit_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

lineoffset_table2:
	dc.w 0*160
	dc.w 1*160
	dc.w 2*160
	dc.w 3*160
	dc.w 4*160
	dc.w 5*160
	dc.w 6*160
	dc.w 7*160
	dc.w 8*160
	dc.w 9*160
	dc.w 10*160
	dc.w 11*160
	dc.w 12*160
	dc.w 13*160
	dc.w 14*160
	dc.w 15*160
	dc.w 16*160
	dc.w 17*160
	dc.w 18*160
	dc.w 19*160
	dc.w 20*160
	dc.w 21*160
	dc.w 22*160
	dc.w 23*160
	dc.w 24*160
	dc.w 25*160
	dc.w 26*160
	dc.w 27*160
	dc.w 28*160
	dc.w 29*160
	dc.w 30*160
	dc.w 31*160
	dc.w 32*160
	dc.w 33*160
	dc.w 34*160
	dc.w 35*160
	dc.w 36*160
	dc.w 37*160
	dc.w 38*160
	dc.w 39*160
	dc.w 40*160
	dc.w 41*160
	dc.w 42*160
	dc.w 43*160
	dc.w 44*160
	dc.w 45*160
	dc.w 46*160
	dc.w 47*160
	dc.w 48*160
	dc.w 49*160
	dc.w 50*160
	dc.w 51*160
	dc.w 52*160
	dc.w 53*160
	dc.w 54*160
	dc.w 55*160
	dc.w 56*160
	dc.w 57*160
	dc.w 58*160
	dc.w 59*160
	dc.w 60*160
	dc.w 61*160
	dc.w 62*160
	dc.w 63*160
	dc.w 64*160
	dc.w 65*160
	dc.w 66*160
	dc.w 67*160
	dc.w 68*160
	dc.w 69*160
	dc.w 70*160
	dc.w 71*160
	dc.w 72*160
	dc.w 73*160
	dc.w 74*160
	dc.w 75*160
	dc.w 76*160
	dc.w 77*160
	dc.w 78*160
	dc.w 79*160
	dc.w 80*160
	dc.w 81*160
	dc.w 82*160
	dc.w 83*160
	dc.w 84*160
	dc.w 85*160
	dc.w 86*160
	dc.w 87*160
	dc.w 88*160
	dc.w 89*160
	dc.w 90*160
	dc.w 91*160
	dc.w 92*160
	dc.w 93*160
	dc.w 94*160
	dc.w 95*160
	dc.w 96*160
	dc.w 97*160
	dc.w 98*160
	dc.w 99*160
	dc.w 100*160
	dc.w 101*160
	dc.w 102*160
	dc.w 103*160
	dc.w 104*160
	dc.w 105*160
	dc.w 106*160
	dc.w 107*160
	dc.w 108*160
	dc.w 109*160
	dc.w 110*160
	dc.w 111*160
	dc.w 112*160
	dc.w 113*160
	dc.w 114*160
	dc.w 115*160
	dc.w 116*160
	dc.w 117*160
	dc.w 118*160
	dc.w 119*160
	dc.w 120*160
	dc.w 121*160
	dc.w 122*160
	dc.w 123*160
	dc.w 124*160
	dc.w 125*160
	dc.w 126*160
	dc.w 127*160
	dc.w 128*160
	dc.w 129*160
	dc.w 130*160
	dc.w 131*160
	dc.w 132*160
	dc.w 133*160
	dc.w 134*160
	dc.w 135*160
	dc.w 136*160
	dc.w 137*160
	dc.w 138*160
	dc.w 139*160
	dc.w 140*160
	dc.w 141*160
	dc.w 142*160
	dc.w 143*160
	dc.w 144*160
	dc.w 145*160
	dc.w 146*160
	dc.w 147*160
	dc.w 148*160
	dc.w 149*160
	dc.w 150*160
	dc.w 151*160
	dc.w 152*160
	dc.w 153*160
	dc.w 154*160
	dc.w 155*160
	dc.w 156*160
	dc.w 157*160
	dc.w 158*160
	dc.w 159*160
	dc.w 160*160
	dc.w 161*160
	dc.w 162*160
	dc.w 163*160
	dc.w 164*160
	dc.w 165*160
	dc.w 166*160
	dc.w 167*160
	dc.w 168*160
	dc.w 169*160
	dc.w 170*160
	dc.w 171*160
	dc.w 172*160
	dc.w 173*160
	dc.w 174*160
	dc.w 175*160
	dc.w 176*160
	dc.w 177*160
	dc.w 178*160
	dc.w 179*160
	dc.w 180*160
	dc.w 181*160
	dc.w 182*160
	dc.w 183*160
	dc.w 184*160
	dc.w 185*160
	dc.w 186*160
	dc.w 187*160
	dc.w 188*160
	dc.w 189*160
	dc.w 190*160
	dc.w 191*160
	dc.w 192*160
	dc.w 193*160
	dc.w 194*160
	dc.w 195*160
	dc.w 196*160
	dc.w 197*160
	dc.w 198*160
	dc.w 199*160

; -----------------------------------------------------------------------------

/*
 * Syntax: w = B WIDTH (gadr,img)
 */
lib4:
	dc.w	0			; no library calls
b_width:
		move.l     a1,-(a7)
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		moveq.l    #0,d3
		cmpi.l     #0x38964820,(a1)
		bne        b_width1
		move.w     4(a1),d7
		cmp.w      d7,d0
		bge        b_width1
		lsl.w      #2,d0
		lea.l      38(a1,d0.w),a2
		adda.l     (a2),a1
		move.w     (a1),d3
b_width1:
		move.l     d3,-(a6)
		move.l     (a7)+,a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: SPOT scr,x,y,colr
 */
lib5:
	dc.w	0			; no library calls
spot:
		movem.l    a0-a2,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		add.w      d1,d1
		lea.l      lineoffset_table3(pc),a1
		adda.w     0(a1,d1.w),a0
		move.w     d0,d1
		andi.w     #-16,d1
		lsr.w      #1,d1
		adda.w     d1,a0
		andi.w     #15,d0
		lsl.w      #3,d0
		lea.l      spot_masktab(pc,d0.w),a1
		movem.l    (a1),d0-d1
		add.w      d2,d2
		lea.l      spot_jtab(pc),a2
		adda.w     0(a2,d2.w),a2
		jmp        (a2)

spot_masktab:
	dc.l 0x80008000,0x7fff7fff
	dc.l 0x40004000,0xbfffbfff
	dc.l 0x20002000,0xdfffdfff
	dc.l 0x10001000,0xefffefff
	dc.l 0x08000800,0xf7fff7ff
	dc.l 0x04000400,0xfbfffbff
	dc.l 0x02000200,0xfdfffdff
	dc.l 0x01000100,0xfefffeff
	dc.l 0x00800080,0xff7fff7f
	dc.l 0x00400040,0xffbfffbf
	dc.l 0x00200020,0xffdfffdf
	dc.l 0x00100010,0xffefffef
	dc.l 0x00080008,0xfff7fff7
	dc.l 0x00040004,0xfffbfffb
	dc.l 0x00020002,0xfffdfffd
	dc.l 0x00010001,0xfffefffe

spot_jbase:
spot_jtab:
	dc.w spot0-spot_jbase
	dc.w spot1-spot_jbase
	dc.w spot2-spot_jbase
	dc.w spot3-spot_jbase
	dc.w spot4-spot_jbase
	dc.w spot5-spot_jbase
	dc.w spot6-spot_jbase
	dc.w spot7-spot_jbase
	dc.w spot8-spot_jbase
	dc.w spot9-spot_jbase
	dc.w spot10-spot_jbase
	dc.w spot11-spot_jbase
	dc.w spot12-spot_jbase
	dc.w spot13-spot_jbase
	dc.w spot14-spot_jbase
	dc.w spot15-spot_jbase

spot0:
		and.l      d1,(a0)+
		and.l      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot1:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		and.l      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot2:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot3:
		or.l       d0,(a0)+
		and.l      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot4:
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot5:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot6:
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		and.w      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot7:
		or.l       d0,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot8:
		and.l      d1,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot9:
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		or.w       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot10:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot11:
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot12:
		and.l      d1,(a0)+
		or.l       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot13:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot14:
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		or.w       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

spot15:
		or.l       d0,(a0)+
		or.l       d0,(a0)
		movem.l    (a7)+,a0-a2
		rts

lineoffset_table3:
	dc.w 0*160
	dc.w 1*160
	dc.w 2*160
	dc.w 3*160
	dc.w 4*160
	dc.w 5*160
	dc.w 6*160
	dc.w 7*160
	dc.w 8*160
	dc.w 9*160
	dc.w 10*160
	dc.w 11*160
	dc.w 12*160
	dc.w 13*160
	dc.w 14*160
	dc.w 15*160
	dc.w 16*160
	dc.w 17*160
	dc.w 18*160
	dc.w 19*160
	dc.w 20*160
	dc.w 21*160
	dc.w 22*160
	dc.w 23*160
	dc.w 24*160
	dc.w 25*160
	dc.w 26*160
	dc.w 27*160
	dc.w 28*160
	dc.w 29*160
	dc.w 30*160
	dc.w 31*160
	dc.w 32*160
	dc.w 33*160
	dc.w 34*160
	dc.w 35*160
	dc.w 36*160
	dc.w 37*160
	dc.w 38*160
	dc.w 39*160
	dc.w 40*160
	dc.w 41*160
	dc.w 42*160
	dc.w 43*160
	dc.w 44*160
	dc.w 45*160
	dc.w 46*160
	dc.w 47*160
	dc.w 48*160
	dc.w 49*160
	dc.w 50*160
	dc.w 51*160
	dc.w 52*160
	dc.w 53*160
	dc.w 54*160
	dc.w 55*160
	dc.w 56*160
	dc.w 57*160
	dc.w 58*160
	dc.w 59*160
	dc.w 60*160
	dc.w 61*160
	dc.w 62*160
	dc.w 63*160
	dc.w 64*160
	dc.w 65*160
	dc.w 66*160
	dc.w 67*160
	dc.w 68*160
	dc.w 69*160
	dc.w 70*160
	dc.w 71*160
	dc.w 72*160
	dc.w 73*160
	dc.w 74*160
	dc.w 75*160
	dc.w 76*160
	dc.w 77*160
	dc.w 78*160
	dc.w 79*160
	dc.w 80*160
	dc.w 81*160
	dc.w 82*160
	dc.w 83*160
	dc.w 84*160
	dc.w 85*160
	dc.w 86*160
	dc.w 87*160
	dc.w 88*160
	dc.w 89*160
	dc.w 90*160
	dc.w 91*160
	dc.w 92*160
	dc.w 93*160
	dc.w 94*160
	dc.w 95*160
	dc.w 96*160
	dc.w 97*160
	dc.w 98*160
	dc.w 99*160
	dc.w 100*160
	dc.w 101*160
	dc.w 102*160
	dc.w 103*160
	dc.w 104*160
	dc.w 105*160
	dc.w 106*160
	dc.w 107*160
	dc.w 108*160
	dc.w 109*160
	dc.w 110*160
	dc.w 111*160
	dc.w 112*160
	dc.w 113*160
	dc.w 114*160
	dc.w 115*160
	dc.w 116*160
	dc.w 117*160
	dc.w 118*160
	dc.w 119*160
	dc.w 120*160
	dc.w 121*160
	dc.w 122*160
	dc.w 123*160
	dc.w 124*160
	dc.w 125*160
	dc.w 126*160
	dc.w 127*160
	dc.w 128*160
	dc.w 129*160
	dc.w 130*160
	dc.w 131*160
	dc.w 132*160
	dc.w 133*160
	dc.w 134*160
	dc.w 135*160
	dc.w 136*160
	dc.w 137*160
	dc.w 138*160
	dc.w 139*160
	dc.w 140*160
	dc.w 141*160
	dc.w 142*160
	dc.w 143*160
	dc.w 144*160
	dc.w 145*160
	dc.w 146*160
	dc.w 147*160
	dc.w 148*160
	dc.w 149*160
	dc.w 150*160
	dc.w 151*160
	dc.w 152*160
	dc.w 153*160
	dc.w 154*160
	dc.w 155*160
	dc.w 156*160
	dc.w 157*160
	dc.w 158*160
	dc.w 159*160
	dc.w 160*160
	dc.w 161*160
	dc.w 162*160
	dc.w 163*160
	dc.w 164*160
	dc.w 165*160
	dc.w 166*160
	dc.w 167*160
	dc.w 168*160
	dc.w 169*160
	dc.w 170*160
	dc.w 171*160
	dc.w 172*160
	dc.w 173*160
	dc.w 174*160
	dc.w 175*160
	dc.w 176*160
	dc.w 177*160
	dc.w 178*160
	dc.w 179*160
	dc.w 180*160
	dc.w 181*160
	dc.w 182*160
	dc.w 183*160
	dc.w 184*160
	dc.w 185*160
	dc.w 186*160
	dc.w 187*160
	dc.w 188*160
	dc.w 189*160
	dc.w 190*160
	dc.w 191*160
	dc.w 192*160
	dc.w 193*160
	dc.w 194*160
	dc.w 195*160
	dc.w 196*160
	dc.w 197*160
	dc.w 198*160
	dc.w 199*160

; -----------------------------------------------------------------------------

/*
 * Syntax: r = BLOCK AMOUNT(madr,blk)
 */
lib6:
	dc.w	0			; no library calls
block_amount:
		move.l     a0,-(a7)
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		moveq.l    #0,d3
		cmpi.l     #0x03031973,(a0)+
		bne.s      block_amount1
		moveq.l    #7,d4
		bra.s      block_amount2
block_amount1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        block_amount5
		moveq.l    #8,d4
block_amount2:
		moveq.l    #0,d2
		moveq.l    #0,d3
		movem.w    (a0)+,d2-d3
		addq.w     #2,d2
		lsr.w      #1,d2
		lsr.w      #1,d3
		mulu.w     d3,d2
		subq.w     #1,d2
		lsl.w      d4,d0
		moveq.l    #0,d3
block_amount3:
		move.w     (a0)+,d1
		cmp.w      d1,d0
		bne.s      block_amount4
		addq.w     #1,d3
block_amount4:
		dbf        d2,block_amount3
		move.l     d3,-(a6)
block_amount5: /* BUG: must be above */
		move.l     (a7)+,a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: REFLECT scr1,y1,y2,scr2,y3
 */
lib7:
	dc.w	0			; no library calls
reflect:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,a1
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		tst.w      d0
		bge.s      reflect1
		moveq.l    #0,d0
reflect1:
		tst.w      d1
		bge.s      reflect2
		moveq.l    #0,d1
reflect2:
		tst.w      d2
		bge.s      reflect3
		moveq.l    #0,d2
reflect3:
		cmpi.w     #SCREEN_HEIGHT-1,d0
		ble.s      reflect4
		move.w     #SCREEN_HEIGHT-1,d0
reflect4:
		cmpi.w     #SCREEN_HEIGHT-1,d1
		ble.s      reflect5
		move.w     #SCREEN_HEIGHT-1,d1
reflect5:
		cmpi.w     #SCREEN_HEIGHT-1,d2
		ble.s      reflect6
		move.w     #SCREEN_HEIGHT-1,d2
reflect6:
		moveq.l    #0,d7
		move.w     d1,d7
		sub.w      d0,d7
		subq.w     #1,d7
		add.w      d7,d0
		mulu.w     #160,d0
		adda.w     d0,a0
		move.w     #SCREEN_HEIGHT-1,d6
		sub.w      d2,d6
		tst.w      d6
		ble.s      reflect_end
		subq.w     #7,d7
		lsr.w      #1,d7
		cmp.w      d6,d7
		ble.s      reflect7
		move.w     d6,d7
reflect7:
		mulu.w     #160,d2
		adda.w     d2,a1
		lea.l      reflect_state(pc),a2
		movem.w    (a2),d0-d1
		tst.w      d0
		beq.s      reflect8
		addq.w     #2,d1
reflect8:
		eori.w     #1,d0
		cmpi.w     #38,d1
		ble.s      reflect9
		moveq.l    #0,d1
reflect9:
		movem.w    d0-d1,(a2)
		lea.l      reflect_table(pc,d1.w),a2
reflect10:
		movem.l    (a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,(a1)
		movem.l    44(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,44(a1)
		movem.l    88(a0),d0-d6/a3-a6
		movem.l    d0-d6/a3-a6,88(a1)
		movem.l    132(a0),d0-d6
		movem.l    d0-d6,132(a1)
		suba.w     (a2)+,a0
		lea.l      160(a1),a1
		dbf        d7,reflect10
reflect_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

reflect_state: dc.w 0,0

reflect_table:
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0
	dc.w 160
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 320
	dc.w 480
	dc.w 480
	dc.w 640
	dc.w 640
	dc.w 480
	dc.w 480
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 320
	dc.w 320
	dc.w 160
	dc.w 160
	dc.w 160
	dc.w 0

; -----------------------------------------------------------------------------

/*
 * Syntax: d = COMPSTATE
 */
lib8:
	dc.w	0			; no library calls
compstate:
		move.l     #-1,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: MOZAIC scr,gadr,img,x1,y1,x2,y2,x,y
 */
lib9:
	dc.w	0			; no library calls
mozaic:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d6
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		cmpi.l     #0x003D2067,(a1)+
		bne        mozaic_end
		move.w     (a1)+,d7
		cmp.w      d7,d0
		bne.s      mozaic1
		move.w     d7,d0
mozaic1:
		tst.w      d1
		bge.s      mozaic2
		moveq.l    #0,d1
mozaic2:
		tst.w      d2
		bge.s      mozaic3
		moveq.l    #0,d2
mozaic3:
		cmpi.w     #SCREEN_WIDTH,d3
		ble.s      mozaic4
		move.w     #SCREEN_WIDTH,d3
mozaic4:
		cmpi.w     #SCREEN_HEIGHT-1,d4
		ble.s      mozaic5
		move.w     #SCREEN_HEIGHT-1,d4
mozaic5:
		sub.w      d1,d3
		tst.w      d3
		ble        mozaic_end
		sub.w      d2,d4
		tst.w      d4
		ble        mozaic_end
		lsr.w      #4,d1
		lsl.w      #3,d1
		adda.w     d1,a0
		mulu.w     #160,d2
		adda.w     d2,a0
		moveq.l    #12,d1
		lsl.w      d1,d0
		adda.w     d0,a1
		move.w     #15,d0
		and.w      d0,d5
		and.w      d0,d6
		lsl.w      #8,d5
		lea.l      32(a1,d5.w),a1
		lsl.w      #3,d6
		adda.w     d6,a1
		lsr.w      #4,d4
		move.w     d4,d7
		lsl.w      #4,d4
		mulu.w     #160,d4
		adda.w     d4,a0
		andi.w     #-16,d3
		lsr.w      #1,d3
		adda.w     d3,a0
		subq.w     #8,a0
		subq.w     #1,d7
		lsr.w      #2,d3
		lea.l      mozaic_jtable(pc),a2
		adda.w     0(a2,d3.w),a2
		jmp        (a2)

mozaic_jtable:
	dc.w mozaic_end-mozaic_jtable
	dc.w mozaic6-mozaic_jtable
	dc.w mozaic8-mozaic_jtable
	dc.w mozaic10-mozaic_jtable
	dc.w mozaic12-mozaic_jtable
	dc.w mozaic14-mozaic_jtable
	dc.w mozaic16-mozaic_jtable
	dc.w mozaic18-mozaic_jtable
	dc.w mozaic20-mozaic_jtable
	dc.w mozaic22-mozaic_jtable
	dc.w mozaic24-mozaic_jtable
	dc.w mozaic26-mozaic_jtable
	dc.w mozaic28-mozaic_jtable
	dc.w mozaic30-mozaic_jtable
	dc.w mozaic32-mozaic_jtable
	dc.w mozaic34-mozaic_jtable
	dc.w mozaic36-mozaic_jtable
	dc.w mozaic38-mozaic_jtable
	dc.w mozaic40-mozaic_jtable
	dc.w mozaic42-mozaic_jtable
	dc.w mozaic44-mozaic_jtable
	
mozaic6:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic7:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		lea.l      -160(a0),a0
		movem.l    d2-d3,(a0)
		lea.l      -160(a0),a0
		movem.l    d4-d5,(a0)
		lea.l      -160(a0),a0
		movem.l    a3-a4,(a0)
		lea.l      -160(a0),a0
		movem.l    a5-a6,(a0)
		lea.l      -160(a0),a0
		dbf        d6,mozaic7
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		lea.l      -160(a0),a0
		dbf        d7,mozaic6
		bra        mozaic_end

mozaic8:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic9:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -152(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -152(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -152(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -152(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -152(a0),a0
		dbf        d6,mozaic9
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -152(a0),a0
		dbf        d7,mozaic8
		bra        mozaic_end

mozaic10:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic11:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -144(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -144(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -144(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -144(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -144(a0),a0
		dbf        d6,mozaic11
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -144(a0),a0
		dbf        d7,mozaic10
		bra        mozaic_end

mozaic12:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic13:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -136(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -136(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -136(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -136(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -136(a0),a0
		dbf        d6,mozaic13
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -136(a0),a0
		dbf        d7,mozaic12
		bra        mozaic_end

mozaic14:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic15:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -128(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -128(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -128(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -128(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -128(a0),a0
		dbf        d6,mozaic15
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -128(a0),a0
		dbf        d7,mozaic14
		bra        mozaic_end

mozaic16:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic17:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -120(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -120(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -120(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -120(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -120(a0),a0
		dbf        d6,mozaic17
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -120(a0),a0
		dbf        d7,mozaic16
		bra        mozaic_end

mozaic18:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic19:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -112(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -112(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -112(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -112(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -112(a0),a0
		dbf        d6,mozaic19
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -112(a0),a0
		dbf        d7,mozaic18
		bra        mozaic_end

mozaic20:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic21:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -104(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -104(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -104(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -104(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -104(a0),a0
		dbf        d6,mozaic21
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -104(a0),a0
		dbf        d7,mozaic20
		bra        mozaic_end

mozaic22:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic23:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -96(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -96(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -96(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -96(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -96(a0),a0
		dbf        d6,mozaic23
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -96(a0),a0
		dbf        d7,mozaic22
		bra        mozaic_end

mozaic24:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic25:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -88(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -88(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -88(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -88(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -88(a0),a0
		dbf        d6,mozaic25
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -88(a0),a0
		dbf        d7,mozaic24
		bra        mozaic_end

mozaic26:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic27:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -80(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -80(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -80(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -80(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -80(a0),a0
		dbf        d6,mozaic27
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -80(a0),a0
		dbf        d7,mozaic26
		bra        mozaic_end

mozaic28:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic29:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -72(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -72(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -72(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -72(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -72(a0),a0
		dbf        d6,mozaic29
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -72(a0),a0
		dbf        d7,mozaic28
		bra        mozaic_end

mozaic30:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic31:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -64(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -64(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -64(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -64(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -64(a0),a0
		dbf        d6,mozaic31
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -64(a0),a0
		dbf        d7,mozaic30
		bra        mozaic_end

mozaic32:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic33:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -56(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -56(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -56(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -56(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -56(a0),a0
		dbf        d6,mozaic33
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -56(a0),a0
		dbf        d7,mozaic32
		bra        mozaic_end

mozaic34:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic35:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -48(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -48(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -48(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -48(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -48(a0),a0
		dbf        d6,mozaic35
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -48(a0),a0
		dbf        d7,mozaic34
		bra        mozaic_end

mozaic36:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic37:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -40(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -40(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -40(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -40(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -40(a0),a0
		dbf        d6,mozaic37
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -40(a0),a0
		dbf        d7,mozaic36
		bra        mozaic_end

mozaic38:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic39:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -32(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -32(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -32(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -32(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -32(a0),a0
		dbf        d6,mozaic39
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -32(a0),a0
		dbf        d7,mozaic38
		bra        mozaic_end

mozaic40:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic41:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -24(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -24(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -24(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -24(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -24(a0),a0
		dbf        d6,mozaic41
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -24(a0),a0
		dbf        d7,mozaic40
		bra        mozaic_end

mozaic42:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic43:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -16(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -16(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -16(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -16(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -16(a0),a0
		dbf        d6,mozaic43
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -16(a0),a0
		dbf        d7,mozaic42
		bra        mozaic_end

mozaic44:
		movea.l    a1,a2
		moveq.l    #2,d6
mozaic45:
		movem.l    (a2)+,d0-d5/a3-a6
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -8(a0),a0
		movem.l    d2-d3,(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		movem.l    d2-d3,-(a0)
		lea.l      -8(a0),a0
		movem.l    d4-d5,(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		movem.l    d4-d5,-(a0)
		lea.l      -8(a0),a0
		movem.l    a3-a4,(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		movem.l    a3-a4,-(a0)
		lea.l      -8(a0),a0
		movem.l    a5-a6,(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		movem.l    a5-a6,-(a0)
		lea.l      -8(a0),a0
		dbf        d6,mozaic45
		movem.l    (a2)+,d0-d1
		movem.l    d0-d1,(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		movem.l    d0-d1,-(a0)
		lea.l      -8(a0),a0
		dbf        d7,mozaic44

mozaic_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: x = X LIMIT(madr,x1,x2)
 */
lib10:
	dc.w	0			; no library calls
x_limit:
		movem.l    a0,-(a7)
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		beq.s      x_limit1
		cmpi.l     #0x02528E54,-4(a0)
		beq        x_limit1 ; FIXME: simplify
		move.l     #0,-(a6)
		movea.l    (a7)+,a0
		rts
x_limit1:
		sub.w      d0,d1
		andi.w     #-16,d1
		move.w     (a0),d0
		addq.w     #2,d0
		lsl.w      #3,d0
		sub.w      d1,d0
		move.l     d0,-(a6)
		move.l     (a7)+,a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: XY BLOCK madr,xadr,yadr,blk,num
 */
lib11:
	dc.w	0			; no library calls
xy_block:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a2
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		bne.s      xy_block1
		lsl.w      #7,d0
		bra.s      xy_block2
xy_block1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        xy_block6
		lsl.w      #8,d0
xy_block2:
		movem.w    (a0)+,d2-d3
		lsr.w      #1,d2
		lsr.w      #1,d3
		subq.w     #1,d3
		move.w     d2,d5
		moveq.l    #0,d7
xy_block3:
		move.w     d5,d2
		moveq.l    #0,d6
xy_block4:
		cmp.w      (a0)+,d0
		bne.s      xy_block5
		move.l     d6,(a1)+
		move.l     d7,(a2)+
		subq.w     #1,d1
		bmi.s      xy_block6
xy_block5:
		addi.w     #16,d6
		dbf        d2,xy_block4
		addi.w     #16,d7
		dbf        d3,xy_block3
xy_block6:
		movem.l    (a7)+,a0-a5
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: y = Y LIMIT(madr,y1,y2)
 */
lib12:
	dc.w	0			; no library calls
y_limit:
		move.l     a0,-(a7)
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		beq.s      y_limit1
		cmpi.l     #0x02528E54,-4(a0)
		beq        y_limit1 ; FIXME: simplify
		move.l     #0,-(a6)
		movea.l    (a7)+,a0
		rts
y_limit1:
		sub.w      d0,d1
		andi.w     #-16,d1
		move.w     2(a0),d0
		lsl.w      #3,d0
		sub.w      d1,d0
y_limit2:
		move.l     d0,-(a6)
		move.l     (a7)+,a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: TEXT scr,font,tadr,x,y
 */
lib13:
	dc.w	0			; no library calls
text:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,a1
		move.l     (a6)+,a2
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #4,-(a7) ; Getrez
		trap       #14
		addq.w     #2,a7
		movem.l    (a7)+,d1-d7/a0-a6
		cmpa.w     #17,a2
		bgt.s      text1
		movem.l    d0/a0-a1,-(a7)
		move.w     a2,d0
		moveq.l    #W_getcharset,d7
		trap       #3
		movea.l    d0,a2
		movem.l    (a7)+,d0/a0-a1
text1:
		lea.l      8(a2),a2
		tst.w      d0
		bne.s      text2
		moveq.l    #7,d6
		moveq.l    #40,d1
		moveq.l    #24,d2
		moveq.l    #3,d7
		lea.l      textfont_patched(pc),a4
		tst.w      (a4)
		beq        text4
		move.w     #0,(a4)
		lea.l      textpatch1(pc),a4
		move.w     #1280,2(a4)
		lea.l      textpatch2(pc),a4
		move.w     #160,2(a4)
		lea.l      textpatch3(pc),a4
		move.w     #320,2(a4)
		lea.l      textpatch4(pc),a4
		move.w     #480,2(a4)
		lea.l      textpatch5(pc),a4
		move.w     #640,2(a4)
		lea.l      textpatch6(pc),a4
		move.w     #800,2(a4)
		lea.l      textpatch7(pc),a4
		move.w     #960,2(a4)
		lea.l      textpatch8(pc),a4
		move.w     #1120,2(a4)
		lea.l      textpatch9(pc),a4
		move.w     #1280,2(a4)
		bra        text4
text2:
		cmpi.w     #1,d0
		bne.s      text3
		moveq.l    #3,d6
		moveq.l    #80,d1
		moveq.l    #24,d2
		moveq.l    #2,d7
		lea.l      textfont_patched(pc),a4
		tst.w      (a4)
		beq        text4
		move.w     #0,(a4)
		lea.l      textpatch1(pc),a4
		move.w     #1280,2(a4)
		lea.l      textpatch2(pc),a4
		move.w     #160,2(a4)
		lea.l      textpatch3(pc),a4
		move.w     #320,2(a4)
		lea.l      textpatch4(pc),a4
		move.w     #480,2(a4)
		lea.l      textpatch5(pc),a4
		move.w     #640,2(a4)
		lea.l      textpatch6(pc),a4
		move.w     #800,2(a4)
		lea.l      textpatch7(pc),a4
		move.w     #960,2(a4)
		lea.l      textpatch8(pc),a4
		move.w     #1120,2(a4)
		lea.l      textpatch9(pc),a4
		move.w     #1280,2(a4)
		bra.s      text4
text3:
		moveq.l    #1,d6
		moveq.l    #80,d1
		moveq.l    #24,d2
		moveq.l    #1,d7
		lea.l      textfont_patched(pc),a4
		cmpi.w     #2,(a4)
		beq.s      text4
		move.w     #2,(a4)
		lea.l      textpatch1(pc),a4
		move.w     #640,2(a4)
		lea.l      textpatch2(pc),a4
		move.w     #80,2(a4)
		lea.l      textpatch3(pc),a4
		move.w     #160,2(a4)
		lea.l      textpatch4(pc),a4
		move.w     #240,2(a4)
		lea.l      textpatch5(pc),a4
		move.w     #320,2(a4)
		lea.l      textpatch6(pc),a4
		move.w     #400,2(a4)
		lea.l      textpatch7(pc),a4
		move.w     #480,2(a4)
		lea.l      textpatch8(pc),a4
		move.w     #560,2(a4)
		lea.l      textpatch9(pc),a4
		move.w     #640,2(a4)
text4:
		tst.w      d3
		bge.s      text5
		moveq.l    #0,d3
text5:
		cmp.w      d1,d3
		ble.s      text6
		move.w     d1,d3
text6:
		tst.w      d4
		bge.s      text7
		moveq.l    #0,d4
text7:
		cmp.w      d2,d4
		ble.s      text8
		move.w     d2,d4
text8:
		move.w     d3,d5
		sub.w      d4,d2
		btst       #0,d3
		beq.s      text9
		lsr.w      #1,d3
		lsl.w      d7,d3
		addq.w     #1,d3
		bra.s      text10
text9:
		lsr.w      #1,d3
		lsl.w      d7,d3

text10:
textpatch1:
		mulu.w     #1280,d4
		adda.w     d4,a0
		movea.l    a0,a4
		adda.w     d3,a0
		btst       #0,d5
		beq.s      text11
		moveq.l    #1,d3
		bra.s      text12
text11:
		moveq.l    #0,d3
text12:
		moveq.l    #0,d0
		move.b     (a1)+,d0
		tst.b      d0
		beq.s      text_end
		cmpi.b     #13,d0
		beq.s      text16
		cmpi.b     #9,d0
		bne.s      text13
		moveq.l    #' ',d0
text13:
		cmpi.w     #31,d0
		ble.s      text12
		lsl.w      #3,d0
		movea.l    a2,a3
		adda.w     d0,a3
		move.b     (a3)+,(a0)
textpatch2:
		move.b     (a3)+,160(a0)
textpatch3:
		move.b     (a3)+,320(a0)
textpatch4:
		move.b     (a3)+,480(a0)
textpatch5:
		move.b     (a3)+,640(a0)
textpatch6:
		move.b     (a3)+,800(a0)
textpatch7:
		move.b     (a3)+,960(a0)
textpatch8:
		move.b     (a3),1120(a0)
		addq.w     #1,d5
		cmp.w      d1,d5
		beq.s      text16
		tst.w      d3
		beq.s      text14
		adda.w     d6,a0
		bra.s      text15
text14:
		addq.w     #1,a0
text15:
		eori.w     #1,d3
		bra.s      text12
		moveq.l    #0,d5
		moveq.l    #0,d3
text16:
		moveq.l    #0,d5
		moveq.l    #0,d3
textpatch9:
		lea.l      1280(a4),a4
		movea.l    a4,a0
		subq.w     #1,d2
		tst.w      d2
		bgt.s      text12

text_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

textfont_patched: dc.w 0


; -----------------------------------------------------------------------------

/*
 * Syntax: a = mostly harmless(1,2,3,4,5)
 */
lib14:
	dc.w	0			; no library calls
mostly_harmless:
	rts

; -----------------------------------------------------------------------------

/*
 * Syntax: WASH scr,x1,y1,x2,y2
 */
lib15:
	dc.w	0			; no library calls
wash:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		tst.w      d0
		bge.s      wash1
		moveq.l    #0,d0
wash1:
		tst.w      d1
		bge.s      wash2
		moveq.l    #0,d1
wash2:
		tst.w      d2
		bge.s      wash3
		moveq.l    #0,d2
wash3:
		tst.w      d3
		bge.s      wash4
		moveq.l    #0,d3
wash4:
		cmpi.w     #SCREEN_WIDTH,d0
		ble.s      wash5
		move.w     #SCREEN_WIDTH,d0
wash5:
		cmpi.w     #SCREEN_HEIGHT,d1
		ble.s      wash6
		move.w     #SCREEN_HEIGHT,d1
wash6:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      wash7
		move.w     #SCREEN_WIDTH,d2
wash7:
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.s      wash8
		move.w     #SCREEN_HEIGHT,d3
wash8:
		andi.w     #-16,d0
		lsr.w      #1,d0
		adda.w     d0,a0
		lsr.w      #2,d0
		andi.w     #-16,d2
		lsr.w      #3,d2
		sub.w      d0,d2
		cmpi.w     #SCREEN_WIDTH/8,d2
		ble.s      wash9
		moveq.l    #SCREEN_WIDTH/8,d2
wash9:
		sub.w      d1,d3
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.s      wash10
		move.w     #SCREEN_HEIGHT,d3
wash10:
		add.w      d1,d1
		lea.l      lineoffset_table4(pc),a1
		adda.w     0(a1,d1.w),a0
		subq.w     #1,d3
		bmi        wash_end
		move.w     d3,d0
		lea.l      wash_jtable(pc),a2
		adda.w     0(a2,d2.w),a2
		jmp        (a2)

wash_jtable:
		dc.w wash_end-wash_jtable
		dc.w wash11-wash_jtable
		dc.w wash13-wash_jtable
		dc.w wash15-wash_jtable
		dc.w wash17-wash_jtable
		dc.w wash19-wash_jtable
		dc.w wash21-wash_jtable
		dc.w wash23-wash_jtable
		dc.w wash25-wash_jtable
		dc.w wash27-wash_jtable
		dc.w wash29-wash_jtable
		dc.w wash31-wash_jtable
		dc.w wash33-wash_jtable
		dc.w wash35-wash_jtable
		dc.w wash37-wash_jtable
		dc.w wash39-wash_jtable
		dc.w wash41-wash_jtable
		dc.w wash43-wash_jtable
		dc.w wash45-wash_jtable
		dc.w wash47-wash_jtable
		dc.w wash49-wash_jtable

wash11:
		moveq.l    #0,d1
		move.l     d1,d2
wash12:
		movem.l    d1-d2,(a0)
		lea.l      160(a0),a0
		dbf        d0,wash12
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash13:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
wash14:
		movem.l    d1-d4,(a0)
		lea.l      160(a0),a0
		dbf        d0,wash14
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash15:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
wash16:
		movem.l    d1-d6,(a0)
		lea.l      160(a0),a0
		dbf        d0,wash16
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash17:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
wash18:
		movem.l    d1-d7/a1,(a0)
		lea.l      160(a0),a0
		dbf        d0,wash18
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash19:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
wash20:
		movem.l    d1-d7/a1-a3,(a0)
		lea.l      160(a0),a0
		dbf        d0,wash20
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash21:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
wash22:
		movem.l    d1-d7/a1-a5,(a0)
		lea.l      160(a0),a0
		dbf        d0,wash22
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash23:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash24:
		movem.l    d1-d7/a1-a6,(a0)
		move.l     d1,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash24
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash25:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d6
		move.l     d1,d5
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash26:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d3,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash26
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash27:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash28:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d5,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash28
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash29:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash30:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash30
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash31:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash32:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a2,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash32
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash33:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash34:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a4,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash34
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash35:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash36:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		lea.l      160(a0),a0
		dbf        d0,wash36
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash37:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash38:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d2,104(a0)
		lea.l      160(a0),a0
		dbf        d0,wash38
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash39:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash40:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d4,104(a0)
		lea.l      160(a0),a0
		dbf        d0,wash40
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash41:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash42:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d6,104(a0)
		lea.l      160(a0),a0
		dbf        d0,wash42
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash43:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash44:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d7/a1,104(a0)
		lea.l      160(a0),a0
		dbf        d0,wash44
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash45:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash46:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d7/a1-a3,104(a0)
		lea.l      160(a0),a0
		dbf        d0,wash46
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash47:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash48:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d7/a1-a5,104(a0)
		lea.l      160(a0),a0
		dbf        d0,wash48
		move.l     (a7)+,a6 ; FIXME
		movem.l    (a7)+,a0-a5
		rts

wash49:
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
wash50:
		movem.l    d1-d7/a1-a6,(a0)
		movem.l    d1-d7/a1-a6,52(a0)
		movem.l    d1-d7/a1-a6,104(a0)
		move.l     d1,156(a0)
		lea.l      160(a0),a0
		dbf        d0,wash50

wash_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

lineoffset_table4:
	dc.w 0*160
	dc.w 1*160
	dc.w 2*160
	dc.w 3*160
	dc.w 4*160
	dc.w 5*160
	dc.w 6*160
	dc.w 7*160
	dc.w 8*160
	dc.w 9*160
	dc.w 10*160
	dc.w 11*160
	dc.w 12*160
	dc.w 13*160
	dc.w 14*160
	dc.w 15*160
	dc.w 16*160
	dc.w 17*160
	dc.w 18*160
	dc.w 19*160
	dc.w 20*160
	dc.w 21*160
	dc.w 22*160
	dc.w 23*160
	dc.w 24*160
	dc.w 25*160
	dc.w 26*160
	dc.w 27*160
	dc.w 28*160
	dc.w 29*160
	dc.w 30*160
	dc.w 31*160
	dc.w 32*160
	dc.w 33*160
	dc.w 34*160
	dc.w 35*160
	dc.w 36*160
	dc.w 37*160
	dc.w 38*160
	dc.w 39*160
	dc.w 40*160
	dc.w 41*160
	dc.w 42*160
	dc.w 43*160
	dc.w 44*160
	dc.w 45*160
	dc.w 46*160
	dc.w 47*160
	dc.w 48*160
	dc.w 49*160
	dc.w 50*160
	dc.w 51*160
	dc.w 52*160
	dc.w 53*160
	dc.w 54*160
	dc.w 55*160
	dc.w 56*160
	dc.w 57*160
	dc.w 58*160
	dc.w 59*160
	dc.w 60*160
	dc.w 61*160
	dc.w 62*160
	dc.w 63*160
	dc.w 64*160
	dc.w 65*160
	dc.w 66*160
	dc.w 67*160
	dc.w 68*160
	dc.w 69*160
	dc.w 70*160
	dc.w 71*160
	dc.w 72*160
	dc.w 73*160
	dc.w 74*160
	dc.w 75*160
	dc.w 76*160
	dc.w 77*160
	dc.w 78*160
	dc.w 79*160
	dc.w 80*160
	dc.w 81*160
	dc.w 82*160
	dc.w 83*160
	dc.w 84*160
	dc.w 85*160
	dc.w 86*160
	dc.w 87*160
	dc.w 88*160
	dc.w 89*160
	dc.w 90*160
	dc.w 91*160
	dc.w 92*160
	dc.w 93*160
	dc.w 94*160
	dc.w 95*160
	dc.w 96*160
	dc.w 97*160
	dc.w 98*160
	dc.w 99*160
	dc.w 100*160
	dc.w 101*160
	dc.w 102*160
	dc.w 103*160
	dc.w 104*160
	dc.w 105*160
	dc.w 106*160
	dc.w 107*160
	dc.w 108*160
	dc.w 109*160
	dc.w 110*160
	dc.w 111*160
	dc.w 112*160
	dc.w 113*160
	dc.w 114*160
	dc.w 115*160
	dc.w 116*160
	dc.w 117*160
	dc.w 118*160
	dc.w 119*160
	dc.w 120*160
	dc.w 121*160
	dc.w 122*160
	dc.w 123*160
	dc.w 124*160
	dc.w 125*160
	dc.w 126*160
	dc.w 127*160
	dc.w 128*160
	dc.w 129*160
	dc.w 130*160
	dc.w 131*160
	dc.w 132*160
	dc.w 133*160
	dc.w 134*160
	dc.w 135*160
	dc.w 136*160
	dc.w 137*160
	dc.w 138*160
	dc.w 139*160
	dc.w 140*160
	dc.w 141*160
	dc.w 142*160
	dc.w 143*160
	dc.w 144*160
	dc.w 145*160
	dc.w 146*160
	dc.w 147*160
	dc.w 148*160
	dc.w 149*160
	dc.w 150*160
	dc.w 151*160
	dc.w 152*160
	dc.w 153*160
	dc.w 154*160
	dc.w 155*160
	dc.w 156*160
	dc.w 157*160
	dc.w 158*160
	dc.w 159*160
	dc.w 160*160
	dc.w 161*160
	dc.w 162*160
	dc.w 163*160
	dc.w 164*160
	dc.w 165*160
	dc.w 166*160
	dc.w 167*160
	dc.w 168*160
	dc.w 169*160
	dc.w 170*160
	dc.w 171*160
	dc.w 172*160
	dc.w 173*160
	dc.w 174*160
	dc.w 175*160
	dc.w 176*160
	dc.w 177*160
	dc.w 178*160
	dc.w 179*160
	dc.w 180*160
	dc.w 181*160
	dc.w 182*160
	dc.w 183*160
	dc.w 184*160
	dc.w 185*160
	dc.w 186*160
	dc.w 187*160
	dc.w 188*160
	dc.w 189*160
	dc.w 190*160
	dc.w 191*160
	dc.w 192*160
	dc.w 193*160
	dc.w 194*160
	dc.w 195*160
	dc.w 196*160
	dc.w 197*160
	dc.w 198*160
	dc.w 199*160

; -----------------------------------------------------------------------------

/*
 * Syntax: r = REAL LENGTH (fadr)
 */
lib16:
	dc.w	0			; no library calls
real_length:
		move.l     (a6)+,d3
		moveq.l    #0,d7
		clr.w      -(a7)
		move.l     d3,-(a7)
		move.w     #61,-(a7) ; Fopen
		trap       #1
		addq.l     #8,a7
		move.w     d0,d6
		tst.w      d0
		blt.s      real_length_end
		pea.l      fheader(pc)
		move.l     #16,-(a7)
		move.w     d6,-(a7)
		move.w     #63,-(a7) ; Fread
		trap       #1
		/* adda.l     #12,a7 */
		dc.w 0xdffc,0,12 /* XXX */
		tst.w      d0
		ble.s      real_length4
		lea.l      fheader(pc),a0
		cmpi.l     #0x49434521,(a0) ; 'ICE!'
		beq.s      real_length1
		cmpi.l     #0x46495245,(a0) ; 'FIRE'
		beq.s      real_length1
		cmpi.l     #0x41544D35,(a0) ; 'ATM5'
		beq.s      real_length2
		cmpi.l     #0x41553521,(a0) ; 'AU51'
		beq.s      real_length1
		cmpi.l     #0x53503230,(a0) ; 'SP20'
		beq.s      real_length3
		cmpi.l     #0x53507633,(a0) ; 'SPv3'
		beq.s      real_length3
		bra.s      real_length_end ; BUG: file not closed
real_length1:
		move.l     8(a0),d7
		bra.s      real_length4
real_length2:
		move.l     4(a0),d7
		bra.s      real_length4
real_length3:
		move.l     12(a0),d7
real_length4:
		move.w     d6,-(a7)
		move.w     #62,-(a7) ; Fclose
		trap       #1
		addq.l     #4,a7
real_length_end:
		move.l     d7,-(a6)
		rts

fheader: ds.b 16

; -----------------------------------------------------------------------------

/*
 * Syntax: REBOOT n
 */
lib17:
	dc.w	0			; no library calls
reboot:
		cmpi.l     #0xABCD,(a6)+
		beq.s      reboot1
		bra.s      reboot2
reboot1:
		clr.l      (0x00000420).w ; clear memvalid
		clr.l      (0x00000426).w ; clear resvalid
		movea.l    (0).w,a7
		movea.l    (4).w,a0
		jmp        (a0)
reboot2:
		lea.l      reboot_msg(pc),a0
		moveq.l    #W_prtstring,d7
		trap       #3
reboot3:
		cmpi.b     #0x15,0x00FFFC02 ; BUG: scancode of 'Y' on US keyboards only
		beq.s      reboot1
		cmpi.b     #0x31,0x00FFFC02 ; scancode of 'N'
		bne.s      reboot3
		rts

reboot_msg:
	dc.b "This action is the software equivalent",10,13
	dc.b "of an enema!",10,13
	dc.b "Are you sure that you wish to proceed?",10,13
	dc.b "press Y or N.",10,13,0
	.even

; -----------------------------------------------------------------------------

/*
 * Syntax: r = BRIGHTEST (padr)
 */
lib18:
	dc.w	0			; no library calls
brightest:
		move.l     a0,-(a7)
		move.l     (a6),a0
		moveq.l    #16-1,d0
		moveq.l    #15,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
brightest1:
		moveq.l    #0,d1
		moveq.l    #0,d2
		moveq.l    #0,d3
		move.w     (a0)+,d1
		andi.w     #0x0777,d1 ; BUG: should not mask out STe bit
		move.w     d1,d2
		and.w      d4,d2
		lsr.w      #4,d1
		move.w     d1,d3
		and.w      d4,d3
		add.w      d3,d2
		lsr.w      #4,d1
		and.w      d4,d1
		add.w      d1,d2
		cmp.w      d5,d2
		ble.s      brightest2
		move.w     d2,d5
		move.w     d6,d7
brightest2:
		addq.w     #1,d6
		dbf        d0,brightest1
		move.l     d7,(a6)
		movea.l    (a7)+,a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: BANK LOAD fadr,adr,num
 */
lib19:
	dc.w	0			; no library calls
bank_load:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d6
		move.l     (a6)+,a5
		move.l     (a6)+,a1
		lea        bankload_filename(pc),a0
bank_load1:
		move.b     (a1)+,d0
		move.b     d0,(a0)+
		tst.w      d0 ; BUG: only byte
		bne.s      bank_load1
		lea        bankload_filename(pc),a3
		clr.w      -(a7)
		move.l     a3,-(a7)
		move.w     #61,-(a7) ; Fopen
		trap       #1
		addq.l     #8,a7
		move.w     d0,d7
		tst.w      d7
		blt        diskerror
		lea.l      bankload_buffer(pc),a4
		moveq.l    #6,d0
		bsr.s      bankload_read
		cmpi.l     #0x46424E4B,(a4) ; 'FBNK'
		bne.s      bankload_end
		cmp.w      4(a4),d6
		bgt.s      bankload_end
		lsl.l      #3,d6
		addq.l     #6,d6
		bsr.s      bankload_seek
		lea.l      bankload_buffer(pc),a4
		moveq.l    #8,d0
		bsr.s      bankload_read
		move.l     (a4),d6
		bsr.s      bankload_seek
		move.l     4(a4),d0
		movea.l    a5,a4
		bsr.s      bankload_read
bankload_end:
		move.w     d7,-(a7)
		move.w     #62,-(a7) ; Fclose
		trap       #1
		addq.l     #4,a7
diskerror: ; BUG no error return
		movem.l    (a7)+,d0-d7/a0-a5
		rts

bankload_read:
		move.l     a4,-(a7)
		move.l     d0,-(a7)
		move.w     d7,-(a7)
		move.w     #63,-(a7) ; Fread
		trap       #1
		/* adda.l     #12,a7 */
		dc.w 0xdffc,0,12 /* XXX */
		rts

bankload_seek:
		clr.w      -(a7)
		move.w     d7,-(a7)
		move.l     d6,-(a7)
		move.w     #66,-(a7) ; Fseek
		trap       #1
		/* adda.l     #10,a7 */
		dc.w 0xdffc,0,10 /* XXX */
		rts

bankload_buffer: ds.b 8
bankload_filename: ds.b 16

; -----------------------------------------------------------------------------

/*
 * Syntax: r = BANK LENGTH (fadr,num)
 */
lib20:
	dc.w	0			; no library calls
bank_length:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d6
		move.l     (a6)+,a1
		move.l     a0,-(a7) ; FIXME: useless
		lea        bank_length_len(pc),a0
		move.l     #0,(a0)
		movea.l    (a7)+,a0
		lea.l      bank_length_filename(pc),a0
bank_length1:
		move.b     (a1)+,d0
		move.b     d0,(a0)+
		tst.w      d0 ; BUG: only byte
		bne.s      bank_length1
		lea.l      bank_length_filename(pc),a3
		clr.w      -(a7)
		move.l     a3,-(a7)
		move.w     #61,-(a7) ; Fopen
		trap       #1
		addq.l     #8,a7
		move.w     d0,d7
		tst.w      d7
		blt.s      bank_length_end
		lea.l      bank_length_buffer(pc),a4
		moveq.l    #6,d0
		bsr.s      banklength_read
		cmpi.l     #0x46424E4B,(a4) ; 'FBNK'
		bne.s      bank_length2
		cmp.w      4(a4),d6
		bgt.s      bank_length2
		lsl.w      #3,d6
		addi.w     #10,d6
		bsr.s      banklength_seek
		lea.l      bank_length_buffer(pc),a4
		moveq.l    #8,d0
		bsr.s      banklength_read
		move.l     a0,-(a7) ; FIXME: useless
		lea.l      bank_length_len(pc),a0
		move.l     (a4),(a0)
		movea.l    (a7)+,a0
bank_length2:
		move.w     d7,-(a7)
		move.w     #62,-(a7) ; Fclose
		trap       #1
		addq.l     #4,a7
bank_length_end:
		movem.l    (a7)+,d0-d7/a0-a5
		move.l     bank_length_len(pc),-(a6)
		rts

banklength_read:
		move.l     a4,-(a7)
		move.l     d0,-(a7)
		move.w     d7,-(a7)
		move.w     #63,-(a7) ; Fread
		trap       #1
		/* adda.l     #12,a7 */
		dc.w 0xdffc,0,12 /* XXX */
		rts

banklength_seek:
		clr.w      -(a7)
		move.w     d7,-(a7)
		move.l     d6,-(a7)
		move.w     #66,-(a7) ; Fseek
		trap       #1
		/* adda.l     #10,a7 */
		dc.w 0xdffc,0,10 /* XXX */
		rts

bank_length_buffer: ds.b 8
bank_length_filename: ds.b 16
bank_length_len: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: BANK COPY adr1,adr2,num
 */
lib21:
	dc.w	0			; no library calls
bank_copy:
		movem.l    a0-a2,-(a7)
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		cmpi.l     #0x46424E4B,(a0) ; 'FBNK'
		bne        bank_copy2
		cmp.w      4(a0),d0
		bgt        bank_copy2
		lsl.w      #3,d0
		lea.l      6(a0,d0.w),a2
		adda.l     (a2)+,a0
		move.l     (a2),d0
		lsr.w      #1,d0
		subq.w     #1,d0
bank_copy1:
		move.w     (a0)+,(a1)+
		dbf        d0,bank_copy1
bank_copy2:
		movem.l    (a7)+,a0-a2
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: r = BANK SIZE (adr,num)
 */
lib22:
	dc.w	0			; no library calls
bank_size:
		move.l     a0,-(a7)
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x46424E4B,(a0) ; 'FBNK'
		bne        bank_size1
		cmp.w      4(a0),d0
		bgt        bank_size1
		lsl.w      #3,d0
		move.l     10(a0,d0.w),-(a6)
bank_size1: ; BUG: no return value
		move.l     (a7)+,a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: M BLIT scr1,x1,y1,x2,y2,scr2,x3,y3
 */
lib23:
	dc.w	0			; no library calls
m_blit:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d5 ; y3
		move.l     (a6)+,d4 ; x3
		move.l     (a6)+,a1 ; scr2
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x2
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		move.l     (a6)+,a0 ; scr1
		move.l     a6,-(a7)
		subq.w     #1,d3
		tst.w      d2
		bge.s      m_blit1
		moveq.l    #0,d2
m_blit1:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      m_blit2
		move.w     #SCREEN_WIDTH,d2
m_blit2:
		tst.w      d3
		bge.s      m_blit3
		moveq.l    #0,d3
m_blit3:
		cmpi.w     #SCREEN_HEIGHT-1,d3
		ble.s      m_blit4
		move.w     #SCREEN_HEIGHT-1,d3
m_blit4:
		andi.w     #-16,d4
		move.w     d2,d6
		tst.w      d6
		bmi.s      m_blit5
		sub.w      d0,d6
		bra.s      m_blit6
m_blit5:
		add.w      d0,d6
m_blit6:
		tst.w      d4
		bge.s      m_blit7
		sub.w      d4,d0
		moveq.l    #0,d4
		moveq.l    #0,d6
		move.w     d2,d6
		sub.w      d0,d6
		bra.s      m_blit8
m_blit7:
		move.w     d4,d7
		add.w      d6,d7
		cmpi.w     #SCREEN_WIDTH,d7
		blt.s      m_blit8
		subi.w     #SCREEN_WIDTH,d7
		sub.w      d7,d2
		moveq.l    #0,d6
		move.w     d2,d6
		sub.w      d0,d6
m_blit8:
		lsr.w      #2,d6
		tst.w      d6
		bgt.s      m_blit9
		bra        m_blit_end
m_blit9:
		cmpi.w     #80,d6
		ble.s      m_blit10
		bra        m_blit_end
m_blit10:
		tst.w      d5
		bge.s      m_blit11
		neg.w      d5
		add.w      d5,d1
		moveq.l    #0,d5
		move.w     d3,d7
		sub.w      d1,d7
		bra.s      m_blit12
m_blit11:
		move.w     d3,d7
		sub.w      d1,d7
		moveq.l    #0,d6
		move.w     d5,d6
		add.w      d7,d6
		cmpi.w     #SCREEN_HEIGHT-1,d6
		ble.s      m_blit12
		subi.w     #SCREEN_HEIGHT-1,d6
		sub.w      d6,d3
		move.w     d3,d7
		sub.w      d1,d7
m_blit12:
		tst.w      d7
		bge.s      m_blit13
		bra        m_blit_end
m_blit13:
		cmpi.w     #SCREEN_HEIGHT-1,d7
		ble.s      m_blit14
		move.w     #SCREEN_HEIGHT-1,d7
m_blit14:
		andi.w     #-16,d0
		andi.w     #-16,d2
		move.w     d2,d6
		sub.w      d0,d6
		lsr.w      #4,d6
		move.w     #20,d7
		sub.w      d6,d7
		move.w     d7,d6
		move.w     d7,d2
		lsl.w      #5,d6
		lsl.w      #4,d7
		add.w      d7,d6
		sub.w      d2,d6
		sub.w      d2,d6
		lsr.w      #1,d0
		lsr.w      #1,d4
		adda.w     d0,a0
		adda.w     d4,a1
		move.w     d3,d7
		sub.w      d1,d7
		add.w      d1,d1
		add.w      d5,d5
		lea.l      lineoffset_table5(pc),a3
		adda.w     0(a3,d1.w),a0
		adda.w     0(a3,d5.w),a1
		lea.l      m_blit16(pc,d6.w),a3
m_blit15:
		jmp        (a3)
m_blit16:
		movem.l    152(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,152(a1)
		or.l       d0,152(a1)
		and.l      d5,156(a1)
		or.l       d1,156(a1)

		movem.l    144(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,144(a1)
		or.l       d0,144(a1)
		and.l      d5,148(a1)
		or.l       d1,148(a1)

		movem.l    136(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,136(a1)
		or.l       d0,136(a1)
		and.l      d5,140(a1)
		or.l       d1,140(a1)

		movem.l    128(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,128(a1)
		or.l       d0,128(a1)
		and.l      d5,132(a1)
		or.l       d1,132(a1)

		movem.l    120(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,120(a1)
		or.l       d0,120(a1)
		and.l      d5,124(a1)
		or.l       d1,124(a1)

		movem.l    112(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,112(a1)
		or.l       d0,112(a1)
		and.l      d5,116(a1)
		or.l       d1,116(a1)

		movem.l    104(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,104(a1)
		or.l       d0,104(a1)
		and.l      d5,108(a1)
		or.l       d1,108(a1)

		movem.l    96(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,96(a1)
		or.l       d0,96(a1)
		and.l      d5,100(a1)
		or.l       d1,100(a1)

		movem.l    88(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,88(a1)
		or.l       d0,88(a1)
		and.l      d5,92(a1)
		or.l       d1,92(a1)

		movem.l    80(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,80(a1)
		or.l       d0,80(a1)
		and.l      d5,84(a1)
		or.l       d1,84(a1)

		movem.l    72(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,72(a1)
		or.l       d0,72(a1)
		and.l      d5,76(a1)
		or.l       d1,76(a1)

		movem.l    64(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,64(a1)
		or.l       d0,64(a1)
		and.l      d5,68(a1)
		or.l       d1,68(a1)

		movem.l    56(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,56(a1)
		or.l       d0,56(a1)
		and.l      d5,60(a1)
		or.l       d1,60(a1)

		movem.l    48(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,48(a1)
		or.l       d0,48(a1)
		and.l      d5,52(a1)
		or.l       d1,52(a1)

		movem.l    40(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,40(a1)
		or.l       d0,40(a1)
		and.l      d5,44(a1)
		or.l       d1,44(a1)

		movem.l    32(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,32(a1)
		or.l       d0,32(a1)
		and.l      d5,36(a1)
		or.l       d1,36(a1)

		movem.l    24(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,24(a1)
		or.l       d0,24(a1)
		and.l      d5,28(a1)
		or.l       d1,28(a1)

		movem.l    16(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,16(a1)
		or.l       d0,16(a1)
		and.l      d5,20(a1)
		or.l       d1,20(a1)

		movem.l    8(a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,8(a1)
		or.l       d0,8(a1)
		and.l      d5,12(a1)
		or.l       d1,12(a1)

		movem.l    (a0),d0-d1
		move.w     d0,d5
		swap       d0
		or.w       d0,d5
		swap       d0
		or.w       d1,d5
		swap       d1
		or.w       d1,d5
		swap       d1
		move.w     d5,d6
		swap       d5
		move.w     d6,d5
		not.l      d5
		and.l      d5,(a1)
		or.l       d0,(a1)
		and.l      d5,4(a1)
		or.l       d1,4(a1)

		lea.l      160(a0),a0
		lea.l      160(a1),a1
		dbf        d7,m_blit15
m_blit_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

lineoffset_table5:
	dc.w 0*160
	dc.w 1*160
	dc.w 2*160
	dc.w 3*160
	dc.w 4*160
	dc.w 5*160
	dc.w 6*160
	dc.w 7*160
	dc.w 8*160
	dc.w 9*160
	dc.w 10*160
	dc.w 11*160
	dc.w 12*160
	dc.w 13*160
	dc.w 14*160
	dc.w 15*160
	dc.w 16*160
	dc.w 17*160
	dc.w 18*160
	dc.w 19*160
	dc.w 20*160
	dc.w 21*160
	dc.w 22*160
	dc.w 23*160
	dc.w 24*160
	dc.w 25*160
	dc.w 26*160
	dc.w 27*160
	dc.w 28*160
	dc.w 29*160
	dc.w 30*160
	dc.w 31*160
	dc.w 32*160
	dc.w 33*160
	dc.w 34*160
	dc.w 35*160
	dc.w 36*160
	dc.w 37*160
	dc.w 38*160
	dc.w 39*160
	dc.w 40*160
	dc.w 41*160
	dc.w 42*160
	dc.w 43*160
	dc.w 44*160
	dc.w 45*160
	dc.w 46*160
	dc.w 47*160
	dc.w 48*160
	dc.w 49*160
	dc.w 50*160
	dc.w 51*160
	dc.w 52*160
	dc.w 53*160
	dc.w 54*160
	dc.w 55*160
	dc.w 56*160
	dc.w 57*160
	dc.w 58*160
	dc.w 59*160
	dc.w 60*160
	dc.w 61*160
	dc.w 62*160
	dc.w 63*160
	dc.w 64*160
	dc.w 65*160
	dc.w 66*160
	dc.w 67*160
	dc.w 68*160
	dc.w 69*160
	dc.w 70*160
	dc.w 71*160
	dc.w 72*160
	dc.w 73*160
	dc.w 74*160
	dc.w 75*160
	dc.w 76*160
	dc.w 77*160
	dc.w 78*160
	dc.w 79*160
	dc.w 80*160
	dc.w 81*160
	dc.w 82*160
	dc.w 83*160
	dc.w 84*160
	dc.w 85*160
	dc.w 86*160
	dc.w 87*160
	dc.w 88*160
	dc.w 89*160
	dc.w 90*160
	dc.w 91*160
	dc.w 92*160
	dc.w 93*160
	dc.w 94*160
	dc.w 95*160
	dc.w 96*160
	dc.w 97*160
	dc.w 98*160
	dc.w 99*160
	dc.w 100*160
	dc.w 101*160
	dc.w 102*160
	dc.w 103*160
	dc.w 104*160
	dc.w 105*160
	dc.w 106*160
	dc.w 107*160
	dc.w 108*160
	dc.w 109*160
	dc.w 110*160
	dc.w 111*160
	dc.w 112*160
	dc.w 113*160
	dc.w 114*160
	dc.w 115*160
	dc.w 116*160
	dc.w 117*160
	dc.w 118*160
	dc.w 119*160
	dc.w 120*160
	dc.w 121*160
	dc.w 122*160
	dc.w 123*160
	dc.w 124*160
	dc.w 125*160
	dc.w 126*160
	dc.w 127*160
	dc.w 128*160
	dc.w 129*160
	dc.w 130*160
	dc.w 131*160
	dc.w 132*160
	dc.w 133*160
	dc.w 134*160
	dc.w 135*160
	dc.w 136*160
	dc.w 137*160
	dc.w 138*160
	dc.w 139*160
	dc.w 140*160
	dc.w 141*160
	dc.w 142*160
	dc.w 143*160
	dc.w 144*160
	dc.w 145*160
	dc.w 146*160
	dc.w 147*160
	dc.w 148*160
	dc.w 149*160
	dc.w 150*160
	dc.w 151*160
	dc.w 152*160
	dc.w 153*160
	dc.w 154*160
	dc.w 155*160
	dc.w 156*160
	dc.w 157*160
	dc.w 158*160
	dc.w 159*160
	dc.w 160*160
	dc.w 161*160
	dc.w 162*160
	dc.w 163*160
	dc.w 164*160
	dc.w 165*160
	dc.w 166*160
	dc.w 167*160
	dc.w 168*160
	dc.w 169*160
	dc.w 170*160
	dc.w 171*160
	dc.w 172*160
	dc.w 173*160
	dc.w 174*160
	dc.w 175*160
	dc.w 176*160
	dc.w 177*160
	dc.w 178*160
	dc.w 179*160
	dc.w 180*160
	dc.w 181*160
	dc.w 182*160
	dc.w 183*160
	dc.w 184*160
	dc.w 185*160
	dc.w 186*160
	dc.w 187*160
	dc.w 188*160
	dc.w 189*160
	dc.w 190*160
	dc.w 191*160
	dc.w 192*160
	dc.w 193*160
	dc.w 194*160
	dc.w 195*160
	dc.w 196*160
	dc.w 197*160
	dc.w 198*160
	dc.w 199*160

; -----------------------------------------------------------------------------

/*
 * Syntax: r = WIN BLOCK AMOUNT (madr,x1,y1,x2,y2,blk)
 */
lib24:
	dc.w	0			; no library calls
win_block_amount:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		bne.s      win_block_amount1
		lsl.w      #7,d4
		bra.s      win_block_amount2
win_block_amount1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        win_block_amount14
		lsl.w      #8,d4
win_block_amount2:
		lsr.w      #4,d0
		lsr.w      #4,d1
		lsr.w      #4,d2
		lsr.w      #4,d3
		tst.w      d0
		bge.s      win_block_amount3
		moveq.l    #0,d0
win_block_amount3:
		tst.w      d1
		bge.s      win_block_amount4
		moveq.l    #0,d1
win_block_amount4:
		tst.w      d2
		bge.s      win_block_amount5
		moveq.l    #0,d2
win_block_amount5:
		tst.w      d3
		bge.s      win_block_amount6
		moveq.l    #0,d3
win_block_amount6:
		movem.w    (a0)+,d5-d6
		lsr.w      #1,d5
		addq.w     #1,d5
		lsr.w      #1,d6
		cmp.w      d5,d0
		ble.s      win_block_amount7
		move.w     d5,d0
win_block_amount7:
		cmp.w      d6,d1
		ble.s      win_block_amount8
		move.w     d6,d1
win_block_amount8:
		cmp.w      d5,d2
		ble.s      win_block_amount9
		move.w     d5,d2
win_block_amount9:
		cmp.w      d6,d3
		ble.s      win_block_amount10
		move.w     d6,d3
win_block_amount10:
		sub.w      d0,d2
		sub.w      d1,d3
		add.w      d5,d5
		mulu.w     d5,d1
		adda.w     d1,a0
		adda.w     d0,a0
		adda.w     d0,a0
		move.w     d2,d0
		moveq.l    #0,d1
win_block_amount11:
		movea.l    a0,a1
win_block_amount12:
		cmp.w      (a1)+,d4
		bne.s      win_block_amount13
		addq.w     #1,d1
win_block_amount13:
		dbf        d2,win_block_amount12
		move.w     d0,d2
		adda.w     d5,a0
		dbf        d3,win_block_amount11
win_block_amount14:
		move.l     d1,-(a6)
		movem.l    (a7)+,a0-a5
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: REPLACE RANGE madr,min,max,blk
 */
lib25:
	dc.w	0			; no library calls
replace_range:
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     a0,-(a7) ; FIXME: useless
		cmpi.l     #0x03031973,(a0)+
		bne.s      replace_range1
		moveq.l    #7,d5
		bra.s      replace_range2
replace_range1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        replace_range5
		moveq.l    #8,d5
replace_range2:
		moveq.l    #0,d3
		movem.w    (a0)+,d3-d4
		addq.w     #2,d3
		lsr.w      #1,d3
		lsr.w      #1,d4
		mulu.w     d4,d3
		subq.w     #1,d3
		lsl.w      d5,d0
		lsl.w      d5,d1
		lsl.w      d5,d2
replace_range3:
		move.w     (a0)+,d4
		cmp.w      d0,d4
		blt.s      replace_range4
		cmp.w      d1,d4
		bgt.s      replace_range4
		move.w     d2,-2(a0)
replace_range4:
		dbf        d3,replace_range3
replace_range5:
		move.l     (a7)+,a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: WIN REPLACE BLOCKS madr,x1,y1,x2,y2,blk1,blk2
 */
lib26: ; FIXME
lib27:
	dc.w	0			; no library calls
win_replace_blocks:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d7 ; blk2
		move.l     (a6)+,d4 ; blk1
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x2
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		move.l     (a6)+,a0 ; madr
		cmpi.l     #0x03031973,(a0)+
		bne.s      win_replace_blocks1
		lsl.w      #7,d4
		lsl.w      #7,d7
		bra.s      win_replace_blocks2
win_replace_blocks1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        win_replace_blocks14
		lsl.w      #8,d4
		lsl.w      #8,d7
win_replace_blocks2:
		lsr.w      #4,d0
		lsr.w      #4,d1
		lsr.w      #4,d2
		lsr.w      #4,d3
		tst.w      d0
		bge.s      win_replace_blocks3
		moveq.l    #0,d0
win_replace_blocks3:
		tst.w      d1
		bge.s      win_replace_blocks4
		moveq.l    #0,d1
win_replace_blocks4:
		tst.w      d2
		bge.s      win_replace_blocks5
		moveq.l    #0,d2
win_replace_blocks5:
		tst.w      d3
		bge.s      win_replace_blocks6
		moveq.l    #0,d3
win_replace_blocks6:
		movem.w    (a0)+,d5-d6
		lsr.w      #1,d5
		addq.w     #1,d5
		lsr.w      #1,d6
		cmp.w      d5,d0
		ble.s      win_replace_blocks7
		move.w     d5,d0
win_replace_blocks7:
		cmp.w      d6,d1
		ble.s      win_replace_blocks8
		move.w     d6,d1
win_replace_blocks8:
		cmp.w      d5,d2
		ble.s      win_replace_blocks9
		move.w     d5,d2
win_replace_blocks9:
		cmp.w      d6,d3
		ble.s      win_replace_blocks10
		move.w     d6,d3
win_replace_blocks10:
		sub.w      d0,d2
		sub.w      d1,d3
		add.w      d5,d5
		mulu.w     d5,d1
		adda.w     d1,a0
		adda.w     d0,a0
		adda.w     d0,a0
		move.w     d2,d0
win_replace_blocks11:
		movea.l    a0,a1
win_replace_blocks12:
		cmp.w      (a1)+,d4
		bne.s      win_replace_blocks13
		move.w     d7,-2(a1)
win_replace_blocks13:
		dbf        d2,win_replace_blocks12
		move.w     d0,d2
		adda.w     d5,a0
		dbf        d3,win_replace_blocks11
win_replace_blocks14:
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax: WIN REPLACE RANGE madr,x1,y1,x2,y2,min,max,blk
 */
lib28: ; FIXME
lib29:
	dc.w	0			; no library calls
win_replace_range:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d7 ; blk
		move.l     (a6)+,d6 ; max
		move.l     (a6)+,d4 ; min
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x2
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		move.l     (a6)+,a0 ; madr
		cmpi.l     #0x03031973,(a0)+
		bne.s      win_replace_range1
		lsl.w      #7,d4
		lsl.w      #7,d7
		lsl.w      #7,d6
		bra.s      win_replace_range2
win_replace_range1:
		cmpi.l     #0x02528E54,-4(a0)
		bne.w      win_replace_range14 /* XXX */
		lsl.w      #8,d4
		lsl.w      #8,d7
		lsl.w      #8,d6
win_replace_range2:
		lsr.w      #4,d0
		lsr.w      #4,d1
		lsr.w      #4,d2
		lsr.w      #4,d3
		tst.w      d0
		bge.s      win_replace_range3
		moveq.l    #0,d0
win_replace_range3:
		tst.w      d1
		bge.s      win_replace_range4
		moveq.l    #0,d1
win_replace_range4:
		tst.w      d2
		bge.s      win_replace_range5
		moveq.l    #0,d2
win_replace_range5:
		tst.w      d3
		bge.s      win_replace_range6
		moveq.l    #0,d3
win_replace_range6:
		movea.w    (a0)+,a4
		move.w     (a0)+,d5
		lsr.w      #1,d5
		cmp.w      d5,d1
		ble.s      win_replace_range7
		move.w     d5,d1
win_replace_range7:
		cmp.w      d5,d3
		ble.s      win_replace_range8
		move.w     d5,d3
win_replace_range8:
		move.w     a4,d5
		lsr.w      #1,d5
		addq.w     #1,d5
		cmp.w      d5,d0
		ble.s      win_replace_range9
		move.w     d5,d0
win_replace_range9:
		cmp.w      d5,d2
		ble.s      win_replace_range10
		move.w     d5,d2
win_replace_range10:
		sub.w      d0,d2
		sub.w      d1,d3
		add.w      d5,d5
		mulu.w     d5,d1
		adda.w     d1,a0
		adda.w     d0,a0
		adda.w     d0,a0
		move.w     d2,d0
win_replace_range11:
		movea.l    a0,a1
win_replace_range12:
		move.w     (a1)+,d1
		cmp.w      d4,d1
		blt.s      win_replace_range13
		cmp.w      d6,d1
		bgt.s      win_replace_range13
		move.w     d7,-2(a1)
win_replace_range13:
		dbf        d2,win_replace_range12
		move.w     d0,d2
		adda.w     d5,a0
		dbf        d3,win_replace_range11
win_replace_range14:
		movem.l    (a7)+,a0-a5
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: WIN XY BLOCK madr,x1,y1,x2,y2,xadr,yadr,blk,num
 */
lib30: ; FIXME
lib31:
	dc.w	0			; no library calls
win_xy_block:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d6
		move.l     (a6)+,d7
		move.l     (a6)+,a3
		move.l     (a6)+,a2
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		bne.s      win_xy_block1
		lsl.w      #7,d7
		bra.s      win_xy_block2
win_xy_block1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        win_xy_block14
		lsl.w      #8,d7
win_xy_block2:
		lsr.w      #4,d0
		lsr.w      #4,d1
		lsr.w      #4,d2
		lsr.w      #4,d3
		tst.w      d0
		bge.s      win_xy_block3
		moveq.l    #0,d0
win_xy_block3:
		tst.w      d1
		bge.s      win_xy_block4
		moveq.l    #0,d1
win_xy_block4:
		tst.w      d2
		bge.s      win_xy_block5
		moveq.l    #0,d2
win_xy_block5:
		tst.w      d3
		bge.s      win_xy_block6
		moveq.l    #0,d3
win_xy_block6:
		movea.w    (a0)+,a4
		move.w     (a0)+,d5
		lsr.w      #1,d5
		cmp.w      d5,d1
		ble.s      win_xy_block7
		move.w     d5,d1
win_xy_block7:
		cmp.w      d5,d3
		ble.s      win_xy_block8
		move.w     d5,d3
win_xy_block8:
		move.w     a4,d5
		lsr.w      #1,d5
		addq.w     #1,d5
		cmp.w      d5,d0
		ble.s      win_xy_block9
		move.w     d5,d0
win_xy_block9:
		cmp.w      d5,d2
		ble.s      win_xy_block10
		move.w     d5,d2
win_xy_block10:
		sub.w      d0,d2
		sub.w      d1,d3
		add.w      d5,d5
		moveq.l    #0,d4
		move.w     d1,d4
		lsl.w      #4,d4
		mulu.w     d5,d1
		adda.w     d1,a0
		adda.w     d0,a0
		adda.w     d0,a0
		lsl.w      #4,d0
		moveq.l    #0,d1
		movea.w    d2,a4
win_xy_block11:
		movea.l    a0,a1
		move.w     d0,d1
win_xy_block12:
		cmp.w      (a1)+,d7
		bne.s      win_xy_block13
		move.l     d1,(a2)+
		move.l     d4,(a3)+
		subq.w     #1,d6
		ble.s      win_xy_block14
win_xy_block13:
		addi.w     #16,d1
		dbf        d2,win_xy_block12
		move.w     a4,d2
		adda.w     d5,a0
		addi.w     #16,d4
		dbf        d3,win_xy_block11
win_xy_block14:
		movem.l    (a7)+,a0-a5
		rts

libex:
	dc.w 0
