		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"

MAX_STARS = 512

STARS_FLAT     = 1
STARS_PARALLAX = 2
STARS_ZOOM     = 3

		.text

		bra.w        load

		.text

        dc.b $80
tokens:
        dc.b "set stars",$80
        /* $81 unused */
        dc.b "go stars",$82
        /* $83 unused */
        dc.b "wipe stars on",$84
        /* $85 unused */
        dc.b "wipe stars off",$86
        /* $87 unused */
        dc.b "stars cmds",$88

        dc.b 0
        even

jumps: dc.w 9
       dc.l setstars
       dc.l dummy
       dc.l gostars
       dc.l dummy
       dc.l wipe_stars_on
       dc.l dummy
       dc.l wipe_stars_off
       dc.l dummy
       dc.l stars_cmds

welcome:
       dc.b 10
       dc.b "ST(e)/TT/Falcon 030 STARS v1.4 by Anthony Hoskin.[type 'stars cmds']",0
       /* dc.b "STARS By Lee Upcraft.  V2.6",0 */
       dc.b 10
       dc.b "ST(e)/TT/Falcon 030 STARS v1.4 by Anthony Hoskin.[type 'stars cmds']",0
       /* dc.b "STARS By Lee Upcraft.  V2.6",0 */
       .even

table: dc.l 0
returnpc: dc.l 0
mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0

load:
	lea.l      finprg(pc),a0
	lea.l      cold(pc),a1
	rts

cold:
	move.l     a0,table
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
	move.w     #17,-(a7) /* Random */
	trap       #14
	addq.l     #2,a7
	move.l     d0,seed
		dc.w 0xa000
		lea.l      lineavars(pc),a1
		move.l     a0,(a1)
	lea.l      welcome(pc),a0
	lea.l      warm(pc),a1
	lea.l      tokens(pc),a2
	lea.l      jumps(pc),a3
	rts

warm:
	rts

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
		move.l     d0,d7
		rts

getparam:
	movea.l    (a7)+,a0
	movem.l    (a7)+,d2-d4
	tst.b      d2
	bne.s      typemismatch
	jmp        (a0)

addrofbank: /* unused */
	movem.l    a0-a2,-(a7)
	movea.l    table(pc),a0
	movea.l    sys_addrofbank(a0),a0
	jsr        (a0)
	movem.l    (a7)+,a0-a2
	rts

syntax:
	moveq.l    #E_syntax,d0
	bra.s      goerror
typemismatch:
	moveq.l    #E_typemismatch,d0
	bra.s      goerror
illfunc:
	moveq.l    #E_illegalfunc,d0
goerror:
	movea.l    table(pc),a0
	movea.l    sys_error(a0),a0
	jmp        (a0)

prillmsg:
	lea.l      illmsg(pc),a2
	move.l     #$00010001,d0
	bra.s      prmsg
prundefined:
	lea.l      undefinedmsg(pc),a2
	move.l     #$00010002,d0
	bra.s      prmsg
prtoomany:
	lea.l      toomanymsg(pc),a2
	move.l     #$00010003,d0
prmsg:
	movea.l    table(pc),a0
	movea.l    sys_err2(a0),a0
	jmp        (a0)
illmsg:
	dc.b "Illegal stars type (Must be 0 - 2)",0
	dc.b "Illegal stars type (Must be 0 - 2)",0
toomanymsg:
	dc.b "Too many stars (Must be <= 512)",0
	dc.b "Too many stars (Must be <= 512)",0
undefinedmsg:
	dc.b "Stars not defined",0
	dc.b "Stars not defined",0
	.even

dummy:
	move.l     (a7)+,returnpc
	bra        syntax

nrand:
	movem.l    a0-a6,-(a7)
	move.w     #17,-(a7) /* Random */
	trap       #14
	addq.l     #2,a7
	andi.l     #$0000FFFF,d0
	sub.l      d5,d6
	divu.w     d6,d0
	swap       d0
	movem.l    (a7)+,a0-a6
	rts

nextstar:
	move.l     seed(pc),d0
	mulu.w     rndfac(pc),d0
	addq.l     #1,d0
	andi.l     #$0000FFFF,d0
	lea        seed(pc),a4
	move.l     d0,(a4)
	movem.w    start_x(pc),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	lea        curr_x(pc),a4
	move.w     d0,(a4)
	move.l     seed(pc),d0
	movem.w    start_y(pc),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	lea        curr_y(pc),a4
	move.w     d0,(a4)
	move.l     seed(pc),d0
	movem.w    startcolor(pc),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	lea        curr_color(pc),a4
	move.w     d0,(a4)
	rts

setpix:
	movea.l    screenaddr(pc),a0
	move.w     d0,d4
	andi.l     #0xFFF0,d4
	lsr.l      #4,d4
	mulu.w     nxwd(pc),d4
	andi.w     #$FFFF,d1
	mulu.w     bytes_lin(pc),d1
	adda.l     d1,a0
	adda.l     d4,a0
	andi.w     #15,d0
	subi.w     #15,d0
	neg.w      d0
	moveq      #0,d1
	bset       d0,d1
	move.w     d1,d3
	not.w      d3
	move.w     nbplanes(pc),d0
	subq.w     #1,d0
setpix1:
	lsr.w      #1,d2
	bcc.s      setpix2
	or.w       d1,(a0)+
	bra.s      setpix3
setpix2:
	and.w      d3,(a0)+
setpix3:
	dbf        d0,setpix1
	rts

isin:
	lea.l      sintab(pc),a1
	cmpi.w     #360,d6
	bmi.s      isin0
	subi.w     #360,d6
isin0:
	cmpi.w     #270,d6
	bmi.s      isin1
	bsr.s      isin4
	rts
isin1:
	cmpi.w     #180,d6
	bmi.s      isin2
	bsr.s      isin5
	rts
isin2:
	cmpi.w     #90,d6
	bmi.s      isin3
	bsr.s      isin6
	rts
isin3:
	add.w      d6,d6
	move.w     0(a1,d6.w),d0
	subi.w     #180,d6
	neg.w      d6
	move.w     0(a1,d6.w),d1
	rts
isin4:
	subi.w     #360,d6
	neg.w      d6
	add.w      d6,d6
	move.w     0(a1,d6.w),d0
	neg.w      d0
	subi.w     #180,d6
	neg.w      d6
	move.w     0(a1,d6.w),d1
	rts
isin5:
	subi.w     #180,d6
	add.w      d6,d6
	move.w     0(a1,d6.w),d0
	neg.w      d0
	subi.w     #180,d6
	neg.w      d6
	move.w     0(a1,d6.w),d1
	neg.w      d1
	rts
isin6:
	subi.w     #180,d6
	neg.w      d6
	add.w      d6,d6
	move.w     0(a1,d6.w),d0
	subi.w     #180,d6
	neg.w      d6
	move.w     0(a1,d6.w),d1
	neg.w      d1
	rts



wipe_stars_on:
	move.l     (a7)+,returnpc
	tst.w      d0
	bne        syntax
	move.w     #-1,wipe_on
	move.l     returnpc(pc),a0
	jmp        (a0)

wipe_stars_off:
	move.l     (a7)+,returnpc
	tst.w      d0
	bne        syntax
	move.w     #0,wipe_on
	move.l     returnpc(pc),a0
	jmp        (a0)


/*
 * SET STARS count,type,sx,sy,ex,ey,sc,ec
 */
setstars:
	move.l     (a7)+,returnpc
	cmpi.w     #8,d0
	bne        syntax
	bsr        getparam
	addq.w     #1,d3
	move.w     d3,endcolor
	bsr        getparam
	move.w     d3,startcolor
	bsr        getparam
	addq.w     #1,end_y /* FIXME: useless */
	move.w     d3,end_y
	bsr        getparam
	move.w     d3,end_x
	bsr        getparam
	move.w     d3,start_y
	bsr        getparam
	move.w     d3,start_x
	bsr        getparam
	move.w     d3,stars_type
	bsr        getparam
	subq.w     #1,d3
	move.w     d3,stars_count
	movem.w    start_x(pc),d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	movem.w    start_y(pc),d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	movem.w    startcolor(pc),d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	move.w     stars_count,d5
	cmpi.w     #MAX_STARS-1,d5
	ble.s      setstars1
	bra        prtoomany
setstars1:
    move.l     lineavars(pc),a0
    lea.l      bytes_lin(pc),a1
    move.l     #32000,screen_size-bytes_lin(a1)
	move.w     vdo_cookie(pc),d6
	cmpi.w     #3,d6
	bne.s      setstars1_1
	move.w     V_BYTES_LIN(a0),d0
	andi.l     #$0000FFFF,d0
	move.w     DEV_TAB+2(a0),d1
	addq.w     #1,d1
	andi.l     #$0000FFFF,d1
	mulu.w     d1,d0
	move.l     d0,screen_size-bytes_lin(a1)
setstars1_1:
	move.w     V_BYTES_LIN(a0),bytes_lin-bytes_lin(a1)
	move.w     LA_PLANES(a0),d0
	move.w     d0,nbplanes-bytes_lin(a1)
	asl.w      #1,d0
	move.w     d0,nxwd-bytes_lin(a1)


	lea.l      starfield(pc),a2
	movem.w    start_x(pc),d0-d3
	move.w     d5,(a2)
	lea        curr_start_x(pc),a4
	movem.w    d0-d3,(a4)
	addq.l     #2,a2
setstars2:
	bsr        nextstar
	lea        stars_type(pc),a4
	cmpi.w     #2,(a4)
	bhi        prillmsg
	beq.s      setstars5
	lea        stars_type(pc),a4
	cmpi.w     #STARS_ZOOM-1,(a4)
	beq.s      setstars3
	moveq      #1,d3
	bra.s      setstars4
setstars3:
	move.w     curr_color(pc),d3
	move.w     startcolor(pc),d1
	sub.w      d1,d3
	addq.w     #1,d3
setstars4:
	movem.w    curr_x(pc),d0-d2
	movem.w    d0-d4,(a2)
	addq.l     #8,a2
	dbf        d5,setstars2
	lea        stars_type(pc),a4
	addq.w     #1,(a4)
	movea.l    returnpc(pc),a0
	jmp        (a0)
setstars5:
	move.w     d5,d7
	movem.w    start_x(pc),d0-d3
	sub.l      d0,d1
	sub.l      d2,d3
	lsr.w      #1,d1
	lsr.w      #1,d3
	cmp.w      d1,d3
	bhi.s      setstars6
	lea        x106c0(pc),a4
	move.w     d1,(a4)
	bra.s      setstars7
setstars6:
	lea        x106c0(pc),a4
	move.w     d3,(a4)
setstars7:
	add.w      start_x(pc),d1
	add.w      start_y(pc),d3
	lea        zoomx(pc),a4
	movem.w    d1/d3,(a4)
	move.w     x106c0(pc),d0
	movem.w    startcolor(pc),d1-d2
	sub.w      d1,d2
	addq.w     #1,d2
	lea        curr_end_color(pc),a4
	move.w     d2,(a4)
	movem.w    start_x(pc),d0-d1
	add.l      d0,d1
	lsr.l      #1,d1
	mulu.w     #512,d2
	divu.w     d1,d2
	lea        rndcolor(pc),a4
	move.w     d2,(a4)
setstars8:
	moveq      #0,d5
	move.w     #359,d6
	bsr        nrand
	move.w     d0,d6
	bsr        isin
	movem.w    d0-d1,(a2)
	addq.l     #4,a2
	movem.w    startcolor(pc),d5-d6
	bsr        nrand
	mulu.w     rndcolor(pc),d0
	move.w     d0,(a2)+
	moveq      #0,d5
	moveq      #20,d6
	bsr        nrand
	move.w     d0,(a2)+
	move.w     x106c0(pc),d6
	bsr        nrand
	move.w     d0,(a2)+
	dbf        d7,setstars8
setstars9:
	lea        stars_type(pc),a4
	addq.w     #1,(a4)
	movea.l    returnpc(pc),a0
	jmp        (a0)

/*
 * GO STARS movex,movey[,screenno]
 */
gostars:
	move.l     (a7)+,returnpc
	move.l     #0,screenaddr
	cmpi.w     #2,d0
	beq        gostars0
	cmpi.w     #3,d0
	bne        syntax
	bsr        getparam
	move.l     d3,screenaddr
gostars0:
	bsr        getparam
	move.w     d3,movey
	bsr        getparam
	move.w     d3,movex
	lea        stars_type(pc),a0
	/* tst.w     (a0) */
	dc.w 0x0c50,0 /* XXX */
	beq        prundefined
	movem.l    d0-d7/a0-a6,-(a7)
	move.l     screenaddr(pc),d0
	bne.s      screen_set
	move.w     #3,-(a7) /* Logbase */
	trap       #14
	addq.l     #2,a7
	lea.l      screenaddr(pc),a0
	move.l     d0,(a0)
screen_set:
	tst.w      wipe_on
	beq        gostars1

	movem.l    d0-d7/a0-a6,-(a7)
	lea.l      bitblt(pc),a1
	move.w     nbplanes(pc),d7
	move.w     d7,d5
	lea.l      start_x(pc),a0
	move.w     start_x-start_x(a0),d0
	move.w     start_y-start_x(a0),d1
	move.w     end_x-start_x(a0),d2
	move.w     end_y-start_x(a0),d3
	sub.w      d0,d2
	sub.w      d1,d3
	addq.w     #1,d2
	addq.w     #1,d3
	cmpi.w     #16,d7
	beq        fastcls2
	cmpi.w     #8,d7
	blt.s      fastcls1
	moveq.l    #4,d5
	movem.l    d0-d7/a0-a1,-(a7)
	move.w     d2,(a1)+ /* b_wd */
	move.w     d3,(a1)+ /* b_ht */
	move.w     d5,(a1)+ /* plane_cnt */
	move.w     #12,(a1)+ /* fg_col */
	move.w     #10,(a1)+ /* bg_col */
	move.l     #0,(a1)+ /* op_tab 4 x ALL_WHITE */
	move.w     d0,(a1)+ /* s_xmin */
	move.w     d1,(a1)+ /* s_ymin */
	movea.l    screenaddr(pc),a2
	addq.l     #8,a2
	move.l     a2,(a1)+ /* s_form */
	move.w     nxwd(pc),(a1)+ /* s_nxwd */
	move.w     bytes_lin(pc),(a1)+ /* s_nxln */
	move.w     #2,(a1)+ /* s_nxpl */
	move.w     d0,(a1)+ /* d_xmin */
	move.w     d1,(a1)+ /* d_ymin */
	movea.l    screenaddr(pc),a2
	addq.l     #8,a2
	move.l     a2,(a1)+ /* d_form */
	move.w     nxwd(pc),(a1)+ /* d_nxwd */
	move.w     bytes_lin(pc),(a1)+ /* d_nxln */
	move.w     #2,(a1)+ /* d_nxpl */
	move.l     #0,(a1)+ /* p_addr */
	lea.l      bitblt,a6
	dc.w 0xa007 /* bit_blt */
	movem.l    (a7)+,d0-d7/a0-a1
fastcls1:
	move.w     d2,(a1)+ /* b_wd */
	move.w     d3,(a1)+ /* b_ht */
	move.w     d5,(a1)+ /* plane_cnt */
	move.w     #12,(a1)+ /* fg_col */
	move.w     #10,(a1)+ /* bg_col */
	move.l     #0,(a1)+ /* op_tab 4 x ALL_WHITE */
	move.w     start_y-start_x(a0),(a1)+ /* s_xmin */
	move.w     end_y-start_x(a0),(a1)+ /* s_ymin */
	move.l     screenaddr(pc),(a1)+ /* s_form */
	move.w     nxwd(pc),(a1)+ /* s_nxwd */
	move.w     bytes_lin(pc),(a1)+ /* s_nxln */
	move.w     #2,(a1)+ /* s_nxpl */
	move.w     d0,(a1)+ /* d_xmin */
	move.w     d1,(a1)+ /* d_ymin */
	move.l     screenaddr(pc),(a1)+ /* d_form */
	move.w     nxwd(pc),(a1)+ /* d_nxwd */
	move.w     bytes_lin(pc),(a1)+ /* d_nxln */
	move.w     #2,(a1)+ /* d_nxpl */
	move.l     #0,(a1)+ /* p_addr */
	lea.l      bitblt,a6
	dc.w 0xa007 /* bit_blt */
fastcls2:
	movem.l    (a7)+,d0-d7/a0-a6

gostars1:
	lea.l      starfield(pc),a2
	movem.w    (a2)+,d7
	lea        stars_type(pc),a4
	cmpi.w     #STARS_ZOOM,(a4)
	beq        gostars9
	movem.w    movex(pc),d5-d6
gostars2:
	movem.w    (a2),d0-d3
	move.w     d3,d4
	tst.w      d5
	beq.s      gostars3
	muls.w     d5,d3
	add.w      d3,d0
	cmp.w      curr_start_x(pc),d0
	ble.s      gostars6
	cmp.w      curr_end_x(pc),d0
	bhi.s      gostars5
gostars3:
	tst.w      d6
	beq.s      gostars4
	muls.w     d6,d4
	add.w      d4,d1
	cmp.w      curr_start_y(pc),d1
	blt.s      gostars8
	cmp.w      curr_end_y(pc),d1
	bhi.s      gostars7
gostars4:
	movem.w    d0-d1,(a2)
	addq.w     #8,a2
	bsr        setpix
	dbf        d7,gostars2
	movem.l    (a7)+,d0-d7/a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)
gostars5:
	move.w     curr_start_x(pc),d0
	bra.s      gostars3
gostars6:
	move.w     curr_end_x(pc),d0
	bra.s      gostars3
gostars7:
	move.w     curr_start_y(pc),d1
	bra.s      gostars4
gostars8:
	move.w     curr_end_y(pc),d1
	bra.s      gostars4
gostars9:
	movem.w    (a2),d0-d4
	movem.w    movex(pc),d5-d6
	muls.w     d4,d0
	lsl.l      #2,d0
	swap       d0
	add.w      zoomx(pc),d0
	tst.w      d5
	beq.s      gostars10
	muls.w     d3,d5
	asr.w      #1,d5
	add.w      d5,d0
gostars10:
	muls.w     d4,d1
	lsl.l      #2,d1
	swap       d1
	add.w      zoomy(pc),d1
	tst.w      d6
	beq.s      gostars11
	muls.w     d3,d6
	asr.w      #1,d6
	add.w      d6,d1
gostars11:
	addq.w     #1,d3
	move.w     d3,d6
	lsr.w      #1,d6
	add.w      d6,d4
	add.w      rndcolor(pc),d2
	addq.w     #4,a2
	movem.w    d2-d4,(a2)
	lsr.w      #6,d2
	cmp.w      curr_start_x(pc),d0
	ble.s      gostars13
	cmp.w      curr_end_x(pc),d0
	bhi.s      gostars13
	cmp.w      curr_start_y(pc),d1
	ble.s      gostars13
	cmp.w      curr_end_y(pc),d1
	bhi.s      gostars13
	cmp.w      curr_end_color(pc),d2
	bhi.s      gostars13
	bsr        setpix
gostars12:
	addq.w     #6,a2
	dbf        d7,gostars9
	movem.l    (a7)+,d0-d7/a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)
gostars13:
	clr.l      (a2)
	move.w     seed(pc),d4
	mulu.w     rndfac(pc),d4
	addq.w     #1,d4
	andi.l     #$0000FFFF,d4
	lea        seed(pc),a4
	move.w     d4,(a4)
	divu.w     x106c0(pc),d4
	swap       d4
	move.w     d4,4(a2)
	bra.s      gostars12

stars_cmds:
		move.l     (a7)+,returnpc
		/* tst.w      d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		lea.l      stars_hlp(pc),a0
stars_cmds1:
		tst.b      (a0)
		beq.s      stars_cmds4
		movem.l    a0-a6,-(a7)
		moveq.l    #W_prtstring,d7
		trap       #3
		movem.l    (a7)+,a0-a6
stars_cmds2:
		tst.b      (a0)+
		bne.s      stars_cmds2
stars_cmds3:
		movem.l    a0-a6,-(a7)
		move.w     #255,-(a7)
		move.w     #6,-(a7) /* Crawio */
		trap       #1
		addq.l     #4,a7
		bclr       #5,d0
		movem.l    (a7)+,a0-a6
		tst.l      d0
		beq.s      stars_cmds3
		cmpi.b     #'Y',d0
		beq.s      stars_cmds1
		cmpi.b     #'N',d0
		bne.s      stars_cmds3
stars_cmds4:
		movem.l    (a7)+,d1-d7/a0-a6
		movea.l    returnpc(pc),a0
		jmp        (a0)

	.data

rndfac:  dc.w 31621

sintab:
	.dc.w 0
	.dc.w 0x011d
	.dc.w 0x023b
	.dc.w 0x0359
	.dc.w 0x0476
	.dc.w 0x0593
	.dc.w 0x06b0
	.dc.w 0x07cc
	.dc.w 0x08e8
	.dc.w 0x0a03
	.dc.w 0x0b1d
	.dc.w 0x0c36
	.dc.w 0x0d4e
	.dc.w 0x0e65
	.dc.w 0x0f7b
	.dc.w 0x1090
	.dc.w 0x11a4
	.dc.w 0x12b6
	.dc.w 0x13c6
	.dc.w 0x14d6
	.dc.w 0x15e3
	.dc.w 0x16ef
	.dc.w 0x17f9
	.dc.w 0x1901
	.dc.w 0x1a07
	.dc.w 0x1b0c
	.dc.w 0x1c0e
	.dc.w 0x1d0e
	.dc.w 0x1e0b
	.dc.w 0x1f07
	.dc.w 0x1fff
	.dc.w 0x20f6
	.dc.w 0x21ea
	.dc.w 0x22db
	.dc.w 0x23c9
	.dc.w 0x24b5
	.dc.w 0x259e
	.dc.w 0x2684
	.dc.w 0x2766
	.dc.w 0x2846
	.dc.w 0x2923
	.dc.w 0x29fc
	.dc.w 0x2ad3
	.dc.w 0x2ba5
	.dc.w 0x2c75
	.dc.w 0x2d41
	.dc.w 0x2e09
	.dc.w 0x2ece
	.dc.w 0x2f8f
	.dc.w 0x304d
	.dc.w 0x3106
	.dc.w 0x31bc
	.dc.w 0x326e
	.dc.w 0x331c
	.dc.w 0x33c6
	.dc.w 0x346c
	.dc.w 0x350e
	.dc.w 0x35ac
	.dc.w 0x3646
	.dc.w 0x36db
	.dc.w 0x376c
	.dc.w 0x37f9
	.dc.w 0x3882
	.dc.w 0x3906
	.dc.w 0x3985
	.dc.w 0x3a00
	.dc.w 0x3a77
	.dc.w 0x3ae9
	.dc.w 0x3b56
	.dc.w 0x3bbf
	.dc.w 0x3c23
	.dc.w 0x3c83
	.dc.w 0x3cde
	.dc.w 0x3d34
	.dc.w 0x3d85
	.dc.w 0x3dd1
	.dc.w 0x3e19
	.dc.w 0x3e5c
	.dc.w 0x3e99
	.dc.w 0x3ed2
	.dc.w 0x3f07
	.dc.w 0x3f36
	.dc.w 0x3f60
	.dc.w 0x3f85
	.dc.w 0x3fa6
	.dc.w 0x3fc1
	.dc.w 0x3fd8
	.dc.w 0x3fe9
	.dc.w 0x3ff6
	.dc.w 0x3ffd
	.dc.w 0x4000


stars_hlp:
	dc.b 13,10
	dc.b 'Quick command reference for the ST(e)/TT/Falcon 030 STARS v1.4 extension 1998',13,10
	dc.b '(based on the original STARS extension by Lee Upcraft).',13,10
	dc.b 13,10
	dc.b '                       Anthony Hoskin.',13,10
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
	dc.b 'Command   :-   stars cmds',13,10
	dc.b 'Action    :-   Lists this command reference.',13,10
	dc.b 13,10,'More.... Y/N',13,0
	dc.b '--------------------------------------------------------------------------',13,10
	dc.b 13,10
	dc.b 'Command   :-   set stars N,T,SX,SY,EX,EY,SC,EC',13,10
	dc.b 'Action    :-   This sets up the star field, where;',13,10
	dc.b 13,10
	dc.b '               N  = Number of stars - (1 to 512)',13,10
	dc.b '               T  = 0 for flat stars or',13,10
	dc.b '               T  = 1 for parallax stars or',13,10
	dc.b "               T  = 2 for 'zooming' stars that move between the coords",13,10
	dc.b '                      SX,SY,EX and EY with colours between SC and EC.',13,10
	dc.b 13,10
	dc.b 'More.... Y/N',13,0
	dc.b "               SX = Start Xcoord   \    As in Lee Upcraft's original STARS",13,10
	dc.b '               SY = Start Ycoord        extension these coordinates define',13,10
	dc.b '               EX = End Xcoord          the rectangle X1,X2,Y1,Y2 used by',13,10
	dc.b "               EY = End Ycoord     /    the 'stars'.",13,10
	dc.b 13,10
	dc.b '               SC = Start colour   \    If  the type is set  for  parallax',13,10
	dc.b '               EC = End  colour    /    stars,   then  stars  with  lowest',13,10
	dc.b '                                        colour   (i.e.,   SC)  will   move',13,10
	dc.b '                                        slowest while highest colour stars',13,10
	dc.b '                                        (i.e., EC) will move fastest.',13,10
	dc.b 13,10
	dc.b 'More.... Y/N',13,0
	dc.b '               When using this extension on the Falcon 030, the parameters',13,10
	dc.b '               SC  and EC may take any valid colour index number  relating',13,10
	dc.b '               to the current Falcon video mode i.e.,',13,10
	dc.b 13,10
	dc.b '               In  16 colour video modes :-  SC and EC ranges 0 - 15',13,10
	dc.b '               In 256 colour video modes :-  SC and EC ranges 0 - 255',13,10
	dc.b 13,10
	dc.b 'More.... Y/N',13,0
	dc.b '--------------------------------------------------------------------------',13,10
	dc.b 13,10
	dc.b "The 'go stars' command has been modified to be compatible with a new sprite",13,10
	dc.b "engine I'm developing for the Falcon 030  - [if this sprite engine turns",13,10
	dc.b 'out OK it will also be compatible with the ST(e)].',13,10
	dc.b 13,10
	dc.b "                       The old 'go stars' command.",13,10
	dc.b 13,10
	dc.b 'Command   :-   go stars X,Y,SCREEN',13,10
	dc.b 'Action    :-   This  moves stars defined with set stars by multiples of  X',13,10
	dc.b '               and  Y along the X and Y axis.  Negative numbers move  left',13,10
	dc.b '               and up,  positive move right and down,  stars will be drawn',13,10
	dc.b "               on  'SCREEN',  this  should be loaded with  logical  screen",13,10
	dc.b '               address. Stars are NOT drawn on the sprites BACK screen.',13,10
	dc.b 13,10
	dc.b 'More.... Y/N',13,0
	dc.b "                       The new 'go stars' command.",13,10
	dc.b 13,10
	dc.b 'Command   :-   go stars X,Y[,SCREEN]',13,10
	dc.b 'Action    :-   This  moves stars defined with set stars by multiples of  X',13,10
	dc.b '               and  Y along the X and Y axis.  Negative numbers move  left',13,10
	dc.b '               and up, positive move right and down.',13,10
	dc.b 13,10
	dc.b '               SCREEN is now an optional parameter,  if this parameter  is',13,10
	dc.b '               passed  then its value is the address of the  LOGIC  screen',13,10
	dc.b '               where the stars are to be drawn.',13,10
	dc.b 13,10
	dc.b '               If  the  SCREEN  parameter is omitted -  the  command  will',13,10
	dc.b '               automatically  fetch  the address of  the  CURRENT  logical',13,10
	dc.b '               screen.',13,10
	dc.b 13,10
	dc.b 'More.... Y/N',13,0
	dc.b '--------------------------------------------------------------------------',13,10
	dc.b 13,10
	dc.b 'Command   :-   wipe stars on',13,10
	dc.b 'Action    :-   Putting this command at the beginning of your program  will',13,10
	dc.b '               automatically  erase  the screen and then draw  the  stars.',13,10
	dc.b 13,10
	dc.b '               My  modified  version  uses the LINE_A  routines  (and  the',13,10
	dc.b '               Blitter  chip when available) and now erases ONLY the  area',13,10
	dc.b '               bounded by the SX,SY,EX,EY coordinates.  This means that it',13,10
	dc.b "               is  now possible to display the 'stars' inside a  spaceship",13,10
	dc.b '               window  for  example  and to erase  only  that  window  and',13,10
	dc.b '               unnecessary to redraw the whole screen.',13,10
	dc.b 13,10
	dc.b 'More.... Y/N',13,0
	dc.b '--------------------------------------------------------------------------',13,10
	dc.b 13,10
	dc.b 'Command   :-   wipe stars off',13,10
	dc.b 'Action    :-   Turns off the automatic clearing process.',13,10
	dc.b 13,10
	dc.b 'End of command reference... Press N to exit.',13,10,0
	.even
	dc.w 0
	dc.w 0

	.bss


bitblt: ds.b 78
lineavars:	ds.l 1
bytes_lin: ds.w 1
nbplanes: ds.w 1
nxwd: ds.w 1
screen_size: ds.l 1

wipe_on: ds.w 1
stars_count: ds.w       1
x106c0: ds.w       1
zoomx: ds.w       1
zoomy: ds.w       1
rndcolor: ds.w       1

stars_type:    ds.w       1
curr_start_x:  ds.w       1
curr_end_x:    ds.w       1
curr_start_y:  ds.w       1
curr_end_y:    ds.w       1
curr_end_color:ds.w       1
movex:         ds.w       1
movey:         ds.w       1
curr_x:        ds.w       1
curr_y:        ds.w       1
curr_color:    ds.w       1
screenaddr:    ds.l       1


seed: ds.l 1
start_x:     ds.w       1
end_x:       ds.w       1
start_y:     ds.w       1
end_y:       ds.w       1
startcolor:  ds.w       1
endcolor:    ds.w       1
starfield: ds.w 5*MAX_STARS

LA_PLANES equ 0
V_BYTES_LIN equ -2
DEV_TAB equ -692

ZERO equ 0


finprg:
	ds.l 1
