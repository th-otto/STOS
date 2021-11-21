		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "tokens.inc"
		.include "equates.inc"
		.include "lib.inc"

COOK_NEMESIS = 0x4E737064 /* 'Nspd' */

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
	dc.w	lib46-lib45
	dc.w	lib47-lib46
	dc.w	lib48-lib47
	dc.w	lib49-lib48
	dc.w	lib50-lib49
	dc.w	lib51-lib50
	dc.w	lib52-lib51
	dc.w	lib53-lib52
	dc.w	lib54-lib53
	dc.w	lib55-lib54
	dc.w	lib56-lib55
	dc.w	lib57-lib56
	dc.w	lib58-lib57
	dc.w	lib59-lib58
	dc.w	lib60-lib59
	dc.w	lib61-lib60
	dc.w	lib62-lib61
	dc.w	libex-lib62

para:
	dc.w	62			; number of library routines
	dc.w	62			; number of extension commands
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
	.dc.w l046-para
	.dc.w l047-para
	.dc.w l048-para
	.dc.w l049-para
	.dc.w l050-para
	.dc.w l051-para
	.dc.w l052-para
	.dc.w l053-para
	.dc.w l054-para
	.dc.w l055-para
	.dc.w l056-para
	.dc.w l057-para
	.dc.w l058-para
	.dc.w l059-para
	.dc.w l060-para
	.dc.w l061-para
	.dc.w l062-para


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,1,1,0             ; coldboot
l002:	.dc.b I,1,1,0             ; cookieptr
l003:	.dc.b 0,1,1,0             ; warmboot
l004:	.dc.b I,S,1,1,0           ; cookie(ID$)
l005:	.dc.b 0,1,1,0             ; caps on
l006:	.dc.b S,1,1,0             ; _tos$
l007:	.dc.b 0,1,1,0             ; caps off
l008:	.dc.b I,1,1,0             ; _phystop
l009:	.dc.b 0,I,1,1,0           ; _cpuspeed N
l010:	.dc.b I,1,1,0             ; _memtop
l011:	.dc.b 0,I,1,1,0           ; _blitterspeed N
l012:	.dc.b I,1,1,0             ; _busmode
l013:	.dc.b 0,1,1,0             ; _stebus
l014:	.dc.b I,I,1,1,0           ; paddle x(P)
l015:	.dc.b 0,1,1,0             ; _falconbus
l016:	.dc.b I,I,1,1,0           ; paddle y(P)
l017:	.dc.b 0,1,1,0             ; _cpucache on
l018:	.dc.b I,1,1,0             ; _cpucache stat
l019:	.dc.b 0,1,1,0             ; _cpucache off
l020:	.dc.b I,1,1,0             ; lpen x
l021:	.dc.b 0,1,1,0             ; ide on
l022:	.dc.b I,1,1,0             ; lpen y
l023:	.dc.b 0,1,1,0             ; ide off
l024:	.dc.b I,1,1,0             ; _nemesis
l025:	.dc.b 0,I,1,1,0           ; _set printer X
l026:	.dc.b I,1,1,0             ; _printer ready
l027:	.dc.b 0,S,',',I,1,1,0     ; file attr FNAME$,ATTR
l028:	.dc.b I,1,1,0             ; kbshift
l029:	.dc.b 0,S,',',I,1,1,0     ; code$ A$,N
l030:	.dc.b I,1,1,0             ; _aes in
l031:	.dc.b 0,S,',',I,1,0       ; uncode$ A$,N
l032:	.dc.b I,S,1,1,0           ; file exist(F$)
l033:	.dc.b 0,1,1,0
l034:	.dc.b I,I,',',I,',',I,',',I,1,1,0   ; _add cbound(A,I,L,U)
l035:	.dc.b 0,S,',',S,1,1,0     ; lset$ A$,B$
l036:	.dc.b I,I,',',I,',',I,',',I,1,1,0   ; _sub cbound(A,I,L,U)
l037:	.dc.b 0,S,',',S,1,1,0     ; rset$ A$,B$
l038:	.dc.b I,I,',',I,',',I,1,1,0  ; _add ubound(A,I,U)
l039:	.dc.b 0,1,1,0             ; st mouse on
l040:	.dc.b I,I,',',I,',',I,1,1,0  ; _sub lbound(A,I,L)
l041:	.dc.b 0,1,1,0             ; st mouse off
l042:	.dc.b I,I,1,1,0           ; odd(A)
l043:	.dc.b 0,I,1               ; st mouse colour COL_INDEX
        .dc.b   I,',',I,',',I,1,1,0 ; st mouse colour RED,GREEN,BLUE
l044:	.dc.b I,I,1,1,0           ; even(A)
l045:	.dc.b 0,I,1               ; _limit st mouse -1
        .dc.b   I,',',I,',',I,',',I,1,1,0             ; _limit st mouse X1,Y1,X2,Y2
l046:	.dc.b I,1,1,0             ; st mouse stat
l047:	.dc.b 0,I,1,1,0           ; st mouse N
l048:	.dc.b S,S,',',S,',',I,',',I,',',I,',',I,',',I,1,1,0             ; _fileselect
l049:	.dc.b 0,1,1,0
l050:	.dc.b I,I,1,1,0           ; _jagpad direction(PORT) 
l051:	.dc.b 0,1,1,0
l052:	.dc.b I,I,',',I,1,1,0     ; _jagpad fire(PORT,BTN)
l053:	.dc.b 0,1,1,0
l054:	.dc.b I,I,1,1,0           ; _jagpad pause(PORT)
l055:	.dc.b 0,1,1,0
l056:	.dc.b I,I,1,1,0           ; _jagpad option(PORT)
l057:	.dc.b 0,1,1,0
l058:	.dc.b S,I,1,1,0           ; _jagpad key$(PORT)
l059:	.dc.b 0,1,1,0             ; _joysticks on
l060:	.dc.b I,I,1,1,0           ; _joyfire(PORT)
l061:	.dc.b 0,1,1,0             ; _joysticks off
l062:	.dc.b I,I,1,1,0           ; _joystick(PORT)

		.even

entry:  bra.w init

install_joyvec:
		movem.l    a0-a6,-(a7)
		move.w     #34,-(a7) ; Kbdvbase
		trap       #14
		addq.l     #2,a7
		lea.l      kbdvbase(pc),a0
		move.l     d0,(a0)
		movea.l    d0,a0
		lea.l      oldjoyvec(pc),a1
		move.l     24(a0),(a1)
		lea.l      myjoyvec(pc),a1
		move.l     a1,24(a0)
		lea.l      (0xFFFFFC00).w,a1
install_joyvec1:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      install_joyvec1
		move.b     #0x14,2(a1) ; SET JOYSTICK EVENT REPORTING
		movem.l    (a7)+,a0-a6
		rts

myjoyvec:
		move.l     a1,-(a7)
		lea.l      joybuf(pc),a1
		move.b     1(a0),(a1)
		move.b     2(a0),1(a1)
		movea.l    (a7)+,a1
		rts

oldjoyvec: ds.l 1
   ds.l 1 /* unused */
kbdvbase: ds.l 1
joybuf: ds.b 2

get_joyfire:
		lea.l      joybuf(pc),a0
		move.b     0(a0,d0.w),d3
		andi.b     #0x80,d3
		beq.s      get_joyfire1
		moveq.l    #-1,d3
get_joyfire1:
		rts

restore_joyvec:
		movem.l    d0-d1/a0-a1,-(a7)
		lea.l      kbdvbase(pc),a0
		move.l     (a0),d0
		beq.s      joysticks_off2
		movea.l    d0,a1
		clr.l      (a0)
		move.l     oldjoyvec(pc),24(a1)
		lea.l      ($FFFFFC00).w,a1
joysticks_off1:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      joysticks_off1
		move.b     #8,2(a1) ; restore to normal mouse reporting
joysticks_off2:
		movem.l    (a7)+,d0-d1/a0-a1
		rts


get_joybutton:
		lea.l      joybuf(pc),a0
		move.b     0(a0,d0.w),d3
		andi.b     #0x7F,d3
		rts


mch_cookie: ds.l 1
cpu_cookie: ds.l 1
nemesis_cookie:
	ds.l 1 ; current value
	ds.l 1 ; original value

getjar:
		move.l     0x000005A0,d0
		rts
getcookie:
		pea        getjar(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      getcookie3
		movea.l    d0,a0
getcookie1:
		move.l     (a0)+,d1
		beq.s      getcookie3
		move.l     (a0)+,d0
		cmp.l      d3,d1
		bne.s      getcookie1
		tst.l      d0
		rts
getcookie3:
		moveq      #0,d0
		rts


init:
		movem.l    d0-d7/a0-a6,-(a7)
		move.l     #0x5F4D4348,d3 /* '_MCH' */
		bsr        getcookie
		lea.l      mch_cookie(pc),a0
		move.l     d0,(a0)
		move.l     #0x5F435055,d3 /* '_CPU' */
		bsr        getcookie
		lea.l      cpu_cookie(pc),a0
		move.l     d0,(a0)
		move.l     #COOK_NEMESIS,d3
		bsr        getcookie
		lea.l      nemesis_cookie(pc),a0
		move.l     d0,(a0)+
		move.l     d0,(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		lea exit(pc),a2
		rts

exit:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        restore_joyvec
		move.w     #0x00C9,d0
		trap       #2
		cmpi.w     #0x00C9,d0
		beq.s      exit1
		move.w     mch_cookie(pc),d0
		subq.w     #3,d0
		bne.s      exit1
		pea.l      dowarm(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
exit1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts


dowarm:
		lea.l      nemesis_cookie(pc),a0
		tst.l      4(a0)
		beq        warm_reset
		tst.l      (a0)
		beq.s      warm_16mhz
		cmpi.l     #1,4(a0)
		beq.s      warm_20mhz
		cmpi.l     #2,4(a0)
		beq        warm_24mhz
		bra        warm_reset

warm_16mhz:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0x96,(a0)
		moveq      #0,d0
		bsr        set_nemesis_cookie
		bra        warm_reset

warm_20mhz:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		moveq      #1,d0
		bsr        set_nemesis_cookie
		bset       #0,(0xFFFF8007).w ; CPU 16Mhz
		bclr       #2,(0xFFFF8007).w ; blitter 8Mhz
		bra        enable_cache

warm_24mhz:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD5,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		moveq      #2,d0
		bsr        set_nemesis_cookie
		bset       #0,(0xFFFF8007).w ; CPU 16Mhz
		bclr       #2,(0xFFFF8007).w ; blitter 8Mhz
		bra        enable_cache

warm_reset:
		movea.l    #0xFFFF8007,a0
		moveq.l    #0,d0
		bset       #0,d0 ; CPU 16Mhz
		bset       #2,d0 ; blitter 16Mhz
		bset       #5,d0 ; STe bus emulation off
		move.b     d0,(a0)
enable_cache:
		move.l     cpu_cookie(pc),d0
		cmp.w      #30,d0
		bne.s      warm_reset1
		move.l     #0x00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
warm_reset1:
		rts

set_nemesis_cookie:
		movea.l    0x000005A0,a0
		move.l     #COOK_NEMESIS,d2
set_nemesis_cookie1:
		move.l     (a0)+,d1
		beq.s      set_nemesis_cookie3
		cmp.l      d2,d1
		beq.s      set_nemesis_cookie2
		addq.l     #4,a0
		bra.s      set_nemesis_cookie1
set_nemesis_cookie2:
		move.l     d0,(a0)
		lea        nemesis_cookie(pc),a0
		move.l     d0,(a0)
		tst.l      d2
set_nemesis_cookie3:
		rts


/*
 * Syntax: coldboot
 */
lib1:
	dc.w	0			; no library calls
coldboot:
		pea.l      docoldboot(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
docoldboot:
		clr.l      0x00000420 ; clear memvalid flag
		movea.l    4.w,a0
		jmp        (a0)

/*
 * Syntax: P_COOKIE=cookieptr
 */
lib2:
	dc.w	0			; no library calls
cookieptr:
		pea        cgetjar(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		moveq      #0,d2
		move.l     d0,-(a6)
		rts
cgetjar:
		move.l     0x000005A0,d0
		rts

/*
 * Syntax: warmboot
 */
lib3:
	dc.w	0			; no library calls
warmboot:
		pea.l      dowarmboot(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
dowarmboot:
		movea.l    4.w,a0
		jmp        (a0)

/*
 * Syntax: COOKIE_VAL=cookie(ID$)
 */
lib4:
	dc.w	0			; no library calls
cookie:
		move.l     (a6)+,a2
		moveq      #0,d0
		move.w     (a2)+,d3
		subq.w     #4,d3
		bne.s      cookie4
		movem.l    a0-a5,-(a7)
		subq.l     #4,a7
		move.l     a7,a0
		move.b     (a2)+,(a0)+
		move.b     (a2)+,(a0)+
		move.b     (a2)+,(a0)+
		move.b     (a2)+,(a0)+
		move.l     (a7)+,d3
		move.l     debut(a5),a0
		movea.l    0(a0,d1.w),a0
		lea        getcookie-entry(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a5
cookie3:
		cmpi.l     #0x5F435055,d3 /* '_CPU' */
		bne.s      cookie4
		andi.l     #255,d0
		addi.l     #68000,d0
cookie4:
		moveq      #0,d2
		move.l     d0,-(a6)
		rts


/*
 * Syntax: caps on
 */
lib5:
	dc.w	0			; no library calls
caps_on:
		movem.l    a0-a2,-(a7)
		move.w     #16,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts

/*
 * Syntax: A$=_tos$
 */
lib6:
	dc.w	0
tosstr:
		movem.l    a2-a5,-(a7)
		pea.l      get_tosvers(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		moveq.l    #5,d3
		lea        tosverstr(pc),a0
		move.l     a0,a1
		move.w     d3,(a0)+
		andi.w     #0x0FFF,d0
		move.l     d0,d2
		move.b     #' ',(a0)+
		lsr.w      #8,d0
		addi.b     #'0',d0
		move.b     d0,(a0)+
		move.b     #'.',(a0)+
		move.w     d2,d0
		andi.w     #0xF0,d0
		lsr.w      #4,d0
		addi.b     #'0',d0
		move.b     d0,(a0)+
		andi.w     #15,d2
		addi.b     #'0',d2
		move.b     d2,(a0)+
		movem.l    (a7)+,a2-a5
		move.l     a1,-(a6)
		rts
get_tosvers:
		movea.l    0x000004F2,a0
		move.w     2(a0),d0
		rts

tosverstr: ds.b 8

/*
 * Syntax: caps off
 */
lib7:
	dc.w	0			; no library calls
caps_off:
		movem.l    a0-a2,-(a7)
		clr.w      -(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts

/*
 * Syntax: X=_phystop
 */
lib8:
	dc.w	0			; no library calls
phystop:
		pea.l      get_phystop(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		clr.l      d2
		move.l     d0,-(a6)
		rts
get_phystop:
		move.l     0x0000042E,d0
		rts

/*
 * Syntax: _cpuspeed N
 */
lib9:
	dc.w	0			; no library calls
cpuspeed:
		move.l     (a6)+,d3
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      cpuspeed6
		lea        set_nemesis_cookie-entry(a3),a0
		lea        set_nemesis_ptr(pc),a1
		move.l     a0,(a1)
		move.l     nemesis_cookie+4-entry(a3),d0
		beq.s      cpuspeed1
		cmpi.l     #8,d3
		beq.s      cpuspeed2
		cmpi.l     #16,d3
		beq.s      cpuspeed3
		cmpi.l     #20,d3
		beq.s      cpuspeed4
		cmpi.l     #24,d3
		beq.s      cpuspeed5
		rts
cpuspeed1:
		cmpi.l     #8,d3
		beq.s      cpuspeed2
		cmpi.l     #16,d3
		beq.s      cpuspeed3
		rts
cpuspeed2:
		pea.l      cpuspeed_set8(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		rts
cpuspeed3:
		pea.l      cpuspeed_set16(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		rts
cpuspeed4:
		pea.l      cpuspeed_set20(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		rts
cpuspeed5:
		pea.l      cpuspeed_set24(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
cpuspeed6:
		rts

cpuspeed_set8:
		moveq      #0,d0
		move.l     set_nemesis_ptr(pc),a0
		jsr        (a0)
		beq        cpuspeed_set8_3
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0x96,(a0)
cpuspeed_set8_3:
		bclr       #0,0xFFFF8007 ; CPU 8Mhz
		rts

cpuspeed_set16:
		moveq      #0,d0
		move.l     set_nemesis_ptr(pc),a0
		jsr        (a0)
		beq        cpuspeed_set16_3
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0x96,(a0)
cpuspeed_set16_3:
		bset       #0,0xFFFF8007 ; CPU 16Mhz
		rts

cpuspeed_set20:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		moveq      #1,d0
		move.l     set_nemesis_ptr(pc),a0
		jsr        (a0)
		bset       #0,(0xFFFF8007).w ; CPU 16Mhz
		bclr       #2,(0xFFFF8007).w ; blitter 8Mhz
		rts

cpuspeed_set24:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD5,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		moveq      #2,d0
		move.l     set_nemesis_ptr(pc),a0
		jsr        (a0)
		bset       #0,(0xFFFF8007).w ; CPU 16Mhz
		bclr       #2,(0xFFFF8007).w ; blitter 8Mhz
		rts

set_nemesis_ptr: ds.l 1


/*
 * Syntax: X=_memtop
 */
lib10:
	dc.w	0			; no library calls
memtop:
		pea.l      get_memtop(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		clr.l      d2
		move.l     d0,-(a6)
		rts

get_memtop:
		move.l     0x00000436,d0
		rts

/*
 * Syntax: _blitterspeed N
 */
lib11:
	dc.w	0			; no library calls
blitterspeed:
		move.l     (a6)+,d3
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      blitterspeed4
		move.l     nemesis_cookie+4-entry(a3),d0
		bne.s      blitterspeed2
blitterspeed1:
		cmpi.l     #16,d3
		beq.s      blitterspeed3
		cmpi.l     #8,d3
		bne.s      blitterspeed4
blitterspeed2:
		pea.l      blitter_set8(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		rts
blitterspeed3:
		pea.l      blitter_set16(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
blitterspeed4:
		rts

blitter_set8:
		bclr       #2,0xFFFF8007 ; blitter 8Mhz
		rts

blitter_set16:
		bset       #2,0xFFFF8007 ; blitter 16Mhz
		rts



/*
 * Syntax: B=_busmode
 */
lib12:
	dc.w	0			; no library calls
busmode:
		movem.l    d1-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq      #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      busmode1
		pea.l      get_busmode(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		move.l     d0,d3
busmode1:
		movem.l    (a7)+,d1-d2/a0-a3
		clr.l      d2
		move.l     d3,-(a6)
		rts

get_busmode:
		moveq      #0,d0
		move.b     0xFFFF8007,d0
		rts

/*
 * Syntax: _stebus
 */
lib13:
	dc.w	0			; no library calls
stebus:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      stebus1
		pea.l      stebus_on(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
stebus1:
		movem.l    (a7)+,d0-d2/a0-a3
		rts
stebus_on:
		bclr       #5,0xFFFF8007 ; STe bus emulation on
		rts


/*
 * Syntax: X=paddle x(P)
 */
lib14:
	dc.w	0			; no library calls
paddle_x:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     (a6)+,d1
		moveq      #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      paddle_x1
		subq.w     #2,d0
		bne.s      paddle_x2
paddle_x1:
		cmpi.w     #4,d1
		bcc.s      paddle_x2
		asl.w      #2,d1
		movea.l    #$ffff9210,a0
		move.b     1(a0,d1.w),d3
paddle_x2:
		movem.l    (a7)+,d0-d2/a0-a3
		clr.l      d2
		move.l     d3,-(a6)
		rts


/*
 * Syntax: _falconbus
 */
lib15:
	dc.w	0			; no library calls
falconbus:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      falconbus1
		pea.l      stebus_off(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
falconbus1:
		movem.l    (a7)+,d0-d2/a0-a3
		rts
stebus_off:
		bset       #5,0xFFFF8007 ; STe bus emulation off
		rts


/*
 * Syntax: Y=paddle y(P)
 */
lib16:
	dc.w	0			; no library calls
paddle_y:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     (a6)+,d1
		moveq      #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      paddle_y1
		subq.w     #2,d0
		bne.s      paddle_y2
paddle_y1:
		cmpi.w     #4,d1
		bcc.s      paddle_y2
		asl.w      #2,d1
		movea.l    #$ffff9212,a0
		move.b     1(a0,d1.w),d3
paddle_y2:
		movem.l    (a7)+,d0-d2/a0-a3
		clr.l      d2
		move.l     d3,-(a6)
		rts


/*
 * Syntax: _cpucache on
 */
lib17:
	dc.w	0			; no library calls
cpucache_on:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     cpu_cookie-entry(a3),d0
		cmpi.w     #30,d0
		bne.s      cpucache_on1
		pea.l      cache_on(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
cpucache_on1:
		movem.l    (a7)+,d0-d2/a0-a3
		rts
cache_on:
		move.l     #$00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #$00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #$00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts

/*
 * Syntax: X=_cpucache stat
 */
lib18:
	dc.w	0			; no library calls
cpucache_stat:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq.l    #0,d3
		move.l     cpu_cookie-entry(a3),d0
		cmpi.w     #30,d0
		bne.s      cpucache_stat1
		pea.l      cache_get(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		move.l     d0,d3
cpucache_stat1:
		movem.l    (a7)+,d0-d2/a0-a3
		clr.l      d2
		move.l     d3,-(a6)
		rts
cache_get:
		dc.w 0x4e7a,2 /* movec      cacr,d0 */
		rts


/*
 * Syntax: _cpucache off
 */
lib19:
	dc.w	0			; no library calls
cpucache_off:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     cpu_cookie-entry(a3),d0
		cmpi.w     #30,d0
		bne.s      cpucache_off1
		pea.l      cache_off(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
cpucache_off1:
		movem.l    (a7)+,d0-d2/a0-a3
		rts
cache_off:
		move.l     #$00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		moveq.l    #0,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts


/*
 * Syntax: X=lpen x
 */
lib20:
	dc.w	0			; no library calls
lpen_x:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq.l    #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      lpen_x1
		subq.w     #2,d0
		bne.s      lpen_x2
lpen_x1:
		move.w     $ffff9220,d3
lpen_x2:
		movem.l    (a7)+,d0-d2/a0-a3
		clr.l      d2
		move.l     d3,-(a6)
		rts


/*
 * Syntax: ide on
 */
lib21:
	dc.w	0			; no library calls
ide_on:
		movem.l    a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      ide_on1
		move.w     #0x007F,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
ide_on1:
		movem.l    (a7)+,a0-a3
		rts

/*
 * Syntax: Y=lpen y
 */
lib22:
	dc.w	0			; no library calls
lpen_y:
		movem.l    d0-d2/a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq.l    #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      lpen_y1
		subq.w     #2,d0
		bne.s      lpen_y2
lpen_y1:
		move.w     0xffff9222,d3
lpen_y2:
		movem.l    (a7)+,d0-d2/a0-a3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: ide off
 */
lib23:
	dc.w	0			; no library calls
ide_off:
		movem.l    a0-a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #3,d0
		bne.s      ide_off1
		move.w     #0x0080,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
ide_off1:
		movem.l    (a7)+,a0-a3
		rts

/*
 * Syntax: NEMESIS_FLAG=_nemesis
 */
lib24:
	dc.w	0			; no library calls
nemesis:
		move.l     a3,-(a7)
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     nemesis_cookie-entry(a3),d3
		beq.s      nemesis1
		moveq.l    #-1,d3
nemesis1:
		move.l     (a7)+,a3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: _set printer X
 */
lib25:
	dc.w	0			; no library calls
set_printer:
		move.l     (a6)+,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #33,-(a7) /* Setprt */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts

/*
 * Syntax: A=_printer ready
 */
lib26:
	dc.w	0			; no library calls
printer_ready:
		movem.l    a0-a2,-(a7)
		clr.w      -(a7)
		move.w     #8,-(a7) /* Bcostat */
		trap       #13
		addq.l     #4,a7
		move.w     d0,d3
		ext.l      d3
		movem.l    (a7)+,a0-a2
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: file attr FNAME$,ATTR
 */
lib27:
	dc.w	0			; no library calls
file_attr:
		move.l     (a6)+,d1
		move.l     (a6)+,a2
		lea.l      file_attrname(pc),a1
		move.w     #(256/4)-1,d7
file_attr1:
		clr.l      (a1)+
		dbf        d7,file_attr1
		lea.l      file_attrname(pc),a1
		move.w     (a2)+,d7
		subq.w     #1,d7
file_attr2:
		move.b     (a2)+,(a1)+
		dbf        d7,file_attr2
		clr.b      (a1)+
		movem.l    a0-a2,-(a7)
		move.w     d1,-(a7)
		move.w     #1,-(a7)
		pea.l      file_attrname(pc)
		move.w     #67,-(a7) /* Fattrib */
		trap       #1
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a2
		tst.w      d0
		bmi.s      diskerror
		rts
diskerror:
		moveq.l    #E_diskerror,d0
		movea.l    error(a5),a0
		jmp        (a0)

file_attrname: ds.b 256


/*
 * Syntax: X=kbshift
 */
lib28:
	dc.w	0			; no library calls
kbshift:
		movem.l    a0-a2,-(a7)
		move.w     #-1,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		moveq      #0,d3
		move.w     d0,d3
		movem.l    (a7)+,a0-a2
		clr.l      d2
		move.l     d3,-(a6)
		rts

lib29:
	dc.w	0			; no library calls
/*
 * Syntax: code$ A$,N
 */
codestr:
		move.l     (a6)+,d3
		move.w     d3,d1
		move.l     (a6)+,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		beq        codestr2
		subq.w     #1,d3
codestr1:
		move.b     (a2),d2
		add.b      d1,d2
		move.b     d2,(a2)+
		dbf        d3,codestr1
codestr2:
		rts

/*
 * Syntax: A=_aes in
 */
lib30:
	dc.w	0			; no library calls
aes_in:
		movem.l    a0-a2,-(a7)
		move.w     #0x00C9,d0
		trap       #2
		movem.l    (a7)+,a0-a2
		moveq      #0,d3
		cmpi.w     #0x00C9,d0
		beq.s      aes_in1
		moveq.l    #-1,d3
aes_in1:
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: uncode$ A$,N
 */
lib31:
	dc.w	0			; no library calls
uncodestr:
		move.l     (a6)+,d3
		move.w     d3,d1
		move.l     (a6)+,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		beq        uncodestr2
		subq.w     #1,d3
uncodestr1:
		move.b     (a2),d2
		sub.b      d1,d2
		move.b     d2,(a2)+
		dbf        d3,uncodestr1
uncodestr2:
		rts

/*
 * Syntax: A=file exist(F$)
 */
lib32:
	dc.w	0			; no library calls
file_exist:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		movea.l    d3,a2
		moveq      #0,d3
		move.w     (a2),d7
		beq        badfilename
		subq.w     #1,d7
file_exist1:
		cmpi.b     #'*',2(a2,d7.w)
		beq        badfilename
		dbf        d7,file_exist1
		lea.l      file_existname(pc),a1
		move.w     #(256/4)-1,d7
file_exist2:
		clr.l      (a1)+
		dbf        d7,file_exist2
		lea.l      file_existname(pc),a1
		move.w     (a2)+,d7
		subq.w     #1,d7
file_exist3:
		move.b     (a2)+,(a1)+
		dbf        d7,file_exist3
		clr.b      (a1)+
		move.w     #47,-(a7) /* Fgetdta */
		trap       #1
		addq.l     #2,a7
		lea.l      file_existdtaptr(pc),a3
		move.l     d0,(a3)
		lea.l      file_existdta(pc),a3
		move.l     a3,-(a7)
		move.w     #26,-(a7) /* Fsetdta */
		trap       #1
		addq.l     #6,a7
		move.w     #-1,-(a7)
		lea.l      file_existname(pc),a3
		move.l     a3,-(a7)
		move.w     #78,-(a7) /* Fsfirst */
		trap       #1
		addq.l     #8,a7
		tst.l      d0
		beq.s      file_exist4
		moveq.l    #-1,d0
file_exist4:
		not.l      d0
		move.l     d0,-(a7)
		move.l     file_existdtaptr(pc),-(a7)
		move.w     #26,-(a7) /* Fsetdta */
		trap       #1
		addq.l     #6,a7
		move.l     (a7)+,d3
		tst.l      d3
		beq.s      file_exist5
		lea.l      file_existdta(pc),a0
		move.l     26(a0),d3
file_exist5:
		clr.l      d2
		movem.l    (a7)+,a0-a6
		move.l     d3,-(a6)
		rts
badfilename:
		moveq.l    #E_badfilename,d0
		move.l     error(a5),a0
		jmp        (a0)

file_existname: ds.b 256
     ds.b 16 /* unused */
file_existdtaptr: ds.l 1
file_existdta: ds.b 44

lib33:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: A=_add cbound(A,I,L,U)
 */
lib34:
	dc.w	0			; no library calls
add_cbound:
		movem.l    (a6)+,d0-d3
		add.l      d2,d3
		cmp.l      d0,d3
		bgt.s      add_cbound1
		cmp.l      d1,d3
		blt.s      add_cbound2
		clr.l      d2
		move.l     d3,-(a6)
		rts
add_cbound1:
		move.l     d1,-(a6)
		clr.l      d2
		rts
add_cbound2:
		clr.l      d2
		move.l     d0,-(a6)
		rts

/*
 * Syntax: lset$ A$,B$
 */
lib35:
	dc.w	0			; no library calls
lsetstr:
		move.l     (a6)+,a2
		move.w     (a2)+,d1
		move.l     (a6)+,a1
		move.w     (a1)+,d0
		tst.w      d1
		beq.s      lsetstr2
		cmp.w      d1,d0
		bcs.s      lsetstr2
		subq.w     #1,d1
lsetstr1:
		move.b     (a1)+,(a2)+
		dbf        d1,lsetstr1
lsetstr2:
		rts

/*
 * Syntax: A=_sub cbound(A,I,L,U)
 */
lib36:
	dc.w	0			; no library calls
sub_cbound:
		movem.l    (a6)+,d0-d3
		sub.l      d2,d3
		cmp.l      d0,d3
		bgt.s      sub_cbound1
		cmp.l      d1,d3
		blt.s      sub_cbound2
		clr.l      d2
		move.l     d3,-(a6)
		rts
sub_cbound1:
		move.l     d1,-(a6)
		clr.l      d2
		rts
sub_cbound2:
		clr.l      d2
		move.l     d0,-(a6)
		rts



/*
 * Syntax: rset$ A$,B$
 */
lib37:
	dc.w	0			; no library calls
rsetstr:
		move.l     (a6)+,a2
		move.w     (a2)+,d1
		move.l     (a6)+,a1
		move.w     (a1)+,d0
		tst.w      d1
		beq.s      rsetstr2
		cmp.w      d1,d0
		bcs.s      rsetstr2
		adda.w     d0,a2
		adda.w     d1,a1
		subq.w     #1,d1
rsetstr1:
		move.b     -(a1),-(a2)
		dbf        d1,rsetstr1
rsetstr2:
		rts



/*
 * Syntax: A=_add ubound(A,I,U)
 */
lib38:
	dc.w	0			; no library calls
add_ubound:
		movem.l    (a6)+,d0-d2
		add.l      d1,d2
		cmp.l      d0,d2
		bgt.s      add_ubound1
		move.l     d2,-(a6)
		clr.l      d2
		rts
add_ubound1:
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax: st mouse on
 */
lib39:
	dc.w	0			; no library calls
st_mouse_on:
		movem.l    a0-a6,-(a7)
		moveq.l    #S_st_mouse_on,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax: A=_sub lbound(A,I,L)
 */
lib40:
	dc.w	0			; no library calls
sub_lbound:
		movem.l    (a6)+,d0-d2
		sub.l      d1,d2
		cmp.l      d0,d2
		blt.s      sub_lbound1
		move.l     d2,-(a6)
		clr.l      d2
		rts
sub_lbound1:
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax: st mouse off
 */
lib41:
	dc.w	0			; no library calls
st_mouse_off:
		movem.l    a0-a6,-(a7)
		moveq.l    #S_st_mouse_off,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax: X=odd(A)
 */
lib42:
	dc.w	0			; no library calls
odd:
		move.l     (a6)+,d0
		moveq.l    #-1,d3
		btst       #0,d0
		bne.s      odd1
		moveq.l    #0,d3
odd1:
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: st mouse colour COL_INDEX
 *         st mouse colour RED,GREEN,BLUE
 */
lib43:
	dc.w	0			; no library calls
st_mouse_colour:
		cmpi.b     #1,d0
		beq.s      st_mouse_colour2
		cmpi.w     #2,d0
		beq.s      st_mouse_colour1
		rts
st_mouse_colour1:
		move.l     (a6)+,d1
		andi.w     #31,d1
		move.l     (a6)+,d2
		andi.w     #31,d2
		lsl.w      #6,d2
		or.w       d2,d1
		move.l     (a6)+,d2
		andi.w     #31,d2
		lsl.w      #6,d2
		lsl.w      #5,d2
		or.w       d2,d1
		bra.s      st_mouse_colour3
st_mouse_colour2:
		move.l     (a6)+,d1
st_mouse_colour3:
		moveq.l    #S_st_mouse_color,d0
		trap       #5
		rts

st_mouse_colour_rgb: ds.w 4

/*
 * Syntax: X=even(A)
 */
lib44:
	dc.w	0			; no library calls
even:
		move.l     (a6)+,d0
		moveq.l    #-1,d3
		btst       #0,d0
		beq.s      even1
		moveq.l    #0,d3
even1:
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: _limit st mouse X1,Y1,X2,Y2
 *         _limit st mouse -1
 */
lib45:
	dc.w	0			; no library calls
limit_st_mouse:
		cmpi.b     #1,d0
		beq.s      limit_st_mouse2
		cmpi.w     #2,d0
		beq.s      limit_st_mouse1
		rts
limit_st_mouse1:
		move.l     (a6)+,d0
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d0,6(a0)
		move.l     (a6)+,d0
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d0,4(a0)
		move.l     (a6)+,d0
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d0,2(a0)
		move.l     (a6)+,d0
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d0,(a0)
		movem.l    d0-d7/a1-a6,-(a7)
		movem.w    (a0),d1-d4
		moveq.l    #-1,d5
		moveq.l    #S_limit_st_mouse,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a1-a6
		rts
limit_st_mouse2:
		move.l     (a6)+,d0
		movem.l    d0-d7/a1-a6,-(a7)
		moveq.l    #0,d5
		moveq.l    #S_limit_st_mouse,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a1-a6
		rts

limit_st_mouse_coords: ds.w 4

/*
 * Syntax: X=st mouse stat
 */
lib46:
	dc.w	0			; no library calls
st_mouse_stat:
		movem.l    a0-a6,-(a7)
		moveq.l    #S_st_mouse_stat,d0
		trap       #5
		move.w     d1,d3
		ext.l      d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: st mouse N
 */
lib47:
	dc.w	0			; no library calls
st_mouse:
		move.l     (a6)+,d3
		move.l     d3,d1
		moveq.l    #S_st_mouse,d0
		trap       #5
		rts

/*
 * Syntax: F$=_fileselect$(PATH$,TITLE$,BG_COLOUR,BTN_COLOUR_1,BTN_COLOUR_2,TXT_COLOUR_1,TXT_COLOUR_2)
 */
lib48:
	dc.w lib48_1-lib48
	dc.w lib48_2-lib48
	dc.w	0
fileselect:
		move.l     (a6)+,d3
		lea.l      fileselect_txtcolor2(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		lea.l      fileselect_txtcolor1(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		lea.l      fileselect_btncolor2(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		lea.l      fileselect_btncolor1(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		lea.l      fileselect_bgcolor(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		lea.l      fileselect_title(pc),a0
		move.l     d3,(a0)
		move.l     (a6)+,d3
		lea.l      fileselect_path(pc),a0
		move.l     d3,(a0)
		movem.l    a2-a5,-(a7)
		lea.l      fileselect_bgcolor(pc),a1
		movem.w    (a1)+,d1-d5
		movem.l    (a1)+,a2-a3
		moveq.l    #S_fileselect,d0
		trap       #5
		lea.l      fileselect_name(pc),a1
		tst.b      (a0)
		beq.s      fileselect4
		moveq      #0,d3
fileselect1:
		cmpi.w     #12,d3
		beq.s      fileselect2
		move.b     (a0)+,d0
		tst.b      d0
		beq.s      fileselect2
		cmpi.b     #' ',d0
		beq.s      fileselect1
		move.b     d0,(a1)+
		addq.w     #1,d3
		bra.s      fileselect1
fileselect2:
lib48_1:	jsr        L_malloc.l
		move.w     d3,(a0)+
		subq.w     #1,d3
		lea.l      fileselect_name(pc),a3
fileselect3:
		move.b     (a3)+,(a0)+
		dbf        d3,fileselect3
		movem.l    (a7)+,a2-a5
		move.l     a1,-(a6)
		rts
fileselect4:
		moveq      #0,d3
lib48_2:	jsr        L_malloc.l
		move.l     a0,-(a6)
		move.w     d3,(a0)+
		clr.b      (a0)
		movem.l    (a7)+,a2-a5
		rts

fileselect_bgcolor: ds.w 1
fileselect_btncolor1: ds.w 1
fileselect_btncolor2: ds.w 1
fileselect_txtcolor1: ds.w 1
fileselect_txtcolor2: ds.w 1
fileselect_title: ds.l 1
fileselect_path: ds.l 1
fileselect_name: ds.b 24

lib49:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: D=_jagpad direction(PORT)
 */
lib50:
	dc.w	0			; no library calls
jagpad_direction:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     (a6)+,d2
		cmpi.w     #2,d2
		bcc        jagpad_direction4
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		moveq      #0,d3
		subq.w     #1,d0
		beq.s      jagpad_direction1
		subq.w     #2,d0
		bne.s      jagpad_direction3
jagpad_direction1:
		movea.l    #0xffff9200,a0
		move.w     #0xFFFE,d0
		tst.w      d2
		beq.s      jagpad_direction2
		move.w     #0xFFEF,d0
jagpad_direction2:
		asl.w      #1,d2
		move.w     d0,2(a0)
		move.w     2(a0,d2.w),d3
		not.w      d3
		lsr.w      #8,d3
		andi.w     #15,d3
jagpad_direction3:
		move.l     d3,-(a6)
		movem.l    (a7)+,d1-d7/a0-a5
		clr.l      d2
		rts
jagpad_direction4:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)


lib51:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: F=_jagpad fire(PORT,BTN)
 */
lib52:
	dc.w	0			; no library calls
jagpad_fire:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     (a6)+,d5
		move.l     (a6)+,d2
		cmpi.w     #3,d5
		bcc        jagpad_fire5
		cmpi.w     #2,d2
		bcc        jagpad_fire5
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq.l    #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      jagpad_fire1
		subq.w     #2,d0
		bne.s      jagpad_fire4
jagpad_fire1:
		tst.w      d2
		beq.s      jagpad_fire2
		asl.w      #4,d5
jagpad_fire2:
		movea.l    #0xffff9200,a0
		move.w     #-1,d0
		bclr       d5,d0
		move.w     d0,2(a0)
		move.w     (a0),d1
		not.w      d1
		tst.w      d2
		beq.s      jagpad_fire3
		lsr.w      #2,d1
jagpad_fire3:
		lsr.w      #1,d1
		andi.w     #1,d1
		beq.s      jagpad_fire4
		moveq.l    #-1,d3
jagpad_fire4:
		move.l     d3,-(a6)
		movem.l    (a7)+,d1-d7/a0-a5
		clr.l      d2
		rts
jagpad_fire5:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)


lib53:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: X=_jagpad pause(PORT)
 */
lib54:
	dc.w	0			; no library calls
jagpad_pause:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     (a6)+,d2
		cmpi.w     #2,d3
		bcc        jagpad_pause5
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq.l    #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      jagpad_pause1
		subq.w     #2,d0
		bne.s      jagpad_pause4
jagpad_pause1:
		movea.l    #$ffff9200,a0
		move.w     #0xFFFE,d0
		tst.w      d2
		beq.s      jagpad_pause2
		move.w     #0xFFEF,d0
jagpad_pause2:
		move.w     d0,2(a0)
		move.w     (a0),d1
		not.w      d1
		tst.w      d2
		beq.s      jagpad_pause3
		ror.w      #2,d1
jagpad_pause3:
		andi.w     #1,d1
		beq.s      jagpad_pause4
		moveq.l    #-1,d3
jagpad_pause4:
		move.l     d3,-(a6)
		movem.l    (a7)+,d1-d7/a0-a5
		clr.l      d2
		rts
jagpad_pause5:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)


lib55:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: X=_jagpad option(PORT)
 */
lib56:
	dc.w	0			; no library calls
jagpad_option:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     (a6)+,d2
		cmpi.w     #2,d2
		bcc        jagpad_option5
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		moveq.l    #0,d3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      jagpad_option1
		subq.w     #2,d0
		bne.s      jagpad_option4
jagpad_option1:
		movea.l    #0xffff9200,a0
		move.w     #0xFFF7,d0
		tst.w      d2
		beq.s      jagpad_option2
		move.w     #0xFF7F,d0
jagpad_option2:
		move.w     d0,2(a0)
		move.w     (a0),d1
		not.w      d1
		tst.w      d2
		beq.s      jagpad_option3
		lsr.w      #2,d1
jagpad_option3:
		lsr.w      #1,d1
		andi.w     #1,d1
		beq.s      jagpad_option4
		moveq.l    #-1,d3
jagpad_option4:
		move.l     d3,-(a6)
		movem.l    (a7)+,d1-d7/a0-a5
		clr.l      d2
		rts
jagpad_option5:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)


lib57:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: K$=_jagpad key$(PORT)
 */
lib58:
	dc.w	0			; no library calls
jagpad_key:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     (a6)+,d2
		cmpi.w     #2,d2
		bcc        jagpad_key9
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     mch_cookie-entry(a3),d0
		subq.w     #1,d0
		beq.s      jagpad_key1
		cmpi.w     #2,d0
		bne.s      jagpad_key4
jagpad_key1:
		movea.l    #0xffff9200,a0
		lea.l      readmasks(pc),a1
		lea.l      readchars(pc),a2
		move.w     #0x0F00,d4
		tst.w      d2
		beq.s      jagpad_key2
		addq.l     #6,a1
		move.w     #0xF000,d4
jagpad_key2:
		moveq.l    #0,d7
jagpad_key3:
		move.w     (a1)+,d0
		move.w     d0,2(a0)
		move.w     2(a0),d1
		not.w      d1
		and.w      d4,d1
		tst.w      d1
		bne.s      jagpad_key5
		addq.w     #1,d7
		cmpi.w     #3,d7
		bne.s      jagpad_key3
jagpad_key4:
		lea.l      jagpad_str(pc),a4
		clr.l      (a4)
		move.l     d4,-(a6)
		movem.l    (a7)+,d1-d7/a0-a5
		move.w     #128,d2 ; returns string
		rts
jagpad_key5:
		tst.w      d2
		beq.s      jagpad_key6
		lsr.w      #4,d1
jagpad_key6:
		lsr.w      #8,d1
		andi.w     #15,d1
		moveq.l    #3,d6
jagpad_key7:
		btst       d6,d1
		bne.s      jagpad_key8
		dbf        d6,jagpad_key7
jagpad_key8:
		asl.w      #2,d7
		add.w      d6,d7
		move.b     0(a2,d7.w),d6
		lea.l      jagpad_str(pc),a4
		move.l     a4,-(a6)
		move.w     #1,(a4)+
		move.b     d6,(a4)+
		clr.b      (a4)
		move.l     a4,d0
		movem.l    (a7)+,d1-d7/a0-a5
		move.w     #128,d2 ; returns string
		rts
jagpad_key9:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)


jagpad_str: dc.w 0,0

readmasks: dc.w 0xfffd,0xfffb,0xfff7
		   dc.w 0xffdf,0xffbf,0xff7f
readchars: dc.b "*7410852#963"


/*
 * Syntax: _joysticks on
 */
lib59:
	dc.w	0			; no library calls
joysticks_on:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		lea        install_joyvec-entry(a0),a0
		jsr        (a0)
		rts


/*
 * Syntax: F=_joyfire(P)
 */
lib60:
	dc.w	0			; no library calls
joyfire:
		move.l     (a6)+,d0
		moveq.l    #0,d3
		subq.w     #1,d0
		cmpi.w     #2,d0
		bcc        joyfire1
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		lea        get_joyfire-entry(a0),a0
		jsr        (a0)
joyfire1:
		moveq.l    #0,d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: _joysticks off
 */
lib61:
	dc.w	0			; no library calls
joysticks_off:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		lea        restore_joyvec-entry(a0),a0
		jsr        (a0)
		rts


/*
 * Syntax: J=_joystick(P)
 */
lib62:
	dc.w	0			; no library calls
joystick:
		move.l     (a6)+,d0
		moveq.l    #0,d3
		subq.w     #1,d0
		cmpi.w     #2,d0
		bcc        joystick1
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		lea        get_joybutton-entry(a0),a0
		jsr        (a0)
joystick1:
		moveq.l    #0,d2
		move.l     d3,-(a6)
		rts

libex:
	ds.w 1
