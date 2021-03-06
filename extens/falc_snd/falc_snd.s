	.include "system.inc"
	.include "errors.inc"
	.include "wave.inc"

	.text

; Adaptation au Stos basic
        bra.w load
        even
        dc.b $80
tokens:
		dc.b "dma reset",$80
		dc.b "locksound",$81
		dc.b "dma buffer",$82
		dc.b "unlocksound",$83
		dc.b "devconnect",$84
		dc.b "dma status",$85
		dc.b "dma samsign",$86
		dc.b "dma samrecptr",$87
		dc.b "dma setmode",$88
		dc.b "dma samplayptr",$89
		dc.b "dma samtracks",$8a
		dc.b "dma samstatus",$8b
		dc.b "dma montrack",$8c
		dc.b "dma samtype",$8d
		dc.b "dma interrupt",$8e
		dc.b "dma samfreq",$8f
		dc.b "dma samrecord",$90
		dc.b "dma sammode",$91
		dc.b "dma playloop off",$92
		dc.b "dma sampval",$93
		dc.b "dma playloop on",$94
		dc.b "dma samconvert",$95
		dc.b "dma samplay",$96
		dc.b "dma samsize",$97
		dc.b "dma samthru",$98
		/* $99 unused */
		dc.b "dma samstop",$9a
		/* $9b unused */
		dc.b "adder in",$9c
		/* $9d unused */
		dc.b "adc input",$9e
		/* $9f unused */
		/* $a0 unused */
		/* $a1 unused */
		dc.b "left gain",$a2
		/* $a3 unused */
		dc.b "right gain",$a4
		/* $a5 unused */
		dc.b "left volume",$a6
		/* $a7 unused */
		dc.b "right volume",$a8
		/* $a9 unused */
		dc.b "speaker off",$aa
		/* $ab unused */
		dc.b "speaker on",$ac
        dc.b 0
        even
		
jumps:  dc.w 45
		dc.l dma_reset
		dc.l locksound
		dc.l dma_buffer
		dc.l unlocksound
		dc.l devconnect
		dc.l dma_status
		dc.l dma_samsign
		dc.l dma_samrecptr
		dc.l dma_setmode
		dc.l dma_samplayptr
		dc.l dma_samtracks
		dc.l dma_samstatus
		dc.l dma_montrack
		dc.l dma_samtype
		dc.l dma_interrupt
		dc.l dma_samfreq
		dc.l dma_samrecord
		dc.l dma_sammode
		dc.l dma_playloop_off
		dc.l dma_sampval
		dc.l dma_playloop_on
		dc.l dma_samconvert
		dc.l dma_samplay
		dc.l dma_samsize
		dc.l dma_samthru
		dc.l dummy
		dc.l dma_samstop
		dc.l dummy
		dc.l adder_in
		dc.l dummy
		dc.l adc_input
		dc.l dummy
		dc.l dummy
		dc.l dummy
		dc.l left_gain
		dc.l dummy
		dc.l right_gain
		dc.l dummy
		dc.l left_volume
		dc.l dummy
		dc.l right_volume
		dc.l dummy
		dc.l speaker_off
		dc.l dummy
		dc.l speaker_on

welcome:
		dc.b 10
		dc.b "Falcon 030 DMA SOUND Extension V2.2 ",$bd," A.Hoskin.",0
		dc.b 10
		dc.b "Extension de Falcon 030 DMA SOUND V2.2 ",$bd," A.Hoskin.",0
		.even

table: dc.l 0
mch_cookie: dc.l 0
snd_cookie: dc.l 0

load:
		lea.l      finprg(pc),a0
		lea.l      cold(pc),a1
		rts

cold:
		move.l     a0,table
		move.l     #0x5F4D4348,d3 /* '_MCH' */
		bsr        getcookie
		lea.l      mch_cookie(pc),a0
		move.l     d0,(a0)
		move.l     #0x5F534E44,d3 /* '_SND' */
		bsr        getcookie
		lea.l      snd_cookie(pc),a0
		move.l     d0,(a0)
		lea.l      params(pc),a4
		move.w     #(paramsend-params)/2-1,d7
cold4:
		clr.w      (a4)+
		dbf        d7,cold4
		lea.l      welcome(pc),a0
		lea.l      warm(pc),a1
		lea.l      tokens(pc),a2
		lea.l      jumps(pc),a3
		rts

warm:
		movem.l    d0-d7/a0-a5,-(a7)
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq.s      warm1
		lea.l      params(pc),a4
		tst.w      dma_initialized-params(a4)
		bne.s      warm1
		bsr        init_dmasound
		lea.l      params(pc),a4
		move.w     #-1,dma_initialized-params(a4)
warm1:
		movem.l    (a7)+,d0-d7/a0-a5
		rts

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

init_dmasound:
		movem.l    a0-a2,-(a7)
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
		movem.l    (a7)+,a0-a2
		/* BUG? LTATTEN/RTATTEN not set here */
		rts

getinteger:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bne.w      typemismatch
		jmp        (a0)

getstring:
		movea.l    (a7)+,a0
		movem.l    (a7)+,d2-d4
		tst.b      d2
		bpl.w      illfunc
		jmp        (a0)

dummy:
		bra.w      syntax
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
badfilename: /* FIXME: unused */
		moveq.l    #E_badfilename,d0
		bra.s      goerror
diskerror: /* FIXME: unused */
		moveq.l    #E_diskerror,d0

goerror:
		movea.l    table(pc),a0
		movea.l    sys_error(a0),a0
		jmp        (a0)

illfalconfunc:
		moveq.l    #0,d0
		bra.s      printerr
notsupported:
		moveq.l    #1,d0
		bra.s      printerr
illresolution:
		moveq.l    #2,d0
		bra.s      printerr
illfreq:
		moveq.l    #3,d0

printerr:
		lea.l      errormsgs(pc),a2
		lsl.w      #1,d0
printerr2:
		tst.b     (a2)+
		bne.s      printerr2
		subq.w     #1,d0
		bpl.s      printerr2
		movea.l    table(pc),a1
		movea.l    sys_err2(a1),a1
		jmp        (a1)

errormsgs:
	.dc.b 0
	.dc.b "Illegal Command/Function (use only on Falcon 030)",0
	.dc.b "Illegal Command/Function (use only on Falcon 030)",0
	.dc.b "Command/Function not supported by sound hardware",0
	.dc.b "Command/Function not supported by sound hardware",0
	.dc.b "Illegal DMA sound playback resolution",0
	.dc.b "Illegal DMA sound playback resolution",0
	.dc.b "Devconnect() frequency out of range 8.195kHz to 50kHz",0
	.dc.b "Devconnect() frequency out of range 8.195kHz to 50kHz",0
	.even

/*
 * Syntax:   dma reset
 */
dma_reset:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        init_dmasound
		lea.l      params(pc),a4
		move.w     #(paramsend-params)/2-1,d7
dma_reset1:
		clr.w      (a4)+
		dbf        d7,dma_reset1
		rts

/*
 * Syntax:   X=locksound
 */
locksound:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    d1-d7/a0-a5,-(a7)
		move.w     #0x0080,-(a7) /* locksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d7/a0-a5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   dma buffer REG,BEG_BUFF,EN_BUFF
 */
dma_buffer:
		move.l     (a7)+,d1
		subq.w     #3,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		move.l     d3,a3
		bsr        getinteger
		move.l     d3,a2
		bsr        getinteger
		move.l     d1,-(a7)
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
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
		move.l     a3,dma_recend_addr-params(a5)
		move.l     a2,dma_recstart_addr-params(a5)
		bra.s      dma_buffer4
dma_buffer3:
		move.l     a3,dma_playend_addr-params(a5)
		move.l     a2,dma_playstart_addr-params(a5)
		add.l      d2,a2
		move.l     a2,dma_playdata_addr-params(a5)
dma_buffer4:
		move.w     #-1,dma_bufferset-params(a5)
		move.l     a3,-(a7)
		move.l     a2,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		movem.l    (a7)+,a0-a5
		rts

dma_buffer_args:
	ds.l 1 /* end addr */
	ds.l 1 /* start addr */
	ds.w 1 /* buffer type playback/record */
	ds.l 1 /* data offset */

/*
 * Syntax:   X=unlocksound
 */
unlocksound:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    d1-d7/a0-a5,-(a7)
		move.w     #0x0081,-(a7) /* unlocksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d7/a0-a5
		move.l     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   devconnect SOURCE,DEST,FREQ
 */
devconnect:
		move.l     (a7)+,d1
		subq.w     #3,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		lea.l      devconnect_freq(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		andi.w     #15,d3
		lea.l      devconnect_dest(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		andi.w     #3,d3
		lea.l      devconnect_source(pc),a1
		move.w     d3,(a1)
		move.l     d1,-(a7)
		lea.l      devconnect_freq(pc),a1
		move.w     (a1),d3
		cmpi.w     #50000,d3
		bgt        illfreq
		cmpi.l     #8195,d3
		blt        illfreq
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
dma_status:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a1-a2,-(a7)
		move.w     #0,-(a7)
		move.w     #0x008C,-(a7) /* sndstatus */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a1-a2
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		rts

/*
 * Syntax:   dma samsign
 */
dma_samsign:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq        dma_samsign15
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
		movea.l    dma_playstart_addr-params(a5),a2
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
dma_samrecptr:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		pea.l      buffptrbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		lea.l      params(pc),a5
		clr.l      d3
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samrecptr1
		move.l     dma_recstart_addr-params(a5),d0
		move.l     buffptrbuf+4(pc),d3
		sub.l      d0,d3
dma_samrecptr1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		rts
buffptrbuf: ds.l 4

/*
 * Syntax:   dma setmode MDE
 */
dma_setmode:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		cmpi.w     #3,d3
		bcc        illresolution
		movem.l    a0-a2,-(a7)
		lea.l      params(pc),a5
		move.w     d3,dma_mode-params(a5)
		move.w     d3,-(a7)
		move.w     #0x0084,-(a7) /* setmode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   POS=dma samplayptr
 */
dma_samplayptr:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		clr.l      d3
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samplayptr1
		pea.l      buffptrbuf2(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		lea.l      params(pc),a5
		move.l     dma_playdata_addr-params(a5),d0
		move.l     buffptrbuf2(pc),d3
		sub.l      d0,d3
dma_samplayptr1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		rts
buffptrbuf2: ds.l 4

/*
 * Syntax:   dma samtracks PLAYTRK,RECTRK
 */
dma_samtracks:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		move.l     d3,d0
		andi.w     #3,d0
		bsr        getinteger
		andi.w     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d0,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0085,-(a7) /* settracks */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   X=dma samstatus
 */
dma_samstatus:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a2,-(a7)
		move.w     #-1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		moveq      #0,d3
		move.w     d0,d3
		clr.l      d2
		rts

/*
 * Syntax:   dma montrack TRACK
 */
dma_montrack:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		andi.w     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0086,-(a7) /* setmontracks */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   SND_TYPE=dma samtype
 */
dma_samtype:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		clr.l      d3
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samtype1
		lea.l      samtype_start(pc),a1
		move.l     dma_playstart_addr-params(a5),d3
		move.l     d3,(a1)
		addi.l     #128,d3
		move.l     d3,samtype_end-samtype_start(a1)
		bsr        find_avr
		tst.l      d7
		bpl.s      dma_samtype1
		bsr        find_wave
		tst.l      d7
		bpl.s      dma_samtype1
		clr.l      d7
dma_samtype1:
		movem.l    (a7)+,a0-a5
		move.l     d7,d3
		clr.l      d2
		rts

find_avr:
		movea.l    samtype_start(pc),a0
		movea.l    samtype_end(pc),a1
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
		moveq.l     #1,d7
		rts
find_avr2:
		moveq.l     #-1,d7
		rts

find_wave:
		movea.l    samtype_start(pc),a0
		movea.l    samtype_end(pc),a1
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
		moveq.l     #2,d7
		rts
find_wave2:
		moveq.l     #-1,d7
		rts
samtype_start: dc.l 0
samtype_end: dc.l 0

/*
 * Syntax:   dma interrupt MODE,CAUSE
 */
dma_interrupt:
		move.l     (a7)+,a1
		subq.w     #2,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		move.w     d3,d0
		andi.w     #3,d0
		bsr        getinteger
		andi.w     #1,d3
		movem.l    a0-a5,-(a7)
		move.w     d0,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0087,-(a7) /* setinterrupt */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a5
		jmp        (a1)

/*
 * Syntax:   FREQ=dma samfreq
 */
dma_samfreq:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samfreq2
		movea.l    dma_playstart_addr-params(a5),a0
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
		rts

samfreq_find:
		lea.l      samfreq_table(pc),a0
		lea.l      samfreq_tableend(pc),a1
		lea.l      samfreq_bestfreq(pc),a5
		move.w     #8192,(a5)
		move.w     #0,samfreq_freqidx-samfreq_bestfreq(a5)
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
		lea.l      samfreq_bestfreq(pc),a5
		cmp.w      (a5),d2
		bge.s      samfreq_find6
		move.w     d2,(a5)
		move.w     d6,samfreq_freqidx-samfreq_bestfreq(a5)
samfreq_find6:
		addq.l     #4,a0
		addq.w     #1,d6
		bra.s      samfreq_find4
samfreq_find7:
		lea.l      samfreq_bestfreq(pc),a5
		move.w     samfreq_freqidx-samfreq_bestfreq(a5),d6
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
dma_samrecord:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a2,-(a7)
		move.w     #4,-(a7)
		move.w     #0x88,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a2
		rts

/*
 * Syntax:   MDE=dma sammode
 */
dma_sammode:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		clr.l      d3
		tst.w      dma_bufferset-params(a5)
		beq        dma_sammode4
		movea.l    dma_playstart_addr-params(a5),a0
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
dma_playloop_off:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_playloop_off1
		move.w     #0,dma_playloop-params(a5)
dma_playloop_off1:
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax:   X=dma sampval
 */
dma_sampval:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		clr.l      d3
		tst.w      dma_bufferset-params(a5)
		beq        dma_sampval3
		pea.l      sampvalbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		move.l     sampvalbuf(pc),a0
		move.w     dma_mode-params(a5),d5
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
		rts

sampvalbuf: ds.l 4

/*
 * Syntax:   dma playloop on
 */
dma_playloop_on:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_playloop_on1
		move.w     #-1,dma_playloop-params(a5)
dma_playloop_on1:
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax:   MDE=dma samconvert(S,D,M$)
 */
dma_samconvert:
		move.l     (a7)+,a1
		move.l     snd_cookie(pc),d1
		btst       #2,d1
		beq        notsupported
		moveq      #0,d6
		moveq      #0,d7
		moveq      #0,d1
		tst.w      d0
		beq.s      dma_samconvert1
		subq.w     #3,d0
		bne        syntax
* fetch mode
		bsr        getstring
		addq.l     #2,d3
		movea.l    d3,a0
		move.b     (a0),d1
* fetch dst res
		bsr        getinteger
		move.l     d3,d6
* fetch src res
		bsr        getinteger
		move.l     d3,d7
dma_samconvert1:
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		moveq.l    #-1,d3
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samconvert3
		movea.l    dma_playstart_addr-params(a5),a0
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
		jmp        (a1)

convert_avr:
		move.w     avr_stereo(a0),d1
		swap       d1
		move.w     avr_bits(a0),d1
		cmpi.l     #0xFFFF0010,d1
		beq.s      convert_avr1
		moveq.l     #-1,d3
		rts
convert_avr1:
		movea.l    dma_playdata_addr-params(a5),a1
		movea.l    dma_playdata_addr-params(a5),a2
		movea.l    dma_playend_addr-params(a5),a3
convert_avr2:
		cmpa.l     a1,a3
		beq.s      convert_avr3
		move.b     (a1),d0
		move.b     d0,(a2)+
		addq.l     #2,a1
		bra.s      convert_avr2
convert_avr3:
		subq.l     #1,a2
		move.l     a2,dma_playend_addr-params(a5)
		move.w     #-1,avr_stereo(a0)
		move.w     #8,avr_bits(a0)
		move.w     #MODE_STEREO8,dma_mode-params(a5)
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     #0,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		moveq.l     #0,d3
		rts

convert_wave:
		nop
		movea.l    dma_playdata_addr-params(a5),a1
		movea.l    dma_playdata_addr-params(a5),a2
		movea.l    dma_playend_addr-params(a5),a3
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
		move.l     a2,dma_playend_addr-params(a5)
		move.w     #0x0200,wave_channels(a0)
		move.w     #0x0800,wave_bits(a0)
		move.l     dma_playstart_addr-params(a5),d2
		move.l     dma_playend_addr-params(a5),d3
		sub.l      d2,d3
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_riffsize+2(a0)
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_riffsize(a0)
		move.l     dma_playdata_addr-params(a5),d2
		move.l     dma_playend_addr-params(a5),d3
		sub.l      d2,d3
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_datasize+2(a0)
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_datasize(a0)
		move.w     #MODE_STEREO8,dma_mode-params(a5)
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
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
dma_samplay:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samplay3
		move.w     dma_playloop-params(a5),d1
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
dma_samsize:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		clr.l      d3
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samsize1
		move.l     dma_playend_addr-params(a5),d3
		sub.l      dma_playstart_addr-params(a5),d3
dma_samsize1:
		movem.l    (a7)+,a0-a5
		clr.l      d2
		rts

/*
 * Syntax:   dma samthru
 */
dma_samthru:
		move.l     (a7)+,a1
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
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
		jmp        (a1)

/*
 * Syntax:   dma samstop
 */
dma_samstop:
		tst.w      d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		movem.l    a0-a5,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.s      dma_samstop1
		move.w     #0,dma_playloop-params(a5)
dma_samstop1:
		move.w     #0,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a5
		rts

/*
 * Syntax:   adder in X
 */
adder_in:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		andi.w     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #ADDERIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   adc input X
 */
adc_input:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		andi.l     #3,d3
		movem.l    a0-a2,-(a7)
		move.w     d3,-(a7)
		move.w     #ADCINPUT,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   left gain GN
 */
left_gain:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		andi.w     #15,d3
		movem.l    a0-a2,-(a7)
		lsl.w      #4,d3
		andi.w     #0x000000F0,d3
		move.w     d3,-(a7)
		move.w     #LTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   right gain GN
 */
right_gain:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
		movem.l    a0-a2,-(a7)
		lsl.w      #4,d3
		andi.w     #0x000000F0,d3
		move.w     d3,-(a7)
		move.w     #RTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a2
		jmp        (a1)

/*
 * Syntax:   left volume VOL
 */
left_volume:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
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
		jmp        (a1)

/*
 * Syntax:   right volume VOL
 */
right_volume:
		move.l     (a7)+,a1
		subq.w     #1,d0
		bne        syntax
		move.l     snd_cookie(pc),d0
		btst       #2,d0
		beq        notsupported
		bsr        getinteger
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
		jmp        (a1)

/*
 * Syntax:   speaker off
 */
speaker_off:
		move.l     (a7)+,a1
		tst.w      d0
		bne        syntax
		move.w     mch_cookie(pc),d0
		subq.w     #3,d0
		bne        illfalconfunc
		movem.l    a1-a2,-(a7)
		move.w     #0x0040,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a1-a2
		jmp        (a1)

/*
 * Syntax:   speaker on
 */
speaker_on:
		move.l     (a7)+,a1
		tst.w      d0
		bne        syntax
		move.w     mch_cookie(pc),d0
		subq.w     #3,d0
		bne        illfalconfunc
		movem.l    a1-a2,-(a7)
		move.w     #0x00BF,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a1-a2
		jmp        (a1)

	.data
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

        ds.b 212 /* unused */

paramsend:

finprg:
