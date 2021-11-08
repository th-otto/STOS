		.include "system.inc"
		.include "errors.inc"
		.include "equates.inc"

MAX_STARS = 512

STARS_FLAT     = 1
STARS_PARALLAX = 2
STARS_ZOOM     = 3

		.text
start:
	.dc.l para-start  ; offset to parameter definitions
	.dc.l entry-start ; offset to coldboot function
	.dc.l lib1-start  ; offset to first library function
; length of library routines follows
	.dc.w lib2-lib1
	.dc.w lib3-lib2
	.dc.w lib4-lib3
	.dc.w lib5-lib4
	.dc.w lib6-lib5
	.dc.w lib7-lib6
	.dc.w libex-lib7

para:
	.dc.w 7           ; number of library routines
	.dc.w 7           ; number of extension commands
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l003-para
	.dc.w l004-para
	.dc.w l005-para
	.dc.w l006-para
	.dc.w l007-para

* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

* "," forces a comma between any commands
* 1   indicates the end of one set of parameters for an instruction
* 1,0 indicates the end of the commands entire parameter definition

l001:  /* set stars */
	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0
l002:
	.dc.b 0,1,1,0
l003: /* go stars */
	.dc.b 0,I,',',I,1
	.dc.b   I,',',I,',',I,1,1,0
l004:
	.dc.b 0,1,1,0
l005: /* wipe stars on */
	.dc.b 0,1,1,0
l006:
	.dc.b 0,1,1,0
l007: /* wipe stars off */
	.dc.b 0,1,1,0
	.even

; Adaptation au Stos basic
entry:
        bra.w init

params_offset: dc.l params-entry
offset_setparams: dc.l setparams-entry
offset_gostars: dc.l dogostars-entry


mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0

params:

x10084: dc.l 0
lineavars:	ds.l 1
bytes_lin: ds.w 1
nbplanes: ds.w 1
nxwd: ds.w 1
screen_size: ds.l 1

wipe_on: dc.w 0
stars_count: dc.w       0
x106c0: dc.w       0
zoomx: dc.w       0
zoomy: dc.w       0
rndcolor: dc.w       0
stars_type:    dc.w       0
curr_start_x:  dc.w       0
curr_end_x:    dc.w       0
curr_start_y:  dc.w       0
curr_end_y:    dc.w       0
curr_end_color:dc.w       0
movex:         dc.w       0
movey:         dc.w       0
curr_x:        dc.w       0
curr_y:        dc.w       0
curr_color:    dc.w       0
screenaddr:    dc.l       0

seed: dc.l 0
rndfac:  dc.w 31621
start_x:     dc.w       0
end_x:       dc.w       0
start_y:     dc.w       0
end_y:       dc.w       0
startcolor:  dc.w       0
endcolor:    dc.w       0


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

starfield: ds.w 5*MAX_STARS

bitblt: ds.b 78

init:
	movem.l    d0-d7/a0-a6,-(a7)
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
		beq.s      init1
		lea.l      cookievalue(pc),a1
		lea.l      mch_cookie(pc),a0
		move.l     (a1),(a0)
init1:
		lea.l      cookieid(pc),a1
		move.l     #0x5F56444F,(a1) /* '_VDO' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      init2
		lea.l      cookievalue(pc),a1
		lea.l      vdo_cookie(pc),a0
		move.l     (a1),(a0)
init2:
/* FIXME: _SND cookie not used here */
		lea.l      cookieid(pc),a1
		move.l     #0x5F534E44,(a1) /* '_SND' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7)
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.s      init3
		lea.l      cookievalue(pc),a1
		lea.l      snd_cookie(pc),a0
		move.l     (a1),(a0)
init3:
	move.w     #17,-(a7) /* Random */
	trap       #14
	addq.l     #2,a7
	lea        seed(pc),a0
	move.l     d0,(a0)
	dc.w 0xa000
	lea lineavars(pc),a1
	move.l d0,(a1)
	movem.l    (a7)+,d0-d7/a0-a6
	lea        exit(pc),a2
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
		bra.w      getcookie1 /* XXX */
getcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.s      getcookie3
		move.l     d1,(a5)
getcookie3:
		rts


nrand:
	move.w     #$0011,-(a7)
	trap       #14
	addq.l     #2,a7
	andi.l     #$0000FFFF,d0
	sub.l      d5,d6
	divu.w     d6,d0
	swap       d0
illtype:
	nop
prundefined:
	rts

nextstar:
	move.l     seed(pc),d0
	mulu.w     rndfac(pc),d0
	addq.l     #1,d0
	andi.l     #$0000FFFF,d0
	lea        seed(pc),a5
	move.l     d0,(a5)
	movem.w    start_x(pc),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	lea        curr_x(pc),a5
	move.w     d0,(a5)
	move.l     seed(pc),d0
	movem.w    start_y(pc),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	lea        curr_y(pc),a5
	move.w     d0,(a5)
	move.l     seed(pc),d0
	movem.w    startcolor(pc),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	lea        curr_color(pc),a5
	move.w     d0,(a5)
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


setparams:
	lea.l      x10084(pc),a5
	lea.l      stars_count(pc),a0
	move.w     d0,(a0)
	lea.l      stars_type(pc),a1
	move.w     d1,(a1)
	lea.l      start_x(pc),a0
	move.w     d2,start_x-start_x(a0)
	move.w     d4,end_x-start_x(a0)
	move.w     d3,start_y-start_x(a0)
	move.w     d5,end_y-start_x(a0)
	move.w     d6,startcolor-start_x(a0)
	move.w     d7,endcolor-start_x(a0)
	movem.w    start_x(pc),d6-d7
	cmp.w      d7,d6
	bhi        setparams1
	movem.w    start_y(pc),d6-d7
	cmp.w      d7,d6
	bhi        setparams1
	movem.w    startcolor(pc),d6-d7
	cmp.w      d7,d6
	bhi        setparams1
	move.w     stars_count(pc),d5
	cmpi.w     #MAX_STARS-1,d5
	ble.s      setparams2
setparams1:
	rts
setparams2:
    move.l     lineavars(pc),a0
    lea.l      bytes_lin(pc),a1
    move.l     #32000,screen_size-bytes_lin(a1)
	move.w     vdo_cookie(pc),d6
	cmpi.w     #3,d6
	bne.s      setparams3
	move.w     V_BYTES_LIN(a0),d0
	andi.l     #$0000FFFF,d0
	move.w     DEV_TAB+2(a0),d1
	/* addq.w     #1,d1 */
	dc.w 0x0641,1 /* XXX */
	andi.l     #$0000FFFF,d1
	mulu.w     d1,d0
	move.l     d0,screen_size-bytes_lin(a1)
setparams3:
	move.w     V_BYTES_LIN(a0),bytes_lin-bytes_lin(a1)
	move.w     LA_PLANES(a0),d0
	move.w     d0,nbplanes-bytes_lin(a1)
	asl.w      #1,d0
	move.w     d0,nxwd-bytes_lin(a1)
	lea.l      starfield(pc),a2
	movem.w    start_x(pc),d0-d3
	move.w     d5,(a2)
	lea        curr_start_x(pc),a5
	movem.w    d0-d3,(a5)
	addq.l     #2,a2
setstars2:
	bsr        nextstar
	lea        stars_type(pc),a5
	cmpi.w     #2,(a5)
	bhi        illtype
	beq.s      setstars5
	lea        stars_type(pc),a5
	cmpi.w     #STARS_PARALLAX-1,(a5)
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
	bra        setstars9
setstars5:
	move.w     d5,d7
	movem.w    start_x(pc),d0-d3
	sub.l      d0,d1
	sub.l      d2,d3
	lsr.w      #1,d1
	lsr.w      #1,d3
	cmp.w      d1,d3
	bhi.s      setstars6
	lea        x106c0(pc),a5
	move.w     d1,(a5)
	bra.s      setstars7
setstars6:
	lea        x106c0(pc),a5
	move.w     d3,(a5)
setstars7:
	add.w      start_x(pc),d1
	add.w      start_y(pc),d3
	lea        zoomx(pc),a5
	movem.w    d1/d3,(a5)
	move.w     x106c0(pc),d0
	movem.w    startcolor(pc),d1-d2
	sub.w      d1,d2
	addq.w     #1,d2
	lea        curr_end_color(pc),a5
	move.w     d2,(a5)
	movem.w    start_x(pc),d0-d1
	add.l      d0,d1
	lsr.l      #1,d1
	mulu.w     #512,d2
	divu.w     d1,d2
	lea        rndcolor(pc),a5
	move.w     d2,(a5)
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
	move.w     #20,d6 /* XXX */
	bsr        nrand
	move.w     d0,(a2)+
	move.w     x106c0(pc),d6
	bsr        nrand
	move.w     d0,(a2)+
	dbf        d7,setstars8
setstars9:
	lea        stars_type(pc),a5
	addq.w     #1,(a5)
	rts

dogostars:
	lea        stars_type(pc),a5
	/* tst.w      (a5) */
	dc.w 0x0c55,0 /* XXX */
	beq        prundefined
	lea.l      screenaddr(pc),a0
	move.l     d3,(a0)
	lea        movex(pc),a0
	move.w     d4,(a0)+
	move.w     d5,(a0)+
	movem.l    d0-d7/a0-a6,-(a7)
	move.l     screenaddr(pc),d0
	bne.s      screen_set
	move.w     #3,-(a7) /* Logbase */
	trap       #14
	addq.l     #2,a7
	lea.l      screenaddr(pc),a0
	move.l     d0,(a0)
screen_set:
	
	tst.w      wipe_on /* BUG: absolute addr */
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
	lea.l      bitblt(pc),a6
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
	lea.l      bitblt(pc),a6
	dc.w 0xa007 /* bit_blt */
fastcls2:
	movem.l    (a7)+,d0-d7/a0-a6

gostars1:
	lea.l      starfield(pc),a2
	movem.w    (a2)+,d7
	lea        stars_type(pc),a5
	cmpi.w     #STARS_ZOOM,(a5)
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
	rts
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
	rts
gostars13:
	clr.l      (a2)
	move.w     seed(pc),d4
	mulu.w     rndfac(pc),d4
	addq.w     #1,d4
	andi.l     #$0000FFFF,d4
	lea        seed(pc),a5
	move.w     d4,(a5)
	divu.w     x106c0(pc),d4
	swap       d4
	move.w     d4,4(a2)
	bra.s      gostars12

exit:
	rts

lib1:
		dc.w 0 /* no library calls */
/*
 * SET STARS count,type,sx,sy,ex,ey,sc,ec
 */
setstars:
	lea.l      saveregs1(pc),a0
	movem.l    d0-d7/a1-a5,(a0)
	move.l     debut(a5),a0
	movea.l    0(a0,d1.w),a0
	move.l offset_setparams-entry(a0),d0
	add.l d0,a0 /* a0 -> setparams */
	
	move.l     (a6)+,d7 /* endcolor */
	addq.w     #1,d7
	move.l     (a6)+,d6 /* startcolor */
	move.l     (a6)+,d5 /* end y */
	move.l     (a6)+,d4 /* end x */
	move.l     (a6)+,d3 /* start y */
	move.l     (a6)+,d2 /* start x */
	move.l     (a6)+,d1 /* type */
	move.l     (a6)+,d0 /* count */
	subq.w     #1,d0
	jsr        (a0)
	movem.l    saveregs1(pc),d0-d7/a1-a5
	rts

saveregs1: ds.l 14

lib2:
	dc.w 0 /* no library calls */
	rts

/*
 * GO STARS movex,movey[,screenno]
 */
lib3:
	dc.w 0 /* no library calls */
gostars:
	lea.l      saveregs2(pc),a0
	movem.l    d0-d7/a1-a5,(a0)
	move.l     debut(a5),a0
	movea.l    0(a0,d1.w),a0
	move.l offset_gostars-entry(a0),d1
	add.l d1,a0 /* a0 -> gotstars */

	moveq      #0,d3
	cmpi.b     #1,d0
	beq.w      params2 /* XXX */
	cmpi.w     #2,d0
	bne        gostarsend
	move.l     (a6)+,d3 /* screeno */
params2:
	move.l     (a6)+,d5 /* movey */
	move.l     (a6)+,d4 /* movex */
	jsr        (a0)
gostarsend:
	movem.l    saveregs2(pc),d0-d7/a1-a5
	rts

saveregs2: ds.l 14


lib4:
	dc.w 0 /* no library calls */
	rts

lib5:
	dc.w 0 /* no library calls */
wipe_stars_on:
	move.l     debut(a5),a0
	movea.l    0(a0,d1.w),a0
	move.l     params_offset-entry(a0),d6
	add.l      d6,a0
	move.w     #-1,wipe_on-params(a0)
	rts

lib6:
	dc.w 0 /* no library calls */
	rts

lib7:
	dc.w 0 /* no library calls */
wipe_stars_off:
	move.l     debut(a5),a0
	movea.l    0(a0,d1.w),a0
	move.l     params_offset-entry(a0),d6
	add.l      d6,a0
	move.w     #0,wipe_on-params(a0)
	rts


libex:
	dc.w 0

finprg:

LA_PLANES equ 0
V_BYTES_LIN equ -2
DEV_TAB equ -692

ZERO equ 0
