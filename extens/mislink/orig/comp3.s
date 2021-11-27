		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "equates.inc"

SCREEN_WIDTH  = 320
SCREEN_HEIGHT = 200

PSG  =	 $ffff8800

gpip =   $fffffa01 ; General Purpose I/O
aer  =   $fffffa03 ; active edge register
ddr  =   $fffffa05 ; data direction register
iera =   $fffffa07 ; interrupt enable a
ierb =   $fffffa09 ; interrupt enable b
ipra =   $fffffa0b ; interrupt pending a
iprb =   $fffffa0d ; interrupt pending b
isra =   $fffffa0f ; interrupt service a
isrb =   $fffffa11 ; interrupt service b
imra =   $fffffa13 ; interrupt mask a
imrb =   $fffffa15 ; interrupt mask b
vr   =   $fffffa17 ; vector register
tacr =   $fffffa19 ; timer a control register
tbcr =   $fffffa1b ; timer b control register
tcdcr =  $fffffa1d ; timer c/d control register
tadr =   $fffffa1f ; timer a data register
tbdr =   $fffffa21 ; timer b data register

vbl_vec    = 0x0070
timerd_vec = 0x0110
timerb_vec = 0x0120
timera_vec = 0x0134

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
	dc.w	libex-lib21

para:
	dc.w	21			; number of library routines
	dc.w	21			; number of extension commands
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


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0           ; many add
l002:	.dc.b I,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; many overlap
l003:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0           ; many sub
l004:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l005:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; many bob
l006:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l007:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; many joey
l008:	.dc.b I,1,1,0             ; hertz
l009:	.dc.b 0,I,1,1,0           ; set hertz
l010:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l011:	.dc.b 0,I,',',I,',',I,',',I,1,1,0             ; many inc
l012:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l013:	.dc.b 0,I,',',I,',',I,',',I,1,1,0             ; many dec
l014:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l015:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; raster
l016:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l017:	.dc.b 0,I,',',I,',',I,',',I,1,1,0           ; bullet
l018:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l019:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; many bullet
l020:	.dc.b I,I,',',I,',',I,1,1,0 ; FIXME
l021:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; many spot

		.even

entry:  bra.w init

init:
		lea        exit(pc),a2
		rts

exit:
		rts


; -----------------------------------------------------------------------------

/*
 * Syntax: MANY ADD xadr,vadr,num,lval,uval
 */
lib1:
	dc.w	0			; no library calls
many_add:
		movem.l    a0-a1,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		tst.l      d0
		bge.s      many_add1
		moveq.l    #0,d0
many_add1:
		cmpa.w     #32000,a1
		bgt.s      many_add5
		move.l     a1,d4
many_add2:
		move.l     (a0),d3
		add.l      d4,d3
		cmp.l      d1,d3
		bge.s      many_add3
		move.l     d2,d3
		bra.s      many_add4
many_add3:
		cmp.l      d2,d3
		ble.s      many_add4
		move.l     d1,d3
many_add4:
		move.l     d3,(a0)+
		dbf        d0,many_add2
		bra.s      many_add8
many_add5:
		move.l     (a0),d3
		add.l      (a1)+,d3
		cmp.l      d1,d3
		bge.s      many_add6
		move.l     d2,d3
		bra.s      many_add7
many_add6:
		cmp.l      d2,d3
		ble.s      many_add7
		move.l     d1,d3
many_add7:
		move.l     d3,(a0)+
		dbf        d0,many_add5
many_add8:
		movem.l    (a7)+,a0-a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: r = MANY OVERLAP (x1,y1,xadr,yadr,wid1,hig1,wid2,hig2,statadr,imgadr,stval,imgval,num)
 */
lib2:
	dc.w	0			; no library calls
many_overlap:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d4 ; num
		move.l     (a6)+,d5 ; imgval
		lea        many_overlap_xadr(pc),a3
		move.l     (a6)+,(a3) ; stval
		move.l     (a6)+,a5 ; imgadr
		move.l     (a6)+,a4 ; statadr
		move.l     (a6)+,d3 ; hig2
		move.l     (a6)+,d2 ; wid2
		move.l     (a6)+,d1 ; hig1
		move.l     (a6)+,d0 ; wid1
		move.l     (a6)+,a3 ; yadr
		move.l     (a6)+,a2 ; xadr
		move.l     (a6)+,a1 ; y1
		move.l     (a6)+,a0 ; x1
		move.l     a6,-(a7)
		tst.l      d4
		bge.s      many_overlap1
		moveq.l    #0,d4
many_overlap1:
		/* suba.l     a6,a6 */
		dc.w 0x2c7c,0,0 /* XXX */
many_overlap2:
		cmpi.l     #1,(a4)
		bne.s      many_overlap3
		move.l     (a2),d6
		move.l     a0,d7
		add.l      d0,d7
		cmp.l      d6,d7
		blt.s      many_overlap3
		add.l      d2,d6
		cmpa.l     d6,a0
		bgt.s      many_overlap3
		move.l     (a3),d6
		move.l     a1,d7
		add.l      d1,d7
		cmp.l      d6,d7
		blt.s      many_overlap3
		add.l      d3,d6
		cmpa.l     d6,a1
		bgt.s      many_overlap3
		move.l     many_overlap_xadr(pc),(a4)+
		move.l     d5,(a5)+
		addq.l     #1,a6
		bra.s      many_overlap4
many_overlap3:
		addq.w     #4,a4
		addq.w     #4,a5
many_overlap4:
		addq.l     #4,a2
		addq.l     #4,a3
		dbf        d4,many_overlap2
		move.l     a6,d0
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		move.l     d0,-(a6)
		rts

many_overlap_xadr: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: MANY SUB xadr,vadr,num,lval,uval
 */
lib3:
	dc.w	0			; no library calls
many_sub:
		movem.l    a0-a1,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		tst.l      d0
		bge.s      many_sub1
		moveq.l    #0,d0
many_sub1:
		cmpa.w     #32000,a1
		bgt.s      many_sub5
		move.l     a1,d4
many_sub2:
		move.l     (a0),d3
		sub.l      d4,d3
		cmp.l      d1,d3
		bge.s      many_sub3
		move.l     d2,d3
		bra.s      many_sub4
many_sub3:
		cmp.l      d2,d3
		ble.s      many_sub4
		move.l     d1,d3
many_sub4:
		move.l     d3,(a0)+
		dbf        d0,many_sub2
		bra.s      many_sub8
many_sub5:
		move.l     (a0),d3
		sub.l      (a1)+,d3
		cmp.l      d1,d3
		bge.s      many_sub6
		move.l     d2,d3
		bra.s      many_sub7
many_sub6:
		cmp.l      d2,d3
		ble.s      many_sub7
		move.l     d1,d3
many_sub7:
		move.l     d3,(a0)+
		dbf        d0,many_sub5
many_sub8:
		movem.l    (a7)+,a0-a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: MANY BOB x1,y1,x2,y2,0,0,0,0,0,1
 *         scr,gadr,imgadr,xadr,yadr,statadr,xoff,yoff,num,0
 */
lib4: ; FIXME
lib5:
	dc.w	0			; no library calls
many_bob:
		movem.l    a0-a5,-(a7)
		tst.l      (a6)+
		bne        many_bob_init
		move.l     (a6)+,d6 ; num
		bmi.s      many_bob3 ; FIXME: should be illfunc ; BUG wrong target label
		move.l     (a6)+,d5 ; yoff
		move.l     (a6)+,d4 ; xoff
		move.l     (a6)+,a5 ; statadr
		move.l     (a6)+,a4 ; yadr
		move.l     (a6)+,a3 ; xadr
		move.l     (a6)+,a2 ; imadr
		move.l     (a6)+,a1 ; gadr
		move.l     (a6)+,a0 ; src
		move.l     a6,-(a7)
many_bob1:
		move.l     (a2)+,d0
		move.l     (a3)+,d1
		move.l     (a4)+,d2
		sub.w      d4,d1
		sub.w      d5,d2
		tst.l      (a5)+
		beq.s      many_bob2
		movem.l    d4-d6/a0-a5,-(a7)
		bsr.s      many_bob4
		movem.l    (a7)+,d4-d6/a0-a5
many_bob2:
		dbf        d6,many_bob1
many_bob3:
		move.l     (a7)+,a6
many_bob_ret:
		movem.l    (a7)+,a0-a5
		rts
many_bob4:
		moveq.l    #0,d3
		move.l     d3,d4
		move.l     d3,d5
		move.l     d3,d7
		movea.l    d3,a2
		movea.l    d3,a3
		movea.l    d3,a4
		movea.l    d3,a5
		movea.l    d3,a6
many_bobpatch1:
		cmpi.w     #-64,d1 ; patched with x1-64
		blt        many_bob_end
many_bobpatch2:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_bob_end
many_bobpatch3:
		cmpi.w     #-64,d2 ; patched with y1-64
		blt        many_bob_end
many_bobpatch4:
		cmpi.w     #SCREEN_HEIGHT,d2 ; patched with y2
		bge        many_bob_end
		cmpi.l     #0x38964820,(a1)
		bne        many_bob_end
		move.w     4(a1),d7
		cmp.w      d7,d0
		bge        many_bob_end
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
		beq.s      many_bob5
		sub.w      a5,d3
		bra.s      many_bob6
many_bob5:
		subi.w     #16,d4
many_bob6:
		adda.l     d3,a1
		cmpi.w     #99,d6
		bne.s      many_bob7
		lsr.w      #4,d4
		move.w     d4,d5
		bra        many_bob39
many_bob7:
many_bobpatch5:
		move.w     #0xDEAD,d5 ; patched with y1
		sub.w      d7,d5
		lea.l      many_bobpatch8_1(pc),a2
		move.w     d5,2(a2)
		lea.l      many_bobpatch10_1(pc),a2
		move.w     d7,2(a2)
many_bobpatch6:
		move.w     #SCREEN_HEIGHT-1,d5 ; patched with y2
		sub.w      d7,d5
		lea.l      many_bobpatch10_2(pc),a2
		move.w     d5,2(a2)
		lea.l      many_bobpatch10_3(pc),a2
		move.w     d5,2(a2)
many_bobpatch7:
		cmpi.w     #SCREEN_HEIGHT-1,d2 ; patched with y2
		blt.s      many_bob8
		bra        many_bob_end
many_bob8:
many_bobpatch8:
		cmpi.w     #0xDEAD,d2 ; patched with y1
		bge.s      many_bob11
many_bobpatch8_1:
		cmpi.w     #-16,d2
		bgt.s      many_bob9
		bra        many_bob_end
many_bob9:
many_bobpatch9:
		move.w     #0xDEAD,d7 ; patched with y1
		sub.w      d2,d7
		tst.w      d7
		bpl.s      many_bob10
		neg.w      d7
many_bob10:
		move.w     d7,d2
		lsl.w      #3,d2
		add.w      d7,d2
		add.w      d7,d2
		add.w      d7,d2
		add.w      d7,d2
		adda.w     d2,a1
many_bobpatch10:
		move.w     #0xDEAD,d2 ; patched with y1
many_bobpatch10_1:
		move.w     #-16,d6
		sub.w      d7,d6
		move.w     d6,d7
		bra.s      many_bob12
many_bob11:
many_bobpatch10_2:
		cmpi.w     #SCREEN_HEIGHT-16,d2
		ble.s      many_bob12
		move.l     d2,d6
many_bobpatch10_3:
		subi.w     #SCREEN_HEIGHT-16,d6
		sub.w      d6,d7
many_bob12:
		lsr.w      #3,d4
		lea.l      many_bob_jtable(pc),a2
		adda.w     0(a2,d4.w),a2
		jmp        (a2)

many_bob_jtable:
		dc.w many_bob38-many_bob_jtable
		dc.w many_bob34-many_bob_jtable
		dc.w many_bob29-many_bob_jtable
		dc.w many_bob23-many_bob_jtable
		dc.w many_bob14-many_bob_jtable

many_bob14:
many_bobpatch11:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_bob18
many_bobpatch12:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      many_bob15
		adda.w     a5,a1
		moveq.l    #3,d5
many_bobpatch13:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob15:
many_bobpatch14:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      many_bob16
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #2,d5
many_bobpatch15:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob16:
many_bobpatch16:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt.s      many_bob17
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
many_bobpatch17:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob17:
many_bobpatch18:
		cmpi.w     #-64,d1 ; patched with x1-64
		ble        many_bob_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
many_bobpatch19:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob18:
many_bobpatch20:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_bob_end
many_bobpatch21:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_bob19
		moveq.l    #0,d5
		bra        many_bob39
many_bob19:
many_bobpatch22:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      many_bob20
		moveq.l    #1,d5
		bra        many_bob39
many_bob20:
many_bobpatch23:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      many_bob21
		moveq.l    #2,d5
		bra        many_bob39
many_bob21:
many_bobpatch24:
		cmpi.w     #SCREEN_WIDTH-64,d1 ; patched with x2-64
		blt.s      many_bob22
		moveq.l    #3,d5
		bra        many_bob39
many_bob22:
		moveq.l    #4,d5
		bra        many_bob39
many_bob23:
many_bobpatch25:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_bob26
many_bobpatch26:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      many_bob24
		adda.w     a5,a1
		moveq.l    #2,d5
many_bobpatch27:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob24:
many_bobpatch28:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      many_bob25
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
many_bobpatch29:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob25:
many_bobpatch30:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt        many_bob_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
many_bobpatch31:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_bob39
many_bob26:
many_bobpatch32:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_bob_end
many_bobpatch33:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_bob27
		moveq.l    #0,d5
		bra        many_bob39
many_bob27:
many_bobpatch34:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      many_bob28
		moveq.l    #1,d5
		bra        many_bob39
many_bob28:
many_bobpatch35:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      many_bob28_1
		moveq.l    #2,d5
		bra        many_bob39
many_bob28_1:
		moveq.l    #3,d5
		bra        many_bob39
many_bob29:
many_bobpatch36:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_bob31
many_bobpatch37:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      many_bob30
		adda.w     a5,a1
		moveq.l    #1,d5
many_bobpatch38:
		move.w     #0xDEAD,d1 ; patched with x1
		bra.s      many_bob39
many_bob30:
many_bobpatch39:
		cmpi.w     #-32,d1 ; patched with x1-32
		ble        many_bob_end
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
many_bobpatch40:
		move.w     #0xDEAD,d1 ; patched with x1
		bra.s      many_bob39
many_bob31:
many_bobpatch41:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_bob_end
many_bobpatch42:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_bob32
		moveq.l    #0,d5
		bra.s      many_bob39
many_bob32:
many_bobpatch43:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      many_bob33
		moveq.l    #1,d5
		bra.s      many_bob39
many_bob33:
		moveq.l    #2,d5
		bra.s      many_bob39
many_bob34:
many_bobpatch44:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_bob35
many_bobpatch45:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt        many_bob_end
		adda.w     a5,a1
		moveq.l    #0,d5
many_bobpatch46:
		move.w     #0xDEAD,d1 ; patched with x1
		bra.s      many_bob39
many_bob35:
many_bobpatch47:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		blt.s      many_bob36
		bra        many_bob_end
many_bob36:
many_bobpatch48:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_bob37
		moveq.l    #0,d5
		bra.s      many_bob39
many_bob37:
		moveq.l    #1,d5
		bra.s      many_bob39
many_bob38:
many_bobpatch49:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		blt        many_bob_end
many_bobpatch50:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_bob_end
		moveq.l    #0,d5
many_bob39:
		andi.w     #-16,d1
		lsr.w      #1,d1
		add.w      d2,d2
		lea.l      lineoffset_table(pc),a2
		adda.w     d2,a2
		adda.w     (a2),a0
		adda.w     d1,a0
		moveq.l    #64,d6
		sub.w      d7,d6
		move.w     d6,d7
		lsl.w      #4,d6
		add.w      d7,d6
		add.w      d7,d6
		add.w      d7,d6
		add.w      d7,d6
		movea.l    a0,a2
		movea.l    a1,a3
many_bob40:
		lea.l      many_bob41(pc,d6.w),a4
		jmp        (a4)
many_bob41:
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		move.l     (a1)+,d0
		move.l     d0,d1
		and.l      (a0),d0
		or.l       (a1)+,d0
		move.l     d0,(a0)+
		and.l      (a0),d1
		or.l       (a1)+,d1
		move.l     d1,(a0)
		lea.l      156(a0),a0
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		dbf        d5,many_bob40
many_bob_end:
		rts

many_bob_init:
		adda.w     #20,a6 ; skip dummy args
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		bge.s      many_bob_init1
		moveq.l    #0,d0
many_bob_init1:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      many_bob_init2
		move.w     #SCREEN_WIDTH,d2
many_bob_init2:
		/* tst.w     d1 */
		dc.w 0x0c41,0 /* XXX */
		bge.s      many_bob_init3
		moveq.l    #0,d1
many_bob_init3:
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.s      many_bob_init4
		move.w     #SCREEN_HEIGHT,d3
many_bob_init4:
		andi.w     #-16,d0
		andi.w     #-16,d2

		lea.l      many_bobpatch8(pc),a0
		move.w     d1,2(a0)
		lea.l      many_bobpatch10(pc),a0
		move.w     d1,2(a0)
		lea.l      many_bobpatch9(pc),a0
		move.w     d1,2(a0)
		lea.l      many_bobpatch5(pc),a0
		move.w     d1,2(a0)

		subi.w     #64,d1
		lea.l      many_bobpatch3(pc),a0
		move.w     d1,2(a0)

		lea.l      many_bobpatch7(pc),a0
		move.w     d3,2(a0)
		lea.l      many_bobpatch6(pc),a0
		move.w     d3,2(a0)
		lea.l      many_bobpatch4(pc),a0
		move.w     d3,2(a0)

		lea.l      many_bobpatch44(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch49(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch36(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch38(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch40(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch46(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch25(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch27(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch29(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch31(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch11(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch13(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch15(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch17(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch19(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_bobpatch45(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch37(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch26(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch12(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_bobpatch39(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch28(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch14(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      many_bobpatch30(pc),a0
		move.w     d0,2(a0)
		lea.l      many_bobpatch16(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_bobpatch18(pc),a0 ; BUG: not patched
		lea.l      many_bobpatch1(pc),a0
		move.w     d0,2(a0)

		lea.l      many_bobpatch47(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch41(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch32(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch50(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch20(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch2(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_bobpatch48(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch42(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch33(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch21(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_bobpatch43(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch34(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch22(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_bobpatch35(pc),a0
		move.w     d2,2(a0)
		lea.l      many_bobpatch23(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_bobpatch24(pc),a0
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
 * Syntax: MANY JOEY x1,y1,x2,y2,0,0,0,0,1
 *         MANY JOEY scr,gadr,imgadr,xadr,yadr,statadr,coladr,xoff,yoff,num,0
 */
lib6:
lib7:
	dc.w	0			; no library calls
many_joey:
		movem.l    a0-a5,-(a7)
		tst.l      (a6)+
		bne        many_joey_init
		move.l     (a6)+,d6
		bmi.s      many_joey_ret ; FIXME: should be illfunc ; BUG: wrong label
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,a5
		move.l     (a6)+,a4
		move.l     (a6)+,a3
		move.l     (a6)+,a2
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		movea.l    d3,a6
		cmpa.w     #32000,a6
		ble.s      many_joey3
many_joey1:
		move.l     (a2)+,d0
		move.l     (a3)+,d1
		move.l     (a4)+,d2
		move.l     (a6)+,d3
		sub.w      d4,d1
		sub.w      d5,d2
		tst.l      (a5)+
		beq.s      many_joey2
		movem.l    d4-d6/a0-a6,-(a7)
		bsr.s      many_joey5
		movem.l    (a7)+,d4-d6/a0-a6
many_joey2:
		dbf        d6,many_joey1
many_joey_ret:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts
many_joey3:
		move.l     (a2)+,d0
		move.l     (a3)+,d1
		move.l     (a4)+,d2
		move.w     a6,d3
		sub.w      d4,d1
		sub.w      d5,d2
		tst.l      (a5)+
		beq.s      many_joey4
		movem.l    d4-d6/a0-a6,-(a7)
		bsr.s      many_joey5
		movem.l    (a7)+,d4-d6/a0-a6
many_joey4:
		dbf        d6,many_joey3
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts
many_joey5:
		moveq.l    #0,d4
		move.l     d4,d5
		move.l     d4,d7
		movea.l    d4,a2
		movea.l    d4,a3
		movea.l    d4,a4
		movea.l    d4,a5
		movea.l    d4,a6
many_joeypatch1:
		cmpi.w     #-64,d1 ; patched with x1-64
		blt        many_joey_end
many_joeypatch2:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_joey_end
many_joeypatch3:
		cmpi.w     #-64,d2 ; patched with y1-64
		blt        many_joey_end
many_joeypatch4:
		cmpi.w     #SCREEN_HEIGHT,d2 ; patched with y2
		bge        many_joey_end
		lea.l      many_joeypatch55(pc),a2
		move.w     d3,2(a2)
		cmpi.l     #0x38964820,(a1)
		bne        many_joey_end
		move.w     4(a1),d7
		cmp.w      d7,d0
		bge        many_joey_end
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
		beq.s      many_joey6
		sub.w      a5,d3
		bra.s      many_joey7
many_joey6:
		subi.w     #16,d4
many_joey7:
		adda.l     d3,a1
		cmpi.w     #99,d6
		bne.s      many_joey8
		lsr.w      #4,d4
		move.w     d4,d5
		bra        many_joey40
many_joey8:
many_joeypatch5:
		move.w     #0xDEAD,d5 ; patched with y2
		sub.w      d7,d5
		lea.l      many_joeypatch9(pc),a2
		move.w     d5,2(a2)
		lea.l      many_joeypatch12(pc),a2
		move.w     d7,2(a2)
many_joeypatch6:
		move.w     #SCREEN_HEIGHT,d5 ; patched with y2
		sub.w      d7,d5
		lea.l      many_joeypatch13(pc),a2
		move.w     d5,2(a2)
		lea.l      many_joeypatch14(pc),a2
		move.w     d5,2(a2)
many_joeypatch7:
		cmpi.w     #SCREEN_HEIGHT-1,d2 ; patched with y2
		blt.s      many_joey9
		bra        many_joey_end
many_joey9:
many_joeypatch8:
		cmpi.w     #0xDEAD,d2 ; patched with y1
		bge.s      many_joey11
many_joeypatch9:
		cmpi.w     #-16,d2
		bgt.s      many_joey9_1
		bra        many_joey_end
many_joey9_1:
many_joeypatch10:
		move.w     #0xDEAD,d7 ; patched with y1
		sub.w      d2,d7
		tst.w      d7
		bpl.s      many_joey10
		neg.w      d7
many_joey10:
		move.w     d7,d2
		lsl.w      #2,d2
		adda.w     d2,a1
many_joeypatch11:
		move.w     #0xDEAD,d2 ; patched with y1
many_joeypatch12:
		move.w     #-16,d6
		sub.w      d7,d6
		move.w     d6,d7
		bra.s      many_joey12
many_joey11:
many_joeypatch13:
		cmpi.w     #SCREEN_HEIGHT-16,d2
		ble.s      many_joey12
		move.w     d2,d6
many_joeypatch14:
		subi.w     #SCREEN_HEIGHT-16,d6
		sub.w      d6,d7
many_joey12:
		lsr.w      #3,d4
		lea.l      many_joey_jtable(pc),a2
		adda.w     0(a2,d4.w),a2
		jmp        (a2)

many_joey_jtable:
	dc.w many_joey39-many_joey_jtable
	dc.w many_joey35-many_joey_jtable
	dc.w many_joey30-many_joey_jtable
	dc.w many_joey23-many_joey_jtable
; BUG? missing entry, joey9 cannot be reached                      

many_joey14:
many_joeypatch15:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_joey18
many_joeypatch16:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      many_joey15
		adda.w     a5,a1
		moveq.l    #3,d5
many_joeypatch17:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey15:
many_joeypatch18:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      many_joey16
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #2,d5
many_joeypatch19:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey16:
many_joeypatch20:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt.s      many_joey17
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
many_joeypatch21:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey17:
many_joeypatch22:
		cmpi.w     #-64,d1 ; patched with x1-64
		ble        many_joey_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
many_joeypatch23:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey18:
many_joeypatch24:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_joey_end
many_joeypatch25:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_joey19
		moveq.l    #0,d5
		bra        many_joey40
many_joey19:
many_joeypatch26:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      many_joey20
		moveq.l    #1,d5
		bra        many_joey40
many_joey20:
many_joeypatch27:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      many_joey21
		moveq.l    #2,d5
		bra        many_joey40
many_joey21:
many_joeypatch28:
		cmpi.w     #SCREEN_WIDTH-64,d1 ; patched with x2-64
		blt.s      many_joey22
		moveq.l    #3,d5
		bra        many_joey40
many_joey22:
		moveq.l    #4,d5
		bra        many_joey40
many_joey23:
many_joeypatch29:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_joey26
many_joeypatch30:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      many_joey24
		adda.w     a5,a1
		moveq.l    #2,d5
many_joeypatch31:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey24:
many_joeypatch32:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      many_joey25
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
many_joeypatch33:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey25:
many_joeypatch34:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt        many_joey_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
many_joeypatch35:
		move.w     #0xDEAD,d1 ; patched with x1
		bra        many_joey40
many_joey26:
many_joeypatch36:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_joey_end
many_joeypatch37:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_joey27
		moveq.l    #0,d5
		bra        many_joey40
many_joey27:
many_joeypatch38:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      many_joey28
		moveq.l    #1,d5
		bra        many_joey40
many_joey28:
many_joeypatch39:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      many_joey29
		moveq.l    #2,d5
		bra        many_joey40
many_joey29:
		moveq.l    #3,d5
		bra        many_joey40
many_joey30:
many_joeypatch40:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_joey32
many_joeypatch41:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      many_joey31
		adda.w     a5,a1
		moveq.l    #1,d5
many_joeypatch42:
		move.w     #0xDEAD,d1 ; patched with x1
		bra.s      many_joey40
many_joey31:
many_joeypatch43:
		cmpi.w     #-32,d1 ; patched with x1-32
		ble        many_joey_end
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
many_joeypatch44:
		move.w     #0xDEAD,d1 ; patched with x1
		bra.s      many_joey40
many_joey32:
many_joeypatch45:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_joey_end
many_joeypatch46:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_joey33
		moveq.l    #0,d5
		bra.s      many_joey40
many_joey33:
many_joeypatch47:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      many_joey34
		moveq.l    #1,d5
		bra.s      many_joey40
many_joey34:
		moveq.l    #2,d5
		bra.s      many_joey40
many_joey35:
many_joeypatch48:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		bge.s      many_joey36
many_joeypatch49:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt        many_joey_end
		adda.w     a5,a1
		moveq.l    #0,d5
many_joeypatch50:
		move.w     #0xDEAD,d1 ; patched with x1
		bra.s      many_joey40
many_joey36:
many_joeypatch51:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		blt.s      many_joey37
		bra        many_joey_end
many_joey37:
many_joeypatch52:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      many_joey38
		moveq.l    #0,d5
		bra.s      many_joey40
many_joey38:
		moveq.l    #1,d5
		bra.s      many_joey40
many_joey39:
many_joeypatch53:
		cmpi.w     #0xDEAD,d1 ; patched with x1
		blt        many_joey_end
many_joeypatch54:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        many_joey_end
		moveq.l    #0,d5
many_joey40:
		andi.w     #-16,d1
		lsr.w      #1,d1
		add.w      d2,d2
		lea.l      lineoffset_table2(pc),a2
		adda.w     0(a2,d2.w),a0
		adda.w     d1,a0
		subq.w     #1,d7
		movea.l    a0,a2
		move.w     d7,d6
		movea.l    a1,a3
many_joeypatch55:
		move.w     #0xDEAD,d3
		andi.w     #15,d3
		add.w      d3,d3
		lea.l      many_joey_jtable2(pc),a4
		adda.w     0(a4,d3.w),a4
		jmp        (a4)

many_joey_jtable2:
		dc.w many_joey41-many_joey_jtable2
		dc.w many_joey42-many_joey_jtable2
		dc.w many_joey43-many_joey_jtable2
		dc.w many_joey44-many_joey_jtable2
		dc.w many_joey45-many_joey_jtable2
		dc.w many_joey46-many_joey_jtable2
		dc.w many_joey47-many_joey_jtable2
		dc.w many_joey48-many_joey_jtable2
		dc.w many_joey49-many_joey_jtable2
		dc.w many_joey50-many_joey_jtable2
		dc.w many_joey51-many_joey_jtable2
		dc.w many_joey52-many_joey_jtable2
		dc.w many_joey53-many_joey_jtable2
		dc.w many_joey54-many_joey_jtable2
		dc.w many_joey55-many_joey_jtable2
		dc.w many_joey56-many_joey_jtable2

many_joey41:
		move.l     (a1)+,d1
		not.l      d1
		and.l      d1,(a0)+
		and.l      d1,(a0)
		lea.l      156(a0),a0
		dbf        d7,many_joey41
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey41
		rts
many_joey42:
		move.l     (a1)+,d0
		or.w       d0,(a0)+
		not.l      d0
		and.l      d0,(a0)+
		and.w      d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey42
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey42
		rts
many_joey43:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d1,(a0)
		lea.l      156(a0),a0
		dbf        d7,many_joey43
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey43
		rts
many_joey44:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.l       d0,(a0)+
		and.l      d1,(a0)
		lea.l      156(a0),a0
		dbf        d7,many_joey44
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey44
		rts
many_joey45:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey45
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey45
		rts
many_joey46:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey46
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey46
		rts
many_joey47:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey47
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey47
		rts
many_joey48:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.l       d0,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey48
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey48
		rts
many_joey49:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.l      d1,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey49
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey49
		rts
many_joey50:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey50
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey50
		rts
many_joey51:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey51
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey51
		rts
many_joey52:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey52
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey52
		rts
many_joey53:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.l      d1,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		dbf        d7,many_joey53
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey53
		rts
many_joey54:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d0,(a0)
		lea.l      156(a0),a0
		dbf        d7,many_joey54
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey54
		rts
many_joey55:
		move.l     (a1)+,d0
		move.l     d0,d1
		not.l      d1
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		or.w       d0,(a0)
		lea.l      154(a0),a0
		dbf        d7,many_joey55
		addq.w     #8,a2
		movea.l    a2,a0
		adda.w     a5,a3
		movea.l    a3,a1
		move.w     d6,d7
		dbf        d5,many_joey55
		rts
many_joey56:
		moveq.l    #63,d6
		sub.w      d7,d6
		move.w     d6,d7
		lsl.w      #3,d6
		add.w      d7,d6
		add.w      d7,d6
many_joey57:
		lea.l      many_joey58(pc,d6.w),a4
		jmp        (a4)
many_joey58:
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
		dbf        d5,many_joey57
many_joey_end:
		rts

many_joey_init:
		adda.w     #24,a6 ; skip dummy args
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		bge.s      many_joey_init1
		moveq.l    #0,d0
many_joey_init1:
		cmpi.w     #SCREEN_WIDTH,d2
		ble.s      many_joey_init2
		move.w     #SCREEN_WIDTH,d2
many_joey_init2:
		/* tst.w     d1 */
		dc.w 0x0c41,0 /* XXX */
		bge.s      many_joey_init3
		moveq.l    #0,d1
many_joey_init3:
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.s      many_joey_init4
		move.w     #SCREEN_HEIGHT,d3
many_joey_init4:
		andi.w     #-16,d0
		andi.w     #-16,d2

		lea.l      many_joeypatch8(pc),a0
		move.w     d1,2(a0)
		lea.l      many_joeypatch11(pc),a0
		move.w     d1,2(a0)
		lea.l      many_joeypatch10(pc),a0
		move.w     d1,2(a0)
		lea.l      many_joeypatch5(pc),a0
		move.w     d1,2(a0)

		subi.w     #64,d1
		lea.l      many_joeypatch3(pc),a0
		move.w     d1,2(a0)

		lea.l      many_joeypatch7(pc),a0
		move.w     d3,2(a0)
		lea.l      many_joeypatch6(pc),a0
		move.w     d3,2(a0)
		lea.l      many_joeypatch4(pc),a0
		move.w     d3,2(a0)

		lea.l      many_joeypatch48(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch53(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch40(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch42(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch44(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch50(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch29(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch31(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch33(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch35(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch15(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch17(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch19(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch21(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch23(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_joeypatch49(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch41(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch30(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch16(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_joeypatch43(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch32(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch18(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_joeypatch34(pc),a0
		move.w     d0,2(a0)
		lea.l      many_joeypatch20(pc),a0
		move.w     d0,2(a0)

		subi.w     #16,d0
		lea.l      many_joeypatch22(pc),a0 ; BUG: not patched
		lea.l      many_joeypatch1(pc),a0
		move.w     d0,2(a0)

		lea.l      many_joeypatch51(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch45(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch36(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch54(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch24(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch2(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_joeypatch52(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch46(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch37(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch25(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_joeypatch47(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch38(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch26(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_joeypatch39(pc),a0
		move.w     d2,2(a0)
		lea.l      many_joeypatch27(pc),a0
		move.w     d2,2(a0)

		subi.w     #16,d2
		lea.l      many_joeypatch28(pc),a0
		move.w     d2,2(a0)

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
 * Syntax: freq = HERTZ
 */
lib8:
	dc.w	0			; no library calls
hertz:
		moveq.l    #0,d0
		move.b     (0xFFFF820A).w,d0
		btst       #1,d0
		beq.s      hertz1
		moveq.l    #50,d3
		bra.s      hertz2
hertz1:
		moveq.l    #60,d3
hertz2:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: SET HERTZ freq
 */
lib9:
	dc.w	0			; no library calls
set_hertz:
		move.l     (a6)+,d3
		move.b     (0xFFFF820A).w,d1
		cmpi.w     #60,d3
		bne.s      set_hertz1
		bclr       #1,d1
		bra.s      set_hertz2
set_hertz1:
		bset       #1,d1
set_hertz2:
		move.b     d1,(0xFFFF820A).w
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: MANY INC xadr,num,lval,uval
 */
lib10:
lib11:
	dc.w	0			; no library calls
many_inc:
		movem.l    a0-a1,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		tst.l      d0
		bge.s      many_inc1
		moveq.l    #0,d0
many_inc1:
		move.l     (a0),d3
		addq.w     #1,d3
		cmp.l      d1,d3
		bge.s      many_inc2
		move.l     d2,d3
		bra.s      many_inc3
many_inc2:
		cmp.l      d2,d3
		ble.s      many_inc3
		move.l     d1,d3
many_inc3:
		move.l     d3,(a0)+
		dbf        d0,many_inc1
		movem.l    (a7)+,a0-a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: MANY DEC xadr,num,lval,uval
 */
lib12:
lib13:
	dc.w	0			; no library calls
many_dec:
		movem.l    a0-a1,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		tst.l      d0
		bge.s      many_dec1
		moveq.l    #0,d0
many_dec1:
		move.l     (a0),d3
		subq.w     #1,d3
		cmp.l      d1,d3
		bge.s      many_dec2
		move.l     d2,d3
		bra.s      many_dec3
many_dec2:
		cmp.l      d2,d3
		ble.s      many_dec3
		move.l     d1,d3
many_dec3:
		move.l     d3,(a0)+
		dbf        d0,many_dec1
		movem.l    (a7)+,a0-a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: RASTER flag,coladr,line,wid,num,col
 */
lib14:
lib15:
	dc.w	0			; no library calls
raster:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     (a6)+,d1
		lea.l      raster_coladr(pc),a2
		move.l     a0,(a2)
		tst.w      d1
		beq        raster5
		cmpi.w     #1,d2
		bge.s      raster1
		moveq.l    #1,d2
raster1:
		tst.w      d4
		bpl.s      raster2
		moveq.l    #0,d4
raster2:
		cmpi.w     #15,d4
		ble.s      raster3
		moveq.l    #15,d4
raster3:
		add.w      d4,d4
		addi.l     #0xFFFF8240,d4
		lea.l      raster_colpatch(pc),a2
		move.w     d4,4(a2)
		lea.l      raster_colpatch2(pc),a2
		move.w     d4,4(a2)
		lea        vbl_saved_flag(pc),a2
		tst.w      (a2)
		beq.s      raster4
		clr.b      tbcr.l /* XXX */
		lea.l      raster_tbdrpatch(pc),a2
		move.b     d0,2(a2)
		lea.l      raster_tbdrpatch2(pc),a2
		move.b     d2,2(a2)
		lea.l      raster_linecount(pc),a2
		move.w     d3,(a2)
		move.b     #8,tbcr.l /* XXX */
		bra        raster6
raster4:
		lea.l      raster_tbdrpatch(pc),a2
		move.w     d0,2(a2)
		lea.l      raster_tbdrpatch2(pc),a2
		move.w     d2,2(a2)
		lea.l      raster_coladr(pc),a2
		move.l     a0,(a2)
		lea.l      raster_linecount(pc),a2
		move.w     d3,(a2)
		lea.l      save_iera(pc),a0
		move.b     (iera).w,(a0)+
		move.b     (ierb).w,(a0)+
		move.b     (imra).w,(a0)+
		move.b     (imrb).w,(a0)+
		move.w     #0x2700,sr /* BUG: sr not saved */
		ori.b      #1,(iera).w
		ori.b      #1,(imra).w
		bclr       #3,(vr).w
		clr.b      (tbcr).w
		lea        save_vbl(pc),a2
		move.l     (vbl_vec).w,(a2)
		lea        raster_irq(pc),a2
		move.l     a2,(vbl_vec).w
		move.w     #0x2300,sr
		lea        vbl_saved_flag(pc),a2
		move.w     #1,(a2)
		bra.s      raster6
raster5:
		lea        vbl_saved_flag(pc),a2
		tst.w      (a2)
		beq.s      raster6
		move.w     #0x2700,sr /* BUG: sr not saved */
		lea.l      save_iera(pc),a0
		move.b     (a0)+,(iera).w
		move.b     (a0)+,(ierb).w
		move.b     (a0)+,(imra).w
		move.b     (a0)+,(imrb).w
		move.l     save_vbl(pc),(vbl_vec).w
		move.w     #0x2300,sr
		lea        vbl_saved_flag(pc),a2
		move.w     #0,(a2)
raster6:
		movem.l    (a7)+,a0-a5
		rts

raster_irq:
raster_colpatch:
		move.w     #0,(0xFFFF8242).w
		movem.l    a0-a1,-(a7)
		lea        raster_coladr(pc),a1 ; FIXME
		movea.l    (a1),a0
		lea.l      raster_colpatch2(pc),a1
		move.w     (a0)+,2(a1)
		lea.l      raster_colptr(pc),a1
		move.l     a0,(a1)
		lea.l      raster_linecount(pc),a0
		lea.l      raster_counter(pc),a1
		move.w     (a0),(a1)
		movem.l    (a7)+,a0-a1
		clr.b      (tbcr).w
		lea        raster_irq2(pc),a2 ; BUG BUG clobbers a2
		move.l     a2,(timerb_vec).w
raster_tbdrpatch:
		move.b     #0x63,(tbdr).w
		move.b     #8,(tbcr).w
raster_tbdrpatch2:
		move.b     #1,(tbdr).w
		move.l     save_vbl(pc),-(a7)
		rts

raster_irq2:
		movem.l    d0/a0-a2,-(a7)
raster_colpatch2:
		move.w     #0x0777,(0xFFFF8242).w
		lea.l      raster_counter(pc),a0
		subq.w     #1,(a0)
		bge.s      raster_irq3
		clr.b      (tbcr).w
		bra.s      raster_irq4
raster_irq3:
		lea.l      raster_colptr(pc),a0
		movea.l    (a0),a1
		lea.l      raster_colpatch2(pc),a2
		move.w     (a1)+,2(a2)
		move.l     a1,(a0)
raster_irq4:
		movem.l    (a7)+,d0/a0-a2
		rte

save_iera: ds.b 4
save_vbl: ds.l 1
vbl_saved_flag: ds.w 1
raster_linecount: ds.w 1
raster_counter: ds.w 1
raster_coladr: ds.l 1
raster_colptr: ds.l 1

; -----------------------------------------------------------------------------

		movem.l    (a7)+,a0-a5 ; FIXME, dead code
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: BULLET scr,x,y,col
 */
lib16:
lib17:
	dc.w	0			; no library calls
bullet:
		movem.l    a0-a2,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		tst.w      d0
		bmi        bullet_ret
		cmpi.w     #SCREEN_WIDTH-2,d0
		bgt        bullet_ret
		tst.w      d1
		bmi        bullet_ret
		cmpi.w     #SCREEN_HEIGHT-2,d1
		bgt        bullet_ret
		add.w      d1,d1
		lea.l      lineoffset_table3(pc),a1
		adda.w     d1,a1
		adda.w     (a1),a0
		move.w     d0,d1
		andi.w     #-16,d1
		lsr.w      #1,d1
		adda.w     d1,a0
		add.w      d2,d2
		lea.l      bullet_jtable(pc),a1
		adda.w     0(a1,d2.w),a1
		andi.w     #15,d0
		lsl.w      #5,d0
		lea.l      bullet_masktab(pc),a2
		adda.w     d0,a2
		movem.l    (a2),d0-d7
		jmp        (a1)

bullet_jtable:
	dc.w bullet1-bullet_jtable
	dc.w bullet2-bullet_jtable
	dc.w bullet3-bullet_jtable
	dc.w bullet4-bullet_jtable
	dc.w bullet5-bullet_jtable
	dc.w bullet6-bullet_jtable
	dc.w bullet7-bullet_jtable
	dc.w bullet8-bullet_jtable
	dc.w bullet9-bullet_jtable
	dc.w bullet10-bullet_jtable
	dc.w bullet11-bullet_jtable
	dc.w bullet12-bullet_jtable
	dc.w bullet13-bullet_jtable
	dc.w bullet14-bullet_jtable
	dc.w bullet15-bullet_jtable
	dc.w bullet16-bullet_jtable

bullet1:
		and.l      d1,(a0)+
		and.l      d1,(a0)+
		and.l      d3,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		and.l      d5,(a0)+
		and.l      d5,(a0)+
		and.l      d7,(a0)+
		and.l      d7,(a0)
		bra        bullet_ret

bullet2:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		and.l      d1,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		and.l      d5,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		and.l      d7,(a0)
		bra        bullet_ret

bullet3:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.l      d5,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		and.l      d7,(a0)
		bra        bullet_ret

bullet4:
		or.l       d0,(a0)+
		and.l      d1,(a0)+
		or.l       d2,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		or.l       d4,(a0)+
		and.l      d5,(a0)+
		or.l       d6,(a0)+
		and.l      d7,(a0)
		bra        bullet_ret

bullet5:
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		and.l      d3,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		and.l      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		and.l      d7,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)
		bra        bullet_ret

bullet6:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)
		bra        bullet_ret

bullet7:
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		and.w      d3,(a0)+
		or.l       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		and.w      d5,(a0)+
		or.l       d4,(a0)+
		and.w      d5,(a0)+
		and.w      d7,(a0)+
		or.l       d6,(a0)+
		and.w      d7,(a0)
		bra        bullet_ret

bullet8:
		or.l       d0,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d2,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		or.l       d4,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.l       d6,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)
		bra        bullet_ret

bullet9:
		and.l      d1,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d3,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		and.l      d5,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.l      d7,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)
		bra        bullet_ret

bullet10:
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		or.w       d2,(a0)+
		and.l      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		or.w       d4,(a0)+
		and.l      d5,(a0)+
		or.w       d4,(a0)+
		or.w       d6,(a0)+
		and.l      d7,(a0)+
		or.w       d6,(a0)
		bra        bullet_ret

bullet11:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)
		bra        bullet_ret

bullet12:
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		or.l       d2,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		or.l       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		or.l       d6,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)
		bra.s      bullet_ret

bullet13:
		and.l      d1,(a0)+
		or.l       d0,(a0)+
		and.l      d3,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		and.l      d5,(a0)+
		or.l       d4,(a0)+
		and.l      d7,(a0)+
		or.l       d6,(a0)
		bra.s      bullet_ret

bullet14:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.l       d4,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		or.l       d6,(a0)
		bra.s      bullet_ret

bullet15:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		or.l       d0,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		or.l       d4,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		or.l       d6,(a0)
		bra.s      bullet_ret

bullet16:
		or.l       d0,(a0)+
		or.l       d0,(a0)+
		or.l       d2,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		or.l       d4,(a0)+
		or.l       d4,(a0)+
		or.l       d6,(a0)+
		or.l       d6,(a0)

bullet_ret:
		movem.l    (a7)+,a0-a2
		rts

bullet_masktab:
	dc.l 0xc000c000,0x3fff3fff,0x00000000,0xffffffff
	dc.l 0xc000c000,0x3fff3fff,0x00000000,0xffffffff
	dc.l 0x60006000,0x9fff9fff,0x00000000,0xffffffff
	dc.l 0x60006000,0x9fff9fff,0x00000000,0xffffffff
	dc.l 0x30003000,0xcfffcfff,0x00000000,0xffffffff
	dc.l 0x30003000,0xcfffcfff,0x00000000,0xffffffff
	dc.l 0x18001800,0xe7ffe7ff,0x00000000,0xffffffff
	dc.l 0x18001800,0xe7ffe7ff,0x00000000,0xffffffff
	dc.l 0x0c000c00,0xf3fff3ff,0x00000000,0xffffffff
	dc.l 0x0c000c00,0xf3fff3ff,0x00000000,0xffffffff
	dc.l 0x06000600,0xf9fff9ff,0x00000000,0xffffffff
	dc.l 0x06000600,0xf9fff9ff,0x00000000,0xffffffff
	dc.l 0x03000300,0xfcfffcff,0x00000000,0xffffffff
	dc.l 0x03000300,0xfcfffcff,0x00000000,0xffffffff
	dc.l 0x01800180,0xfe7ffe7f,0x00000000,0xffffffff
	dc.l 0x01800180,0xfe7ffe7f,0x00000000,0xffffffff
	dc.l 0x00c000c0,0xff3fff3f,0x00000000,0xffffffff
	dc.l 0x00c000c0,0xff3fff3f,0x00000000,0xffffffff
	dc.l 0x00600060,0xff9fff9f,0x00000000,0xffffffff
	dc.l 0x00600060,0xff9fff9f,0x00000000,0xffffffff
	dc.l 0x00300030,0xffcfffcf,0x00000000,0xffffffff
	dc.l 0x00300030,0xffcfffcf,0x00000000,0xffffffff
	dc.l 0x00180018,0xffe7ffe7,0x00000000,0xffffffff
	dc.l 0x00180018,0xffe7ffe7,0x00000000,0xffffffff
	dc.l 0x000c000c,0xfff3fff3,0x00000000,0xffffffff
	dc.l 0x000c000c,0xfff3fff3,0x00000000,0xffffffff
	dc.l 0x00060006,0xfff9fff9,0x00000000,0xffffffff
	dc.l 0x00060006,0xfff9fff9,0x00000000,0xffffffff
	dc.l 0x00030003,0xfffcfffc,0x00000000,0xffffffff
	dc.l 0x00030003,0xfffcfffc,0x00000000,0xffffffff
	dc.l 0x00010001,0xfffefffe,0x80008000,0x7fff7fff
	dc.l 0x00010001,0xfffefffe,0x80008000,0x7fff7fff

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
 * Syntax: MANY BULLET scr,xadr,yady,statadr,coladr,xoff,yoff,num
 */
lib18:
lib19:
	dc.w	0			; no library calls
many_bullet:
		movem.l    a0-a4,-(a7)
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,a4
		move.l     (a6)+,a3
		move.l     (a6)+,a2
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		tst.l      d5
		bge.s      many_bullet1
		moveq.l    #0,d5
many_bullet1:
		cmpa.w     #32000,a4
		blt.s      many_bullet4
many_bullet2:
		move.l     (a1)+,d0
		sub.w      d3,d0
		move.l     (a2)+,d1
		sub.w      d4,d1
		move.l     (a4)+,d2
		tst.l      (a3)+
		beq.s      many_bullet3
		movem.l    d3-d5/a0-a4,-(a7)
		bsr.s      drawmany
		movem.l    (a7)+,d3-d5/a0-a4
many_bullet3:
		dbf        d5,many_bullet2
		movem.l    (a7)+,a0-a4
		rts
many_bullet4:
		move.l     (a1)+,d0
		sub.w      d3,d0
		move.l     (a2)+,d1
		sub.w      d4,d1
		move.w     a4,d2
		tst.l      (a3)+
		beq.s      many_bullet5
		movem.l    d3-d5/a0-a4,-(a7)
		bsr.s      drawmany
		movem.l    (a7)+,d3-d5/a0-a4
many_bullet5:
		dbf        d5,many_bullet4
		movem.l    (a7)+,a0-a4
		rts

drawmany:
		tst.w      d0
		bmi        drawmany_ret
		cmpi.w     #SCREEN_WIDTH-2,d0
		bgt        drawmany_ret
		tst.w      d1
		bmi        drawmany_ret
		cmpi.w     #SCREEN_HEIGHT-2,d1
		bgt        drawmany_ret
		add.w      d1,d1
		lea.l      lineoffset_table4(pc),a1
		adda.w     d1,a1
		adda.w     (a1),a0
		move.w     d0,d1
		andi.w     #-16,d1
		lsr.w      #1,d1
		adda.w     d1,a0
		andi.w     #15,d2
		add.w      d2,d2
		lea.l      many_bullet_jtable(pc),a1
		adda.w     0(a1,d2.w),a1
		andi.w     #15,d0
		lsl.w      #5,d0
		lea.l      bullet_masktab2(pc),a2
		adda.w     d0,a2
		movem.l    (a2),d0-d7
		jmp        (a1)

many_bullet_jtable:
		dc.w drawmany1-many_bullet_jtable
		dc.w drawmany2-many_bullet_jtable
		dc.w drawmany3-many_bullet_jtable
		dc.w drawmany4-many_bullet_jtable
		dc.w drawmany5-many_bullet_jtable
		dc.w drawmany6-many_bullet_jtable
		dc.w drawmany7-many_bullet_jtable
		dc.w drawmany8-many_bullet_jtable
		dc.w drawmany9-many_bullet_jtable
		dc.w drawmany10-many_bullet_jtable
		dc.w drawmany11-many_bullet_jtable
		dc.w drawmany12-many_bullet_jtable
		dc.w drawmany13-many_bullet_jtable
		dc.w drawmany14-many_bullet_jtable
		dc.w drawmany15-many_bullet_jtable
		dc.w drawmany16-many_bullet_jtable

drawmany1:
		and.l      d1,(a0)+
		and.l      d1,(a0)+
		and.l      d3,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		and.l      d5,(a0)+
		and.l      d5,(a0)+
		and.l      d7,(a0)+
		and.l      d7,(a0)
		rts

drawmany2:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		and.l      d1,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		and.l      d5,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		and.l      d7,(a0)
		rts

drawmany3:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.l      d5,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		and.l      d7,(a0)
		rts

drawmany4:
		or.l       d0,(a0)+
		and.l      d1,(a0)+
		or.l       d2,(a0)+
		and.l      d3,(a0)
		lea.l      148(a0),a0
		or.l       d4,(a0)+
		and.l      d5,(a0)+
		or.l       d6,(a0)+
		and.l      d7,(a0)
		rts

drawmany5:
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		and.l      d3,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		and.l      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		and.l      d7,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)
		rts

drawmany6:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)
		rts

drawmany7:
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		and.w      d3,(a0)+
		or.l       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		and.w      d5,(a0)+
		or.l       d4,(a0)+
		and.w      d5,(a0)+
		and.w      d7,(a0)+
		or.l       d6,(a0)+
		and.w      d7,(a0)
		rts

drawmany8:
		or.l       d0,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d2,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)
		lea.l      146(a0),a0
		or.l       d4,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.l       d6,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)
		rts

drawmany9:
		and.l      d1,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d3,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		and.l      d5,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.l      d7,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)
		rts

drawmany10:
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		or.w       d2,(a0)+
		and.l      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		or.w       d4,(a0)+
		and.l      d5,(a0)+
		or.w       d4,(a0)+
		or.w       d6,(a0)+
		and.l      d7,(a0)+
		or.w       d6,(a0)
		rts

drawmany11:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)
		rts

drawmany12:
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		or.l       d2,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)
		lea.l      146(a0),a0
		or.l       d4,(a0)+
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		or.l       d6,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)
		rts

drawmany13:
		and.l      d1,(a0)+
		or.l       d0,(a0)+
		and.l      d3,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		and.l      d5,(a0)+
		or.l       d4,(a0)+
		and.l      d7,(a0)+
		or.l       d6,(a0)
		rts

drawmany14:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		or.w       d2,(a0)+
		and.w      d3,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		or.w       d4,(a0)+
		and.w      d5,(a0)+
		or.l       d4,(a0)+
		or.w       d6,(a0)+
		and.w      d7,(a0)+
		or.l       d6,(a0)
		rts

drawmany15:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		or.l       d0,(a0)+
		and.w      d3,(a0)+
		or.w       d2,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		and.w      d5,(a0)+
		or.w       d4,(a0)+
		or.l       d4,(a0)+
		and.w      d7,(a0)+
		or.w       d6,(a0)+
		or.l       d6,(a0)
		rts

drawmany16:
		or.l       d0,(a0)+
		or.l       d0,(a0)+
		or.l       d2,(a0)+
		or.l       d2,(a0)
		lea.l      148(a0),a0
		or.l       d4,(a0)+
		or.l       d4,(a0)+
		or.l       d6,(a0)+
		or.l       d6,(a0)

drawmany_ret:
		rts

bullet_masktab2:
	dc.l 0xc000c000,0x3fff3fff,0x00000000,0xffffffff
	dc.l 0xc000c000,0x3fff3fff,0x00000000,0xffffffff
	dc.l 0x60006000,0x9fff9fff,0x00000000,0xffffffff
	dc.l 0x60006000,0x9fff9fff,0x00000000,0xffffffff
	dc.l 0x30003000,0xcfffcfff,0x00000000,0xffffffff
	dc.l 0x30003000,0xcfffcfff,0x00000000,0xffffffff
	dc.l 0x18001800,0xe7ffe7ff,0x00000000,0xffffffff
	dc.l 0x18001800,0xe7ffe7ff,0x00000000,0xffffffff
	dc.l 0x0c000c00,0xf3fff3ff,0x00000000,0xffffffff
	dc.l 0x0c000c00,0xf3fff3ff,0x00000000,0xffffffff
	dc.l 0x06000600,0xf9fff9ff,0x00000000,0xffffffff
	dc.l 0x06000600,0xf9fff9ff,0x00000000,0xffffffff
	dc.l 0x03000300,0xfcfffcff,0x00000000,0xffffffff
	dc.l 0x03000300,0xfcfffcff,0x00000000,0xffffffff
	dc.l 0x01800180,0xfe7ffe7f,0x00000000,0xffffffff
	dc.l 0x01800180,0xfe7ffe7f,0x00000000,0xffffffff
	dc.l 0x00c000c0,0xff3fff3f,0x00000000,0xffffffff
	dc.l 0x00c000c0,0xff3fff3f,0x00000000,0xffffffff
	dc.l 0x00600060,0xff9fff9f,0x00000000,0xffffffff
	dc.l 0x00600060,0xff9fff9f,0x00000000,0xffffffff
	dc.l 0x00300030,0xffcfffcf,0x00000000,0xffffffff
	dc.l 0x00300030,0xffcfffcf,0x00000000,0xffffffff
	dc.l 0x00180018,0xffe7ffe7,0x00000000,0xffffffff
	dc.l 0x00180018,0xffe7ffe7,0x00000000,0xffffffff
	dc.l 0x000c000c,0xfff3fff3,0x00000000,0xffffffff
	dc.l 0x000c000c,0xfff3fff3,0x00000000,0xffffffff
	dc.l 0x00060006,0xfff9fff9,0x00000000,0xffffffff
	dc.l 0x00060006,0xfff9fff9,0x00000000,0xffffffff
	dc.l 0x00030003,0xfffcfffc,0x00000000,0xffffffff
	dc.l 0x00030003,0xfffcfffc,0x00000000,0xffffffff
	dc.l 0x00010001,0xfffefffe,0x80008000,0x7fff7fff
	dc.l 0x00010001,0xfffefffe,0x80008000,0x7fff7fff

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
 * Syntax: MANY SPOT scr,xadr,yady,statadr,coladr,xoff,yoff,num
 */
lib20:
lib21:
	dc.w	0			; no library calls
many_spot:
		movem.l    a0-a4,-(a7)
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,a4
		move.l     (a6)+,a3
		move.l     (a6)+,a2
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		tst.l      d5
		bge.s      many_spot1
		moveq.l    #0,d5
many_spot1:
		cmpa.w     #32000,a4
		ble.s      many_spot4
many_spot2:
		move.l     (a1)+,d0
		sub.w      d3,d0
		move.l     (a2)+,d1
		sub.w      d4,d1
		move.l     (a4)+,d2
		tst.l      (a3)+
		beq.s      many_spot3
		movem.l    d3-d5/a0-a4,-(a7)
		bsr.s      drawspot
		movem.l    (a7)+,d3-d5/a0-a4
many_spot3:
		dbf        d5,many_spot2
		movem.l    (a7)+,a0-a4
		rts
many_spot4:
		move.l     (a1)+,d0
		sub.w      d3,d0
		move.l     (a2)+,d1
		sub.w      d4,d1
		move.w     a4,d2
		tst.l      (a3)+
		beq.s      many_spot5
		movem.l    d3-d5/a0-a4,-(a7)
		bsr.s      drawspot
		movem.l    (a7)+,d3-d5/a0-a4
many_spot5:
		dbf        d5,many_spot4
		movem.l    (a7)+,a0-a4
		rts

drawspot:
		tst.w      d0
		bmi        drawspot_ret
		cmpi.w     #SCREEN_WIDTH-1,d0 ; BUG: should be SCREEN_WIDTH-2
		bgt        drawspot_ret
		tst.w      d1
		bmi        drawspot_ret
		cmpi.w     #SCREEN_HEIGHT-1,d1 ; BUG: should be SCREEN_HEIGHT-2
		bgt        drawspot_ret
		andi.w     #15,d2
		add.w      d1,d1
		lea.l      lineoffset_table5(pc),a1
		adda.w     0(a1,d1.w),a0
		move.w     d0,d1
		andi.w     #-16,d1
		lsr.w      #1,d1
		adda.w     d1,a0
		andi.w     #15,d0
		lsl.w      #3,d0
		lea.l      manyspot_masktable(pc,d0.w),a1
		movem.l    (a1),d0-d1
		add.w      d2,d2
		lea.l      manyspot_jtable(pc),a2
		adda.w     0(a2,d2.w),a2
		jmp        (a2)

manyspot_masktable:
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

manyspot_jtable:
		dc.w drawspot1-manyspot_jtable
		dc.w drawspot2-manyspot_jtable
		dc.w drawspot3-manyspot_jtable
		dc.w drawspot4-manyspot_jtable
		dc.w drawspot5-manyspot_jtable
		dc.w drawspot6-manyspot_jtable
		dc.w drawspot7-manyspot_jtable
		dc.w drawspot8-manyspot_jtable
		dc.w drawspot9-manyspot_jtable
		dc.w drawspot10-manyspot_jtable
		dc.w drawspot11-manyspot_jtable
		dc.w drawspot12-manyspot_jtable
		dc.w drawspot13-manyspot_jtable
		dc.w drawspot14-manyspot_jtable
		dc.w drawspot15-manyspot_jtable
		dc.w drawspot16-manyspot_jtable

drawspot1:
		and.l      d1,(a0)+
		and.l      d1,(a0)
		rts
drawspot2:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		and.l      d1,(a0)
		rts
drawspot3:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.l      d1,(a0)
		rts
drawspot4:
		or.l       d0,(a0)+
		and.l      d1,(a0)
		rts
drawspot5:
		and.l      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		rts
drawspot6:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		rts
drawspot7:
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		and.w      d1,(a0)
		rts
drawspot8:
		or.l       d0,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)
		rts
drawspot9:
		and.l      d1,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		rts
drawspot10:
		or.w       d0,(a0)+
		and.l      d1,(a0)+
		or.w       d0,(a0)
		rts
drawspot11:
		and.w      d1,(a0)+
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		rts
drawspot12:
		or.l       d0,(a0)+
		and.w      d1,(a0)+
		or.w       d0,(a0)
		rts
drawspot13:
		and.l      d1,(a0)+
		or.l       d0,(a0)
		rts
drawspot14:
		or.w       d0,(a0)+
		and.w      d1,(a0)+
		or.l       d0,(a0)
		rts
drawspot15:
		and.w      d1,(a0)+
		or.l       d0,(a0)+
		or.w       d0,(a0)
		rts
drawspot16:
		or.l       d0,(a0)+
		or.l       d0,(a0)
drawspot_ret:
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

libex:
	dc.w 0
