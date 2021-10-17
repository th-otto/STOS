		.include "system.inc"
		.include "errors.inc"

MAX_STARS = 200

STARS_FLAT     = 1
STARS_PARALLAX = 2
STARS_ZOOM     = 3

		.text

		bra.w        load

		.text

        dc.b $80
tokens:
        dc.b "set stars",$80
        /* $81 missing */
        dc.b "go stars",$82
        /* $83 missing */
        dc.b "wipe stars on",$84
        /* $85 missing */
        dc.b "wipe stars off",$86

        dc.b 0
        even

jumps: dc.w 7
       dc.l setstars
       dc.l dummy
       dc.l gostars
       dc.l dummy
       dc.l wipe_stars_on
       dc.l dummy
       dc.l wipe_stars_off

welcome:
       dc.b 10
       dc.b "STARS By Lee Upcraft.  V2.6",0
       dc.b 10
       dc.b "STARS By Lee Upcraft.  V2.6",0
       .even

	dc.w       $0000
table: dc.l 0
returnpc: dc.l 0

load:
	lea.l      finprg,a0
	lea.l      cold,a1
	rts

cold:
	move.l     a0,table
	move.w     #17,-(a7) /* Random */
	trap       #14
	addq.l     #2,a7
	move.l     d0,seed
	lea.l      welcome,a0
	lea.l      warm,a1
	lea.l      tokens,a2
	lea.l      jumps,a3
	rts

warm:
	rts

getparam:
	movea.l    (a7)+,a0
	movem.l    (a7)+,d2-d4
	tst.b      d2
	bne.w      typemismatch /* XXX */
	jmp        (a0)
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
	dc.b "Illegal stars type",0
	dc.b "Illegal stars type",0
toomanymsg:
	dc.b "Too many stars",0
	dc.b "Too many stars",0
undefinedmsg:
	dc.b "Stars not defined",0
	dc.b "Stars not defined",0
	.even

dummy:
	move.l     (a7)+,returnpc
	bra        syntax

nrand:
	move.w     #$0011,-(a7)
	trap       #14
	addq.l     #2,a7
	andi.l     #$0000FFFF,d0
	sub.l      d5,d6
	divu.w     d6,d0
	swap       d0
	rts

nextstar:
	move.l     seed,d0
	mulu.w     rndfac,d0
	addq.l     #1,d0
	andi.l     #$0000FFFF,d0
	move.l     d0,seed
	movem.w    start_x,d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	move.w     d0,curr_x
	move.l     seed,d0
	movem.w    start_y,d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	move.w     d0,curr_y
	move.l     seed,d0
	movem.w    startcolor,d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	move.w     d0,curr_color
	rts

setpix:
	movea.l    screenno,a0
	mulu.w     #160,d1
	adda.w     d1,a0
	move.w     d0,d4
	andi.w     #0xFFF0,d4
	lsr.w      #1,d4
	adda.w     d4,a0
	andi.w     #15,d0
	subi.w     #15,d0
	neg.w      d0
	clr.w      d1
	bset       d0,d1
	move.w     d1,d3
	not.w      d3
	moveq.l    #3,d0
setpix1:
	lsr.w      #1,d2
	bcc.w      setpix2 /* XXX */
	or.w       d1,(a0)+
	dbf        d0,setpix1
	rts
setpix2:
	and.w      d3,(a0)+
	dbf        d0,setpix1
	rts

isin:
	lea.l      sintab,a1
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



fastcls:
	movem.l    a0-a6,-(a7)
	movea.l    screenno,a0
	lea.l      32000(a0),a0
	moveq.l    #0,d1
	moveq.l    #0,d2
	moveq.l    #0,d3
	moveq.l    #0,d4
	moveq.l    #0,d5
	moveq.l    #0,d6
	moveq.l    #0,d7
	movea.l    d1,a1
	movea.l    d1,a2
	movea.l    d1,a3
	movea.l    d1,a4
	movea.l    d1,a5
	movea.l    d1,a6
	move.w     #205-1,d0
fastcls1:
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	dbf        d0,fastcls1
	movem.l    d1-d5,-(a0)
	movem.l    (a7)+,a0-a6
	bra        gostars1

wipe_stars_on:
	movea.l    (a7)+,a0
	move.w     #-1,wipe_on
	jmp        (a0)

wipe_stars_off:
	movea.l    (a7)+,a0
	move.w     #0,wipe_on
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
	movem.w    start_x,d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	movem.w    start_y,d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	movem.w    startcolor,d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	move.w     stars_count,d5
	cmpi.w     #MAX_STARS,d5
	ble.w      setstars1 /* XXX */
	bra        prtoomany
setstars1:
	lea.l      starfield,a2
	movem.w    start_x,d0-d3
	move.w     d5,(a2)
	movem.w    d0-d3,curr_start_x
	addq.l     #2,a2
setstars2:
	bsr        nextstar
	cmpi.w     #2,stars_type
	bhi        illmsg /* BUG: should be prillmsg */
	beq.w      setstars5 /* XXX */
	cmpi.w     #STARS_PARALLAX-1,stars_type
	beq.w      setstars3 /* XXX */
	move.w     #1,d3
	bra.w      setstars4 /* XXX */
setstars3:
	move.w     curr_color,d3
	move.w     startcolor,d1
	sub.w      d1,d3
	addq.w     #1,d3
setstars4:
	movem.w    curr_x,d0-d2
	movem.w    d0-d4,(a2)
	addq.l     #8,a2
	dbf        d5,setstars2
	bra        setstars9
setstars5:
	move.w     d5,d7
	movem.w    start_x,d0-d3
	sub.l      d0,d1
	sub.l      d2,d3
	lsr.w      #1,d1
	lsr.w      #1,d3
	cmp.w      d1,d3
	bhi.w      setstars6 /* XXX */
	move.w     d1,x106c0
	bra.w      setstars7 /* XXX */
setstars6:
	move.w     d3,x106c0
setstars7:
	add.w      start_x,d1
	add.w      start_y,d3
	movem.w    d1/d3,zoomx
	move.w     x106c0,d0
	movem.w    startcolor,d1-d2
	sub.w      d1,d2
	addq.w     #1,d2
	move.w     d2,curr_end_color
	movem.w    start_x,d0-d1
	add.l      d0,d1
	lsr.l      #1,d1
	mulu.w     #512,d2
	divu.w     d1,d2
	move.w     d2,rndcolor
setstars8:
	clr.w      d5
	move.w     #359,d6
	bsr        nrand
	move.w     d0,d6
	bsr        isin
	movem.w    d0-d1,(a2)
	addq.l     #4,a2
	movem.w    startcolor,d5-d6
	bsr        nrand
	mulu.w     rndcolor,d0
	move.w     d0,(a2)+
	clr.w      d5
	move.w     #20,d6
	bsr        nrand
	move.w     d0,(a2)+
	move.w     x106c0,d6
	bsr        nrand
	move.w     d0,(a2)+
	dbf        d7,setstars8
setstars9:
	/* addq.w     #1,stars_type */
	dc.l 0x06790001,stars_type /* XXX */
	movea.l    returnpc,a0
	jmp        (a0)

gostars:
	move.l     (a7)+,returnpc
	cmpi.w     #3,d0
	bne        syntax
	bsr        getparam
	move.l     d3,screenno
	bsr        getparam
	move.w     d3,movey
	bsr        getparam
	move.w     d3,movex
	/* tst.w     stars_type */
	dc.l 0x0c790000,stars_type /* XXX */
	beq        undefinedmsg /* BUG: should be prundefined */
	tst.w      wipe_on
	beq.w      gostars1 /* XXX */
	bra        fastcls
gostars1:
	lea.l      starfield,a2
	movem.w    (a2)+,d7
	cmpi.w     #STARS_ZOOM,stars_type
	beq        gostars9
	movem.w    movex,d5-d6
gostars2:
	movem.w    (a2),d0-d3
	move.w     d3,d4
	tst.w      d5
	beq.w      gostars3 /* XXX */
	muls.w     d5,d3
	add.w      d3,d0
	cmp.w      curr_start_x,d0
	ble.w      gostars6 /* XXX */
	cmp.w      curr_end_x,d0
	bhi.w      gostars5 /* XXX */
gostars3:
	tst.w      d6
	beq.w      gostars4 /* XXX */
	muls.w     d6,d4
	add.w      d4,d1
	cmp.w      curr_start_y,d1
	blt.w      gostars8 /* XXX */
	cmp.w      curr_end_y,d1
	bhi.w      gostars7 /* XXX */
gostars4:
	movem.w    d0-d1,(a2)
	addq.w     #8,a2
	bsr        setpix
	dbf        d7,gostars2
	movea.l    returnpc,a0
	jmp        (a0)
gostars5:
	move.w     curr_start_x,d0
	bra.w      gostars3 /* XXX */
gostars6:
	move.w     curr_end_x,d0
	bra.w      gostars3 /* XXX */
gostars7:
	move.w     curr_start_y,d1
	bra.w      gostars4 /* XXX */
gostars8:
	move.w     curr_end_y,d1
	bra.w      gostars4 /* XXX */
gostars9:
	movem.w    (a2),d0-d4
	movem.w    movex,d5-d6
	muls.w     d4,d0
	lsl.l      #2,d0
	swap       d0
	add.w      zoomx,d0
	tst.w      d5
	beq.w      gostars10 /* XXX */
	muls.w     d3,d5
	asr.w      #1,d5
	add.w      d5,d0
gostars10:
	muls.w     d4,d1
	lsl.l      #2,d1
	swap       d1
	add.w      zoomy,d1
	tst.w      d6
	beq.w      gostars11 /* XXX */
	muls.w     d3,d6
	asr.w      #1,d6
	add.w      d6,d1
gostars11:
	addq.w     #1,d3
	move.w     d3,d6
	lsr.w      #1,d6
	add.w      d6,d4
	add.w      rndcolor,d2
	addq.w     #4,a2
	movem.w    d2-d4,(a2)
	lsr.w      #6,d2
	cmp.w      curr_start_x,d0
	ble.w      gostars13 /* XXX */
	cmp.w      curr_end_x,d0
	bhi.w      gostars13 /* XXX */
	cmp.w      curr_start_y,d1
	ble.w      gostars13 /* XXX */
	cmp.w      curr_end_y,d1
	bhi.w      gostars13 /* XXX */
	cmp.w      curr_end_color,d2
	bhi.w      gostars13 /* XXX */
	bsr        setpix
gostars12:
	addq.w     #6,a2
	dbf        d7,gostars9
	movea.l    returnpc,a0
	jmp        (a0)
gostars13:
	clr.l      (a2)
	move.w     seed,d4
	mulu.w     rndfac,d4
	addq.w     #1,d4
	andi.l     #$0000FFFF,d4
	move.w     d4,seed
	divu.w     x106c0,d4
	swap       d4
	move.w     d4,4(a2)
	bra.w      gostars12 /* XXX */

	dc.l 0

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
screenno:      dc.w       0
x106e0:      dc.w       0

seed: dc.l 0
rndfac:  dc.w 31621
start_x:     dc.w       0
end_x:       dc.w       0
start_y:     dc.w       0
end_y:       dc.w       0
startcolor:  dc.w       0
endcolor:    dc.w       0
starfield: ds.w 5*MAX_STARS

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

finprg:
