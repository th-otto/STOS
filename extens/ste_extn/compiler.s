/*
 * The STOS STE Extension
 *
 * By Asa Burrows
 *
 * original filesize: 4847 bytes
 */

		.include "system.inc"
		.include "errors.inc"
		.include "equates.inc"
		.include "ste.inc"

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
	.dc.w lib8-lib7
	.dc.w lib9-lib8
	.dc.w lib10-lib9
	.dc.w lib11-lib10
	.dc.w lib12-lib11
	.dc.w lib13-lib12
	.dc.w lib14-lib13
	.dc.w lib15-lib14
	.dc.w lib16-lib15
	.dc.w lib17-lib16
	.dc.w lib18-lib17
	.dc.w lib19-lib18
	.dc.w lib20-lib19
	.dc.w lib21-lib20
	.dc.w lib22-lib21
	.dc.w lib23-lib22
	.dc.w lib24-lib23
	.dc.w lib25-lib24
	.dc.w lib26-lib25
	.dc.w lib27-lib26
	.dc.w lib28-lib27
	.dc.w lib29-lib28
	.dc.w lib30-lib29
	.dc.w lib31-lib30
	.dc.w lib32-lib31
	.dc.w lib33-lib32
	.dc.w lib34-lib33
	.dc.w lib35-lib34
	.dc.w lib36-lib35
	.dc.w lib37-lib36
	.dc.w lib38-lib37
	.dc.w lib39-lib38
	.dc.w lib40-lib39
	.dc.w lib41-lib40
	.dc.w lib42-lib41
	.dc.w lib43-lib42
	.dc.w lib44-lib43
	.dc.w lib45-lib44
	.dc.w libex-lib45

para:
	.dc.w 45           ; number of library routines
	.dc.w 45           ; number of extension commands

	.dc.w l001-para
	.dc.w l001-para
	.dc.w l001-para
	.dc.w l001-para
	.dc.w l003-para
	.dc.w l002-para
	.dc.w l003-para
	.dc.w l002-para
	.dc.w l002-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l002-para
	.dc.w l002-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l001-para
	.dc.w 0
	.dc.w l001-para
	.dc.w 0
	.dc.w l001-para
	.dc.w 0
	.dc.w l001-para
	.dc.w 0
	.dc.w l001-para
	.dc.w 0
	.dc.w l005-para
	.dc.w 0
	.dc.w l003-para
	.dc.w 0
	.dc.w l004-para
	.dc.w 0
	.dc.w l003-para
	.dc.w 0
	.dc.w l001-para
	.dc.w 0
	.dc.w l001-para
	
* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

* "," forces a comma between any commands
* 1   indicates the end of one set of parameters for an instruction
* 1,0 indicates the end of the commands entire parameter definition

l001:  /* no parameters */
	.dc.b I
	.dc.b 1,1,0
l002: /* one integer */
	.dc.b I
	.dc.b I,1,1,0
l003: /* two integer */
	dc.b I
	dc.b I,',',I,1,1,0
l004: /* three integer */
	dc.b I
	dc.b I,',',I,',',I,1,1,0
l005: /* 1-16 integer */
	dc.b I
	dc.b I,1
	dc.b I,',',I,1
	dc.b I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	dc.b I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,',',I,1
	/* BUG: end indicator missing: */
	/* dc.b 1,0 */
	.even

; Adaptation au Stos basic
entry:
        bra.w init

joy_in:
		move.l     a1,-(a7)
		lea.l      joy_pos(pc),a1
		move.b     1(a0),(a1)
		move.b     2(a0),1(a1)
		movea.l    (a7)+,a1
		rts

write_microwire:
		move.w     #0x07FF,mwmask
		move.w     d0,mwdata
write_microwire1:
		cmpi.w     #0x07FF,mwmask
		bne.s      write_microwire1
		rts

intervbl:
		movem.l    d0-d2/a0-a1,-(a7)
		lea.l      physic(pc),a0
		clr.l      d0
		clr.l      d1
		move.b     scroll_bitoffset-physic(a0),d0
		move.b     scroll_byteoffset-physic(a0),d1
		move.w     scroll_planes-physic(a0),d2
		andi.l     #0x0000FFFF,d2
		tst.b      d0
		beq.s      intervbl1
		sub.l      d2,d1
intervbl1:
		move.l     scroll_offset-physic(a0),d2
		movea.l    physic-physic(a0),a1
		adda.l     d2,a1
		move.l     a1,next_physic-physic(a0)
		move.b     d1,st_dstride
		andi.b     #0xF0,st_hbits
		or.b       d0,st_hbits
		move.b     next_physic+1-physic(a0),st_vach
		move.b     next_physic+2-physic(a0),st_vacm
		move.b     next_physic+3-physic(a0),st_vacl
		movem.l    (a7)+,d0-d2/a0-a1
vblret:
		jmp        0.l /* FIXME: self-modifying */


save_sp: dc.l 0
save_ssp: dc.l 0
save_buserr: dc.l 0
old_joyvec: dc.l 0
atable: dc.l 0
returnpc: dc.l 0
is_ste: dc.w 0
vbl_active: dc.w 0
joy_pos: dc.w 0
sticks_are_on: dc.w 0
frame_start: dc.l 0
frame_end: dc.l 0
dmacontrol_shadow: dc.b 1,0
physic: dc.l 0
next_physic: dc.l 0
screen_width: dc.l 0
screen_height: dc.l 0
scroll_bytewidth: dc.l 0
scroll_bytes: dc.w 0
scroll_planes: dc.w 0
scroll_byteoffset: dc.w 0
scroll_bitoffset: dc.w 0
scroll_offset: dc.l 0


myerror:
		move.l     error(a5),a0
		jmp        (a0)

init:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      save_buserr(pc),a0
		lea.l      buserr(pc),a1
		lea.l      save_sp(pc),a2
		lea.l      is_ste(pc),a3
		move.l     8.l,(a0)
		move.l     a1,8.l /* XXX */
		move.l     a7,(a2)
		move.w     #0,dmainter
		move.b     #1,(a3)
		bra.s      load2
load1:
		lea.l      is_ste(pc),a3
		lea.l      save_sp(pc),a2
		lea.l      save_buserr(pc),a0
		clr.b      (a3)
load2:
		movea.l    (a2),a7
		move.l     (a0),8.l /* XXX */
		movem.l    (a7)+,d0-d7/a0-a6
		lea.l      exit(pc),a2
		rts
buserr:
		lea.l      load1(pc),a3
		move.l     a3,2(a7)
		rte

exit:
		movem.l    d0-d7/a0-a6,-(a7)
		lea        is_ste(pc),a0
		lea.l      vblret+2(pc),a1
		tst.b      (a0)
		beq.s      exit3
		tst.b      vbl_active-is_ste(a0)
		beq.s      exit3
		clr.b      vbl_active-is_ste(a0)
		move.w     sr,d0
		move.w     #0x2700,sr
		move.l     (a1),0x00000070.l /* XXX */
		move.w     d0,sr
		lea        sticks_are_on(pc),a0
		tst.w      (a0)
		beq.s      exit2
		clr.w      (a0)
		move.w     #34,-(a7) /* Kbdvbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		lea.l      old_joyvec(pc),a1
		move.l     (a1),24(a0) /* restore previous joy handler */
		lea.l      ikbdacia,a0
warm1:
		move.b     (a0),d0
		btst       #1,d0      /* tx data empty? */
		beq.s      warm1      /* no, wait */
		move.b     #8,2(a0)   /* turn ikbd mouse on */
exit2:
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      exit3
		move.w     #LMC1992_FUNCTION_INPUT_SELECT|1,d0
		jsr        (a1)
		move.w     #0,dmainter /* BUG which was fixed in interpreter */
		move.b     #0,st_dstride
		andi.b     #0xF0,st_hbits
exit3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

/*
 * sticks on: switch on interrupts for joystick #0 (mouse port) and joystick #1
 * Also disables the mouse.
 */
lib1:
		dc.w 0 /* no library calls */
sticks_on:
		movem.l    a0-a6,-(a7)
		move.w     #34,-(a7)
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      sticks_are_on-entry(a5),a1
		lea.l      old_joyvec-entry(a5),a2
		lea.l      joy_in-entry(a5),a3
		tst.w      (a1)
		bne.w      sticks_on2
		move.w     #1,(a1)
		move.l     24(a0),(a2)  /* save old joy handler */
		move.l     a3,24(a0)    /* install our handler */
		lea.l      ikbdacia,a0
sticks_on1:
		move.b     (a0),d0
		btst       #1,d0        /* tx data empty? */
		beq.s      sticks_on1   /* no, wait */
		move.b     #0x14,2(a0)  /* set ikbd to joystick event reporting */
sticks_on2:
		movem.l    (a7)+,a0-a6
		rts

/*
 * stick1: return the status of joysticks one
 */
lib2:
		dc.w 0 /* no library calls */
stick1:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      joy_pos-entry(a5),a5
		clr.l      d0
		move.b     (a5),d0
		move.l     d0,-(a6)
		move.l     (a7)+,a5
		rts

/*
 * sticks off: switch off interrupts for joystick #0 and #1
 */
lib3:
		dc.w 0 /* no library calls */
sticks_off:
		movem.l    a0-a6,-(a7)
		move.w     #34,-(a7)
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      sticks_are_on-entry(a5),a1
		lea.l      old_joyvec-entry(a5),a2
		tst.w      (a1)
		beq.w      sticks_off2 /* XXX */
		clr.w      (a1)
		move.l     (a2),24(a0) /* restore previous joy handler */
		lea.l      ikbdacia,a0
sticks_off1:
		move.b     (a0),d0
		btst       #1,d0        /* tx data empty? */
		beq.s      sticks_off1  /* no, wait */
		move.b     #8,2(a0)     /* turn ikbd mouse on */
sticks_off2:
		movem.l    (a7)+,a0-a6
		rts

/*
 * stick2: return the status of joysticks two
 */
lib4:
		dc.w 0 /* no library calls */
stick2:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      joy_pos-entry(a5),a5
		clr.l      d0
		move.b     1(a5),d0
		move.l     d0,-(a6)
		move.l     (a7)+,a5
		rts

/*
 * DAC CONVERT start address of sample, end address of sample
 */
lib5:
		dc.w 0 /* no library calls */
dac_convert:
		move.l     a0,-(a7)
		move.l     (a6)+,d0   ; d0 = end address
		move.l     (a6)+,a0   ; a0 = start address
		sub.l      a0,d0
dac_convert1:
		subi.b     #0x7F,(a0)+
		subq.l     #1,d0
		tst.l      d0
		bne.s      dac_convert1
		move.l     (a7)+,a0
		rts

/*
 * x= LSTICK (j)
 * Returns the current status of the joystick's left
 * position.
 */
lib6:
		dc.w 0 /* no library calls */
l_stick:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a1
		lea.l      joy_pos-entry(a4),a2
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d3
		cmp.l      #1,d3
		beq.s      l_stick_joy0
		cmp.l      #2,d3
		beq.s      l_stick_joy1
		tst.b      (a1)         /* do we have STE joysticks? */
		beq.w      l_stick_true /* no XXX FIXME: should maybe be illfunc? */
		cmp.l      #3,d3
		beq.s      l_stick_joy2
		cmp.l      #4,d3
		beq.s      l_stick_joy3
		cmp.l      #5,d3
		beq.s      l_stick_joy4
		cmp.l      #6,d3
		beq.s      l_stick_joy5
		bra        l_illfunc
l_stick_joy0:
		btst       #2,(a2)
		bne.s      l_stick_true
		bra.s      l_stick_false
l_stick_joy1:
		btst       #2,1(a2)
		bne.s      l_stick_true
		bra.s      l_stick_false
l_stick_joy2:
		btst       #1,joyport+1
		bclr       #1,joyport+1
		beq.s      l_stick_true
		bra.s      l_stick_false
l_stick_joy3:
		btst       #1,joyport  /* BUG: no bclr */
		beq.s      l_stick_true
		bra.s      l_stick_false
l_stick_joy4:
		btst       #5,joyport+1
		bclr       #5,joyport+1
		beq.s      l_stick_true
		bra.s      l_stick_false
l_stick_joy5:
		btst       #5,joyport  /* BUG: no bclr */
		beq.s      l_stick_true
		bra.s      l_stick_false
l_stick_true:
		move.l     #-1,-(a6)
		bra.s      l_stick_ret
l_stick_false:
		clr.l      -(a6)
l_stick_ret:
		movem.l    (a7)+,a0-a5
		rts
l_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * DAC RAW start address of sample,end address of sample
 * 
 * Plays your raw sample.
 */
lib7:
		dc.w 0 /* no library calls */
dac_raw:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      frame_start-entry(a4),a1
		lea.l      frame_end-entry(a4),a2
		lea.l      dmacontrol_shadow-entry(a4),a3
		tst.b      (a0)
		beq.s      dac_raw_noste /* BUG: should pop paremeters */
		move.l     (a6)+,(a2)
		move.l     (a6)+,(a1)
		move.w     #0,dmainter
		move.b     1(a1),f_b_um
		move.b     2(a1),f_b_lm
		move.b     3(a1),f_b_ll
		move.b     1(a2),f_e_um
		move.b     2(a2),f_e_lm
		move.b     3(a2),f_e_ll
		move.b     (a3),dmacontrol
dac_raw_noste:
		movem.l    (a7)+,a0-a5
		rts

/*
 * x= RSTICK (j)
 * Returns the current status of the joystick's right
 * position.
 */
lib8:
		dc.w 0 /* no library calls */
r_stick:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a1
		lea.l      joy_pos-entry(a4),a2
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d3
		cmp.l      #1,d3
		beq.s      r_stick_joy0
		cmp.l      #2,d3
		beq.s      r_stick_joy1
		tst.b      (a1)         /* do we have STE joysticks? */
		beq.w      r_stick_true /* no XXX FIXME: should maybe be illfunc? */
		cmp.l      #3,d3
		beq.s      r_stick_joy2
		cmp.l      #4,d3
		beq.s      r_stick_joy3
		cmp.l      #5,d3
		beq.s      r_stick_joy4
		cmp.l      #6,d3
		beq.s      r_stick_joy5
		bra.w      r_illfunc /* XXX */
r_stick_joy0:
		btst       #3,(a2)
		bne.s      r_stick_true
		bra.s      r_stick_false
r_stick_joy1:
		btst       #3,1(a2)
		bne.s      r_stick_true
		bra.s      r_stick_false
r_stick_joy2:
		btst       #0,joyport+1
		bclr       #0,joyport+1
		beq.s      r_stick_true
		bra.s      r_stick_false
r_stick_joy3:
		btst       #0,joyport  /* BUG: no bclr */
		beq.s      r_stick_true
		bra.s      r_stick_false
r_stick_joy4:
		btst       #4,joyport+1
		bclr       #4,joyport+1
		beq.s      r_stick_true
		bra.s      r_stick_false
r_stick_joy5:
		btst       #4,joyport  /* BUG: no bclr */
		beq.s      r_stick_true
		bra.s      r_stick_false
r_stick_true:
		move.l     #-1,-(a6)
		bra.s      r_stick_ret
r_stick_false:
		clr.l      -(a6)
r_stick_ret:
		movem.l    (a7)+,a0-a5
		rts
r_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * DAC SPEED n
 * Sets the speed of sample replay. 0=6Khz, 1=12.5Khz, 2=25Khz, 3=50Khz
 */
lib9:
		dc.w 0 /* no library calls */
dac_speed:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      dac_speed_noste /* BUG: should pop paremeters */
		move.l     (a6)+,d3
		tst.l      d3
		bmi.w      dac_illfunc /* XXX */
		cmp.l      #3,d3
		bgt.w      dac_illfunc /* XXX */
		move.b     modecontrol,d2
		andi.b     #0x80,d2     /* BUG: masks out 16 bit flag on falcon */
		or.b       d3,d2
		move.b     d2,modecontrol
dac_speed_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x= USTICK (j)
 * Returns the current status of the joystick's up
 * position.
 */
lib10:
		dc.w 0 /* no library calls */
u_stick:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a1
		lea.l      joy_pos-entry(a4),a2
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d3
		cmp.l      #1,d3
		beq.s      u_stick_joy0
		cmp.l      #2,d3
		beq.s      u_stick_joy1
		tst.b      (a1)         /* do we have STE joysticks? */
		beq.w      u_stick_true /* no XXX FIXME: should maybe be illfunc? */
		cmp.l      #3,d3
		beq.s      u_stick_joy2
		cmp.l      #4,d3
		beq.s      u_stick_joy3
		cmp.l      #5,d3
		beq.s      u_stick_joy4
		cmp.l      #6,d3
		beq.s      u_stick_joy5
		bra.w      u_illfunc /* XXX */
u_stick_joy0:
		btst       #0,(a2)
		bne.s      u_stick_true
		bra.s      u_stick_false
u_stick_joy1:
		btst       #0,1(a2)
		bne.s      u_stick_true
		bra.s      u_stick_false
u_stick_joy2:
		btst       #3,joyport+1
		bclr       #3,joyport+1
		beq.s      u_stick_true
		bra.s      u_stick_false
u_stick_joy3:
		btst       #3,joyport  /* BUG: no bclr */
		beq.s      u_stick_true
		bra.s      u_stick_false
u_stick_joy4:
		btst       #7,joyport+1
		bclr       #7,joyport+1
		beq.s      u_stick_true
		bra.s      u_stick_false
u_stick_joy5:
		btst       #7,joyport  /* BUG: no bclr */
		beq.s      u_stick_true
		bra.s      u_stick_false
u_stick_true:
		move.l     #-1,-(a6)
		bra.s      u_stick_ret
u_stick_false:
		clr.l      -(a6)
u_stick_ret:
		movem.l    (a7)+,a0-a5
		rts
u_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * DAC STOP: stop the DAC
 */
lib11:
		dc.w 0 /* no library calls */
dac_stop:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      is_ste-entry(a5),a5
		tst.b      (a5)
		beq.s      dac_stop_noste
		move.b     #0,dmacontrol
dac_stop_noste:
        move.l     (a7)+,a5
		rts

/*
 * x= DSTICK (j)
 * Returns the current status of the joystick's down
 * position.
 */
lib12:
		dc.w 0 /* no library calls */
d_stick:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a1
		lea.l      joy_pos-entry(a4),a2
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d3
		cmp.l      #1,d3
		beq.s      d_stick_joy0
		cmp.l      #2,d3
		beq.s      d_stick_joy1
		tst.b      (a1)         /* do we have STE joysticks? */
		beq.w      d_stick_true /* no XXX FIXME: should maybe be illfunc? */
		cmp.l      #3,d3
		beq.s      d_stick_joy2
		cmp.l      #4,d3
		beq.s      d_stick_joy3
		cmp.l      #5,d3
		beq.s      d_stick_joy4
		cmp.l      #6,d3
		beq.s      d_stick_joy5
		bra.w      d_illfunc /* XXX */
d_stick_joy0:
		btst       #1,(a2)
		bne.s      d_stick_true
		bra.s      d_stick_false
d_stick_joy1:
		btst       #1,1(a2)
		bne.s      d_stick_true
		bra.s      d_stick_false
d_stick_joy2:
		btst       #2,joyport+1
		bclr       #2,joyport+1
		beq.s      d_stick_true
		bra.s      d_stick_false
d_stick_joy3:
		btst       #2,joyport  /* BUG: no bclr */
		beq.s      d_stick_true
		bra.s      d_stick_false
d_stick_joy4:
		btst       #6,joyport+1
		bclr       #6,joyport+1
		beq.s      d_stick_true
		bra.s      d_stick_false
d_stick_joy5:
		btst       #6,joyport  /* BUG: no bclr */
		beq.s      d_stick_true
		bra.s      d_stick_false
d_stick_true:
		move.l     #-1,-(a6)
		bra.s      d_stick_ret
d_stick_false:
		clr.l      -(a6)
d_stick_ret:
		movem.l    (a7)+,a0-a5
		rts
d_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * DAC M VOLUME volume
 * set master volume
 */
lib13:
		dc.w 0 /* no library calls */
dac_m_volume:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      dac_m_volume_noste /* BUG: should pop paremeters */
		move.l     (a6)+,d3
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt.w      dac_m_illfunc /* XXX */
		cmp.l      #40,d3
		bgt.w      dac_m_illfunc /* XXX */
		ori.w      #LMC1992_FUNCTION_VOLUME,d3
		move.w     d3,d0
		jsr        (a1)
dac_m_volume_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_m_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x= FSTICK (j)
 * Returns the current status of the joystick's fire button.
 */
lib14:
		dc.w 0 /* no library calls */
f_stick:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a1
		lea.l      joy_pos-entry(a4),a2
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d3
		cmp.l      #1,d3
		beq.s      f_stick_joy0
		cmp.l      #2,d3
		beq.s      f_stick_joy1
		tst.b      (a1)         /* do we have STE joysticks? */
		beq.w      f_stick_true /* no XXX FIXME: should maybe be illfunc? */
		cmp.l      #3,d3
		beq.s      f_stick_joy2
		cmp.l      #4,d3
		beq.s      f_stick_joy3
		cmp.l      #5,d3
		beq.s      f_stick_joy4
		cmp.l      #6,d3
		beq.s      f_stick_joy5
		bra.w      f_illfunc /* XXX */
f_stick_joy0:
		btst       #7,(a2)
		bne.s      f_stick_true
		bra.s      f_stick_false
f_stick_joy1:
		btst       #7,1(a2)
		bne.s      f_stick_true
		bra.s      f_stick_false
f_stick_joy2:
		btst       #0,joyfire
		beq.s      f_stick_true
		bra.s      f_stick_false
f_stick_joy3:
		btst       #1,joyfire
		beq.s      f_stick_true
		bra.s      f_stick_false
f_stick_joy4:
		btst       #2,joyfire
		beq.s      f_stick_true
		bra.s      f_stick_false
f_stick_joy5:
		btst       #3,joyfire
		beq.s      f_stick_true
		bra.s      f_stick_false
f_stick_true:
		move.l     #-1,-(a6)
		bra.s      f_stick_ret
f_stick_false:
		clr.l      -(a6)
f_stick_ret:
		movem.l    (a7)+,a0-a5
		rts
f_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * DAC M VOLUME volume
 * set left volume
 */
lib15:
		dc.w 0 /* no library calls */
dac_l_volume:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      dac_l_volume_noste /* BUG: should pop paremeters */
		move.l     (a6)+,d3
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt.w      dac_r_illfunc /* XXX */
		cmp.l      #20,d3
		bgt.w      dac_r_illfunc /* XXX */
		ori.w      #LMC1992_FUNCTION_LEFT_FRONT_FADER,d3
		move.w     d3,d0
		jsr        (a1)
dac_l_volume_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_r_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x =LIGHT X
 * return the x coordinate of your gun or pen
 */
lib16:
		dc.w 0 /* no library calls */
light_x:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      is_ste-entry(a5),a5
		tst.b      (a5)
		beq        light_x_err
		move.w     lightpen_x,d3
		move.b     st_shift,d0
		andi.l     #0x000003FF,d3
		andi.l     #0x0000000F,d0
		lsl.l      d0,d3
		move.l     d3,-(a6)
		bra.s      light_x_ret
light_x_err:
		move.l     #-1,-(a6)
light_x_ret:
		movea.l    (a7)+,a5
		rts

/*
 * DAC M VOLUME volume
 * set right volume
 */
lib17:
		dc.w 0 /* no library calls */
dac_r_volume:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      dac_r_volume_noste /* BUG: should pop paremeters */
		move.l     (a6)+,d3
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt.w      dac_rv_illfunc /* XXX */
		cmp.l      #20,d3
		bgt.w      dac_rv_illfunc /* XXX */
		ori.w      #LMC1992_FUNCTION_RIGHT_FRONT_FADER,d3
		move.w     d3,d0
		jsr        (a1)
dac_r_volume_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_rv_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x =LIGHT Y
 * return the Y coordinate of your gun or pen
 */
lib18:
		dc.w 0 /* no library calls */
light_y:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      is_ste-entry(a5),a5
		tst.b      (a5)
		beq        light_y_err
		move.w     lightpen_y,d3
		andi.l     #0x000003FF,d3
		move.l     d3,-(a6)
		bra.s      light_y_ret
light_y_err:
		move.l     #-1,-(a6)
light_y_ret:
		move.l     (a7)+,a5
		rts

/*
 * DAC TREBLE volume
 * set treble volume
 */
lib19:
		dc.w 0 /* no library calls */
dac_treble:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      dac_treble_noste /* BUG: should pop paremeters */
		move.l     (a6)+,d3
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt.w      dac_tr_illfunc /* XXX */
		cmp.l      #12,d3
		bgt.w      dac_tr_illfunc /* XXX */
		ori.w      #LMC1992_FUNCTION_TREBLE,d3
		move.w     d3,d0
		jsr        (a1)
dac_treble_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_tr_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x = STE
 * returns TRUE if the machine is an STE or FALSE if it isn't
 */
lib20:
		dc.w 0 /* no library calls */
ste:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      is_ste-entry(a5),a5
		clr.l      d0
		move.b     (a5),d0
		move.l     d0,-(a6)
		move.l     (a7)+,a5
		rts

/*
 * DAC BASS volume
 * set bass volume
 */
lib21:
		dc.w 0 /* no library calls */
dac_bass:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      dac_bass_noste /* BUG: should pop paremeters */
		move.l     (a6)+,d3
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt.w      dac_b_illfunc /* XXX */
		cmp.l      #12,d3
		bgt.w      dac_b_illfunc /* XXX */
		ori.w      #LMC1992_FUNCTION_BASS,d3
		move.w     d3,d0
		jsr        (a1)
dac_bass_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_b_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x= E COLOR (colour)
 * returns the RGB value of the colour number, 0 to 15.
 */
lib22:
		dc.w 0 /* no library calls */
e_color:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      e_color_noste
		move.l     (a6)+,d3
		cmp.l      #15,d3
		bhi.w      e_color_illfunc
		lea.l      st_palette,a0
		lsl.l      #1,d3
		move.w     0(a0,d3.w),d3
		move.l     d3,d6
		rol.l      #1,d6 /* rotate bits in position */
		btst       #4,d6 /* was low bit for blue set? */
		beq.s      e_color1
		bset       #0,d6
e_color1:
		bclr       #4,d6
		btst       #8,d6 /* was low bit for green set? */
		beq.s      e_color2
		bset       #4,d6
e_color2:
		bclr       #8,d6
		btst       #12,d6 /* was low bit for red set? */
		beq.s      e_color3
		bset       #8,d6
e_color3:
		bclr       #12,d6 /* FIXME: useless */
		andi.l     #0x00000FFF,d6
		move.l     d6,-(a6)  /* return value */
		bra.s      e_color_ret
e_color_noste:
		clr.l      (a6)
e_color_ret:
		movem.l    (a7)+,a0-a5
		rts
e_color_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * DAC MIX ON
 * Mix PSG output on
 */
lib23:
		dc.w 0 /* no library calls */
dac_mix_on:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		lea.l      myerror-entry(a4),a4 /* FIXME: unused */
		tst.b      (a0)
		beq.s      dac_mix_on_noste
		move.w     #LMC1992_FUNCTION_INPUT_SELECT|1,d0
		jsr        (a1)
dac_mix_on_noste:
		movem.l    (a7)+,a0-a5
		rts
dac_mix_on_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

/*
 * x = HARD PHYSIC (screen address)
 This command tells the ST where the screen is stored.
 */
lib24:
		dc.w 0 /* no library calls */
hard_physic:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      physic-entry(a4),a1
		lea.l      next_physic-entry(a4),a2
		tst.b      (a0)
		beq.s      hard_physic_noste
		move.l     (a6),d7 /* BUG: does not pop paremeter */
		move.l     d7,physic-physic(a1) /* XXX */
		move.l     d7,next_physic-next_physic(a2) /* XXX */
hard_physic_noste:
		movem.l    (a7)+,a0-a5
		rts

/*
 * DAC MIX ON
 * Mix PSG output off
 */
lib25:
		dc.w 0 /* no library calls */
dac_mix_off:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      write_microwire-entry(a4),a1
		tst.b      (a0)
		beq.s      dac_mix_off_noste
		move.w     #LMC1992_FUNCTION_INPUT_SELECT|2,d0
		jsr        (a1)
dac_mix_off_noste:
		movem.l    (a7)+,a0-a5
		rts

lib26:
		dc.w 0 /* no library calls */
		rts

/*
 * DAC MONO
 * sets the sample to be mono
 */
lib27:
		dc.w 0 /* no library calls */
dac_mono:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      is_ste-entry(a5),a5
		tst.b      (a5)
		beq.s      dac_mono_noste
		bset       #7,modecontrol
dac_mono_noste:
        move.l     (a7)+,a5
        rts

lib28:
		dc.w 0 /* no library calls */
		rts

/*
 * DAC STEREO
 * sets the sample to be mono
 */
lib29:
		dc.w 0 /* no library calls */
dac_stereo:
		move.l     a5,-(a7)
		move.l     debut(a5),a5
		movea.l    0(a5,d1.w),a5
		lea.l      is_ste-entry(a5),a5
		tst.b      (a5)
		beq.s      dac_stereo_noste
		bclr       #7,modecontrol
dac_stereo_noste:
        move.l     (a7)+,a5
        rts

lib30:
		dc.w 0 /* no library calls */
		rts

/*
 * DAC LOOP ON
 * Set the loop function on
 */
lib31:
		dc.w 0 /* no library calls */
dac_loop_on:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      dmacontrol_shadow-entry(a4),a1
		tst.b      (a0)
		beq.s      dac_loop_on_noste
		move.b     #3,(a1)
dac_loop_on_noste:
        movem.l    (a7)+,a0-a5
        rts

lib32:
		dc.w 0 /* no library calls */
		rts

/*
 * DAC LOOP OFF
 * Set the loop function off
 */
lib33:
		dc.w 0 /* no library calls */
dac_loop_off:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      dmacontrol_shadow-entry(a4),a1
		tst.b      (a0)
		beq.s      dac_loop_off_noste
		move.b     #1,(a1)
dac_loop_off_noste:
        movem.l    (a7)+,a0-a5
        rts

lib34:
		dc.w 0 /* no library calls */
		rts

/*
 * E PALETTE $RGB,$RGB,...(up to 16 colour values)
 * Works exactly as the PALETTE command in STOS,
 * but allows 4 bits per component
 */
lib35:
		dc.w 0 /* no library calls */
e_palette:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      st_palette,a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.s      e_palette_noste /* FIXME: unneeded, this would work the same on ST */
		clr.l      d1
		move.w     d0,d1
		lsl.w      #1,d1
		subq.w     #1,d0 /* for dbra */
		adda.l     d1,a1
e_palette_loop:
		move.l     (a6)+,d3
		cmp.l      #0xFFF,d3
		bhi.w      e_pal_illfunc /* XXX */
		move.l     d3,d6
		ror.l      #1,d6 /* shift bits into position */
		btst       #7,d6 /* was low bit of red set? */
		beq.s      e_palette1
		bset       #11,d6
e_palette1:
		bclr       #7,d6
		btst       #3,d6 /* was low bit of green set? */
		beq.s      e_palette2
		bset       #7,d6
e_palette2:
		bclr       #3,d6
		btst       #31,d6 /* was low bit of blue set? */
		beq.s      e_palette3
		bset       #3,d6
e_palette3:
		andi.l     #0xFFF,d6
		move.w     d6,-(a1)
		dbf        d0,e_palette_loop
		bra.s      e_palette_ret
e_palette_noste:
		lsl.l      #2,d0
		adda.l     d0,a6
e_palette_ret:
        movem.l    (a7)+,a0-a5
        rts
e_pal_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

lib36:
		dc.w 0 /* no library calls */
		rts

/*
 * E COLOUR colour,$RGB
 * same as the COLOUR command but allows 4 bits per component
 */
lib37:
		dc.w 0 /* no library calls */
e_colour:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      st_palette,a1
		lea.l      myerror-entry(a4),a4
		tst.b      (a0)
		beq.w      e_colour_noste /* FIXME: unneeded, this would work the same on ST */
		move.l     (a6)+,d3
		cmp.l      #0xFFF,d3
		bhi.w      e_col_illfunc /* XXX */
		move.l     d3,d6
		ror.l      #1,d6
		btst       #7,d6
		beq.s      e_colour1
		bset       #11,d6
e_colour1:
		bclr       #7,d6
		btst       #3,d6
		beq.s      e_colour2
		bset       #7,d6
e_colour2:
		bclr       #3,d6
		btst       #31,d6
		beq.s      e_colour3
		bset       #3,d6
e_colour3:
		andi.l     #0xFFF,d6
		move.l     (a6)+,d3
		cmp.l      #15,d3
		bhi.w      e_col_illfunc /* XXX */
		lsl.l      #1,d3
		move.w     d6,0(a1,d3.w)
		bra.s      e_colour_ret
e_colour_noste:
		addq.l     #8,a6
e_colour_ret:
        movem.l    (a7)+,a0-a5
        rts
e_col_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

lib38:
		dc.w 0 /* no library calls */
		rts

/*
 * HARD SCREEN SIZE w,h,mode
 * Sets the screens logical size. w=width of screen and h=height of
 * screen ready for scrolling.
 */
lib39:
		dc.w 0 /* no library calls */
hard_screen_size:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      physic-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d0 ; d0 = mode
		move.l     (a6)+,d7 ; d7 = height
		move.l     (a6)+,d6 ; d6 = width
		tst.b      (a0)
		beq        hard_screen_size_noste
		cmp.l      #2,d0
		beq        screensize_mode2
		cmp.l      #1,d0
		beq.s      screensize_mode1
/* set parameters for mode 0 (low resolution) */
		tst.l      d0
		bne        hard_s_illfunc
		addi.l     #15,d7
		andi.l     #0xFFFFFFF0,d6
		move.l     d6,d5
		subi.l     #320,d6
		bmi        hard_s_illfunc
		subi.l     #200,d7
		bmi        hard_s_illfunc
		move.l     d6,d0
		move.l     d7,d1
		mulu.w     #4,d0
		mulu.w     #4,d5
		divs.w     #8,d0
		divs.w     #8,d5
		andi.l     #0x0000FFFF,d0
		andi.l     #0x0000FFFF,d5
		lsr.l      #1,d0
		cmp.l      #255,d0
		bgt        hard_s_illfunc
		move.w     sr,d2
		move.w     #0x2700,sr
		move.l     d6,screen_width-physic(a1)
		move.l     d7,screen_height-physic(a1)
		move.l     d5,scroll_bytewidth-physic(a1)
		move.w     #8,scroll_bytes-physic(a1)
		move.w     #4,scroll_planes-physic(a1)
		move.b     d0,scroll_byteoffset-physic(a1)
		move.w     d2,sr
		bra        hard_screen_size_noste
/* set parameters for mode 1 (medium resolution) */
screensize_mode1:
		addi.l     #15,d7
		andi.l     #0xFFFFFFF0,d6
		move.l     d6,d5
		subi.l     #640,d6
		bmi        hard_s_illfunc
		subi.l     #200,d7
		bmi        hard_s_illfunc
		move.l     d6,d0
		move.l     d7,d1
		mulu.w     #2,d0
		mulu.w     #2,d5
		divs.w     #8,d0
		divs.w     #8,d5
		andi.l     #0x0000FFFF,d0
		andi.l     #0x0000FFFF,d5
		lsr.l      #1,d0
		cmp.l      #255,d0
		bgt        hard_s_illfunc
		move.w     sr,d2
		move.w     #0x2700,sr
		move.l     d6,screen_width-physic(a1)
		move.l     d7,screen_height-physic(a1)
		move.l     d5,scroll_bytewidth-physic(a1)
		move.w     #4,scroll_bytes-physic(a1)
		move.w     #2,scroll_planes-physic(a1)
		move.b     d0,scroll_byteoffset-physic(a1)
		move.w     d2,sr
		bra.w      hard_screen_size_noste
/* set parameters for mode 2 (high resolution) */
screensize_mode2:
		addi.l     #15,d7
		andi.l     #0xFFFFFFF0,d6
		move.l     d6,d5
		subi.l     #640,d6
		bmi.w      hard_s_illfunc /* XXX */
		subi.l     #400,d7
		bmi.w      hard_s_illfunc /* XXX */
		move.l     d6,d0
		move.l     d7,d1
		divs.w     #8,d0
		divs.w     #8,d5
		andi.l     #0x0000FFFF,d0
		andi.l     #0x0000FFFF,d5
		lsr.l      #1,d0
		cmp.l      #255,d0
		bgt.w      hard_s_illfunc /* XXX */
		move.w     sr,d2
		move.w     #0x2700,sr
		move.l     d6,screen_width-physic(a1)
		move.l     d7,screen_height-physic(a1)
		move.l     d5,scroll_bytewidth-physic(a1)
		move.w     #2,scroll_bytes-physic(a1)
		move.w     #1,scroll_planes-physic(a1)
		move.b     d0,scroll_byteoffset-physic(a1)
		clr.w      scroll_bitoffset-physic(a1)
		move.w     d2,sr
hard_screen_size_noste:
        movem.l    (a7)+,a0-a5
        rts
hard_s_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

lib40:
		dc.w 0 /* no library calls */
		rts

/*
 * HARD SCREEN OFFSET x,y
 * This command tells the ST where to start displaying the screen.
 */
lib41:
		dc.w 0 /* no library calls */
hard_screen_offset:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      physic-entry(a4),a1
		lea.l      myerror-entry(a4),a4
		move.l     (a6)+,d7 ; d7 = y
		move.l     (a6)+,d6 ; d6 = x
		tst.b      (a0)
		beq.s      hard_screen_offset_ret
		tst.b      scroll_planes+1-physic(a1)
		beq.w      hard_screen_offset_ret
		move.l     screen_width-physic(a1),d0
		move.l     screen_height-physic(a1),d1
		/* cmp.l      #0,d6 */
		dc.w 0xbcbc,0,0 /* XXX */
		blt.w      hard_o_illfunc
		/* cmp.l      #0,d7 */
		dc.w 0xbebc,0,0 /* XXX */
		blt.w      hard_o_illfunc
		cmp.l      d0,d6
		bgt.w      hard_o_illfunc
		cmp.l      d1,d7
		bgt.w      hard_o_illfunc
		clr.l      d0
		movea.l    physic-physic(a1),a0
		move.w     scroll_bytes-physic(a1),d0
		move.l     scroll_bytewidth-physic(a1),d1
		move.l     d6,d5
		divs.w     #16,d6
		divs.w     #16,d5
		andi.l     #0x0000FFFF,d6
		mulu.w     d0,d6
		swap       d5
		mulu.w     d1,d7
		andi.l     #0x0000FFFF,d6
		add.l      d6,d7
		move.w     sr,d2
		move.w     #0x2700,sr
		move.l     d7,scroll_offset-physic(a1)
		move.b     d5,scroll_bitoffset-physic(a1)
		move.w     d2,sr
hard_screen_offset_ret:
        movem.l    (a7)+,a0-a5
        rts
hard_o_illfunc:
		/* moveq.l    #E_illegalfunc,d0 */
		dc.w 0x203c,0,E_illegalfunc
		jmp        (a4)

lib42:
		dc.w 0 /* no library calls */
		rts

/*
 * HARD INTER ON
 * Turn on hardware scrolling
 */
lib43:
		dc.w 0 /* no library calls */
hard_inter_on:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      vblret+2-entry(a4),a1
		lea.l      intervbl-entry(a4),a2
		tst.b      (a0)
		beq.s      hard_inter_on_ret
		tst.b      vbl_active-is_ste(a0)
		bne.s      hard_inter_on_ret
		move.b     #1,vbl_active-is_ste(a0)
		move.w     sr,d0
		move.w     #0x2700,sr
		move.l     0x00000070.l,(a1) /* XXX */
		move.l     a2,0x00000070.l /* XXX */
		move.w     d0,sr
hard_inter_on_ret:
        movem.l    (a7)+,a0-a5
        rts

lib44:
		dc.w 0 /* no library calls */
		rts

/*
 * HARD INTER OFF
 * Turn off hardware scrolling
 */
lib45:
		dc.w 0 /* no library calls */
hard_inter_off:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		lea.l      is_ste-entry(a4),a0
		lea.l      vblret+2-entry(a4),a1
		tst.b      (a0)
		beq.s      hard_inter_off_ret
		tst.b      vbl_active-is_ste(a0)
		beq.s      hard_inter_off_ret
		clr.b      vbl_active-is_ste(a0)
		move.w     sr,d0
		move.w     #0x2700,sr
		move.l     (a1),0x00000070.l /* XXX */
		move.w     d0,sr
		move.b     #0,st_dstride
		andi.b     #0xF0,st_hbits
hard_inter_off_ret:
        movem.l    (a7)+,a0-a5
        rts


libex:

finprg:
