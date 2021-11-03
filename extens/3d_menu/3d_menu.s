		.include "system.inc"
		.include "errors.inc"
		.include "sprites.inc"
		.include "window.inc"

		.text

        bra.w load

        dc.b $80
tokens:
		dc.b "_fmenu init",$80
		dc.b "_fmenu select",$81
		dc.b "_fmenu on",$82
		dc.b "_fmenu item",$83
		dc.b "_fmenu$ off",$84
		dc.b "_fmenu height",$85
		dc.b "_fmenu$ on",$86
		/* $87 unused */
		dc.b "_fmenu$",$88
		/* $89 unused */
		dc.b "_fmenu kill",$8a
		/* $8b unused */
		dc.b "_fmenu freeze",$8c
		/* $8d unused */
		dc.b "_fmenu uncheck item",$8e
		/* $8f unused */
		dc.b "_fmenu check item",$90
		dc.b "_form alert",$91
		dc.b "_fmenu cmds",$92

        dc.b 0
        even
jumps:  dc.w 19
		dc.l fmenu_init
		dc.l fmenu_select
		dc.l fmenu_on
		dc.l fmenu_item
		dc.l fmenustr_off
		dc.l fmenu_height
		dc.l fmenustr_on
		dc.l dummy
		dc.l fmenustr
		dc.l dummy
		dc.l fmenu_kill
		dc.l dummy
		dc.l fmenu_freeze
		dc.l dummy
		dc.l fmenu_uncheck_item
		dc.l dummy
		dc.l fmenu_check_item
		dc.l form_alert
		dc.l fmenu_cmds
		
welcome:
	dc.b 10,"ST(e)/TT/Falcon 030 3D Menus & Alerts v0.6 ",$bd," Anthony Hoskin. type '_fmenu cmds'",0
	dc.b 10,"ST(e)/TT/Falcon 030 3D Menus & Alerts v0.6 ",$bd," Anthony Hoskin. type '_fmenu cmds'",0
	.even

table: dc.l 0
returnpc: dc.l 0

x101b4: dc.w 0

mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0
mode: dc.l 0

load:
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts

cold:
		move.l     a0,table
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0 /* BUG: should not be masked */
		swap       d0
		lea.l      mode(pc),a0
		move.l     d0,(a0)
		lea.l      mch_cookie(pc),a0
		clr.l      (a0)+
		clr.l      (a0)+ /* vdo_cookie */
		move.l     #1,(a0)+ /* snd_cookie */
		lea.l      cookieid(pc),a1
		move.l     #0x5F4D4348,(a1) /* '_MCH' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold1
		lea.l      cookievalue(pc),a1
		lea.l      mch_cookie(pc),a0
		move.l     (a1),(a0)
cold1:
		lea.l      cookieid(pc),a1
		move.l     #0x5F56444F,(a1) /* '_VDO' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold2
		lea.l      cookievalue(pc),a1
		lea.l      vdo_cookie(pc),a0
		move.l     (a1),(a0)
cold2:
		lea.l      cookieid(pc),a1
		move.l     #0x5F534E44,(a1) /* '_SND' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold3
		lea.l      cookievalue(pc),a1
		lea.l      snd_cookie(pc),a0
		move.l     (a1),(a0)
cold3:
		move.l     a1,(a0)
		ALINE      #0
		lea.l      lineavars(pc),a1
		move.l     a0,(a1)
		lea.l      x13c7e(pc),a0
		move.w     #1,(a0)
		lea.l      x13c80(pc),a0
		move.w     #0,(a0)
		lea.l      x13c82(pc),a0
		move.w     #-1,(a0)
		lea.l      x13c84(pc),a0
		lea.l      x13c8a(pc),a1
		move.l     #-1,(a1)
		move.l     a1,(a0)
		lea.l      x13c88(pc),a0
		move.w     #0,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #S_f57,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		bsr.s      check_windowlib
		tst.w      d7
		bmi.s      cold4
		beq.s      cold4
		bra        windowlib_err
cold4:
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		rts

check_windowlib:
		movem.l    d0-d6/a0-a6,-(a7)
		movea.l    0x0000008C.l,a1 ; vector for trap #3
		suba.l     #windowlib_id_end-windowlib_id,a1
		lea.l      windowlib_id(pc),a0
		moveq.l    #windowlib_id_end-windowlib_id-1,d7
check_windowlib1:
		cmpm.b     (a0)+,(a1)+
		bne.s      check_windowlib2
		dbf        d7,check_windowlib1
check_windowlib2:
		movem.l    (a7)+,d0-d6/a0-a6
		rts

windowlib_id:
	dc.b "FALCON 030 STOS Window 4.6",0,0
windowlib_id_end:

warm:
		rts

x10318: /* FIXME: unused */
		movem.l    a0-a6,-(a7)
		lea.l      x13c7e(pc),a0
		move.w     #1,(a0)
		lea.l      x13c80(pc),a0
		move.w     #0,(a0)
		lea.l      x13c82(pc),a0
		move.w     #-1,(a0)
		lea.l      x13c84(pc),a0
		lea.l      x13c8a(pc),a1
		move.l     #-1,(a1)
		move.l     a1,(a0)
		lea.l      x13c88(pc),a0
		move.w     #0,(a0)
		moveq.l    #S_f57,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		rts

* BUG: clobbers lots of registers it shouldn't
* FIXME: rewrite
getcookie:
		/* movea.l    #0x000005A0.l,a0 */
		dc.w 0x207c,0,0x5a0 /* XXX */
		lea.l      cookievalue(pc),a5
		clr.l      (a5)
		lea.l      cookieid(pc),a1
		move.l     (a1),d3
		move.l     (a0),d0
		tst.l      d0
		beq.s      getcookie3
		movea.l    d0,a0
		clr.l      d4
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

addrofbank: /* FIXME: unused */
		movem.l    a0-a2,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_addrofbank(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a2
		rts

malloc: /* FIXME: unused */
		movea.l    table(pc),a0
		movea.l    sys_demand(a0),a0
		jsr        (a0)
		rts
	
dummy:
		move.l     (a7)+,returnpc
		bra.s      syntax
		clr.l      d0
		bra.s      goerror

syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
illfunc:
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0
		bra.s      goerror
subscripterror:
		moveq.l    #E_subscript,d0
		bra.s      goerror
		nop
diskerror:
		moveq.l    #E_diskerror,d0

goerror:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      mode(pc),a0
		move.w     (a0),d0
		cmpi.w     #2,d0
		beq.s      goerror1
		move.w     d0,-(a7)
		move.l     #-1,-(a7)
		move.l     #-1,-(a7)
		move.w     #5,-(a7) /* Setscreen */
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

windowlib_err:
		moveq.l    #0,d0
		bra.s      printerr
fmenu_err:
		moveq.l    #1,d0
		bra.s      printerr
		nop /* XXX */

printerr:
		movem.l    d0-d7/a0-a6,-(a7)
		tst.w      d0
		beq.s      printerr1
		lea.l      mode(pc),a0
		move.w     (a0),d0
		cmpi.w     #2,d0
		beq.s      printerr1
		move.w     d0,-(a7)
		move.l     #-1,-(a7)
		move.l     #-1,-(a7)
		move.w     #5,-(a7) /* Setscreen */
		trap       #14
		lea.l      12(a7),a7
		moveq.l    #S_initmode,d0
		trap       #5
		moveq.l    #W_initmode,d7
		trap       #3
printerr1:
		movem.l    (a7)+,d0-d7/a0-a6
		lea.l      errormsgs(pc),a2
		lsl.w      #1,d0
printerr2:
		/* tst.b     (a2)+ */
		dc.w 0x0c1a,0 /* XXX */
		bne.s      printerr2
		subq.w     #1,d0
		bpl.s      printerr2
		movea.l    table(pc),a1
		movea.l    sys_err2(a1),a1
		jmp        (a1)

errormsgs:
		dc.b 0
		dc.b 13,10,C_inverse
		dc.b "  Extension ERROR - the 'WINDO102.BIN' file version in the STOS folder   ",13,10
		dc.b "  is incompatible with the ST(e)/TT/Falcon 030 MENUS & ALERTS Manager    ",13,10
		dc.b "  Extension v0.6. Please re-boot your system with the version 4.6        ",13,10
		dc.b "  'WINDO102.BIN' file in the STOS folder.                                ",C_normal,13,10,0
		dc.b 13,10,C_inverse
		dc.b "  Extension ERROR - the 'WINDO102.BIN' file version in the STOS folder   ",13,10
		dc.b "  is incompatible with the ST(e)/TT/Falcon 030 MENUS & ALERTS Manager    ",13,10
		dc.b "  Extension v0.6. Please re-boot your system with the version 4.6        ",13,10
		dc.b "  'WINDO102.BIN' file in the STOS folder.                                ",C_normal,13,10,0
		dc.b "Menu not initialised. _fmenu init required.",0
		dc.b "Menu not initialised. _fmenu init required.",0
		.even

*
* Syntax    :-   _fmenu init COL1,COL2,COL3,COL4
*
fmenu_init:
		move.l     (a7)+,returnpc
		cmp.w      #4,d0
		bne        syntax
		bsr        getinteger
		lea.l      menucolors+6(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      menucolors+4(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      menucolors+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      menucolors(pc),a0
		move.w     d3,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menucolors(pc),a0
		movem.w    (a0)+,d1-d4
		moveq.l    #W_fmenu_init,d7
		trap       #3
		movem.l    (a7)+,d0-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)
menucolors: ds.w 4

*
* Syntax    :-   MN=_fmenu select
*
fmenu_select:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		moveq.l    #W_fmenu_select,d7
		trap       #3
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

*
* Syntax    :-   _fmenu on
*
fmenu_on:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		moveq.l    #W_fmenu_on,d7
		trap       #3
		movem.l    (a7)+,d1-d7/a0-a6
		tst.l      d0
		bne        fmenu_err
		movea.l    returnpc(pc),a0
		jmp        (a0)

*
* Syntax    :-   ITEM=_fmenu item
*
fmenu_item:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		moveq.l    #W_fmenu_item,d7
		trap       #3
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

*
* Syntax    :-   _fmenu$ TITLE,TITLE$
*                _fmenu$ TITLE,ITEM,ITEM$
*
fmenustr:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		beq.s      fmenustr1
		cmp.w      #2,d0
		beq.s      fmenustr2
		bra        syntax
fmenustr1:
		bsr        getstring
		lea.l      fmenustr_str(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustr_item(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustr_title(pc),a0
		move.w     d3,(a0)
		movea.l    fmenustr_str(pc),a0
		move.w     fmenustr_title(pc),d1
		move.w     fmenustr_item(pc),d2
		moveq.l    #W_fmenustr,d7
		trap       #3
		tst.l      d0
		beq.s      fmenustr3
		cmpi.l     #-1,d0
		beq        fmenu_err
		cmpi.l     #-2,d0
		beq        subscripterror
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenustr2:
		bsr        getstring
		lea.l      fmenustr_str(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustr_title(pc),a0
		move.w     d3,(a0)
		clr.w      fmenustr_item-fmenustr_title(a0)
		movea.l    fmenustr_str(pc),a0
		move.w     fmenustr_title(pc),d1
		move.w     fmenustr_item(pc),d2
		moveq.l    #W_fmenustr,d7
		trap       #3
		tst.l      d0
		beq.s      fmenustr3
		cmpi.l     #-1,d0
		beq        fmenu_err
		cmpi.l     #-2,d0
		beq        subscripterror
fmenustr3:
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenustr_str: dc.l 0
fmenustr_title: dc.w 0
fmenustr_item: dc.w 0

*
* Syntax    :-   _fmenu$ off TITLE
*                _fmenu$ off TITLE,ITEM
*
fmenustr_off:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		beq.s      fmenustr_off1
		cmp.w      #1,d0
		beq.s      fmenustr_off2
		bra        syntax
fmenustr_off1:
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustroff_item(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustroff_title(pc),a0
		move.w     d3,(a0)
		move.w     fmenustroff_title(pc),d1
		move.w     fmenustroff_item(pc),d2
		moveq.l    #W_fmenustr_off,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenustr_off2:
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustroff_title(pc),a0
		move.w     d3,(a0)
		clr.w      fmenustroff_item-fmenustroff_title(a0)
		move.w     fmenustroff_title(pc),d1
		move.w     fmenustroff_item(pc),d2
		moveq.l    #W_fmenustr_off,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenustroff_title: dc.w 0
fmenustroff_item: dc.w 0

*
* Syntax    :-   H=_fmenu height
*
fmenu_height:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		moveq.l    #W_fmenu_height,d7
		trap       #3
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

*
* Syntax    :-   _fmenu$ on TITLE
*                _fmenu$ on TITLE,ITEM
*
fmenustr_on:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		beq.s      fmenustr_on1
		cmp.w      #1,d0
		beq.s      fmenustr_on2
		bra        syntax
fmenustr_on1:
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustron_item(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustron_title(pc),a0
		move.w     d3,(a0)
		move.w     fmenustron_title(pc),d1
		move.w     fmenustron_item(pc),d2
		moveq.l    #W_fmenustr_on,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenustr_on2:
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenustron_title(pc),a0
		move.w     d3,(a0)
		clr.w      2(a0)
		move.w     fmenustron_title(pc),d1
		move.w     fmenustron_item(pc),d2
		moveq.l    #W_fmenustr_on,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenustron_title: dc.w 0
fmenustron_item: dc.w 0

*
* Syntax    :-   _fmenu kill
*
fmenu_kill:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		moveq.l    #W_fmenu_kill,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)

*
* Syntax    :-   _fmenu freeze
*
fmenu_freeze:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		moveq.l    #W_fmenu_freeze,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)

*
* Syntax    :-   _fmenu uncheck item TITLE,ITEM
*
fmenu_uncheck_item:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		beq.s      fmenu_uncheck_item1
		bra        syntax
fmenu_uncheck_item1:
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenu_unchk_item(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenu_unchk_title(pc),a0
		move.w     d3,(a0)
		move.w     fmenu_unchk_title(pc),d1
		move.w     fmenu_unchk_item(pc),d2
		moveq.l    #0,d3
		moveq.l    #W_fmenu_check_item,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenu_unchk_title: dc.w 0
fmenu_unchk_item: dc.w 0

*
* Syntax    :-   _fmenu check item TITLE,ITEM
*
fmenu_check_item:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		beq.s      fmenu_check_item1
		bra        syntax
fmenu_check_item1:
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenu_chk_item(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3 /* FIXME: should be handled by trap */
		lea.l      fmenu_chk_title(pc),a0
		move.w     d3,(a0)
		move.w     fmenu_chk_title(pc),d1
		move.w     fmenu_chk_item(pc),d2
		moveq.l    #-1,d3
		moveq.l    #W_fmenu_check_item,d7
		trap       #3
		movea.l    returnpc(pc),a0
		jmp        (a0)
fmenu_chk_title: dc.w 0
fmenu_chk_item: dc.w 0

*
* Syntax    :-   BTN=_form alert(COL1,COL2,COL3,COL4,ALERT$)
*
form_alert:
		move.l     (a7)+,returnpc
		cmp.w      #5,d0
		bne        syntax
		bsr        getstring
		lea.l      form_alert_params+8(pc),a0
		move.l     d3,(a0)
		bsr        getinteger
		lea.l      form_alert_params+6(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      form_alert_params+4(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      form_alert_params+2(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		lea.l      form_alert_params(pc),a0
		move.w     d3,(a0)
		movem.l    d1-d7/a1-a6,-(a7)
		lea.l      form_alert_params(pc),a1
		movem.w    (a1)+,d1-d4
		movea.l    (a1)+,a0
		moveq.l    #W_form_alert,d7
		trap       #3
		movem.l    (a7)+,d1-d7/a1-a6
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
		/* FIXME: dead code */
		moveq.l    #0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
form_alert_params: ds.w 4
	ds.l 1

fmenu_cmds:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		lea.l      fmenu_hlp(pc),a0
fmenu_cmds1:
		tst.b      (a0)
		beq.s      fmenu_cmds4
		movem.l    a0-a6,-(a7)
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,a0-a6
fmenu_cmds2:
		tst.b      (a0)+
		bne.s      fmenu_cmds2
fmenu_cmds3:
		movem.l    a0-a6,-(a7)
		move.w     #255,-(a7)
		move.w     #6,-(a7) /* Crawio */
		trap       #1
		addq.l     #4,a7
		bclr       #5,d0
		movem.l    (a7)+,a0-a6
		tst.l      d0
		beq.s      fmenu_cmds3
		cmpi.b     #'Y',d0
		beq.s      fmenu_cmds1
		cmpi.b     #'N',d0
		bne.s      fmenu_cmds3
fmenu_cmds4:
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

		.data

fmenu_hlp:
                dc.b 13,10
                dc.b 'Quick command reference for the ST(e)/TT/Falcon 030 3D Menus & Alerts Manager',13,10,10
                dc.b '          ',$bd,' 1997, 1998 Anthony Hoskin.',13,10
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
                dc.b 'Command   :-   _fmenu cmds',13,10
                dc.b 'Action    :-   Lists this command reference.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu init COL1,COL2,COL3,COL4',13,10
                dc.b 'Action    :-   This  command  assigns  the  menu  strip  3D  colours   and',13,10
                dc.b '               initialises  the  extensions  internal  variables  for  the',13,10
                dc.b '               ST(e)/TT/Falcon 3D Menu strip for the CURRENT video mode.',13,10
                dc.b 13,10
                dc.b 'Important :-   This  MUST be the first menu command the  program  invokes,',13,10
                dc.b '               since  all other _fmenu commands will return error  reports',13,10
                dc.b '               if the menu strip is not valid.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '               COL1      Assigns  the  fill colour [0 - 15] for  the  menu',13,10
                dc.b '                         strip.  [In 256 colour video modes only the LOWER',13,10
                dc.b '                         16 colours are available to the 3D Menu strip].',13,10
                dc.b 13,10
                dc.b '               COL2      Assigns the colour [0 - 15] of the LEFT side  and',13,10
                dc.b '                         TOP edge border of the 3D menu strip.',13,10
                dc.b 13,10
                dc.b '               COL3      Assigns the colour [0 - 15] of the RIGHT side and',13,10
                dc.b '                         BOTTOM edge border of the 3D menu strip.',13,10
                dc.b 13,10
                dc.b '               COL4      Assigns  the  colour [0 - 15] to the  Menu  texts',13,10
                dc.b '                         which  are  currently enabled by the  _fmenu$  on',13,10
                dc.b '                         command.  [By  default ALL menu titles and  items',13,10
                dc.b '                         are  enabled  until disabled by the  _fmenu$  off',13,10
                dc.b '                         command].',13,10
                dc.b 13,10
                dc.b '               COL2 \    Are  also  assigned as the text colours  for  the',13,10
                dc.b '               COL3 /    disabled menu title(s)/item(s).',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   H=_fmenu height',13,10
                dc.b 'Action    :-   Returns  the height (depth) of the current 3D  menu  strip.',13,10
                dc.b '               This command is useful for determining the height of the 3D',13,10
                dc.b '               menu  strip so that your program may calculate the  Yorigin',13,10
                dc.b "               for its drawing of graphics etc such as they don't encroach",13,10
                dc.b '               the screen area of the menu strip.  The value returned will',13,10
                dc.b '               depend  upon the current screen resolution and is as  shown',13,10
                dc.b '               below:-',13,10
                dc.b 13,10
                dc.b '               H                   Screen resolution',13,10
                dc.b 13,10
                dc.b '               12        320x200   320x240   640x200   640x240   768x240',13,10
                dc.b '               24        320x400   320x480   640x400   640x480   768x480',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu$ TITLE,TITLE$',13,10
                dc.b '               _fmenu$ TITLE,ITEM,ITEM$',13,10
                dc.b 'Action    :-   Define menu titles/options.',13,10
                dc.b 13,10
                dc.b '               _fmenu$ TITLE,TITLE$     assigns  the string TITLE$ to  the',13,10
                dc.b '                                        menu  title  TITLE.   This   title',13,10
                dc.b '                                        string is displayed in the 3D menu',13,10
                dc.b '                                        strip.',13,10
                dc.b 13,10
                dc.b '               _fmenu$ TITLE,ITEM,ITEM$ assigns  the string ITEM$  to  the',13,10
                dc.b '                                        menu titles TITLE drop-down.  This',13,10
                dc.b '                                        item string is displayed in the 3D',13,10
                dc.b '                                        menu drop-down.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '               Currently  the parameters range as shown below:-',13,10
                dc.b 13,10
                dc.b '               TITLE     1 -  6    The  upper  limits are limited  by  the',13,10
                dc.b '                                   size of the screen save buffer used  by',13,10
                dc.b '               ITEM      1 - 10    the menu drop-downs.  By using internal',13,10
                dc.b '                                   buffers  the  program itself  does  not',13,10
                dc.b '                                   need to restore the screen after a menu',13,10
                dc.b '                                   drop-down has occurred.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '               If TITLE or ITEM are out of range then the error "Subscript',13,10,
                dc.b '               out  of range" is generated.  [Normally this error  message',13,10
                dc.b '               relates to an unDIMensioned string,  but it is applied here',13,10
                dc.b '               because the strings for the _fmenu$ command are effectively',13,10
                dc.b '               pre-dimensioned by this extension].',13,10
                dc.b 13,10
                dc.b '               Both  TITLE$  and  ITEM$ are limited to  16  characters  in',13,10
                dc.b '               length,  if strings longer than this are used they will  be',13,10
                dc.b '               truncated to the first 16 characters.',13,10
                dc.b 13,10
                dc.b '               If  the 3D Menu strip has not been  previously  initialised',13,10
                dc.b '               via   the   _fmenu  init  command  the  error   "Menu   not',13,10
                dc.b '               initialised. _fmenu init required." is generated.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu on',13,10
                dc.b 'Action    :-   Equivalent to the STOS menu on command.  Turns on the  menu',13,10
                dc.b '               interrupt  drivers and displays the 3D Effects Menu  strip.',13,10
                dc.b '               After the program invokes this command the 3D menu is fully',13,10
                dc.b '               operational to the program in the same way as the  original',13,10
                dc.b '               STOS menu on command.',13,10
                dc.b 13,10
                dc.b '               If  the 3D Menu strip has not been  previously  initialised',13,10
                dc.b '               via   the   _fmenu  init  command  the  error   "Menu   not',13,10
                dc.b '               initialised. _fmenu init required." is generated.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu$ off TITLE',13,10
                dc.b '               _fmenu$ off TITLE,ITEM',13,10
                dc.b 'Action    :-   _fmenu$ off TITLE disables the menu title TITLE. This title',13,10
                dc.b '               string is then displayed in the 3D menu in the colours COL2',13,10
                dc.b '               &  COL3.  Any further attempts to CLICK on this menu  title',13,10
                dc.b '               are completely ignored.',13,10
                dc.b 13,10
                dc.b '               _fmenu$  off TITLE,ITEM disables the menu item  TITLE,ITEM.',13,10
                dc.b '               This item string is then displayed in the 3D menu drop-down',13,10
                dc.b '               in the colours COL2 & COL3.  Any further attempts to  CLICK',13,10
                dc.b '               on this menu item are completely ignored.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu$ on TITLE',13,10
                dc.b '               _fmenu$ on TITLE,ITEM',13,10
                dc.b 'Action    :-   Reverses the effect of the above commands.',13,10
                dc.b '               _fmenu$ on TITLE enables the menu title TITLE.  This  title',13,10
                dc.b '               string is then displayed in the 3D menu in the colours COL3',13,10
                dc.b '               & COL4.',13,10
                dc.b 13,10
                dc.b '               _fmenu$  on  TITLE,ITEM enables the menu  item  TITLE,ITEM.',13,10
                dc.b '               This item string is then displayed in the 3D menu drop-down',13,10
                dc.b '               in the colours COL3 & COL4.',13,10
                dc.b 13,10
                dc.b 'Important :-   All  menu  titles/items  are  enabled  by  default   unless',13,10
                dc.b '               previously disabled by the _fmenu$ off command.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   MN=_fmenu select',13,10
                dc.b 'Action    :-   Equivalent  to the STOS mnbar function,  returns  a  number',13,10
                dc.b '               denoting  the menu title you have chosen otherwise  returns',13,10
                dc.b '               zero.',13,10
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   ITEM=_fmenu item',13,10
                dc.b 'Action    :-   Equivalent to the STOS mnselect function,  returns a number',13,10
                dc.b '               denoting  the  menu option/item you have  chosen  otherwise',13,10
                dc.b '               returns zero.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu check item',13,10
                dc.b 'Syntax    :-   _fmenu check item TITLE,ITEM',13,10
                dc.b 'Version   :-   All Menu extension versions.',13,10
                dc.b 'Action    :-   Adds  a checkmark in front of the menu item string  indexed',13,10
                dc.b '               by TITLE,ITEM.',13,10
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu uncheck item',13,10
                dc.b 'Syntax    :-   _fmenu uncheck item TITLE,ITEM',13,10
                dc.b 'Version   :-   All Menu extension versions.',13,10
                dc.b 'Action    :-   Removes  the  checkmark in front of the  menu  item  string',13,10
                dc.b '               indexed by TITLE,ITEM.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu freeze',13,10
                dc.b 'Action    :-   Temporarily  freezes  (turns off) the action of  the  menu.',13,10
                dc.b '               The menu can be restarted with the _fmenu on command.',13,10
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   _fmenu kill',13,10
                dc.b 'Action    :-   Turns off the action of the menu and erases it from memory.',13,10
                dc.b '               The  menu  CANNOT  now  be restarted  with  the  _fmenu  on',13,10
                dc.b '               command, [a new menu must be initialised].',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'Command   :-   BTN=_form alert(COL1,COL2,COL3,COL4,ALERT$)',13,10
                dc.b 'Action    :-   Invokes a 3D effect alert dialog modelled on the GEM  alert',13,10
                dc.b '               dialog.  Returns BTN with the number of the button the user',13,10
                dc.b '               selected (range 1 - 3 depending on the number of buttons in',13,10
                dc.b '               the alert dialog).',13,10
                dc.b 13,10
                dc.b '               COL1   =  Colour index of the 3D alert dialog fill colour.',13,10
                dc.b '               COL2   =  Colour index of the LEFT & TOP sides of the 3D',13,10
                dc.b '                         alert dialog.',13,10
                dc.b '               COL3   =  Colour index of the RIGHT & BOTTOM sides of the',13,10
                dc.b '                         3D alert dialog.',13,10
                dc.b '               COL4   =  Colour index of the alert text and icon.',13,10
                dc.b '               ALERT$ =  String containing the alert message and button',13,10
                dc.b '                         text(s) and takes the format as shown below :-',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '200 ALERT$="[3][Alert message line #1|Alert message line #2|Alert message',13,10
                dc.b '    line #3|Alert message line #4|Alert message line #5 |Alert message',13,10
                dc.b '    line #6|Alert message line #7][Button #1 |Button #2]"',13,10
                dc.b 13,10
                dc.b 'Each  part  of  the alert message string is  contained  within  paired  []',13,10
                dc.b '(square brackets) thus in this example;  breaking up the string each  part',13,10
                dc.b 'has the following function :-',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '[] pair #1 --- in the above example --- [3] = Icon type where;',13,10
                dc.b 13,10
                dc.b '               0 = No icon',13,10
                dc.b '               1 = ! icon',13,10
                dc.b '               2 = ? icon',13,10
                dc.b '               3 = STOP icon',13,10
                dc.b '               4 = i (info) icon',13,10
                dc.b '               5 = floppy disk icon',13,10
                dc.b 13,10
                dc.b '               Note: Any other ASCII value behaves as type = 0.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '[] pair #2 =   [Alert  message  line  #1|Alert  message  line  #2|etc....]',13,10
                dc.b '               where; the alert message itself is contained between paired',13,10
                dc.b '               []  brackets and consist of a maximum 7 lines of text  each',13,10
                dc.b '               of  a  maximum of 32 characters.  Each line of  text  being',13,10
                dc.b "               separated by the '|' character.",13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b '[] pair #3 =   [Buttont text #1|Button text #2|etc....] where;',13,10
                dc.b 13,10
                dc.b '               The  alert  dialog  can provide the user with  1,  2  or  3',13,10
                dc.b '               buttons  and each button definition being seperated by  the',13,10
                dc.b "               '|'  character,  the text contained within each  button  is",13,10
                dc.b '               restricted as follows;',13,10
                dc.b 13,10
                dc.b '          1 button  = Maximum of 24 characters centred within the button.',13,10
                dc.b '          2 buttons = Maximum of 12 characters centred within each button.',13,10
                dc.b '          3 buttons = Maximum of  8 characters centred within each button.',13,10
                dc.b 13,10
                dc.b 'More.... Y/N',13,0
                dc.b 'The 3D alert automatically redraws the screen when it terminates its call,',13,10
                dc.b "this means that you don't need to redraw the screen yourself.",13,10
                dc.b 13,10
                dc.b 'Example of code for the _form alert command (part);',13,10
                dc.b 13,10
                dc.b '1000 rem ~~~~~~~~~~~~~~~~ Initialise Alert string ~~~~~~~~~~~~~~~~~~~~',13,10
                dc.b '1010  : ',13,10
                dc.b '1020 ALERT$="[4][ST/Falcon 3D Alert Dialog|"',13,10
                dc.b '1030 ALERT$=ALERT$+"written in STOS Basic,|"',13,10
                dc.b '1040 ALERT$=ALERT$+"for more info contact....|"',13,10
                dc.b '1050 ALERT$=ALERT$+"Anthony Hoskin.|"',13,10
                dc.b '1060 ALERT$=ALERT$+"45 Wythburn Rd, Newbold,|"',13,10
                dc.b '1070 ALERT$=ALERT$+"Chesterfield, Derbyshire,|"',13,10
                dc.b '1080 ALERT$=ALERT$+"(U.K.) S41 8DP.]"',13,10
                dc.b '1090 ALERT$=ALERT$+"[Tap Here]"',13,10
                dc.b '1100  : ',13,10
                dc.b '1110 rem ~~~~~~~~~~~~~~~ Call the 3D Alert Dialog ~~~~~~~~~~~~~~~~~~',13,10
                dc.b '1120  : ',13,10
                dc.b '1130 BTN=_form alert(COL1,COL2,COL3,COL4,ALERT$)',13,10
                dc.b '--------------------------------------------------------------------------',13,10
                dc.b 13,10
                dc.b 'End of command reference... Press N to exit.',13,10,0
                .even
                dc.l 0

	.bss
lineavars: ds.l 1
x13c7e: ds.w 1
x13c80: ds.w 1
x13c82: ds.w 1
x13c84: ds.l 1
x13c88: ds.w 1
x13c8a: ds.l 1
	ds.b 468

finprg: /* 13e62 */
	ds.w 1
