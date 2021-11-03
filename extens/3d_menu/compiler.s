		.include "system.inc"
		.include "errors.inc"
		.include "sprites.inc"
		.include "window.inc"

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
	dc.w	libex-lib18

para:
	.dc.w 18           ; number of library routines
	.dc.w 18           ; number of extension commands
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

* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001: .dc.b 0,I,',',I,',',I,',',I,1,1,0 /* _fmenu init COL1,COL2,COL3,COL4 */
l002: .dc.b I,1,1,0 /* _fmenu select */
l003: .dc.b 0,1,1,0 /* _fmenu on */
l004: .dc.b I,1,1,0 /* _fmenu item */
l005: .dc.b 0,I,1           /* _fmenu$ off TITLE */
       dc.b   I,',',I,1,1,0 /* _fmenu$ off TITLE,ITEM */
l006: .dc.b I,1,1,0 /* _fmenu height */
l007: .dc.b 0,I,1           /* _fmenu$ on TITLE */
       dc.b   I,',',I,1,1,0 /* _fmenu$ on TITLE,ITEM */
l008: .dc.b I,1,1,0 /* unused */
l009: .dc.b 0,I,',',S,1           /* _fmenu$ TITLE,ITEM$ */
       dc.b   I,',',I,',',S,1,1,0 /* _fmenu$ TITLE,ITEM,ITEM$ */
l010: .dc.b I,1,1,0 /* unused */
l011: .dc.b 0,1,1,0 /* _fmenu kill */
l012: .dc.b I,1,1,0 /* unused */
l013: .dc.b 0,1,1,0 /* _fmenu freeze */
l014: .dc.b I,1,1,0 /* unused */
l015: .dc.b 0,I,',',I,1,1,0 /* _fmenu uncheck item TITLE,ITEM */
l016: .dc.b I,1,1,0 /* unused */
l017: .dc.b 0,I,',',I,1,1,0 /* _fmenu check item TITLE,ITEM */
l018: .dc.b I,I,',',I,',',I,',',I,',',S,1,1,0 /* _form alert(COL1,COL2,COL3,COL4,ALERT$) */
	.even

; Adaptation au Stos basic
entry:
	bra.w init

screenbuf: dc.l 0

getcookie:
		move.l     0x000005A0,d0
		beq.s      getcookie3
		movea.l    d0,a0
getcookie1:
		move.l     (a0)+,d1
		beq.s      getcookie3
		move.l     (a0)+,d0
		cmp.l      d3,d1
		bne.s      getcookie1
		rts
getcookie3:
		moveq      #0,d0
		rts

init:
		movem.l    d0-d6/a0-a6,-(a7)
		move.l     #0x5F56444F,d3 /* '_VDO' */
		bsr        getcookie
		cmpi.l     #0x00030000,d0
		beq.s      init1
		move.l     #$00008000,d7
		bra.s      init2
init1:
		move.l     #122880,d7
init2:
		movem.l    (a7)+,d0-d6/a0-a6
		lea        entry(pc),a2
		move.l     a0,screenbuf-entry(a2)
		adda.l     d7,a0
		cmpa.l     a1,a0
		bcc.s      init3
		
		movem.l    d0-d7/a0-a6,-(a7)
		move.l     #-1,-(a7)
		move.w     #35,-(a7) /* query trap #5 */
		move.w     #5,-(a7) /* Setexc */
		trap       #13
		addq.l     #8,a7
		movea.l    d0,a2
		move.l     screenbuf(pc),d0
		move.l     d0,-4(a2) /* set screenbuf ptr in window.lib */
		movem.l    (a7)+,d0-d7/a0-a6
		clr.w      d0
		lea        exit(pc),a2
		rts

exit:
		rts

init3:
		moveq.l    #1,d0
		rts

lib1:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu init COL1,COL2,COL3,COL4
*
fmenu_init:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		moveq.l    #W_fmenu_init,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib2:
		dc.w 0 /* no library calls */
*
* Syntax    :-   MN=_fmenu select
*
fmenu_select:
		movem.l    d1-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_select,d7
		trap       #3
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts

lib3:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu on
*
fmenu_on:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_on,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a6
		rts

lib4:
		dc.w 0 /* no library calls */
*
* Syntax    :-   ITEM=_fmenu item
*
fmenu_item:
		movem.l    d1-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_item,d7
		trap       #3
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts

lib5:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu$ off TITLE
*                _fmenu$ off TITLE,ITEM
*
fmenustr_off:
		movem.l    d0-d7/a0-a5,-(a7)
		subq.w     #1,d0
		beq.s      fmenustr_off1
		cmp.w      #1,d0
		bne.s      fmenustr_off3
fmenustr_off1:
		move.l     (a6)+,d1
		clr.l      d2
		tst.w      d0
		beq.s      fmenustr_off2
		move.l     d1,d2
		move.l     (a6)+,d1
fmenustr_off2:
		moveq.l    #W_fmenustr_off,d7
		trap       #3
fmenustr_off3:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib6:
		dc.w 0 /* no library calls */
*
* Syntax    :-   H=_fmenu height
*
fmenu_height:
		movem.l    d1-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_height,d7
		trap       #3
		movem.l    (a7)+,d1-d7/a0-a6
		clr.l      d2
		move.l     d0,-(a6)
		rts

lib7:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu$ on TITLE
*                _fmenu$ on TITLE,ITEM
*
fmenustr_on:
		movem.l    d0-d7/a0-a5,-(a7)
		subq.w     #1,d0
		beq.s      fmenustr_on1
		cmp.w      #1,d0
		bne.s      fmenustr_on3
fmenustr_on1:
		move.l     (a6)+,d1
		clr.l      d2
		tst.w      d0
		beq.s      fmenustr_on2
		move.l     d1,d2
		move.l     (a6)+,d1
fmenustr_on2:
		moveq.l    #W_fmenustr_on,d7
		trap       #3
fmenustr_on3:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib8:
		dc.w 0 /* no library calls */
		rts

lib9:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu$ TITLE,TITLE$
*                _fmenu$ TITLE,ITEM,ITEM$
*
* Note: in the compiler, d0 does not contain the number of
* parameters, but instead the entry# for the parameter list
*
fmenustr:
		movem.l    d0-d7/a0-a5,-(a7)
		subq.w     #1,d0
		beq.s      fmenustr1
		cmp.w      #1,d0
		bne.s      fmenustr3
fmenustr1:
		move.l     (a6)+,a0
		move.l     (a6)+,d1
		clr.l      d2
		tst.w      d0
		beq.s      fmenustr2
		move.l     d1,d2
		move.l     (a6)+,d1
fmenustr2:
		moveq.l    #W_fmenustr,d7
		trap       #3
fmenustr3:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib10:
		dc.w 0 /* no library calls */
		rts

lib11:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu kill
*
fmenu_kill:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_kill,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a6
		rts

lib12:
		dc.w 0 /* no library calls */
		rts

lib13:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu freeze
*
fmenu_freeze:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_freeze,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a6
		rts

lib14:
		dc.w 0 /* no library calls */
		rts

lib15:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu uncheck item TITLE,ITEM
*
fmenu_uncheck_item:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		moveq.l    #0,d3
		moveq.l    #W_fmenu_check_item,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib16:
		dc.w 0 /* no library calls */
		rts

lib17:
		dc.w 0 /* no library calls */
*
* Syntax    :-   _fmenu check item TITLE,ITEM
*
fmenu_check_item:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		moveq.l    #-1,d3
		moveq.l    #W_fmenu_check_item,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a5
		rts

lib18:
		dc.w 0 /* no library calls */
*
* Syntax    :-   BTN=_form alert(COL1,COL2,COL3,COL4,ALERT$)
*
form_alert:
		movem.l    d1-d7/a1-a5,-(a7)
		move.l     (a6)+,a0
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		move.l     (a6)+,d1
		moveq.l    #W_form_alert,d7
		trap       #3
		movem.l    (a7)+,d1-d7/a1-a5
		clr.l      d2
		move.l     d0,-(a6)
		rts

libex:
	dc.w 0
