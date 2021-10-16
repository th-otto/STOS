/*
 * The STOS STE Extension
 *
 * By Asa Burrows
 *
 * original filesize: 4847 bytes
 * other versions:
 *                    4839 bytes from the compiler disc
 *                    4824 bytes from exxos
 *
 */

		.include "system.inc"
		.include "errors.inc"

dmainter   = $ff8900 /* XXX */
dmacontrol = $ff8901
trackcontrol = $ff8920
modecontrol = $ff8921

st_palette = $ff8240
st_shift   = $ff8260  /* ST shift mode */
st_hbits   = $ff8265  /* horizontal pixel scroll */
st_hoff    = $ff820e  /* horizontal offset */
st_dstride = $ff820f  /* width of a scanline */

joyfire    = $ff9201
joyport    = $ff9202

lightpen_x = $ff9220
lightpen_y = $ff9222

mwdata     = $ff8922
mwmask     = $ff8924

st_vach    = $ff8205	;.b video address counter hi
st_vacm	   = $ff8207	;.b video address counter mid
st_vacl	   = $ff8209	;.b video address counter lo

f_b_um     = $ff8903    ;. Frame start address (high byte)
f_b_lm     = $ff8905    ;. Frame start address (mid byte)
f_b_ll     = $ff8907    ;. Frame start address (low byte)

f_e_um     = $ff890f    ;. Frame end address (high byte)
f_e_lm     = $ff8911    ;. Frame end address (mid byte)
f_e_ll     = $ff8913    ;. Frame end address (low byte)

ikbdacia    = $fffc00

MICROWIRE_ADDRESS = 0x400
/* LMC1992 functions */
LMC1992_FUNCTION_INPUT_SELECT       = MICROWIRE_ADDRESS+0x000 /* 0<<6 */
LMC1992_FUNCTION_BASS               = MICROWIRE_ADDRESS+0x040 /* 1<<6 */
LMC1992_FUNCTION_TREBLE             = MICROWIRE_ADDRESS+0x080 /* 2<<6 */
LMC1992_FUNCTION_VOLUME             = MICROWIRE_ADDRESS+0x0c0 /* 3<<6 */
LMC1992_FUNCTION_RIGHT_FRONT_FADER  = MICROWIRE_ADDRESS+0x100 /* 4<<6 */
LMC1992_FUNCTION_LEFT_FRONT_FADER   = MICROWIRE_ADDRESS+0x140 /* 5<<6 */
LMC1992_FUNCTION_RIGHT_REAR_FADER   = MICROWIRE_ADDRESS+0x180 /* 6<<6 */
LMC1992_FUNCTION_LEFT_REAR_FADER    = MICROWIRE_ADDRESS+0x1c0 /* 7<<6 */

		.text

		bra.w        load

        dc.b $80

tokens:
        dc.b "sticks on",$80
        dc.b "stick1",$81
        dc.b "sticks off",$82
        dc.b "stick2",$83
        dc.b "dac convert",$84
        dc.b "l stick",$85
        dc.b "dac raw",$86
        dc.b "r stick",$87
        dc.b "dac speed",$88
        dc.b "u stick",$89
        dc.b "dac stop",$8a
        dc.b "d stick",$8b
        dc.b "dac m volume",$8c
        dc.b "f stick",$8d
        dc.b "dac l volume",$8e
        dc.b "light x",$8f
        dc.b "dac r volume",$90
        dc.b "light y",$91
        dc.b "dac treble",$92
        dc.b "ste",$93
        dc.b "dac bass",$94
        dc.b "e color",$95
        dc.b "dac mix on",$96
        dc.b "hard physic",$97
        dc.b "dac mix off",$98
        /* $99 missing */
        dc.b "dac mono",$9a
        /* $9b missing */
        dc.b "dac stereo",$9c
        /* $9d missing */
        dc.b "dac loop on",$9e
        /* $9f missing */
        dc.b "dac loop off",$a0
        /* $a1 missing */
        dc.b " e palette",$a2
        /* $a3 missing */
        dc.b "e colour",$a4
        /* $a5 missing */
        dc.b "hard screen size",$a6
        /* $a7 missing */
        dc.b "hard screen offset",$a8
        /* $a9 missing */
        dc.b "hard inter on",$aa
        /* $ab missing */
        dc.b "hard inter off",$ac

        dc.b 0
        even

jumps:  dc.w 45
        dc.l sticks_on
        dc.l stick1
        dc.l sticks_off
        dc.l stick2
        dc.l dac_convert
        dc.l l_stick
        dc.l dac_raw
        dc.l r_stick
        dc.l dac_speed
        dc.l u_stick
        dc.l dac_stop
        dc.l d_stick
        dc.l dac_m_volume
        dc.l f_stick
        dc.l dac_l_volume
		dc.l light_x
		dc.l dac_r_volume
		dc.l light_y
		dc.l dac_treble
		dc.l ste
		dc.l dac_bass
		dc.l e_color
		dc.l dac_mix_on
		dc.l hard_physic
		dc.l dac_mix_off
		dc.l 0
		dc.l dac_mono
		dc.l 0
		dc.l dac_stereo
		dc.l 0
		dc.l dac_loop_on
		dc.l 0
		dc.l dac_loop_off
		dc.l 0
		dc.l e_palette
		dc.l 0
		dc.l e_colour
		dc.l 0
		dc.l hard_screen_size
		dc.l 0
		dc.l hard_screen_offset
		dc.l 0
		dc.l hard_inter_on
		dc.l 0
		dc.l hard_inter_off
		

welcome:
		dc.b 10
		dc.b "STE Extension v4.0 (c)1991/92/95 AMBRAH",0
		dc.b 10
		dc.b "Extension STE v4.0 (c)1991/92/95 AMBRAH",0
		dc.b 0
		.even

load:
		movem.l    d0-d7/a0-a6,-(a7)
		clr.l      -(a7)
		move.w     #32,-(a7)
		trap       #1
		addq.l     #6,a7
		move.l     d0,save_ssp
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
		clr.l      -(a7)
		move.w     #32,-(a7)
		trap       #1
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a0-a6
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts
buserr:
		lea.l      load1(pc),a3
		move.l     a3,2(a7)
		rte

cold:
		move.l     a0,table
		lea.l      saveerror+12(pc),a1
		lea.l      myerror(pc),a2
		lea.l      saveerror(pc),a3
		movea.l    sys_error(a0),a0
		/* save 10 bytes of original code; wel be executed in our saveerror function */
		move.l     (a0),(a3)
		move.l     4(a0),4(a3)
		move.w     8(a0),8(a3)
		/* make error function jump to our error */
		move.w     #0x4EF9,(a0) /* jmp abs.l opcode */
		move.l     a2,2(a0)
		/* our error handler will return to after the patched code */
		/* adda.l     #10,a0 */
        dc.w 0xd1fc,0x0000,0x000a /* XXX */
		move.l     a0,(a1)
		lea.l      welcome,a0
		lea.l      warm,a1
		lea.l      tokens,a2
		lea.l      jumps,a3
		rts

warm:
		movem.l    d0-d7/a0-a6,-(a7)
		clr.l      d0
		jsr        hard_inter_off
		tst.w      sticks_are_on
		beq.s      warm2
		clr.w      sticks_are_on
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
warm2:
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      warm3
		move.w     #LMC1992_FUNCTION_INPUT_SELECT|1,d0
		jsr        (a1)
		andi.w     #0xFFFC,dmainter
		tst.w      is_inter_on
		beq.s      warm3
		move.b     #0,st_dstride
		andi.b     #0xF0,st_hbits
warm3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

/*
 * sticks on: switch on interrupts for joystick #0 (mouse port) and joystick #1
 * Also disables the mouse.
 */
sticks_on:
		move.l     (a7)+,returnpc
		movem.l    a0-a6,-(a7)
		move.w     #34,-(a7)
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		lea.l      sticks_are_on(pc),a1
		lea.l      old_joyvec,a2
		lea.l      joy_in,a3
		clr.w      joy_pos-sticks_are_on(a1)
		tst.w      (a1)
		bne        noerror
		move.w     #1,(a1)
		move.l     24(a0),(a2)  /* save old joy handler */
		move.l     a3,24(a0)    /* install our handler */
		lea.l      ikbdacia,a0
sticks_on1:
		move.b     (a0),d0
		btst       #1,d0        /* tx data empty? */
		beq.s      sticks_on1   /* no, wait */
		move.b     #0x14,2(a0)  /* set ikbd to joystick event reporting */
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * stick1: return the status of joysticks one
 */
stick1:
		move.l     (a7)+,returnpc
		lea.l      joy_pos(pc),a0
		clr.l      d3
		move.b     (a0),d3
		clr.l      d2
		clr.l      d4
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * sticks off: switch off interrupts for joystick #0 and #1
 */
sticks_off:
		move.l     (a7)+,returnpc
		movem.l    a0-a6,-(a7)
		move.w     #34,-(a7)
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a0
		lea.l      sticks_are_on(pc),a1
		lea.l      old_joyvec(pc),a2
		tst.w      (a1)
		beq        noerror
		clr.w      (a1)
		move.l     (a2),24(a0) /* restore previous joy handler */
		lea.l      ikbdacia,a0
sticks_off1:
		move.b     (a0),d0
		btst       #1,d0        /* tx data empty? */
		beq.s      sticks_off1  /* no, wait */
		move.b     #8,2(a0)     /* turn ikbd mouse on */
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * stick2: return the status of joysticks two
 */
stick2:
		move.l     (a7),returnpc
		lea.l      joy_pos(pc),a0
		clr.l      d3
		move.b     1(a0),d3
		clr.l      d2
		clr.l      d4
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC CONVERT start address of sample, end address of sample
 */
dac_convert:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		jsr        getparam
		move.l     d3,d0      ; d0 = end address
		jsr        getparam
		move.l     d3,d7      ; d7 = start address
		move.l     a0,-(a7)
		movea.l    d7,a0
		sub.l      a0,d0
dac_convert1:
		subi.b     #0x7F,(a0)+
		subq.l     #1,d0
		tst.l      d0
		bne.s      dac_convert1
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x= LSTICK (j)
 * Returns the current status of the joystick's left
 * position.
 */
l_stick:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a1
		lea.l      joy_pos(pc),a2
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
		bra        illfunc
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
		moveq.l    #-1,d3
		bra.s      l_stick_ret
l_stick_false:
		clr.l      d3
l_stick_ret:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC RAW start address of sample,end address of sample
 * 
 * Plays your raw sample.
 */
dac_raw:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		jsr        getparam
		move.l     d3,d7      ; d7 = end address
		jsr        getparam
		move.l     d3,d6      ; d6 = start address
		movem.l    a0-a5,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      frame_start(pc),a1
		lea.l      frame_end(pc),a2
		lea.l      dmacontrol_shadow(pc),a3
		tst.b      (a0)
		beq.s      dac_raw_noste
		move.l     d7,(a2)
		move.l     d6,(a1)
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
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x= RSTICK (j)
 * Returns the current status of the joystick's right
 * position.
 */
r_stick:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a1
		lea.l      joy_pos(pc),a2
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
		bra        illfunc
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
		moveq.l    #-1,d3
		bra.s      r_stick_ret
r_stick_false:
		clr.l      d3
r_stick_ret:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC SPEED n
 * Sets the speed of sample replay. 0=6Khz, 1=12.5Khz, 2=25Khz, 3=50Khz
 */
dac_speed:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		move.l     a0,-(a7)
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.s      dac_speed_noste
		tst.l      d3
		bmi        illfunc
		cmp.l      #3,d3
		bgt        illfunc
		move.b     modecontrol,d2
		andi.b     #0x80,d2     /* BUG: masks out 16 bit flag on falcon */
		or.b       d3,d2
		move.b     d2,modecontrol
dac_speed_noste:
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x= USTICK (j)
 * Returns the current status of the joystick's up
 * position.
 */
u_stick:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a1
		lea.l      joy_pos(pc),a2
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
		bra        illfunc
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
		moveq.l    #-1,d3
		bra.s      u_stick_ret
u_stick_false:
		clr.l      d3
u_stick_ret:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC STOP: stop the DAC
 */
dac_stop:
		move.l     (a7)+,returnpc
		move.l     a0,-(a7)
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.s      dac_stop_noste
		move.b     #0,dmacontrol
dac_stop_noste:
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x= DSTICK (j)
 * Returns the current status of the joystick's down
 * position.
 */
d_stick:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a1
		lea.l      joy_pos(pc),a2
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
		bra        illfunc
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
		moveq.l    #-1,d3
		bra.s      d_stick_ret
d_stick_false:
		clr.l      d3
d_stick_ret:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC M VOLUME volume
 * set master volume
 */
dac_m_volume:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_m_volume_noste
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt        illfunc
		cmp.l      #40,d3
		bgt        illfunc
		ori.w      #LMC1992_FUNCTION_VOLUME,d3
		move.w     d3,d0
		jsr        (a1)
dac_m_volume_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x= FSTICK (j)
 * Returns the current status of the joystick's fire button.
 */
f_stick:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a1
		lea.l      joy_pos(pc),a2
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
		bra        illfunc
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
		moveq.l    #-1,d3
		bra.s      f_stick_ret
f_stick_false:
		clr.l      d3
f_stick_ret:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC M VOLUME volume
 * set left volume
 */
dac_l_volume:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_l_volume_noste
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt        illfunc
		cmp.l      #20,d3
		bgt        illfunc
		ori.w      #LMC1992_FUNCTION_LEFT_FRONT_FADER,d3
		move.w     d3,d0
		jsr        (a1)
dac_l_volume_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x =LIGHT X
 * return the x coordinate of your gun or pen
 */
light_x:
		move.l     (a7)+,returnpc
		move.l     a0,-(a7)
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.w      light_x_err
		move.w     lightpen_x,d3
		move.b     st_shift,d0
		andi.l     #0x000003FF,d3
		andi.l     #0x0000000F,d0
		lsl.l      d0,d3
		bra.s      light_x_ret
light_x_err:
		moveq.l    #-1,d3
light_x_ret:
		clr.l      d2
		clr.l      d4
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC M VOLUME volume
 * set right volume
 */
dac_r_volume:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_r_volume_noste
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt        illfunc
		cmp.l      #20,d3
		bgt        illfunc
		ori.w      #LMC1992_FUNCTION_RIGHT_FRONT_FADER,d3
		move.w     d3,d0
		jsr        (a1)
dac_r_volume_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x =LIGHT Y
 * return the Y coordinate of your gun or pen
 */
light_y:
		move.l     (a7)+,returnpc
		move.l     a0,-(a7)
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.w      light_y_err
		move.w     lightpen_y,d3
		andi.l     #0x000003FF,d3
		bra.s      light_y_ret
light_y_err:
		moveq.l    #-1,d3
light_y_ret:
		clr.l      d2
		clr.l      d4
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC TREBLE volume
 * set treble volume
 */
dac_treble:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_treble_noste
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt        illfunc
		cmp.l      #12,d3
		bgt        illfunc
		ori.w      #LMC1992_FUNCTION_TREBLE,d3
		move.w     d3,d0
		jsr        (a1)
dac_treble_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x = STE
 * returns TRUE if the machine is an STE or FALSE if it isn't
 */
ste:
		move.l     (a7)+,returnpc
		lea.l      is_ste(pc),a0
		clr.l      d2
		clr.l      d3
		clr.l      d4
		move.b     (a0),d3
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC BASS volume
 * set bass volume
 */
dac_bass:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_bass_noste
		/* cmp.l      #0,d3 */
		dc.w 0xb6bc,0,0 /* XXX */
		blt        illfunc
		cmp.l      #12,d3
		bgt        illfunc
		ori.w      #LMC1992_FUNCTION_BASS,d3
		move.w     d3,d0
		jsr        (a1)
dac_bass_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x= E COLOR (colour)
 * returns the RGB value of the colour number, 0 to 15.
 */
e_color:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.s      e_color_noste
		jsr        getparam
		cmp.l      #15,d3
		bhi        illfunc
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
		move.l     d6,d3  /* return value */
		bra.s      e_color_ret
e_color_noste:
		addq.l     #4,a7 /* BUG: must pop 12 bytes, not 4 */
e_color_ret:
		clr.l      d2
		clr.l      d4
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC MIX ON
 * Mix PSG output on
 */
dac_mix_on:
		move.l     (a7)+,returnpc
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_mix_on_noste
		move.w     #LMC1992_FUNCTION_INPUT_SELECT|1,d0
		jsr        (a1)
dac_mix_on_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC MIX ON
 * Mix PSG output off
 */
dac_mix_off:
		move.l     (a7)+,returnpc
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      write_microwire(pc),a1
		tst.b      (a0)
		beq.s      dac_mix_off_noste
		move.w     #LMC1992_FUNCTION_INPUT_SELECT|2,d0
		jsr        (a1)
dac_mix_off_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC MONO
 * sets the sample to be mono
 */
dac_mono:
		move.l     (a7)+,returnpc
		move.l     a0,-(a7)
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.s      dac_mono_noste
		bset       #7,modecontrol
dac_mono_noste:
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * x = HARD PHYSIC (screen address)
 This command tells the ST where the screen is stored.
 */
hard_physic:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		bne        syntax
		jsr        getparam
		move.l     d3,d7
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      physic(pc),a1
		lea.l      next_physic(pc),a2
		tst.b      (a0)
		beq.s      hard_physic_noste
		move.l     d7,physic-physic(a1) /* XXX */
		move.l     d7,next_physic-next_physic(a2) /* XXX */
hard_physic_noste:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC STEREO
 * sets the sample to be mono
 */
dac_stereo:
		move.l     (a7)+,returnpc
		move.l     a0,-(a7)
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.s      dac_stereo_noste
		bclr       #7,modecontrol
dac_stereo_noste:
		movea.l    (a7)+,a0
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC LOOP ON
 * Set the loop function on
 */
dac_loop_on:
		move.l     (a7)+,returnpc
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      dmacontrol_shadow(pc),a1
		tst.b      (a0)
		beq.s      dac_loop_on_noste
		move.b     #3,(a1)
dac_loop_on_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * DAC LOOP OFF
 * Set the loop function off
 */
dac_loop_off:
		move.l     (a7)+,returnpc
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      dmacontrol_shadow(pc),a1
		tst.b      (a0)
		beq.s      dac_loop_off_noste
		move.b     #1,(a1)
dac_loop_off_noste:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * E PALETTE $RGB,$RGB,...(up to 16 colour values)
 * Works exactly as the PALETTE command in STOS,
 * but allows 4 bits per component
 */
e_palette:
		move.l     (a7)+,returnpc
		cmp.w      #1,d0
		blt        syntax
		cmp.w      #16,d0
		bgt        syntax
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.s      e_palette_noste /* FIXME: unneeded, this would work the same on ST */
		clr.l      d1
		move.w     d0,d1
		lsl.w      #1,d1
		subq.w     #1,d0 /* for dbra */
		move.l     a1,d5
		lea.l      st_palette,a1
		adda.l     d1,a1
e_palette_loop:
		jsr        getparam
		cmp.l      #0xFFF,d3
		bhi        illfunc
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
		lsl.l      #2,d0  /* BUG: must pop 12 bytes per param, not 4 */
		adda.l     d0,a7
e_palette_ret:
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * E COLOUR colour,$RGB
 * same as the COLOUR command but allows 4 bits per component
 */
e_colour:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		lea.l      is_ste(pc),a0
		tst.b      (a0)
		beq.w      e_colour_noste /* FIXME: unneeded, this would work the same on ST */
		jsr        getparam
		cmp.l      #0xFFF,d3
		bhi        illfunc
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
		jsr        getparam
		cmp.l      #15,d3
		bhi        illfunc
		lsl.l      #1,d3
		lea.l      st_palette,a0
		move.w     d6,0(a0,d3.w)
		bra.s      e_colour_ret
e_colour_noste:
		addq.l     #8,a7  /* BUG: must pop 12 bytes per param, not 4 */
e_colour_ret:
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * HARD SCREEN SIZE w,h,mode
 * Sets the screens logical size. w=width of screen and h=height of
 * screen ready for scrolling.
 */
hard_screen_size:
		move.l     (a7)+,returnpc
		cmp.w      #3,d0
		bne        syntax
		jsr        getparam
		move.l     d3,d0 ; d0 = mode
		jsr        getparam
		move.l     d3,d7 ; d7 = height
		jsr        getparam
		move.l     d3,d6 ; d6 = width
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      physic(pc),a1
		tst.b      (a0)
		beq        hard_screen_size_noste
		cmp.l      #2,d0
		beq        screensize_mode2
		cmp.l      #1,d0
		beq.s      screensize_mode1
/* set parameters for mode 0 (low resolution) */
		tst.l      d0
		bne        illfunc
		addi.l     #15,d7
		andi.l     #0xFFFFFFF0,d6
		move.l     d6,d5
		subi.l     #320,d6
		bmi        illfunc
		subi.l     #200,d7
		bmi        illfunc
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
		bgt        illfunc
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
		bmi        illfunc
		subi.l     #200,d7
		bmi        illfunc
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
		bgt        illfunc
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
		bmi        illfunc
		subi.l     #400,d7
		bmi        illfunc
		move.l     d6,d0
		move.l     d7,d1
		divs.w     #8,d0
		divs.w     #8,d5
		andi.l     #0x0000FFFF,d0
		andi.l     #0x0000FFFF,d5
		lsr.l      #1,d0
		cmp.l      #255,d0
		bgt        illfunc
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
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * HARD SCREEN OFFSET x,y
 * This command tells the ST where to start displaying the screen.
 */
hard_screen_offset:
		move.l     (a7)+,returnpc
		cmp.w      #2,d0
		bne        syntax
		jsr        getparam
		move.l     d3,d7 ; d7 = y
		jsr        getparam
		move.l     d3,d6 ; d6 = x
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      physic(pc),a1
		tst.b      (a0)
		beq.s      hard_screen_offset_ret
		tst.b      scroll_planes+1-physic(a1)
		beq.w      hard_screen_offset_ret
		move.l     screen_width-physic(a1),d0
		move.l     screen_height-physic(a1),d1
		/* cmp.l      #0,d6 */
		dc.w 0xbcbc,0,0 /* XXX */
		blt        illfunc
		/* cmp.l      #0,d7 */
		dc.w 0xbebc,0,0 /* XXX */
		blt        illfunc
		cmp.l      d0,d6
		bgt        illfunc
		cmp.l      d1,d7
		bgt        illfunc
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
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * HARD INTER ON
 * Turn on hardware scrolling
 */
hard_inter_on:
		move.l     (a7)+,returnpc
		/* cmp.w      #0,d0 */
		dc.w 0xb07c,0 /* XXX */
		bne        syntax
		movem.l    a0-a2,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      vblret+2(pc),a1
		lea.l      intervbl(pc),a2
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
		move.w     #1,is_inter_on
hard_inter_on_ret:
		movem.l    (a7)+,a0-a2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * HARD INTER OFF
 * Turn off hardware scrolling
 */
hard_inter_off:
		move.l     (a7)+,returnpc
		/* cmp.w      #0,d0 */
		dc.w 0xb07c,0 /* XXX */
		bne.w      syntax /* XXX */
		movem.l    a0-a1,-(a7)
		lea.l      is_ste(pc),a0
		lea.l      vblret+2(pc),a1
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
		clr.w      is_inter_on
hard_inter_off_ret:
		movem.l    (a7)+,a0-a1
		movea.l    returnpc,a0
		jmp        (a0)


/*
 * fetch and pop a parameter from the stack
 */
getparam:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne.w      typemismatch /* XXX */
		jmp        (a0)

		dc.l       0
noerror:
		moveq.l    #E_none,d0
		bra.s      goerror
syntax:
		moveq.l    #E_syntax,d0
		bra.s      goerror
illfunc:
		moveq.l    #E_illegalfunc,d0
		bra.s      goerror
typemismatch:
		moveq.l    #E_typemismatch,d0
goerror:
		movea.l    table(pc),a0
		movea.l    sys_error(a0),a0
		jmp        (a0)

myerror:
		movem.l    d0-d7/a0-a6,-(a7)
		clr.l      d0
		jsr        hard_inter_off
		jsr        warm
		movem.l    (a7)+,d0-d7/a0-a6
*
* FIXME: this will not work if original code
* is not really 10 bytes, or contains pc-relative addressings
*
saveerror:
		dc.w       0,0,0,0,0 /* saved opcodes of original error function */
		jmp        0.l /* jumps back to original error function */

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
table: dc.l 0
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
is_inter_on: dc.w 0

finprg:
