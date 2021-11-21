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
l020:	.dc.b I,I,1,1,0           ; lpen x BUG: has no parameters
l021:	.dc.b 0,1,1,0             ; ide on
l022:	.dc.b I,I,1,1,0           ; lpen y BUG: has no parameters
l023:	.dc.b 0,1,1,0             ; ide off
l024:	.dc.b I,1,1,0             ; _nemesis
l025:	.dc.b 0,I,1,1,0           ; _set printer X
l026:	.dc.b I,1,1,0             ; _printer ready
l027:	.dc.b 0,S,',',I,1,0       ; file attr FNAME$,ATTR BUG end marker wrong
l028:	.dc.b I,1,1,0             ; kbshift
l029:	.dc.b 0,S,',',I,1,0       ; code$ A$,N BUG end marker wrong
l030:	.dc.b I,1,1,0             ; _aes in
l031:	.dc.b 0,S,',',I,1,0       ; uncode$ A$,N
l032:	.dc.b I,S,1,1,0           ; file exist(F$)
l033:	.dc.b 0,1,1,0
l034:	.dc.b I,I,',',I,',',I,',',I,1,0   ; _add cbound(A,I,L,U) BUG end marker wrong
l035:	.dc.b 0,S,',',S,1,1,0     ; lset$ A$,B$
l036:	.dc.b I,I,',',I,',',I,',',I,1,0   ; _sub cbound(A,I,L,U) BUG end marker wrong
l037:	.dc.b 0,S,',',S,1,1,0     ; rset$ A$,B$
l038:	.dc.b I,I,',',I,',',I,1,0  ; _add ubound(A,I,U) BUG end marker wrong
l039:	.dc.b 0,1,1,0             ; st mouse on
l040:	.dc.b I,I,',',I,',',I,1,0  ; _sub lbound(A,I,L) BUG end marker wrong
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

install_joyvec_offset: dc.l install_joyvec-entry /* 10266 */
get_joyfire_offset: dc.l get_joyfire-entry /* 102c4 */
restore_joyvec_offset: dc.l restore_joyvec-entry /* 102dc */
get_joybutton_offset: dc.l get_joybutton-entry /* 10312 */


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
		move.l     d3,d0
		lea.l      joybuf(pc),a0
		move.b     0(a0,d0.w),d3
		andi.l     #0x80,d3
		tst.l      d3
		beq.s      get_joyfire1
		moveq.l    #-1,d3
get_joyfire1:
		rts

restore_joyvec:
		movem.l    a0-a6,-(a7)
		lea.l      kbdvbase(pc),a0
		/* tst.l     (a0) */
		dc.w 0x0c90,0,0 /* XXX */
		beq.s      joysticks_off2
		movea.l    (a0),a1
		move.l     #0,(a0) /* XXX */
		move.l     oldjoyvec(pc),24(a1)
		lea.l      ($FFFFFC00).w,a1
joysticks_off1:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      joysticks_off1
		move.b     #8,2(a1) ; restore to normal mouse reporting
joysticks_off2:
		movem.l    (a7)+,a0-a6
		rts


get_joybutton:
		move.l     d3,d0
		lea.l      joybuf(pc),a0
		move.b     0(a0,d0.w),d3
		andi.l     #0x7F,d3
		rts


mch_cookie: ds.l 1
cpu_cookie: ds.l 1
vdo_cookie: ds.l 1
snd_cookie: ds.l 1
nemesis_cookie: ds.l 2
cookieid: ds.l 1
cookievalue: ds.l 1
falcon_mode: ds.w 1

getcookie:
		movea.l    #0x000005A0,a0
		lea.l      cookievalue(pc),a5
		clr.l      (a5)
		lea.l      cookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      getcookie3
		movea.l    d0,a0
		moveq      #0,d4
getcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      getcookie3
		cmp.l      d3,d0
		beq.s      getcookie2
		addq.w     #1,d4
		bra.s      getcookie1
getcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      getcookie3
		move.l     d1,(a5)
getcookie3:
		rts


init:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      mch_cookie(pc),a0
		clr.l      (a0)+
		clr.l      (a0)+
		clr.l      (a0)+
		move.l     #1,(a0)+
		lea.l      cookieid(pc),a1
		move.l     #0x5F4D4348,(a1)
		bsr.s      getcookie
		tst.l      d0
		beq.s      cold1
		lea.l      cookievalue(pc),a1
		lea.l      mch_cookie(pc),a0
		move.l     (a1),(a0)
cold1:
		lea.l      cookieid(pc),a1
		move.l     #0x5F435055,(a1)
		bsr.s      getcookie
		tst.l      d0
		beq.s      cold2
		lea.l      cookievalue(pc),a1
		lea.l      cpu_cookie(pc),a0
		move.l     (a1),(a0)
cold2:
		lea.l      cookieid(pc),a1
		move.l     #0x5F56444F,(a1)
		bsr        getcookie
		tst.l      d0
		beq.s      cold3
		lea.l      cookievalue(pc),a1
		lea.l      vdo_cookie(pc),a0
		move.l     (a1),(a0)
cold3:
		lea.l      cookieid(pc),a1
		move.l     #COOK_NEMESIS,(a1)
		bsr        getcookie
		tst.l      d0
		beq.s      cold5
		lea.l      cookievalue(pc),a1
		lea.l      nemesis_cookie(pc),a0
		move.l     #-1,(a0)
		move.l     (a1),4(a0)
cold5:


		move.w     vdo_cookie(pc),d6 /* WTF? */
		cmpi.w     #3,d6
		bra.s      warm1 /* WTF? */
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		lea.l      falcon_mode(pc),a0
		move.w     d0,(a0)
warm1:
		movem.l    (a7)+,d0-d7/a0-a6
		lea exit(pc),a2
		rts

exit:
		/* BUG: joyvec bot restored */
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #0x00C9,d0
		trap       #2
		cmpi.w     #0x00C9,d0
		beq.s      exit1
		lea.l      mch_cookie(pc),a0
		cmpi.w     #3,(a0)
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
		tst.l      (a0)
		beq        warm_reset
		/* tst.l      4(a0) */
		dc.w 0x0ca8,0,0,4 /* XXX */
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
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
warm_16mhz1:
		move.l     (a0),d1
		beq.s      warm_16mhz3
		cmp.l      d0,d1
		beq.s      warm_16mhz2
		addq.l     #8,a0
		bra.s      warm_16mhz1
warm_16mhz2:
		move.l     #0,4(a0)
warm_16mhz3:
		bra        warm_reset

warm_20mhz:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
warm_20mhz1:
		move.l     (a0),d1
		beq.s      warm_20mhz3
		cmp.l      d0,d1
		beq.s      warm_20mhz2
		addq.l     #8,a0
		bra.s      warm_20mhz1
warm_20mhz2:
		move.l     #1,4(a0)
warm_20mhz3:
		bset       #0,(0xFFFF8007).w
		bclr       #2,(0xFFFF8007).w
		move.l     #0x00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts

warm_24mhz:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD5,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
warm_24mhz1:
		move.l     (a0),d1
		beq.s      warm_24mhz3
		cmp.l      d0,d1
		beq.s      warm_24mhz2
		addq.l     #8,a0
		bra.s      warm_24mhz1
warm_24mhz2:
		move.l     #2,4(a0)
warm_24mhz3:
		bset       #0,(0xFFFF8007).w
		bclr       #2,(0xFFFF8007).w
		move.l     #0x00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts

warm_reset:
		movea.l    #0xFFFF8007,a0
		moveq.l    #0,d0
		bset       #0,d0
		bset       #2,d0
		bset       #5,d0
		move.b     d0,(a0)
		move.l     #0x00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #0x00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
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
		addq.l     #6,a7
		rts
docoldboot:
		clr.l      0x00000420.l ; clear memvalid flag /* XXX */
		lea.l      0x00000004,a0 /* XXX */
		movea.l    (a0),a0
		jmp        (a0)
		rts /* FIXME */

/*
 * Syntax: P_COOKIE=cookieptr
 */
lib2:
	dc.w	0			; no library calls
cookieptr:
		movem.l    a0-a6,-(a7)
		movea.l    #0x000005A0,a0
		move.l     (a0),d3
		movem.l    (a7)+,a0-a6
		moveq      #0,d2
		move.l     d3,-(a6)
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
		addq.l     #6,a7
		rts
dowarmboot:
		lea.l      0x00000004,a0 /* XXX */
		movea.l    (a0),a0
		jmp        (a0)
		rts /* FIXME */

/*
 * Syntax: COOKIE_VAL=cookie(ID$)
 */
lib4:
	dc.w	0			; no library calls
cookie:
		move.l     (a6)+,a2
		cmpi.w     #4,(a2)
		beq.s      cookie0
		moveq      #0,d3
		moveq      #0,d2
		move.l     d3,-(a6)
		rts
cookie0:
		movem.l    a0-a6,-(a7)
		move.w     (a2),d3
		addq.l     #2,a2
		lea.l      ccookieid(pc),a1
		subq.w     #1,d3
cookie1:
		move.b     (a2)+,(a1)+
		dbf        d3,cookie1
		pea.l      cgetcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		tst.l      d0
		beq.s      cookie2
		lea.l      ccookievalue(pc),a1
		move.l     (a1),d3
		bra.s      cookie3
cookie2:
		move.l     d0,d3
cookie3:
		lea.l      ccookieid(pc),a1
		cmpi.l     #0x5F435055,(a1) /* '_CPU' */
		bne.s      cookie4
		andi.l     #255,d3 /* WTF */
		addi.l     #68000,d3
cookie4:
		moveq      #0,d2
		move.l     d3,-(a6)
		rts

cgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      ccookievalue(pc),a5
		clr.l      (a5)
		lea.l      ccookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      cgetcookie3
		movea.l    d0,a0
		moveq      #0,d4
cgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      cgetcookie3
		cmp.l      d3,d0
		beq.s      cgetcookie2
		addq.w     #1,d4
		bra.s      cgetcookie1
cgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      cgetcookie3
		move.l     d1,(a5)
cgetcookie3:
		rts

ccookieid: ds.l 1
ccookievalue: ds.l 1

/*
 * Syntax: caps on
 */
lib5:
	dc.w	0			; no library calls
caps_on:
		movem.l    a0-a6,-(a7)
		move.w     #16,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax: A$=_tos$
 */
lib6:
	dc.w lib6_1-lib6
	dc.w	0
tosstr:
		movem.l    a2-a6,-(a7)
		pea.l      get_tosvers(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		moveq.l    #5,d3
lib6_1:	jsr        L_malloc.l
		move.w     d3,(a0)+
		lea.l      tosver(pc),a2
		move.w     (a2),d0
		andi.l     #0x0FFF,d0
		move.l     d0,d2
		move.b     #' ',(a0)
		ror.w      #8,d0
		addi.b     #'0',d0
		move.b     d0,1(a0)
		move.b     #'.',2(a0)
		move.w     d2,d0
		andi.l     #0xF0,d0
		ror.w      #4,d0
		addi.b     #'0',d0
		move.b     d0,3(a0)
		andi.l     #15,d2
		addi.b     #'0',d2
		move.b     d2,4(a0)
		movem.l    (a7)+,a2-a6
		move.l     a1,-(a6)
		rts
get_tosvers:
		movea.l    #0x000004F2,a0
		movea.l    (a0),a0
		move.w     2(a0),d0
		andi.l     #0x00000FFF,d0 /* WTF */
		lea.l      tosver(pc),a0
		move.w     d0,(a0)
		rts

tosver: ds.w 1

/*
 * Syntax: caps off
 */
lib7:
	dc.w	0			; no library calls
caps_off:
		movem.l    a0-a6,-(a7)
		move.w     #0,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax: X=_phystop
 */
lib8:
	dc.w	0			; no library calls
phystop:
		movem.l    a0-a6,-(a7)
		pea.l      get_phystop(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      phystop_val(pc),a1
		move.l     (a1),d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		move.l     d3,-(a6)
		rts
get_phystop:
		lea.l      0x0000042E,a0 /* XXX */
		lea.l      phystop_val(pc),a1
		move.l     (a0),(a1)
		rts
phystop_val: ds.l 1

/*
 * Syntax: _cpuspeed N
 */
lib9:
	dc.w	0			; no library calls
cpuspeed:
		move.l     (a6)+,d3
		lea.l      cpu_setspeed(pc),a0
		move.l     d3,(a0)
		movem.l    d1-d7/a1-a6,-(a7)
		lea.l      pcookieid(pc),a1
		move.l     #0x5F4D4348,(a1) /* '_MCH' */
		pea.l      pgetcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a1-a6
		lea        pcookievalue(pc),a1
		tst.l      d0
		beq.s      cpuspeed0
		move.w     (a1),d0
		cmpi.w     #3,d0
		bne.s      cpuspeed0
		movem.l    d1-d7/a1-a6,-(a7)
		lea.l      pcookieid(pc),a1
		move.l     #COOK_NEMESIS,(a1)
		pea.l      pgetcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a1-a6
		tst.l      d0
		beq.s      cpuspeed1
		move.l     cpu_setspeed(pc),d3
		cmpi.l     #8,d3
		beq.s      cpuspeed2
		cmpi.l     #16,d3
		beq.s      cpuspeed3
		cmpi.l     #20,d3
		beq.s      cpuspeed4
		cmpi.l     #24,d3
		beq.s      cpuspeed5
cpuspeed0:
		rts
cpuspeed1:
		move.l     cpu_setspeed(pc),d3
		cmpi.l     #8,d3
		beq.s      cpuspeed2
		cmpi.l     #16,d3
		beq.s      cpuspeed3
		rts
cpuspeed2:
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set8(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		rts
cpuspeed3:
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set16(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		rts
cpuspeed4:
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set20(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		rts
cpuspeed5:
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set24(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
cpuspeed6:
		rts

cpuspeed_set8:
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
cpuspeed_set8_1:
		move.l     (a0),d1
		beq.s      cpuspeed_set8_3
		cmp.l      d0,d1
		beq.s      cpuspeed_set8_2
		addq.l     #8,a0
		bra.s      cpuspeed_set8_1
cpuspeed_set8_2:
		move.l     #0,4(a0)
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0x96,(a0)
cpuspeed_set8_3:
		movea.l    #0xFFFF8007,a0
		bclr       #0,(a0)
		rts

cpuspeed_set16:
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
cpuspeed_set16_1:
		move.l     (a0),d1
		beq.s      cpuspeed_set16_3
		cmp.l      d0,d1
		beq.s      cpuspeed_set16_2
		addq.l     #8,a0
		bra.s      cpuspeed_set16_1
cpuspeed_set16_2:
		move.l     #0,4(a0)
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0x96,(a0)
cpuspeed_set16_3:
		movea.l    #0xFFFF8007,a0
		bset       #0,(a0)
		rts

cpuspeed_set20:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
cpuspeed_set20_1:
		move.l     (a0),d1
		beq.s      cpuspeed_set20_3
		cmp.l      d0,d1
		beq.s      cpuspeed_set20_2
		addq.l     #8,a0
		bra.s      cpuspeed_set20_1
cpuspeed_set20_2:
		move.l     #1,4(a0)
cpuspeed_set20_3:
		bset       #0,(0xFFFF8007).w
		bclr       #2,(0xFFFF8007).w
		rts

cpuspeed_set24:
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD5,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0xD6,(a0)
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
cpuspeed_set24_1:
		move.l     (a0),d1
		beq.s      cpuspeed_set24_3
		cmp.l      d0,d1
		beq.s      cpuspeed_set24_2
		addq.l     #8,a0
		bra.s      cpuspeed_set24_1
cpuspeed_set24_2:
		move.l     #2,4(a0)
cpuspeed_set24_3:
		bset       #0,(0xFFFF8007).w
		bclr       #2,(0xFFFF8007).w
		rts

pgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      pcookievalue(pc),a5
		clr.l      (a5)
		lea.l      pcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      pgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
pgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      pgetcookie3
		cmp.l      d3,d0
		beq.s      pgetcookie2
		addq.w     #1,d4
		bra.s      pgetcookie1
pgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      pgetcookie3
		move.l     d1,(a5)
pgetcookie3:
		rts

pcookieid: ds.l 1
pcookievalue: ds.l 1

cpu_setspeed: ds.l 1
	ds.l 1 /* unused */

/*
 * Syntax: X=_memtop
 */
lib10:
	dc.w	0			; no library calls
memtop:
		movem.l    a0-a6,-(a7)
		pea.l      get_memtop(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      memtop_val(pc),a1
		move.l     (a1),d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		move.l     d3,-(a6)
		rts

get_memtop:
		lea.l      0x00000436,a0 /* XXX */
		lea.l      memtop_val(pc),a1
		move.l     (a0),(a1)
		rts

memtop_val: ds.l 1

/*
 * Syntax: _blitterspeed N
 */
lib11:
	dc.w	0			; no library calls
blitterspeed:
		move.l     (a6)+,d3
		lea.l      blitter_setspeed(pc),a0
		move.l     d3,(a0)
		movem.l    d1-d7/a1-a6,-(a7)
		lea.l      bcookieid(pc),a1
		move.l     #0x5F4D4348,(a1) /* '_MCH' */
		pea.l      bgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a1-a6
		lea.l      bcookievalue(pc),a1
		tst.l      d0
		beq.s      blitterspeed0
		move.w     (a1),d0
		cmpi.w     #3,d0
		bne.s      blitterspeed0
		movem.l    d0-d7/a1-a5,-(a7)
		pea.l      get_nemesis(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a1-a5
		lea.l      bcookievalue(pc),a0
		move.l     (a0),d7
		tst.l      d7
		beq.s      blitterspeed1
		bra.s      blitterspeed2 /* BUG: should do nothing, but sets 8Mhz */
blitterspeed0:
		rts
blitterspeed1:
		move.l     blitter_setspeed(pc),d3
		cmpi.l     #8,d3
		beq.s      blitterspeed2
		cmpi.l     #16,d3
		beq.s      blitterspeed3
		rts
blitterspeed2:
		movem.l    a0-a6,-(a7)
		pea.l      blitter_set8(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		rts
blitterspeed3:
		movem.l    a0-a6,-(a7)
		pea.l      blitter_set16(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
blitterspeed4:
		rts

blitter_set8:
		movea.l    #0xFFFF8007,a0
		bclr       #2,(a0)
		rts

blitter_set16:
		movea.l    #0xFFFF8007,a0
		bset       #2,(a0)
		rts

bgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      bcookievalue(pc),a5
		clr.l      (a5)
		lea.l      bcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      bgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
bgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      bgetcookie3
		cmp.l      d3,d0
		beq.s      bgetcookie2
		addq.w     #1,d4
		bra.s      bgetcookie1
bgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      bgetcookie3
		move.l     d1,(a5)
bgetcookie3:
		rts

bcookieid: ds.l 1
bcookievalue: ds.l 1

blitter_setspeed: ds.l 1

get_nemesis:
		movea.l    0x000005A0.l,a0 /* XXX */
		move.l     #COOK_NEMESIS,d0
get_nemesis1:
		move.l     (a0),d1
		beq.s      get_nemesis3
		cmp.l      d0,d1
		beq.s      get_nemesis2
		addq.l     #8,a0
		bra.s      get_nemesis1
get_nemesis2:
		lea.l      bcookievalue(pc),a1
		move.l     4(a0),(a1)
		rts
get_nemesis3:
		lea.l      bcookievalue(pc),a1
		move.l     #0,(a1)
		rts

/*
 * Syntax: B=_busmode
 */
lib12:
	dc.w	0			; no library calls
busmode:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		lea.l      mcookieid(pc),a1
		move.l     #0x5F4D4348,(a1) /* '_MCH' */
		pea.l      mgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      mcookievalue(pc),a1
		tst.l      d0
		beq.s      busmode1
		move.w     (a1),d0
		cmpi.w     #3,d0
		bne.s      busmode1
		pea.l      get_busmode(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		move.l     d0,d3
busmode1:
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

get_busmode:
		movea.l    #0xFFFF8007,a0
		move.b     (a0),d0
		andi.l     #0x0000FFFF,d0 /* FIXME; useless */
		rts

mgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      mcookievalue(pc),a5
		clr.l      (a5)
		lea.l      mcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      mgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
mgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      mgetcookie3
		cmp.l      d3,d0
		beq.s      mgetcookie2
		addq.w     #1,d4
		bra.s      mgetcookie1
mgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      mgetcookie3
		move.l     d1,(a5)
mgetcookie3:
		rts

mcookieid: ds.l 1
mcookievalue: ds.l 1

/*
 * Syntax: _stebus
 */
lib13:
	dc.w	0			; no library calls
stebus:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      scookieid(pc),a1
		move.l     #0x5F4D4348,(a1)
		pea.l      sgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      scookievalue(pc),a1
		tst.l      d0
		beq.s      stebus1
		move.w     (a1),d0
		cmpi.w     #3,d0
		bne.s      stebus1
		pea.l      stebus_on(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
stebus1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
stebus_on:
		movea.l    #0xFFFF8007,a0
		bclr       #5,(a0)
		rts

sgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      scookievalue(pc),a5
		clr.l      (a5)
		lea.l      scookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      sgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
sgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      sgetcookie3
		cmp.l      d3,d0
		beq.s      sgetcookie2
		addq.w     #1,d4
		bra.s      sgetcookie1
sgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      sgetcookie3
		move.l     d1,(a5)
sgetcookie3:
		rts

scookieid: ds.l 1
scookievalue: ds.l 1

/*
 * Syntax: X=paddle x(P)
 */
lib14:
	dc.w	0			; no library calls
paddle_x:
		move.l     (a6)+,d3
		andi.l     #0x0000007F,d3 /* FIXME useless */
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		lea.l      paddlex_port(pc),a0
		move.w     d3,(a0)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      pxgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      pxcookievalue(pc),a1
		tst.l      d0
		beq.s      paddle_x2
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      paddle_x1
		cmpi.w     #3,d6
		bne.s      paddle_x2
paddle_x1:
		moveq.l    #0,d3
		move.w     paddlex_port(pc),d0
		tst.w      d0
		bmi.s      paddle_x2
		cmpi.w     #3,d0
		bgt.s      paddle_x2
		asl.w      #2,d0
		movea.l    #$00FF9210,a0 /* XXX */
		move.b     1(a0,d0.w),d3
paddle_x2:
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

paddlex_port: ds.w 1

pxgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      pxcookievalue(pc),a5
		clr.l      (a5)
		lea.l      pxcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      pxgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
pxgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      pxgetcookie3
		cmp.l      d3,d0
		beq.s      pxgetcookie2
		addq.w     #1,d4
		bra.s      pxgetcookie1
pxgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      pxgetcookie3
		move.l     d1,(a5)
pxgetcookie3:
		rts

pxcookieid: ds.l 1
pxcookievalue: ds.l 1

/*
 * Syntax: _falconbus
 */
lib15:
	dc.w	0			; no library calls
falconbus:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      fcookieid(pc),a1
		move.l     #0x5F4D4348,(a1)
		pea.l      fgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      fcookievalue(pc),a1
		tst.l      d0
		beq.s      falconbus1
		move.w     (a1),d0
		cmpi.w     #3,d0
		bne.s      falconbus1
		pea.l      stebus_off(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
falconbus1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
stebus_off:
		movea.l    #0xFFFF8007,a0
		bset       #5,(a0)
		rts

fgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      fcookievalue(pc),a5
		clr.l      (a5)
		lea.l      fcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      fgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
fgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      fgetcookie3
		cmp.l      d3,d0
		beq.s      fgetcookie2
		addq.w     #1,d4
		bra.s      fgetcookie1
fgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      fgetcookie3
		move.l     d1,(a5)
fgetcookie3:
		rts

fcookieid: ds.l 1
fcookievalue: ds.l 1

/*
 * Syntax: Y=paddle y(P)
 */
lib16:
	dc.w	0			; no library calls
paddle_y:
		move.l     (a6)+,d3
		andi.l     #0x0000007F,d3 /* FIXME: useless */
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		lea.l      paddley_port(pc),a0
		move.w     d3,(a0)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      pygetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      pycookievalue(pc),a1
		tst.l      d0
		beq.s      paddle_y2
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      paddle_y1
		cmpi.w     #3,d6
		bne.s      paddle_y2
paddle_y1:
		moveq.l    #0,d3
		move.w     paddley_port(pc),d0
		tst.w      d0
		bmi.s      paddle_y2
		cmpi.w     #3,d0
		bgt.s      paddle_y2
		asl.w      #2,d0
		movea.l    #$00FF9212,a0 /* XXX */
		move.b     1(a0,d0.w),d3
paddle_y2:
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

paddley_port: ds.w 1

pygetcookie:
		movea.l    #0x000005A0,a0
		lea.l      pycookievalue(pc),a5
		clr.l      (a5)
		lea.l      pycookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      pygetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
pygetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      pygetcookie3
		cmp.l      d3,d0
		beq.s      pygetcookie2
		addq.w     #1,d4
		bra.s      pygetcookie1
pygetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      pygetcookie3
		move.l     d1,(a5)
pygetcookie3:
		rts

pycookieid: ds.l 1
pycookievalue: ds.l 1

/*
 * Syntax: _cpucache on
 */
lib17:
	dc.w	0			; no library calls
cpucache_on:
		movem.l    d0-d7/a0-a6,-(a7)
		move.l     #0x5F435055,(a1) /* BUG: a1 not set */
		pea.l      congetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		lea.l      concookievalue(pc),a1
		tst.l      d0
		beq.s      cpucache_on1
		move.l     (a1),d6
		cmpi.w     #30,d6
		bne.s      cpucache_on1
		pea.l      cache_on(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
cpucache_on1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
cache_on:
		move.l     #$00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #$00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		move.l     #$00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts

congetcookie:
		movea.l    #0x000005A0,a0
		lea.l      concookievalue(pc),a5
		clr.l      (a5)
		lea.l      concookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      congetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
congetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      congetcookie3
		cmp.l      d3,d0
		beq.s      congetcookie2
		addq.w     #1,d4
		bra.s      congetcookie1
congetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      congetcookie3
		move.l     d1,(a5)
congetcookie3:
		rts

concookieid: ds.l 1
concookievalue: ds.l 1

/*
 * Syntax: X=_cpucache stat
 */
lib18:
	dc.w	0			; no library calls
cpucache_stat:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		move.l     #0x5F435055,(a1) /* BUG: a1 not set */
		pea.l      csgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      cscookievalue(pc),a1
		tst.l      d0
		beq.s      cpucache_stat1
		move.l     (a1),d6
		cmpi.w     #30,d6
		bne.s      cpucache_stat1
		pea.l      cache_get(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      cache_val(pc),a0
		move.l     (a0),d3
cpucache_stat1:
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
cache_get:
		dc.w 0x4e7a,2 /* movec      cacr,d0 */
		lea        cache_val(pc),a0
		move.l     d0,(a0)
		rts

cache_val: ds.l 1

csgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      cscookievalue(pc),a5
		clr.l      (a5)
		lea.l      cscookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      csgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
csgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      csgetcookie3
		cmp.l      d3,d0
		beq.s      csgetcookie2
		addq.w     #1,d4
		bra.s      csgetcookie1
csgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      csgetcookie3
		move.l     d1,(a5)
csgetcookie3:
		rts

cscookieid: ds.l 1
cscookievalue: ds.l 1

/*
 * Syntax: _cpucache off
 */
lib19:
	dc.w	0			; no library calls
cpucache_off:
		movem.l    d0-d7/a0-a6,-(a7)
		move.l     #0x5F435055,(a1) /* BUG: a1 not set */
		pea.l      coffgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		lea.l      coffcookievalue(pc),a1
		tst.l      d0
		beq.s      cpucache_off1
		move.l     (a1),d6
		cmpi.w     #30,d6
		bne.s      cpucache_off1
		pea.l      cache_off(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
cpucache_off1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
cache_off:
		move.l     #$00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		moveq.l    #0,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts

coffgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      coffcookievalue(pc),a5
		clr.l      (a5)
		lea.l      coffcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      coffgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
coffgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      coffgetcookie3
		cmp.l      d3,d0
		beq.s      coffgetcookie2
		addq.w     #1,d4
		bra.s      coffgetcookie1
coffgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      coffgetcookie3
		move.l     d1,(a5)
coffgetcookie3:
		rts

coffcookieid: ds.l 1
coffcookievalue: ds.l 1

/*
 * Syntax: X=lpen x
 */
lib20:
	dc.w	0			; no library calls
lpen_x:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		move.l     #$5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      lxgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      lxcookievalue(pc),a1
		tst.l      d0
		beq.s      lpen_x2
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      lpen_x1
		cmpi.w     #3,d6
		bne.s      lpen_x2
lpen_x1:
		move.w     $00FF9220,d3 /* XXX */
lpen_x2:
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

lxgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      lxcookievalue(pc),a5
		clr.l      (a5)
		lea.l      lxcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      lxgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
lxgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      lxgetcookie3
		cmp.l      d3,d0
		beq.s      lxgetcookie2
		addq.w     #1,d4
		bra.s      lxgetcookie1
lxgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      lxgetcookie3
		move.l     d1,(a5)
lxgetcookie3:
		rts

lxcookieid: ds.l 1
lxcookievalue: ds.l 1

/*
 * Syntax: ide on
 */
lib21:
	dc.w	0			; no library calls
ide_on:
		.IFNE 0 /* BUG: not implemented */
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		movem.l    a0-a6,-(a7)
		move.w     #0x007F,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		.ENDC
		rts

/*
 * Syntax: Y=lpen y
 */
lib22:
	dc.w	0			; no library calls
lpen_y:
		movem.l    d0-d2/d4-d7/a0-a6,-(a7)
		move.l     #$5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      lygetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		moveq.l    #0,d3
		lea.l      lycookievalue(pc),a1
		tst.l      d0
		beq.s      lpen_y2
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      lpen_y1
		cmpi.w     #3,d6
		bne.s      lpen_y2
lpen_y1:
		move.w     0x00FF9222,d3 /* XXX */
lpen_y2:
		movem.l    (a7)+,d0-d2/d4-d7/a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

lygetcookie:
		movea.l    #0x000005A0,a0
		lea.l      lycookievalue(pc),a5
		clr.l      (a5)
		lea.l      lycookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      lygetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
lygetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      lygetcookie3
		cmp.l      d3,d0
		beq.s      lygetcookie2
		addq.w     #1,d4
		bra.s      lygetcookie1
lygetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      lygetcookie3
		move.l     d1,(a5)
lygetcookie3:
		rts

lycookieid: ds.l 1
lycookievalue: ds.l 1

/*
 * Syntax: ide off
 */
lib23:
	dc.w	0			; no library calls
ide_off:
		.IFNE 0 /* BUG: not implemented */
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		movem.l    a0-a6,-(a7)
		move.w     #0x0080,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		.ENDC
		rts

/*
 * Syntax: NEMESIS_FLAG=_nemesis
 */
lib24:
	dc.w	0			; no library calls
nemesis:
		movem.l    d0-d6/a0-a6,-(a7)
		lea.l      ncookieid(pc),a1
		move.l     #COOK_NEMESIS,(a1)
		pea.l      ngetcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      ncookievalue(pc),a1
		moveq.l    #0,d7
		tst.l      d0
		beq.s      nemesis1
		moveq.l    #-1,d7
nemesis1:
		movem.l    (a7)+,d0-d6/a0-a6
		clr.l      d2
		move.l     d7,-(a6)
		rts

ngetcookie:
		movea.l    #0x000005A0,a0
		lea.l      ncookievalue(pc),a5
		clr.l      (a5)
		lea.l      ncookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      ngetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
ngetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      ngetcookie3
		cmp.l      d3,d0
		beq.s      ngetcookie2
		addq.w     #1,d4
		bra.s      ngetcookie1
ngetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      ngetcookie3
		move.l     d1,(a5)
ngetcookie3:
		rts

ncookieid: ds.l 1
ncookievalue: ds.l 1

/*
 * Syntax: _set printer X
 */
lib25:
	dc.w	0			; no library calls
set_printer:
		move.l     (a6)+,d3
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #33,-(a7) /* Setprt */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax: A=_printer ready
 */
lib26:
	dc.w	0			; no library calls
printer_ready:
		movem.l    a0-a6,-(a7)
		move.w     #0,-(a7)
		move.w     #8,-(a7) /* Bcostat */
		trap       #13
		addq.l     #4,a7
		move.w     d0,d3
		andi.l     #0x0000FFFF,d3 /* FIXME */
		ext.l      d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax: file attr FNAME$,ATTR
 */
lib27:
	dc.w	0			; no library calls
file_attr:
		move.l     (a6)+,d3
		lea.l      file_attrval(pc),a1
		move.w     d3,(a1)
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
		move.b     #0,(a1)+
		movem.l    a0-a6,-(a7)
		move.w     file_attrval(pc),-(a7)
		move.w     #1,-(a7)
		pea.l      file_attrname(pc)
		move.w     #67,-(a7) /* Fattrib */
		trap       #1
		lea.l      10(a7),a7
		movem.l    (a7)+,a0-a6
		tst.w      d0
		bmi.s      diskerror
		rts
diskerror:
		moveq.l    #E_diskerror,d0
		movea.l    error(a5),a0
		jmp        (a0)

file_attrval: ds.w 1
file_attrname: ds.b 256


/*
 * Syntax: X=kbshift
 */
lib28:
	dc.w	0			; no library calls
kbshift:
		movem.l    a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		andi.l     #0x000000FF,d0
		move.w     d0,d3
		movem.l    (a7)+,a0-a6
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
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		move.w     d3,d1
		move.l     (a6)+,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		subq.w     #1,d3 /* BUG: does not check for empty string */
codestr1:
		move.b     (a2),d2
		add.b      d1,d2
		move.b     d2,(a2)+
		dbf        d3,codestr1
		rts

/*
 * Syntax: A=_aes in
 */
lib30:
	dc.w	0			; no library calls
aes_in:
		movem.l    a0-a6,-(a7)
		move.w     #0x00C9,d0
		trap       #2
		movem.l    (a7)+,a0-a6
		cmpi.w     #0x00C9,d0
		beq.s      aes_in1
		clr.l      d2
		move.l     #-1,-(a6) /* FIXME */
		rts
aes_in1:
		clr.l      d2
		move.l     #0,-(a6)
		rts

/*
 * Syntax: uncode$ A$,N
 */
lib31:
	dc.w	0			; no library calls
uncodestr:
		move.l     (a6)+,d3
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		move.w     d3,d1
		move.l     (a6)+,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		subq.w     #1,d3 /* BUG: does not check for empty string */
uncodestr1:
		move.b     (a2),d2
		sub.b      d1,d2
		move.b     d2,(a2)+
		dbf        d3,uncodestr1
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
		cmpi.w     #1,(a2)
		blt        badfilename
		move.w     (a2),d7
		subq.w     #1,d7 /* BUG: does not check for empty string */
file_exist1:
		cmpi.b     #'*',2(a2,d7.w)
		beq        badfilename
		dbf        d7,file_exist1
		lea.l      file_existname(pc),a1
		move.w     #(256/4)-1,d7
file_exist2:
		clr.b      (a1)+ /* XXX */
		dbf        d7,file_exist2
		lea.l      file_existname(pc),a1
		move.w     (a2)+,d7
		subq.w     #1,d7
file_exist3:
		move.b     (a2)+,(a1)+
		dbf        d7,file_exist3
		move.b     #0,(a1)+
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
		nop /* XXX */
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
badfilename: /* FIXME */
		clr.l      d2
		movem.l    (a7)+,a0-a6
		move.l     d3,-(a6)
		rts
		.IFNE 0
		moveq.l    #E_badfilename,d0
		move.l     error(a5),a0
		jmp        (a0)
		.ENDC

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
		move.l     (a6)+,d3 /* FIXME */
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		lea.l      lset_srcstr(pc),a0
		move.l     a2,(a0)+
		move.w     d3,(a0)+
		move.l     (a6)+,d3 /* FIXME */
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		lea.l      lset_dststr(pc),a0
		move.l     a2,(a0)+
		move.w     d3,(a0)+
		lea.l      lset_dststr(pc),a0
		move.w     4(a0),d0
		move.w     10(a0),d1
		cmp.w      d1,d0
		bcs.s      lsetstr2
		subq.w     #1,d1
		movea.l    (a0),a2
		movea.l    6(a0),a1
lsetstr1:
		move.b     (a1)+,(a2)+
		dbf        d1,lsetstr1
lsetstr2:
		rts

lset_dststr: ds.b 6
lset_srcstr: ds.b 6

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
		move.l     (a6)+,d3 /* FIXME */
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		lea.l      rset_srcstr(pc),a0
		move.l     a2,(a0)+
		move.w     d3,(a0)+
		move.l     (a6)+,d3 /* FIXME */
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		lea.l      rset_dststr(pc),a0
		move.l     a2,(a0)+
		move.w     d3,(a0)+
		lea.l      rset_dststr(pc),a0
		move.w     4(a0),d0
		move.w     10(a0),d1
		cmp.w      d1,d0
		bcs.s      rsetstr2
		movea.l    (a0),a2
		adda.w     d0,a2
		movea.l    6(a0),a1
		adda.w     d1,a1
		subq.w     #1,d1
rsetstr1:
		move.b     -(a1),-(a2)
		dbf        d1,rsetstr1
rsetstr2:
		rts

rset_dststr: ds.b 6
rset_srcstr: ds.b 6


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
		move.l     (a6)+,d3
		andi.l     #31,d3
		move.l     (a6)+,d2
		andi.l     #31,d2
		rol.w      #6,d2
		move.l     (a6)+,d1
		andi.l     #31,d1
		rol.w      #6,d1
		rol.w      #5,d1
		or.w       d3,d2
		or.w       d2,d1
		andi.l     #0x0000FFFF,d1 /* FIXME: useless */
		bra.s      st_mouse_colour3
st_mouse_colour2:
		move.l     (a6)+,d1
		andi.l     #0x000000FF,d1
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
		move.w     (a0)+,d1
		move.w     (a0)+,d2
		move.w     (a0)+,d3
		move.w     (a0)+,d4
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
		movem.l    a2-a6,-(a7)
		lea.l      fileselect_bgcolor(pc),a1
		movem.w    (a1)+,d1-d5
		movem.l    (a1)+,a2-a3
		moveq.l    #S_fileselect,d0
		trap       #5
		lea.l      fileselect_name(pc),a1
		/* tst.b      (a0) */
		dc.w 0x0c10,0 /* XXX */
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
		movem.l    (a7)+,a2-a6
		move.l     a1,-(a6)
		rts
fileselect4:
		moveq      #0,d3
lib48_2:	jsr        L_malloc.l
		move.w     d3,(a0)+
		move.b     #0,(a0)+
		movem.l    (a7)+,a2-a6
		move.l     a1,-(a6)
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
		move.l     (a6)+,d3
		/* FIXME: range checks removed */
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    d1-d7/a0-a6,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      jgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a0-a6
		lea.l      jcookievalue(pc),a1
		tst.l      d0
		beq.s      jagpad_direction4
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      jagpad_direction1
		cmpi.w     #3,d6
		bne.s      jagpad_direction4
jagpad_direction1:
		movea.l    #0x00FF9200,a0 /* XXX */
		move.w     #0xFFFE,d0
		tst.w      d3
		beq.s      jagpad_direction2
		move.w     #0xFFEF,d0
jagpad_direction2:
		asl.w      #1,d3
		move.w     d0,2(a0)
		move.w     2(a0,d3.w),d3
		not.w      d3
		ror.w      #8,d3
		andi.l     #15,d3 /* FIXME */
jagpad_direction3:
		exg        d3,d0
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts
jagpad_direction4:
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     #0,-(a6)
		rts

jgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      jcookievalue(pc),a5
		clr.l      (a5)
		lea.l      jcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      jgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
jgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      jgetcookie3
		cmp.l      d3,d0
		beq.s      jgetcookie2
		addq.w     #1,d4
		bra.s      jgetcookie1
jgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      jgetcookie3
		move.l     d1,(a5)
jgetcookie3:
		rts

jcookieid: ds.l 1
jcookievalue: ds.l 1

lib51:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: F=_jagpad fire(PORT,BTN)
 */
lib52:
	dc.w	0			; no library calls
jagpad_fire:
		move.l     (a6)+,d3
		/* FIXME: range checks removed */
		andi.l     #15,d3 /* FIXME: useless */
		move.l     d3,d5
		move.l     (a6)+,d3
		andi.l     #15,d3
		movem.l    d1-d7/a0-a6,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      jfgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a0-a6
		lea.l      jfcookievalue(pc),a1
		tst.l      d0
		beq.s      jagpad_fire5
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      jagpad_fire1
		cmpi.w     #3,d6
		bne.s      jagpad_fire5
jagpad_fire1:
		tst.w      d3
		beq.s      jagpad_fire2
		asl.w      #4,d5
jagpad_fire2:
		movea.l    #0x00FF9200,a0 /* XXX */
		move.w     #-1,d0
		bclr       d5,d0
		move.w     d0,2(a0)
		move.w     ZERO(a0),d1
		not.w      d1
		tst.w      d3
		beq.s      jagpad_fire3
		ror.w      #2,d1
jagpad_fire3:
		ror.w      #1,d1
		andi.w     #1,d1
		moveq.l    #0,d3
		tst.w      d1
		beq.s      jagpad_fire4
		moveq.l    #-1,d3
jagpad_fire4:
		exg        d3,d0
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts
jagpad_fire5:
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     #0,-(a6)
		rts

jfgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      jfcookievalue(pc),a5
		clr.l      (a5)
		lea.l      jfcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      jfgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
jfgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      jfgetcookie3
		cmp.l      d3,d0
		beq.s      jfgetcookie2
		addq.w     #1,d4
		bra.s      jfgetcookie1
jfgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      jfgetcookie3
		move.l     d1,(a5)
jfgetcookie3:
		rts

jfcookieid: ds.l 1
jfcookievalue: ds.l 1

lib53:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: X=_jagpad pause(PORT)
 */
lib54:
	dc.w	0			; no library calls
jagpad_pause:
		move.l     (a6)+,d3
		/* FIXME: range checks removed */
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    d1-d7/a0-a6,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      jpgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a0-a6
		lea.l      jpcookievalue(pc),a1
		tst.l      d0
		beq.s      jagpad_pause5
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      jagpad_pause1
		cmpi.w     #3,d6
		bne.s      jagpad_pause5
jagpad_pause1:
		movea.l    #$00FF9200,a0 /* XXX */
		move.w     #0xFFFE,d0
		tst.w      d3
		beq.s      jagpad_pause2
		move.w     #0xFFEF,d0
jagpad_pause2:
		move.w     d0,2(a0)
		move.w     ZERO(a0),d1
		not.w      d1
		tst.w      d3
		beq.s      jagpad_pause3
		ror.w      #2,d1
jagpad_pause3:
		andi.w     #1,d1
		moveq.l    #0,d3
		tst.w      d1
		beq.s      jagpad_pause4
		moveq.l    #-1,d3
jagpad_pause4:
		exg        d3,d0
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts
jagpad_pause5:
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     #0,-(a6)
		rts

jpgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      jpcookievalue(pc),a5
		clr.l      (a5)
		lea.l      jpcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      jpgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
jpgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      jpgetcookie3
		cmp.l      d3,d0
		beq.s      jpgetcookie2
		addq.w     #1,d4
		bra.s      jpgetcookie1
jpgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      jpgetcookie3
		move.l     d1,(a5)
jpgetcookie3:
		rts

jpcookieid: ds.l 1
jpcookievalue: ds.l 1

lib55:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: X=_jagpad option(PORT)
 */
lib56:
	dc.w	0			; no library calls
jagpad_option:
		move.l     (a6)+,d3
		/* FIXME: range checks removed */
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    d1-d7/a0-a6,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      jogetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a0-a6
		lea.l      jocookievalue(pc),a1
		tst.l      d0
		beq.s      jagpad_option5
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      jagpad_option1
		cmpi.w     #3,d6
		bne.s      jagpad_option5
jagpad_option1:
		movea.l    #0x00FF9200,a0 /* XXX */
		move.w     #0xFFF7,d0
		tst.w      d3
		beq.s      jagpad_option2
		move.w     #0xFF7F,d0
jagpad_option2:
		move.w     d0,2(a0)
		move.w     ZERO(a0),d1
		not.w      d1
		tst.w      d3
		beq.s      jagpad_option3
		ror.w      #2,d1
jagpad_option3:
		ror.w      #1,d1
		andi.w     #1,d1
		moveq.l    #0,d3
		tst.w      d1
		beq.s      jagpad_option4
		moveq.l    #-1,d3
jagpad_option4:
		exg        d3,d0
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts
jagpad_option5:
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     #0,-(a6)
		rts

jogetcookie:
		movea.l    #0x000005A0,a0
		lea.l      jocookievalue(pc),a5
		clr.l      (a5)
		lea.l      jocookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      jogetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
jogetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      jogetcookie3
		cmp.l      d3,d0
		beq.s      jogetcookie2
		addq.w     #1,d4
		bra.s      jogetcookie1
jogetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      jogetcookie3
		move.l     d1,(a5)
jogetcookie3:
		rts

jocookieid: ds.l 1
jocookievalue: ds.l 1

lib57:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: K$=_jagpad key$(PORT)
 */
lib58:
	dc.w	0			; no library calls
jagpad_key:
		move.l     (a6)+,d3
		/* FIXME: range checks removed */
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    d1-d7/a0-a6,-(a7)
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     #0x5F4D4348,(a1) /* BUG: a1 not set */
		pea.l      jkgetcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d1-d7/a0-a6
		lea.l      jkcookievalue(pc),a1
		tst.l      d0
		beq.s      jagpad_key4
		move.w     (a1),d6
		cmpi.w     #1,d6
		beq.s      jagpad_key1
		cmpi.w     #3,d6
		bne.s      jagpad_key4
jagpad_key1:
		movea.l    #0x00FF9200,a0 /* XXX */
		lea.l      readmasks(pc),a1
		lea.l      readchars(pc),a2
		move.w     #0x0F00,d4
		tst.w      d3
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
		move.l     #0,(a4)
		move.l     a4,d0
		movem.l    (a7)+,d1-d7/a0-a6
		move.w     #128,d2 ; returns string
		move.l     d0,-(a6)
		rts
jagpad_key5:
		tst.w      d3
		beq.s      jagpad_key6
		ror.w      #4,d1
jagpad_key6:
		ror.w      #8,d1
		andi.l     #15,d1
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
		move.w     #1,(a4)
		move.b     d6,2(a4)
		move.b     #0,3(a4)
		move.l     a4,d0
		movem.l    (a7)+,d1-d7/a0-a6
		move.w     #128,d2 ; returns string
		move.l     d0,-(a6)
		rts

jkgetcookie:
		movea.l    #0x000005A0,a0
		lea.l      jkcookievalue(pc),a5
		clr.l      (a5)
		lea.l      jkcookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      jkgetcookie3
		movea.l    d0,a0
		moveq.l    #0,d4
jkgetcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.s      jkgetcookie3
		cmp.l      d3,d0
		beq.s      jkgetcookie2
		addq.w     #1,d4
		bra.s      jkgetcookie1
jkgetcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      jkgetcookie3
		move.l     d1,(a5)
jkgetcookie3:
		rts

jkcookieid: ds.l 1
jkcookievalue: ds.l 1

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
		move.l     install_joyvec_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		rts


/*
 * Syntax: F=_joyfire(P)
 */
lib60:
	dc.w	0			; no library calls
joyfire:
		move.l     (a6)+,d3
		andi.l     #3,d3
		subq.w     #1,d3
		bmi        joyfire1
		cmpi.w     #1,d3
		bgt        joyfire1
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     get_joyfire_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		moveq.l    #0,d2
		move.l     d3,-(a6)
		rts
joyfire1:
		moveq.l    #0,d2
		move.l     #0,-(a6)
		rts

/*
 * Syntax: _joysticks off
 */
lib61:
	dc.w	0			; no library calls
joysticks_off:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     restore_joyvec_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		rts


/*
 * Syntax: J=_joystick(P)
 */
lib62:
	dc.w	0			; no library calls
joystick:
		move.l     (a6)+,d3
		andi.l     #3,d3
		subq.w     #1,d3
		bmi        joystick1
		cmpi.w     #1,d3
		bgt        joystick1
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     get_joybutton_offset-entry(a0),d0
		adda.l     d0,a0
		jsr        (a0)
		moveq.l    #0,d2
		move.l     d3,-(a6)
		rts
joystick1:
		moveq.l    #0,d2
		move.l     #0,-(a6)
		rts

libex:
	ds.w 1

ZERO = 0
