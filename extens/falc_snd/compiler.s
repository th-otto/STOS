	.include "system.inc"
	.include "errors.inc"
	.include "equates.inc"
	.include "wave.inc"

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
	dc.w	lib19-lib18
	dc.w	lib20-lib19
	dc.w	lib21-lib20
	dc.w	lib22-lib21
	dc.w	lib23-lib22
	dc.w	lib24-lib23
	dc.w	lib25-lib24
	dc.w	lib26-lib25
	dc.w	lib27-lib26
	dc.w	lib28-lib27
	dc.w	lib29-lib28
	dc.w	lib30-lib29
	dc.w	lib31-lib30
	dc.w	lib32-lib31
	dc.w	lib33-lib32
	dc.w	lib34-lib33
	dc.w	lib35-lib34
	dc.w	lib36-lib35
	dc.w	lib37-lib36
	dc.w	lib38-lib37
	dc.w	lib39-lib38
	dc.w	lib40-lib39
	dc.w	lib41-lib40
	dc.w	lib42-lib41
	dc.w	lib43-lib42
	dc.w	lib44-lib43
	dc.w	lib45-lib44
	dc.w	libex-lib45

para:
	dc.w	45			; number of library routines
	dc.w	45			; number of extension commands
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
	.dc.w l019-para
	.dc.w l020-para
	.dc.w l021-para
	.dc.w l022-para
	.dc.w l023-para
	.dc.w l024-para
	.dc.w l025-para
	.dc.w l026-para
	.dc.w l027-para
	.dc.w l028-para
	.dc.w l029-para
	.dc.w l030-para
	.dc.w l031-para
	.dc.w l032-para
	.dc.w l033-para
	.dc.w l034-para
	.dc.w l035-para
	.dc.w l036-para
	.dc.w l037-para
	.dc.w l038-para
	.dc.w l039-para
	.dc.w l040-para
	.dc.w l041-para
	.dc.w l042-para
	.dc.w l043-para
	.dc.w l044-para
	.dc.w l045-para

* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,1,1,0             ; dma reset
l002:	.dc.b I,1,1,0             ; locksound
l003:	.dc.b 0,I,',',I,',',I,1,1,0 ; dma buffer
l004:	.dc.b I,1,1,0             ; unlocksound
l005:	.dc.b 0,I,',',I,',',I,1,1,0             ; devconnect
l006:	.dc.b I,1,1,0             ; dma status
l007:	.dc.b 0,1,1,0             ; dma samsign
l008:	.dc.b I,1,1,0             ; dma samrecptr
l009:	.dc.b 0,I,1,1,0           ; dma setmode
l010:	.dc.b I,1,1,0             ; dma samplayptr
l011:	.dc.b 0,I,',',I,1,1,0     ; dma samtracks
l012:	.dc.b I,1,1,0             ; dma samstatus
l013:	.dc.b 0,I,1,1,0           ; dma montrack
l014:	.dc.b I,1,1,0             ; dma samtype
l015:	.dc.b 0,I,',',I,1,1,0     ; dma interrupt
l016:	.dc.b I,1,1,0             ; dma samfreq
l017:	.dc.b 0,1,1,0             ; dma samrecord
l018:	.dc.b I,1,1,0             ; dma sammode
l019:	.dc.b 0,1,1,0             ; dma playloop off
l020:	.dc.b I,1,1,0             ; dma sampval
l021:	.dc.b 0,1,1,0             ; dma playloop on
l022:	.dc.b I,1
        .dc.b   I,',',I,',',S,1,1,0     ; dma samconvert */
l023:	.dc.b 0,1,1,0             ; dma samplay
l024:	.dc.b I,1,1,0             ; dma samsize
l025:	.dc.b 0,1,1,0             ; dma samthru
l026:	.dc.b I,1,1,0             ;
l027:	.dc.b 0,1,1,0             ; dma samstop
l028:	.dc.b I,1,1,0             ;
l029:	.dc.b 0,I,1,1,0           ; adder in
l030:	.dc.b I,1,1,0             ;
l031:	.dc.b 0,I,1,1,0           ; adc input
l032:	.dc.b I,1,1,0             ;
l033:	.dc.b 0,1,1,0             ;
l034:	.dc.b I,1,1,0             ;
l035:	.dc.b 0,I,1,1,0           ; left gain
l036:	.dc.b I,1,1,0             ;
l037:	.dc.b 0,I,1,1,0           ; right gain
l038:	.dc.b I,1,1,0             ;
l039:	.dc.b 0,I,1,1,0           ; left volume
l040:	.dc.b I,1,1,0             ;
l041:	.dc.b 0,I,1,1,0           ; right volume
l042:	.dc.b I,1,1,0             ;
l043:	.dc.b 0,1,1,0             ; speaker off
l044:	.dc.b I,1,1,0             ;
l045:	.dc.b 0,1,1,0             ; speaker on
		.even


entry:
	bra.w init

params:
dma_initialized: ds.w 1
dma_bufferset: ds.w 1
dma_recstart_addr: ds.l 1 /* 1188a, 4 */
dma_recend_addr: ds.l 1 /* 1188e, 8 */
dma_playstart_addr: ds.l 1 /* 11892, 12 */
dma_playdata_addr: ds.l 1 /* 11896, 16 */
dma_playend_addr: ds.l 1 /* 1189a, 20 */
dma_mode:  ds.w 1  /* 1189e, 24 */
dma_playloop: ds.w 1 /* 118a0, 26 */
paramsend:

mch_cookie: dc.l 0
snd_cookie: dc.l 0

init:
cold:
		lea.l      entry(pc),a4
		move.l     #0x5F4D4348,d3 /* '_MCH' */
		bsr        getcookie
		move.l     d0,mch_cookie-entry(a4)
		move.l     #0x5F534E44,d3 /* '_SND' */
		bsr        getcookie
		move.l     d0,snd_cookie-entry(a4)
		lea        exit(pc),a2
		rts

exit:
	rts

illfunc:
illfalconfunc:
		moveq.l    #E_illegalfunc,d0
goerror:
        move.l table(a5),a0
        move.l sys_error(a0),a0
        jmp (a0)

getjar:
		move.l     0x000005A0,d0
		rts
getcookie:
		pea        getjar(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
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

/*
 * Syntax:   dma reset
 */
lib1:
	dc.w	0			; no library calls
dma_reset:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_reset2
* setplayback mode
		move.w     #0,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
* unlock sound
		move.w     #0x0081,-(a7) /* unlocksnd */
		trap       #14
		addq.l     #2,a7
* reset sound
		move.w     #1,-(a7)
		move.w     #0x008C,-(a7) /* sndstatus */
		trap       #14
		addq.l     #4,a7
* src=DMA, dst=speaker, srcclk=intern, prescale=0, protocol=handshake
		move.w     #1,-(a7)
		move.w     #0,-(a7)
		move.w     #0,-(a7)
		move.w     #8,-(a7)
		move.w     #0,-(a7)
		move.w     #0x008B,-(a7) /* devconnect */
		trap       #14
		lea.l      12(a7),a7
* set prescale
		move.w     #PRE320,-(a7)
		move.w     #SETPRESCALE,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
* set 8 bit stereo
		move.w     #0,-(a7)
		move.w     #0x0084,-(a7) /* setmode */
		trap       #14
		addq.l     #4,a7
* set tracks
		move.l     #0,-(a7)
		move.w     #0x0085,-(a7) /* settracks */
		trap       #14
		addq.l     #6,a7
* both inputs for adder
		move.w     #ADCIN+MATIN,-(a7)
		move.w     #ADDERIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
* for inputs for A/D
		move.w     #ADCRT+ADCLT,-(a7)
		move.w     #ADCINPUT,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
* generate MFP 7 interrupt after playback
		move.w     #1,-(a7)
		move.w     #1,-(a7)
		move.w     #0x0087,-(a7) /* setinterrupt */
		trap       #14
		addq.l     #6,a7
* set left & right output gain
		move.w     #0,-(a7)
		move.w     #LTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		move.w     #0,-(a7)
		move.w     #RTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		/* BUG? LTATTEN/RTATTEN not set here */

		lea        params-entry(a4),a4
		move.w     #(paramsend-params)/2-1,d7
dma_reset1:
		clr.w      (a4)+
		dbf        d7,dma_reset1

dma_reset2:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

/*
 * Syntax:   X=locksound
 */
lib2:
	dc.w	0			; no library calls
locksound:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        locksound1
		movem.l    d1-d2/a0-a2,-(a7)
		move.w     #0x0080,-(a7) /* locksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d2/a0-a2
		move.l     d0,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts
locksound1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   dma buffer REG,BEG_BUFF,EN_BUFF
 */
lib3:
	dc.w	0			; no library calls
dma_buffer:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_buffer5
		move.l     (a6)+,a3
		move.l     (a6)+,a2
		move.l     (a6)+,d3
		clr.l      d2
		andi.w     #1,d3
		bne.s      dma_buffer2
		cmpi.l     #AVR_MAGIC,avr_magic(a2)
		bne.s      dma_buffer1
		move.l     #avr_headersize,d2
		bra.s      dma_buffer3
dma_buffer1:
		cmpi.l     #WAVE_MAGIC,wave_magic(a2)
		bne.s      dma_buffer3
		cmpi.l     #WAVE_FMT,wave_ckid(a2)
		bne.s      dma_buffer3
		move.l     #wave_headersize,d2 /* BUG: should use cksize from header */
		bra.s      dma_buffer3
dma_buffer2:
		move.l     a3,dma_recend_addr-entry(a4)
		move.l     a2,dma_recstart_addr-entry(a4)
		move.w     #-1,dma_bufferset-entry(a4)
		bra.s      dma_buffer4
dma_buffer3:
		move.l     a3,dma_playend_addr-entry(a4)
		move.l     a2,dma_playstart_addr-entry(a4)
		add.l      d2,a2
		move.l     a2,dma_playdata_addr-entry(a4)
dma_buffer4:
		move.w     #-1,dma_bufferset-entry(a4)
		move.l     a3,-(a7)
		move.l     a2,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		movem.l    (a7)+,a0-a5
		rts
dma_buffer5:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

dma_buffer_args:
	ds.l 1 /* end addr */
	ds.l 1 /* start addr */
	ds.w 1 /* buffer type playback/record */
	ds.l 1 /* data offset */

/*
 * Syntax:   X=unlocksound
 */
lib4:
	dc.w	0			; no library calls
unlocksound:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        unlocksound1
		movem.l    d1-d2/a0-a2,-(a7)
		move.w     #0x0081,-(a7) /* unlocksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d2/a0-a2
		move.l     d0,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts
unlocksound1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   devconnect SOURCE,DEST,FREQ
 */
lib5:
	dc.w	0			; no library calls
devconnect:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        devconnect2
		move.l     (a6)+,d3
		lea.l      devconnect_freq(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		andi.w     #15,d3
		lea.l      devconnect_dest(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		andi.w     #3,d3
		lea.l      devconnect_source(pc),a1
		move.w     d3,(a1)
		lea.l      devconnect_freq(pc),a1
		move.w     (a1),d3
		cmpi.w     #50000,d3
		bgt        devconnect2
		cmpi.w     #8195,d3
		blt        devconnect2
		movem.l    a0-a5,-(a7)
		bsr.w      find_freq
		lea.l      devconnect_prescale(pc),a1
		move.w     d0,(a1)
		lea.l      devconnect_steprescale(pc),a1
		move.w     d1,(a1)
		lea.l      devconnect_protocol(pc),a1
		move.w     (a1),-(a7)
		move.w     devconnect_prescale-devconnect_protocol(a1),-(a7)
		move.w     devconnect_srcclk-devconnect_protocol(a1),-(a7)
		move.w     devconnect_dest-devconnect_protocol(a1),-(a7)
		move.w     devconnect_source-devconnect_protocol(a1),-(a7)
		move.w     #0x008B,-(a7) /* devconnect */
		trap       #14
		lea.l      12(a7),a7
		lea.l      devconnect_prescale(pc),a1
		tst.w      (a1)
		bne.s      devconnect1
		bsr.w      set_prescale
devconnect1:
		movem.l    (a7)+,a0-a5
		rts
devconnect2:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

set_prescale:
		lea.l      devconnect_steprescale(pc),a1
		move.w     (a1),-(a7)
		move.w     #SETPRESCALE,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		rts

find_freq:
		lea.l      freqtable(pc),a0
		lea.l      freqtableend(pc),a1
		lea.l      devconnect_freq(pc),a2
		lea.l      devconnect_bestfreq(pc),a5
		move.w     #0x2000,(a5)
		move.w     #0,devconnect_freqidx-devconnect_bestfreq(a5)
		move.w     (a2),d0
		andi.l     #0x0000FFFF,d0
find_freq_1:
		cmpa.l     a0,a1
		beq.s      find_freq_3
		cmp.w      (a0),d0
		beq.s      find_freq_2
		addq.l     #6,a0
		bra.s      find_freq_1
find_freq_2:
		move.w     2(a0),d0
		move.w     4(a0),d1
		rts
find_freq_3:
		lea.l      freqtable(pc),a0
		lea.l      freqtableend(pc),a1
		lea.l      devconnect_freq(pc),a2
		clr.l      d6
find_freq_4:
		cmpa.l     a0,a1
		beq.s      find_freq_7
		move.w     (a2),d0
		andi.l     #0x0000FFFF,d0
		move.w     (a0),d1
		andi.l     #0x0000FFFF,d1
		sub.w      d1,d0
		bpl.s      find_freq_5
		neg.w      d0
find_freq_5:
		lea.l      devconnect_bestfreq(pc),a5
		cmp.w      (a5),d0
		bge.s      find_freq_6
		move.w     d0,(a5)
		move.w     d6,devconnect_freqidx-devconnect_bestfreq(a5)
find_freq_6:
		addq.l     #6,a0
		addq.w     #1,d6
		bra.s      find_freq_4
find_freq_7:
		lea.l      devconnect_bestfreq(pc),a5
		move.w     devconnect_freqidx-devconnect_bestfreq(a5),d6
		lea.l      freqtable(pc),a0
		mulu.w     #6,d6
		move.w     2(a0,d6.w),d0
		move.w     4(a0,d6.w),d1
		rts

devconnect_bestfreq: dc.w 0
devconnect_freqidx: dc.w 0
devconnect_protocol: dc.w 1
devconnect_prescale: dc.w 0
devconnect_srcclk: dc.w 0
devconnect_dest: dc.w 0
devconnect_source: dc.w 0
devconnect_steprescale: dc.w 0
devconnect_freq: dc.w 0
 dc.w 0 /* unused */

freqtable:
		dc.w 50000,0,3
		dc.w 49170,1,0
		dc.w 33880,2,0
		dc.w 25000,0,2
		dc.w 24585,3,0
		dc.w 20770,4,0
		dc.w 16490,5,0
		dc.w 12500,0,1
		dc.w 12292,7,0
		dc.w 9834,9,0
		dc.w 8195,11,0
freqtableend: dc.w 0,0

/*
 * Syntax:   X=dma status
 */
lib6:
	dc.w	0			; no library calls
dma_status:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_status1
		movem.l    a0-a5,-(a7)
		move.w     #0,-(a7)
		move.w     #0x008C,-(a7) /* sndstatus */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a5
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts
dma_status1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   dma samsign
 */
lib7:
	dc.w	0			; no library calls
dma_samsign:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq        dma_samsign15
		movea.l    dma_playdata_addr-entry(a4),a0
		movea.l    dma_playend_addr-entry(a4),a1
		movea.l    dma_playstart_addr-entry(a4),a2
		cmpi.l     #AVR_MAGIC,avr_magic(a2)
		bne.s      dma_samsign6
		cmpi.w     #16,avr_bits(a2)
		beq.s      dma_samsign3
dma_samsign2:
		cmpa.l     a0,a1
		beq.s      dma_samsign15
		eori.b     #0x80,(a0)+
		bra.s      dma_samsign2
dma_samsign3:
dma_samsign4:
		cmpa.l     a0,a1
		beq.s      dma_samsign15
		move.w     (a0),d0
		eori.w     #0x8000,d0
		move.w     d0,(a0)+
		bra.s      dma_samsign4
dma_samsign6:
		cmpi.l     #WAVE_MAGIC,wave_magic(a2)
		bne.s      dma_samsign15
		cmpi.l     #WAVE_FMT,wave_ckid(a2)
		bne.s      dma_samsign15
		cmpi.w     #0x1000,wave_bits(a2)
		beq.s      dma_samsign13
		cmpi.w     #0x0800,wave_bits(a2)
		bne.s      dma_samsign15
dma_samsign11:
		cmpa.l     a0,a1
		beq.s      dma_samsign15
		eori.b     #0x80,(a0)+
		bra.s      dma_samsign11
dma_samsign13:
dma_samsign14:
		cmpa.l     a0,a1
		beq.s      dma_samsign15
		move.w     (a0),d0
		rol.w      #8,d0
		eori.w     #0x8000,d0
		move.w     d0,(a0)+
		bra.s      dma_samsign14
dma_samsign15:
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax:   POS=dma samrecptr
 */
lib8:
	dc.w	0			; no library calls
dma_samrecptr:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		clr.l      d3
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samrecptr1
		pea.l      buffptrbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		move.l     dma_recstart_addr-entry(a4),d0
		move.l     buffptrbuf+4(pc),d3
		sub.l      d0,d3
dma_samrecptr1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

buffptrbuf: ds.l 4

/*
 * Syntax:   dma setmode MDE
 */
lib9:
	dc.w	0			; no library calls
dma_setmode:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_setmode1
		move.l     (a6)+,d3
		cmpi.w     #3,d3
		bcc        dma_setmode1
		movem.l    a0-a2,-(a7)
		move.w     d3,dma_mode-entry(a4)
		move.w     d3,-(a7)
		move.w     #0x0084,-(a7) /* setmode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts
dma_setmode1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   POS=dma samplayptr
 */
lib10:
	dc.w	0			; no library calls
dma_samplayptr:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		clr.l      d3
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samplayptr1
		pea.l      buffptrbuf2(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		move.l     dma_playdata_addr-entry(a4),d0
		move.l     buffptrbuf2(pc),d3
		sub.l      d0,d3
dma_samplayptr1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

buffptrbuf2: ds.l 4

/*
 * Syntax:   dma samtracks PLAYTRK,RECTRK
 */
lib11:
	dc.w	0			; no library calls
dma_samtracks:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_samtracks1
		move.l     (a6)+,d0
		andi.w     #3,d0
		move.l     (a6)+,d3
		andi.w     #3,d3
		movem.l    a0-a5,-(a7)
		move.w     d0,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0085,-(a7) /* settracks */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a5
		rts
dma_samtracks1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   X=dma samstatus
 */
lib12:
	dc.w	0			; no library calls
dma_samstatus:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_samstatus1
		movem.l    a0-a2,-(a7)
		move.w     #-1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		moveq      #0,d3
		move.w     d0,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts
dma_samstatus1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   dma montrack TRACK
 */
lib13:
	dc.w	0			; no library calls
dma_montrack:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_montrack1
		move.l     (a6)+,d3
		andi.w     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0086,-(a7) /* setmontracks */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts
dma_montrack1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   SND_TYPE=dma samtype
 */
lib14:
	dc.w	0			; no library calls
dma_samtype:
		movem.l    a0-a5,-(a7)
		clr.l      d3
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samtype1
		move.l     dma_playstart_addr-entry(a4),a0
		lea        128(a0),a1
		move.l     a0,d0
		bsr        find_avr
		tst.l      d3
		bpl.s      dma_samtype1
		move.l     d0,a0
		bsr        find_wave
		tst.l      d3
		bpl.s      dma_samtype1
		clr.l      d3
dma_samtype1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

find_avr:
		moveq.l    #-1,d3
find_avr1:
		cmpa.l     a0,a1
		beq.s      find_avr2
		cmpi.b     #'2',(a0)+
		bne.s      find_avr1
		cmpi.b     #'B',(a0)
		bne.s      find_avr1
		cmpi.b     #'I',1(a0)
		bne.s      find_avr1
		cmpi.b     #'T',2(a0)
		bne.s      find_avr1
		subq.l     #1,a0
		moveq.l    #1,d3
find_avr2:
		rts

find_wave:
		moveq.l    #-1,d3
find_wave1:
		cmpa.l     a0,a1
		beq.s      find_wave2
		cmpi.b     #'W',(a0)+
		bne.s      find_wave1
		cmpi.b     #'A',(a0)
		bne.s      find_wave1
		cmpi.b     #'V',1(a0)
		bne.s      find_wave1
		cmpi.b     #'E',2(a0)
		bne.s      find_wave1
		cmpi.b     #'f',3(a0)
		bne.s      find_wave1
		cmpi.b     #'m',4(a0)
		bne.s      find_wave1
		cmpi.b     #'t',5(a0)
		bne.s      find_wave1
		subq.l     #1,a0
		moveq.l    #2,d3
find_wave2:
		rts

/*
 * Syntax:   dma interrupt MODE,CAUSE
 */
lib15:
	dc.w	0			; no library calls
dma_interrupt:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_interrupt1
		move.l     (a6)+,d0
		andi.w     #3,d0
		move.l     (a6)+,d3
		andi.w     #1,d3
		movem.l    a0-a5,-(a7)
		move.w     d0,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0087,-(a7) /* setinterrupt */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a5
		rts
dma_interrupt1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   FREQ=dma samfreq
 */
lib16:
	dc.w	0			; no library calls
dma_samfreq:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samfreq2
		movea.l    dma_playstart_addr-entry(a4),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.s      dma_samfreq1
		move.w     avr_samprate+2(a0),d0
		bsr        samfreq_find
		move.l     d0,d3
		bra.s      dma_samfreq3
dma_samfreq1:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.s      dma_samfreq2
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.s      dma_samfreq2
		move.b     wave_samprate+1(a0),d0
		rol.w      #8,d0
		move.b     wave_samprate(a0),d0
		bsr        samfreq_find
		move.l     d0,d3
		bra.s      dma_samfreq3
dma_samfreq2:
		move.l     #12292,d3
dma_samfreq3:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

samfreq_find:
		lea.l      samfreq_table(pc),a0
		lea.l      samfreq_tableend(pc),a1
		lea.l      samfreq_bestfreq(pc),a4
		move.w     #8192,(a4)
		move.w     #0,samfreq_freqidx-samfreq_bestfreq(a4)
samfreq_find1:
		cmpa.l     a0,a1
		beq.s      samfreq_find3
		cmp.w      (a0),d0
		beq.s      samfreq_find2
		addq.l     #4,a0
		bra.w      samfreq_find1
samfreq_find2:
		move.w     (a0),d0
		rts
samfreq_find3:
		lea.l      samfreq_table(pc),a0
		clr.l      d6
samfreq_find4:
		cmpa.l     a0,a1
		beq.s      samfreq_find7
		move.w     d0,d2
		move.w     (a0),d1
		sub.w      d1,d2
		bpl.s      samfreq_find5
		neg.w      d2
samfreq_find5:
		lea.l      samfreq_bestfreq(pc),a4
		cmp.w      (a4),d2
		bge.s      samfreq_find6
		move.w     d2,(a4)
		move.w     d6,samfreq_freqidx-samfreq_bestfreq(a4)
samfreq_find6:
		addq.l     #4,a0
		addq.w     #1,d6
		bra.s      samfreq_find4
samfreq_find7:
		lea.l      samfreq_bestfreq(pc),a4
		move.w     samfreq_freqidx-samfreq_bestfreq(a4),d6
		lea.l      samfreq_table(pc),a0
		asl.w      #2,d6
		move.w     0(a0,d6.w),d0
		rts

samfreq_bestfreq: dc.w 0
samfreq_freqidx: dc.w 0

samfreq_table:
		dc.w 50000,0
		dc.w 49170,1
		dc.w 33880,2
		dc.w 25000,0
		dc.w 24585,3
		dc.w 20770,4
		dc.w 16490,5
		dc.w 12500,0
		dc.w 12292,7
		dc.w 9834,9
		dc.w 8195,11
samfreq_tableend:

/*
 * Syntax:   dma samrecord
 */
lib17:
	dc.w	0			; no library calls
dma_samrecord:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     snd_cookie-entry(a4),d0
		btst       #2,d0
		beq        dma_samrecord1
		movem.l    a0-a2,-(a7)
		move.w     #4,-(a7)
		move.w     #0x88,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts
dma_samrecord1:
		lea        illfunc-entry(a4),a0
		jmp        (a0)

/*
 * Syntax:   MDE=dma sammode
 */
lib18:
	dc.w	0			; no library calls
dma_sammode:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		clr.l      d3
		tst.w      dma_bufferset-entry(a4)
		beq        dma_sammode4
		movea.l    dma_playstart_addr-entry(a4),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.s      dma_sammode1
		lea.l      sammode_stereo(pc),a1
		move.w     avr_stereo(a0),(a1)
		move.w     avr_bits(a0),2(a1)
		bsr        sammode_find
		lea.l      sammode_stereo(pc),a1
		move.w     (a1),d3
		bra.s      dma_sammode4
dma_sammode1:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.s      dma_sammode4
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.s      dma_sammode4
		clr.l      d0
		move.b     wave_channels+1(a0),d0
		rol.w      #8,d0
		move.b     wave_channels(a0),d0
		lea.l      sammode_stereo(pc),a1
		cmpi.w     #1,d0
		beq.s      dma_sammode2
		move.w     #-1,(a1)
		bra.s      dma_sammode3
dma_sammode2:
		move.w     #0,(a1)
dma_sammode3:
		clr.l      d0
		move.b     wave_bits+1(a0),d0
		rol.w      #8,d0
		move.b     wave_bits(a0),d0
		move.w     d0,2(a1)
		bsr        sammode_find
		lea.l      sammode_stereo(pc),a1
		move.w     (a1),d3
dma_sammode4:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

sammode_find:
		lea.l      sammode_stereo(pc),a1
		lea.l      sammode_table(pc),a2
		lea.l      sammode_tableend(pc),a3
		move.l     (a1),d0
sammode_find1:
		cmpa.l     a2,a3
		beq.s      sammode_find3
		cmp.l      (a2),d0
		beq.s      sammode_find2
		addq.l     #6,a2
		bra.s      sammode_find1
sammode_find2:
		move.w     4(a2),(a1)
		rts
sammode_find3:
		move.w     #MODE_STEREO8,(a1)
		rts
sammode_table:
	dc.w -1,8,MODE_STEREO8
	dc.w -1,16,MODE_STEREO16
	dc.w 0,8,MODE_MONO8
sammode_tableend: dc.w 0,0,0,0
sammode_stereo: dc.w 0,0

/*
 * Syntax:   dma playloop off
 */
lib19:
	dc.w	0			; no library calls
dma_playloop_off:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_playloop_off1
		move.w     #0,dma_playloop-entry(a4)
dma_playloop_off1:
		movem.l    (a7)+,d1-d7/a0-a5
		rts

/*
 * Syntax:   X=dma sampval
 */
lib20:
	dc.w	0			; no library calls
dma_sampval:
		movem.l    a0-a5,-(a7)
		clr.l      d3
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_sampval3
		pea.l      sampvalbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		move.l     sampvalbuf(pc),a0
		move.w     dma_mode-entry(a4),d5
		cmpi.w     #MODE_STEREO8,d5
		beq.s      dma_sampval1
		cmpi.w     #MODE_STEREO16,d5
		beq.s      dma_sampval2
dma_sampval1:
		move.b     (a0),d3
		bra.s      dma_sampval3
dma_sampval2:
		move.w     (a0),d3
dma_sampval3:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

sampvalbuf: ds.l 4

/*
 * Syntax:   dma playloop on
 */
lib21:
	dc.w	0			; no library calls
dma_playloop_on:
		movem.l    d1-d7/a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_playloop_on1
		move.w     #1,dma_playloop-entry(a4)
dma_playloop_on1:
		movem.l    (a7)+,d1-d7/a0-a5
		rts

/*
 * Syntax:   MDE=dma samconvert(S,D,M$)
 */
lib22:
	dc.w	0			; no library calls
dma_samconvert:
		moveq      #0,d6
		moveq      #0,d7
		moveq      #0,d1
		subq.w     #1,d0
		beq.s      dma_samconvert1
* fetch mode
		move.l     (a6)+,a1
		move.b     2(a1),d1
* fetch dst res
		move.l     (a6)+,d6
* fetch src res
		move.l     (a6)+,d7
dma_samconvert1:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		moveq.l    #-1,d3
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samconvert3
		movea.l    dma_playstart_addr-entry(a4),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.s      dma_samconvert2
		bsr        convert_avr
		bra.s      dma_samconvert3
dma_samconvert2:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.s      dma_samconvert3
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.s      dma_samconvert3
		bsr        convert_wave
dma_samconvert3:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

convert_avr:
		move.w     avr_stereo(a0),d1
		swap       d1
		move.w     avr_bits(a0),d1
		cmpi.l     #0xFFFF0010,d1
		beq.s      convert_avr1
		moveq.l     #-1,d3
		rts
convert_avr1:
		movea.l    dma_playdata_addr-entry(a4),a1
		movea.l    dma_playdata_addr-entry(a4),a2
		movea.l    dma_playend_addr-entry(a4),a3
convert_avr2:
		cmpa.l     a1,a3
		beq.s      convert_avr3
		move.b     (a1),d0
		move.b     d0,(a2)+
		addq.l     #2,a1
		bra.s      convert_avr2
convert_avr3:
		subq.l     #1,a2
		move.l     a2,dma_playend_addr-entry(a4)
		move.w     #-1,avr_stereo(a0)
		move.w     #8,avr_bits(a0)
		move.w     #MODE_STEREO8,dma_mode-entry(a4)
		movea.l    dma_playdata_addr-entry(a4),a0
		movea.l    dma_playend_addr-entry(a4),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     #0,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		moveq.l    #0,d3
		rts

convert_wave:
		movea.l    dma_playdata_addr-entry(a4),a1
		movea.l    dma_playdata_addr-entry(a4),a2
		movea.l    dma_playend_addr-entry(a4),a3
convert_wave1:
		cmpa.l     a1,a3
		beq.s      convert_wave2
		move.b     1(a1),d0
		eori.b     #0x80,d0
		move.b     d0,(a2)+
		addq.l     #2,a1
		bra.s      convert_wave1
convert_wave2:
		subq.l     #1,a2
		move.l     a2,dma_playend_addr-entry(a4)
		move.w     #0x0200,wave_channels(a0)
		move.w     #0x0800,wave_bits(a0)
		move.l     dma_playstart_addr-entry(a4),d2
		move.l     dma_playend_addr-entry(a4),d3
		sub.l      d2,d3
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_riffsize+2(a0)
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_riffsize(a0)
		move.l     dma_playdata_addr-entry(a4),d2
		move.l     dma_playend_addr-entry(a4),d3
		sub.l      d2,d3
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_datasize+2(a0)
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_datasize(a0)
		move.w     #MODE_STEREO8,dma_mode-entry(a4)
		movea.l    dma_playdata_addr-entry(a4),a0
		movea.l    dma_playend_addr-entry(a4),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     #0,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		moveq.l     #0,d3
		rts

/*
 * Syntax:   dma samplay
 */
lib23:
	dc.w	0			; no library calls
dma_samplay:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samplay3
		move.w     dma_playloop-entry(a4),d1
		beq.s      dma_samplay2
		move.w     #3,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		bra.s      dma_samplay3
dma_samplay2:
		move.w     #1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
dma_samplay3:
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax:   SZ=dma samsize
 */
lib24:
	dc.w	0			; no library calls
dma_samsize:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		clr.l      d3
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samsize1
		move.l     dma_playend_addr-entry(a4),d3
		sub.l      dma_playstart_addr-entry(a4),d3
dma_samsize1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   dma samthru
 */
lib25:
	dc.w	0			; no library calls
dma_samthru:
		movem.l    a0-a5,-(a7)
		move.w     #1,-(a7)
		move.w     #0,-(a7)
		move.w     #0,-(a7)
		move.w     #8,-(a7)
		move.w     #3,-(a7)
		move.w     #0x008B,-(a7) /* devconnect */
		trap       #14
		lea.l      12(a7),a7
		move.w     #PRE320,-(a7)
		move.w     #SETPRESCALE,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		move.w     #0,-(a7)
		move.w     #0x0084,-(a7) /* setmode */
		trap       #14
		addq.l     #4,a7
		move.l     #0,-(a7)
		move.w     #0x0085,-(a7) /* settracks */
		trap       #14
		addq.l     #6,a7
		move.w     #ADCIN,-(a7)
		move.w     #ADDERIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		move.w     #0,-(a7)
		move.w     #ADCINPUT,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		move.w     #1,-(a7)
		move.w     #1,-(a7)
		move.w     #0x0087,-(a7) /* setinterrupt */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a5
		rts

lib26:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   dma samstop
 */
lib27:
	dc.w	0			; no library calls
dma_samstop:
		movem.l    a0-a5,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		tst.w      dma_bufferset-entry(a4)
		beq.s      dma_samstop1
		move.w     #0,dma_playloop-entry(a4)
dma_samstop1:
		move.w     #0,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a5
		rts

lib28:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   adder in X
 */
lib29:
	dc.w	0			; no library calls
adder_in:
		move.l     (a6)+,d3
		andi.w     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #ADDERIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		rts

lib30:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   adc input X
 */
lib31:
	dc.w	0			; no library calls
adc_input:
		move.l     (a6)+,d3
		andi.l     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #ADCINPUT,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		rts

lib32:
	dc.w	0			; no library calls
	rts

lib33:
	dc.w	0			; no library calls
	rts

lib34:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   left gain GN
 */
lib35:
	dc.w	0			; no library calls
left_gain:
		move.l     (a6)+,d3
		andi.l     #15,d3
		movem.l    a0-a2,-(a7)
		lsl.w      #4,d3
		andi.w     #0x000000F0,d3
		move.w     d3,-(a7)
		move.w     #LTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		rts

lib36:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   right gain GN
 */
lib37:
	dc.w	0			; no library calls
right_gain:
		move.l     (a6)+,d3
		movem.l    a0-a2,-(a7)
		lsl.w      #4,d3
		andi.w     #0x000000F0,d3
		move.w     d3,-(a7)
		move.w     #RTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		rts

lib38:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   left volume VOL
 */
lib39:
	dc.w	0			; no library calls
left_volume:
		move.l     (a6)+,d3
		movem.l    a0-a2,-(a7)
		not.w      d3
		andi.w     #15,d3
		lsl.w      #4,d3
		move.w     d3,-(a7)
		move.w     #LTATTEN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		rts

lib40:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   right volume VOL
 */
lib41:
	dc.w	0			; no library calls
right_volume:
		move.l     (a6)+,d3
		movem.l    a0-a2,-(a7)
		not.w      d3
		andi.w     #15,d3
		lsl.w      #4,d3
		move.w     d3,-(a7)
		move.w     #RTATTEN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		rts

lib42:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   speaker off
 */
lib43:
	dc.w	0			; no library calls
speaker_off:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.w     mch_cookie-entry(a4),d0
		subq.w     #3,d0
		bne.s      speaker_off1
		movem.l    a0-a5,-(a7)
		move.w     #0x0040,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a5
		rts
speaker_off1:
		lea        illfalconfunc-entry(a4),a0
		jmp        (a0)

lib44:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   speaker on
 */
lib45:
	dc.w	0			; no library calls
speaker_on:
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.w     mch_cookie-entry(a4),d0
		subq.w     #3,d0
		bne.s      speaker_on1
		movem.l    a0-a5,-(a7)
		move.w     #0x00BF,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a5
		rts
speaker_on1:
		lea        illfalconfunc-entry(a4),a0
		jmp        (a0)

libex:
   dc.w 0
