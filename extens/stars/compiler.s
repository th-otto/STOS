		.include "system.inc"
		.include "errors.inc"
		.include "equates.inc"

MAX_STARS = 200

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
	.dc.w l003-para
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w l001-para
	.dc.w l001-para
	.dc.w l001-para

* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

* "," forces a comma between any commands
* 1   indicates the end of one set of parameters for an instruction
* 1,0 indicates the end of the commands entire parameter definition

l001: /* no parameters */
	.dc.b 0,1,1,0
l002: /* three parameters */
	.dc.b 0,I,',',I,',',I,1,1,0
l003: /* eight parameters */
	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1,1,0
	.even

; Adaptation au Stos basic
entry:
        bra.w init

nrand:
	movem.l    d7/a0-a6,-(a7)
	move.w     #$0011,-(a7)
	trap       #14
	addq.l     #2,a7
	andi.l     #$0000FFFF,d0
	sub.l      d5,d6
	divu.w     d6,d0
	swap       d0
	movem.l    (a7)+,d7/a0-a6
	rts

nextstar:
	movem.l    d7/a0,-(a7)
	lea        params(pc),a0
	move.l     seed-params(a0),d0
	mulu.w     rndfac-params(a0),d0
	addq.l     #1,d0
	andi.l     #$0000FFFF,d0
	move.l     d0,seed-params(a0)
	movem.w    start_x-params(a0),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	move.w     d0,curr_x-params(a0)
	move.l     seed-params(a0),d0
	movem.w    start_y-params(a0),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	move.w     d0,curr_y-params(a0)
	move.l     seed-params(a0),d0
	movem.w    startcolor-params(a0),d6-d7
	sub.l      d6,d7
	divu.w     d7,d0
	swap       d0
	add.l      d6,d0
	move.w     d0,curr_color-params(a0)
	movem.l    (a7)+,d7/a0
	rts

setpix:
	move.l     a0,-(a7)
	movea.l    screenno(pc),a0
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
	bcc        setpix2
	or.w       d1,(a0)+
	dbf        d0,setpix1
	move.l     (a7)+,a0
	rts
setpix2:
	and.w      d3,(a0)+
	dbf        d0,setpix1
	move.l     (a7)+,a0
	rts

isin:
	move.l     a1,-(a7)
	lea.l      sintab(pc),a1
	cmpi.w     #360,d6
	bmi.s      isin0
	subi.w     #360,d6
isin0:
	cmpi.w     #270,d6
	bmi.s      isin1
	bsr.s      isin4
	move.l     (a7)+,a1
	rts
isin1:
	cmpi.w     #180,d6
	bmi.s      isin2
	bsr.s      isin5
	move.l     (a7)+,a1
	rts
isin2:
	cmpi.w     #90,d6
	bmi.s      isin3
	bsr.s      isin6
	move.l     (a7)+,a1
	rts
isin3:
	add.w      d6,d6
	move.w     0(a1,d6.w),d0
	subi.w     #180,d6
	neg.w      d6
	move.w     0(a1,d6.w),d1
	move.l     (a7)+,a1
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


params:

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

myerror:
	move.l     error(a5),a0
	jmp (a0)

init:
	movem.l    d0-d7/a0-a6,-(a7)
	move.w     #17,-(a7) /* Random */
	trap       #14
	addq.l     #2,a7
	lea        params(pc),a0
	move.l     d0,seed-params(a0)
	movem.l    (a7)+,d0-d7/a0-a6
	lea        exit(pc),a2
	rts

exit:
	rts

lib1:
		dc.w 0 /* no library calls */
/*
 * SET STARS count,type,sx,sy,ex,ey,sc,ec
 */
setstars:
	movem.l    a0-a5,-(a7)
	move.l     debut(a5),a4
	movea.l    0(a4,d1.w),a4
	lea        params-entry(a4),a0
	lea        nextstar-entry(a4),a1
	lea        starfield-entry(a4),a2
	lea        nrand-entry(a4),a3
	move.l     (a6)+,d3
	addq.w     #1,d3
	move.w     d3,endcolor-params(a0)
	move.l     (a6)+,d3
	move.w     d3,startcolor-params(a0)
	move.l     (a6)+,d3
	move.w     d3,end_y-params(a0)
	move.l     (a6)+,d3
	move.w     d3,end_x-params(a0)
	move.l     (a6)+,d3
	move.w     d3,start_y-params(a0)
	move.l     (a6)+,d3
	move.w     d3,start_x-params(a0)
	move.l     (a6)+,d3
	move.w     d3,stars_type-params(a0)
	move.l     (a6)+,d3
	subq.w     #1,d3
	move.w     d3,stars_count-params(a0)
	movem.w    start_x-params(a0),d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	movem.w    start_y-params(a0),d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	movem.w    startcolor-params(a0),d6-d7
	cmp.w      d7,d6
	bhi        illfunc
	move.w     stars_count-params(a0),d5
	cmpi.w     #MAX_STARS,d5
	ble        setstars1
	bra        illfunc
setstars1:
	movem.w    start_x-params(a0),d0-d3
	move.w     d5,(a2)
	movem.w    d0-d3,curr_start_x-params(a0)
	addq.l     #2,a2
setstars2:
	jsr        (a1)
	cmpi.w     #2,stars_type-params(a0)
	bhi        illfunc
	beq        setstars5
	cmpi.w     #STARS_PARALLAX-1,stars_type-params(a0)
	beq        setstars3
	move.w     #1,d3
	bra        setstars4
setstars3:
	move.w     curr_color-params(a0),d3
	move.w     startcolor-params(a0),d1
	sub.w      d1,d3
	addq.w     #1,d3
setstars4:
	movem.w    curr_x-params(a0),d0-d2
	movem.w    d0-d4,(a2)
	addq.l     #8,a2
	dbf        d5,setstars2
	bra        setstars9
setstars5:
	move.w     d5,d7
	movem.w    start_x-params(a0),d0-d3
	sub.l      d0,d1
	sub.l      d2,d3
	lsr.w      #1,d1
	lsr.w      #1,d3
	cmp.w      d1,d3
	bhi        setstars6
	move.w     d1,x106c0-params(a0)
	bra        setstars7
setstars6:
	move.w     d3,x106c0-params(a0)
setstars7:
	add.w      start_x-params(a0),d1
	add.w      start_y-params(a0),d3
	movem.w    d1/d3,zoomx-params(a0)
	move.w     x106c0-params(a0),d0
	movem.w    startcolor-params(a0),d1-d2
	sub.w      d1,d2
	addq.w     #1,d2
	move.w     d2,curr_end_color-params(a0)
	movem.w    start_x-params(a0),d0-d1
	add.l      d0,d1
	lsr.l      #1,d1
	mulu.w     #512,d2
	divu.w     d1,d2
	move.w     d2,rndcolor-params(a0)
setstars8:
	clr.w      d5
	move.w     #359,d6
	lea        nrand-entry(a4),a3
	jsr        (a3)
	move.w     d0,d6
	lea        isin-entry(a4),a3
	jsr        (a3)
	movem.w    d0-d1,(a2)
	addq.l     #4,a2
	movem.w    startcolor-params(a0),d5-d6
	lea        nrand-entry(a4),a3
	jsr        (a3)
	mulu.w     rndcolor-params(a0),d0
	move.w     d0,(a2)+
	clr.w      d5
	move.w     #20,d6
	jsr        (a3)
	move.w     d0,(a2)+
	move.w     x106c0-params(a0),d6
	jsr        (a3)
	move.w     d0,(a2)+
	dbf        d7,setstars8
setstars9:
	/* addq.w     #1,stars_type-params(a0) */
	dc.w 0x0668,1,stars_type-params /* XXX */
	movem.l    (a7)+,a0-a5
	rts

illfunc:
	lea        myerror-entry(a4),a4
	moveq.l    #E_illegalfunc,d0
	jmp        (a4)

lib2:
	dc.w 0 /* no library calls */
	rts

lib3:
	dc.w 0 /* no library calls */
gostars:
	movem.l    a0-a5,-(a7)
	move.l     debut(a5),a4
	movea.l    0(a4,d1.w),a4
	lea        params-entry(a4),a0
	lea        setpix-entry(a4),a1
	lea        starfield-entry(a4),a2
	lea        myerror-entry(a4),a4
	move.l     (a6)+,d3
	move.l     d3,screenno-params(a0)
	move.l     (a6)+,d3
	move.w     d3,movey-params(a0)
	move.l     (a6)+,d3
	move.w     d3,movex-params(a0)
	tst.w      wipe_on-params(a0)
	beq        gostars1
	bra        fastcls
gostars1:
	movem.w    (a2)+,d7
	cmpi.w     #STARS_ZOOM,stars_type-params(a0)
	beq        gostars9
	movem.w    movex-params(a0),d5-d6
gostars2:
	movem.w    (a2),d0-d3
	move.w     d3,d4
	tst.w      d5
	beq        gostars3
	muls.w     d5,d3
	add.w      d3,d0
	cmp.w      curr_start_x-params(a0),d0
	ble        gostars6
	cmp.w      curr_end_x-params(a0),d0
	bhi.w      gostars5 /* XXX */
gostars3:
	tst.w      d6
	beq        gostars4
	muls.w     d6,d4
	add.w      d4,d1
	cmp.w      curr_start_y-params(a0),d1
	blt        gostars8
	cmp.w      curr_end_y-params(a0),d1
	bhi        gostars7
gostars4:
	movem.w    d0-d1,(a2)
	addq.w     #8,a2
	jsr        (a1)
	dbf        d7,gostars2
	movem.l    (a7)+,a0-a5
	rts
gostars5:
	move.w     curr_start_x-params(a0),d0
	bra        gostars3
gostars6:
	move.w     curr_end_x-params(a0),d0
	bra        gostars3
gostars7:
	move.w     curr_start_y-params(a0),d1
	bra        gostars4
gostars8:
	move.w     curr_end_y-params(a0),d1
	bra        gostars4
gostars9:
	movem.w    (a2),d0-d4
	movem.w    movex-params(a0),d5-d6
	muls.w     d4,d0
	lsl.l      #2,d0
	swap       d0
	add.w      zoomx-params(a0),d0
	tst.w      d5
	beq        gostars10
	muls.w     d3,d5
	asr.w      #1,d5
	add.w      d5,d0
gostars10:
	muls.w     d4,d1
	lsl.l      #2,d1
	swap       d1
	add.w      zoomy-params(a0),d1
	tst.w      d6
	beq        gostars11
	muls.w     d3,d6
	asr.w      #1,d6
	add.w      d6,d1
gostars11:
	addq.w     #1,d3
	move.w     d3,d6
	lsr.w      #1,d6
	add.w      d6,d4
	add.w      rndcolor-params(a0),d2
	addq.w     #4,a2
	movem.w    d2-d4,(a2)
	lsr.w      #6,d2
	cmp.w      curr_start_x-params(a0),d0
	ble        gostars13
	cmp.w      curr_end_x-params(a0),d0
	bhi        gostars13
	cmp.w      curr_start_y-params(a0),d1
	ble        gostars13
	cmp.w      curr_end_y-params(a0),d1
	bhi        gostars13
	cmp.w      curr_end_color-params(a0),d2
	bhi        gostars13
	jsr        (a1)
gostars12:
	addq.w     #6,a2
	dbf        d7,gostars9
	movem.l    (a7)+,a0-a5
	rts
gostars13:
	clr.l      (a2)
	move.w     seed-params(a0),d4
	mulu.w     rndfac-params(a0),d4
	addq.w     #1,d4
	andi.l     #$0000FFFF,d4
	move.w     d4,seed-params(a0)
	divu.w     x106c0-params(a0),d4
	swap       d4
	move.w     d4,4(a2)
	bra        gostars12

fastcls:
	movem.l    a0-a6,-(a7)
	movea.l    screenno-params(a0),a0
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

lib4:
	dc.w 0 /* no library calls */
	rts

lib5:
	dc.w 0 /* no library calls */
wipe_stars_on:
	move.l     a5,-(a7)
	move.l     debut(a5),a5
	movea.l    0(a5,d1.w),a5
	lea        params-entry(a5),a5
	move.w     #-1,wipe_on-params(a5)
	move.l     (a7)+,a5
	rts

lib6:
	dc.w 0 /* no library calls */
	rts

lib7:
	dc.w 0 /* no library calls */
wipe_stars_off:
	move.l     a5,-(a7)
	move.l     debut(a5),a5
	movea.l    0(a5,d1.w),a5
	lea        params-entry(a5),a5
	move.w     #0,wipe_on-params(a5)
	move.l     (a7)+,a5
	rts


libex:

finprg:
