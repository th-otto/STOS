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
timerc_vec = 0x0114
timerb_vec = 0x0120
timera_vec = 0x0134

saved_joyvec = $0418 ; WTF
joybuf       = $041c ; WTF
joysave_flag    = $041e ; WTF
colorptr     = $045a
conterm      = $0484

PACK_ICE2       = 0x49434521 /* "ICE!" */
PACK_ATOMIC     = 0x41544D35 /* "ATM5" */
PACK_FIRE       = 0x46495245 /* "FIRE" */
PACK_AUTOMATION = 0x41553521 /* "AU5!" */
PACK_SPEED2     = 0x53503230 /* "SP20" */
PACK_SPEED3     = 0x53507633 /* "SPv3" */

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
	dc.w	libex-lib32

para:
	dc.w	32			; number of library routines
	dc.w	32			; number of extension commands
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


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; landscape
l002:	.dc.b I,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0             ; overlap
l003:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; bob
l004:	.dc.b I,I,1,1,0           ; map toggle
l005:	.dc.b 0,I,1,1,0           ; wipe
l006:	.dc.b I,I,1,1,0           ; boundary
l007:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0             ; tile
l008:	.dc.b I,I,1,1,0           ; palt
l009:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,1,1,0           ; world
l010:	.dc.b I,I,',',I,',',I,1,1,0             ; musauto
l011:	.dc.b 0,I,',',I,',',I,1,1,0             ; musplay
l012:	.dc.b I,I,',',I,',',I,1,1,0             ; which block
l013:	.dc.b 0,I,1,1,0           ; relocate
l014:	.dc.b I,I,1,1,0           ; p left
l015:	.dc.b 0,1,1,0             ; p on
l016:	.dc.b I,I,1,1,0           ; p joy
l017:	.dc.b 0,1,1,0             ; p stop
l018:	.dc.b I,I,1,1,0           ; p up
l019:	.dc.b 0,I,',',I,',',I,',',I,1,1,0             ; set block
l020:	.dc.b I,I,1,1,0           ; p right
l021:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0             ; palsplit
l022:	.dc.b I,I,1,1,0           ; p down
l023:	.dc.b 0,I,1,1,0           ; floodpal
l024:	.dc.b I,I,1,1,0           ; p fire
l025:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0     ; digi play
l026:	.dc.b I,I,1,1,0           ; string
l027:	.dc.b 0,I,',',I,1,1,0     ; samsign
l028:	.dc.b I,I,1,1,0           ; depack
l029:	.dc.b 0,I,',',I,',',I,1,1,0 ; replace blocks
l030:	.dc.b I,I,',',I,',',I,',',I,1,1,0             ; dload
l031:	.dc.b 0,I,',',I,1,1,0     ; display pc1
l032:	.dc.b I,I,',',I,',',I,',',I,1,1,0             ; dsave

		.even

entry:  bra.w init

init:
		lea        exit(pc),a2
		rts

exit:
		rts


; -----------------------------------------------------------------------------

/*
 * Syntax: LANDSCAPE x1,y1,x2,y2,0,1
 *         LANDSCAPE scr,gadr,madr,x,y,0
 */
lib1:
	dc.w	0			; no library calls
landscape:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d0
		tst.w      d0
		bne        landscape_init
		move.l     (a6)+,d7
		move.l     (a6)+,d6
		move.l     (a6)+,a1
		move.l     (a6)+,a2
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
		tst.w      d0 ; FIXME: already done above
		bne        landscape_init
		cmpi.l     #0x03031973,(a1)+
		bne        landscape_ret
		cmpi.l     #0x18E7074C,(a2)+
		bne        landscape_ret
		lea.l      36(a2),a2
		moveq.l    #0,d0
		lea.l      landscape_screenoffset(pc),a3
		adda.w     (a3)+,a0 ; get screen offset
		move.w     (a3)+,d3 ; get width
		move.w     (a3),d2 ; get height
		movem.w    (a1)+,d4-d5
		addq.w     #2,d4
		lea.l      landscape_mapx(pc),a3
		move.w     d4,(a3)
		lsr.w      #1,d5
		subq.w     #1,d5
		subq.w     #1,d5
		sub.w      d2,d5
		lsl.w      #4,d5
		cmp.w      d5,d7
		ble.s      landscape1
		move.w     d5,d7
landscape1:
		tst.w      d7
		bge.s      landscape2
		moveq.l    #0,d7
landscape2:
		.IFNE 0 ; FIXME, missing
		tst.w      d6
		bge.s      landscape3
		moveq.l    #0,d6
		.ENDC
landscape3:
		lsr.w      #4,d6
		add.w      d6,d6
		adda.w     d6,a1
		move.w     d7,d6
		andi.w     #15,d7
		lsl.w      #3,d7
		lsr.w      #4,d6
		mulu.w     d4,d6
		adda.w     d6,a1
		movea.l    a2,a6
		move.w     d2,d0
		move.w     d7,d6
		move.w     d3,d1
		lea.l      -8(a0),a4
		moveq      #0,d4			; dml
landscape4:
		movea.l    a6,a2
		adda.w     d7,a2
		move.w     (a1)+,d4		; dml
		add.l      d4,a2
		lea.l      landscape_loop(pc,d7.w),a3
		lea.l      8(a4),a4
		movea.l    a4,a0
		jmp        (a3)
landscape_loop:
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2),(a0)+
		dbf        d1,landscape4
		moveq      #19,d4
		sub.w      d3,d4
		lsl.w      #3,d4
		adda.w     d4,a0
		lea.l      landscape_mapx(pc),a4
		move.w     (a4),d4
		sub.w      d3,d4
		sub.w      d3,d4
		subq.w     #2,d4
		adda.w     d4,a1
		moveq      #0,d1			; dml
landscape5:
		movea.l    a0,a5
		movea.l    a0,a4
		move.w     d3,d7
landscape6:
		movea.l    a6,a2
		move.w     (a1)+,d1		; dml
		add.l      d1,a2
		movea.l    a4,a0
		lea.l      8(a4),a4
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2),(a0)
		dbf        d7,landscape6
		lea.l      2560(a5),a0
		adda.w     d4,a1
		dbf        d0,landscape5
		moveq      #120,d7
		sub.w      d6,d7
		move.w     d3,d1
		lea.l      landscape_loop2(pc,d7.w),a3
landscape7:
		movea.l    a6,a2
		move.w     (a1)+,d7		; dml
		add.l      d7,a2
		movea.l    a0,a4
		jmp        (a3)
landscape_loop2:
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2)+,(a0)
		lea.l      156(a0),a0
		move.l     (a2)+,(a0)+
		move.l     (a2),(a0)
		nop
		nop
		lea.l      8(a4),a0
		dbf        d1,landscape7
landscape_ret:
		movea.l    (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

landscape_init:
		lea.l      4(a6),a6 ; skip dummy arg
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x1
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		tst.w      d0
		bge.s      landscape_init1
		moveq.l    #0,d0
landscape_init1:
		cmpi.w     #SCREEN_WIDTH-16,d0 ; FIXME screen size
		ble.s      landscape_init2
		move.w     #SCREEN_WIDTH-16,d0
landscape_init2:
		tst.w      d1
		bge.s      landscape_init3
		moveq.l    #0,d1
landscape_init3:
		cmpi.w     #SCREEN_HEIGHT-16,d1
		ble.s      landscape_init4
		move.w     #SCREEN_HEIGHT-16,d1
landscape_init4:
		sub.w      d1,d3 ; d3 = height
		sub.w      d0,d2 ; d2 = width
		lsr.w      #4,d3
		lsr.w      #4,d2
		andi.w     #-16,d0
		lsr.w      #1,d0
		mulu.w     #160,d1
		add.w      d1,d0
		lea.l      landscape_screenoffset(pc),a0
		move.w     d0,(a0) ; BUG: should be long
		move.w     d2,d0
		move.w     d3,d1
		subq.w     #1,d0
		subq.w     #2,d1
		tst.w      d0
		bge.s      landscape_init5
		moveq.l    #0,d0
landscape_init5:
		tst.w      d1
		bge.s      landscape_init6
		moveq.l    #0,d1
landscape_init6:
		cmpi.w     #19,d0
		ble.s      landscape_init7
		moveq.l    #19,d0
landscape_init7:
		cmpi.w     #10,d1
		ble.s      landscape_init8
		moveq.l    #10,d1
landscape_init8:
		lea.l      landscape_width(pc),a0
		move.w     d0,(a0)+
		move.w     d1,(a0)
landscape_end:
		movem.l    (a7)+,a0-a5
		rts

landscape_screenoffset: ds.w 1 ; BUG: should be long
landscape_width: dc.w 19 ; in words
landscape_height: dc.w 10 ; in words
landscape_mapx: ds.w 1

; -----------------------------------------------------------------------------

/*
 * Syntax: r = OVERLAP (x1,y1,x2,y2,wd1,hg1,wd2,hg2)
 */
lib2:
	dc.w	0			; no library calls
overlap:
		movem.l    d5-d7/a0,-(a7)
		move.l     (a6)+,d7
		move.l     (a6)+,d6
		move.l     (a6)+,d5
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		movea.w    d0,a0
		adda.w     d4,a0
		cmpa.w     d2,a0
		blt.s      overlap1
		movea.w    d2,a0
		adda.w     d6,a0
		cmp.w      a0,d0
		bge.s      overlap1
		movea.w    d1,a0
		adda.w     d5,a0
		cmpa.w     d3,a0
		blt.s      overlap1
		movea.w    d3,a0
		adda.w     d7,a0
		cmp.w      a0,d1
		bge.s      overlap1
		move.l     #-1,-(a6)
		movem.l    (a7)+,d5-d7/a0
		rts
overlap1:
		move.l     #0,-(a6)
		movem.l    (a7)+,d5-d7/a0
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: BOB x1,y1,x2,y2,0,1
 *         BOB scr,gadr,img,x,y,0
 */
lib3:
	dc.w	0			; no library calls
bob:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d6
		cmpi.w     #1,d6
		beq        bob_init
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		moveq.l    #0,d3
		move.l     d3,d4
		move.l     d3,d5
		move.l     d3,d7
		movea.l    d3,a2
		movea.l    d3,a3
		movea.l    d3,a4
		movea.l    d3,a5
		movea.l    d3,a6
bobpatch1:
		cmpi.w     #-64,d1 ; patched with x1-64
		blt        bob_end
bobpatch2:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        bob_end
bobpatch2_1:
		cmpi.w     #-64,d2 ; patched with y1-64
		blt        bob_end
bobpatch3:
		cmpi.w     #SCREEN_HEIGHT,d2 ; patched with y2
		bge        bob_end
		cmpi.l     #0x38964820,(a1)
		bne        bob_end
		move.w     4(a1),d7
		cmp.w      d7,d0
		bge        bob_end
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
		beq.s      bob1
		sub.w      a5,d3
		bra.s      bob2_1
bob1:
		subi.w     #16,d4
bob2:
		tst.w      d4
		bge.s      bob2_1
		moveq.l    #0,d4
bob2_1:
		adda.l     d3,a1
		cmpi.w     #99,d6
		bne.s      bob3
		lsr.w      #4,d4
		move.w     d4,d5
		bra        bob32
bob3:
bobpatch4:
		move.w     #0xdead,d5 ; patched with y1
		sub.w      d7,d5
		lea.l      bobpatch7_1(pc),a2
		move.w     d5,2(a2)
		lea.l      bobpatch9_1(pc),a2
		move.w     d7,2(a2)
bobpatch5:
		move.w     #SCREEN_HEIGHT-1,d5 ; patched with y2
		sub.w      d7,d5
		lea.l      bobpatch9_2(pc),a2
		move.w     d5,2(a2)
		lea.l      bobpatch9_3(pc),a2
		move.w     d5,2(a2)
bobpatch6:
		cmpi.w     #SCREEN_HEIGHT-1,d2 ; patched with y2
		blt.s      bob4
		bra        bob_end
bob4:
bobpatch7:
		cmpi.w     #0xdead,d2 ; patched with y1
		bge.s      bob7
bobpatch7_1:
		cmpi.w     #-16,d2
		bgt.s      bob5
		bra        bob_end
bob5:
bobpatch8:
		move.w     #0xdead,d7 ; patched with y1
		sub.w      d2,d7
		tst.w      d7
		bge.s      bob6
		neg.w      d7
bob6:
		move.w     d7,d2
		lsl.w      #3,d2
		add.w      d7,d2
		add.w      d7,d2
		add.w      d7,d2
		add.w      d7,d2
		adda.w     d2,a1
bobpatch9:
		move.w     #0xdead,d2 ; patched with y1
bobpatch9_1:
		move.w     #16,d6
		sub.w      d7,d6
		move.w     d6,d7
		bra.s      bob8
bob7:
bobpatch9_2:
		cmpi.w     #SCREEN_HEIGHT-16,d2
		ble.s      bob8
		move.l     d2,d6
bobpatch9_3:
		subi.w     #SCREEN_HEIGHT-16,d6
		sub.w      d6,d7
bob8:
		lsr.w      #3,d4
		lea.l      bob_jtab(pc),a2
		adda.w     0(a2,d4.w),a2
		jmp        (a2)

bob_jtab:
	dc.w bob31-bob_jtab
	dc.w bob28-bob_jtab
	dc.w bob24-bob_jtab
	dc.w bob17-bob_jtab
	dc.w bob9-bob_jtab

bob9:
bobpatch10:
    	cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      bob12
bobpatch11:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      bob10
		adda.w     a5,a1
		moveq.l    #3,d5
bobpatch12:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob10:
bobpatch13:
		cmpi.w     #-32,d1
		blt.s      bob11
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #2,d5
bobpatch14:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob11:
bobpatch15:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt.s      bob11_1
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
bobpatch16:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob11_1:
bobpatch17:
		cmpi.w     #-64,d1 ; patched with x1-64
		ble        bob_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
bobpatch18:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob12:
bobpatch19:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        bob_end
bobpatch20:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      bob13
		moveq.l    #0,d5
		bra        bob32
bob13:
bobpatch21:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      bob14
		moveq.l    #1,d5
		bra        bob32
bob14:
bobpatch22:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      bob15
		moveq.l    #2,d5
		bra        bob32
bob15:
bobpatch23:
		cmpi.w     #SCREEN_WIDTH-64,d1 ; patched with x2-64
		blt.s      bob16
		moveq.l    #3,d5
		bra        bob32
bob16:
		moveq.l    #4,d5
		bra        bob32
bob17:
bobpatch24:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      bob20
bobpatch25:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      bob18
		adda.w     a5,a1
		moveq.l    #2,d5
bobpatch26:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob18:
bobpatch27:
		cmpi.w     #-32,d1 ; patched with x1-32
		blt.s      bob19
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #1,d5
bobpatch28:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob19:
bobpatch29:
		cmpi.w     #-48,d1 ; patched with x1-48
		blt        bob_end
		adda.w     a5,a1
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
bobpatch30:
		move.w     #0xdead,d1 ; patched with x1
		bra        bob32
bob20:
bobpatch31:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        bob_end
bobpatch32:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      bob21
		moveq.l    #0,d5
		bra        bob32
bob21:
bobpatch33:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      bob22
		moveq.l    #1,d5
		bra        bob32
bob22:
bobpatch34:
		cmpi.w     #SCREEN_WIDTH-48,d1 ; patched with x2-48
		blt.s      bob23
		moveq.l    #2,d5
		bra        bob32
bob23:
		moveq.l    #3,d5
		bra        bob32
bob24:
bobpatch35:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      bob26
bobpatch36:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt.s      bob25
		adda.w     a5,a1
		moveq.l    #1,d5
bobpatch37:
		move.w     #0xdead,d1 ; patched with x1
		bra.s      bob32
bob25:
bobpatch38:
		cmpi.w     #-32,d1 ; patched with x1-32
		ble        bob_end
		adda.w     a5,a1
		adda.w     a5,a1
		moveq.l    #0,d5
bobpatch39:
		move.w     #0xdead,d1 ; patched with x1
		bra.s      bob32
bob26:
bobpatch40:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        bob_end
bobpatch41:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      bob26_1
		moveq.l    #0,d5
		bra.s      bob32
bob26_1:
bobpatch42:
		cmpi.w     #SCREEN_WIDTH-32,d1 ; patched with x2-32
		blt.s      bob27
		moveq.l    #1,d5
		bra.s      bob32
bob27:
		moveq.l    #2,d5
		bra.s      bob32
bob28:
bobpatch43:
		cmpi.w     #0xdead,d1 ; patched with x1
		bge.s      bob29
bobpatch44:
		cmpi.w     #-16,d1 ; patched with x1-16
		blt        bob_end
		adda.w     a5,a1
		moveq.l    #0,d5
bobpatch45:
		move.w     #0xdead,d1 ; patched with x1
		bra.s      bob32
bob29:
bobpatch46:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		blt.s      bob29_1
		bra        bob_end
bob29_1:
bobpatch46_1:
		cmpi.w     #SCREEN_WIDTH-16,d1 ; patched with x2-16
		blt.s      bob30
		moveq.l    #0,d5
		bra.s      bob32
bob30:
		moveq.l    #1,d5
		bra.s      bob32
bob31:
bobpatch47:
		cmpi.w     #0xdead,d1 ; patched with x1
		blt        bob_end
bobpatch48:
		cmpi.w     #SCREEN_WIDTH,d1 ; patched with x2
		bge        bob_end
		moveq.l    #0,d5
bob32:
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
		lea.l      bob34(pc,d6.w),a4
bob33:
		jmp        (a4)
bob34:
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
		dbf        d5,bob33
		bra        bob_end

bob_init:
		lea.l      4(a6),a6 ; skip dummy arg
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x1
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		move.l     a6,-(a7)
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		bge.s      bob_init1
		moveq.l    #0,d0
bob_init1:
		cmpi.w     #SCREEN_WIDTH,d2 ; FIXME screensize
		ble.s      bob_init2
		move.w     #SCREEN_WIDTH,d2
bob_init2:
		/* tst.w      d1 */
		dc.w 0x0c41,0 /* XXX */
		bge.s      bob_init3
		moveq.l    #0,d1
bob_init3:
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.s      bob_init4
		move.w     #SCREEN_HEIGHT,d3
bob_init4:
		andi.w     #-16,d0
		andi.w     #-16,d2
		lea.l      bobpatch7(pc),a0
		move.w     d1,2(a0)
		lea.l      bobpatch9(pc),a0
		move.w     d1,2(a0)
		lea.l      bobpatch8(pc),a0
		move.w     d1,2(a0)
		lea.l      bobpatch4(pc),a0
		move.w     d1,2(a0)
		subi.w     #64,d1
		lea.l      bobpatch2_1(pc),a0
		move.w     d1,2(a0)
		lea.l      bobpatch6(pc),a0
		move.w     d3,2(a0)
		lea.l      bobpatch5(pc),a0
		move.w     d3,2(a0)
		lea.l      bobpatch3(pc),a0
		move.w     d3,2(a0)
		lea.l      bobpatch43(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch47(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch35(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch37(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch39(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch45(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch24(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch26(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch28(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch30(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch10(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch12(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch14(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch16(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch18(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      bobpatch44(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch36(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch25(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch11(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      bobpatch38(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch27(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch13(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      bobpatch29(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch15(pc),a0
		move.w     d0,2(a0)
		subi.w     #16,d0
		lea.l      bobpatch17(pc),a0 ; BUG: not patched
		lea.l      bobpatch1(pc),a0
		move.w     d0,2(a0)
		lea.l      bobpatch46(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch40(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch31(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch48(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch19(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch2(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      bobpatch46_1(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch41(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch32(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch20(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      bobpatch42(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch33(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch21(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      bobpatch34(pc),a0
		move.w     d2,2(a0)
		lea.l      bobpatch22(pc),a0
		move.w     d2,2(a0)
		subi.w     #16,d2
		lea.l      bobpatch23(pc),a0
		move.w     d2,2(a0)
bob_end:
		move.l     (a7)+,a6
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
 * Syntax: n = MAP TOGGLE(madr)
 */
lib4:
	dc.w	0			; no library calls
map_toggle:
		move.l     a0,-(a7)
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)
		bne.s      map_toggle1
		moveq.l    #7,d4
		moveq.l    #8,d5
		move.l     #0x02528E54,(a0)+
		bra.s      map_toggle2
map_toggle1:
		cmpi.l     #0x02528E54,(a0)
		bne        map_toggle_end
		moveq.l    #8,d4
		moveq.l    #7,d5
		move.l     #0x03031973,(a0)+
map_toggle2:
		moveq.l    #0,d2
		movem.w    (a0)+,d2-d3
		addq.w     #2,d2
		lsr.w      #1,d2
		lsr.w      #1,d3
		mulu.w     d3,d2
		subq.w     #1,d2
map_toggle3:
		move.w     (a0),d3
		lsr.w      d4,d3
		lsl.w      d5,d3
		move.w     d3,(a0)+
		dbf        d2,map_toggle3
map_toggle_end:
		move.l     (a7)+,a0
		move.l     #0,(a6) ; BUG: should be -(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: WIPE scr
 */
lib5:
	dc.w	0			; no library calls
wipe:
		movem.l    a0-a6,-(a7)
		move.l     (a6)+,a5
		lea.l      32000(a5),a6
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		move.l     d1,d6
		move.l     d1,d7
		movea.l    d1,a0
		movea.l    d1,a1
		movea.l    d1,a2
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		moveq.l    #6-1,d0
wipe1:
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		dbf        d0,wipe1
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d7/a0-a5,-(a6)
		movem.l    d1-d5,-(a6)
		movem.l    (a7)+,a0-a6
		addq.w     #4,a6 ; adjust again for popped parameter
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: r = BOUNDARY (n)
 */
lib6:
	dc.w	0			; no library calls
boundary:
		andi.w     #-16,2(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: TILE scr,gadr,img,x,y
 */
lib7:
	dc.w	0			; no library calls
tile:
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		movem.l    a1-a6,-(a7)
		cmpi.l     #0x003D2067,(a1)+
		bne        tile_end
		move.w     (a1)+,d3
		cmp.w      d3,d0
		bne.s      tile1
		move.w     d3,d0
tile1:
		andi.w     #15,d1
		andi.w     #15,d2
		moveq.l    #12,d3
		lsl.w      d3,d0
		lsl.w      #8,d1
		lsl.w      #3,d2
		add.w      d1,d0
		add.w      d2,d0
		lea.l      32(a1,d0.w),a1
		lea.l      32000(a0),a0
		movea.l    a1,a6
		moveq.l    #11,d7
tile2:
		movea.l    a6,a1
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		dbf        d7,tile2
		movea.l    a6,a1
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    (a1)+,d0-d1
		move.l     d0,d2
		move.l     d1,d3
		move.l     d0,d4
		move.l     d1,d5
		move.l     d0,d6
		movea.l    d1,a2
		movea.l    d0,a3
		movea.l    d1,a4
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
		movem.l    d0-d6/a2-a4,-(a0)
tile_end:
		movem.l    (a7)+,a1-a6
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: r = PALT (gadr)
 */
lib8:
	dc.w	0			; no library calls
palt:
		move.l     (a6),a0
		cmpi.l     #0x19861987,(a0) ; is it a sprite bank?
		beq.s      palt5
		cmpi.l     #0x003D2067,(a0)
		bne.s      palt1
		moveq.l    #6,d1
		bra.s      palt7
palt1:
		cmpi.l     #0x07793868,(a0)
		bne.s      palt2
		moveq.l    #8,d1
		bra.s      palt7
palt2:
		cmpi.l     #0x18E7074C,(a0)
		bne.s      palt3
		moveq.l    #8,d1
		bra.s      palt7
palt3:
		cmpi.l     #0x38964820,(a0)
		bne.s      palt4
		move.w     #6,d1
		bra.s      palt7
palt4:
		move.l     #0,(a6)
		rts
palt5:
		move.l     #(256000/2)-1,d0 ; WTF?
		moveq.l    #4,d1
palt6:
		cmpi.l     #0x50414C54,(a0) ; 'PALT'
		beq.s      palt7
		lea.l      2(a0),a0
		dbf        d0,palt6
		move.l     #0,(a6)
		rts
palt7:
		adda.l     d1,a0
		move.l     a0,colorptr /* FIXME: use Setpalette */
		move.l     a0,(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: WORLD x1,y1,x2,y2,0,1
 *         WORLD scr,gadr,madr,x,y,0
 */
lib9:
	dc.w	0			; no library calls
world:
		tst.l      (a6)+
		bne        world_init
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,a2
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		moveq.l    #0,d0
		move.l     d0,d1
		move.l     d0,d4
		move.l     d0,d5
		move.l     d0,d6
		move.l     d0,d7
		movea.l    d0,a3
		movea.l    d0,a4
		movea.l    d0,a5
		movea.l    d0,a6
		tst.w      d7
		bne        world_init ; FIXME; already done above
		cmpi.l     #0x07793868,(a1)+
		bne        world_end
		cmpi.l     #0x02528E54,(a2)+
		bne        world_end
		tst.w      d2
		bge.s      world1
		moveq.l    #0,d2
world1:
		tst.w      d3
		bge.s      world2
		moveq.l    #0,d3
world2:
		move.w     (a2)+,d0
		lea        x12004(pc),a5
		move.w     d0,(a5)
		move.w     (a2)+,d1
		subq.w     #2,d1
		lsr.w      #1,d0
		lsr.w      #1,d1
		lea.l      world_width(pc),a5
		sub.w      (a5)+,d0
		sub.w      (a5),d1
		lsl.w      #4,d0
		lsl.w      #4,d1
		cmp.w      d0,d2
		ble.s      world3
		move.w     d0,d2
world3:
		cmp.w      d1,d3
		ble.s      world4
		move.w     d1,d3
world4:
		movem.w    world_width(pc),d0-d1
		moveq.l    #16,d5
		move.w     (a1)+,d6
		lsr.w      d6,d5
		move.w     d2,d6
		andi.w     #15,d6
		divu.w     d5,d6
		mulu.w     (a1)+,d6
		lea.l      32(a1,d6.l),a3
		lea.l      128(a3),a1
		andi.w     #-16,d2
		lsr.w      #3,d2
		adda.w     d2,a2
		move.w     d3,d2
		andi.w     #15,d3
		lea        x12006(pc),a5
		move.w     d3,(a5)
		lsr.w      #4,d2
		tst.w      d2
		bge.s      world5
		moveq.l    #0,d2
		bra.s      world6
world5:
		move.w     x12004(pc),d6
		addq.w     #2,d6
		mulu.w     d6,d2
world6:
		adda.l     d2,a2
		moveq.l    #0,d5
		move.l     d5,d6
		adda.w     world_screenoffset(pc),a0
		moveq.l    #0,d7
		move.l     a0,-(a7)
		move.l     a2,-(a7)
		move.w     d3,d7
		lsl.w      #3,d7
		move.w     d7,d2
		add.w      d7,d7
		move.w     d3,d4
		add.w      d4,d4
		lea.l      lineoffset_table2(pc),a5
		adda.w     d4,a5
		move.w     #2400,d6
		sub.w      (a5),d6
		neg.w      d6
		lea.l      world8(pc,d7.w),a4
world7:
		movea.l    a1,a5
		adda.w     d2,a5
		movea.l    a3,a6
		adda.w     d2,a6
		move.w     (a2)+,d7			; dml
		add.l      d7,a5
		move.w     (a2),d7
		add.l      d7,a6
		jmp        (a4)
world8:
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6),d4-d5
		or.l       (a5)+,d4
		or.l       (a5),d5
		movem.l    d4-d5,(a0)
		lea.l      8(a0,d6.w),a0
		dbf        d0,world7
		subq.w     #1,d1
		movea.l    (a7)+,a2
		lea.l      2(a2),a2
		neg.w      d6
		movea.l    (a7)+,a0
		adda.w     d6,a0
		lea.l      160(a0),a0
		adda.w     x12004(pc),a2
		tst.w      d1
		bge.s      world9
		movem.w    world_width(pc),d0-d1
		bra        world12
world9:
		move.w     world_width(pc),d0
		movea.l    a0,a4
		move.l     a0,-(a7)
		move.w     d1,-(a7)
world10:
		move.w     (a7),d1
		move.l     a2,-(a7)
world11:
		movea.l    a1,a5
		movea.l    a3,a6
		moveq      #0,d2			; dml
		move.w     (a2)+,d2
		add.l      d2,a5
		move.w     (a2),d2
		add.l      d2,a6
		movem.l    (a6)+,d2-d7
		or.l       (a5)+,d2
		or.l       (a5)+,d3
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		or.l       (a5)+,d6
		or.l       (a5)+,d7
		movem.l    d2-d3,(a0)
		movem.l    d4-d5,160(a0)
		movem.l    d6-d7,320(a0)
		lea.l      480(a0),a0
		movem.l    (a6)+,d2-d7
		or.l       (a5)+,d2
		or.l       (a5)+,d3
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		or.l       (a5)+,d6
		or.l       (a5)+,d7
		movem.l    d2-d3,(a0)
		movem.l    d4-d5,160(a0)
		movem.l    d6-d7,320(a0)
		lea.l      480(a0),a0
		movem.l    (a6)+,d2-d7
		or.l       (a5)+,d2
		or.l       (a5)+,d3
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		or.l       (a5)+,d6
		or.l       (a5)+,d7
		movem.l    d2-d3,(a0)
		movem.l    d4-d5,160(a0)
		movem.l    d6-d7,320(a0)
		lea.l      480(a0),a0
		movem.l    (a6)+,d2-d7
		or.l       (a5)+,d2
		or.l       (a5)+,d3
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		or.l       (a5)+,d6
		or.l       (a5)+,d7
		movem.l    d2-d3,(a0)
		movem.l    d4-d5,160(a0)
		movem.l    d6-d7,320(a0)
		lea.l      480(a0),a0
		movem.l    (a6)+,d2-d7
		or.l       (a5)+,d2
		or.l       (a5)+,d3
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		or.l       (a5)+,d6
		or.l       (a5)+,d7
		movem.l    d2-d3,(a0)
		movem.l    d4-d5,160(a0)
		movem.l    d6-d7,320(a0)
		lea.l      480(a0),a0
		movem.l    (a6),d2-d3
		or.l       (a5)+,d2
		or.l       (a5),d3
		movem.l    d2-d3,(a0)
		lea.l      160(a0),a0
		adda.w     x12004(pc),a2
		dbf        d1,world11
		lea.l      8(a4),a4
		movea.l    a4,a0
		movea.l    (a7)+,a2
		addq.w     #2,a2
		dbf        d0,world10
		addq.w     #2,a7
		movea.l    (a7)+,a0
		movem.w    world_width(pc),d0-d1
		lsl.w      #1,d0 ; FIXME; may overflow
		suba.l     d0,a2
		subq.w     #2,a2
		lsr.w      #1,d0 ; FIXME
		moveq.l    #0,d7
		move.w     x12004(pc),d7
		addq.w     #2,d7
		mulu.w     d1,d7
		adda.w     d7,a2
		lsl.w      #5,d1
		lea.l      lineoffset_table2(pc),a5
		adda.w     d1,a5
		adda.w     (a5),a0
world12:
		move.w     x12006(pc),d1
		tst.w      d1
		beq        world_end
		moveq.l    #15,d7
		sub.w      d1,d7
		lsl.w      #4,d7
		lea.l      world14(pc,d7.w),a4
world13:
		lea.l      128(a3),a5
		move.w     (a2)+,d7			; dml
		add.l      d7,a5
		move.l     a3,a6
		move.w     (a2),d7
		add.l      d7,a6
		movea.l    a0,a1
		jmp        (a4)
world14:
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6)+,d4-d5
		or.l       (a5)+,d4
		or.l       (a5)+,d5
		movem.l    d4-d5,(a0)
		lea.l      160(a0),a0
		movem.l    (a6),d4-d5
		or.l       (a5)+,d4
		or.l       (a5),d5
		movem.l    d4-d5,(a0)
		lea.l      8(a1),a0
		dbf        d0,world13
world_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,a0-a5
		rts

world_init:
		lea.l      4(a6),a6 ; skip dummy arg
		move.l     (a6)+,d3 ; y2
		move.l     (a6)+,d2 ; x1
		move.l     (a6)+,d1 ; y1
		move.l     (a6)+,d0 ; x1
		move.l     a0,-(a7)
		tst.w      d0
		bge.s      world_init1
		moveq.l    #0,d0
world_init1:
		cmpi.w     #SCREEN_WIDTH-16,d0 ; FIXME screensize
		ble.s      world_init2
		move.w     #SCREEN_WIDTH-16,d0
world_init2:
		tst.w      d1
		bge.s      world_init3
		moveq.l    #0,d1
world_init3:
		cmpi.w     #SCREEN_HEIGHT-16,d1
		ble.s      world_init4
		move.w     #SCREEN_HEIGHT-16,d1
world_init4:
		sub.w      d1,d3
		sub.w      d0,d2
		lsr.w      #4,d3
		lsr.w      #4,d2
		andi.w     #-16,d0
		lsr.w      #1,d0
		mulu.w     #160,d1
		add.w      d1,d0
		lea.l      world_screenoffset(pc),a0
		move.w     d0,(a0)
		subq.w     #1,d2
		subq.w     #1,d3
		tst.w      d2
		bge.s      world_init5
		moveq.l    #0,d2
world_init5:
		tst.w      d3
		bge.s      world_init6
		moveq.l    #0,d3
world_init6:
		cmpi.w     #19,d2
		ble.s      world_init7
		moveq.l    #19,d2
world_init7:
		cmpi.w     #11,d3
		ble.s      world_init8
		moveq.l    #11,d3
world_init8:
		lea.l      world_width(pc),a0
		move.w     d2,(a0)+
		move.w     d3,(a0)
		move.l     (a7)+,a0
		rts

world_width: dc.w 19
world_height: dc.w 9
x12004: dc.w 798
x12006: ds.w 1
world_screenoffset: ds.w 1

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

*
* FIXME: this is an older version, and returns different type numbers than
* the interpreter version
*

/*
 * Syntax: r = MUSAUTO (adr,num,size)
 */
lib10:
	dc.w	0			; no library calls
musauto:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d1 ; size
		move.l     (a6)+,d0 ; sound num
		move.l     (a6)+,a0 ; addr
		move.l     a6,-(a7)
		andi.l     #-2,d1
		tst.w      d0
		beq        musstop
		lea.l      mus_inited(pc),a1
		cmpi.w     #1,(a1)
		beq        musauto_end
		move.w     #1,(a1)
		lea.l      mus_soundtype(pc),a2
		lea.l      mus_soundoffset(pc),a3
		movea.l    a0,a1

musautoloop:
		cmpi.l     #"TFMX",(a1) ; Mad Max
		bne.s      musauto1
		move.w     #1,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto1:
		cmpi.l     #"COSO",(a1) ; Mad Max
		bne.s      musauto2
		move.w     #1,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto2:
		cmpi.l     #"Coun",(a1) ; Count Zero
		bne.s      musauto3
		move.w     #2,(a2)
		move.w     #2,(a3)
		bra        soundplay1

musauto3:
		cmpi.l     #"P 19",(a1) ; Lap #1
		bne.s      musauto4
		move.w     #3,(a2)
		move.w     #62,(a3)
		bra        soundplay1

musauto4:
		cmpi.l     #"AP 9",(a1) ; Lap #2
		bne.s      musauto5
		move.w     #4,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto5:
		cmpi.l     #"YM21",(a1) ; Big Alec (old)
		bne.s      musauto6
		move.w     #5,(a2)
		move.w     #4,(a3)
		bra        soundplay1

musauto6:
		cmpi.l     #"STIC",(a1) ; LTK
		bne.s      musauto7
		move.w     #10,(a2)
		move.w     #2,(a3)
		bra        soundplay1

musauto7:
		cmpi.l     #"ille",(a1) ; Megatizer
		bne.s      musauto8
		move.w     #11,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto8:
		cmpi.l     #"NDEA",(a1) ; Ninja Turtle
		bne.s      musauto9
		move.w     #6,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto9:
		cmpi.l     #"ZOUN",(a1) ; Zound Dragger
		bne.s      musauto10
		move.w     #7,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto10:
		cmpi.l     #"THIZ",(a1) ; TAO (chip #1)
		bne.s      musauto11
		move.w     #8,(a2)
		move.w     #4,(a3)
		bra        soundplay1

musauto11:
		cmpi.l     #"ENEX",(a1) ; Titan
		bne.s      musauto12
		move.w     #9,(a2)
		move.w     #4,(a3)
		bra        soundplay1

musauto12:
		cmpi.l     #" C D",(a1) ; Synth Dream
		bne.s      musauto13
		move.w     #12,(a2)
		move.w     #26,(a3)
		bra        soundplay1

musauto13:
		cmpi.l     #"BADF",(a1) ; Big Alec (new)
		bne.s      musauto14
		move.w     #13,(a2)
		move.w     #8,(a3)
		bra        soundplay1

musauto14:
		cmpi.l     #"M4M1",(a1) ; Ben Daglish
		bne.s      musauto15
		move.w     #14,(a2)
		move.w     #4,(a3)
		bra        soundplay1

musauto15:
		cmpi.l     #"LARY",(a1) ; FFT
		bne.s      musauto16
		move.w     #15,(a2)
		move.w     #34,(a3)
		bra.w      soundplay1

musauto16:
		cmpi.l     #"(c)L",(a1) ; Lap (1 scanline)
		bne.s      musauto17
		move.w     #18,(a2)
		move.w     #312,(a3)
		bra.s      soundplay1

musauto17:
		cmpi.l     #"TAO-",(a1) ; TAO (digi)
		bne.s      musauto18
		move.w     #19,(a2)
		move.w     #8,(a3)
		bra.s      soundplay1

musauto18:
		cmpi.l     #"-TAO",(a1) ; TAO (digi)
		bne.s      musauto19
		move.w     #19,(a2)
		move.w     #8,(a3)
		bra.s      soundplay1

musauto19:
		cmpi.l     #"TOJG",(a1) ; TAO (chip #2)
		bne.s      musauto20
		move.w     #20,(a2)
		move.w     #8,(a3)
		bra.s      soundplay1

musauto20:
		cmpi.l     #"-NEX",(a1) ; Nexus
		bne.s      musauto21
		move.w     #21,(a2)
		move.w     #2,(a3)
		bra.s      soundplay1

musauto21:
		cmpi.l     #"NEXU",(a1) ; Nexus
		bne.s      musauto22
		move.w     #21,(a2)
		move.w     #2,(a3)
		bra.s      soundplay1

musauto22:
		lea.l      2(a1),a1
		dbf        d1,musautoloop
		move.l     #0,-(a6)
		bra        musauto_err

soundplay1:
		lea.l      mus_savearea+8(pc),a1
		move.l     (timerc_vec).w,(a1)
		lea.l      mus_savearea+12(pc),a1
		move.b     (ierb).w,(a1)
		lea.l      mus_savearea+15(pc),a1
		move.b     (tcdcr).w,(a1)
		lea.l      mus_savearea+13(pc),a1
		move.b     (imrb).w,(a1)
		lea.l      mus_savearea+14(pc),a1
		move.b     (vr).w,(a1)
		lea.l      mus_savearea(pc),a1
		move.l     (vbl_vec).w,(a1)

		lea.l      mus_soundtype(pc),a1
		move.w     (a1)+,d2
		move.w     (a1),d1 ; sound offset

		cmp.w      #10,d2 ; LTK?
		bne.s      soundplay2
		subq.w     #1,d0
		lsl.w      #2,d0
		addi.w     #0xFF00,d0
		move.w     d0,(a0)
		bra.s      soundplay8
soundplay2:
		cmpi.w     #12,d2 ; Synth Dream?
		bne.s      soundplay3
		subq.w     #1,d0
		bra.s      soundplay7
soundplay3:
		cmp.w      #14,d2 ; Ben Daglish?
		bne.s      soundplay4
		subq.w     #1,d0
		bra.s      soundplay7
soundplay4:
		cmp.w      #18,d2 ; Lap (1 scanline)?
		bne.s      soundplay5
		movea.l    a0,a2
		lea.l      350(a2),a0
		lea.l      368(a2),a1
		move.l     a0,10(a1)
		move.l     a1,10(a0)
		lea.l      32(a2),a0
		jsr        (a0)
		lea.l      1774(a2),a0
		jsr        (a2)
		movea.l    a2,a0
		bra.s      soundplay8
soundplay5:
		cmp.w      #19,d2 ; TAO (digi)?
		bne.s      soundplay6
		moveq.l    #1,d0
		bra.s      soundplay7
soundplay6:
		cmp.w      #20,d2 ; TAO (chip #2)
		bne.s      soundplay7
		moveq.l    #0,d0
soundplay7:
		movem.l    d0-d7/a0-a6,-(a7)
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
soundplay8:
		add.l      d1,a0
		lea.l      mus_addr(pc),a1
		move.l     a0,(a1)
		
		lea.l      playirq(pc),a0
		move.l     a0,(vbl_vec).w
		bra        musauto_end

musstop:
		lea.l      mus_inited(pc),a2
		tst.w      (a2)
		beq        musstop_end
		lea.l      mus_savearea(pc),a1
		move.l     (a1),(vbl_vec).w
		lea.l      mus_inited(pc),a1
		move.w     #0,(a1)
		lea.l      mus_soundtype(pc),a1
		move.w     (a1),d1
		lea.l      mus_addr(pc),a1
		movea.l    (a1),a0

		cmp.w      #12,d1 ; Synth Dream?
		bne.s      soundstop1
		subq.w     #8,a0
		movem.l    d0-d7/a0-a6,-(a7)
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     #255,d0
		/* lea -18(a0),a0 */
		dc.w 0x91fc,0,18 /* XXX */
		movem.l    d0-d7/a0-a6,-(a7)
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		bra.s      soundstop_restore

soundstop1:
		cmp.w      #10,d1 ; LTK?
		bne.s      soundstop2
		move.w     #-1,-2(a0)
		jsr        (a0)
		bra.s      soundstop_restore
soundstop2:
		cmp.w      #11,d1 ; Megatizer?
		bne.s      soundstop3
		subq.w     #4,a0
		jsr        (a0)
		bra.s      soundstop_restore
soundstop3:
		cmp.w      #18,d1 ; Lap (1 scanline)?
		bne.s      soundstop4
		lea.l      mus_addr(pc),a1
		movea.l    (a1),a0
		lea.l      -166(a0),a0
		jsr        (a0)
		bra.s      soundstop_restore
soundstop4:
		cmp.w      #19,d1 ; TAO (digi)?
		bne.s      soundstop5
		moveq.l    #0,d0
		lea.l      mus_addr(pc),a1
		movea.l    (a1),a0
		lea.l      -8(a0),a0
		jsr        (a0)
		bra.s      soundstop_restore
soundstop5:
		cmp.w      #20,d1 ; TAO (chip #2)?
		bne.s      soundstop6
		moveq.l    #1,d0
		lea.l      mus_addr(pc),a1
		movea.l    (a1),a0
		lea.l      -8(a0),a0
		jsr        (a0)
		bra.s      soundstop_restore
soundstop6:
		cmp.w      #21,d1 ; Nexus?
		bne.s      soundstop_restore
		lea.l      mus_addr(pc),a1
		movea.l    (a1),a0
		lea.l      2(a0),a0
		jsr        (a0)

soundstop_restore:
		lea.l      mus_savearea+8(pc),a0
		move.l     (a0),(timerc_vec).w
		lea.l      mus_savearea+12(pc),a0
		move.b     (a0),(ierb).w
		lea.l      mus_savearea+15(pc),a0
		move.b     (a0),(tcdcr).w
		lea.l      mus_savearea+13(pc),a0
		move.b     (a0),(imrb).w
		lea.l      mus_savearea+14(pc),a0
		move.b     (a0),(vr).w

		move.l     #0x08000000,PSG ; turn all voices off
		move.l     #0x09000000,PSG
		move.l     #0x0A000000,PSG
		bra.s      musstop_end

playirq:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    mus_addr(pc),a0
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     mus_savearea(pc),-(a7) ; jump to orignal VBL handler
		rts

musstop_end:
musauto_end:
		move.l     (a7)+,a6
		lea.l      mus_soundtype(pc),a0
		moveq.l    #0,d0
		move.w     (a0),d0
		move.l     d0,-(a6)
musauto_err:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

mus_inited: dc.w 0
mus_soundtype: dc.w 0
mus_soundoffset: ds.w 1

mus_savearea:
	ds.l 1 ; vbl
mus_addr: ds.l 1
	ds.l 1 ; timerc
	ds.b 1 ; ierb
	ds.b 1 ; imrb
	ds.b 1 ; vr
	ds.b 1 ; tcdcr

; -----------------------------------------------------------------------------

/*
 * Syntax: MUSPLAY adr,num,offset
 */
lib11:
	dc.w	0			; no library calls
musplay:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     a6,-(a7)
		tst.w      d0
		beq.s      musplay2
		lea.l      vbl_saved_flag(pc),a1
		move.w     (a1),d2
		tst.w      d2
		bne.s      musplay1
		move.w     #1,(a1)
		lea.l      save_vbl(pc),a1
		move.l     (vbl_vec).w,(a1)
musplay1:
		movem.l    d0-d7/a0-a6,-(a7)
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		adda.l     d1,a0
		lea.l      musplay_addr(pc),a1
		move.l     a0,(a1)
		lea.l      musplay_intr(pc),a0
		move.l     a0,(vbl_vec).w
		bra.s      musplay_end
musplay2:
		lea.l      vbl_saved_flag(pc),a2
		tst.w      (a2)
		beq.s      musplay_end
		lea.l      save_vbl(pc),a1
		move.l     (a1),vbl_vec
		lea.l      vbl_saved_flag(pc),a1
		move.w     #0,(a1)
		lea.l      musplay_addr(pc),a1
		movea.l    (a1),a0
		move.l     #0x08000000,PSG ; turn all voices off
		move.l     #0x09000000,PSG
		move.l     #0x0A000000,PSG
		bra.s      musplay_end

musplay_intr:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    musplay_addr(pc),a0
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     save_vbl(pc),-(a7)
		rts

musplay_end:
		move.l     (a7)+,a6
		movem.l    (a7)+,d0-d7/a0-a5
		rts

vbl_saved_flag: ds.w 1
musplay_addr: ds.l 1
save_vbl: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: r = WHICH BLOCK (madr,x,y)
 */
lib12:
	dc.w	0			; no library calls
which_block:
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		bne.s      which_block1
		moveq.l    #7,d5
		bra.s      which_block2
which_block1:
		cmpi.l     #0x02528E54,-4(a0)
		bne.w      which_block3
		moveq.l    #8,d5
which_block2:
		tst.w      d0
		blt.s      which_block4
		tst.w      d1
		blt.s      which_block4
		moveq.l    #0,d4
		move.w     (a0)+,d4
		addq.w     #2,d4
		lsl.w      #3,d4
		cmp.w      d4,d0
		bge.s      which_block4
		lsr.w      #3,d4
		move.w     (a0)+,d6
		lsl.w      #3,d6
		cmp.w      d6,d1
		bge.s      which_block4
		lsr.w      #4,d1
		mulu.w     d4,d1
		andi.w     #-16,d0
		lsr.w      #3,d0
		adda.w     d0,a0
		adda.l     d1,a0
		moveq.l    #0,d3
		move.w     (a0),d3
		lsr.w      d5,d3
		tst.w      d3
		bge.w      which_block3
		move.l     #0x0000FFFF,d3
which_block3:
		move.l     d3,-(a6)
		rts
which_block4:
		move.l     #0x0000FFFF,d3
		bra.s      which_block3

; -----------------------------------------------------------------------------

/*
 * Syntax: RELOCATE padr
 */
lib13:
	dc.w	0			; no library calls
relocate:
		move.l     (a6)+,a0
		movem.l    d0-d7/a0-a5,-(a7)
		cmpi.w     #0x601A,(a0) ; GEMDOS magic
		beq.s      relocate1
		bra.s      relocate5
relocate1:
		move.l     a0,d2
		addi.l     #28,d2
		lea.l      28(a0),a1
		movea.l    a1,a2
		adda.l     2(a0),a2 ; skip text segment
; 3 BUGS: in a single instruction:
;  - ignores length of data segment
;  - ignores length of symbol table
;  - does not check for first longword being zero
		adda.l     (a2)+,a1 ; get address of first relocation
		add.l      d2,(a1)
relocate2:
		tst.b      (a2)
		beq.s      relocate5
		moveq.l    #0,d1
relocate3:
		moveq.l    #0,d0
		move.b     (a2)+,d0
		cmp.b      #1,d0
		bne.s      relocate4
		addi.w     #254,d1
		bra.s      relocate3
relocate4:
		add.w      d0,d1
		adda.w     d1,a1
		add.l      d2,(a1)
		bra.s      relocate2
relocate5:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P LEFT (n)
 */
lib14:
	dc.w	0			; no library calls
p_left:
		move.l     (a6)+,d3
		lea.l      joybuf,a0
		adda.w     d3,a0
		moveq.l    #0,d3
		move.b     (a0),d0
		btst       #2,d0
		beq.s      p_left1
		moveq.l    #-1,d3
p_left1:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: P ON
 */
lib15:
	dc.w	0			; no library calls
p_on:
		cmpi.w     #0x1234,(joysave_flag).w
		beq.s      p_on1
		move.w     #0x1234,(joysave_flag).w
		movem.l    d0-d2/a0-a2,-(a7)
		move.w     #20,-(a7)
		move.w     #4,-(a7) ; IKBD
		move.w     #3,-(a7) ; Bconout
		trap       #13
		addq.l     #6,a7
		move.w     #34,-(a7) ; Kbdvbase
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		/* adda.l     #24,a0 */
		dc.w 0xd1fc,0,24 /* XXX */
		move.l     (a0),saved_joyvec
		lea.l      myjoyvec(pc),a1
		move.l     a1,(a0)
		movem.l    (a7)+,d0-d2/a0-a2
p_on1:
		rts

myjoyvec:
		movem.l    a0-a1,-(a7)
		move.b     1(a0),joybuf
		move.b     2(a0),joybuf+1
		movem.l    (a7)+,a0-a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P JOY (n)
 */
lib16:
	dc.w	0			; no library calls
p_joy:
		move.l     (a6)+,d3
		tst.b      d3
		bne.s      p_joy1
		moveq.l    #0,d3
		move.b     joybuf,d3
		bra.s      p_joy2
p_joy1:
		moveq.l    #0,d3
		move.b     joybuf+1,d3
p_joy2:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: P STOP
 */
lib17:
	dc.w	0			; no library calls
p_stop:
		cmpi.w     #0x1234,(joysave_flag).w
		bne.s      p_stop1
		move.w     #-1,(joysave_flag).w
		move.w     #34,-(a7) ; Kbdvbase
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		/* adda.l     #24,a0 */
		dc.w 0xd1fc,0,24 /* XXX */
		move.l     saved_joyvec,(a0)
; send reset command to IKBD
		move.w     #0x0080,-(a7)
		move.w     #4,-(a7)
		move.w     #3,-(a7)
		trap       #13
		addq.l     #6,a7
		move.w     #1,-(a7)
		move.w     #4,-(a7)
		move.w     #3,-(a7)
		trap       #13
		addq.l     #6,a7
p_stop1:
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P UP (n)
 */
lib18:
	dc.w	0			; no library calls
p_up:
		move.l     (a6)+,d3
		lea.l      joybuf,a0
		adda.w     d3,a0
		moveq.l    #0,d3
		move.b     (a0),d0
		btst       #0,d0
		beq.s      p_up1
		moveq.l    #-1,d3
p_up1:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: SET BLOCK madr,x,y,blk
 */
lib19:
	dc.w	0			; no library calls
set_block:
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		cmpi.l     #0x03031973,(a0)+
		bne.s      set_block1
		lsl.w      #7,d2
		bra.s      set_block2
set_block1:
		cmpi.l     #0x02528E54,-4(a0)
		bne.w      set_block3
		lsl.w      #8,d2
set_block2:
		tst.w      d0
		blt.s      set_block3
		tst.w      d1
		blt.s      set_block3
		moveq.l    #0,d3
		move.w     (a0)+,d3
		addq.w     #2,d3
		lsl.w      #3,d3
		cmp.w      d3,d0
		bge.s      set_block3
		lsr.w      #3,d3
		move.w     (a0)+,d4
		lsl.w      #3,d4
		cmp.w      d4,d1
		bge.s      set_block3
		andi.w     #-16,d0
		lsr.w      #3,d0
		lsr.w      #4,d1
		mulu.w     d1,d3
		adda.w     d0,a0
		adda.l     d3,a0
		move.w     d2,(a0)
set_block3:
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P RIGHT (n)
 */
lib20:
	dc.w	0			; no library calls
p_right:
		move.l     (a6)+,d3
		lea.l      joybuf,a0
		adda.w     d3,a0
		moveq.l    #0,d3
		move.b     (a0),d0
		btst       #3,d0
		beq.s      p_right1
		moveq.l    #-1,d3
p_right1:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: PALSPLIT md,cadr,y,hig,num
 */
lib21:
	dc.w	0			; no library calls
palsplit:
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     (a6)+,d1
		tst.w      d1
		beq        palsplit4
		.IFNE 0 ; missing
		cmpi.w     #2,d2
		bge.s      palsplit1
		moveq.l    #2,d2
		.ENDC
palsplit1:
		lea        palsplit_saveflag(pc),a2
		tst.w      (a2)
		beq.s      palsplit2
		clr.b      tbcr.l /* XXX */
		lea.l      palsplit_patch1(pc),a2
		move.b     d0,2(a2)
		lea.l      palsplit_patch2(pc),a2
		move.b     d2,2(a2)
		lea.l      palsplit_num(pc),a2
		move.w     d3,(a2)
		move.b     #8,tbcr.l /* XXX */
		bra        palsplit_end
palsplit2:
		lea.l      palsplit_patch1(pc),a2
		move.w     d0,2(a2)
		lea.l      palsplit_patch2(pc),a2
		move.w     d2,2(a2)
		lea.l      palsplit_cadr(pc),a2
		move.l     a0,(a2)
		lea.l      palsplit_num(pc),a2
		move.w     d3,(a2)
		lea.l      0xFFFF8240,a0
		lea.l      palsplit_colortab(pc),a1
		lea.l      2(a1),a1
		move.w     #8-1,d0
palsplit3:
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		dbf        d0,palsplit3
		lea.l      palsplit_savearea(pc),a0
		move.b     (iera).w,(a0)+
		move.b     (ierb).w,(a0)+
		move.b     (imra).w,(a0)+
		move.b     (imrb).w,(a0)+
		move.w     #0x2700,sr
		ori.b      #1,(iera).w
		ori.b      #1,(imra).w
		bclr       #3,(vr).w
		clr.b      (tbcr).w
		lea        palsplit_savevbl(pc),a2
		move.l     (vbl_vec).w,(a2)
		lea        palsplit_vbl(pc),a2
		move.l     a2,(vbl_vec).w
; BUG: sr not saved/restored
		move.w     #0x2300,sr
		lea        palsplit_saveflag(pc),a2
		move.w     #1,(a2)
		bra.s      palsplit_end
palsplit4:
		lea        palsplit_saveflag(pc),a2
		tst.w      (a2)
		beq.s      palsplit_end
		move.w     #0x2700,sr
		lea.l      palsplit_savearea(pc),a0
		move.b     (a0)+,(iera).w
		move.b     (a0)+,(ierb).w
		move.b     (a0)+,(imra).w
		move.b     (a0)+,(imrb).w
		move.l     palsplit_savevbl(pc),(vbl_vec).w
; BUG: sr not saved/restored
		move.w     #0x2300,sr
		lea        palsplit_saveflag(pc),a2
		move.w     #0,(a2)

palsplit_end:
		rts

palsplit_vbl:
palsplit_colortab:
		move.l     #0x00000777,(0xFFFF8240).w
		move.l     #0x00000777,(0xFFFF8244).w
		move.l     #0x00000777,(0xFFFF8248).w
		move.l     #0x00000777,(0xFFFF824C).w
		move.l     #0x00000777,(0xFFFF8250).w
		move.l     #0x00000777,(0xFFFF8254).w
		move.l     #0x00000777,(0xFFFF8258).w
		move.l     #0x00333222,(0xFFFF825C).w
		movem.l    a0-a1,-(a7)
		lea.l      palsplit_cadr(pc),a1
		movea.l    (a1),a0
		lea.l      timerb_colortab(pc),a1
		lea.l      2(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		lea.l      palsplit_colorptr(pc),a1
		move.l     a0,(a1)
		lea.l      palsplit_num(pc),a0
		lea.l      palsplit_count(pc),a1
		move.w     (a0),(a1)
		clr.b      (tbcr).w
; BUG timerb_vec not saved/restored
		lea        palsplit_timerb(pc),a0
		move.l     a0,(timerb_vec).w
palsplit_patch1:
		move.b     #0x63,(tbdr).w
		move.b     #8,(tbcr).w
palsplit_patch2:
		move.b     #1,(tbdr).w
		movem.l    (a7)+,a0-a1
		move.l     palsplit_savevbl(pc),-(a7)
		rts

palsplit_timerb:
		movem.l    d0/a0-a2,-(a7)
timerb_colortab:
		move.l     #0x00000777,(0xFFFF8240).w
		move.l     #0x00000777,(0xFFFF8244).w
		move.l     #0x00000777,(0xFFFF8248).w
		move.l     #0x00000777,(0xFFFF824C).w
		move.l     #0x00000777,(0xFFFF8250).w
		move.l     #0x00000777,(0xFFFF8254).w
		move.l     #0x00000777,(0xFFFF8258).w
		move.l     #0x00333222,(0xFFFF825C).w
		lea.l      palsplit_count(pc),a0
		subq.w     #1,(a0)
		bge.s      palsplit_timerb1
		clr.b      (tbcr).w
		bra.s      palsplit_timerb2
palsplit_timerb1:
		lea.l      palsplit_colorptr(pc),a0
		movea.l    (a0),a1
		lea.l      timerb_colortab(pc),a2
		lea.l      2(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     (a1)+,(a2)
		lea.l      8(a2),a2
		move.l     a1,(a0)
palsplit_timerb2:
		movem.l    (a7)+,d0/a0-a2
		rte

palsplit_savearea: ds.b 4
palsplit_savevbl: ds.l 1
palsplit_saveflag: ds.w 1
palsplit_num: ds.w 1
palsplit_count: ds.w 1
palsplit_cadr: ds.l 1
palsplit_colorptr: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P DOWN (n)
 */
lib22:
	dc.w	0			; no library calls
p_down:
		move.l     (a6)+,d3
		lea.l      joybuf,a0
		adda.w     d3,a0
		moveq.l    #0,d3
		move.b     (a0),d0
		btst       #1,d0
		beq.s      p_down1
		moveq.l    #-1,d3
p_down1:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: FLOODPAL colr
 */
lib23:
	dc.w	0			; no library calls
floodpal:
		move.l     (a6)+,d3
		moveq.l    #16-1,d0
		lea.l      floodpal_colortab(pc),a0
floodpal1:
		move.w     d3,(a0)+
		dbf        d0,floodpal1
		lea.l      floodpal_colortab(pc),a0
		move.l     a0,colorptr /* FIXME: use Setpalette */
		rts

floodpal_colortab: ds.w 16

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P FIRE (n)
 */
lib24:
	dc.w	0			; no library calls
p_fire:
		move.l     (a6)+,d3
		lea.l      joybuf,a0
		adda.l     d3,a0
		moveq.l    #0,d3
		move.b     (a0),d0
		btst       #7,d0
		beq.s      p_fire1
		moveq.l    #-1,d3
p_fire1:
		move.l     d3,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: DIGI PLAY md,sadr,sz,freq,lp
 */
lib25:
	dc.w	0			; no library calls
digi_play:
		lea        digiplay_flag(pc),a0
		tst.w      (a0)
		beq.s      digi_play1
		move.w     #0,(a0)
		move.w     sr,-(a7)
		move.w     #0x2700,sr
		move.l     save_timera(pc),(timera_vec).w
		move.b     save_iera(pc),(iera).w
		move.b     save_imra(pc),(imra).w
		move.b     save_vr(pc),(vr).w
		move.b     save_tacr(pc),(tacr).w
		lea        digiplay_loop(pc),a0
		move.w     #0,(a0)
		move.w     (a7)+,sr
digi_play1:
		move.l     (a6)+,d3
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     (a6)+,d2
		tst.w      d2
		beq        digi_play_stop
		subq.w     #1,d1
		cmpi.w     #2,d1
		blt.s      digi_play4
		cmpi.w     #32,d1
		bgt.s      digi_play4
		lea.l      digiplay_loop(pc),a1
		move.w     d3,(a1)
		cmpi.l     #0x0858B8C1,(a0)
		bne.s      digi_play3
		move.w     4(a0),d3
		cmp.w      d3,d0
		ble.s      digi_play2
		move.w     d3,d0
digi_play2:
		lsl.w      #3,d0
		lea.l      6(a0,d0.w),a1
		adda.l     (a1)+,a0
		move.l     (a1),d0
digi_play3:
		lea.l      timera_table(pc),a1
		move.b     0(a1,d1.w),d1
		lea.l      timera_value(pc),a1
		move.b     d1,(a1)
		bsr        digiplay_init
		bsr        install_digiirq
digi_play4:
		rts

install_digiirq:
		lea.l      digiplay_flag(pc),a1
		move.w     #1,(a1)
		move.w     sr,-(a7)
		move.w     #0x2700,sr
		lea        save_iera(pc),a1
		move.b     iera,(a1)+
		move.b     imra,(a1)+
		move.b     vr,(a1)+
		move.b     tacr,(a1)
		lea        save_timera(pc),a1
		move.l     (timera_vec).w,(a1)
		lea        digiplay_irq(pc),a1
		move.l     a1,(timera_vec).w
		move.b     #1,(tacr).w
		move.b     timera_value(pc),(tadr).w
		bset       #5,(iera).w
		bset       #5,(imra).w
		bclr       #3,(vr).w
		rte

digi_play_stop:
		move.w     sr,-(a7)
		lea.l      digiplay_flag(pc),a0
		tst.w      (a0)
		beq.s      digi_play_stop1
		move.w     #0,(a0)
		move.w     #0x2700,sr
		move.l     save_timera(pc),(timera_vec).w
		move.b     save_iera(pc),(iera).w
		move.b     save_imra(pc),(imra).w
		move.b     save_vr(pc),(vr).w
		move.b     save_tacr(pc),(tacr).w
		lea        digiplay_loop(pc),a0
		move.w     #0,(a0)
digi_play_stop1:
		rte

save_timera: ds.l 1

digiplay_init:
		lea        digiplay_length2(pc),a1
		move.l     d0,(a1)
		lea        digiplay_addr2(pc),a1
		move.l     a0,(a1)
		lea        digiplay_length(pc),a1
		move.l     d0,(a1)
		lea        digiplay_addr(pc),a1
		move.l     a0,(a1)
		move.b     #11-1,d1 /* BUG: should be move.w */
		moveq.l    #0,d0
		movea.w    #PSG,a0
digiplay_init1:
		move.b     d1,(a0)
		move.b     d0,2(a0)
		dbf        d1,digiplay_init1
		move.b     #7,(a0)
		move.b     #-1,2(a0)
		rts

digiplay_irq:
		movem.l    d0-d1/a0-a1,-(a7)
		moveq.l    #0,d0
		lea        digiplay_length(pc),a0
		subq.l     #1,(a0)
		movea.l    digiplay_addr(pc),a0
		bne.s      digiplay_irq2
		lea.l      digiplay_loop(pc),a1
		tst.w      (a1)
		bne.s      digiplay_irq1
		bsr        digi_play_stop
digiplay_irq1:
		movea.l    digiplay_addr2(pc),a0
		lea.l      digiplay_length(pc),a1
		move.l     digiplay_length2(pc),(a1)
digiplay_irq2:
		move.b     (a0)+,d0
		lea        digiplay_addr(pc),a1
		move.l     a0,(a1)
		lsl.w      #3,d0
		movem.l    voldat(pc,d0.w),d0-d1
		movea.w    #PSG,a0
		movep.l    d0,0(a0)
		move.l     d1,(a0)
		movem.l    (a7)+,d0-d1/a0-a1
		rte

digiplay_addr: ds.l 1
digiplay_length: ds.l 1
digiplay_addr2: ds.l 1
digiplay_length2: ds.l 1 ; backup for loop

digiplay_loop: ds.w 1
      ds.w 1
timera_value: dc.b 61,0

voldat:
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x08,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x09,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x09,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x08,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x07,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0a,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0a,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x06,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x05,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x05,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x09,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x04,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0a,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0a,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0a,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0a,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x09,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x09,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0a,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0b,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0a,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x07,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x08,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x07,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x09,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x06,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x07,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0a,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0a,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x0a,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x09,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x08,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x09,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x01,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x08,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x0a,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x08,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x08,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x09,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0b,0x09,0x07,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x09,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x09,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x08,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x09,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x09,0x09,0x08,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x08,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0a,0x09,0x08,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x09,0x09,0x08,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x08,0x09,0x08,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x09,0x09,0x08,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x09,0x09,0x09,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x09,0x09,0x07,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x08,0x09,0x08,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x09,0x09,0x07,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x09,0x09,0x08,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x08,0x09,0x08,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x09,0x09,0x06,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x08,0x09,0x07,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x08,0x09,0x08,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x08,0x09,0x07,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x08,0x09,0x08,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x07,0x09,0x07,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x08,0x09,0x06,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x08,0x09,0x07,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x07,0x09,0x07,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x08,0x09,0x06,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x08,0x09,0x06,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x07,0x09,0x06,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x07,0x09,0x07,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x08,0x09,0x05,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x06,0x09,0x06,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x07,0x09,0x06,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x07,0x09,0x05,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x06,0x09,0x06,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x06,0x09,0x06,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x06,0x09,0x05,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x06,0x09,0x06,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x06,0x09,0x05,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x05,0x09,0x05,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x06,0x09,0x05,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x05,0x09,0x05,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x05,0x09,0x04,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x05,0x09,0x05,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x04,0x09,0x04,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x04,0x09,0x04,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x04,0x09,0x04,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x04,0x09,0x03,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x03,0x09,0x03,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x03,0x09,0x03,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x03,0x09,0x02,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x02,0x09,0x02,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x02,0x09,0x02,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x01,0x09,0x01,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x02,0x09,0x01,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x01,0x09,0x01,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x01,0x09,0x00,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x00,0x09,0x00,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0c,0x00,0x00
		dc.b 0x08,0x0f,0x09,0x03,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0f,0x09,0x03,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0f,0x09,0x03,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0f,0x09,0x03,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0f,0x09,0x03,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0f,0x09,0x03,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0c,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0d,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0d,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0d,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0d,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0d,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0d,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0d,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0c,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0c,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0c,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x0c,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0b,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0a,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0d,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x0a,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x09,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x09,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x09,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x08,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x09,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x0c,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x08,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x07,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x08,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x07,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x06,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x05,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x04,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0e,0x09,0x00,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0c,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0a,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0a,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0a,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x09,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x0b,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0b,0x0a,0x00,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x07,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x06,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x03,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0c,0x0a,0x01,0x00,0x00
		dc.b 0x08,0x0c,0x09,0x0b,0x0a,0x0a,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0a,0x0a,0x05,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0a,0x0a,0x04,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x0a,0x0a,0x02,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0x08,0x0d,0x09,0x09,0x0a,0x08,0x00,0x00
		dc.b 0,0,0,0

timera_table:
		dc.b 0,0,204,153,122,102,87,76,68,61,55,51
		dc.b 47,43,40,38,36,34,32,30,29,27,26,25
		dc.b 24,23,22,21,21,20,19,18,18,17,17,16
		dc.b 16,15,15,14,14,14,13,13,13,13,12,12
		dc.b 12,0

digiplay_flag: ds.w 1
save_iera: ds.b 1
save_imra: ds.b 1
save_vr: ds.b 1
save_tacr: ds.b 1

; -----------------------------------------------------------------------------

/*
 * Syntax: tadr = STRING (num)
 */
lib26:
	dc.w	0			; no library calls
FN_string:
		move.l     (a6),d3
		lea.l      stringbuf+14(pc),a0
		tst.l      d3
		bgt.s      string1 ; BUG: should be bne, or handle negative values
		move.b     #'0',-(a0)
		bra.s      string2
string1:
		tst.w      d3
		beq.s      string2
		divu.w     #10,d3
		swap       d3
		addi.w     #'0',d3
		move.b     d3,-(a0)
		move.w     #ZERO,d3
		swap       d3
		bra.s      string1
string2:
		move.l     a0,(a6)
		rts

stringbuf: dc.b "               ",0
		rts ; FIXME

; -----------------------------------------------------------------------------

/*
 * Syntax: SAMSIGN sadr,sz
 */
lib27:
	dc.w	0			; no library calls
samsign:
		move.l     (a6)+,d0
		move.l     (a6)+,a0
samsign1:
		addi.b     #0x80,(a0)+
		subq.w     #1,d0 ; BUG: should be .l
		bne.s      samsign1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: l = DEPACK (adr)
 */
lib28:
	dc.w	0			; no library calls
depack:
		move.l     (a6)+,a0
		cmpi.l     #PACK_ICE2,(a0)
		beq.s      depack1
		cmpi.l     #PACK_FIRE,(a0)
		beq.s      depack2
		cmpi.l     #PACK_ATOMIC,(a0)
		beq.s      depack4
		cmpi.l     #PACK_AUTOMATION,(a0)
		beq.s      depack3
		cmpi.l     #PACK_SPEED2,(a0)
		beq.s      depack5
		cmpi.l     #PACK_SPEED3,(a0)
		beq.s      depack6
		clr.l      -(a7) ; return value
		bra.s      depack_end
depack1:
		move.l     8(a0),-(a7)
		bsr        ice2
		bra.s      depack_end
depack2:
		move.l     8(a0),-(a7)
		bsr        fire_decrunch
		bra.s      depack_end
depack3:
		move.l     8(a0),-(a7)
		bsr        AU5_decrunch
		bra.s      depack_end
depack4:
		move.l     4(a0),-(a7)
		bsr.s      atomik
		bra.s      depack_end
depack5:
		move.l     12(a0),-(a7)
		bsr        speed2_depack
		bra.s      depack_end
depack6:
		move.l     12(a0),-(a7)
		bsr        speed3_depack
depack_end:
		move.l     (a7)+,d0 ; return value
		move.l     d0,-(a6)
		rts

		include "atomik.s"
		include "ice2.s"
		include "fire.s"
		include "atm_5_01.s"
		include "speed2.s"
		include "speed3.s"

; -----------------------------------------------------------------------------

/*
 * Syntax: REPLACE BLOCKS madr,blk1,blk2
 */
lib29:
	dc.w	0			; no library calls
replace_blocks:
		move.l     (a6)+,d1
		move.l     (a6)+,d0
		move.l     (a6)+,a0
		move.l     a1,-(a7)
		cmpi.l     #0x03031973,(a0)+
		bne.s      replace_blocks1
		moveq.l    #7,d4
		bra.s      replace_blocks2
replace_blocks1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        replace_blocks5
		moveq.l    #8,d4
replace_blocks2:
		movem.w    (a0)+,d2-d3
		addq.w     #2,d2
		lsr.w      #1,d2
		lsr.w      #1,d3
		mulu.w     d3,d2
		subq.w     #1,d2
		lsl.w      d4,d0
		lsl.w      d4,d1
replace_blocks3:
		move.w     (a0)+,d3
		cmp.w      d3,d0
		bne.s      replace_blocks4
		move.w     d1,-2(a0)
replace_blocks4:
		dbf        d2,replace_blocks3
replace_blocks5:
		movea.l    (a7)+,a1
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: l = DLOAD (filename,adr,ofs,num)
 */
lib30:
	dc.w	0			; no library calls
dload:
		move.l     (a6)+,d4 ; d4=num
		move.l     (a6)+,d3 ; d3=ofs
		move.l     (a6)+,a4 ; a4=adr
		move.l     a3,-(a7)
		movea.l    (a6)+,a3 ; a3=filename
		moveq.l    #0,d6
		clr.w      -(a7)
		move.l     a3,-(a7)
		move.w     #61,-(a7) ; Fopen
		trap       #1
		addq.l     #8,a7
		move.w     d0,d7
		move.w     d0,d6 ; BUG: should be move.l
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.s      dload2
		clr.w      -(a7)
		move.w     d7,-(a7)
		move.l     d3,-(a7)
		move.w     #66,-(a7) ; Fseek
		trap       #1
		lea.l      10(a7),a7
		move.w     d0,d6 ; BUG: should be move.l
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.s      dload1
		move.l     a4,-(a7)
		move.l     d4,-(a7)
		move.w     d7,-(a7)
		move.w     #63,-(a7) ; Fread
		trap       #1
		lea.l      12(a7),a7
		move.w     d0,d6 ; BUG: should be move.l
dload1:
		move.w     d7,-(a7)
		move.w     #62,-(a7) ; Fclose
		trap       #1
		addq.l     #4,a7
dload2:
		movea.l    (a7)+,a3
		move.l     d6,-(a6)
		rts

; -----------------------------------------------------------------------------

/*
 * Syntax: DISPLAY PC1 gadr,scr
 */
lib31:
	dc.w	0			; no library calls
display_pc1:
		movem.l    a0-a5,-(a7)
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		lea.l      2(a0),a3
		move.l     a3,(colorptr).w /* FIXME: use Setpalette */
		movea.l    a1,a3
		lea.l      34(a0),a0
		move.w     #200-1,d4
display_pc1_1:
		moveq.l    #3,d3
display_pc1_2:
		lea.l      degas_line(pc),a1
		bsr.s      depack_pc1
		bsr.s      degas_copyline
		addq.w     #2,a3
		dbf        d3,display_pc1_2
		lea.l      152(a3),a3
		dbf        d4,display_pc1_1
		movem.l    (a7)+,a0-a5
		rts

depack_pc1:
		movem.l    d1/a1-a2,-(a7)
		movea.l    a1,a2
		lea.l      40(a2),a2
depack_pc1_1:
		moveq.l    #0,d1
		move.b     (a0)+,d1
		bmi.s      depack_pc1_3
depack_pc1_2:
		move.b     (a0)+,(a1)+
		dbf        d1,depack_pc1_2
		cmpa.l     a2,a1
		blt.s      depack_pc1_1
		bra.s      depack_pc1_5
depack_pc1_3:
		neg.b      d1
		move.b     (a0)+,d0
depack_pc1_4:
		move.b     d0,(a1)+
		dbf        d1,depack_pc1_4
		cmpa.l     a2,a1
		blt.s      depack_pc1_1
depack_pc1_5:
		movem.l    (a7)+,d1/a1-a2
		rts

degas_copyline:
		movem.l    d0/a0-a3,-(a7)
		lea.l      degas_line(pc),a0
		moveq.l    #20-1,d0
degas_copyline1:
		move.w     (a0)+,(a3)+
		addq.w     #6,a3
		dbf        d0,degas_copyline1
		movem.l    (a7)+,d0/a0-a3
		rts

degas_line: ds.w 20

; -----------------------------------------------------------------------------

/*
 * Syntax: l = DSAVE (filename,adr,ofs,num)
 */
lib32:
	dc.w	0			; no library calls
dsave:
		move.l     (a6)+,d4 ; d4=num
		move.l     (a6)+,d3 ; d3=ofs
		move.l     (a6)+,a4 ; a4=adr
		move.l     a3,-(a7)
		move.l     (a6)+,a3 ; a3=filename
		move.w     #47,-(a7) ; Fgetdta
		trap       #1
		addq.l     #2,a7
		lea.l      dsave_dtaptr(pc),a0
		move.l     d0,(a0)
		pea.l      dsave_dta(pc)
		move.w     #26,-(a7) ; Fsetdta
		trap       #1
		addq.l     #6,a7
		move.w     #-1,-(a7)
		move.l     a3,-(a7)
		move.w     #78,-(a7) ; Fsfirst
		trap       #1
		addq.l     #8,a7
		moveq.l    #0,d6
		tst.w      d0
		beq.s      dsave1
		clr.w      -(a7)
		move.l     a3,-(a7)
		move.w     #60,-(a7) ; Fcreate
		trap       #1
		addq.l     #8,a7
		bra.s      dsave2
dsave1:
		clr.w      -(a7)
		move.l     a3,-(a7)
		move.w     #61,-(a7) ; Fopen
		trap       #1
		addq.l     #8,a7
dsave2:
		move.w     d0,d7
		move.w     d0,d6 ; BUG: should be move.l
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.s      dsave4
		clr.w      -(a7)
		move.w     d7,-(a7)
		move.l     d3,-(a7)
		move.w     #66,-(a7) ; Fseek
		trap       #1
		lea.l      10(a7),a7
		move.w     d0,d6 ; BUG: should be move.l
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.s      dsave3
		move.l     a4,-(a7)
		move.l     d4,-(a7)
		move.w     d7,-(a7)
		move.w     #64,-(a7) ; Fwrite
		trap       #1
		lea.l      12(a7),a7
		move.w     d0,d6 ; BUG: should be move.l
dsave3:
		move.w     d7,-(a7)
		move.w     #62,-(a7) ; Fclose
		trap       #1
		addq.l     #4,a7
dsave4:
		lea.l      dsave_dtaptr(pc),a0
		move.l     (a0),-(a7)
		move.w     #26,-(a7) ; Fsetdta
		trap       #1
		addq.l     #6,a7
		move.l     d6,-(a6)
		movea.l    (a7)+,a3
		rts

dsave_dtaptr: ds.l 1
dsave_dta: ds.b 46

libex:
	dc.w 0

ZERO = 0
