		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "tokens.inc"

COOK_NEMESIS = 0x4E737064 /* 'Nspd' */

		.text

        bra.w load

        dc.b $80
tokens:
		dc.b "coldboot",$80
		dc.b "cookieptr",$81
		dc.b "warmboot",$82
		dc.b "cookie",$83
		dc.b "caps on",$84
		dc.b "_tos$",$85
		dc.b "caps off",$86
		dc.b "_phystop",$87
		dc.b "_cpuspeed",$88
		dc.b "_memtop",$89
		dc.b "_blitterspeed",$8a
		dc.b "_busmode",$8b
		dc.b "_stebus",$8c
		dc.b "paddle x",$8d
		dc.b "_falconbus",$8e
		dc.b "paddle y",$8f
		dc.b "_cpucache on",$90
		dc.b "_cpucache stat",$91
		dc.b "_cpucache off",$92
		dc.b "lpen x",$93
		dc.b "ide on",$94
		dc.b "lpen y",$95
		dc.b "ide off",$96
		dc.b "_nemesis",$97
		dc.b "_set printer",$98
		dc.b "_printer ready",$99
		dc.b "_file attr",$9a
		dc.b "kbshift",$9b
		dc.b "code$",$9c
		dc.b "_aes in",$9d
		dc.b "uncode$",$9e
		dc.b "_file exist",$9f
		/* $a0 unused */
		dc.b "_add cbound",$a1
		dc.b "lset$",$a2
		dc.b "_sub cbound",$a3
		dc.b "rset$",$a4
		dc.b "_add ubound",$a5
		dc.b "st mouse on",$a6
		dc.b "_sub lbound",$a7
		dc.b "st mouse off",$a8
		dc.b "odd",$a9
		dc.b "st mouse colour",$aa
		dc.b "even",$ab
		dc.b "_limit st mouse",$ac
		dc.b "st mouse stat",$ad
		dc.b "st mouse",$ae
		dc.b "_fileselect$",$af
		/* $b0 unused */
		dc.b "_jagpad direction",$b1
		/* $b2 unused */
		dc.b "_jagpad fire",$b3
		/* $b4 unused */
		dc.b "_jagpad pause",$b5
		/* $b6 unused */
		dc.b "_jagpad option",$b7
		/* $b8 unused */
		dc.b "_jagpad key$",$b9
		dc.b "_joysticks on",$ba
		dc.b "_joyfire",$bb
		dc.b "_joysticks off",$bc
		dc.b "_joystick",$bd
		dc.b "sys cmds",$be
        dc.b 0
        even

jumps:  dc.w 63
		dc.l coldboot
		dc.l cookieptr
		dc.l warmboot
		dc.l cookie
		dc.l caps_on
		dc.l tosstr
		dc.l caps_off
		dc.l phystop
		dc.l cpuspeed
		dc.l memtop
		dc.l blitterspeed
		dc.l busmode
		dc.l stebus
		dc.l paddle_x
		dc.l falconbus
		dc.l paddle_y
		dc.l cpucache_on
		dc.l cpucache_stat
		dc.l cpucache_off
		dc.l lpen_x
		dc.l ide_on
		dc.l lpen_y
		dc.l ide_off
		dc.l nemesis
		dc.l set_printer
		dc.l printer_ready
		dc.l file_attr
		dc.l kbshift
		dc.l codestr
		dc.l aes_in
		dc.l uncodestr
		dc.l file_exist
		dc.l dummy
		dc.l add_cbound
		dc.l lsetstr
		dc.l sub_cbound
		dc.l rsetstr
		dc.l add_ubound
		dc.l st_mouse_on
		dc.l sub_lbound
		dc.l st_mouse_off
		dc.l odd
		dc.l st_mouse_colour
		dc.l even
		dc.l limit_st_mouse
		dc.l st_mouse_stat
		dc.l st_mouse
		dc.l fileselect
		dc.l dummy
		dc.l jagpad_direction
		dc.l dummy
		dc.l jagpad_fire
		dc.l dummy
		dc.l jagpad_pause
		dc.l dummy
		dc.l jagpad_option
		dc.l dummy
		dc.l jagpad_key
		dc.l joysticks_on
		dc.l joyfire
		dc.l joysticks_off
		dc.l joystick
		dc.l sys_cmds


welcome:
		dc.b 10
		dc.b "ST(e)/TT/Falcon 030 System Control v1.02 ",$bd," A.Hoskin. - type 'sys cmds'",0
		dc.b 10
		dc.b "ST(e)/TT/Falcon 030 System Control v1.02 ",$bd," A.Hoskin. - type 'sys cmds'",0
		.even

table: ds.l 1
returnpc: ds.l 1
tosver: ds.w 1
mch_cookie: ds.l 1
cpu_cookie: ds.l 1
vdo_cookie: ds.l 1
snd_cookie: ds.l 1
nemesis_cookie: ds.l 1
cookieid: ds.l 1
cookievalue: ds.l 1
bootflag: ds.w 1
	ds.w 1 /* unused */
mode: ds.l 1

load:
		lea.l      finprg,a0
		lea.l      cold,a1
		rts

cold:
		move.l     a0,table
		move.w     #4,-(a7) /* Getrez */
		trap       #14
		addq.l     #2,a7
		andi.l     #3,d0
		swap       d0
		lea.l      mode(pc),a0
		move.l     d0,(a0)
		move.w     #0,bootflag
		lea.l      mch_cookie(pc),a0
		clr.l      (a0)+
		clr.l      (a0)+
		clr.l      (a0)+
		move.l     #1,(a0)+
		clr.l      (a0)+
		lea.l      cookieid(pc),a1
		move.l     #0x5F4D4348,(a1)
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
		move.l     #0x5F435055,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold2
		lea.l      cookievalue(pc),a1
		lea.l      cpu_cookie(pc),a0
		move.l     (a1),(a0)
cold2:
		lea.l      cookieid(pc),a1
		move.l     #0x5F56444F,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold3
		lea.l      cookievalue(pc),a1
		lea.l      vdo_cookie(pc),a0
		move.l     (a1),(a0)
cold3:
		lea.l      cookieid(pc),a1
		move.l     #0x5F534E44,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold4
		lea.l      cookievalue(pc),a1
		lea.l      snd_cookie(pc),a0
		move.l     (a1),(a0)
cold4:
		lea.l      cookieid(pc),a1
		move.l     #COOK_NEMESIS,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      cold5
		lea.l      cookievalue(pc),a1
		lea.l      nemesis_cookie(pc),a0
		move.l     (a1),(a0)
cold5:
		lea.l      welcome,a0
		lea.l      warm,a1
		lea.l      tokens,a2
		lea.l      jumps,a3
		bsr.s      check_spritelib
		rts

check_spritelib:
		movem.l    d0-d6/a0-a6,-(a7)
		move.w     #0,spritelib_ok
		movea.l    0x00000094,a1 ; vector for trap #5
		lea        -(spritelib_id_end-spritelib_id)(a1),a1
		lea.l      spritelib_id(pc),a0
		moveq.l    #spritelib_id_end-spritelib_id-1,d7
check_spritelib1:
		cmpm.b     (a0)+,(a1)+
		bne.s      check_spritelib2
		dbf        d7,check_spritelib1
		move.w     #-1,spritelib_ok
check_spritelib2:
		movem.l    (a7)+,d0-d6/a0-a6
		rts

spritelib_id:
	dc.b "FALCON 030 STOS Sprite 5.8",0,0
spritelib_id_end:


warm:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      kbdvbase(pc),a0
		/* tst.l     (a0) */
		dc.w 0x0c90,0,0 /* XXX */
		beq.s      warm2
		movea.l    (a0),a1
		move.l     #0,(a0) /* XXX */
		move.l     oldjoyvec(pc),24(a1)
		lea.l      (0xFFFFFC00).w,a1
warm1:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      warm1
		move.b     #8,2(a1) ; restore to normal mouse reporting
warm2:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      warm3
		tst.w      bootflag
		bne.s      warm3
		move.w     #-1,bootflag
		pea.l      dowarm(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
warm3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

dowarm:
		movea.l    (0x000005A0).w,a0
		move.l     #COOK_NEMESIS,d0
dowarm1:
		move.l     (a0),d1
		beq.s      dowarm3
		cmp.l      d0,d1
		beq.s      dowarm2
		addq.l     #8,a0
		bra.s      dowarm1
dowarm2:
		move.l     #0,4(a0)
		/* set nemesis back to 8Mhz */
		lea.l      (0xFFFFFC04).w,a0
		move.b     #0x03,(a0)
		move.b     #0x95,(a0)
		lea.l      (0xFFFFFC00).w,a0
		move.b     #0x03,(a0)
		move.b     #0x96,(a0)
dowarm3:
		lea.l      nemesis_cookie(pc),a0
		move.l     #0,(a0)
		move.l     #0x00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */ /* BUG: must only do this for 030+ */
		move.l     #0x00003919,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */ /* BUG: must only do this for 030+ */
		move.l     #0x00003111,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */ /* BUG: must only do this for 030+ */
		movea.l    #0xFFFF8007,a0
		bclr       #0,(a0)
		bset       #2,(a0)
		bset       #5,(a0)
		rts

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
		move.l     d0,d7
		rts

getpalette: /* unused */
		movem.l    d1-d7/a0-a6,-(a7)
		lea.l      rgbpalette,a0
		move.l     a0,-(a7)
		move.w     d7,-(a7)
		move.w     #0,-(a7)
		move.w     #94,-(a7) /* VgetRGB */
		trap       #14
		lea.l      10(a7),a7
		movem.l    (a7)+,d1-d7/a0-a6
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

addrofbank: /* unused */
		movem.l    a0-a2,-(a7)
		movea.l    table(pc),a0
		movea.l    sys_addrofbank(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a2
		rts

malloc:
		movea.l    table(pc),a0
		movea.l    sys_demand(a0),a0
		jsr        (a0)
		rts

dummy:
		move.l     (a7)+,returnpc
		bra.s      syntax

/* unused */
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
string_too_long: /* unused */
		moveq.l    #E_string_too_long,d0
		bra.s      goerror
e_charset: /* unused */
		movem.l    (a7)+,a1-a6
		moveq.l    #E_character_set,d0
		bra.s      goerror
badfilename:
		moveq.l    #E_badfilename,d0
		bra.s      goerror
extension_noent:
		moveq.l    #E_extension_noent,d0
		bra.s      goerror
diskerror:
		moveq.l    #E_diskerror,d0

goerror:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      kbdvbase(pc),a0
		/* tst.l     (a0) */
		dc.w 0x0c90,0,0 /* XXX */
		beq.s      goerror2
		movea.l    (a0),a1
		move.l     #0,(a0) /* XXX */
		move.l     oldjoyvec(pc),24(a1)
		lea.l      ($FFFFFC00).w,a1
goerror1:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      goerror1
		move.b     #8,2(a1) ; restore to normal mouse reporting
goerror2:
		lea.l      mode(pc),a0
		move.w     (a0),d0
		cmpi.w     #2,d0
		beq.s      goerror3
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
goerror3:
		movem.l    (a7)+,d0-d7/a0-a6
		movea.l    table(pc),a0
		movea.l    sys_error(a0),a0
		jmp        (a0)

illfalconfunc:
		moveq.l    #0,d0
		bra.s      printerr
cookieerr:
		moveq.l    #1,d0
		bra.s      printerr
cpuspeederr:
		moveq.l    #2,d0
		bra.s      printerr
blitterspeederr:
		moveq.l    #3,d0
		bra.s      printerr
/* dead code */
		moveq.l    #0,d0
		bra.s      printerr
		nop

printerr:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      kbdvbase(pc),a0
		/* tst.l     (a0) */
		dc.w 0x0c90,0,0 /* XXX */
		beq.s      printerr4
		movea.l    (a0),a1
		move.l     #0,(a0) /* XXX */
		move.l     oldjoyvec(pc),24(a1)
		lea.l      ($FFFFFC00).w,a1
printerr3:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      printerr3
		move.b     #8,2(a1) ; restore to normal mouse reporting
printerr4:
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
		dc.b "Illegal Command/Function (use only on Falcon 030)",0
		dc.b "Illegal Command/Function (use only on Falcon 030)",0
		dc.b "Cookie ID string requires 4 characters",0
		dc.b "Cookie ID string requires 4 characters",0
		dc.b "CPU speed maybe set to 8 or 16 mHz only!",0
		dc.b "CPU speed maybe set to 8 or 16 mHz only!",0
		dc.b "BLITTER speed maybe set to 8 or 16 mHz only!",0
		dc.b "BLITTER speed maybe set to 8 or 16 mHz only!",0
		.even

/*
 * Syntax: coldboot
 */
coldboot:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
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

/*
 * Syntax: P_COOKIE=cookieptr
 */
cookieptr:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movea.l    #0x000005A0,a0
		move.l     (a0),d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: warmboot
 */
warmboot:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
		pea.l      dowarmboot(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		rts
dowarmboot:
		lea.l      0x00000004,a0 /* XXX */
		movea.l    (a0),a0
		jmp        (a0)

/*
 * Syntax: COOKIE_VAL=cookie(ID$)
 */
cookie:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		cmp.w      #1,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a2
		move.w     (a2),d3
		cmpi.w     #4,(a2)
		bne        cookieerr
		addq.l     #2,a2
		lea.l      cookieid(pc),a1
		subq.w     #1,d3
cookie1:
		move.b     (a2)+,(a1)+
		dbf        d3,cookie1
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      cookievalue(pc),a1
		move.l     (a1),d3
		tst.l      d0
		bne.s      cookie2
		move.l     d0,d3
cookie2:
		lea.l      cookieid(pc),a1
		cmpi.l     #0x5F435055,(a1) /* '_CPU' */
		bne.s      cookie3
		andi.l     #255,d3 /* WTF */
		addi.l     #68000,d3
cookie3:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: caps on
 */
caps_on:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #16,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: A$=_tos$
 */
tosstr:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		pea.l      get_tosvers(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		moveq.l    #5,d3
		jsr        malloc /* FIXME */
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
		move.l     a1,d3
		move.w     #128,d2 ; returns string
		movea.l    returnpc(pc),a0
		jmp        (a0)
get_tosvers:
		movea.l    #0x000004F2,a0
		movea.l    (a0),a0
		move.w     2(a0),d0
		andi.l     #0x00000FFF,d0 /* WTF */
		lea.l      tosver(pc),a0
		move.w     d0,(a0)
		rts

/*
 * Syntax: caps off
 */
caps_off:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: X=_phystop
 */
phystop:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		pea.l      get_phystop(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      phystop_val(pc),a1
		move.l     (a1),d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)
get_phystop:
		lea.l      0x0000042E,a0 /* XXX */
		lea.l      phystop_val(pc),a1
		move.l     (a0),(a1)
		rts
phystop_val: ds.l 1

/*
 * Syntax: _cpuspeed N
 */
cpuspeed:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      cpu_setspeed(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		lea.l      cookieid(pc),a1
		move.l     #COOK_NEMESIS,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
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
		bra        cpuspeederr
cpuspeed1:
		move.l     cpu_setspeed(pc),d3
		cmpi.l     #8,d3
		beq.s      cpuspeed2
		cmpi.l     #16,d3
		beq.s      cpuspeed3
		bra        cpuspeederr
cpuspeed2:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      cpuspeed6
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set8(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		bra.s      cpuspeed6
cpuspeed3:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      cpuspeed6
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set16(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		bra.s      cpuspeed6
cpuspeed4:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      cpuspeed6
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set20(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		bra.s      cpuspeed6
cpuspeed5:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      cpuspeed6
		movem.l    a0-a6,-(a7)
		pea.l      cpuspeed_set24(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
cpuspeed6:
		movea.l    returnpc(pc),a0
		jmp        (a0)

cpuspeed_set8:
		movea.l    (0x000005A0).w,a0
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
		movea.l    (0x000005A0).w,a0
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
		movea.l    (0x000005A0).w,a0
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
		movea.l    (0x000005A0).w,a0
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

cpu_setspeed: ds.l 1
	ds.l 1 /* unused */

/*
 * Syntax: X=_memtop
 */
memtop:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		pea.l      get_memtop(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      memtop_val(pc),a1
		move.l     (a1),d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

get_memtop:
		lea.l      0x00000436,a0 /* XXX */
		lea.l      memtop_val(pc),a1
		move.l     (a0),(a1)
		rts

memtop_val: ds.l 1

/*
 * Syntax: _blitterspeed N
 */
blitterspeed:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		lea.l      blitter_setspeed(pc),a0
		move.l     d3,(a0)
		pea.l      get_nemesis(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      nemesis_val(pc),a1
		move.l     (a1),d7
		tst.l      d7
		beq.s      blitterspeed1
		bra.s      blitterspeed2 /* BUG: should do nothing, but sets 8Mhz */
blitterspeed1:
		move.l     blitter_setspeed(pc),d3
		cmpi.l     #8,d3
		beq.s      blitterspeed2
		cmpi.l     #16,d3
		beq.s      blitterspeed3
		bra        blitterspeederr
blitterspeed2:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      blitterspeed4
		movem.l    a0-a6,-(a7)
		pea.l      blitter_set8(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		bra.s      blitterspeed4
blitterspeed3:
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      blitterspeed4
		movem.l    a0-a6,-(a7)
		pea.l      blitter_set16(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
blitterspeed4:
		movea.l    returnpc(pc),a0
		jmp        (a0)

blitter_set8:
		movea.l    #0xFFFF8007,a0
		bclr       #2,(a0)
		rts

blitter_set16:
		movea.l    #0xFFFF8007,a0
		bset       #2,(a0)
		rts

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
		lea.l      nemesis_val(pc),a1
		move.l     4(a0),(a1)
		rts
get_nemesis3:
		lea.l      nemesis_val(pc),a1
		move.l     #0,(a1)
		rts

nemesis_val: ds.l 1

/*
 * Syntax: B=_busmode
 */
busmode:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		moveq.l    #0,d3
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      busmode1
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		pea.l      get_busmode(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
busmode1:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

get_busmode:
		movea.l    #0xFFFF8007,a0
		move.b     (a0),d0
		andi.l     #0x0000FFFF,d0 /* FIXME; useless */
		rts

/*
 * Syntax: _stebus
 */
stebus:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      stebus1
		movem.l    a0-a6,-(a7)
		pea.l      stebus_on(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
stebus1:
		movea.l    returnpc(pc),a0
		jmp        (a0)
stebus_on:
		movea.l    #0xFFFF8007,a0
		bclr       #5,(a0)
		rts

/*
 * Syntax: X=paddle x(P)
 */
paddle_x:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		movem.l    a0-a6,-(a7)
		moveq.l    #0,d0
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      paddle_x1
		cmpi.w     #3,d6
		bne.s      paddle_x2
paddle_x1:
		tst.l      d3
		bmi.s      paddle_x2
		cmpi.l     #3,d3
		bgt.s      paddle_x2
		asl.w      #2,d3
		movea.l    #$00FF9210,a0 /* XXX */
		move.b     1(a0,d3.w),d0
paddle_x2:
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: _falconbus
 */
falconbus:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne.s      falconbus1
		movem.l    a0-a6,-(a7)
		pea.l      stebus_off(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
falconbus1:
		movea.l    returnpc(pc),a0
		jmp        (a0)
stebus_off:
		movea.l    #0xFFFF8007,a0
		bset       #5,(a0)
		rts

/*
 * Syntax: Y=paddle y(P)
 */
paddle_y:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		movem.l    a0-a6,-(a7)
		moveq.l    #0,d0
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      paddle_y1
		cmpi.w     #3,d6
		bne.s      paddle_y2
paddle_y1:
		tst.l      d3
		bmi.s      paddle_y2
		cmpi.l     #3,d3
		bgt.s      paddle_y2
		asl.w      #2,d3
		movea.l    #$00FF9212,a0 /* XXX */
		move.b     1(a0,d3.w),d0
paddle_y2:
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: _cpucache on
 */
cpucache_on:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		move.l     cpu_cookie(pc),d6
		cmpi.w     #30,d6
		bne.s      cpucache_on1
		movem.l    a0-a6,-(a7)
		pea.l      cache_on(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
cpucache_on1:
		movea.l    returnpc(pc),a0
		jmp        (a0)
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
cpucache_stat:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		moveq.l    #0,d3
		move.l     cpu_cookie(pc),d6
		cmpi.w     #30,d6
		bne.s      cpucache_stat1
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		pea.l      cache_get(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      cache_val,a0 /* FIXME */
		move.l     (a0),d3
		movem.l    (a7)+,a0-a6
cpucache_stat1:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
cache_get:
		dc.w 0x4e7a,2 /* movec      cacr,d0 */
		move.l     d0,cache_val
		rts

cache_val: ds.l 1

/*
 * Syntax: _cpucache off
 */
cpucache_off:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		move.l     cpu_cookie(pc),d6
		cmpi.w     #30,d6
		bne.s      cpucache_off1
		movem.l    a0-a6,-(a7)
		pea.l      cache_off(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
cpucache_off1:
		movea.l    returnpc(pc),a0
		jmp        (a0)
cache_off:
		move.l     #$00000A0A,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		moveq.l    #0,d0
		dc.w 0x4e7b,2 /* movec      d0,cacr */
		rts

/*
 * Syntax: X=lpen x
 */
lpen_x:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		moveq.l    #0,d0
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      lpen_x1
		cmpi.w     #3,d6
		bne.s      lpen_x2
lpen_x1:
		move.w     $00FF9220,d0 /* XXX */
lpen_x2:
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: ide on
 */
ide_on:
		move.l     (a7)+,returnpc
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0x007F,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: Y=lpen y
 */
lpen_y:
		move.l     (a7)+,returnpc
		move.w     #0,bootflag
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		moveq.l    #0,d0
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      lpen_y1
		cmpi.w     #3,d6
		bne.s      lpen_y2
lpen_y1:
		move.w     0x00FF9222,d0 /* XXX */
lpen_y2:
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: ide off
 */
ide_off:
		move.l     (a7)+,returnpc
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0x0080,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: NEMESIS_FLAG=_nemesis
 */
nemesis:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      cookieid(pc),a1
		move.l     #COOK_NEMESIS,(a1)
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		lea.l      cookievalue(pc),a1
		lea.l      nemesis_cookie(pc),a0
		move.l     (a1),(a0)
		moveq.l    #0,d3
		tst.l      d0
		beq.s      nemesis1
		moveq.l    #-1,d3
nemesis1:
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: _set printer X
 */
set_printer:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #33,-(a7) /* Setprt */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: A=_printer ready
 */
printer_ready:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0,-(a7)
		move.w     #8,-(a7) /* Bcostat */
		trap       #13
		addq.l     #4,a7
		move.w     d0,d3
		ext.l      d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: file attr FNAME$,ATTR
 */
file_attr:
		move.l     (a7)+,returnpc
		cmpi.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		lea.l      file_attrval(pc),a1
		move.w     d3,(a1)
		bsr        getstring
		movea.l    d3,a2
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
		bmi        diskerror
		movea.l    returnpc(pc),a0
		jmp        (a0)

file_attrval: ds.w 1
file_attrname: ds.b 256


/*
 * Syntax: X=kbshift
 */
kbshift:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #11,-(a7) /* Kbshift */
		trap       #13
		addq.l     #4,a7
		andi.l     #0x000000FF,d0
		move.w     d0,d3
		clr.l      d2
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: A=_aes in
 */
aes_in:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0x00C9,d0
		trap       #2
		movem.l    (a7)+,a0-a6
		clr.l      d3
		cmpi.w     #0x00C9,d0
		beq.s      aes_in1
		moveq.l    #-1,d3
aes_in1:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: code$ A$,N
 */
codestr:
		move.l     (a7)+,returnpc
		cmpi.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		move.w     d3,d1
		bsr        getstring
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		subq.w     #1,d3 /* BUG: does not check for empty string */
codestr1:
		move.b     (a2),d2
		add.b      d1,d2
		move.b     d2,(a2)+
		dbf        d3,codestr1
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: uncode$ A$,N
 */
uncodestr:
		move.l     (a7)+,returnpc
		cmpi.w     #2,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		move.w     d3,d1
		bsr        getstring
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		subq.w     #1,d3 /* BUG: does not check for empty string */
uncodestr1:
		move.b     (a2),d2
		sub.b      d1,d2
		move.b     d2,(a2)+
		dbf        d3,uncodestr1
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: A=file exist(F$)
 */
file_exist:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a2
		cmpi.w     #1,(a2)
		blt        badfilename
		move.w     (a2),d7
		subq.w     #1,d7 /* BUG: does not check for empty string */
file_exist1:
		cmpi.b     #'*',2(a2,d7.w)
		beq        badfilename
		dbf        d7,file_exist1
		lea.l      file_existname,a1
		move.w     #(256/4)-1,d7
file_exist2:
		clr.l      (a1)+
		dbf        d7,file_exist2
		lea.l      file_existname,a1
		move.w     (a2)+,d7
		subq.w     #1,d7
file_exist3:
		move.b     (a2)+,(a1)+
		dbf        d7,file_exist3
		move.b     #0,(a1)+
		movem.l    a0-a6,-(a7)
		lea.l      file_existdtaptr(pc),a3
		move.w     #47,-(a7) /* Fgetdta */
		trap       #1
		addq.l     #2,a7
		move.l     d0,(a3)
		pea.l      file_existdta(pc)
		move.w     #26,-(a7) /* Fsetdta */
		trap       #1
		addq.l     #6,a7
		move.w     #-1,-(a7)
		pea.l      file_existname(pc)
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
		movea.l    returnpc(pc),a0
		jmp        (a0)

file_existname: ds.b 256
     ds.b 16 /* unused */
file_existdtaptr: ds.l 1
file_existdta: ds.b 44

/*
 * Syntax: A=_add cbound(A,I,L,U)
 */
add_cbound:
		move.l     (a7)+,returnpc
		cmpi.w     #4,d0
		bne        syntax
		lea.l      add_cbound_rect(pc),a2
		bsr        getinteger
		move.l     d3,12(a2)
		bsr        getinteger
		move.l     d3,8(a2)
		bsr        getinteger
		move.l     d3,4(a2)
		bsr        getinteger
		move.l     d3,(a2)
		movem.l    (a2)+,d0-d3
		add.l      d1,d0
		cmp.l      d3,d0
		bgt.s      add_cbound1
		cmp.l      d2,d0
		blt.s      add_cbound2
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
add_cbound1:
		move.l     d2,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
add_cbound2:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

add_cbound_rect: ds.l 4

/*
 * Syntax: lset$ A$,B$
 */
lsetstr:
		move.l     (a7)+,returnpc
		cmpi.w     #2,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		lea.l      lset_srcstr(pc),a0
		move.l     a2,(a0)+
		move.w     d3,(a0)+
		bsr        getstring
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
		movea.l    returnpc(pc),a0
		jmp        (a0)

lset_dststr: ds.b 6
lset_srcstr: ds.b 6

/*
 * Syntax: A=_sub cbound(A,I,L,U)
 */
sub_cbound:
		move.l     (a7)+,returnpc
		cmpi.w     #4,d0
		bne        syntax
		lea.l      sub_cbound_rect(pc),a2
		bsr        getinteger
		move.l     d3,12(a2)
		bsr        getinteger
		move.l     d3,8(a2)
		bsr        getinteger
		move.l     d3,4(a2)
		bsr        getinteger
		move.l     d3,(a2)
		movem.l    (a2)+,d0-d3
		sub.l      d1,d0
		cmp.l      d3,d0
		bgt.s      sub_cbound1
		cmp.l      d2,d0
		blt.s      sub_cbound2
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
sub_cbound1:
		move.l     d2,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
sub_cbound2:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

sub_cbound_rect: ds.l 4


/*
 * Syntax: rset$ A$,B$
 */
rsetstr:
		move.l     (a7)+,returnpc
		cmpi.w     #2,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a2
		moveq.l    #0,d3
		move.w     (a2)+,d3
		lea.l      rset_srcstr(pc),a0
		move.l     a2,(a0)+
		move.w     d3,(a0)+
		bsr        getstring
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
		movea.l    returnpc(pc),a0
		jmp        (a0)

rset_dststr: ds.b 6
rset_srcstr: ds.b 6


/*
 * Syntax: A=_add ubound(A,I,U)
 */
add_ubound:
		move.l     (a7)+,returnpc
		cmpi.w     #3,d0
		bne        syntax
		lea.l      add_ubound_rect(pc),a2
		bsr        getinteger
		move.l     d3,8(a2)
		bsr        getinteger
		move.l     d3,4(a2)
		bsr        getinteger
		move.l     d3,(a2)
		movem.l    (a2)+,d0-d2
		add.l      d1,d0
		cmp.l      d2,d0
		bgt.s      add_ubound1
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
add_ubound1:
		move.l     add_ubound_rect+8(pc),d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

add_ubound_rect: ds.l 3

/*
 * Syntax: st mouse on
 */
st_mouse_on:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		moveq.l    #S_st_mouse_on,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: A=_sub lbound(A,I,L)
 */
sub_lbound:
		move.l     (a7)+,returnpc
		cmpi.w     #3,d0
		bne        syntax
		lea.l      sub_lbound_rect(pc),a2
		bsr        getinteger
		move.l     d3,8(a2)
		bsr        getinteger
		move.l     d3,4(a2)
		bsr        getinteger
		move.l     d3,(a2)
		movem.l    (a2)+,d0-d2
		sub.l      d1,d0
		cmp.l      d2,d0
		blt.s      sub_lbound1
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)
sub_lbound1:
		move.l     sub_lbound_rect+8(pc),d3
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

sub_lbound_rect: ds.l 3

/*
 * Syntax: st mouse off
 */
st_mouse_off:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		moveq.l    #S_st_mouse_off,d0
		trap       #5
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: X=odd(A)
 */
odd:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0
		moveq.l    #-1,d3
		btst       #0,d0
		bne.s      odd1
		moveq.l    #0,d3
odd1:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: st mouse colour COL_INDEX
 *         st mouse colour RED,GREEN,BLUE
 */
st_mouse_colour:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		cmp.w      #1,d0
		beq.s      st_mouse_colour2
		cmp.w      #3,d0
		beq.s      st_mouse_colour1
		bra        syntax
st_mouse_colour1:
		bsr        getinteger
		andi.l     #31,d3
		lea.l      st_mouse_colour_rgb(pc),a0
		move.w     d3,4(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		lea.l      st_mouse_colour_rgb(pc),a0
		move.w     d3,2(a0)
		bsr        getinteger
		andi.l     #31,d3
		rol.w      #6,d3
		rol.w      #5,d3
		lea.l      st_mouse_colour_rgb(pc),a0
		move.w     d3,(a0)
		movem.w    (a0)+,d1-d3
		or.w       d1,d2
		or.w       d2,d3
		andi.l     #0x0000FFFF,d3 /* FIXME: useless */
		bra.s      st_mouse_colour3
st_mouse_colour2:
		bsr        getinteger
		andi.l     #0x000000FF,d3
st_mouse_colour3:
		move.w     d3,d1
		moveq.l    #S_st_mouse_color,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

st_mouse_colour_rgb: ds.w 4

/*
 * Syntax: X=even(A)
 */
even:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0
		moveq.l    #-1,d3
		btst       #0,d0
		beq.s      even1
		moveq.l    #0,d3
even1:
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: _limit st mouse X1,Y1,X2,Y2
 *         _limit st mouse -1
 */
limit_st_mouse:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		cmp.w      #1,d0
		beq.s      limit_st_mouse2
		cmp.w      #4,d0
		beq.s      limit_st_mouse1
		bra        syntax
limit_st_mouse1:
		bsr        getinteger
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d3,6(a0)
		bsr        getinteger
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d3,4(a0)
		bsr        getinteger
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d3,2(a0)
		bsr        getinteger
		lea.l      limit_st_mouse_coords(pc),a0
		move.w     d3,(a0)
		move.w     (a0)+,d1
		move.w     (a0)+,d2
		move.w     (a0)+,d3
		move.w     (a0)+,d4
		moveq.l    #-1,d5
		moveq.l    #S_limit_st_mouse,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)
limit_st_mouse2:
		/* BUG: does not pop argument */
		moveq.l    #0,d5
		moveq.l    #S_limit_st_mouse,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

limit_st_mouse_coords: ds.w 4

/*
 * Syntax: X=st mouse stat
 */
st_mouse_stat:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		moveq.l    #S_st_mouse_stat,d0
		trap       #5
		move.w     d1,d3
		ext.l      d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: st mouse N
 */
st_mouse:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d1
		andi.l     #0x000000FF,d1 /* FIXME */
		moveq.l    #S_st_mouse,d0
		trap       #5
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: F$=_fileselect$(PATH$,TITLE$,BG_COLOUR,BTN_COLOUR_1,BTN_COLOUR_2,TXT_COLOUR_1,TXT_COLOUR_2)
 */
fileselect:
		move.l     (a7)+,returnpc
		move.w     spritelib_ok(pc),d6
		tst.w      d6
		beq        extension_noent
		cmp.w      #7,d0
		bne        syntax
		bsr        getinteger
		lea.l      fileselect_txtcolor2(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		lea.l      fileselect_txtcolor1(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		lea.l      fileselect_btncolor2(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		lea.l      fileselect_btncolor1(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		lea.l      fileselect_bgcolor(pc),a1
		move.w     d3,(a1)
		bsr        getstring
		lea.l      fileselect_title(pc),a0
		move.l     d3,(a0)
		bsr        getstring
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
		clr.l      d3
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
		jsr        malloc /* FIXME */
		move.w     d3,(a0)+
		subq.w     #1,d3
		lea.l      fileselect_name(pc),a3
fileselect3:
		move.b     (a3)+,(a0)+
		dbf        d3,fileselect3
		movem.l    (a7)+,a2-a6
		move.l     a1,d3
		move.w     #128,d2 /* returns string */
		movea.l    returnpc(pc),a0
		jmp        (a0)
fileselect4:
		clr.l      d3
		jsr        malloc /* FIXME */
		move.w     d3,(a0)+
		move.b     #0,(a0)+
		movem.l    (a7)+,a2-a6
		move.l     a1,d3
		move.w     #128,d2 /* returns string */
		movea.l    returnpc(pc),a0
		jmp        (a0)

fileselect_bgcolor: ds.w 1
fileselect_btncolor1: ds.w 1
fileselect_btncolor2: ds.w 1
fileselect_txtcolor1: ds.w 1
fileselect_txtcolor2: ds.w 1
fileselect_title: ds.l 1
fileselect_path: ds.l 1
fileselect_name: ds.b 24

/*
 * Syntax: D=_jagpad direction(PORT)
 */
jagpad_direction:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #1,d3
		bgt        illfunc
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      jagpad_direction1
		cmpi.w     #3,d6
		beq.s      jagpad_direction1
		moveq.l    #0,d3
		bra.s      jagpad_direction3
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
		andi.w     #15,d3
jagpad_direction3:
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: F=_jagpad fire(PORT,BTN)
 */
jagpad_fire:
		move.l     (a7)+,returnpc
		cmpi.w     #2,d0
		bne        syntax
		bsr        getinteger
		tst.l      d3
		bmi        illfunc
		cmpi.l     #2,d3
		bgt        illfunc
		andi.l     #15,d3 /* FIXME: useless */
		move.l     d3,d5
		bsr        getinteger
		tst.w      d3
		bmi        illfunc
		cmpi.w     #1,d3
		bgt        illfunc
		andi.l     #15,d3
		movem.l    a0-a6,-(a7)
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      jagpad_fire1
		cmpi.w     #3,d6
		beq.s      jagpad_fire1
		moveq.l    #0,d3
		bra.s      jagpad_fire4
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
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: X=_jagpad pause(PORT)
 */
jagpad_pause:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.w      d3
		bmi        illfunc
		cmpi.w     #1,d3
		bgt        illfunc
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      jagpad_pause1
		cmpi.w     #3,d6
		beq.s      jagpad_pause1
		moveq.l    #0,d3
		bra.s      jagpad_pause4
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
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: X=_jagpad option(PORT)
 */
jagpad_option:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.w      d3
		bmi        illfunc
		cmpi.w     #1,d3
		bgt        illfunc
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      jagpad_option1
		cmpi.w     #3,d6
		beq.s      jagpad_option1
		moveq.l    #0,d3
		bra.s      jagpad_option4
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
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc(pc),a0
		jmp        (a0)

/*
 * Syntax: K$=_jagpad key$(PORT)
 */
jagpad_key:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		tst.w      d3
		bmi        illfunc
		cmpi.w     #1,d3
		bgt        illfunc
		andi.l     #15,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		move.w     mch_cookie(pc),d6
		cmpi.w     #1,d6
		beq.s      jagpad_key1
		cmpi.w     #3,d6
		beq.s      jagpad_key1
		bra.s      jagpad_key4
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
		lea.l      jagpad_str(pc),a1
		move.l     a1,d3
		move.w     #0,(a1)+
		move.w     #0,(a1)+
		move.w     #128,d2 ; returns string
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)
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
		lea.l      jagpad_str(pc),a1
		move.l     a1,d3
		move.w     #1,(a1)+
		move.b     d6,(a1)+
		move.b     #0,(a1)+
		move.w     #128,d2 ; returns string
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

jagpad_str: dc.w 0,0

readmasks: dc.w 0xfffd,0xfffb,0xfff7
		   dc.w 0xffdf,0xffbf,0xff7f
readchars: dc.b "*7410852#963"

/*
 * Syntax: _joysticks on
 */
joysticks_on:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
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
joysticks_on1:
		move.b     (a1),d1
		btst       #1,d1
		beq.s      joysticks_on1
		move.b     #0x14,2(a1) ; SET JOYSTICK EVENT REPORTING
		movem.l    (a7)+,a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

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

/*
 * Syntax: F=_joyfire(P)
 */
joyfire:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		subq.w     #1,d3
		bmi        illfunc
		cmpi.w     #1,d3
		bgt        illfunc
		andi.l     #3,d3
		move.l     d3,d0
		lea.l      joybuf(pc),a0
		move.b     0(a0,d0.w),d3
		andi.l     #0x80,d3
		tst.l      d3
		beq.s      joyfire1
		moveq.l    #-1,d3
joyfire1:
		moveq.l    #0,d2
		movea.l    returnpc(pc),a0
		jmp        (a0)


/*
 * Syntax: _joysticks off
 */
joysticks_off:
		move.l     (a7)+,returnpc
		tst.w      d0
		bne        syntax
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
		movea.l    returnpc(pc),a0
		jmp        (a0)


/*
 * Syntax: J=_joystick(P)
 */
joystick:
		move.l     (a7)+,returnpc
		cmpi.w     #1,d0
		bne        syntax
		bsr        getinteger
		subq.w     #1,d3
		bmi        illfunc
		cmpi.w     #1,d3
		bgt        illfunc
		andi.l     #3,d3
		move.l     d3,d0
		lea.l      joybuf(pc),a0
		move.b     0(a0,d0.w),d3
		andi.l     #0x7F,d3
		moveq.l    #0,d2
		movea.l    returnpc(pc),a0
		jmp        (a0)



/*
 * Syntax: sys cmds
 */
sys_cmds:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		lea.l      helpmsgs(pc),a0
sys_cmds1:
		tst.b      (a0)
		beq.s      sys_cmds4
		movem.l    a0-a6,-(a7)
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,a0-a6
sys_cmds2:
		tst.b      (a0)+
		bne.s      sys_cmds2
sys_cmds3:
		movem.l    a0-a6,-(a7)
		move.w     #255,-(a7)
		move.w     #6,-(a7) /* Crawio */
		trap       #1
		addq.l     #4,a7
		bclr       #5,d0
		movem.l    (a7)+,a0-a6
		tst.l      d0
		beq.s      sys_cmds3
		cmpi.b     #'Y',d0
		beq.s      sys_cmds1
		cmpi.b     #'N',d0
		bne.s      sys_cmds3
sys_cmds4:
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

	.data

helpmsgs:
		dc.b 13,10
		dc.b 'Quick reference for the ST(e)/TT/Falcon 030 System Control Extension v1.02',13,10
		dc.b 10
		dc.b '    ',$bd,' 1996, 1997, 1998 Anthony Hoskin.',13,10
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
		dc.b 'Command   :-   sys cmds',13,10
		dc.b 'Action    :-   Lists this command reference.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '------------------------- System Reset Commands --------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   coldboot',13,10
		dc.b 'Action    :-   This command causes a coldboot of the machine (analogous to',13,10
		dc.b '               switching off the machine and powering up again).',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   warmboot',13,10
		dc.b 'Action    :-   This command causes a warmboot of the machine (analogous to',13,10
		dc.b '               pressing the reset switch at the back of the computer).',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '-------------------------- Cookie Jar Commands ---------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   P_COOKIE=cookieptr',13,10
		dc.b 'Action    :-   This  function returns P_COOKIE holding the address of  the',13,10
		dc.b '               Cookie Jar if present. Otherwise P_COOKIE = 0 if cookie jar',13,10
		dc.b '               not  found.  The Cookie Jar features information about  the',13,10
		dc.b '               system that might be useful while writing programs.',13,10
		dc.b '               The  system variables address $5A0 holds a pointer  to  the',13,10
		dc.b "               'cookie  jar'  - an invention from Atari to  make  programs",13,10
		dc.b '               more  compatible with various TOS based  machines.  If  you',13,10
		dc.b "               follow the 'rules' and start using the 'cookie' in your own",13,10
		dc.b '               programs,  it is more likely they will run on the other  ST',13,10
		dc.b '               computers (and the Falcon 030) as well.',13,10
		dc.b '               Normally,  the  address  $5A0 contains zero on  all  ST(FM)',13,10
		dc.b '               computers  [unless  some auto-booting software  installs  a',13,10
		dc.b '               cookie  jar of its own or the machine has been upgraded  to',13,10
		dc.b '               TOS 2.06]. This system variable was introduced with the STe',13,10
		dc.b '               where it contains the pointer  to the Cookie Jar.  It is an',13,10
		dc.b '               official system variable from Atari that you can trust!',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   COOKIE_VAL=cookie(ID$)',13,10
		dc.b 'Action    :-   This  function returns COOKIE_VAL holding the value of  the',13,10
		dc.b '               COOKIE  whose  identifier (cookie name) is passed  in  ID$.',13,10
		dc.b 13,10
		dc.b '               e.g., PRINT cookie("_CPU")',13,10
		dc.b 13,10
		dc.b '               will  return the CPU type 68000 for the standard  ST(e)  or',13,10
		dc.b '               68030 for the TT030/Falcon030.',13,10
		dc.b 13,10
		dc.b "               The  'cookie jar' allows a program to find out at run  time",13,10
		dc.b '               which  machine  it is running on,   and what  features  the',13,10
		dc.b '               machine has.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '------------------------- Keyboard Commands ------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=kbshift',13,10
		dc.b 'Action    :-   This  function returns the status of the keyboard  modifier',13,10
		dc.b '               keys where the value X may be:-',13,10
		dc.b 13,10
		dc.b '               0   =    None of the keys listed below are pressed.',13,10
		dc.b '               1   =    Right shift key pressed.',13,10
		dc.b '               2   =    Left shift key pressed.',13,10
		dc.b '               4   =    Control key pressed.',13,10
		dc.b '               8   =    Alternate key pressed.',13,10
		dc.b '              16   =    Caps Lock On',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   caps off',13,10
		dc.b 'Action    :-   This command sets CAPS LOCK OFF via BIOS function KBSHIFT.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   caps on',13,10
		dc.b 'Action    :-   This command sets CAPS LOCK ON via BIOS function KBSHIFT.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------- ST Mouse Commands ----------------------------',13,10
		dc.b 13,10
		dc.b 'These  ST mouse pointer commands were originally written specifically  for',13,10
		dc.b "the  Falcon  030's extended video modes,  particularly for the  3D  effect",13,10
		dc.b 'fileselector   and   3D  effect  menu   commands.   However,   since   the',13,10
		dc.b 'ST(e)/TT/Falcon  030  System  Control  extensions  are  now  fully  ST/STe',13,10
		dc.b 'compatible  this  ST  mouse pointer is also available for  the  3D  effect',13,10
		dc.b "fileselector and 3D effect menu commands while running on ST/STe's.",13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   st mouse N',13,10
		dc.b 'Action    :-   Sets the current mouse definition for the ST mouse pointer.',13,10
		dc.b 13,10
		dc.b '               N = 1     Arrow (as per ST desktop mouse pointer).',13,10
		dc.b '                 = 2     Hand with pointing finger.',13,10
		dc.b '                 = 3     Crosshair.',13,10
		dc.b '                 = 4     Outlined Crosshair.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   st mouse colour COL_INDEX       For 2/4/16/256 colour modes',13,10
		dc.b '               st mouse colour RED,GREEN,BLUE  For TRUE-Colour modes',13,10
		dc.b 'Action    :-   Sets the colour for the ST mouse pointer where:-',13,10
		dc.b 13,10
		dc.b '               COL_INDEX      =    0 -   3 for   4 colour modes.',13,10
		dc.b '                              =    0 -  15 for  16 colour modes.',13,10
		dc.b '                              =    0 - 255 for 256 colour modes.',13,10
		dc.b 13,10
		dc.b "Enhanced  :-   In the Falcon's TRUE-COLOUR mode a palette is not available",13,10
		dc.b '               so  the  mouse  pointer  colour is  set  by  selecting  the',13,10
		dc.b '               required RED, GREEN and BLUE components, where:-',13,10
		dc.b 13,10
		dc.b '               RED       =    0 - 31    \    These RED, GREEN, BLUE',13,10
		dc.b '               GREEN     =    0 - 31     >   component values allow any',13,10
		dc.b '               BLUE      =    0 - 31    /    choice from 32768 colours.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   st mouse on',13,10
		dc.b 'Action    :-   Enables and displays the ST mouse pointer.',13,10
		dc.b 'Important :-   Before   issueing  this  command  when   in   ST-compatible',13,10
		dc.b '               resolutions  you  MUST  hide the old  STOS  mouse  pointer,',13,10
		dc.b '               however  the old STOS xmouse and ymouse will  still  report',13,10
		dc.b '               the  coords of the mouse.  Indeed my routines use the  STOS',13,10
		dc.b '               xmouse and ymouse routines to position the ST mouse pointer',13,10
		dc.b '               (this  is  actually a sprite in LINEA format and  uses  the',13,10
		dc.b '               LINEA Drawsprite/Undrawsprite routines).',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   _limit st mouse X1,Y1,X2,Y2',13,10
		dc.b '               _limit st mouse -1',13,10
		dc.b 'Action    :-   This  command  restricts  the  ST  mouse  pointer  to   the',13,10
		dc.b '               rectangle specified by X1,Y1,X2,Y2.  To allow the ST  mouse',13,10
		dc.b '               pointer  to  use  the whole of the screen  area  again  the',13,10
		dc.b '               single parameter (-1) turns off the limiting rectangle.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   st mouse off',13,10
		dc.b 'Action    :-   Disables and removes the ST mouse pointer.  After  issueing',13,10
		dc.b '               this  command  when in ST-compatible resolutions  you  MUST',13,10
		dc.b '               show the old STOS mouse if you wish to make use of the STOS',13,10
		dc.b '               mouse.',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=st mouse stat',13,10
		dc.b 'Action    :-   Returns X=TRUE if ST mouse enabled otherwise FALSE.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '-------------------------- Dual Joystick Commands ------------------------',13,10
		dc.b 13,10
		dc.b 'This group of commands allows BOTH the standard ST joysticks ports to be',13,10
		dc.b 'accessed by STOS.',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   _joysticks on',13,10
		dc.b 'Action    :-   Enables the Dual ST joystick ports [you should always HIDE',13,10
		dc.b '               the STOS mouse pointer before invoking this command].',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   _joysticks off',13,10
		dc.b 'Action    :-   Disables the Dual ST joystick ports [returns the mouse',13,10
		dc.b '               reporting to normal, the STOS mouse pointer may now be',13,10
		dc.b '               reSHOWn].',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   F=_joyfire(P)',13,10
		dc.b 'Action    :-   Returns the status of the firebutton of joystick(P).',13,10
		dc.b "               where P = 1 or 2 and the returned value 'F' = TRUE (-1)",13,10
		dc.b '               if pressed, otherwise FALSE (0).',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   J=_joystick(P)',13,10
		dc.b "Action    :-   Returns the value 'J' with the direction of joystick 'P'",13,10
		dc.b '               where P = 1 = joystick 1',13,10
		dc.b '                     P = 2 = joystick 2',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b "               The directions 'J' correspond as follows:-",13,10
		dc.b 13,10
		dc.b '                              1    ',13,10
		dc.b '                         5    |    9',13,10
		dc.b '                          \   |   /       Note;   Neutral position returns',13,10
		dc.b '                           \  |  /                a value of zero.',13,10
		dc.b '                            \ | /',13,10
		dc.b '                             \|/',13,10
		dc.b '                        4-----+-----8',13,10
		dc.b '                             /|\',13,10
		dc.b '                            / | \',13,10
		dc.b '                           /  |  \',13,10
		dc.b '                          /   |   \',13,10
		dc.b '                         6    |    10',13,10
		dc.b '                              2   ',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------- Jaguar Controller Pad Commands ---------------------',13,10
		dc.b 13,10
		dc.b 'This group of commands allows the Jaguar Controller Pad to be accessed  by',13,10
		dc.b 'STOS when the device is connected to the STe/Falcon 030 enhanced  joystick',13,10
		dc.b 'ports.',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   D=_jagpad direction(PORT)',13,10
		dc.b "Action    :-   Returns  the  value 'D' with the direction  of  the  jagpad",13,10
		dc.b '               (Jaguar  controller)  joypad  connected  to  the   enhanced',13,10
		dc.b '               joystick port PORT (0 - 1).',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '               The directions correspond as follows:-',13,10
		dc.b 13,10
		dc.b '                              1    ',13,10
		dc.b '                         5    |    9',13,10
		dc.b '                          \   |   /       Note;   Neutral position returns',13,10
		dc.b '                           \  |  /                a value of zero.',13,10
		dc.b '                            \ | /',13,10
		dc.b '                             \|/',13,10
		dc.b '                        4-----+-----8',13,10
		dc.b '                             /|\',13,10
		dc.b '                            / | \',13,10
		dc.b '                           /  |  \',13,10
		dc.b '                          /   |   \',13,10
		dc.b '                         6    |    10',13,10
		dc.b '                              2   ',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   F=_jagpad fire(PORT,BTN)',13,10
		dc.b 'Action    :-   Tests the condition of the fire-button (BTN) of the  jagpad',13,10
		dc.b '               (Jaguar controller) connected to the enhanced joystick port',13,10
		dc.b '               PORT (0 - 1).',13,10
		dc.b 13,10
		dc.b '               BTN  =    0    Read Fire button A',13,10
		dc.b '               BTN  =    1    Read Fire button B',13,10
		dc.b '               BTN  =    2    Read Fire button C',13,10
		dc.b 13,10
		dc.b '               Returns TRUE (-1) if fire-button pressed else FALSE (0).',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=_jagpad option(PORT)',13,10
		dc.b 'Action    :-   Tests  the  condition of the option-button  of  the  jagpad',13,10
		dc.b '               (Jaguar controller) connected to the enhanced joystick port',13,10
		dc.b '               PORT (0 - 1).',13,10
		dc.b 13,10
		dc.b '               Returns TRUE (-1) if option-button pressed else FALSE (0).',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=_jagpad pause(PORT)',13,10
		dc.b 'Action    :-   Tests  the  condition  of the pause-button  of  the  jagpad',13,10
		dc.b '               (Jaguar controller) connected to the enhanced joystick port',13,10
		dc.b '               PORT (0 - 1).',13,10
		dc.b 13,10
		dc.b '               Returns TRUE (-1) if pause-button pressed else FALSE (0).',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   K$=_jagpad key$(PORT)',13,10
		dc.b "Action    :-   Reads  the  condition  of the 'phone-pad'  buttons  of  the",13,10
		dc.b '               jagpad  (Jaguar  controller)  connected  to  the   enhanced',13,10
		dc.b '               joystick port PORT (0 - 1).',13,10
		dc.b 13,10
		dc.b '               Returns  K$  holding  the ASCII  character  of  the  button',13,10
		dc.b '               pressed else returns K$ as a NULL string.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '------------------------ Memory/Vars Commands ----------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A=_aes in',13,10
		dc.b 'Action    :-   This function probes the presence of the AES.  Returns TRUE',13,10
		dc.b '               (-1) if present else FALSE (0). Useful to determine whether',13,10
		dc.b '               the program has been booted from the AUTO folder.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A$=_tos$',13,10
		dc.b 'Action    :-   This function returns the TOS version (as a five  character',13,10
		dc.b '               string) in A$.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=_phystop',13,10
		dc.b 'Action    :-   This function returns X pointing to the top of physical  ST',13,10
		dc.b '               compatible RAM in the machine.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=_memtop',13,10
		dc.b 'Action    :-   This  function  returns X pointing to  the  highest  memory',13,10
		dc.b '               location available for the system heap.  This value is used',13,10
		dc.b '               to initialise GEMDOS free memory.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '----------------------------- File Commands ------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b "               This  command  is  only available on  ST(e)/TT's  when  the",13,10
		dc.b "               patched   'SPRIT101.BIN'  and  'SPRIT101.LIB'   files   are",13,10
		dc.b '               installed  [the Falcon installation requires these  patches',13,10
		dc.b '               anyway].',13,10
		dc.b 13,10
		dc.b 'Command   :-   F$=_fileselect$(PATH$,TITLE$,BG_COLOUR,',13,10
		dc.b '                               BTN_COLOUR_1,BTN_COLOUR_2,',13,10
		dc.b '                               TXT_COLOUR_1,TXT_COLOUR_2)',13,10
		dc.b 13,10
		dc.b 'Action    :-   This  function allows a user to select files from a new  3D',13,10
		dc.b '               effect fileselector dialog box originally designed for  use',13,10
		dc.b "               within  the Falcon's non-ST video modes (the 16/256  colour",13,10
		dc.b '               palette modes and TRUE-COLOUR modes). This is now available',13,10
		dc.b '               for ST(e) users.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '               PATH$     =    A  string containing the search  mask  which',13,10
		dc.b '                              will be used to display the possible  files,',13,10
		dc.b '                              [same as for standard STOS fileselector].',13,10
		dc.b '               TITLE$    =    A string containing the title of the  dialog',13,10
		dc.b '                              box,  [same purpose as for the standard STOS',13,10
		dc.b '                              fileselector].',13,10
		dc.b '               BG_COLOUR =    The background colour of the dialog box.',13,10
		dc.b '               BTN_COLOUR_1\  These two colours determine the 3D effect of',13,10
		dc.b '               BTN_COLOUR_2/  the dialog buttons, [depending upon the set-',13,10
		dc.b '                              up of the palette these buttons will have a',13,10
		dc.b '                              3D look].',13,10
		dc.b '               TXT_COLOUR_1\  TXT_COLOUR_1 is the colour used for the de-',13,10
		dc.b '               TXT_COLOUR_2/  selected drive buttons and remaining button',13,10
		dc.b '                              texts.  TXT_COLOUR_2 is the colour used  for',13,10
		dc.b '                              the currently selected drive button and  the',13,10
		dc.b '                              display list of file/pathnames.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b 'IMPORTANT :-   The  _fileselect$   function   uses  a  completely  new  mouse',13,10
		dc.b "               pointer 'st mouse' from the ST(e)/TT/Falcon 030 System Control",13,10
		dc.b '               extension.  The  patch  for  this  mouse  is contained  within',13,10
		dc.b "               the  STOS  editor  'SPRIT101.BIN' and  compiler 'SPRIT101.LIB'",13,10
		dc.b '               files and are necessary for its operation.',13,10
		dc.b 13,10
		dc.b '               Although  the  _fileselect$  function  is compatible with  the',13,10
		dc.b '               ST(e) LOW/MED/HIGH rez modes you must ensure the standard STOS',13,10
		dc.b '               mouse is HIDDEN  otherwise mouse pointer confusion will arise.',13,10
		dc.b 13,10
		dc.b '               If   the  ST  mouse   [st mouse  command]  is  OFF  when  this',13,10
		dc.b '               fileselector  function  is  called it will automatically  turn',13,10
		dc.b '               ON  for  the duration of the _fileselect$ call and then turned',13,10
		dc.b '               OFF again upon quitting the fileselector.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A=_file exist(F$)',13,10
		dc.b 'Action    :-   Tests  the existence of the file specified by F$ (this  may',13,10
		dc.b '               be just the filename or may be the full-path-filename).',13,10
		dc.b 13,10
		dc.b '               Unlike most Basics that have this function this returns the',13,10
		dc.b '               value A=LENGTH of the file if it IS found else returns  A=0',13,10
		dc.b '               if the file is NOT found.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   _file attr FNAME$,ATTR',13,10
		dc.b 'Action    :-   To change a files attributes',13,10
		dc.b 13,10
		dc.b '               Where:-   FNAME$  = filename of file whose attribute is  to',13,10
		dc.b '                         be modified and ATTR = new attribute for the file',13,10
		dc.b 13,10
		dc.b '                         ATTR can have the following values :-',13,10
		dc.b 13,10
		dc.b '               0 = Normal, 1 = Read only, 2 = Hidden file, 4 = System file',13,10
		dc.b 13,10
		dc.b '               N.B.      Use with extreme caution !!!!!!!',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '-------------------- TT030/Falcon030 System Commands ---------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030 with Nemesis system accelerator.",13,10
		dc.b 'Command   :-   NEMESIS_FLAG=_nemesis',13,10
		dc.b 'Action    :-   This  command  function  returns TRUE (-1)  if  Nemesis  is',13,10
		dc.b '               detected in the cookie jar otherwise returns FALSE (0).',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   _cpuspeed N',13,10
		dc.b 'Action    :-   This command sets the clockrate of the 68030 CPU; where :-',13,10
		dc.b 13,10
		dc.b '               N    =    8 sets the clockrate to  8 MHz     *',13,10
		dc.b '               N    =   16 sets the clockrate to 16 MHz     *',13,10
		dc.b '               N    =   20 sets the clockrate to 20 MHz (Nemesis only)',13,10
		dc.b '               N    =   24 sets the clockrate to 24 MHz (Nemesis only)',13,10
		dc.b 13,10
		dc.b "               *    If  Nemesis  is not installed any other value  of  'N'",13,10
		dc.b '                    generates an illegal function error.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   _blitterspeed N',13,10
		dc.b 'Action    :-   This command,  although performing the same task as in  the',13,10
		dc.b '               previous  System  Control versions  now  works  differently',13,10
		dc.b '               depending on the presence of Nemesis.',13,10
		dc.b 13,10
		dc.b '               *    If Nemesis is not installed or is inactive (i.e.  when',13,10
		dc.b '                    the  cpu  speed = 8 MHz or 16 MHz) then  this  command',13,10
		dc.b '                    sets the clockrate of the Blitter chip; where',13,10
		dc.b 13,10
		dc.b '                    N    =    8 sets the clockrate to  8 MHz',13,10
		dc.b '                    N    =   16 sets the clockrate to 16 MHz',13,10
		dc.b 13,10
		dc.b "                    any  other value of 'N' generates an illegal  function",13,10
		dc.b '                    error.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '               *    If  Nemesis  is  installed and  is  active  then  this',13,10
		dc.b '                    command  returns  unprocessed (the  clockrate  of  the',13,10
		dc.b '                    Blitter  chip is not changed).  I once read  somewhere',13,10
		dc.b "                    that the Blitter chip couldn't be clocked faster  than",13,10
		dc.b '                    16 MHz and this seems to be confirmed when Nemesis  is',13,10
		dc.b '                    installed and active.',13,10
		dc.b 13,10
		dc.b 'With Nemesis installed and active the BSS Nemesis software configures  the',13,10
		dc.b 'blitter  clockrate to be the CPU clockrate/2.  I have simply followed  the',13,10
		dc.b "same 'rules' in my extension.",13,10
		dc.b 13,10
		dc.b 'e.g. When Nemesis is clocking the system at Nemesis-Lowspeed (20 MHz)  the',13,10
		dc.b '     blitter  will  be clocked at 10 MHz.  When Nemesis  is  clocking  the',13,10
		dc.b '     system  at Nemesis-Highspeed (24 MHz) the blitter will be clocked  at',13,10
		dc.b '     12 MHz.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   TT030/Falcon030 - this is a 68030 CPU feature.",13,10
		dc.b 'Command   :-   _cpucache on',13,10
		dc.b "Action    :-   This   command   clears  and  enables  the   M68030   CPU's",13,10
		dc.b '               instruction/data cache.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   TT030/Falcon030 - this is a 68030 CPU feature.",13,10
		dc.b 'Command   :-   _cpucache off',13,10
		dc.b "Action    :-   This   command  clears  and  disables  the   M68030   CPU's",13,10
		dc.b '               instruction/data cache.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   TT030/Falcon030 - this is a 68030 CPU feature.",13,10
		dc.b 'Command   :-   X=_cpucache stat',13,10
		dc.b 'Action    :-   This function returns X containing a 32 bit value from  the',13,10
		dc.b "               68030 CPU's CACR (cache control register),  thus  returning",13,10
		dc.b "               the enabled/disabled status of the 68030's cpu cache.",13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   _falconbus',13,10
		dc.b "Action    :-   This command returns the Falcon 030's system bus control to",13,10
		dc.b '               Falcon mode.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   _stebus',13,10
		dc.b 'Action    :-   This  command  was originally ste bus,  but  was  found  to',13,10
		dc.b '               conflict  with the X=ste function of the STE  extension  by',13,10
		dc.b '               ASA  BURROWS  therefore  the  slight  modification  to  the',13,10
		dc.b '               spelling.  (No  two extensions may have a command with  the',13,10
		dc.b '               same name.)',13,10
		dc.b 13,10
		dc.b "               This  command sets the Falcon 030's system bus  control  to",13,10
		dc.b '               emulate the STe.  This is achieved by clearing the required',13,10
		dc.b '               bits  at address $FF8007 (the Falcon 030 processor  control',13,10
		dc.b '               register).',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   B=_busmode',13,10
		dc.b "Action    :-   This function returns the current state of the Falcon 030's",13,10
		dc.b '               system bus control, B returns a bitmap as follows :-',13,10
		dc.b 13,10
		dc.b '                                             Bit 7_6_5_4_3_2_1_0',13,10
		dc.b '                                                     |     |   |',13,10
		dc.b "                    STe Bus emulation  (0 = on) -----'     |   |",13,10
		dc.b "                    Blitter   (0=8mHz, 1=16mHz) -----------'   |",13,10
		dc.b "                    68030 CPU (0=8mHz, 1=16mHz) ---------------'",13,10
		dc.b 13,10
		dc.b '               Note;     Bits   0 and 2 are manipulated by  the  _cpuspeed',13,10
		dc.b '                         and _blitterspeed commands respectively.',13,10
		dc.b 13,10
		dc.b '                         If,  at any time a program needs to determine the',13,10
		dc.b '                         clockrate  the  CPU or Blitter was last  set  to,',13,10
		dc.b '                         _busmode  may be used and the bitmap interrogated',13,10
		dc.b '                         for the current clockrate setting(s).',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '------------------------- IDE Hard drive Commands ------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   ide off',13,10
		dc.b 'Action    :-   This command switches off the internal IDE hard drive.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   Falcon 030's only.",13,10
		dc.b 'Command   :-   ide on',13,10
		dc.b 'Action    :-   This command switches on the internal IDE hard drive.',13,10
		dc.b 'Important :-   These  last two commands are NOT supported by the  compiler',13,10
		dc.b '               extension  as  it  was felt that they  are  not  really  of',13,10
		dc.b '               serious use from within a compiled program.',13,10
		dc.b 'More.... Y/N',13,0
		dc.b '------------------------ Paddle/Lightpen Commands ------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=paddle x(P)',13,10
		dc.b 'Action    :-   Returns the x-coordinates of paddle P.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   Y=paddle y(P)',13,10
		dc.b 'Action    :-   Returns the y-coordinates of the paddle P.',13,10
		dc.b 13,10
		dc.b 'Note;     In  both these functions the paddle to be inquired is  given  by',13,10
		dc.b "          'P' and may be in the range 0 - 3 inclusive.",13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=lpen x',13,10
		dc.b 'Action    :-   Returns the x-coordinates of the light gun/pen.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All STe's/Falcon 030's.",13,10
		dc.b 'Command   :-   Y=lpen y',13,10
		dc.b 'Action    :-   Returns the y-coordinates of the light gun/pen.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '------------------------- Printer Port Commands --------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :    _set printer X',13,10
		dc.b 'Action    :    This command sets the printer configuration.',13,10
		dc.b 13,10
		dc.b '               X is a bit-map defined as follows:-',13,10
		dc.b 13,10
		dc.b '               Bit  When clear          When set',13,10
		dc.b 13,10
		dc.b '                0   Dot Matrix          Daisy Wheel',13,10
		dc.b '                1   Monochrome          Colour',13,10
		dc.b '                2   Atari Printer       Epson Compatible Printer',13,10
		dc.b '                3   Draft Mode          Final Mode',13,10
		dc.b '                4   Parallel Port       Serial Port',13,10
		dc.b '                5   Continuous Feed     Single Sheet Feed',13,10
		dc.b '               6-15 Unused              Unused',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :    A=_printer ready',13,10
		dc.b 'Action    :    This  function returns the status of  the  printer (returns',13,10
		dc.b '               TRUE if ready else FALSE).',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '---------------------------- String Commands -----------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   code$ A$,N',13,10
		dc.b "Action    :-   Encodes the string A$ by adding the value 'N' to each ASCII",13,10
		dc.b '               character.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   uncode$ A$,N',13,10
		dc.b "Action    :-   Decodes  the  string A$ by subtracting the value  'N'  from",13,10
		dc.b '               each ASCII character.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   lset$ A$,B$',13,10
		dc.b 'Action    :-   Left justifies the  string B$ into the string A$.',13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   rset$ A$,B$',13,10
		dc.b 'Action    :-   Right justifies the  string B$ into the string A$.',13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '-------------------------- Arithmetic Commands ---------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A=_add cbound(A,I,L,U)',13,10
		dc.b "Action    :-   Cyclic  integer addition of 'I' to 'A' checking the  result",13,10
		dc.b "               in 'A' is within the lower bound 'L' and upper bound 'U'.",13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A=_sub cbound(A,I,L,U)',13,10
		dc.b "Action    :-   Cyclic  integer  subtraction of 'I' from 'A'  checking  the",13,10
		dc.b "               result in 'A' is within the lower bound 'L' and upper bound",13,10
		dc.b "               'U'.",13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A=_add ubound(A,I,U)',13,10
		dc.b "Action    :-   Integer  addition of 'I' to 'A' checking the result in  'A'",13,10
		dc.b "               is within upper bound 'U'.",13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   A=_sub lbound(A,I,L)',13,10
		dc.b "Action    :-   Integer subtraction of 'I' from 'A' checking the result  in",13,10
		dc.b "               'A' is within the lower bound 'L'.",13,10
		dc.b 13,10
		dc.b 'More.... Y/N',13,0
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=odd(A)',13,10
		dc.b 'Action    :-   X=TRUE (-1) if value A is odd otherwise X=FALSE (0).',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b "Machine   :-   All ST's/TT's/Falcon 030's.",13,10
		dc.b 'Command   :-   X=even(A)',13,10
		dc.b 'Action    :-   X=TRUE (-1) if value A is even otherwise X=FALSE (0).',13,10
		dc.b 13,10
		dc.b '--------------------------------------------------------------------------',13,10
		dc.b 13,10
		dc.b 'End of command reference... Press N to exit.',13,10
		dc.b 0
		.even
		dc.w 0
		dc.w 0

	.bss

spritelib_ok: ds.w 1 /* 18a36 */
rgbpalette: ds.l 256 /* 18a38 */

finprg: /* 18e38 */
	ds.l 1

ZERO = 0
