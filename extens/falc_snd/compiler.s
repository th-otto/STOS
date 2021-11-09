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
/* l022:	.dc.b I,I,',',I,',',S,1,1,0     ; dma samconvert */
l022:	.dc.b I,1,1,0 /* BUG: should be like above */
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

params_offset: dc.l params-entry

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

mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0

        ds.b 192 /* unused */

paramsend:

        ds.b 16 /* unused */

init:
		bra init0

cold:
		lea.l      params(pc),a4
		lea.l      mch_cookie-params(a4),a0
		clr.l      (a0)+
		clr.l      (a0)+ /* vdo_cookie */
		move.l     #1,(a0)+ /* snd_cookie */
		lea.l      cookieid-params(a4),a1
		move.l     #0x5F4D4348,(a1) /* '_MCH' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.w      cold1 /* XXX */
		lea.l      cookievalue-params(a4),a1
		lea.l      mch_cookie-params(a4),a0
		move.l     (a1),(a0)
cold1:
		lea.l      cookieid-params(a4),a1
		move.l     #0x5F56444F,(a1) /* '_VDO' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.w      cold2 /* XXX */
		lea.l      cookievalue-params(a4),a1
		lea.l      vdo_cookie-params(a4),a0
		move.l     (a1),(a0)
cold2:
		lea.l      cookieid-params(a4),a1
		move.l     #0x5F534E44,(a1) /* '_SND' */
		pea.l      getcookie(pc)
		move.w     #38,-(a7) /* Supexec */
		trap       #14
		addq.l     #6,a7
		tst.l      d0
		beq.w      cold3 /* XXX */
		lea.l      cookievalue-params(a4),a1
		lea.l      snd_cookie-params(a4),a0
		move.l     (a1),(a0)
cold3:
init0:
		lea        exit(pc),a2
		rts

getcookie:
		/* movea.l    #0x000005A0.l,a0 */
		dc.w 0x207c,0,0x5a0 /* XXX */
		lea.l      cookievalue-params(a4),a5
		clr.l      (a5)
		lea.l      cookieid-params(a4),a1
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

exit:
	rts

/*
 * Syntax:   dma reset
 */
lib1:
	dc.w	0			; no library calls
dma_reset:
		/* BUG: cookie check removed */
		movem.l    d0-d7/a0-a6,-(a7)
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
		movem.l    (a7)+,d0-d7/a0-a6
		/* BUG? LTATTEN/RTATTEN not set here */

		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		move.w     #(paramsend-params)/4-1,d7
dma_reset1:
		clr.l      (a4)+
		dbf        d7,dma_reset1
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   X=locksound
 */
lib2:
	dc.w	0			; no library calls
locksound:
		/* BUG: cookie check removed */
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #0x0080,-(a7) /* locksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   dma buffer REG,BEG_BUFF,EN_BUFF
 */
lib3:
	dc.w	0			; no library calls
dma_buffer:
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		lea.l      dma_buffer_args(pc),a1
		clr.l      10(a1)
		move.l     d3,(a1)
		move.l     (a6)+,d3
		lea.l      dma_buffer_args+4(pc),a1
		move.l     d3,(a1)
		move.l     (a6)+,d3
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
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		lea.l      dma_buffer_args(pc),a1
		move.l     (a1),d0
		move.l     d0,dma_recend_addr-params(a4)
		move.l     4(a1),d0
		move.l     d0,dma_recstart_addr-params(a4)
		move.w     #-1,dma_bufferset-params(a4)
		lea.l      dma_buffer_args(pc),a1
		move.l     (a1),-(a7)
		move.l     4(a1),-(a7)
		move.w     8(a1),-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		movem.l    (a7)+,a0-a6
		rts
dma_buffer3:
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		lea.l      dma_buffer_args(pc),a1
		move.l     (a1),d0
		move.l     d0,dma_playend_addr-params(a4)
		move.l     4(a1),d0
		move.l     d0,dma_playstart_addr-params(a4)
		move.l     10(a1),d1
		add.l      d1,d0
		move.l     d0,dma_playdata_addr-params(a4)
		move.w     #-1,dma_bufferset-params(a4)
		move.w     dma_buffer_args+8(pc),d1
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		move.w     d1,-(a7)
		move.w     #0x0083,-(a7) /* setbuffer */
		trap       #14
		lea.l      12(a7),a7
		movem.l    (a7)+,a0-a6
		rts

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
		/* BUG: cookie check removed */
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #0x0081,-(a7) /* unlocksnd */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   devconnect SOURCE,DEST,FREQ
 */
lib5:
	dc.w	0			; no library calls
devconnect:
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		andi.l     #0x0000FFFF,d3
		lea.l      devconnect_freq(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		andi.l     #15,d3
		lea.l      devconnect_dest(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
		andi.l     #3,d3
		lea.l      devconnect_source(pc),a1
		move.w     d3,(a1)
		lea.l      devconnect_freq(pc),a1
		move.w     (a1),d3
		andi.l     #0x0000FFFF,d3
		cmpi.w     #50000,d3
		/* bgt        illfreq BUG: check removed */
		cmpi.w     #8195,d3
		/* blt        illfreq BUG: check removed */
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
lib6:
	dc.w	0			; no library calls
dma_status:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.w     #0,-(a7)
		move.w     #0x008C,-(a7) /* sndstatus */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   dma samsign
 */
lib7:
	dc.w	0			; no library calls
dma_samsign:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		bne.w      dma_samsign1 /* XXX */
		movem.l    (a7)+,a0-a6
		rts
dma_samsign1:
		movea.l    dma_playstart_addr-params(a4),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_samsign6 /* XXX */
		cmpi.w     #16,avr_bits(a0)
		beq.w      dma_samsign3 /* XXX */
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
dma_samsign2:
		cmpa.l     a0,a1
		beq.w      dma_samsign5 /* XXX */
		eori.b     #0x80,(a0)+
		bra.w      dma_samsign2 /* XXX */
dma_samsign3:
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
dma_samsign4:
		cmpa.l     a0,a1
		beq.w      dma_samsign5 /* XXX */
		move.w     (a0),d0
		eori.w     #0x8000,d0
		move.w     d0,(a0)+
		bra.w      dma_samsign4 /* XXX */
dma_samsign5:
		movem.l    (a7)+,a0-a6
		rts
dma_samsign6:
		cmpi.l     #WAVE_MAGIC,wave_magic(a0)
		bne.w      dma_samsign7 /* XXX */
		cmpi.l     #WAVE_FMT,wave_ckid(a0)
		bne.w      dma_samsign7 /* XXX */
		bra.w      dma_samsign8 /* XXX */
dma_samsign7:
		movem.l    (a7)+,a0-a6
		rts
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
		rts
dma_samsign10:
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
dma_samsign11:
		cmpa.l     a0,a1
		beq.w      dma_samsign12 /* XXX */
		eori.b     #0x80,(a0)+
		bra.w      dma_samsign11 /* XXX */
dma_samsign12:
		movem.l    (a7)+,a0-a6
		rts
dma_samsign13:
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
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
		rts

/*
 * Syntax:   POS=dma samrecptr
 */
lib8:
	dc.w	0			; no library calls
dma_samrecptr:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samrecptr1 /* XXX */
		movem.l    d0-d7/a0-a6,-(a7)
		pea.l      buffptrbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     dma_recstart_addr-params(a4),d0
		lea.l      buffptrbuf(pc),a0
		move.l     4(a0),d3
		sub.l      d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
dma_samrecptr1:
		movem.l    (a7)+,a0-a6
		clr.l      d3
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		/* BUG: valid check removed */
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		move.w     d3,dma_mode-params(a4)
		move.w     d3,-(a7)
		move.w     #0x0084,-(a7) /* setmode */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   POS=dma samplayptr
 */
lib10:
	dc.w	0			; no library calls
dma_samplayptr:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samplayptr1 /* XXX */
		movem.l    d0-d7/a0-a6,-(a7)
		pea.l      buffptrbuf2(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,d0-d7/a0-a6
		move.l     dma_playdata_addr-params(a4),d0
		lea.l      buffptrbuf2(pc),a0
		move.l     (a0),d3
		sub.l      d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
dma_samplayptr1:
		movem.l    (a7)+,a0-a6
		clr.l      d3
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		andi.l     #3,d3
		lea.l      rectrk(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
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
		rts
rectrk: dc.w 0
playtrk: dc.w 0

/*
 * Syntax:   X=dma samstatus
 */
lib12:
	dc.w	0			; no library calls
dma_samstatus:
		/* BUG: cookie check removed */
		movem.l    d1-d7/a0-a6,-(a7)
		move.w     #-1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,d1-d7/a0-a6
		move.l     d0,d3
		andi.l     #0x0000FFFF,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   dma montrack TRACK
 */
lib13:
	dc.w	0			; no library calls
dma_montrack:
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #0x0086,-(a7) /* setmontracks */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   SND_TYPE=dma samtype
 */
lib14:
	dc.w	0			; no library calls
dma_samtype:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		clr.l      d7
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samtype1 /* XXX */
		lea.l      samtype_start(pc),a1
		move.l     dma_playstart_addr-params(a4),d3
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
		move.l     d3,-(a6)
		rts

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
lib15:
	dc.w	0			; no library calls
dma_interrupt:
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		andi.l     #3,d3
		lea.l      interrupt_cause(pc),a1
		move.w     d3,(a1)
		move.l     (a6)+,d3
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
		rts
interrupt_cause: dc.w 0
interrupt_mode: dc.w 0

/*
 * Syntax:   FREQ=dma samfreq
 */
lib16:
	dc.w	0			; no library calls
dma_samfreq:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samfreq2 /* XXX */
		movea.l    dma_playstart_addr-params(a4),a0
		cmpi.l     #AVR_MAGIC,avr_magic(a0)
		bne.w      dma_samfreq1 /* XXX */
		lea.l      samfreq_search(pc),a1
		move.w     avr_samprate+2(a0),(a1)
		bsr        samfreq_find
		move.l     d0,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
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
		move.l     d3,-(a6)
		rts
dma_samfreq2:
		movem.l    (a7)+,a0-a6
		move.l     #12292,d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

samfreq_find:
		lea.l      samfreq_table(pc),a0
		lea.l      samfreq_tableend(pc),a1
		lea.l      samfreq_search(pc),a2
		lea.l      samfreq_bestfreq(pc),a4
		move.w     #8192,(a4)
		move.w     #0,samfreq_freqidx-samfreq_bestfreq(a4)
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
		lea.l      samfreq_bestfreq(pc),a4
		cmp.w      (a4),d0
		bge.w      samfreq_find6 /* XXX */
		move.w     d0,(a4)
		move.w     d6,samfreq_freqidx-samfreq_bestfreq(a4)
samfreq_find6:
		/* addq.l     #4,a0 */
		dc.w 0xd1fc,0,4 /* XXX */
		addq.w     #1,d6
		bra.w      samfreq_find4 /* XXX */
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
		dc.w 0,0
samfreq_search: dc.w 0,0,0,0

/*
 * Syntax:   dma samrecord
 */
lib17:
	dc.w	0			; no library calls
dma_samrecord:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.w     #4,-(a7)
		move.w     #0x88,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   MDE=dma sammode
 */
lib18:
	dc.w	0			; no library calls
dma_sammode:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq        dma_sammode4
		movea.l    dma_playstart_addr-params(a4),a0
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
		move.l     d3,-(a6)
		rts
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
		move.l     d3,-(a6)
		rts
dma_sammode4:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

sammode_find:
		lea.l      sammode_stereo(pc),a1
		lea.l      sammode_table,a2 /* BUG: absolute address */
		lea.l      sammode_tableend,a3 /* BUG: absolute address */
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
lib19:
	dc.w	0			; no library calls
dma_playloop_off:
		/* BUG: cookie check removed */
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_playloop_off1 /* XXX */
		move.w     #0,dma_playloop-params(a4)
dma_playloop_off1:
		movem.l    (a7)+,d1-d7/a0-a6
		rts

/*
 * Syntax:   X=dma sampval
 */
lib20:
	dc.w	0			; no library calls
dma_sampval:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		clr.l      d3
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_sampval3 /* XXX */
		movem.l    a4-a6,-(a7) /* XXX fixme: useless */
		pea.l      sampvalbuf(pc)
		move.w     #0x008D,-(a7) /* buffptr */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a4-a6 /* XXX fixme: useless */
		lea.l      sampvalbuf(pc),a0
		movea.l    (a0),a0
		move.w     dma_mode-params(a4),d5
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
		nop /* XXX */
dma_sampval3:
		movem.l    (a7)+,a0-a6
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
		/* BUG: cookie check removed */
		movem.l    d1-d7/a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_playloop_on1 /* XXX */
		move.w     #1,dma_playloop-params(a4)
dma_playloop_on1:
		movem.l    (a7)+,d1-d7/a0-a6
		rts

/*
 * Syntax:   MDE=dma samconvert(S,D,M$)
 */
lib22:
	dc.w	0			; no library calls
dma_samconvert:
		/* BUG: cookie check removed */
		/* BUG: only version without arguments supported */
		nop
dma_samconvert1:
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samconvert4 /* XXX */
		movea.l    dma_playstart_addr-params(a4),a0
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
		move.l     d3,-(a6)
		rts
dma_samconvert4:
		movem.l    (a7)+,a0-a6
		/* moveq.l     #-1,d3 */
		dc.w 0x263c,-1,-1 /* XXX */
		clr.l      d2
		move.l     d3,-(a6)
		rts

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
		movea.l    dma_playdata_addr-params(a4),a1
		movea.l    dma_playdata_addr-params(a4),a2
		movea.l    dma_playend_addr-params(a4),a3
convert_avr2:
		cmpa.l     a1,a3
		beq.w      convert_avr3 /* XXX */
		move.b     (a1),d0
		move.b     d0,(a2)+
		addq.l     #2,a1
		bra.w      convert_avr2 /* XXX */
convert_avr3:
		subq.l     #1,a2
		move.l     a2,dma_playend_addr-params(a4)
		move.w     #-1,avr_stereo(a0)
		move.w     #8,avr_bits(a0)
		move.w     #MODE_STEREO8,dma_mode-params(a4)
		move.w     #-1,dma_bufferset-params(a4)
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
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
		movea.l    dma_playdata_addr-params(a4),a1
		movea.l    dma_playdata_addr-params(a4),a2
		movea.l    dma_playend_addr-params(a4),a3
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
		move.l     a2,dma_playend_addr-params(a4)
		move.w     #0x0200,wave_channels(a0)
		move.w     #0x0800,wave_bits(a0)
		move.l     dma_playstart_addr-params(a4),d2
		move.l     dma_playend_addr-params(a4),d3
		sub.l      d2,d3
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_riffsize+2(a0)
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_riffsize(a0)
		move.l     dma_playdata_addr-params(a4),d2
		move.l     dma_playend_addr-params(a4),d3
		sub.l      d2,d3
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_datasize+2(a0)
		swap       d3
		ror.w      #8,d3
		move.w     d3,wave_datasize(a0)
		move.w     #MODE_STEREO8,dma_mode-params(a4)
		move.w     #-1,dma_bufferset-params(a4)
		movea.l    dma_playdata_addr-params(a4),a0
		movea.l    dma_playend_addr-params(a4),a1
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
lib23:
	dc.w	0			; no library calls
dma_samplay:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samplay1 /* XXX */
		move.w     dma_playloop-params(a4),d1
		/* tst.w      d1 */
		dc.w 0x0c41,0 /* XXX */
		beq.w      dma_samplay2 /* XXX */
		move.w     #3,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
dma_samplay1:
		movem.l    (a7)+,a0-a6
		rts
dma_samplay2:
		move.w     #1,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   SZ=dma samsize
 */
lib24:
	dc.w	0			; no library calls
dma_samsize:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samsize1 /* XXX */
		move.l     dma_playstart_addr-params(a4),d2
		move.l     dma_playend_addr-params(a4),d3
		sub.l      d2,d3
		movem.l    (a7)+,a0-a6
		clr.l      d2
		move.l     d3,-(a6)
		rts
dma_samsize1:
		movem.l    (a7)+,a0-a6
		clr.l      d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

/*
 * Syntax:   dma samthru
 */
lib25:
	dc.w	0			; no library calls
dma_samthru:
		/* BUG: cookie check removed */
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
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.l     debut(a5),a4
		movea.l    0(a4,d1.w),a4
		move.l     params_offset-entry(a4),d0
		adda.l     d0,a4
		tst.w      dma_bufferset-params(a4)
		beq.w      dma_samstop1 /* XXX */
		move.w     #0,dma_playloop-params(a4)
dma_samstop1:
		move.w     #0,-(a7)
		move.w     #0x0088,-(a7) /* buffoper */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #ADDERIN,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
		andi.l     #3,d3
		movem.l    a0-a6,-(a7)
		move.w     d3,-(a7)
		move.w     #ADCINPUT,-(a7)
		move.w     #0x0082,-(a7) /* soundcmd */
		trap       #14
		addq.l     #6,a7
		movem.l    (a7)+,a0-a6
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
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
		/* BUG: cookie check removed */
		move.l     (a6)+,d3
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
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.w     #0x0040,-(a7)
		move.w     #30,-(a7) /* Ongibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

lib44:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   speaker on
 */
lib45:
	dc.w	0			; no library calls
speaker_on:
		/* BUG: cookie check removed */
		movem.l    a0-a6,-(a7)
		move.w     #0x00BF,-(a7)
		move.w     #29,-(a7) /* Offgibit */
		trap       #14
		addq.l     #4,a7
		movem.l    (a7)+,a0-a6
		rts

libex:
   dc.w 0
