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
returnpc: dc.l 0
   dc.w 0
   dc.w 0
   dc.w 0
mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0

load:
		lea.l      finprg,a0
		lea.l      cold,a1
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
		beq.w      cold1 /* XXX */
		lea.l      cookievalue(pc),a1
		lea.l      mch_cookie(pc),a0
		move.l     (a1),(a0)
cold1:
		lea.l      cookieid(pc),a1
		move.l     #0x5F56444F,(a1) /* '_VDO' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.w      cold2 /* XXX */
		lea.l      cookievalue(pc),a1
		lea.l      vdo_cookie(pc),a0
		move.l     (a1),(a0)
cold2:
		lea.l      cookieid(pc),a1
		move.l     #0x5F534E44,(a1) /* '_SND' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.w      cold3 /* XXX */
		lea.l      cookievalue(pc),a1
		lea.l      snd_cookie(pc),a0
		move.l     (a1),(a0)
cold3:
		lea.l      params(pc),a4
		move.w     #(paramsend-params)/4-1,d7
cold4:
		clr.l      (a4)+
		dbf        d7,cold4
		lea.l      welcome,a0
		lea.l      warm,a1
		lea.l      tokens,a2
		lea.l      jumps,a3
		rts

warm:
		movem.l    d0-d7/a0-a6,-(a7)
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq.w      warm1 /* XXX */
		lea.l      params(pc),a4
		tst.w      dma_initialized-params(a4)
		bne.w      warm1 /* XXX */
		bsr        init_dmasound
		lea.l      params(pc),a4
		move.w     #-1,dma_initialized-params(a4)
warm1:
		movem.l    (a7)+,d0-d7/a0-a6
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
		beq.w      getcookie3 /* XXX */
		movea.l    d0,a0
		clr.l      d4
getcookie1:
		move.l     (a0)+,d0
		move.l     (a0)+,d1
		/* tst.l      d0 */
		dc.w 0xb0bc,0,0 /* XXX */
		beq.w      getcookie3 /* XXX */
		cmp.l      d3,d0
		beq.w      getcookie2 /* XXX */
		addq.w     #1,d4
		bra.w      getcookie1 /* XXX */
getcookie2:
		/* cmpa.l     #0,a5 */
		dc.w 0xbbfc,0,0 /* XXX */
		beq.w      getcookie3 /* XXX */
		move.l     d1,(a5)
getcookie3:
		rts

init_dmasound:
		movem.l    a0-a6,-(a7)
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
		.IFNE 0 /* XXX */
		move.w     #1,-(a7)
		move.w     #0x008C,-(a7) /* sndstatus */
		trap       #14
		addq.l     #4,a7
		.ENDC
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
		movem.l    (a7)+,a0-a6
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

malloc: /* FIXME: unused */
		movea.l    table(pc),a0
		movea.l    sys_demand(a0),a0
		jsr        (a0)
		rts

addrofbank: /* FIXME: unused */
		movem.l    a0-a2,-(a7)
		movea.l    table,a0
		movea.l    sys_addrofbank(a0),a0
		jsr        (a0)
		movem.l    (a7)+,a0-a2
		rts

dummy:
		move.l     (a7)+,returnpc
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
		bra.w      printerr /* XXX */
notsupported:
		moveq.l    #1,d0
		bra.w      printerr /* XXX */
illresolution:
		moveq.l    #2,d0
		bra.w      printerr /* XXX */
illfreq:
		moveq.l    #3,d0

printerr:
		lea.l      errormsgs(pc),a2
		lsl.w      #1,d0
printerr2:
		/* tst.b     (a2)+ */
		dc.w 0x0c1a,0
		bne.w      printerr2 /* XXX */
		subq.w     #1,d0
		bpl.w      printerr2 /* XXX */
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
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		bsr        init_dmasound
		lea.l      params(pc),a4
		move.w     #(paramsend-params)/4-1,d7
dma_reset1:
		clr.l      (a4)+
		dbf        d7,dma_reset1
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   X=locksound
 */
locksound:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #0x0080,-(a7) /* locksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   dma buffer REG,BEG_BUFF,EN_BUFF
 */
dma_buffer:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		lea.l      dma_buffer_args(pc),a1
		clr.l      10(a1)
		move.l     d3,(a1)
		bsr        getinteger
		lea.l      dma_buffer_args+4(pc),a1
		move.l     d3,(a1)
		bsr        getinteger
		andi.l     #1,d3
		lea.l      dma_buffer_args+8(pc),a1
		move.w     d3,(a1)
		tst.w      d3
		bne.w      dma_buffer2 /* XXX */
		lea.l      dma_buffer_args+4(pc),a1
		movea.l    (a1),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_buffer1 /* XXX */
		move.l     #avr_headersize,6(a1)
		bra.w      dma_buffer3 /* XXX */
dma_buffer1:
		lea.l      dma_buffer_args+4(pc),a1
		movea.l    (a1),a0
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.w      dma_buffer3 /* XXX */
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.w      dma_buffer3 /* XXX */
		move.l     #wave_headersize,6(a1) /* BUG: should use cksize from header */
		bra.w      dma_buffer3 /* XXX */
dma_buffer2:
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		lea.l      dma_buffer_args(pc),a1
		move.l     (a1),d0
		move.l     d0,dma_recend_addr-params(a5)
		move.l     4(a1),d0
		move.l     d0,dma_recstart_addr-params(a5)
		move.w     #-1,dma_bufferset-params(a5)
		lea.l      dma_buffer_args(pc),a1
		move.l     (a1),-(a7)
		move.l     4(a1),-(a7)
		move.w     8(a1),-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_buffer3:
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		lea.l      dma_buffer_args(pc),a1
		move.l     (a1),d0
		move.l     d0,dma_playend_addr-params(a5)
		move.l     4(a1),d0
		move.l     d0,dma_playstart_addr-params(a5)
		move.l     10(a1),d1
		add.l      d1,d0
		move.l     d0,dma_playdata_addr-params(a5)
		move.w     #-1,dma_bufferset-params(a5)
		move.w     dma_buffer_args+8(pc),d1
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     d1,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

dma_buffer_args:
	ds.l 1 /* end addr */
	ds.l 1 /* start addr */
	ds.w 1 /* buffer type playback/record */
	ds.l 1 /* data offset */

/*
 * Syntax:   X=unlocksound
 */
unlocksound:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #0x0081,-(a7) /* unlocksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   devconnect SOURCE,DEST,FREQ
 */
devconnect:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #3,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3
		lea.l      devconnect_freq(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		andi.l     #15,d3
		lea.l      devconnect_dest(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		andi.l     #3,d3
		lea.l      devconnect_source(pc),a1
		move.w     d3,(a1)
		lea.l      devconnect_freq(pc),a1
		move.w     (a1),d3
		andi.l     #0x0000FFFF,d3
		cmpi.l     #50000,d3
		bgt        illfreq
		cmpi.l     #8195,d3
		blt        illfreq
		movem.l    a0-a6,-(a7)
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
		bne.w      devconnect1 /* XXX */
		bsr.w      set_prescale
devconnect1:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
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
		beq.w      find_freq_3 /* XXX */
		cmp.w      (a0),d0
		beq.w      find_freq_2 /* XXX */
		/* addq.l     #6,a0 */
		dc.w 0xd1fc,0,6 /* XXX */
		bra.w      find_freq_1 /* XXX */
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
		beq.w      find_freq_7 /* XXX */
		move.w     (a2),d0
		andi.l     #0x0000FFFF,d0
		move.w     (a0),d1
		andi.l     #0x0000FFFF,d1
		sub.w      d1,d0
		bpl.w      find_freq_5 /* XXX */
		neg.w      d0
find_freq_5:
		lea.l      devconnect_bestfreq(pc),a5
		cmp.w      (a5),d0
		bge.w      find_freq_6 /* XXX */
		move.w     d0,(a5)
		move.w     d6,devconnect_freqidx-devconnect_bestfreq(a5)
find_freq_6:
		/* addq.l     #6,a0 */
		dc.w 0xd1fc,0,6 /* XXX */
		addq.w     #1,d6
		bra.w      find_freq_4 /* XXX */
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
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0,-(a7)
		move.w     #0x008C,-(a7) /* sndstatus */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   dma samsign
 */
dma_samsign:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		bne.w      dma_samsign1 /* XXX */
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_samsign1:
		movea.l    dma_playstart_addr-params(a5),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_samsign6 /* XXX */
		cmpi.w     #16,avr_bits(a0)
		beq.w      dma_samsign3 /* XXX */
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
dma_samsign2:
		cmpa.l     a0,a1
		beq.w      dma_samsign5 /* XXX */
		eori.b     #0x80,(a0)+
		bra.w      dma_samsign2 /* XXX */
dma_samsign3:
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
dma_samsign4:
		cmpa.l     a0,a1
		beq.w      dma_samsign5 /* XXX */
		move.w     (a0),d0
		eori.w     #0x8000,d0
		move.w     d0,(a0)+
		bra.w      dma_samsign4 /* XXX */
dma_samsign5:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_samsign6:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.w      dma_samsign7 /* XXX */
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.w      dma_samsign7 /* XXX */
		bra.w      dma_samsign8 /* XXX */
dma_samsign7:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_samsign8:
		cmpi.w     #0x100,wave_channels(a0)
		beq.w      dma_samsign9 /* XXX */
		cmpi.w     #0x200,wave_channels(a0)
dma_samsign9:
		cmpi.w     #0x0800,wave_bits(a0)
		beq.w      dma_samsign10 /* XXX */
		cmpi.w     #0x1000,wave_bits(a0)
		beq.w      dma_samsign13 /* XXX */
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_samsign10:
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
dma_samsign11:
		cmpa.l     a0,a1
		beq.w      dma_samsign12 /* XXX */
		eori.b     #0x80,(a0)+
		bra.w      dma_samsign11 /* XXX */
dma_samsign12:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_samsign13:
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
dma_samsign14:
		cmpa.l     a0,a1
		beq.w      dma_samsign15 /* XXX */
		move.w     (a0),d0
		rol.w      #8,d0
		eori.w     #0x8000,d0
		move.w     d0,(a0)+
		bra.w      dma_samsign14 /* XXX */
dma_samsign15:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   POS=dma samrecptr
 */
dma_samrecptr:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		pea.l      buffptrbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		lea.l      params(pc),a5
		/* BUG: no check for dma_bufferset */
		move.l     dma_recstart_addr-params(a5),d0
		lea.l      buffptrbuf(pc),a0
		move.l     4(a0),d3
		sub.l      d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
buffptrbuf: ds.l 4

/*
 * Syntax:   dma setmode MDE
 */
dma_setmode:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		tst.w      d3
		bmi        illresolution
		cmpi.l     #3,d3
		bge        illresolution
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		move.w     d3,dma_mode-params(a5)
		move.w     d3,-(a7)
		move.w     #0x0084,-(a7) /* setmode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   POS=dma samplayptr
 */
dma_samplayptr:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		/* BUG: no check for dma_bufferset */
		pea.l      buffptrbuf2(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		lea.l      params(pc),a5
		move.l     dma_playdata_addr-params(a5),d0
		lea.l      buffptrbuf2(pc),a0
		move.l     (a0),d3
		sub.l      d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
buffptrbuf2: ds.l 4

/*
 * Syntax:   dma samtracks PLAYTRK,RECTRK
 */
dma_samtracks:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		andi.l     #3,d3
		lea.l      rectrk(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		andi.l     #3,d3
		lea.l      playtrk(pc),a1
		move.w     d3,(a1)
		movem.l    a0-a6,-(a7)
		lea.l      rectrk(pc),a1
		move.l     (a1),-(a7)
		move.w     #0x0085,-(a7) /* settracks */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
rectrk: dc.w 0
playtrk: dc.w 0

/*
 * Syntax:   X=dma samstatus
 */
dma_samstatus:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   dma montrack TRACK
 */
dma_montrack:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0086,-(a7) /* setmontracks */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   SND_TYPE=dma samtype
 */
dma_samtype:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		clr.l      d7
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_samtype1 /* XXX */
		lea.l      samtype_start(pc),a1
		move.l     dma_playstart_addr-params(a5),d3
		move.l     d3,(a1)
		addi.l     #128,d3
		move.l     d3,samtype_end-samtype_start(a1)
		bsr        find_avr
		tst.l      d7
		bpl.w      dma_samtype1 /* XXX */
		bsr        find_wave
		tst.l      d7
		bpl.w      dma_samtype1 /* XXX */
		clr.l      d7
dma_samtype1:
		movem.l    (a7)+,a0-a6
		move.l     d7,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

find_avr:
		movea.l    samtype_start(pc),a0
		movea.l    samtype_end(pc),a1
find_avr1:
		cmpa.l     a0,a1
		beq.w      find_avr2 /* XXX */
		cmpi.b     #'2',(a0)+
		bne.w      find_avr1 /* XXX */
		cmpi.b     #'B',(a0)
		bne.w      find_avr1 /* XXX */
		cmpi.b     #'I',1(a0)
		bne.w      find_avr1 /* XXX */
		cmpi.b     #'T',2(a0)
		bne.w      find_avr1 /* XXX */
		/* subq.l     #1,a0 */
		dc.w 0x91fc,0,1 /* XXX */
		/* moveq.l     #1,d7 */
		dc.w 0x2e3c,0,1 /* XXX */
		rts
find_avr2:
		/* moveq.l     #-1,d7 */
		dc.w 0x2e3c,-1,-1 /* XXX */
		rts

find_wave:
		movea.l    samtype_start(pc),a0
		movea.l    samtype_end(pc),a1
find_wave1:
		cmpa.l     a0,a1
		beq.w      find_wave2 /* XXX */
		cmpi.b     #'W',(a0)+
		bne.w      find_wave1 /* XXX */
		cmpi.b     #'A',(a0)
		bne.w      find_wave1 /* XXX */
		cmpi.b     #'V',1(a0)
		bne.w      find_wave1 /* XXX */
		cmpi.b     #'E',2(a0)
		bne.w      find_wave1 /* XXX */
		cmpi.b     #'f',3(a0)
		bne.w      find_wave1 /* XXX */
		cmpi.b     #'m',4(a0)
		bne.w      find_wave1 /* XXX */
		cmpi.b     #'t',5(a0)
		bne.w      find_wave1 /* XXX */
		/* subq.l     #1,a0 */
		dc.w 0x91fc,0,1 /* XXX */
		/* moveq.l     #2,d7 */
		dc.w 0x2e3c,0,2 /* XXX */
		rts
find_wave2:
		/* moveq.l     #-1,d7 */
		dc.w 0x2e3c,-1,-1 /* XXX */
		rts
samtype_start: dc.l 0
samtype_end: dc.l 0

/*
 * Syntax:   dma interrupt MODE,CAUSE
 */
dma_interrupt:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #2,d0
		bne        syntax
		bsr        getinteger
		andi.l     #3,d3
		lea.l      interrupt_cause(pc),a1
		move.w     d3,(a1)
		bsr        getinteger
		andi.l     #1,d3
		lea.l      interrupt_mode(pc),a1
		move.w     d3,(a1)
		movem.l    a0-a6,-(a7)
		lea.l      interrupt_cause(pc),a1
		move.w     (a1),-(a7)
		move.w     2(a1),-(a7)
		move.w     #0x0087,-(a7) /* setinterrupt */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
interrupt_cause: dc.w 0
interrupt_mode: dc.w 0

/*
 * Syntax:   FREQ=dma samfreq
 */
dma_samfreq:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_samfreq2 /* XXX */
		movea.l    dma_playstart_addr-params(a5),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_samfreq1 /* XXX */
		lea.l      samfreq_search(pc),a1
		move.w     avr_samprate+2(a0),(a1)
		bsr        samfreq_find
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
dma_samfreq1:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.w      dma_samfreq2 /* XXX */
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.w      dma_samfreq2 /* XXX */
		move.b     wave_samprate+1(a0),d0
		rol.w      #8,d0
		move.b     wave_samprate(a0),d0
		lea.l      samfreq_search(pc),a1
		move.w     d0,(a1)
		bsr        samfreq_find
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
dma_samfreq2:
		movem.l    (a7)+,a0-a6
		move.l     #12292,d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

samfreq_find:
		lea.l      samfreq_table(pc),a0
		lea.l      samfreq_tableend(pc),a1
		lea.l      samfreq_search(pc),a2
		lea.l      samfreq_bestfreq(pc),a5
		move.w     #8192,(a5)
		move.w     #0,samfreq_freqidx-samfreq_bestfreq(a5)
		move.w     (a2),d0
		andi.l     #0x0000FFFF,d0
samfreq_find1:
		cmpa.l     a0,a1
		beq.w      samfreq_find3 /* XXX */
		cmp.w      (a0),d0
		beq.w      samfreq_find2 /* XXX */
		/* addq.l     #4,a0 */
		dc.w 0xd1fc,0,4 /* XXX */
		bra.w      samfreq_find1
samfreq_find2:
		move.w     (a0),d0
		rts
samfreq_find3:
		lea.l      samfreq_table(pc),a0
		lea.l      samfreq_tableend(pc),a1
		lea.l      samfreq_search(pc),a2
		clr.l      d6
samfreq_find4:
		cmpa.l     a0,a1
		beq.w      samfreq_find7 /* XXX */
		move.w     (a2),d0
		andi.l     #0x0000FFFF,d0
		move.w     (a0),d1
		andi.l     #0x0000FFFF,d1
		sub.w      d1,d0
		bpl.w      samfreq_find5 /* XXX */
		neg.w      d0
samfreq_find5:
		lea.l      samfreq_bestfreq(pc),a5
		cmp.w      (a5),d0
		bge.w      samfreq_find6 /* XXX */
		move.w     d0,(a5)
		move.w     d6,samfreq_freqidx-samfreq_bestfreq(a5)
samfreq_find6:
		/* addq.l     #4,a0 */
		dc.w 0xd1fc,0,4 /* XXX */
		addq.w     #1,d6
		bra.w      samfreq_find4 /* XXX */
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
		dc.w 0,0
samfreq_search: dc.w 0,0,0,0

/*
 * Syntax:   dma samrecord
 */
dma_samrecord:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #4,-(a7)
		move.w     #0x88,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   MDE=dma sammode
 */
dma_sammode:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq        dma_sammode4
		movea.l    dma_playstart_addr-params(a5),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_sammode1 /* XXX */
		lea.l      sammode_stereo(pc),a1
		move.w     avr_stereo(a0),(a1)
		move.w     avr_bits(a0),2(a1)
		bsr        sammode_find
		lea.l      sammode_stereo(pc),a1
		move.w     (a1),d3
		andi.l     #0x0000FFFF,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
dma_sammode1:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.w      dma_sammode4 /* XXX */
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.w      dma_sammode4 /* XXX */
		clr.l      d0
		move.b     wave_channels+1(a0),d0
		rol.w      #8,d0
		move.b     wave_channels(a0),d0
		lea.l      sammode_stereo(pc),a1
		cmpi.w     #1,d0
		beq.w      dma_sammode2 /* XXX */
		move.w     #-1,(a1)
		bra.w      dma_sammode3 /* XXX */
dma_sammode2:
		move.w     #0,(a1)
dma_sammode3:
		clr.l      d0
		move.b     wave_bits+1(a0),d0
		rol.w      #8,d0
		move.b     wave_bits(a0),d0
		move.w     d0,2(a1)
		bsr        sammode_find /* XXX */
		lea.l      sammode_stereo(pc),a1
		move.w     (a1),d3
		andi.l     #0x0000FFFF,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
dma_sammode4:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

sammode_find:
		lea.l      sammode_stereo(pc),a1
		lea.l      sammode_table,a2 /* XXX pc */
		lea.l      sammode_tableend,a3 /* XXX pc */
		move.l     (a1),d0
sammode_find1:
		cmpa.l     a2,a3
		beq.w      sammode_find3 /* XXX */
		cmp.l      (a2),d0
		beq.w      sammode_find2 /* XXX */
		/* addq.l     #6,a2 */
		dc.w 0xd5fc,0,6 /* XXX */
		bra.w      sammode_find1 /* XXX */
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
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_playloop_off1 /* XXX */
		move.w     #0,dma_playloop-params(a5)
dma_playloop_off1:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   X=dma sampval
 */
dma_sampval:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		/* BUG: no check for dma_bufferset */
		movem.l    a0-a6,-(a7)
		pea.l      sampvalbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		lea.l      sampvalbuf(pc),a0
		movea.l    (a0),a0
		lea.l      params(pc),a5
		move.w     dma_mode-params(a5),d5
		/* cmpi.w     #MODE_STEREO8,d5 */
		dc.w 0x0c45,0
		beq.w      dma_sampval1 /* XXX */
		cmpi.w     #MODE_STEREO16,d5
		beq.w      dma_sampval2 /* XXX */
		move.b     (a0),d3
		andi.l     #255,d3
		bra.w      dma_sampval3 /* XXX */
dma_sampval1:
		move.b     (a0),d3
		andi.l     #255,d3
		bra.w      dma_sampval3 /* XXX */
dma_sampval2:
		move.w     (a0),d3
		andi.l     #0x0000FFFF,d3
		bra.w      dma_sampval3 /* XXX */
dma_sampval3:
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

sampvalbuf: ds.l 4

/*
 * Syntax:   dma playloop on
 */
dma_playloop_on:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_playloop_on1 /* XXX */
		move.w     #-1,dma_playloop-params(a5)
dma_playloop_on1:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   MDE=dma samconvert(S,D,M$)
 */
dma_samconvert:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		beq.w      dma_samconvert1 /* XXX */
		cmp.w      #3,d0
		bne        syntax
		bsr        getstring
		lea.l      convert_mode(pc),a0
		addq.l     #2,d3
		movea.l    d3,a1
		move.b     (a1),(a0)
		bsr        getinteger
		andi.l     #31,d3
		lea.l      convert_srcres(pc),a0
		move.w     d3,(a0)
		bsr        getinteger
		andi.l     #31,d3
		lea.l      comvert_dstres(pc),a0
		move.w     d3,(a0)
dma_samconvert1:
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_samconvert4 /* XXX */
		movea.l    dma_playstart_addr-params(a5),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_samconvert2 /* XXX */
		bsr        convert_avr
		bra.w      dma_samconvert3 /* XXX */
dma_samconvert2:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.w      dma_samconvert4 /* XXX */
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.w      dma_samconvert4 /* XXX */
		bsr        convert_wave
dma_samconvert3:
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
dma_samconvert4:
		movem.l    (a7)+,a0-a6
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

convert_avr:
		move.w     avr_stereo(a0),d1
		swap       d1
		move.w     avr_bits(a0),d1
		cmpi.l     #0xFFFF0010,d1
		beq.w      convert_avr1 /* XXX */
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
		rts
convert_avr1:
		movea.l    dma_playdata_addr-params(a5),a1
		movea.l    dma_playdata_addr-params(a5),a2
		movea.l    dma_playend_addr-params(a5),a3
convert_avr2:
		cmpa.l     a1,a3
		beq.w      convert_avr3 /* XXX */
		move.b     (a1),d0
		move.b     d0,(a2)+
		addq.l     #2,a1
		bra.w      convert_avr2 /* XXX */
convert_avr3:
		subq.l     #1,a2
		move.l     a2,dma_playend_addr-params(a5)
		move.w     #-1,avr_stereo(a0)
		move.w     #8,avr_bits(a0)
		move.w     #MODE_STEREO8,dma_mode-params(a5)
		move.w     #-1,dma_bufferset-params(a5)
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     #0,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		/* moveq.l     #0,d3 */
		dc.w 0x263c,0,0 /* XXX */
		rts

convert_wave:
		nop
		movea.l    dma_playdata_addr-params(a5),a1
		movea.l    dma_playdata_addr-params(a5),a2
		movea.l    dma_playend_addr-params(a5),a3
convert_wave1:
		cmpa.l     a1,a3
		beq.w      convert_wave2 /* XXX */
		move.b     1(a1),d0
		eori.b     #0x80,d0
		move.b     d0,(a2)+
		addq.l     #2,a1
		bra.w      convert_wave1 /* XXX */
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
		move.w     #-1,dma_bufferset-params(a5)
		movea.l    dma_playdata_addr-params(a5),a0
		movea.l    dma_playend_addr-params(a5),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     #0,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		/* moveq.l     #0,d3 */
		dc.w 0x263c,0,0 /* XXX */
		rts

convert_mode: dc.b 0,0
comvert_dstres: dc.w 0
convert_srcres: dc.w 0

/*
 * Syntax:   dma samplay
 */
dma_samplay:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_samplay1 /* XXX */
		move.w     dma_playloop-params(a5),d1
		/* tst.w      d1 */
		dc.w 0x0c41,0 /* XXX */
		beq.w      dma_samplay2 /* XXX */
		move.w     #3,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
dma_samplay1:
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)
dma_samplay2:
		move.w     #1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   SZ=dma samsize
 */
dma_samsize:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_samsize1 /* XXX */
		move.l     dma_playstart_addr-params(a5),d2
		move.l     dma_playend_addr-params(a5),d3
		sub.l      d2,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)
dma_samsize1:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   dma samthru
 */
dma_samthru:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
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
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   dma samstop
 */
dma_samstop:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		lea.l      params(pc),a5
		tst.w      dma_bufferset-params(a5)
		beq.w      dma_samstop1 /* XXX */
		move.w     #0,dma_playloop-params(a5)
dma_samstop1:
		move.w     #0,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   adder in X
 */
adder_in:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #ADDERIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   adc input X
 */
adc_input:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #ADCINPUT,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   left gain GN
 */
left_gain:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #15,d3
		movem.l    a0-a6,-(a7)
		rol.w      #4,d3
		andi.l     #0x000000F0,d3
		move.w     d3,-(a7)
		move.w     #LTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   right gain GN
 */
right_gain:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3
		movem.l    a0-a6,-(a7)
		rol.w      #4,d3
		andi.l     #0x000000F0,d3
		move.w     d3,-(a7)
		move.w     #RTGAIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   left volume VOL
 */
left_volume:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3
		movem.l    a0-a6,-(a7)
		not.w      d3
		andi.l     #15,d3
		rol.w      #4,d3
		move.w     d3,-(a7)
		move.w     #LTATTEN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   right volume VOL
 */
right_volume:
		move.l     (a7)+,returnpc
		move.l     snd_cookie(pc),d6
		btst       #2,d6
		beq        notsupported
		cmp.w      #1,d0
		bne        syntax
		bsr        getinteger
		andi.l     #0x0000FFFF,d3
		movem.l    a0-a6,-(a7)
		not.w      d3
		andi.l     #15,d3
		rol.w      #4,d3
		move.w     d3,-(a7)
		move.w     #RTATTEN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   speaker off
 */
speaker_off:
		move.l     (a7)+,returnpc
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0x0040,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

/*
 * Syntax:   speaker on
 */
speaker_on:
		move.l     (a7)+,returnpc
		move.w     mch_cookie(pc),d6
		cmpi.w     #3,d6
		bne        illfalconfunc
		tst.w      d0
		bne        syntax
		movem.l    a0-a6,-(a7)
		move.w     #0x00BF,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		movea.l    returnpc,a0
		jmp        (a0)

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
