		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"

PSG  =	 $ffff8800

iera =   $fffffa07
ipra =   $fffffa0b
isra =   $fffffa0f
imra =   $fffffa13
vr   =   $fffffa17
tacr =   $fffffa19
tadr =   $fffffa1f

TYPE_FORWARD       = 1
TYPE_BACKWARD      = 2
TYPE_LOOP_FORWARD  = 3
TYPE_LOOP_BACKWARD = 4
TYPE_SWEEP         = 5

		.text

		bra.w        load

        dc.b $80
tokens: dc.b "sound init",$80
        dc.b "sample",$81
        dc.b "samplay",$82
        dc.b "samplace",$83
        dc.b "samspeed manual",$84
        dc.b "samspeed auto",$86
        dc.b "samspeed",$88
        dc.b "samstop",$8a
        dc.b "samloop off",$8c
        dc.b "samloop on",$8e
        dc.b "samdir forward",$90
        dc.b "samdir backward",$92
        dc.b "samsweep on",$94
        dc.b "samsweep off",$96
        dc.b "samraw",$98
        dc.b "samrecord",$9a
        dc.b "samcopy",$9c
        dc.b "sammusic",$9e
        dc.b "samthru",$a2
        dc.b "sambank",$a4
        dc.b 0
        even

jumps:  dc.w 38
        dc.l soundinit
        dc.l sample
        dc.l samplay
        dc.l samplace
        dc.l samspeed_manual
        dc.l dummy
        dc.l samspeed_auto
        dc.l dummy
        dc.l samspeed
        dc.l dummy
        dc.l samstop
        dc.l dummy
        dc.l samloop_off
        dc.l dummy
        dc.l samloop_on
        dc.l dummy
		dc.l samdir_forward
        dc.l dummy
		dc.l samdir_backward
        dc.l dummy
		dc.l samsweep_on
        dc.l dummy
		dc.l samsweep_off
        dc.l dummy
		dc.l samraw
        dc.l dummy
		dc.l samrecord
        dc.l dummy
		dc.l samcopy
        dc.l dummy
		dc.l sammusic
        dc.l dummy
        dc.l dummy
        dc.l dummy
		dc.l samthru
        dc.l dummy
		dc.l sambank
        dc.l dummy
		
welcome:
		dc.b 10
		dc.b "STOS Maestro Commands Installed V1",0
		dc.b 10
		dc.b "STOS Maestro V1 Install",$82,0
		.even

		dc.b 0
errormsgs:
		dc.b "Memory Bank does not contain sample data",0
		dc.b "Cette banque ne contient pas de donn",$82,"es digitalis",$82,"es",0
		dc.b "Sample not found in bank",0
		dc.b "Son digitalis",$82," introuvable dans cette banque",0
		dc.b "Sample rate out of range ( 4 - 22 Khz )",0
		dc.b "Frequence d'",$82,"chantillonage hors normes ( 4 - 22 Khz )",0
		dc.b "Sample does not contain its play speed",0
		dc.b "Le son digitalis",$82," n'inclus pas sa fr",$82,"quence",0
		dc.b "End address must be higher than start address",0
		dc.b "L'adresse de fin doit etre sup",$82,"rieure a celle de d",$82,"but",0
		dc.b "Memory bank out of range",0
		dc.b "Mauvais num",$82,"ro de banque",0
		.even

table: ds.l 1

load:
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts

cold:
		lea        table(pc),a1
		move.l     a0,(a1)
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		rts

warm:
		rts

dummy:
		bra.s      syntax

getinteger:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne        typemismatch
		jmp        (a0)

getstring:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bpl        typemismatch
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


/*
 * Syntax: sound init
 */
soundinit:
		tst.w      d0
		bne        syntax
		pea        snd_init(pc)
		move.w     #32,-(a7) ; Dosound
		trap       #14
		addq.l     #6,a7
		rts

/*
 * Syntax: samplay SAMPLENO
 */
samplay:
		move.l     (a7)+,a1
		lea        speed_override(pc),a0
		clr.w      (a0)
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
samplay0:
		lea        sampleno(pc),a0
		move.l     d3,(a0)
		movea.l    table(pc),a0
		movea.l    sys_addrofbank(a0),a0
		move.w     playbankno(pc),d3
		jsr        (a0)
		movea.l    d3,a1
		cmpi.b     #'M',(a1)
		bne        nosampledata
		cmpi.b     #'A',1(a1)
		bne        nosampledata
		cmpi.b     #'E',2(a1)
		bne        nosampledata
		cmpi.b     #'S',3(a1)
		bne        nosampledata
		cmpi.b     #'T',4(a1)
		bne        nosampledata
		cmpi.b     #'R',5(a1)
		bne        nosampledata
		cmpi.b     #'O',6(a1)
		bne        nosampledata
		cmpi.b     #'!',7(a1)
		bne        nosampledata
		move.l     a1,-(a7) ; push returnpc
		clr.w      d7
samplay1:
		addq.l     #8,a1
		addq.w     #1,d7
		tst.l      (a1)
		bne.s      samplay1
		subq.w     #1,d7
		move.w     d7,-(a7) /* FIXME useless */
		move.w     (a7)+,d7
		movea.l    (a7)+,a1
		movea.l    a1,a0
		move.l     sampleno(pc),d3
		tst.b      d3
		beq        samplenotfound
		cmp.b      d7,d3
		bgt        samplenotfound
		andi.l     #255,d3
		lsl.w      #3,d3
		adda.l     d3,a1
		adda.l     (a1),a0
		movea.l    4(a1),a1
		lea        -20(a1),a1
		addq.l     #8,a0

* Sample play routine, includes code for forward,back,loop,sweep
* Also can be used with samples that include their sample rate,
* if no sample rate is found within the sample then the current
* sample rate is used.

* ON ENTRY:
*            A0.L = START ADDRESS OF PLAY
*            A1.L = LENGTH IN BYTES TO PLAY
*          TYPE.W = 1 - FORWARD PLAY
*                 = 2 - BACKWARD PLAY
*                 = 3 - FORWARD LOOP
*                 = 4 - BACKWARD LOOP
*                 = 5 - SWEEP PLAY
*       AUTO_ON.W = 0 - SAMPLE SPEED MANUAL ( USES CURRENT RATE )
*                 = 1 - SAMPLE SPEED AUTO ( SEARCHES FOR RATE STORED )

*         SPEED.B = 5-32 SAMPLE RATE ( IGNORED IF AUTO_ON = 1 )


* I.E,
* 
* 	LEA SAMSTART,A0		; START ADDRESS
*       LEA SAMLENGTH,A1	; LENGTH TO PLAY
*	MOVE.W #1,TYPE		; NORMAL FORWARD PLAY
*       MOVE.W #1,AUTO_ON	; AUTO SPEED SEARCH
*	JSR PLAYSAM		; PLAY THE SAMPLE

* The above code could only be used with files saved using stos maestro
* as auto_on is set to 1, this tells the play routine to search for
* the sample rate which is found after a three byte code saved with
* every stos maestro file, if the code is not found ( a replay or pro-sound 
* file is to be played ) then the current sample rate is used.


playsam:
		move.w     sr,d7                ; save status
		move.w     #0x2700,sr           ; kill interrupts
		lea        startaddr(pc),a2
		move.l     a0,(a2)              ; start address store
		move.l     a1,length-startaddr(a2)     ; length store
		move.l     a0,startaddr2-startaddr(a2) ; backup
		move.l     a1,length2-startaddr(a2)    ; backup

		clr.b      tacr                 ; stop timer a
		move.b     #1,tacr              ; start timer a
		move.w     auto_on(pc),d3       ; auto mode ?
		beq.s      noton                ; no, dont search
		cmpi.b     #'J',(a0)            ; check code digit 1
		bne        nospeed              ; not found use set rate
		cmpi.b     #'O',1(a0)           ; check digit 2
		bne        nospeed              ; not found
		cmpi.b     #'N',2(a0)           ; check digit 3
		bne        nospeed              ; not found
		moveq      #0,d3
		move.b     3(a0),d3             ; 4th byte is the rate
		lea.l      hertz(pc),a0         ; start of rate conversion table
		move.b     0(a0,d3.w),d3        ; get timer a data for samrate
		addi.b     #19,d3               ; add 19 timer ticks
		bra.s      skipnxt              ; store timer a data & skip next bit

noton:
		move.w     speed_override(pc),d3
		beq.s      noton1
		move.b     speed(pc),d3
		bra.s      skipnxt
noton1:
		move.b     speed(pc),d3         ; speed in d3
		addi.b     #19,d3               ; add 19 ticks
skipnxt:
		move.b     d3,tadr              ; store the data

		ori.b      #0x20,imra           ; timer a mask
		ori.b      #0x20,iera           ; timer a enable
		bclr       #3,vr                ; automatic end-of-interrupt BUG: should not mess with this
		move.w     type(pc),d3
		subq.w     #TYPE_FORWARD,d3     ; type 1 forward
		beq.s      type1
		subq.w     #1,d3                ; type 2 backward
		beq.s      type2
		subq.w     #1,d3                ; type 3 forward loop
		beq.s      type3
		subq.w     #1,d3                ; type 4 backward loop
		beq.s      type4
		subq.w     #1,d3                ; type 5 sweep
		beq.s      type5
type1:
		lea        playirq1(pc),a0      ; interrupt address 1
		bra.s      playsamexit
type2:
		move.l     length(pc),d0
		lea        startaddr(pc),a2
		add.l      d0,(a2)         ; start from the end
		add.l      d0,startaddr2-startaddr(a2)
		lea        playirq2(pc),a0      ; interrupt address 2
		bra.s      playsamexit
type3:
		lea        playirq3(pc),a0       ; interrupt address 3
		bra.s      playsamexit
type4:
		move.l     length(pc),d0
		lea        startaddr(pc),a2
		add.l      d0,(a2)         ; start from the end
		add.l      d0,startaddr2-startaddr(a2)
		lea        playirq4(pc),a0      ; interrupt address 4
		bra.s      playsamexit
type5:
		lea        playirq5(pc),a0      ; interrupt address 5
playsamexit:
		move.l     a0,0x0134
		move.w     d7,sr                ; status back
		rts

nospeed:
		move.w     d7,sr                ; status back
		moveq.l    #3,d0
		bra        printerr

nosampledata:
		moveq.l    #0,d0
		bra        printerr

samplenotfound:
		moveq.l    #1,d0

printerr:
		move.w     d0,d4
		lsl.w      #1,d0
		lea.l      errormsgs(pc),a2
		subq.w     #1,d0
		bmi.s      printerr2
printerr1:
		tst.b      (a2)+
		bne.s      printerr1
		dbf        d0,printerr1
printerr2:
		movea.l    table(pc),a1
		movea.l    sys_err2(a1),a1
		jmp        (a1)

* forward normal play routine *

playirq1:
		movem.l    d7/a0/a3,-(a7)
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi        outofit1
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3)+,d7
		move.l     a3,(a0)
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte

outofit1:
		clr.l      (a3)
		bclr       #5,iera              ; disable interrupt
		movem.l    (a7)+,d7/a0/a3       ; stack back
		rte

* backward normal play routine *

playirq2:
		movem.l    d7/a0/a3,-(a7)
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi        outofit1
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		subq.l     #1,a3
		move.l     a3,(a0)
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte

* forward loop play routine *

playirq3:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit2
		addq.l     #1,(a0)
intoit2:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit2:
		move.l     length2(pc),(a3)
		move.l     startaddr2(pc),(a0)
		bra.s      intoit2

* backward loop play routine *

playirq4:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit3
		subq.l     #1,(a0)
intoit3:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit3:
		move.l     length2(pc),(a3)
		move.l     startaddr2(pc),(a0)
		bra.s      intoit3

* sweep play routine *

playirq5:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit4
		addq.l     #1,(a0)
intoit4:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit4:
		move.l     length2(pc),(a3)
		lea        playirq6(pc),a3
		move.l     a3,0x0134
		bra.s      intoit4


playirq6:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit5
		subq.l     #1,(a0)
intoit5:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit5:
		move.l     length2(pc),(a3)
		lea        playirq5(pc),a3
		move.l     a3,0x0134
		bra.s      intoit5


/*
 * Syntax: samspeed N
 */
samspeed:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
		cmp.w      #23,d3
		bge.s      outofrange
		cmp.w      #4,d3
		blt.s      outofrange
		lea        auto_on(pc),a0
		clr.w      (a0)
		lea.l      hertz(pc),a0
		lea        speed(pc),a1
		move.b     0(a0,d3.w),d3
		move.b     d3,(a1)
		addi.b     #19,d3
		move.b     d3,tadr
		rts

outofrange:
		moveq.l    #2,d0
		bra        printerr

/*
 * Syntax: samspeed auto
 */
samspeed_auto:
		tst.w      d0
		bne        syntax
		lea        auto_on(pc),a0
		move.w     #1,(a0)
		rts

/*
 * Syntax: samspeed manual
 */
samspeed_manual:
		tst.w      d0
		bne        syntax
		lea        auto_on(pc),a0
		clr.w      (a0)
		rts

/*
 * Syntax: samstop
 * stop sample routine, simply clears timer a interrupt
 */
samstop:
		tst.w      d0
		bne        syntax
		move.w     sr,d7                ; save status
		move.w     #0x2700,sr           ; kill interrupts
		bclr       #5,iera              ; timer a interrupt off
		move.b     #0xdf,ipra           ; timer a pending clear
		move.b     #0xdf,isra           ; timer a interrupt in service clr
		bclr       #5,imra              ; timer a mask off
		move.w     d7,sr                ; status back
		rts

/*
 * Syntax: samloop off
 */
samloop_off:
		tst.w      d0
		bne        syntax
		lea        type(pc),a0
		cmpi.w     #TYPE_BACKWARD,(a0)
		ble.s      samloop_off1
		cmpi.w     #TYPE_SWEEP,(a0)
		beq.s      samloop_off1
		subq.w     #2,(a0)
samloop_off1:
		rts

/*
 * Syntax: samloop on
 */
samloop_on:
		tst.w      d0
		bne        syntax
		lea        type(pc),a0
		cmpi.w     #TYPE_SWEEP,(a0)
		beq        samloop_on1
		cmpi.w     #TYPE_LOOP_FORWARD,(a0)
		bge.s      samloop_on1
		addq.w     #2,(a0)
samloop_on1:
		rts

/*
 * Syntax: samdir forward
 */
samdir_forward:
		tst.w      d0
		bne        syntax
		lea        type(pc),a0
		cmpi.w     #TYPE_SWEEP,(a0)
		beq.s      samdir_forward2
		cmpi.w     #TYPE_FORWARD,(a0)
		beq.s      samdir_forward2
		cmpi.w     #TYPE_LOOP_FORWARD,(a0)
		beq.s      samdir_forward2
		cmpi.w     #TYPE_BACKWARD,(a0)
		bne.s      samdir_forward1
		move.w     #TYPE_FORWARD,(a0)
		rts
samdir_forward1:
		move.w     #TYPE_LOOP_FORWARD,(a0)
samdir_forward2:
		rts

/*
 * Syntax: samdir backward
 */
samdir_backward:
		tst.w      d0
		bne        syntax
		lea        type(pc),a0
		cmpi.w     #TYPE_LOOP_FORWARD,(a0)
		beq.s      samdir_backward1
		cmpi.w     #TYPE_FORWARD,(a0)
		bne.s      samdir_backward2
		move.w     #TYPE_BACKWARD,(a0)
		rts
samdir_backward1:
		move.w     #TYPE_LOOP_BACKWARD,(a0)
samdir_backward2:
		rts

/*
 * Syntax: samsweep on
 */
samsweep_on:
		tst.w      d0
		bne        syntax
		lea        type(pc),a0
		move.w     #TYPE_SWEEP,(a0)
		rts

/*
 * Syntax: samsweep off
 */
samsweep_off:
		tst.w      d0
		bne        syntax
		lea        type(pc),a0
		move.w     #TYPE_FORWARD,(a0)
		rts

/*
 * Syntax: samraw
 */
samraw:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
		cmp.l      d0,d3
		bge.s      illegalend
		movea.l    d3,a0
		movea.l    d0,a1
		suba.l     a0,a1
		bra        playsam

illegalend:
		moveq.l    #4,d0
		bra        printerr

memorybankrange:
		moveq.l    #5,d0
		bra        printerr

/*
 * Syntax: samrecord ADDR,END
 * samrec records a sample into memory
 * a0.l    = start address
 * a1.l    = length
 * speed.w = sample speed
 */
samrecord:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,d0
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
		cmp.l      d0,d3
		bge.s      illegalend
		movea.l    d3,a0
		movea.l    d0,a1
		suba.l     a0,a1                ; calculate length
		lea        startaddr(pc),a2
		move.l     a0,(a2)         ; start address
		move.l     a1,length-startaddr(a2)            ; length
		move.l     a0,startaddr2-startaddr(a2)        ; backup
		move.l     a1,length2-startaddr(a2)           ; backup
		move.w     sr,d7                ; status save
		move.w     #0x2700,sr           ; interrupts off
		clr.b      tacr                 ; timer a off
		move.b     #1,tacr              ; timer a start
		move.b     speed(pc),d3         ; speed
		addi.b     #19,d3               ; add 19 ticks
		move.b     d3,tadr              ; timer a data
		ori.b      #0x20,imra           ; interrupt mask
		ori.b      #0x20,iera           ; interrupt enable
		bclr       #3,vr                ; automatic end-of-interrupt BUG: should not mess with this
		lea.l      recirq(pc),a0        ; address of routine
		move.l     a0,0x0134
		move.w     d7,sr                ; status back
		rts

* record interrupt routine *
recirq:
		movem.l    d7/a0/a3,-(a7)       ; save regs on stack
		lea        length(pc),a3
		subq.l     #1,(a3)              ; length -1
		bmi.s      routofit             ; end, exit
		lea        startaddr(pc),a0
		movea.l    (a0),a3              ; start address
		moveq      #0,d7                ; clr word
		move.b     0x00FB0001,d7        ; get input data
		move.b     d7,(a3)+             ; save it in memory
		move.l     a3,(a0)              ; start address +1
		lea.l      voldat2(pc),a3       ; volume convert table
		lsl.w      #4,d7                ; d7 * 16
		move.l     0(a3,d7.w),PSG       ; data for volume 1
		move.l     4(a3,d7.w),PSG       ; data for volume 2
		move.l     8(a3,d7.w),PSG       ; data for volume 3
		movem.l    (a7)+,d7/a0/a3       ; stack stuff back
		rte
routofit:
		clr.l      (a3)
		bclr       #5,iera              ; clear timer a interrupt
		movem.l    (a7)+,d7/a0/a3       ; stack stuff back
		rte

/*
 * Syntax: X=sample
 */
sample:
		tst.w      d0
		bne        syntax
		move.b     0x00FB0001,d3 ; get input data
		subi.b     #$80,d3
		ext.w      d3
		ext.l      d3
		clr.b      d2
		rts

/*
 * Syntax: X=samplace
 */
samplace:
		tst.w      d0
		bne        syntax
		move.l     startaddr(pc),d3
		sub.l      startaddr2(pc),d3
		clr.b      d2
		rts

/*
 * Syntax: samcopy SRC,SRCEND,DST
 */
samcopy:
		move.l     (a7)+,a1
		subq.w     #3,d0
		bne        syntax
		bsr        getinteger
		move.l     d3,a2
		bsr        getinteger
		move.l     d3,d0
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
		movea.l    d3,a0
samcopy1:
		move.b     (a0)+,(a2)+
		cmp.l      d0,a0
		blt.s      samcopy1
		rts

/*
 * Syntax: sammusic SAMPLENO,N$
 */
sammusic:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		bsr        getstring
		movea.l    d3,a2
		move.w     (a2)+,d2
		beq.s      sammusic2
		move.b     (a2)+,d0
		andi.b     #0xDF,d0 ; make uppercase
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
		movea.l    a2,a0
		lea.l      notetable(pc),a1
sammusic1:
		cmp.b      (a1)+,d0
		bne.s      sammusic4
		cmp.b      #1,d2
		beq.s      sammusic3
		cmpm.b     (a0)+,(a1)+
		bne.s      sammusic5
		cmp.b      #2,d2
		beq.s      sammusic3
sammusic2:
		moveq.l    #5,d0
		bra        printerr
sammusic3:
		lea        speed(pc),a0
		move.b     (a1),(a0)
		lea        auto_on(pc),a0
		clr.w      (a0)
		lea        speed_override(pc),a0
		move.w     #1,(a0)
		bra        samplay0
sammusic4:
		addq.l     #1,a1
sammusic5:
		addq.l     #2,a1
		movea.l    a2,a0
		tst.b      (a1)
		bne.s      sammusic1
		bra        illfunc


notetable:
	dc.b 'C','9',0,0
	dc.b 'C','#',55,0
	dc.b 'D','5',0,0
	dc.b 'D','#',51,0
	dc.b 'E','1',0,0
	dc.b 'F','.',0,0
	dc.b 'F','#',44,0
	dc.b 'G','+',0,0
	dc.b 'G','#',41,0
	dc.b 'A','(',0,0
	dc.b 'A','#',38,0
	dc.b 'B','%',0,0
	dc.b 0,0,0,0

/*
 * Syntax: samthru
 * thru mode routine
 */
samthru:
		tst.w      d0
		bne        syntax
		move.w     sr,d7                ; save status
		move.w     #0x2700,sr           ; interrupts off
		clr.b      tacr                 ; stop timer a
		move.b     #1,tacr              ; start timer a
		move.b     speed(pc),d3         ; speed
		addi.b     #19,d3               ; +19
		move.b     d3,tadr              ; timer a data
		ori.b      #$20,imra
		ori.b      #$20,iera            ; enable timer a
		bclr       #3,vr
		lea        thruirq(pc),a0       ; address of routine
		move.l     a0,0x0134
		move.w     d7,sr                ; status back
		rts

thruirq:
		movem.l    d7/a3,-(a7)
		moveq      #0,d7
		move.b     $00FB0001,d7         ; get input data
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a3
		rte

/*
 * Syntax: sambank N
 */
sambank:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		bsr        getinteger
		move.l     a1,-(a7) ; push returnpc
		tst.w      d3
		beq        memorybankrange
		cmp.w      #16,d3
		bge        memorybankrange
		lea        playbankno(pc),a0
		move.w     d3,(a0)
		rts

playbankno: dc.w 5
auto_on: ds.w 1

startaddr: ds.l 1
length: ds.l 1
startaddr2: ds.l 1
length2: ds.l 1
type: dc.w 1
speed: dc.b 41
	.even

snd_init:
	dc.b 0,0
	dc.b 1,0
	dc.b 2,0
	dc.b 3,0
	dc.b 4,0
	dc.b 5,0
	dc.b 6,0
	dc.b 7,255
	dc.b 8,0
	dc.b 9,0
	dc.b 10,0
	dc.b 11,0
	dc.b 12,0
	dc.b 13,0
	dc.b -1,0

* Conversion table as used in stos maestro


voldat2:
	dc.l $08000000,$09000000,$0a000000,$00000000
	dc.l $08000000,$09000000,$0a000100,$00000000
	dc.l $08000100,$09000100,$0a000000,$00000000
	dc.l $08000100,$09000100,$0a000100,$00000000
	dc.l $08000200,$09000200,$0a000000,$00000000
	dc.l $08000200,$09000200,$0a000100,$00000000
	dc.l $08000300,$09000100,$0a000000,$00000000
	dc.l $08000300,$09000100,$0a000100,$00000000
	dc.l $08000400,$09000000,$0a000000,$00000000
	dc.l $08000400,$09000100,$0a000100,$00000000
	dc.l $08000400,$09000200,$0a000000,$00000000
	dc.l $08000400,$09000200,$0a000100,$00000000
	dc.l $08000500,$09000000,$0a000000,$00000000
	dc.l $08000500,$09000100,$0a000100,$00000000
	dc.l $08000500,$09000200,$0a000000,$00000000
	dc.l $08000500,$09000200,$0a000100,$00000000
	dc.l $08000500,$09000300,$0a000000,$00000000
	dc.l $08000500,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000200,$0a000000,$00000000
	dc.l $08000600,$09000200,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000000,$00000000
	dc.l $08000600,$09000300,$0a000000,$00000000
	dc.l $08000600,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000200,$00000000
	dc.l $08000600,$09000300,$0a000200,$00000000
	dc.l $08000600,$09000300,$0a000200,$00000000
	dc.l $08000700,$09000000,$0a000000,$00000000
	dc.l $08000700,$09000100,$0a000100,$00000000
	dc.l $08000700,$09000200,$0a000100,$00000000
	dc.l $08000700,$09000200,$0a000200,$00000000
	dc.l $08000700,$09000400,$0a000000,$00000000
	dc.l $08000700,$09000400,$0a000100,$00000000
	dc.l $08000700,$09000400,$0a000200,$00000000
	dc.l $08000700,$09000400,$0a000300,$00000000
	dc.l $08000800,$09000300,$0a000000,$00000000
	dc.l $08000800,$09000300,$0a000200,$00000000
	dc.l $08000800,$09000400,$0a000000,$00000000
	dc.l $08000800,$09000400,$0a000200,$00000000
	dc.l $08000800,$09000500,$0a000000,$00000000
	dc.l $08000800,$09000500,$0a000100,$00000000
	dc.l $08000800,$09000500,$0a000200,$00000000
	dc.l $08000800,$09000500,$0a000300,$00000000
	dc.l $08000900,$09000000,$0a000100,$00000000
	dc.l $08000900,$09000000,$0a000100,$00000000
	dc.l $08000900,$09000200,$0a000200,$00000000
	dc.l $08000900,$09000200,$0a000200,$00000000
	dc.l $08000a00,$09000300,$0a000000,$00000000
	dc.l $08000a00,$09000300,$0a000100,$00000000
	dc.l $08000a00,$09000300,$0a000200,$00000000
	dc.l $08000a00,$09000300,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000100,$00000000
	dc.l $08000a00,$09000400,$0a000100,$00000000
	dc.l $08000a00,$09000400,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000300,$00000000
	dc.l $08000a00,$09000400,$0a000300,$00000000
	dc.l $08000a00,$09000400,$0a000400,$00000000
	dc.l $08000a00,$09000400,$0a000400,$00000000
	dc.l $08000a00,$09000400,$0a000400,$00000000
	dc.l $08000a00,$09000400,$0a000500,$00000000
	dc.l $08000a00,$09000400,$0a000500,$00000000
	dc.l $08000a00,$09000400,$0a000500,$00000000
	dc.l $08000a00,$09000500,$0a000000,$00000000
	dc.l $08000a00,$09000500,$0a000200,$00000000
	dc.l $08000a00,$09000500,$0a000300,$00000000
	dc.l $08000a00,$09000500,$0a000400,$00000000
	dc.l $08000a00,$09000600,$0a000000,$00000000
	dc.l $08000a00,$09000600,$0a000200,$00000000
	dc.l $08000a00,$09000600,$0a000300,$00000000
	dc.l $08000a00,$09000600,$0a000400,$00000000
	dc.l $08000a00,$09000600,$0a000500,$00000000
	dc.l $08000a00,$09000700,$0a000000,$00000000
	dc.l $08000a00,$09000700,$0a000000,$00000000
	dc.l $08000a00,$09000700,$0a000100,$00000000
	dc.l $08000a00,$09000700,$0a000200,$00000000
	dc.l $08000a00,$09000700,$0a000200,$00000000
	dc.l $08000a00,$09000700,$0a000300,$00000000
	dc.l $08000a00,$09000700,$0a000400,$00000000
	dc.l $08000b00,$09000000,$0a000000,$00000000
	dc.l $08000b00,$09000100,$0a000000,$00000000
	dc.l $08000b00,$09000100,$0a000100,$00000000
	dc.l $08000b00,$09000200,$0a000000,$00000000
	dc.l $08000b00,$09000200,$0a000100,$00000000
	dc.l $08000b00,$09000300,$0a000000,$00000000
	dc.l $08000b00,$09000300,$0a000200,$00000000
	dc.l $08000b00,$09000400,$0a000000,$00000000
	dc.l $08000b00,$09000400,$0a000200,$00000000
	dc.l $08000b00,$09000400,$0a000300,$00000000
	dc.l $08000b00,$09000400,$0a000400,$00000000
	dc.l $08000b00,$09000600,$0a000000,$00000000
	dc.l $08000b00,$09000600,$0a000200,$00000000
	dc.l $08000b00,$09000600,$0a000300,$00000000
	dc.l $08000b00,$09000600,$0a000400,$00000000
	dc.l $08000b00,$09000800,$0a000000,$00000000
	dc.l $08000b00,$09000800,$0a000100,$00000000
	dc.l $08000b00,$09000800,$0a000300,$00000000
	dc.l $08000b00,$09000800,$0a000400,$00000000
	dc.l $08000b00,$09000900,$0a000000,$00000000
	dc.l $08000b00,$09000900,$0a000200,$00000000
	dc.l $08000b00,$09000900,$0a000300,$00000000
	dc.l $08000b00,$09000900,$0a000400,$00000000
	dc.l $08000c00,$09000400,$0a000000,$00000000
	dc.l $08000c00,$09000400,$0a000000,$00000000
	dc.l $08000c00,$09000400,$0a000100,$00000000
	dc.l $08000c00,$09000400,$0a000100,$00000000
	dc.l $08000c00,$09000500,$0a000200,$00000000
	dc.l $08000c00,$09000500,$0a000200,$00000000
	dc.l $08000c00,$09000500,$0a000300,$00000000
	dc.l $08000c00,$09000500,$0a000300,$00000000
	dc.l $08000c00,$09000500,$0a000400,$00000000
	dc.l $08000c00,$09000500,$0a000400,$00000000
	dc.l $08000c00,$09000600,$0a000000,$00000000
	dc.l $08000c00,$09000600,$0a000100,$00000000
	dc.l $08000c00,$09000600,$0a000200,$00000000
	dc.l $08000c00,$09000600,$0a000400,$00000000
	dc.l $08000c00,$09000700,$0a000000,$00000000
	dc.l $08000c00,$09000700,$0a000200,$00000000
	dc.l $08000c00,$09000700,$0a000400,$00000000
	dc.l $08000c00,$09000800,$0a000000,$00000000
	dc.l $08000c00,$09000800,$0a000200,$00000000
	dc.l $08000c00,$09000800,$0a000300,$00000000
	dc.l $08000c00,$09000800,$0a000400,$00000000
	dc.l $08000c00,$09000900,$0a000000,$00000000
	dc.l $08000c00,$09000900,$0a000200,$00000000
	dc.l $08000c00,$09000900,$0a000300,$00000000
	dc.l $08000d00,$09000000,$0a000000,$00000000
	dc.l $08000d00,$09000100,$0a000000,$00000000
	dc.l $08000d00,$09000100,$0a000100,$00000000
	dc.l $08000d00,$09000200,$0a000100,$00000000
	dc.l $08000d00,$09000300,$0a000100,$00000000
	dc.l $08000d00,$09000300,$0a000200,$00000000
	dc.l $08000d00,$09000400,$0a000000,$00000000
	dc.l $08000d00,$09000400,$0a000200,$00000000
	dc.l $08000d00,$09000400,$0a000300,$00000000
	dc.l $08000d00,$09000400,$0a000400,$00000000
	dc.l $08000d00,$09000500,$0a000300,$00000000
	dc.l $08000d00,$09000500,$0a000400,$00000000
	dc.l $08000d00,$09000600,$0a000300,$00000000
	dc.l $08000d00,$09000600,$0a000400,$00000000
	dc.l $08000d00,$09000700,$0a000000,$00000000
	dc.l $08000d00,$09000700,$0a000200,$00000000
	dc.l $08000d00,$09000700,$0a000300,$00000000
	dc.l $08000d00,$09000700,$0a000400,$00000000
	dc.l $08000d00,$09000700,$0a000500,$00000000
	dc.l $08000d00,$09000700,$0a000500,$00000000
	dc.l $08000d00,$09000800,$0a000000,$00000000
	dc.l $08000d00,$09000800,$0a000200,$00000000
	dc.l $08000d00,$09000800,$0a000400,$00000000
	dc.l $08000d00,$09000800,$0a000500,$00000000
	dc.l $08000d00,$09000900,$0a000100,$00000000
	dc.l $08000d00,$09000900,$0a000300,$00000000
	dc.l $08000d00,$09000900,$0a000400,$00000000
	dc.l $08000d00,$09000900,$0a000500,$00000000
	dc.l $08000d00,$09000900,$0a000500,$00000000
	dc.l $08000d00,$09000900,$0a000600,$00000000
	dc.l $08000d00,$09000900,$0a000600,$00000000
	dc.l $08000d00,$09000900,$0a000600,$00000000
	dc.l $08000d00,$09000a00,$0a000100,$00000000
	dc.l $08000d00,$09000a00,$0a000200,$00000000
	dc.l $08000d00,$09000a00,$0a000300,$00000000
	dc.l $08000d00,$09000a00,$0a000300,$00000000
	dc.l $08000d00,$09000a00,$0a000400,$00000000
	dc.l $08000d00,$09000a00,$0a000500,$00000000
	dc.l $08000d00,$09000a00,$0a000500,$00000000
	dc.l $08000d00,$09000a00,$0a000600,$00000000
	dc.l $08000d00,$09000b00,$0a000000,$00000000
	dc.l $08000d00,$09000b00,$0a000100,$00000000
	dc.l $08000d00,$09000b00,$0a000200,$00000000
	dc.l $08000d00,$09000b00,$0a000300,$00000000
	dc.l $08000d00,$09000b00,$0a000400,$00000000
	dc.l $08000d00,$09000b00,$0a000400,$00000000
	dc.l $08000d00,$09000b00,$0a000500,$00000000
	dc.l $08000d00,$09000b00,$0a000500,$00000000
	dc.l $08000e00,$09000000,$0a000000,$00000000
	dc.l $08000e00,$09000000,$0a000100,$00000000
	dc.l $08000e00,$09000300,$0a000000,$00000000
	dc.l $08000e00,$09000300,$0a000200,$00000000
	dc.l $08000e00,$09000400,$0a000300,$00000000
	dc.l $08000e00,$09000400,$0a000500,$00000000
	dc.l $08000e00,$09000500,$0a000400,$00000000
	dc.l $08000e00,$09000500,$0a000500,$00000000
	dc.l $08000e00,$09000700,$0a000000,$00000000
	dc.l $08000e00,$09000700,$0a000300,$00000000
	dc.l $08000e00,$09000700,$0a000400,$00000000
	dc.l $08000e00,$09000700,$0a000400,$00000000
	dc.l $08000e00,$09000800,$0a000200,$00000000
	dc.l $08000e00,$09000800,$0a000400,$00000000
	dc.l $08000e00,$09000800,$0a000500,$00000000
	dc.l $08000e00,$09000800,$0a000500,$00000000
	dc.l $08000e00,$09000900,$0a000000,$00000000
	dc.l $08000e00,$09000900,$0a000100,$00000000
	dc.l $08000e00,$09000900,$0a000200,$00000000
	dc.l $08000e00,$09000900,$0a000300,$00000000
	dc.l $08000e00,$09000900,$0a000500,$00000000
	dc.l $08000e00,$09000900,$0a000500,$00000000
	dc.l $08000e00,$09000900,$0a000600,$00000000
	dc.l $08000e00,$09000900,$0a000700,$00000000
	dc.l $08000e00,$09000a00,$0a000000,$00000000
	dc.l $08000e00,$09000a00,$0a000500,$00000000
	dc.l $08000e00,$09000a00,$0a000800,$00000000
	dc.l $08000e00,$09000a00,$0a000900,$00000000
	dc.l $08000e00,$09000b00,$0a000300,$00000000
	dc.l $08000e00,$09000b00,$0a000600,$00000000
	dc.l $08000e00,$09000b00,$0a000800,$00000000
	dc.l $08000e00,$09000b00,$0a000900,$00000000
	dc.l $08000e00,$09000c00,$0a000000,$00000000
	dc.l $08000e00,$09000c00,$0a000100,$00000000
	dc.l $08000e00,$09000c00,$0a000200,$00000000
	dc.l $08000e00,$09000c00,$0a000300,$00000000
	dc.l $08000e00,$09000c00,$0a000400,$00000000
	dc.l $08000e00,$09000c00,$0a000400,$00000000
	dc.l $08000e00,$09000c00,$0a000500,$00000000
	dc.l $08000e00,$09000c00,$0a000500,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000000,$00000000
	dc.l $08000e00,$09000d00,$0a000100,$00000000
	dc.l $08000e00,$09000d00,$0a000200,$00000000
	dc.l $08000e00,$09000d00,$0a000200,$00000000
	dc.l $08000e00,$09000d00,$0a000300,$00000000
	dc.l $08000e00,$09000d00,$0a000400,$00000000
	dc.l $08000e00,$09000d00,$0a000500,$00000000
	dc.l $08000e00,$09000d00,$0a000500,$00000000
	dc.l $08000e00,$09000d00,$0a000600,$00000000
	dc.l $08000e00,$09000d00,$0a000600,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000800,$00000000
	dc.l $08000e00,$09000d00,$0a000800,$00000000
	dc.l $08000e00,$09000e00,$0a000000,$00000000
	dc.l $08000e00,$09000e00,$0a000000,$00000000
	dc.l $08000e00,$09000e00,$0a000100,$00000000
	dc.l $08000e00,$09000e00,$0a000100,$00000000
	dc.l $08000e00,$09000e00,$0a000200,$00000000
	dc.l $08000e00,$09000e00,$0a000200,$00000000
	dc.l $08000e00,$09000e00,$0a000300,$00000000
	dc.l $08000e00,$09000e00,$0a000300,$00000000
	dc.l $08000e00,$09000e00,$0a000400,$00000000
	dc.l $08000e00,$09000e00,$0a000500,$00000000
	dc.l $08000e00,$09000e00,$0a000600,$00000000
	dc.l $08000e00,$09000e00,$0a000600,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000

hertz:
	dc.b 0,0,0,0,115,91,75,63,54,47,41,36,32,28,25,22,20,18,16
	dc.b 14,13,11,10,9,8,7,6,5,4,3,2,1,0,0
	even

speed_override: ds.w 1

sampleno: ds.l 1


finprg:
