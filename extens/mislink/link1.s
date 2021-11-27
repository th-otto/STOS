		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"

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

saved_joyvec = $0418 ; WTF
joybuf       = $041c ; WTF
colorptr     = $045a
conterm      = $0484

PACK_ICE2       = 0x49434521 /* "ICE!" */
PACK_ATOMIC     = 0x41544D35 /* "ATM5" */
PACK_FIRE       = 0x46495245 /* "FIRE" */
PACK_AUTOMATION = 0x41553521 /* "AU5!" */
PACK_SPEED2     = 0x53503230 /* "SP20" */
PACK_SPEED3     = 0x53507633 /* "SPv3" */

		.text

		bra.w        load

        dc.b $80
tokens:
        dc.b "landscape",$80
        dc.b "overlap",$81
        dc.b "bob",$82
        dc.b "map toggle",$83
        dc.b "wipe",$84
        dc.b "boundary",$85
        dc.b "tile",$86
        dc.b "palt",$87
        dc.b "world",$88
        dc.b "musauto",$89
        dc.b "musplay",$8a
        dc.b "which block",$8b
        dc.b "relocate",$8c
        dc.b "p left",$8d
        dc.b "p on",$8e
        dc.b "p joy",$8f
        dc.b "p stop",$90
        dc.b "p up",$91
        dc.b "set block",$92
        dc.b "p right",$93
        dc.b "palsplit",$94
        dc.b "p down",$95
        dc.b "floodpal",$96
        dc.b "p fire",$97
        dc.b "digi play",$98
        dc.b "string",$99
        dc.b "samsign",$9a
        dc.b "depack",$9b
        dc.b "replace blocks",$9c
        dc.b "dload",$9d
        dc.b "display pc1",$9e
        dc.b "dsave",$9f
        dc.b "honesty",$a0

        dc.b 0
        even

jumps: dc.w 33

		dc.l landscape
		dc.l overlap
		dc.l bob
		dc.l map_toggle
		dc.l wipe
		dc.l boundary
		dc.l tile
		dc.l palt
		dc.l world
		dc.l musauto
		dc.l musplay
		dc.l which_block
		dc.l relocate
		dc.l p_left
		dc.l p_on
		dc.l p_joy
		dc.l p_stop
		dc.l p_up
		dc.l set_block
		dc.l p_right
		dc.l palsplit
		dc.l p_down
		dc.l floodpal
		dc.l p_fire
		dc.l digi_play
		dc.l FN_string
		dc.l samsign
		dc.l depack
		dc.l replace_blocks
		dc.l dload
		dc.l display_pc1
		dc.l dsave
		dc.l honesty

; welcome messages: English, French
welcome:
		dc.b 10,13,"The Missing Link",10,13,"(c) 1993 Top Notch Software.",10,13,"* fixes by dml/2016.",10,13,10,13,0
		dc.b 10,13,"The Missing Link",10,13,"(c) 1993 Top Notch Software.",10,13,"* fixes by dml/2016.",10,13,10,13,0
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
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #2,-(a7) ; Physbase
		trap       #14
		addq.w     #2,a7
		movea.l    d0,a1
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #4,-(a7) ; Getrez
		trap       #14
		addq.w     #2,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d2
		/* adda.l     #(168*160+16*8),a1 */
		dc.w 0xd3fc,0,(168*160+16*8) /* XXX */
		movea.l    a1,a2
		suba.l     #32768,a2
		lea.l      logo(pc),a0
		move.w     #27-1,d0
		cmpi.w     #2,d2 ; High-Res?
		beq.w      cold3
		cmpi.w     #1,d2 ; Med-Res?
		beq.w      cold2
; else hopefully low-res
cold1:
		move.w     (a0),(a1)
		move.w     2(a0),8(a1)
		move.w     4(a0),16(a1)
		move.w     6(a0),24(a1)
		lea.l      160(a1),a1
		move.w     (a0)+,(a2)
		move.w     (a0)+,8(a2)
		move.w     (a0)+,16(a2)
		move.w     (a0)+,24(a2)
		lea.l      160(a2),a2
		dbf        d0,cold1
		bra.s      cold4
cold2:
		move.w     (a0),(a1)
		move.w     2(a0),4(a1)
		move.w     4(a0),8(a1)
		move.w     6(a0),12(a1)
		lea.l      160(a1),a1
		move.w     (a0)+,(a2)
		move.w     (a0)+,4(a2)
		move.w     (a0)+,8(a2)
		move.w     (a0)+,12(a2)
		lea.l      160(a2),a2
		dbf        d0,cold2
		bra.s      cold4
cold3:
		move.w     (a0),(a1)
		move.w     2(a0),2(a1)
		move.w     4(a0),4(a1)
		move.w     6(a0),6(a1)
		lea.l      80(a1),a1
		move.w     (a0)+,(a2)
		move.w     (a0)+,2(a2)
		move.w     (a0)+,4(a2)
		move.w     (a0)+,6(a2)
		lea.l      80(a2),a2
		dbf        d0,cold3
cold4:
		move.w     #0x04D2,0x00000380.l ; invalidate crash page
		move.w     #10000,d0
		moveq.l    #1,d1
		move.w     (0xFFFF8240).w,d3
cold5:
		move.w     #0x0707,(0xFFFF8240).w
		lsl.w      d1,d2
		move.w     #0x0077,(0xFFFF8240).w
		lsl.w      d1,d2
		addq.w     #1,d1
		dbf        d0,cold5
		move.w     d3,(0xFFFF8240).w
		movem.l    (a7)+,d0-d7/a0-a6
		rts

;	warm start (response to UNDO keyword)
warm:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      x104f2(pc),a0
		tst.w      (a0)
		bne        warm1
		move.w     #-1,(a0)
		movem.l    d7/a0,-(a7)
		/* moveq.l     #2,d0 */
		dc.w 0x203c,0,2 /* XXX */
		moveq.l    #W_setpen,d7
		trap       #3
		movem.l    (a7)+,d7/a0
		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0
		movem.l    d7/a0,-(a7)
		movea.l    #mlmsg1,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0
		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0
		movem.l    d7/a0,-(a7)
		movea.l    #mlmsg2,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0
		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0
		movem.l    d7/a0,-(a7)
		/* moveq.l     #1,d0 */
		dc.w 0x203c,0,1 /* XXX */
		moveq.l    #W_setpen,d7
		trap       #3
		movem.l    (a7)+,d7/a0
warm1:
		lea.l      vbl_saved_flag(pc),a2
		tst.w      (a2)
		beq.w      warm2
		lea.l      save_vbl(pc),a1
		move.l     (a1),vbl_vec.l /* XXX */
		lea.l      vbl_saved_flag(pc),a1
		move.w     #0,(a1)
		lea.l      musplay_addr(pc),a1
		movea.l    (a1),a0
		move.l     #0x08000000,PSG.l ; turn all voices off
		move.l     #0x09000000,PSG.l
		move.l     #0x0A000000,PSG.l
warm2:
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		lea.l      goback(pc),a0
		move.l     a0,returnpc
		bra        musstop

goback:
		movem.l    (a7)+,d0-d7/a0-a6
		rts


x10422:
		lea.l      digiplay_flag(pc),a0
		tst.w      (a0)
		beq.s      x10422_1
		move.w     #0,(a0)
		move.w     sr,-(a7)
		move.w     #0x2700,sr
		move.l     save_timera,(timera_vec).w
		move.b     save_iera,(iera).w
		move.b     save_imra,(imra).w
		move.b     save_vr,(vr).w
		move.b     save_tacr,(tacr).w
		move.w     #0,digiplay_loop
		move.w     (a7)+,sr
x10422_1:
		tst.w      palsplit_saveflag
		beq.s      x10422_2
		move.w     #0x2700,sr
		lea.l      palsplit_savearea,a0
		move.b     (a0)+,(iera).w
		move.b     (a0)+,(ierb).w
		move.b     (a0)+,(imra).w
		move.b     (a0)+,(imrb).w
		move.l     palsplit_savevbl,(vbl_vec).w
		move.w     #0x2300,sr
		move.w     #0,palsplit_saveflag
x10422_2:
		lea.l      joysave_flag(pc),a0
		tst.w      (a0)
		beq.s      x10422_3
		move.w     #0,(a0)
		move.w     #34,-(a7) ; Kbdvbase
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		/* adda.l     #24,a0 */
		dc.w 0xd1fc,0,24 /* XXX */
		move.l     saved_joyvec.l,(a0) /* XXX */
; send reset command to IKBD
		move.w     #0x80,-(a7)
		move.w     #4,-(a7) ; IKBD
		move.w     #3,-(a7) ; Bconout
		trap       #13
		addq.l     #6,a7
		move.w     #1,-(a7)
		move.w     #4,-(a7) ; IKBD
		move.w     #3,-(a7) ; Bconout
		trap       #13
		addq.l     #6,a7
x10422_3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

getinteger:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne.s      typemismatch
		jmp        (a0)

x104f0: ds.w 1 /* unused */
x104f2: ds.w 1

crnl: dc.b 10,13,0
mlmsg1: dc.b "type 'honesty' for registration details",0
mlmsg2: dc.b "for Missing Link",0
	.even


syntax:
		moveq      #E_syntax,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0
		bra.s      goerror
illfunc: /* unused */
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror
noerror:
		moveq.l    #E_none,d0
		bra.w      goerror
goerror:
		movea.l    table(pc),a0
		movea.l    sys_error(a0),a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: LANDSCAPE x1,y1,x2,y2,0,1
 *         LANDSCAPE scr,gadr,madr,x,y,0
 */
landscape:
		move.l     (a7)+,returnpc
		cmp.w      #6,d0
		bne.s      syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr.w      getinteger
		move.l     d3,args+20
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		movea.l    args+0(pc),a0
		movea.l    args+4(pc),a2
		movea.l    args+8(pc),a1
		movem.l    args+12(pc),d6-d7
		move.l     args+20(pc),d0
		moveq.l    #0,d1
		move.l     d1,d2
		move.l     d1,d3
		move.l     d1,d4
		move.l     d1,d5
		movea.l    d1,a3
		movea.l    d1,a4
		movea.l    d1,a5
		movea.l    d1,a6
		tst.w      d0
		bne        landscape_init
		cmpi.l     #0x03031973,(a1)+
		bne        noerror
		cmpi.l     #0x18E7074C,(a2)+
		bne        noerror
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
		tst.w      d6
		bge.s      landscape3
		moveq.l    #0,d6
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
		moveq      #0,d4		; dml	
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
		lea        landscape_loop2(pc,d7.w),a3	; dml
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
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

landscape_init:
		movem.l    args+0(pc),d0-d3 ; x1,y1,x2,y2
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
		lea.l      landscape_width,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)
landscape_end:
		lea.l      saveregs(pc),a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

landscape_screenoffset: ds.w 1 ; BUG: should be long
landscape_width: ds.w 1 ; in words
landscape_height: ds.w 1 ; in words
landscape_mapx: ds.w 1

; -----------------------------------------------------------------------------

/*
 * Syntax: r = OVERLAP (x1,y1,x2,y2,wd1,hg1,wd2,hg2)
 */
overlap:
		move.l     (a7)+,returnpc
		cmpi.w     #8,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,args+28
		bsr        getinteger
		move.l     d3,args+24
		bsr        getinteger
		move.l     d3,args+20
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		movem.l    d5-d7,-(a7)
		movem.l    args+0(pc),d0-d7
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
		moveq.l    #-1,d3
		moveq.l    #0,d2
		movem.l    (a7)+,d5-d7
		movea.l    returnpc,a0
		jmp        (a0)
overlap1:
		moveq.l    #0,d3
		moveq.l    #0,d2
		movem.l    (a7)+,d5-d6 ; BUG
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: BOB x1,y1,x2,y2,0,1
 *         BOB scr,gadr,img,x,y,0
 */
bob:
		move.l     (a7)+,returnpc
		cmp.w      #6,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,args+20
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		move.l     args+20(pc),d6
		cmpi.w     #1,d6
		beq        bob_init
		movem.l    args+0(pc),a0-a1
		movem.l    args+8(pc),d0-d2
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
		bne        noerror
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
		bra.s      bob2
bob1:
		subi.w     #16,d4
bob2:
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
		bpl.s      bob6
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
		move.w     #-16,d6
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
		lea.l      bob_jtable(pc),a2
		adda.w     0(a2,d4.w),a2
		jmp        (a2)

bob_jtable:
	dc.w bob31-bob_jtable
	dc.w bob28-bob_jtable
	dc.w bob24-bob_jtable
	dc.w bob17-bob_jtable
	dc.w bob9-bob_jtable

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
		lea        bob34(pc,d6.w),a4	; dml
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
		movem.l    args+0(pc),d0-d3 ; x1,y1,x2,y2
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		bge.w      bob_init1
		moveq.l    #0,d0
bob_init1:
		cmpi.w     #SCREEN_WIDTH,d2 ; FIXME screensize
		ble.w      bob_init2
		move.w     #SCREEN_WIDTH,d2
bob_init2:
		/* tst.w      d1 */
		dc.w 0x0c41,0 /* XXX */
		bge.w      bob_init3
		moveq.l    #0,d1
bob_init3:
		cmpi.w     #SCREEN_HEIGHT,d3
		ble.w      bob_init4
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
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: n = MAP TOGGLE(madr)
 */
map_toggle:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		movea.l    d3,a0
		cmpi.l     #0x03031973,(a0)
		bne.s      map_toggle1
		moveq.l    #7,d4
		moveq.l    #8,d5
		move.l     #0x02528E54,(a0)+
		bra.s      map_toggle2
map_toggle1:
		cmpi.l     #0x02528E54,(a0)
		bne        noerror
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
		moveq.l    #0,d2
		moveq.l    #0,d3
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: WIPE scr
 */
wipe:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		movea.l    d3,a6
		lea.l      32000(a6),a6
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
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: r = BOUNDARY (n)
 */
boundary:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		andi.w     #-16,d3
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: TILE scr,gadr,img,x,y
 */
tile:
		move.l     (a7)+,returnpc
		cmp.w      #5,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		movem.l    args+0(pc),a0-a1
		movem.l    args+8(pc),d0-d2
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
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: r = PALT (gadr)
 */
palt:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		movea.l    d3,a0
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
		bra        noerror
palt5:
		move.l     #(256000/2)-1,d0 ; WTF?
		moveq.l    #4,d1
palt6:
		cmpi.l     #0x50414C54,(a0) ; 'PALT'
		beq.s      palt7
		lea.l      2(a0),a0
		dbf        d0,palt6
		bra        noerror
palt7:
		adda.l     d1,a0
		move.l     a0,colorptr.l /* XXX */ /* FIXME: use Setpalette */
		move.l     a0,d3
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: WORLD x1,y1,x2,y2,0,1
 *         WORLD scr,gadr,madr,x,y,0
 */
world:
		move.l     (a7)+,returnpc
		cmpi.w     #6,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,args+20
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		movem.l    args+0(pc),a0-a2
		movem.l    args+12(pc),d2-d3
		move.l     args+20(pc),d7
		moveq.l    #0,d0
		move.l     d0,d1
		move.l     d0,d4
		move.l     d0,d5
		move.l     d0,d6
		movea.l    d0,a3
		movea.l    d0,a4
		movea.l    d0,a5
		movea.l    d0,a6
		tst.w      d7
		bne        world_init
		cmpi.l     #0x07793868,(a1)+
		bne        noerror
		cmpi.l     #0x02528E54,(a2)+
		bne        noerror
		tst.w      d2
		bge.s      world1
		moveq.l    #0,d2
world1:
		tst.w      d3
		bge.s      world2
		moveq.l    #0,d3
world2:
		movem.w    (a2)+,d0-d1
		move.w     d0,x12004
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
		move.w     d3,x12006
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
		lea.l      lineoffset_table(pc),a5
		adda.w     d4,a5
		move.w     #2400,d6
		sub.w      (a5),d6
		lea        world8(pc,d7.w),a4		; dml

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
		suba.w     d6,a0
		lea.l      8(a0),a0
		dbf        d0,world7
		subq.w     #1,d1
		movea.l    (a7)+,a2
		addq.w     #2,a2
		movea.l    (a7)+,a0
		lea.l      160(a0),a0
		adda.w     d6,a0
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
		lea.l      2(a2),a2
		dbf        d0,world10
		addq.w     #2,a7
		movea.l    (a7)+,a0
		movem.w    world_width(pc),d0-d1
		suba.w     d0,a2
		suba.w     d0,a2
		subq.w     #2,a2
		moveq.l    #0,d7
		move.w     x12004(pc),d7
		addq.w     #2,d7
		mulu.w     d1,d7
		adda.w     d7,a2
		lsl.w      #5,d1
		lea.l      lineoffset_table(pc),a5
		adda.w     d1,a5
		adda.w     (a5),a0
world12:
		move.w     x12006(pc),d1
		tst.w      d1
		beq        landscape_end ; WTF
		moveq.l    #15,d7
		sub.w      d1,d7
		lsl.w      #4,d7
		lea        world14(pc,d7.w),a4		; dml

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
		bra        landscape_end ; WTF

world_init:
		movem.l    args+0(pc),d0-d3 ; x1,y1,x2,y2
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
		add.w      d1,d1
		lea.l      lineoffset_table(pc),a0
		adda.w     d1,a0
		add.w      (a0),d0
		lea.l      world_screenoffset(pc),a0
		move.w     d0,(a0)
		move.w     d2,d0
		move.w     d3,d1
		subq.w     #1,d0
		subq.w     #1,d1
		tst.w      d0
		bge.s      world_init5
		moveq.l    #0,d0
world_init5:
		tst.w      d1
		bge.s      world_init6
		moveq.l    #0,d1
world_init6:
		cmpi.w     #19,d0
		ble.s      world_init7
		moveq.l    #19,d0
world_init7:
		cmpi.w     #11,d1
		ble.s      world_init8
		moveq.l    #11,d1
world_init8:
		lea.l      world_width,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)
		lea.l      saveregs(pc),a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

world_width: dc.w 19
world_height: dc.w 11
x12004: ds.w 1
x12006: ds.w 1
world_screenoffset: ds.w 1

; -----------------------------------------------------------------------------

/*
 * Syntax: r = MUSAUTO (adr,num,size)
 */
musauto:
		move.l     (a7)+,returnpc
		cmpi.w     #3,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,d1
		bsr        getinteger
		move.l     d3,d6
		bsr        getinteger
		movea.l    d3,a1
		; BUG: should test NUM, not ADR
		/* cmpa.l     #0,a1 */
		dc.w 0xb3fc,0,0 /* XXX */
		beq        musstop
		lea.l      mus_soundtype(pc),a3
		tst.w      (a3)
		bge        musauto5
		lea.l      mus_addr(pc),a3
		move.l     a1,(a3)
		lea.l      mus_num(pc),a3
		move.l     d6,(a3)
		lea.l      mus_savearea(pc),a0
		move.l     (vbl_vec).w,(a0)+
		move.l     (timerd_vec).w,(a0)+
		move.b     (gpip).w,(a0)+
		move.b     (aer).w,(a0)+
		move.b     (ddr).w,(a0)+
		move.b     (iera).w,(a0)+
		move.b     (ierb).w,(a0)+
		move.b     (ipra).w,(a0)+
		move.b     (iprb).w,(a0)+
		move.b     (isra).w,(a0)+
		move.b     (isrb).w,(a0)+
		move.b     (imra).w,(a0)+
		move.b     (imrb).w,(a0)+
		move.b     (vr).w,(a0)+
		move.b     (tacr).w,(a0)+
		move.b     (tbcr).w,(a0)+
		move.b     (tcdcr).w,(a0)+
		move.b     (tadr).w,(a0)+
		move.b     (tbdr).w,(a0)+
		move.b     (conterm).w,(a0)+
		andi.b     #0xFA,(conterm).w ; turn off system bell & key click
		movea.l    a1,a0
		move.l     d1,d7
musauto1:
		lea.l      soundtypetable(pc),a1
		move.b     (a0),d1
		move.b     1(a0),d2
		move.b     2(a0),d3
		move.b     3(a0),d4
		move.w     #33-1,d0 ; BUG: only 32 drivers
musauto2:
		cmp.b      (a1),d1
		bne.s      musauto3
		cmp.b      1(a1),d2
		bne.s      musauto3
		cmp.b      2(a1),d3
		bne.s      musauto3
		cmp.b      3(a1),d4
		beq.w      musauto4
musauto3:
		addq.l     #4,a1
		dbf        d0,musauto2
		addq.l     #1,a0
		dbf        d7,musauto1
		moveq.l    #0,d3
		lea.l      mus_soundtype(pc),a3
		move.w     #-1,(a3)
		bra        musauto_end
musauto4:
		move.w     #32,d1
		sub.w      d0,d1
		lea.l      mus_soundtype(pc),a2
		move.w     d1,(a2)
musauto5:
		move.w     mus_soundtype(pc),d0
		move.l     mus_num(pc),d7
		add.w      d0,d0
		lea.l      soundtype_jtable(pc),a0
		adda.w     0(a0,d0.w),a0
		jmp        (a0)

soundtype_jtable:
	dc.w soundtype0-soundtype_jtable
	dc.w soundtype1-soundtype_jtable
	dc.w soundtype2-soundtype_jtable
	dc.w soundtype3-soundtype_jtable
	dc.w soundtype4-soundtype_jtable
	dc.w soundtype5-soundtype_jtable
	dc.w soundtype6-soundtype_jtable
	dc.w soundtype7-soundtype_jtable
	dc.w soundtype8-soundtype_jtable
	dc.w soundtype9-soundtype_jtable
	dc.w soundtype10-soundtype_jtable
	dc.w soundtype11-soundtype_jtable
	dc.w soundtype12-soundtype_jtable
	dc.w soundtype13-soundtype_jtable
	dc.w soundtype14-soundtype_jtable
	dc.w soundtype15-soundtype_jtable
	dc.w soundtype16-soundtype_jtable
	dc.w soundtype17-soundtype_jtable
	dc.w soundtype18-soundtype_jtable
	dc.w soundtype19-soundtype_jtable
	dc.w soundtype20-soundtype_jtable
	dc.w soundtype21-soundtype_jtable
	dc.w soundtype22-soundtype_jtable
	dc.w soundtype23-soundtype_jtable
	dc.w soundtype24-soundtype_jtable
	dc.w soundtype25-soundtype_jtable
	dc.w soundtype26-soundtype_jtable
	dc.w soundtype27-soundtype_jtable
	dc.w soundtype28-soundtype_jtable
	dc.w soundtype29-soundtype_jtable
	dc.w soundtype30-soundtype_jtable
	dc.w soundtype31-soundtype_jtable


soundtype0:
soundtype1:
		moveq.l    #8,d6
		bra        soundplay1
soundtype2:
		moveq.l    #6,d6
		bra        soundplay1
soundtype3:
		moveq.l    #4,d6
		moveq.l    #1,d7
		bra        soundplay1
soundtype4:
		bra.s      soundtype3
soundtype5:
		moveq.l    #8,d6
		moveq.l    #0,d7
		bra        soundplay1
soundtype6:
		moveq.l    #8,d6
		moveq.l    #1,d7
		bra        soundplay1
soundtype7:
		bra.w      soundtype0
soundtype8:
		moveq.l    #62,d6
		bra        soundplay1
soundtype9:
		moveq.l    #8,d6
		moveq.l    #1,d7
		bra        soundplay1
soundtype10:
soundtype31:
		bra.w      soundtype0
soundtype11:
		bra.w      soundtype0
soundtype12:
		bra.w      soundtype0
soundtype13:
		bra.w      soundtype3
soundtype14:
		movea.l    mus_addr(pc),a0
		move.w     #0xFF00,(a0)
		moveq.l    #2,d6
		bra        soundplay2
soundtype15:
		moveq.l    #1,d7
		bra.w      soundtype2
soundtype16:
		movea.l    mus_addr(pc),a3
		lea.l      350(a3),a0
		lea.l      368(a3),a1
		move.l     a0,10(a1)
		move.l     a1,10(a0)
		/* adda.l     #32,a3 */
		dc.w 0xd7fc,0,32 /* XXX */
		jsr        (a3)
		movea.l    mus_addr(pc),a3
		lea.l      1774(a3),a0
		jsr        (a3)
		movea.l    mus_addr(pc),a3
		move.l     #312,d6
		bra        soundplay2
soundtype17:
		movea.l    mus_addr(pc),a3
		moveq.l    #0,d0
		jsr        (a3)
		movea.l    mus_addr(pc),a3
		/* adda.l     #18,a3 */
		dc.w 0xd7fc,0,18 /* XXX */
		jsr        (a3)
		moveq.l    #26,d6
		bra.w      soundplay2
soundtype18:
		moveq.l    #4,d6
		subq.l     #1,d7
		bra.w      soundplay1
soundtype19:
		moveq.l    #0,d7
		moveq.l    #2,d6
		bra.w      soundplay1
soundtype20:
		moveq.l    #0,d7
		move.l     #168,d6
		bra.w      soundplay1
soundtype21:
		moveq.l    #0,d7
		move.l     #156,d6
		bra.w      soundplay1
soundtype22:
		bra        soundtype3
soundtype23:
		bra        soundtype3
soundtype24:
		moveq.l    #1,d7
		moveq.l    #16,d6
		bra.w      soundplay1
soundtype25:
		movea.l    mus_addr(pc),a3
		jsr        (a3)
		movea.l    mus_addr(pc),a3
		addq.l     #4,a3
		move.l     mus_num(pc),d0
		jsr        (a3)
		moveq.l    #8,d6
		bra.w      soundplay2
soundtype26:
		moveq.l    #0,d7
		moveq.l    #34,d6
		bra.w      soundplay1
soundtype27:
		bra        soundtype9
soundtype28:
		bra        soundtype9
soundtype29:
		bra        soundtype0
soundtype30:
		move.w     #1,d7
		bra        soundtype2

soundplay1:
		move.l     d6,-(a7)
		movea.l    mus_addr(pc),a0
		move.l     d7,d0
		jsr        (a0)
		move.l     (a7)+,d6
soundplay2:
		moveq.l    #0,d3
		move.w     mus_soundtype(pc),d3 ; return value
		addq.l     #1,d3
		lea.l      mus_soundoffset(pc),a0
		move.l     d6,(a0)
		lea.l      playirq(pc),a0
		move.l     a0,(vbl_vec).w

musauto_end:
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		moveq.l    #0,d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

playirq:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    mus_addr(pc),a0
		move.l     mus_soundoffset(pc),d0
		adda.l     d0,a0
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     mus_savearea(pc),-(a7) ; jump to orignal VBL handler
		rts

musstop:
		lea.l      mus_soundtype(pc),a3
		tst.w      (a3)
		bmi        musstop_end
		move.l     mus_savearea(pc),(vbl_vec).w ; retore VBL
		moveq.l    #0,d0
		move.w     mus_soundtype(pc),d0
		add.w      d0,d0
		lea.l      stop_jtable(pc),a0
		adda.w     0(a0,d0.w),a0
		jmp        (a0)

stop_jtable:
	dc.w stoptype0-stop_jtable
	dc.w stoptype1-stop_jtable
	dc.w stoptype2-stop_jtable
	dc.w stoptype3-stop_jtable
	dc.w stoptype4-stop_jtable
	dc.w stoptype5-stop_jtable
	dc.w stoptype6-stop_jtable
	dc.w stoptype7-stop_jtable
	dc.w stoptype8-stop_jtable
	dc.w stoptype9-stop_jtable
	dc.w stoptype10-stop_jtable
	dc.w stoptype11-stop_jtable
	dc.w stoptype12-stop_jtable
	dc.w stoptype13-stop_jtable
	dc.w stoptype14-stop_jtable
	dc.w stoptype15-stop_jtable
	dc.w stoptype16-stop_jtable
	dc.w stoptype17-stop_jtable
	dc.w stoptype18-stop_jtable
	dc.w stoptype19-stop_jtable
	dc.w stoptype20-stop_jtable
	dc.w stoptype21-stop_jtable
	dc.w stoptype22-stop_jtable
	dc.w stoptype23-stop_jtable
	dc.w stoptype24-stop_jtable
	dc.w stoptype25-stop_jtable
	dc.w stoptype26-stop_jtable
	dc.w stoptype27-stop_jtable
	dc.w stoptype28-stop_jtable
	dc.w stoptype29-stop_jtable
	dc.w stoptype30-stop_jtable
	dc.w stoptype31-stop_jtable

stoptype0:
stoptype1:
		moveq.l    #4,d6
		moveq.l    #0,d7
		bra        soundstop1
stoptype2:
		moveq.l    #2,d6
		moveq.l    #0,d7
		bra        soundstop1
stoptype3:
		bra        soundstop2
stoptype4:
		bra.w      stoptype3
stoptype5:
		moveq.l    #0,d6
		moveq.l    #1,d7
		bra        soundstop1
stoptype6:
		moveq.l    #0,d6
		moveq.l    #0,d6
		bra        soundstop1
stoptype7:
		bra.w      stoptype0
stoptype8:
		bra        soundstop2
stoptype9:
		moveq.l    #0,d6
		moveq.l    #0,d7
		bra.w      soundstop1
stoptype10:
stoptype31:
		bra.w      stoptype0
stoptype11:
		bra.w      stoptype0
stoptype12:
		bra.w      stoptype0
stoptype13:
		bra.w      soundstop2
stoptype14:
		movea.l    mus_addr(pc),a0
		move.w     #-1,(a0)+
		jsr        (a0)
		bra.w      soundstop2
stoptype15:
		bra.w      stoptype2
stoptype16:
		move.l     #146,d6
		moveq.l    #0,d7
		bra.w      soundstop1
stoptype17:
		move.l     #255,d0
		movea.l    mus_addr(pc),a0
		jsr        (a0)
		/* move.l     #18,d6 */
		dc.w 0x2c3c,0,18 /* XXX */
		moveq.l    #-1,d0
		bra.w      soundstop1
stoptype18:
		bra.w      soundstop2
stoptype19:
		bra        stoptype0
stoptype20:
		bra.w      soundstop2
stoptype21:
		bra.w      soundstop2
stoptype22:
		bra.w      soundstop2
stoptype23:
		bra.w      soundstop2
stoptype24:
		bra.w      soundstop2
stoptype25:
		bra.w      soundstop2
stoptype26:
		bra.w      soundstop2
stoptype27:
		bra.w      stoptype9
stoptype28:
		bra.w      stoptype9
stoptype29:
		bra        stoptype0
stoptype30:
		bra        stoptype2

soundstop1:
		movea.l    mus_addr(pc),a0
		adda.l     d6,a0
		move.l     d7,d0
		jsr        (a0)
soundstop2:
		lea.l      mus_savearea(pc),a0
		move.l     (a0)+,(vbl_vec).w
		move.l     (a0)+,(timerd_vec).w
		move.b     (a0)+,(gpip).w
		move.b     (a0)+,(aer).w
		move.b     (a0)+,(ddr).w
		move.b     (a0)+,(iera).w
		move.b     (a0)+,(ierb).w
		move.b     (a0)+,(ipra).w
		move.b     (a0)+,(iprb).w
		move.b     (a0)+,(isra).w
		move.b     (a0)+,(isrb).w
		move.b     (a0)+,(imra).w
		move.b     (a0)+,(imrb).w
		move.b     (a0)+,(vr).w
		move.b     (a0)+,(tacr).w
		move.b     (a0)+,(tbcr).w
		move.b     (a0)+,(tcdcr).w
		move.b     (a0)+,(tadr).w
		move.b     (a0)+,(tbdr).w
		move.b     (a0)+,(conterm).w
		lea.l      (PSG).w,a0
		move.l     #0x0707FFFF,(a0) ; turn off mixer
		move.l     #0x08080000,(a0) ; turn all voices off
		move.l     #0x09090000,(a0)
		move.l     #0x0A0A0000,(a0)
		lea.l      mus_soundtype(pc),a3
		move.w     #-1,(a3)

musstop_end:
		moveq.l    #0,d3
		bra        musauto_end

mus_addr: ds.l 1
mus_num: ds.l 1
mus_soundtype: dc.w -1

mus_savearea:
	ds.l 1 ; vbl
	ds.l 1 ; timerd
	ds.b 17 ; MFP regs
	ds.b 1  ; conterm
	ds.b 54 ; unused
mus_soundoffset: ds.l 1

soundtypetable:
	dc.b "TFMX" ; Mad Max
	dc.b "COSO" ; Mad Max
	dc.b "Coun" ; Count Zero
	dc.b "YM21" ; Big Alec (old)
	dc.b "THIZ" ; TAO (chip #1)
	dc.b "TOJG" ; TAO (chip #2)
	dc.b "-TAO" ; TAO (digi)
	dc.b "P 90" ; Lap (1990)
	dc.b "P 19" ; Lap (1991)
	dc.b "BADF" ; Big Alec (new)
	dc.b "ille" ; Megatizer
	dc.b "UNDE" ; Undead
	dc.b "ZOUN" ; Zound Dragger
	dc.b "ENEX" ; Titan
	dc.b "MYST" ; LTK
	dc.b "TriM" ; TriMod
	dc.b "LAP9" ; Lap (1 scanline)
	dc.b " C D" ; Synth Dream
	dc.b "Rip:" ; Ben Daglish
	dc.b "NEXU" ; Nexus
	dc.b "HRIS" ; Chrispy Noodle #1
	dc.b "HRIS" ; Chrispy Noodle #2
	dc.b "QQQQ" ; MUF/SMF (disabled)
	dc.b "BIRD" ; Misfit
	dc.b "Blip" ; Blipp Blopper
	dc.b " G.S" ; G.S.R Format
	dc.b "LARY" ; FFT
	dc.b "a6J@" ; Crusader
	dc.b "line" ; Newline
	dc.b "ILLE" ; Millenium Brothers
	dc.b "AXX " ; Synergy
	dc.b "THKE"

	
		move.l     d0,d3
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: MUSPLAY adr,num,offset
 */
musplay:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		movea.l    args+0(pc),a0
		movem.l    args+4(pc),d0-d1
		tst.w      d0
		beq.w      musplay2
		lea.l      vbl_saved_flag(pc),a1
		tst.w      (a1)
		bne.w      musplay1
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
		bra.w      musplay_end
musplay2:
		lea.l      vbl_saved_flag(pc),a2
		tst.w      (a2)
		beq.w      musplay_end
		lea.l      save_vbl(pc),a1
		move.l     (a1),vbl_vec.l /* XXX */
		lea.l      vbl_saved_flag(pc),a1
		move.w     #0,(a1)
		lea.l      musplay_addr(pc),a1
		movea.l    (a1),a0
		move.l     #0x08000000,PSG.l ; turn all voices off
		move.l     #0x09000000,PSG.l
		move.l     #0x0A000000,PSG.l
		bra.s      musplay_end

musplay_intr:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    musplay_addr(pc),a0
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     save_vbl(pc),-(a7)
		rts

musplay_end:
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

vbl_saved_flag: ds.w 1
musplay_addr: ds.l 1
save_vbl: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: r = WHICH BLOCK (madr,x,y)
 */
which_block:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		movea.l    args+0(pc),a0
		move.l     args+4(pc),d0
		move.l     args+8(pc),d1
		cmpi.l     #0x03031973,(a0)+
		bne.s      which_block1
		moveq.l    #7,d5
		bra.s      which_block2
which_block1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        noerror
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
		moveq.l    #0,d2
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)
which_block4:
		move.l     #0x0000FFFF,d3
		bra.s      which_block3

; -----------------------------------------------------------------------------

/*
 * Syntax: RELOCATE padr
 */
relocate:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		movea.l    d3,a0
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
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: P ON
 */
p_on:
		move.l     (a7)+,returnpc
		lea.l      joysave_flag(pc),a0
		tst.w      (a0)
		bne.s      p_on1
		move.w     #1,(a0)
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
		move.l     (a0),saved_joyvec.l /* XXX */
		lea.l      myjoyvec(pc),a1
		move.l     a1,(a0)
p_on1:
		movea.l    returnpc,a0
		jmp        (a0)

myjoyvec:
		movem.l    a0-a1,-(a7)
		move.b     1(a0),joybuf.l /* XXX */
		move.b     2(a0),(joybuf+1).l /* XXX */
		movem.l    (a7)+,a0-a1
		rts

joysave_flag: ds.w 1

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P JOY (n)
 */
p_joy:
		move.l     (a7)+,returnpc
		cmpi.b     #1,d0
		bne        syntax
		bsr        getinteger
		tst.b      d3
		bne.s      p_joy1
		moveq.l    #0,d3
		move.b     joybuf.l,d3
		bra.s      p_joy2
p_joy1:
		moveq.l    #0,d3
		move.b     (joybuf+1).l,d3
p_joy2:
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: P STOP
 */
p_stop:
		move.l     (a7)+,returnpc
		lea.l      joysave_flag(pc),a0
		tst.w      (a0)
		beq.s      p_stop1
		move.w     #0,(a0)
		move.w     #34,-(a7) ; Kbdvbase
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		/* adda.l     #24,a0 */
		dc.w 0xd1fc,0,24 /* XXX */
		move.l     saved_joyvec.l,(a0) /* XXX */
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
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: SET BLOCK madr,x,y,blk
 */
set_block:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		movea.l    d3,a0
		movem.l    args+4(pc),d0-d2
		cmpi.l     #0x03031973,(a0)+
		bne.s      set_block1
		lsl.w      #7,d2
		bra.s      set_block2
set_block1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        noerror
		lsl.w      #8,d2
set_block2:
		tst.w      d0
		blt.w      set_block3
		tst.w      d1
		blt.w      set_block3
		moveq.l    #0,d3
		move.w     (a0)+,d3
		addq.w     #2,d3
		lsl.w      #3,d3
		cmp.w      d3,d0
		bge.w      set_block3
		lsr.w      #3,d3
		move.w     (a0)+,d4
		lsl.w      #3,d4
		cmp.w      d4,d1
		bge.w      set_block3
		andi.w     #-16,d0
		lsr.w      #3,d0
		lsr.w      #4,d1
		mulu.w     d1,d3
		adda.w     d0,a0
		adda.l     d3,a0
		move.w     d2,(a0)
set_block3:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: PALSPLIT md,cadr,y,hig,num
 */
palsplit:
		move.l     (a7)+,returnpc
		cmpi.w     #5,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		lea.l      saveregsend,a0
		movem.l    d0-d1/a0-a2,-(a0)
		move.l     args+0(pc),d1
		movea.l    args+4(pc),a0
		move.l     args+8(pc),d0
		movem.l    args+12(pc),d2-d3
		tst.w      d1
		beq        palsplit4
		cmpi.w     #2,d2
		bge.s      palsplit1
		moveq.l    #2,d2
palsplit1:
		tst.w      palsplit_saveflag
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
		lea.l      0xFFFF8240.l,a0 /* XXX */
		lea.l      palsplit_colortab,a1
		lea.l      2(a1),a1
		move.w     #8-1,d0
palsplit3:
		move.l     (a0)+,(a1)
		lea.l      8(a1),a1
		dbf        d0,palsplit3
		lea.l      palsplit_savearea,a0
		move.b     (iera).w,(a0)+
		move.b     (ierb).w,(a0)+
		move.b     (imra).w,(a0)+
		move.b     (imrb).w,(a0)+
		move.w     #0x2700,sr
		ori.b      #1,(iera).w
		ori.b      #1,(imra).w
		bclr       #3,(vr).w
		clr.b      (tbcr).w
		move.l     (vbl_vec).w,palsplit_savevbl
		move.l     #palsplit_vbl,(vbl_vec).w
; BUG: sr not saved/restored
		move.w     #0x2300,sr
		move.w     #1,palsplit_saveflag
		bra.s      palsplit_end
palsplit4:
		tst.w      palsplit_saveflag
		beq.s      palsplit_end
		move.w     #0x2700,sr
		lea.l      palsplit_savearea,a0
		move.b     (a0)+,(iera).w
		move.b     (a0)+,(ierb).w
		move.b     (a0)+,(imra).w
		move.b     (a0)+,(imrb).w
		move.l     palsplit_savevbl,(vbl_vec).w
; BUG: sr not saved/restored
		move.w     #0x2300,sr
		move.w     #0,palsplit_saveflag

palsplit_end:
		lea.l      saveregs,a0
		movem.l    (a7)+,d0-d1/a0-a2 ; BUG: should be a0
		movea.l    returnpc,a0
		jmp        (a0)

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
		lea.l      timerb_colortab,a1
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
		movem.l    (a7)+,a0-a1 ; FIXME: move below
		clr.b      (tbcr).w
; BUG timerb_vec not saved/restored
		move.l     #palsplit_timerb,(timerb_vec).w
palsplit_patch1:
		move.b     #0x63,(tbdr).w
		move.b     #8,(tbcr).w
palsplit_patch2:
		move.b     #1,(tbdr).w
		move.l     palsplit_savevbl,-(a7)
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
 * Syntax: d = P LEFT (n)
 */
p_left:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      joybuf.l,a0
		adda.l     d3,a0
		moveq.l    #0,d3
		moveq.l    #0,d2
		move.b     (a0),d0
		btst       #2,d0
		beq.w      p_left1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
p_left1:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P UP (n)
 */
p_up:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      joybuf.l,a0
		adda.l     d3,a0
		moveq.l    #0,d3
		moveq.l    #0,d2
		move.b     (a0),d0
		btst       #0,d0
		beq.w      p_up1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
p_up1:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P RIGHT (n)
 */
p_right:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      joybuf.l,a0
		adda.l     d3,a0
		moveq.l    #0,d3
		moveq.l    #0,d2
		move.b     (a0),d0
		btst       #3,d0
		beq.w      p_right1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
p_right1:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P DOWN (n)
 */
p_down:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      joybuf.l,a0
		adda.l     d3,a0
		moveq.l    #0,d3
		moveq.l    #0,d2
		move.b     (a0),d0
		btst       #1,d0
		beq.w      p_down1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
p_down1:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: FLOODPAL colr
 */
floodpal:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		moveq.l    #16-1,d0
		lea.l      floodpal_colortab(pc),a0
floodpal1:
		move.w     d3,(a0)+
		dbf        d0,floodpal1
		lea.l      floodpal_colortab(pc),a0
		move.l     a0,colorptr.l /* XXX */ /* FIXME: use Setpalette */
		movea.l    returnpc,a0
		jmp        (a0)

floodpal_colortab: ds.w 16

; -----------------------------------------------------------------------------

/*
 * Syntax: d = P FIRE (n)
 */
p_fire:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      joybuf.l,a0
		adda.l     d3,a0
		moveq.l    #0,d3
		moveq.l    #0,d2
		move.b     (a0),d0
		btst       #7,d0
		beq.w      p_fire1
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
p_fire1:
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: DIGI PLAY md,sadr,sz,freq,lp
 */
digi_play:
		move.l     (a7)+,returnpc
		cmp.w      #5,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,args+16
		bsr        getinteger
		move.l     d3,args+12
		bsr        getinteger
		move.l     d3,args+8
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		move.l     args+0(pc),d3
		movea.l    args+4(pc),a0
		movem.l    args+8(pc),d0-d2
		tst.w      digiplay_flag
		beq.s      digi_play1
		move.w     #0,digiplay_flag
		move.w     sr,-(a7)
		move.w     #0x2700,sr
		move.l     save_timera,(timera_vec).w
		move.b     save_iera,(iera).w
		move.b     save_imra,(imra).w
		move.b     save_vr,(vr).w
		move.b     save_tacr,(tacr).w
		move.w     #0,digiplay_loop
		move.w     (a7)+,sr
digi_play1:
		tst.w      d3
		beq        digi_play_stop
		tst.w      d2
		lea.l      digiplay_loop(pc),a1
		move.w     d2,(a1)
		subq.w     #1,d1
		cmpi.w     #2,d1
		blt.s      digi_play4
		cmpi.w     #32,d1
		bgt.s      digi_play4
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
		jsr        digiplay_init /* FIXME */
		jsr        install_digiirq /* FIXME */
digi_play4:
		movea.l    returnpc,a0
		jmp        (a0)

install_digiirq:
		lea.l      digiplay_flag(pc),a0
		move.w     #1,(a0)
		move.w     sr,-(a7)
		move.w     #0x2700,sr
		move.l     (timera_vec).w,save_timera
		move.l     #digiplay_irq,(timera_vec).w
		move.b     iera.l,save_iera /* XXX */
		move.b     imra.l,save_imra /* XXX */
		move.b     vr.l,save_vr /* XXX */
		move.b     tacr.l,save_tacr /* XXX */
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
		move.l     save_timera,(timera_vec).w
		move.b     save_iera,(iera).w
		move.b     save_imra,(imra).w
		move.b     save_vr,(vr).w
		move.b     save_tacr,(tacr).w
		move.w     #0,digiplay_loop
digi_play_stop1:
		rte

save_timera: ds.l 1

digiplay_init:
		move.l     d0,digiplay_length2
		move.l     a0,digiplay_addr2
		move.l     d0,digiplay_length
		move.l     a0,digiplay_addr
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
		movem.l    d0-d3/a0-a1,-(a7)
		moveq.l    #0,d0
		movea.l    digiplay_addr,a0
		subq.l     #1,digiplay_length
		bne.s      digiplay_irq2
		lea.l      digiplay_loop(pc),a1
		tst.w      (a1)
		bne.s      digiplay_irq1
		jsr        digi_play_stop /* FIXME */
digiplay_irq1:
		movea.l    digiplay_addr2,a0
		lea.l      digiplay_length(pc),a1
		move.l     digiplay_length2(pc),(a1)
digiplay_irq2:
		move.b     (a0)+,d0
		move.l     a0,digiplay_addr
		lsl.w      #3,d0
		movem.l    voldat(pc,d0.w),d0-d1
		movea.w    #PSG,a0
		movep.l    d0,0(a0)
		move.l     d1,(a0)
		movem.l    (a7)+,d0-d3/a0-a1
		rte

digiplay_addr: ds.l 1
digiplay_length: ds.l 1
digiplay_addr2: ds.l 1
digiplay_length2: ds.l 1 ; backup for loop

digiplay_loop: ds.w 1
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
save_iera: ds.l 1
save_imra: ds.l 1
save_vr: ds.l 1
save_tacr: ds.l 1

; -----------------------------------------------------------------------------

/*
 * Syntax: tadr = STRING (num)
 */
FN_string:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
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
		move.l     a0,d3
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

stringbuf: dc.b "               ",0

; -----------------------------------------------------------------------------

/*
 * Syntax: SAMSIGN sadr,sz
 */
samsign:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0
		bsr        getinteger
		movea.l    d3,a0
samsign1:
		addi.b     #0x80,(a0)+
		subq.w     #1,d0 ; BUG: should be .l
		bne.s      samsign1
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: l = DEPACK (adr)
 */
depack:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		movea.l    d3,a0
		moveq.l    #0,d0
		move.l     d0,d1
		move.l     d0,d3
		move.l     d0,d4
		move.l     d0,d5
		move.l     d0,d6
		move.l     d0,d7
		movea.l    d0,a1
		movea.l    d0,a2
		movea.l    d0,a3
		movea.l    d0,a4
		movea.l    d0,a5
		movea.l    d0,a6
		cmpi.l     #PACK_ICE2,(a0)
		beq.w      depack1
		cmpi.l     #PACK_FIRE,(a0)
		beq.w      depack2
		cmpi.l     #PACK_ATOMIC,(a0)
		beq.w      depack4
		cmpi.l     #PACK_AUTOMATION,(a0)
		beq.w      depack3
		cmpi.l     #PACK_SPEED2,(a0)
		beq.w      depack5
		cmpi.l     #PACK_SPEED3,(a0)
		beq.w      depack6
		clr.l      -(a7) ; return value
		bra.w      depack_end
depack1:
		move.l     8(a0),-(a7)
		bsr        ice2
		bra.w      depack_end
depack2:
		move.l     8(a0),-(a7)
		bsr        fire_decrunch
		bra.w      depack_end
depack3:
		move.l     8(a0),-(a7)
		bsr        AU5_decrunch
		bra.w      depack_end
depack4:
		move.l     4(a0),-(a7)
		bsr.w      atomik
		bra.w      depack_end
depack5:
		move.l     12(a0),-(a7)
		bsr        speed2_depack
		bra.w      depack_end
depack6:
		move.l     12(a0),-(a7)
		bsr        speed3_depack
depack_end:
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		move.l     (a7)+,d3 ; return value
		moveq.l    #0,d2
		movea.l    returnpc,a0
		jmp        (a0)

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
replace_blocks:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,d1
		bsr        getinteger
		move.l     d3,d0
		bsr        getinteger
		movea.l    d3,a0
		cmpi.l     #0x03031973,(a0)+
		bne.s      replace_blocks1
		moveq.l    #7,d4
		bra.s      replace_blocks2
replace_blocks1:
		cmpi.l     #0x02528E54,-4(a0)
		bne        noerror
		moveq.l    #8,d4
replace_blocks2:
		moveq.l    #0,d2
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
		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: l = DLOAD (filename,adr,ofs,num)
 */
dload:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0 ; d0=num
		bsr        getinteger
		move.l     d3,d1 ; d1=ofs
		bsr        getinteger
		movea.l    d3,a4 ; a4=adr
		bsr        getinteger
		move.l     a3,-(a7)
		movea.l    d3,a3 ; a3=filename
		move.l     d0,d4 ; d4=num
		move.l     d1,d3 ; d3=ofs
		moveq.l    #0,d6 ; FIXME: useless
		clr.w      -(a7)
		move.l     a3,-(a7)
		move.w     #61,-(a7) ; Fopen
		trap       #1
		addq.l     #8,a7
		move.w     d0,d7
		move.l     d0,d6
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.w      dload2
		clr.w      -(a7)
		move.w     d7,-(a7)
		move.l     d3,-(a7)
		move.w     #66,-(a7) ; Fseek
		trap       #1
		lea.l      10(a7),a7
		move.l     d0,d6
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.w      dload1
		move.l     a4,-(a7)
		move.l     d4,-(a7)
		move.w     d7,-(a7)
		move.w     #63,-(a7) ; Fread
		trap       #1
		lea.l      12(a7),a7
		move.l     d0,d6
dload1:
		move.w     d7,-(a7)
		move.w     #62,-(a7) ; Fclose
		trap       #1
		addq.l     #4,a7
dload2:
		moveq.l    #0,d2
		moveq.l    #0,d3 ; FIXME: useless
		move.l     d6,d3
		movea.l    (a7)+,a3
		movea.l    returnpc,a0
		jmp        (a0)

; -----------------------------------------------------------------------------

/*
 * Syntax: DISPLAY PC1 gadr,scr
 */
display_pc1:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)
		bsr        getinteger
		move.l     d3,args+4
		bsr        getinteger
		move.l     d3,args+0
		movea.l    args+0(pc),a0
		movea.l    args+4(pc),a1
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
		lea.l      saveregs(pc),a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

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
dsave:
		move.l     (a7)+,returnpc
		cmpi.w     #4,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0 ; d0=num
		bsr        getinteger
		move.l     d3,d1 ; d1=ofs
		bsr        getinteger
		movea.l    d3,a4 ; a4=adr
		bsr        getinteger
		move.l     a3,-(a7)
		movea.l    d3,a3 ; a3=filename
		move.l     d0,d4 ; d4=num
		move.l     d1,d3 ; d3=ofs
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
		move.l     d0,d6
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.s      dsave4
		clr.w      -(a7)
		move.w     d7,-(a7)
		move.l     d3,-(a7)
		move.w     #66,-(a7) ; Fseek
		trap       #1
		lea.l      10(a7),a7
		move.l     d0,d6
		/* tst.w     d0 */
		dc.w 0x0c40,0 /* XXX */
		blt.s      dsave3
		move.l     a4,-(a7)
		move.l     d4,-(a7)
		move.w     d7,-(a7)
		move.w     #64,-(a7) ; Fwrite
		trap       #1
		lea.l      12(a7),a7
		move.l     d0,d6
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
		moveq.l    #0,d2
		moveq.l    #0,d3
		move.l     d6,d3
		movea.l    (a7)+,a3
		movea.l    returnpc,a0
		jmp        (a0)

dsave_dtaptr: ds.l 1
dsave_dta: ds.b 46

; -----------------------------------------------------------------------------

/*
 * Syntax: HONESTY
 */
honesty:
		move.l     (a7)+,returnpc
		lea.l      saveregsend,a0
		movem.l    d5-d6/a1-a6,-(a0)

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg1,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg2,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg3,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg4,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg5,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg6,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg7,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg8,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg9,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg10,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg11,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		/* moveq.l     #2,d0 */
		dc.w 0x203c,0,2 /* XXX */
		moveq.l    #W_setpen,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg12,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		/* moveq.l     #1,d0 */
		dc.w 0x203c,0,1 /* XXX */
		moveq.l    #W_setpen,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg13,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg14,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #crnl,a0
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		movem.l    d7/a0,-(a7)
		movea.l    #honesty_msg15,a0
		moveq.l    #W_centre,d7
		trap       #3
		movem.l    (a7)+,d7/a0

		lea.l      saveregs,a0
		movem.l    (a0)+,d5-d6/a1-a6
		movea.l    returnpc,a0
		jmp        (a0)

honesty_msg1: dc.b C_clearscreen,C_home,0
honesty_msg2: dc.b "To register for Missing Link, send",0
honesty_msg3: dc.b $9c,"10.00 (Ten pounds sterling) to:",0,0
honesty_msg4: dc.b "Top Notch (TML dept.)",0
honesty_msg5: dc.b "PO BOX 1083",0
honesty_msg6: dc.b "GLASGOW",0
honesty_msg7: dc.b "SCOTLAND",0,0
honesty_msg8: dc.b "G14 9DG",0
honesty_msg9: dc.b "If you are outside Europe, please",0
honesty_msg10: dc.b "enclose an extra ",$9c,"1.50 for P&P",0,0
honesty_msg11: dc.b "Make cheques, etc, payable to:",0,0
honesty_msg12: dc.b "Colin A Watt & Billy Allan",0,0
honesty_msg13: dc.b C_inverse,"This version is for registrees only and",0,0
honesty_msg14: dc.b "is definatley NOT public domain.",C_normal,0
honesty_msg15: dc.b "V 2.0 (C)1993 Top Notch",0
	.even

; space for registers d5-d6/a1-a6
saveregs: ds.l 8
saveregsend:

; space for up to 8 arguments
args: ds.l 8


logo:
		dc.w 0xffff,0xffff,0xfff0,0x03fc
		dc.w 0xffff,0xffff,0xfffc,0x03fc
		dc.w 0xffff,0xffff,0xffff,0x03fc
		dc.w 0xffff,0xffff,0xffff,0x83fc
		dc.w 0x0000,0x0000,0xffff,0xc3fc
		dc.w 0x0000,0x0000,0xffff,0xe3fc
		dc.w 0x000f,0xf000,0xffff,0xf3fc
		dc.w 0x000f,0xf000,0xff3f,0xfbfc
		dc.w 0x000f,0xf000,0xff0f,0xfffc
		dc.w 0x000f,0xf000,0xff03,0xfffc
		dc.w 0x000f,0xf000,0xff01,0xfffc
		dc.w 0x000f,0xf000,0xff00,0xfffc
		dc.w 0x000f,0xf000,0xff00,0x7ffc
		dc.w 0x000f,0xf000,0xff00,0x3ffc
		dc.w 0x000f,0xf000,0xff00,0x3ffc
		dc.w 0x000f,0xf000,0xff00,0x1ffc
		dc.w 0x000f,0xf000,0xff00,0x1ffc
		dc.w 0x000f,0xf000,0xff00,0x0ffc
		dc.w 0x000f,0xf000,0xff00,0x0ffc
		dc.w 0x000f,0xf000,0xff00,0x07fc
		dc.w 0x000f,0xf000,0xff00,0x07fc
		dc.w 0x000f,0xf000,0xff00,0x07fc
		dc.w 0x000f,0xf000,0xff00,0x03fc
		dc.w 0x000f,0xf000,0xff00,0x03fc
		dc.w 0x000f,0xf000,0xff00,0x03fc
		dc.w 0x000f,0xf000,0xff00,0x03fc
		dc.w 0x0000,0x0000,0x0000,0x0000
		dc.w 0x0000,0x0001,0x0000,0x0000

	dc.w 0,0,8
	dc.b "SPRMAXNB"
	dc.l 256
	dc.w 136
	dc.b "VERSION$"
	dc.l 0x3c434


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


	dc.w 0
	dc.w 0


finprg:

ZERO = 0
