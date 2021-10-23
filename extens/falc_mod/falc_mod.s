	.include "system.inc"
	.include "music.inc"
	.include "tokens.inc"
	.include "errors.inc"
	.include "window.inc"
	.include "sprites.inc"

; BUG: checked for equality, which rules out
; other hardware.
FALCON_SND_COOKIE = 31

MAX_BANK_NUM = 15
MAX_STRINGLEN = 20
MAX_VOICES = 32

; tracker status bits
STATUS_PLAYING = 0
STATUS_REPEAT  = 1
STATUS_PAUSED  = 2
STATUS_RES3    = 3
STATUS_RES4    = 4
STATUS_END     = 6
STATUS_INIT    = 7

; soundcmd() values
LTATTEN     = 0
RTATTEN     = 1
LTGAIN      = 2
RTGAIN      = 3
ADDERIN     = 4
   ADCIN    = 1
   MATIN    = 2
ADCINPUT    = 5
   ADCRT = 1
   ADCLT = 2
SETPRESCALE = 6
   PREMUTE  = 0
   PRE640   = 1
   PRE320   = 2
   PRE160   = 3

PACK_ICE2     = 0x49434521 /* "ICE!" */
PACK_ATOMIC   = 0x41544D35 /* "ATM5" */

        .offset 0

Amiga_Name:         ds.b      22
Amiga_Length:       ds.w      1    * Taille cod‚e en words
Amiga_Fine_Tune:    ds.b      1    * de 0 … 15  =  0 … 7 et -8 … -1
Amiga_Volume:       ds.b      1    * de 0 … 64
Amiga_Repeat_Start: ds.w      1
Amiga_Repeat_Length:ds.w      1
Amiga_Size:                        * 30 octets


	.text

; Adaptation au Stos basic
        bra.w load
        even
        dc.b $80
tokens:
		dc.b "_tracker reset",$80
		dc.b "_tracker init",$81
		dc.b "_tracker play",$82
		dc.b "_tracker title$",$83
		dc.b "_tracker loop on",$84
		dc.b "_tracker format$",$85
		dc.b "_tracker loop off",$86
		dc.b "_tracker startaddress",$87
		dc.b "_tracker stop",$88
		dc.b "_tracker size",$89
		dc.b "_tracker pause",$8a
		dc.b "_tracker songlength",$8b
		dc.b "_tracker speed",$8c
		dc.b "_tracker instruments max",$8d
		dc.b "_tracker volume",$8e
		dc.b "_tracker status",$8f
		dc.b "_tracker copy",$90
		dc.b "_tracker songpos",$91
		/* $92 unused */
		dc.b "_tracker pattpos",$93
		dc.b "_tracker ffwd",$94
		dc.b "_tracker sample title$",$95
		dc.b "_tracker songprev",$96
		dc.b "_tracker voices",$97
		dc.b "_tracker songnext",$98
		dc.b "_tracker vu",$99
		/* $9a unused */
		dc.b "_tracker spectrum",$9b
		/* $9c unused */
		dc.b "_tracker maxsize",$9d
		/* $9e unused */
		dc.b "_tracker howmany",$9f
		/* $a0 unused */
		dc.b "_tracker packed",$a1
		dc.b "_tracker depack",$a2
		dc.b "_tracker filelength",$a3
		dc.b "_tracker load",$a4
		dc.b "_tracker instruments used",$a5
		dc.b "_tracker scope init",$a6
		dc.b "_tracker patt info$",$a7
		dc.b "_tracker scope draw",$a8
		dc.b "_tracker tempo",$a9
        dc.b 0
        even

jumps:
		dc.w 42
		dc.l tracker_reset
		dc.l tracker_init
		dc.l tracker_play
		dc.l tracker_title
		dc.l tracker_loop_on
		dc.l tracker_format
		dc.l tracker_loop_off
		dc.l tracker_startadress
		dc.l tracker_stop
		dc.l tracker_size
		dc.l tracker_pause
		dc.l tracker_songlength
		dc.l tracker_speed
		dc.l tracker_instruments_max
		dc.l tracker_volume
		dc.l tracker_status
		dc.l tracker_copy
		dc.l tracker_songpos
		dc.l dummy
		dc.l tracker_pattpos
		dc.l tracker_ffwd
		dc.l tracker_sample_title
		dc.l tracker_songprev
		dc.l tracker_voices
		dc.l tracker_songnext
		dc.l tracker_vu
		dc.l dummy
		dc.l tracker_spectrum
		dc.l dummy
		dc.l tracker_maxsize
		dc.l dummy
		dc.l tracker_howmany
		dc.l dummy
		dc.l tracker_packed
		dc.l tracker_depack
		dc.l tracker_filelength
		dc.l tracker_load
		dc.l tracker_instruments_used
		dc.l tracker_scope_init
		dc.l tracker_patt_info
		dc.l tracker_scope_draw
		dc.l tracker_tempo

welcome:
		dc.b 10
		dc.b 21,"Falcon 030 DSP Tracker Extension v2.87",$9e,32,$bd," A.Hoskin.",18,0
		dc.b 10
		dc.b 21,"Falcon 030 DSP Tracker Extension v2.87",$9e,32,$bd," A.Hoskin.",18,0

table: dc.l 0
returnpc: dc.l 0
        dc.w 0 /* unused */
        dc.w 0 /* unused */
        dc.w 0 /* unused */
mch_cookie: dc.l 0
vdo_cookie: dc.l 0
snd_cookie: dc.l 0
cookieid: dc.l 0
cookievalue: dc.l 0
warmflag: dc.w 0
mode:   dc.w 0
        dc.w 0 /* unused */
ltatten_value: dc.w 0
rtatten_value: dc.w 0
status_bits: dc.b 0
	.even

load:
	lea.l      finprg(pc),a0
	lea.l      cold(pc),a1
	rts

cold:
	move.l     a0,table
	move.w     #4,-(a7) /* Getrez */
	trap       #14
	addq.l     #2,a7
	andi.l     #3,d0 /* BUG: should not be masked */
	lea.l      mode(pc),a0
	move.w     d0,(a0)
	move.l     #0,warmflag /* BUG: word only; clobbers mode from above */
	move.l     #0,ltatten_value /* also clears rtatten_value */
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
	beq.s      cold1
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
	beq.s      cold2
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
	beq.s      cold3
	lea.l      cookievalue(pc),a1
	lea.l      snd_cookie(pc),a0
	move.l     (a1),(a0)
cold3:
	lea.l      welcome(pc),a0
	lea.l      warm(pc),a1
	lea.l      tokens(pc),a2
	lea.l      jumps(pc),a3
	bsr.s      check_musiclib
	tst.w      d7
	bmi.s      cold4
	beq.s      cold4
	bra        musiclib_err
cold4:
	rts

check_musiclib:
	movem.l    d0-d6/a0-a6,-(a7)
	movea.l    $0000009C.l,a1 /* XXX */
	suba.l     #musiclib_id_end-musiclib_id,a1
	lea.l      musiclib_id(pc),a0
	moveq.l    #musiclib_id_end-musiclib_id-1,d7
check_musiclib1:
	cmpm.b     (a0)+,(a1)+
	bne.s      check_musiclib2
	dbf        d7,check_musiclib1
check_musiclib2:
	movem.l    (a7)+,d0-d6/a0-a6
	rts

warm:
	movem.l    d0-d7/a0-a6,-(a7)
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	beq.s      warm3
	tst.w      warmflag
	bne.s      warm3
	move.w     #-1,warmflag
	btst       #STATUS_PLAYING,status_bits
	bne.s      warm1
	bra.s      warm2
warm1:
	movem.l    a0-a6,-(a7)
	moveq.l    #LTATTEN,d0
	move.w     #240,d1
	bsr        soundcmd
	moveq.l    #RTATTEN,d0
	move.w     #240,d1
	bsr        soundcmd
	moveq.l    #M_soundreset,d0
	trap       #7
	bsr.s      init_dmasound
	movem.l    (a7)+,a0-a6
	bclr       #STATUS_PLAYING,status_bits
	bclr       #STATUS_REPEAT,status_bits
warm2:
	moveq.l    #LTATTEN,d0
	move.w     ltatten_value(pc),d1
	bsr        soundcmd
	moveq.l    #RTATTEN,d0
	move.w     rtatten_value(pc),d1
	bsr        soundcmd
	lea.l      scope_active(pc),a0
	move.w     #0,(a0)
warm3:
	movem.l    (a7)+,d0-d7/a0-a6
	rts

init_dmasound:
* setplayback mode
	move.w     #0,-(a7)
	move.w     #0x0088,-(a7) /* buffoper */
	trap       #14
	addq.l     #4,a7
* unlock sound
	move.w     #0x0081,-(a7) /* unlocksnd */
	trap       #14
	addq.l     #2,a7
	move.w     #1,-(a7)
	move.w     #0x008C,-(a7) /* sndstatus */
	trap       #14
	addq.l     #4,a7
* src=DMA, dst=speaker, srcclk=intern, prescale=0, protocol=handshake
	move.w     #1,-(a7)
	move.w     #PREMUTE,-(a7)
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
* set left & right output attenuation
	lea.l      ltatten_value(pc),a0
	moveq.l    #LTATTEN,d0
	move.w     (a0)+,d1
	bsr.s      soundcmd
	moveq.l    #RTATTEN,d0
	move.w     (a0)+,d1
	bsr.s      soundcmd
	rts

soundcmd:
	move.l     a0,-(a7)
	move.w     d1,-(a7)
	move.w     d0,-(a7)
	move.w     #0x0082,-(a7) /* soundcmd */
	trap       #14
	addq.w     #6,a7
	movea.l    (a7)+,a0
	rts

* BUG: clobbers lots of registers it shouldn't
* FIXME: rewrite
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
	bra.s      getcookie1
getcookie2:
	/* cmpa.l     #0,a5 */
	dc.w 0xbbfc,0,0 /* XXX */
	beq.s      getcookie3
	move.l     d1,(a5)
getcookie3:
	rts


	include "ice2.s"
	include "atomik.s"

paktype:
	move.l     #950,d0
	moveq.l    #31,d7 /* max instruments */
	moveq.l    #4,d3
	lea.l      mk_id(pc),a4
* offset 1080 is ModFile Chunk
; Formats 4 voices
	cmpi.l     #0x4D2E4B2E,1080(a0)           ; "M.K."
	beq        Format_Ok
	cmpi.l     #0x4D214B21,1080(a0)           ; "M!K!"
	beq        Format_Ok
	cmpi.l     #0x4D264B26,1080(a0)           ; "M&K&"
	beq        Format_Ok
	lea.l      fa04_id(pc),a4
	cmpi.l     #0x46413034,1080(a0)           ; "FA04"
	beq        Format_Ok
	lea.l      flt4_id(pc),a4
	cmpi.l     #0x464C5434,1080(a0)           ; "FLT4"
	beq        Format_Ok
	lea.l      rasp_id(pc),a4
	cmpi.l     #0x52415350,1080(a0)           ; "RASP"
	beq        Format_Ok

; Formats 6 voices
	moveq.l    #6,d3
	lea.l      fa06_id(pc),a4
	cmpi.l     #0x46413036,1080(a0)           ; "FA06"
	beq.s      Format_Ok
	lea.l      chn6_id(pc),a4
	cmpi.l     #0x3643484E,1080(a0)           ; "6CHN"
	beq.s      Format_Ok
	lea.l      flt6_id(pc),a4
	cmpi.l     #0x464C5436,1080(a0)           ; "FLT6"
	beq.s      Format_Ok

; Formats 8 voices
	moveq.l    #8,d3
	lea.l      fa08_id(pc),a4
	cmpi.l     #0x46413038,1080(a0)           ; "FA08"
	beq.s      Format_Ok
	lea.l      chn8_id(pc),a4
	cmpi.l     #0x3843484E,1080(a0)           ; "8CHN"
	beq.s      Format_Ok
	lea.l      cd81_id(pc),a4
	cmpi.l     #0x43443831,1080(a0)           ; "CD81"
	beq.s      Format_Ok
	lea.l      flt8_id(pc),a4
	cmpi.l     #0x464C5438,1080(a0)           ; "FLT8"
	beq.s      Format_Ok
	lea.l      octa_id(pc),a4
	cmpi.l     #0x4F435441,1080(a0)           ; "OCTA"
	beq.s      Format_Ok
	move.l     #470,d0
	moveq.l    #4,d3
	moveq.l    #15,d7 /* max instruments */
	lea.l      generic4_id(pc),a4
Format_Ok:
	rts

getinteger:
	movea.l    (a7)+,a0
	movem.l    (a7)+,d2-d4
	tst.b      d2
	bne.s      typemismatch
	jmp        (a0)

getstring:
	movea.l    (a7)+,a0
	movem.l    (a7)+,d2-d4
	tst.b      d2
	bpl.s      illfunc
	jmp        (a0)

malloc:
	movea.l    table(pc),a0
	movea.l    sys_demand(a0),a0
	jsr        (a0)
	rts

addrofbank:
	movem.l    a0-a2,-(a7)
	movea.l    table(pc),a0
	movea.l    sys_addrofbank(a0),a0
	jsr        (a0)
	movem.l    (a7)+,a0-a2
	rts

reserve:
	movem.l    d0-d7/a1-a6,-(a7)
	movea.l    table(pc),a0
	movea.l    sys_extjumps(a0),a0
	movea.l    4*(T_exti_reserve-$70)(a0),a0 ; 228
	jsr        130(a0) /* calls reserve_entry in interpreter */
	movem.l    (a7)+,d0-d7/a1-a6
	rts

erase:
	movem.l    d0-d7/a1-a2,-(a7)
	movea.l    table(pc),a0
	movea.l    sys_extjumps(a0),a0
	movea.l    4*(T_exti_erase-$70)(a0),a0 ; 224
	jsr        20(a0) /* calls erase_entry in interpreter */
	movem.l    (a7)+,d0-d7/a1-a2
	rts

dummy:
	move.l     (a7)+,returnpc
	bra.s      syntax
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
enoent:
	moveq.l    #E_noent,d0
	bra.s      goerror
badfilename:
	moveq.l    #E_badfilename,d0
	bra.s      goerror
diskerror:
	moveq.l    #E_diskerror,d0
goerror:
	movem.l    d0-d7/a0-a6,-(a7)
	move.w     mode(pc),d0
	cmpi.w     #2,d0
	beq.s      goerror1
	move.w     d0,-(a7)
	move.l     #-1,-(a7)
	move.l     #-1,-(a7)
	move.w     #5,-(a7) /* Setscreen */
	trap       #14
	lea.l      12(a7),a7
	moveq.l    #S_initmode,d0
	trap       #5
	moveq.l    #W_initmode,d7
	trap       #3
goerror1:
	movem.l    (a7)+,d0-d7/a0-a6
	movea.l    table(pc),a0
	movea.l    sys_error(a0),a0
	jmp        (a0)

illfalconfunc:
	moveq.l    #0,d0
	bra.s      printerr
notsupported:
	moveq.l    #1,d0
	bra.s      printerr
banknotdefined:
	moveq.l    #2,d0
	bra.s      printerr
musiclib_err:
	moveq.l    #3,d0
	bra.s      printerr
	nop /* XXX */

printerr:
	movem.l    d0-d7/a0-a6,-(a7)
	tst.w      d0
	beq.s      printerr1
	move.w     mode(pc),d0
	cmpi.w     #2,d0
	beq.s      printerr1
	move.w     d0,-(a7)
	move.l     #-1,-(a7)
	move.l     #-1,-(a7)
	move.w     #5,-(a7) /* setscreen */
	trap       #14
	lea.l      12(a7),a7
	moveq.l    #S_initmode,d0
	trap       #5
	moveq.l    #W_initmode,d7
	trap       #3
printerr1:
	movem.l    (a7)+,d0-d7/a0-a6
	lea.l      errormsgs(pc),a2
	lsl.w      #1,d0
printerr2:
	/* tst.b     (a2)+ */
	dc.w 0x0c1a,0 /* XXX */
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
	.dc.b "Bank data is not a JoinedTrackerBank module.",0
	.dc.b "Bank data is not a JoinedTrackerBank module.",0
	.dc.b 13,10,21
	.dc.b " Extension ERROR - the 'MUSIC101.BIN' file version in the STOS folder is ",13,10
	.dc.b " incompatible with the Falcon 030 DSP Tracker Extension v2.85.           ",13,10
	.dc.b " Please re-boot your system with the version 2.85 'MUSIC101.BIN' file in ",13,10
	.dc.b " the STOS folder.                                                        ",18,13,10,0
	.dc.b 13,10,21
	.dc.b " Extension ERROR - the 'MUSIC101.BIN' file version in the STOS folder is ",13,10
	.dc.b " incompatible with the Falcon 030 DSP Tracker Extension v2.85.           ",13,10
	.dc.b " Please re-boot your system with the version 2.85 'MUSIC101.BIN' file in ",13,10
	.dc.b " the STOS folder.                                                        ",18,13,10,0
	.even

* Syntax    : _tracker reset
tracker_reset:
	move.l     (a7)+,returnpc
	move.w     #0,warmflag
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	moveq.l    #LTATTEN,d0
	move.w     #240,d1
	bsr        soundcmd
	moveq.l    #RTATTEN,d0
	move.w     #240,d1
	bsr        soundcmd
	lea.l      status_bits(pc),a0
	tst.b      (a0)
	beq.s      tracker_reset1
	moveq.l    #M_soundreset,d0
	trap       #7
	lea.l      status_bits(pc),a0
	move.b     #0,(a0)
	bsr        init_dmasound
tracker_reset1:
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : X=_tracker init(ADDR,SIZE)
tracker_init:
	move.l     (a7)+,returnpc
	move.w     #0,warmflag
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #2,d0
	bne        syntax
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	move.l     d3,tracker_init_size
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_init1
	bsr        addrofbank
tracker_init1:
	move.l     d3,tracker_init_addr
	movem.l    a0-a6,-(a7)
	movea.l    tracker_init_addr(pc),a3
	moveq.l    #0,d0
	move.l     (a3),d4
	move.l     4(a3),d5
	cmpi.l     #0x442E542E,d4 /* "D.T." */
	beq.s      tracker_init3
	cmpi.l     #0x4D475411,d4
	beq.s      tracker_init3
	cmpi.l     #PACK_ATOMIC,d4
	beq.s      tracker_init3
	cmpi.l     #PACK_ICE2,d4
	beq.s      tracker_init3
	cmpi.l     #0x414E2043,d4 /* "AN C" */
	bne.s      tracker_init2
	cmpi.l     #0x4F4F4C2E,d5 /* "OOL." */
	beq.s      tracker_init3
tracker_init2:
	moveq.l    #-1,d0
tracker_init3:
	tst.l      d0
	beq.w      tracker_init5 /* XXX */
	moveq.l    #LTATTEN,d0
	move.w     #-1,d1
	bsr        soundcmd
	lea.l      ltatten_value(pc),a0
	move.w     d0,(a0)
	moveq.l    #RTATTEN,d0
	move.w     #-1,d1
	bsr        soundcmd
	lea.l      ltatten_value(pc),a0
	move.w     d0,rtatten_value-ltatten_value(a0)
	bsr        soundcmd
	moveq.l    #LTATTEN,d0
	move.w     #240,d1
	bsr        soundcmd
	moveq.l    #RTATTEN,d0
	move.w     #240,d1
	bsr        soundcmd
	move.l     tracker_init_addr(pc),d1
	move.l     tracker_init_size(pc),d2
	moveq.l    #M_trackerinit,d0
	trap       #7
	lea.l      status_bits(pc),a2
	move.b     #0,(a2)
	move.l     d0,d3
	tst.l      d0
	beq.s      tracker_init4
	bset       #STATUS_INIT,(a2)
tracker_init4:
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_init5:
	lea.l      status_bits(pc),a2
	move.b     #0,(a2)
	movem.l    (a7)+,a0-a6
	moveq.l    #0,d3
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_init_addr: dc.l 0
tracker_init_size: dc.l 0

* Syntax    : _tracker play
tracker_play:
	move.l     (a7)+,returnpc
	move.w     #0,warmflag
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	lea.l      status_bits(pc),a2
	btst       #STATUS_PAUSED,(a2)
	beq.s      tracker_play1
	moveq.l    #M_trackerpause,d0
	trap       #7
	bra.s      tracker_play2
tracker_play1:
	moveq.l    #M_trackerplay,d0
	trap       #7
tracker_play2:
	lea.l      status_bits(pc),a2
	bset       #STATUS_PLAYING,(a2)
	bclr       #STATUS_PAUSED,(a2)
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : A$=_tracker title$(ADDR)
tracker_title:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_title1
	bsr        addrofbank
tracker_title1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a4
	movea.l    d3,a3
	clr.l      d3
	/* tst.b      (a3) */
	dc.w 0x0c13,0 /* XXX */
	beq.s      tracker_title5
tracker_title2:
	cmpi.w     #MAX_STRINGLEN,d3
	beq.s      tracker_title3
	/* tst.b      (a3)+ */
	dc.w 0x0c1b,0 /* XXX */
	beq.s      tracker_title3
	addq.w     #1,d3
	bra.s      tracker_title2
tracker_title3:
	andi.l     #255,d3 /* FIXME: useless */
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	move.w     d3,(a0)+
	subq.w     #1,d3
tracker_title4:
	move.b     (a4)+,(a0)+
	dbf        d3,tracker_title4
	bra.s      tracker_title6
tracker_title5:
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	move.w     #1,(a0)+
	move.b     #' ',(a0)+
tracker_title6:
	move.b     #0,(a0)+
	move.l     a1,d3         ; return value
	movem.l    (a7)+,a0-a6
	move.w     #0x80,d2      ; flag string type
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker loop on
tracker_loop_on:
	move.l     (a7)+,returnpc
	move.w     #0,warmflag
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	moveq.l    #-1,d1
	moveq.l    #M_trackerloop,d0
	trap       #7
	lea.l      status_bits(pc),a2
	bset       #STATUS_REPEAT,(a2)
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : A$=_tracker format$(ADDR)
tracker_format:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_format1
	bsr        addrofbank
tracker_format1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	bsr        paktype
	move.b     (a4)+,d3
	andi.l     #255,d3 /* FIXME: useless */
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	move.w     d3,(a0)+
	subq.w     #1,d3
tracker_format2:
	move.b     (a4)+,(a0)+
	dbf        d3,tracker_format2
	move.b     #0,(a0)+
	move.l     a1,d3         ; return value
	movem.l    (a7)+,a0-a6
	move.w     #0x80,d2      ; flag string type
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker loop off
tracker_loop_off:
	move.l     (a7)+,returnpc
	move.w     #0,warmflag
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	moveq.l    #0,d1
	moveq.l    #M_trackerloop,d0
	trap       #7
	lea.l      status_bits(pc),a2
	bclr       #STATUS_REPEAT,(a2)
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : ADDR=_tracker startaddress(BANK,N)
tracker_startadress:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #2,d0
	bne        syntax
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	andi.l     #255,d3
	move.w     d3,startaddress_modnum
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_startadress1
	bsr        addrofbank
tracker_startadress1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	movea.l    a0,a1
	lea.l      joined_module_id(pc),a2
	moveq.l    #joined_module_id_end-joined_module_id-1,d7
tracker_startadress2:
	cmpm.b     (a1)+,(a2)+
	bne.s      tracker_startadress3
	dbf        d7,tracker_startadress2
	moveq.l    #0,d0
	moveq.l    #0,d1
	move.w     startaddress_modnum(pc),d1
	move.w     40(a0),d0
	cmp.w      d1,d0
	bcs.s      tracker_startadress3
	subq.w     #1,d1
	asl.w      #3,d1
	move.l     42(a0,d1.w),d3
	adda.l     d3,a0
	move.l     a0,d3
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_startadress3:
	movem.l    (a7)+,a0-a6
	bra        banknotdefined
startaddress_modnum:   dc.w       0

* Syntax    : _tracker stop
tracker_stop:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	move.w     #0,warmflag
	movem.l    a0-a6,-(a7)
	moveq.l    #M_trackerstop,d0
	trap       #7
	lea.l      status_bits(pc),a2
	bclr       #STATUS_PLAYING,(a2)
	bclr       #STATUS_PAUSED,(a2)
	btst       #STATUS_REPEAT,(a2)
	beq.s      tracker_stop1
	moveq.l    #M_trackerloop,d0 /* BUG: no parameter in D1 */
	trap       #7
	bclr       #STATUS_REPEAT,(a2)
tracker_stop1:
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : SIZE=_tracker size(BANK,N)
tracker_size:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #2,d0
	bne        syntax
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	andi.l     #255,d3
	move.w     d3,size_modnum
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_size1
	bsr        addrofbank
tracker_size1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	movea.l    a0,a1
	lea.l      joined_module_id(pc),a2
	moveq.l    #joined_module_id_end-joined_module_id-1,d7
tracker_size2:
	cmpm.b     (a1)+,(a2)+
	bne.s      tracker_size3
	dbf        d7,tracker_size2
	moveq.l    #0,d0
	moveq.l    #0,d1
	move.w     size_modnum(pc),d1
	move.w     40(a0),d0
	cmp.w      d1,d0
	bcs.s      tracker_size3
	subq.w     #1,d1
	asl.w      #3,d1
	bsr.s      get_uncomp_size
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_size3:
	movem.l    (a7)+,a0-a6
	bra        banknotdefined

get_uncomp_size:
	movea.l    42(a0,d1.w),a4
	adda.l     a0,a4
	cmpi.l     #PACK_ICE2,(a4)
	beq.s      get_uncomp_size1
	cmpi.l     #PACK_ATOMIC,(a4)
	beq.s      get_uncomp_size2
	move.l     46(a0,d1.w),d3
	rts
get_uncomp_size1:
	move.l     8(a4),d3
	rts
get_uncomp_size2:
	move.l     4(a4),d3
	rts
size_modnum:  dc.w       0

* Syntax    : _tracker pause
tracker_pause:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	lea.l      status_bits(pc),a2
	btst       #STATUS_PAUSED,(a2)
	bne.s      tracker_pause1
	moveq.l    #M_trackerpause,d0
	trap       #7
	bset       #STATUS_PAUSED,(a2)
tracker_pause1:
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : X=_tracker songlength(ADDR)
tracker_songlength:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_songlength1
	bsr        addrofbank
tracker_songlength1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	bsr        paktype
	moveq.l    #0,d3
	move.b     0(a0,d0.w),d3
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker speed S
tracker_speed:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	cmpi.l     #8,d3
	blt.s      tracker_speed1
	bra        illfunc
tracker_speed1:
	move.l     d3,d1
	moveq.l    #M_trackerspeed,d0
	trap       #7
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : X=_tracker instruments max(ADDR)
tracker_instruments_max:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_instruments_max1
	bsr        addrofbank
tracker_instruments_max1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	bsr        paktype
	moveq.l    #0,d3
	move.w     d7,d3
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker volume V
tracker_volume:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	move.w     #0,warmflag
	bsr        getinteger
	andi.l     #15,d3
	not.w      d3
	andi.l     #15,d3
	rol.w      #4,d3
	move.w     d3,tracker_vol
	movem.l    a0-a6,-(a7)
	moveq.l    #LTATTEN,d0
	move.w     tracker_vol(pc),d1
	bsr        soundcmd
	moveq.l    #RTATTEN,d0
	move.w     tracker_vol(pc),d1
	bsr        soundcmd
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_vol: dc.w 0

* Syntax    : X=_tracker status
tracker_status:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	moveq.l    #M_trackerstatus,d0
	trap       #7
	movem.l    (a7)+,a0-a6
	move.b     status_bits(pc),d3
	bclr       #STATUS_END,d3
	btst       #STATUS_REPEAT,d3
	bne.s      tracker_status1
	cmpi.w     #-1,d0
	bne.s      tracker_status1
	bset       #STATUS_END,d3
tracker_status1:
	andi.l     #255,d3
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker copy SOURCE_ADDR,DESTINATION_ADDR,LENGTH
tracker_copy:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #3,d0
	bne        syntax
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	move.l     d3,tcopy_length
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_copy1
	bsr        addrofbank
tracker_copy1:
	move.l     d3,tcopy_dest
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_copy2
	bsr        addrofbank
tracker_copy2:
	move.l     d3,tcopy_src
	movea.l    tcopy_src(pc),a0
	movea.l    tcopy_dest(pc),a1
	move.l     tcopy_length(pc),d7
	addq.l     #4,d7
	andi.l     #-4,d7
	asr.l      #2,d7
tracker_copy3:
	move.l     (a0)+,(a1)+
	subq.l     #1,d7
	bne.s      tracker_copy3
	movea.l    returnpc(pc),a0
	jmp        (a0)
tcopy_length: dc.l 0
tcopy_dest: dc.l 0
tcopy_src: dc.l 0

* Syntax    : P=_tracker songpos
tracker_songpos:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	moveq.l    #0,d3
	lea.l      status_bits(pc),a2
	btst       #STATUS_INIT,(a2)
	beq.s      tracker_songpos1
	moveq.l    #M_trackersongpos,d0
	trap       #7
	move.l     d0,d3
	andi.l     #255,d3
tracker_songpos1:
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : P=_tracker pattpos
tracker_pattpos:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	moveq.l    #0,d3
	lea.l      status_bits(pc),a2
	btst       #STATUS_INIT,(a2)
	beq.s      tracker_pattpos1
	moveq.l    #M_trackerpattpos,d0
	trap       #7
	move.l     d0,d3
	andi.l     #255,d3
tracker_pattpos1:
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker ffwd
tracker_ffwd:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	moveq.l    #M_trackerffwd,d0
	trap       #7
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : A$=_tracker sample title$(ADDR,N)
tracker_sample_title:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #2,d0
	bne        syntax
	bsr        getinteger
	andi.l     #31,d3
	subq.l     #1,d3
	move.l     d3,sample_title_num
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_sample_title1
	bsr        addrofbank
tracker_sample_title1:
	movem.l    d0-d1/d4-d7/a0-a6,-(a7)
	move.l     sample_title_num(pc),d6
	mulu.w     #Amiga_Size,d6
	addi.l     #20,d6
	add.l      d6,d3
	movea.l    d3,a4
	movea.l    d3,a3
	clr.l      d3
tracker_sample_title2:
	cmpi.w     #Amiga_Length,d3
	beq.s      tracker_sample_title3
	/* tst.b     (a3)+ */
	dc.w 0x0c1b,0 /* XXX */
	beq.s      tracker_sample_title3
	addq.w     #1,d3
	bra.s      tracker_sample_title2
tracker_sample_title3:
	andi.l     #255,d3
	tst.w      d3
	beq.s      tracker_sample_title4
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	bsr.s      copy_sample_title
	move.l     a1,d3         ; return value
	movem.l    (a7)+,d0-d1/d4-d7/a0-a6
	move.w     #0x80,d2      ; flag string type
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_sample_title4:
	moveq.l    #0,d3
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	move.w     d3,(a0)+
	move.b     #0,(a0)+
	move.l     a1,d3         ; return value
	movem.l    (a7)+,d0-d1/d4-d7/a0-a6
	move.w     #0x80,d2      ; flag string type
	movea.l    returnpc(pc),a0
	jmp        (a0)

sample_title_num: dc.l 0

copy_sample_title:
	move.w     d3,(a0)+
	subq.w     #1,d3
copy_sample_title1:
	move.b     (a4)+,d1
	cmpi.b     #0x20,d1
	blt.s      copy_sample_title2
	cmpi.b     #0x7A,d1
	bgt.s      copy_sample_title2
	bra.s      copy_sample_title3
copy_sample_title2:
	move.b     #'.',d1
copy_sample_title3:
	move.b     d1,(a0)+
	dbf        d3,copy_sample_title1
	move.b     #0,(a0)+
	rts

* Syntax    : _tracker songprev
tracker_songprev:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	moveq.l    #M_trackersongprev,d0
	trap       #7
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : MAX_VOICE=_tracker voices(ADDR)
tracker_voices:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_voices1
	bsr        addrofbank
tracker_voices1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	bsr        paktype
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker songnext
tracker_songnext:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	moveq.l    #M_trackersongnext,d0
	trap       #7
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : X=_tracker vu(VOICE)
tracker_vu:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	andi.l     #15,d3 /* BUG? */
	movem.l    d0-d2/d4-d7/a0-a6,-(a7)
	move.l     d3,d1
	moveq.l    #0,d3
	lea.l      status_bits(pc),a2
	btst       #STATUS_INIT,(a2)
	beq.s      tracker_vu1
	btst       #STATUS_PLAYING,(a2)
	beq.s      tracker_vu1
	btst       #STATUS_PAUSED,(a2)
	bne.s      tracker_vu1
	moveq.l    #M_trackervu,d0
	trap       #7
	move.l     d0,d3
	andi.l     #127,d3
	cmpi.l     #64,d3
	bcs.s      tracker_vu1
	moveq.l    #64,d3
tracker_vu1:
	movem.l    (a7)+,d0-d2/d4-d7/a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : X=_tracker spectrum(VOICE)
tracker_spectrum:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	andi.l     #15,d3 /* BUG? */
	movem.l    a0-a6,-(a7)
	move.l     d3,d1
	moveq.l    #0,d3
	lea.l      status_bits(pc),a2
	btst       #STATUS_INIT,(a2)
	beq.s      tracker_spectrum1
	btst       #STATUS_PLAYING,(a2)
	beq.s      tracker_spectrum1
	btst       #STATUS_PAUSED,(a2)
	bne.s      tracker_spectrum1
	moveq.l    #M_trackerspectrum,d0
	trap       #7
	move.l     d0,d3
	andi.l     #0x000003FF,d3
tracker_spectrum1:
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : MX_SIZE=_tracker maxsize(BANK)
tracker_maxsize:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_maxsize1
	bsr        addrofbank
tracker_maxsize1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	movea.l    a0,a1
	lea.l      joined_module_id(pc),a2
	moveq.l    #joined_module_id_end-joined_module_id-1,d7
tracker_maxsize2:
	cmpm.b     (a1)+,(a2)+
	bne.s      tracker_maxsize6
	dbf        d7,tracker_maxsize2
	lea.l      42(a0),a2
	lea.l      46(a0),a3
	move.w     40(a0),d0
	moveq.l    #0,d1
tracker_maxsize3:
	tst.w      d0
	beq.s      tracker_maxsize5
	bsr.s      mget_uncomp_size
	cmp.l      d2,d1
	bcc.s      tracker_maxsize4
	exg        d2,d1
tracker_maxsize4:
	subq.w     #1,d0
	addq.l     #8,a2
	addq.l     #8,a3
	bra.s      tracker_maxsize3
tracker_maxsize5:
	move.l     d1,d3
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_maxsize6:
	movem.l    (a7)+,a0-a6
	bra        banknotdefined

mget_uncomp_size:
	movea.l    (a2),a4
	adda.l     a0,a4
	cmpi.l     #PACK_ICE2,(a4)
	beq.s      mget_uncomp_size1
	cmpi.l     #PACK_ATOMIC,(a4)
	beq.s      mget_uncomp_size2
	move.l     (a3),d2
	rts
mget_uncomp_size1:
	move.l     8(a4),d2
	rts
mget_uncomp_size2:
	move.l     4(a4),d2
	rts

* Syntax    : HOW_MANY=_tracker howmany(BANK)
tracker_howmany:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_howmany1
	bsr        addrofbank
tracker_howmany1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	movea.l    a0,a1
	lea.l      joined_module_id(pc),a2
	moveq.l    #joined_module_id_end-joined_module_id-1,d7
tracker_howmany2:
	cmpm.b     (a1)+,(a2)+
	bne.s      tracker_howmany3
	dbf        d7,tracker_howmany2
	moveq.l    #0,d3
	move.w     40(a0),d3
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_howmany3:
	movem.l    (a7)+,a0-a6
	bra        banknotdefined

* Syntax    : X=_tracker packed(BANK,N)
tracker_packed:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #2,d0
	bne        syntax
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	andi.l     #255,d3
	move.w     d3,packed_modnum
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_packed1
	bsr        addrofbank
tracker_packed1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	movea.l    a0,a1
	lea.l      joined_module_id(pc),a2
	moveq.l    #joined_module_id_end-joined_module_id-1,d7
tracker_packed2:
	cmpm.b     (a1)+,(a2)+
	bne.s      tracker_packed5
	dbf        d7,tracker_packed2
	moveq.l    #0,d0
	moveq.l    #0,d1
	move.w     packed_modnum(pc),d1
	move.w     40(a0),d0
	cmp.w      d1,d0
	bcs.s      tracker_packed5
	subq.w     #1,d1
	asl.w      #3,d1
	movea.l    42(a0,d1.w),a4
	adda.l     a0,a4
	cmpi.l     #PACK_ICE2,(a4)
	beq.s      tracker_packed3
	cmpi.l     #PACK_ATOMIC,(a4)
	beq.s      tracker_packed3
	moveq.l    #0,d3
	bra.s      tracker_packed4
tracker_packed3:
	moveq.l    #-1,d3
tracker_packed4:
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_packed5:
	movem.l    (a7)+,a0-a6
	bra        banknotdefined
packed_modnum: dc.w       0

* Syntax    : _tracker depack SOURCE[,DEST]
tracker_depack:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	lea.l      depack_argc(pc),a0
	move.w     d0,(a0)
	cmp.w      #1,d0
	beq.s      tracker_depack2
	cmp.w      #2,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_depack1
	bsr        addrofbank
tracker_depack1:
	lea.l      depack_dest(pc),a0
	move.l     d3,(a0)
tracker_depack2:
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_depack3
	bsr        addrofbank
tracker_depack3:
	lea.l      depack_src(pc),a0
	move.l     d3,(a0)
	move.w     depack_argc(pc),d0
	cmpi.w     #1,d0
	bne.s      tracker_depack4
	move.l     d3,depack_dest-depack_src(a0)
tracker_depack4:
	movea.l    depack_src(pc),a0
	cmpi.l     #PACK_ICE2,(a0)
	beq.s      d_crunch
	cmpi.l     #PACK_ATOMIC,(a0)
	beq.s      d_crunch
	movea.l    returnpc(pc),a0
	jmp        (a0)

d_crunch:
	movem.l    a0-a6,-(a7)
	movea.l    depack_src(pc),a0
	movea.l    depack_dest(pc),a1
	cmpa.l     a0,a1
	beq.s      d_crunch2
	move.l     4(a0),d7
	addq.l     #4,d7
	andi.l     #-4,d7
	asr.l      #2,d7
d_crunch1:
	move.l     (a0)+,(a1)+
	subq.l     #1,d7
	bne.s      d_crunch1
	movea.l    depack_dest(pc),a0
d_crunch2:
	cmpi.l     #PACK_ICE2,(a0)
	beq.s      do_ice2
	cmpi.l     #PACK_ATOMIC,(a0)
	beq.s      do_atomic
	bra.s      d_crunch3
do_ice2:
	bsr        ice2
	bra.s      d_crunch3
do_atomic:
	bsr        atomik
d_crunch3:
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)
depack_argc: dc.w       0
depack_src: dc.l 0
depack_dest: dc.l 0

* Syntax    : SIZE=_tracker filelength(B)
tracker_filelength:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	move.l     loaded_filelength(pc),d3 /* FIXME: uses only single static value */
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker load F$,B
tracker_load:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #2,d0
	bne        syntax
	lea.l      status_bits(pc),a0
	bclr       #STATUS_RES3,(a0)
	bclr       #STATUS_RES4,(a0)
	lea.l      loaded_filelength(pc),a1
	clr.l      (a1)
	bsr        getinteger
	tst.l      d3
	bmi        illfunc
	beq        illfunc
	cmpi.l     #MAX_BANK_NUM,d3
	bgt        illfunc
	lea.l      load_banknum(pc),a0
	move.w     d3,(a0)
	bsr        getstring
	movea.l    d3,a0
	moveq.l    #0,d3
	move.w     (a0)+,d3
	subq.l     #1,d3
	lea.l      load_filename(pc),a1
tracker_load1:
	move.b     (a0)+,(a1)+
	dbf        d3,tracker_load1
	move.b     #0,(a1)
	movem.l    a0-a6,-(a7)
	move.w     #7-1,d7
	lea.l      module_header(pc),a0
tracker_load2:
	clr.l      (a0)+
	dbf        d7,tracker_load2
	moveq.l    #0,d3
	move.w     load_banknum(pc),d3
	bsr        erase
	move.w     #47,-(a7) /* Fgetdta */
	trap       #1
	addq.l     #2,a7
	lea.l      dtaptr(pc),a3
	move.l     d0,(a3)
	move.w     #-1,-(a7)
	pea.l      load_filename(pc)
	move.w     #78,-(a7) /* Fsfirst */
	trap       #1
	addq.l     #8,a7
	tst.l      d0
	beq.s      tracker_load3
	moveq.l    #-1,d0
tracker_load3:
	not.l      d0
	tst.l      d0
	beq        tracker_load10
	movea.l    dtaptr(pc),a0
	move.l     26(a0),d3 /* file size from DTA */
	andi.l     #0x7FFFFFFF,d3
	lea.l      compressed_len(pc),a0
	move.l     d3,(a0)
	lea.l      loaded_filelength(pc),a1
	move.l     d3,(a1)
	lea.l      load_filename(pc),a0
	bsr        open
	tst.w      d0
	bmi        tracker_load11
	lea.l      module_header(pc),a0
	moveq.l    #26,d0
	bsr        read
	tst.l      d0
	bmi        tracker_load11
	bsr        close
	lea.l      status_bits(pc),a2
	lea.l      compressed_len(pc),a0
	move.l     (a0),d3
	lea.l      load_paktype(pc),a1
	move.w     #0,(a1)
	lea.l      module_header(pc),a0
	cmpi.l     #PACK_ICE2,(a0)
	beq.s      tracker_load5
	cmpi.l     #PACK_ATOMIC,(a0)
	beq.s      tracker_load4
	bra.s      tracker_load6
tracker_load4:
	bclr       #STATUS_RES3,(a2)
	bset       #STATUS_RES4,(a2)
	move.w     #2,(a1)
	move.l     4(a0),d3
	bra.s      tracker_load6
	lea.l      loaded_filelength(pc),a0
	move.l     #0,(a0)
	bra.w      tracker_load9
tracker_load5:
	bset       #STATUS_RES3,(a2)
	bclr       #STATUS_RES4,(a2)
	move.w     #1,(a1)
	move.l     8(a0),d3
tracker_load6:
	lea.l      loaded_filelength(pc),a0
	move.l     d3,(a0)
	move.w     #1,d1
	moveq.l    #0,d2
	move.w     load_banknum(pc),d2
	addi.l     #0x00008000,d3
	bsr        reserve
	moveq.l    #0,d3
	move.w     load_banknum(pc),d3
	bsr        addrofbank
	lea.l      load_faddr(pc),a0
	move.l     d3,(a0)
	lea.l      load_filename(pc),a0
	bsr.s      open
	tst.w      d0
	bmi.s      tracker_load11
	movea.l    load_faddr(pc),a0
	move.l     compressed_len(pc),d0
	bsr.s      read
	tst.l      d0
	bmi.s      tracker_load11
	bsr.s      close
	lea.l      load_paktype(pc),a1
	tst.w      (a1)
	beq.s      tracker_load9
	cmpi.w     #1,(a1)
	beq.s      tracker_load7
	cmpi.w     #2,(a1)
	beq.s      tracker_load8
	bra.s      tracker_load9
tracker_load7:
	movea.l    load_faddr(pc),a0
	bsr        ice2
	bra.s      tracker_load9
tracker_load8:
	movea.l    load_faddr(pc),a0
	bsr        atomik
tracker_load9:
	movem.l    (a7)+,a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_load10:
	movem.l    (a7)+,a0-a6
	bra        enoent
tracker_load11:
	movem.l    (a7)+,a0-a6
	bra        diskerror

open:
	clr.w      -(a7)
	move.l     a0,-(a7)
	move.w     #61,-(a7) /* Fopen */
	trap       #1
	addq.l     #8,a7
	move.w     d0,filehandle
	rts

read:
	move.l     a0,-(a7)
	move.l     d0,-(a7)
	move.w     filehandle(pc),-(a7)
	move.w     #63,-(a7) /* Fread */
	trap       #1
	lea.l      12(a7),a7
	rts

close:
	move.w     filehandle(pc),-(a7)
	move.w     #62,-(a7) /* Fclose */
	trap       #1
	addq.l     #4,a7
	rts

* Syntax    : X=_tracker instruments used(ADDR)
tracker_instruments_used:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_instruments_used1
	bsr        addrofbank
tracker_instruments_used1:
	movem.l    a0-a6,-(a7)
	movea.l    d3,a0
	bsr        paktype
	subq.w     #1,d7
	moveq.l    #0,d3
	lea.l      20+Amiga_Length(a0),a0
tracker_instruments_used2:
	tst.w      (a0)
	beq.s      tracker_instruments_used3
	addq.w     #1,d3
tracker_instruments_used3:
	lea.l      Amiga_Size(a0),a0
	dbf        d7,tracker_instruments_used2
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : _tracker scope init SCREEN,SCOPE_X1,SCOPE_Y1,COLOR
tracker_scope_init:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #4,d0
	bne        syntax
	bsr        getinteger
	lea.l      scope_color(pc),a0
	move.w     d3,(a0)
	bsr        getinteger
	lea.l      scope_y1(pc),a0
	move.w     d3,(a0)
	bsr        getinteger
	lea.l      scope_x1(pc),a0
	move.w     d3,(a0)
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_scope_init1
	bsr        addrofbank
tracker_scope_init1:
	movem.l    d0-d1/d4-d7/a0-a6,-(a7)
	lea.l      scope_screen(pc),a0
	move.l     d3,(a0)
	lea.l      scope_x1(pc),a0
	move.w     (a0),d2
	addi.w     #64,d2
	move.w     d2,scope_x2-scope_x1(a0)
	move.w     scope_y1-scope_x1(a0),d2
	addi.w     #24,d2
	move.w     d2,scope_ymid-scope_x1(a0)
	move.w     scope_y1-scope_x1(a0),d2
	addi.w     #48,d2
	move.w     d2,scope_y2-scope_x1(a0)
	dc.w 0xa000 /* ALINE #0 */
	lea.l      lineavars(pc),a1
	move.l     a0,(a1)
	lea.l      la_bytes_line(pc),a1
	move.w     -2(a0),la_bytes_line-la_bytes_line(a1)
	/* move.w     (a0),d0 */
	dc.w 0x3028,0 /* XXX */
	move.w     d0,la_planes-la_bytes_line(a1)
	asl.w      #1,d0
	move.w     d0,la_pixeloff-la_bytes_line(a1)
	move.w     scope_x1(pc),d0
	swap       d0
	move.w     scope_ymid(pc),d0
	lea.l      scope_currx(pc),a0
	move.l     d0,(a0) /* also writes scope_curry */
	lea.l      scope_colormask(pc),a0
	move.w     #-1,(a0)
	lea.l      scope_active(pc),a0
	move.w     #-1,(a0)
	movem.l    (a7)+,d0-d1/d4-d7/a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)

* Syntax    : A$=_tracker patt info$(ADDR)
tracker_patt_info:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	cmp.w      #1,d0
	bne        syntax
	bsr        getinteger
	cmpi.l     #MAX_BANK_NUM,d3
	bgt.s      tracker_patt_info1
	bsr        addrofbank
tracker_patt_info1:
	movem.l    d0-d1/d4-d7/a0-a6,-(a7)
	lea.l      status_bits(pc),a2
	btst       #STATUS_INIT,(a2)
	beq        tracker_patt_info6
	btst       #STATUS_PLAYING,(a2)
	beq.s      tracker_patt_info6
	btst       #STATUS_PAUSED,(a2)
	bne.s      tracker_patt_info6
	moveq.l    #M_trackerpattinfo,d0
	trap       #7
	move.l     d0,d7
	tst.l      d0
	bmi.s      tracker_patt_info6
	movea.l    a0,a4
	lea.l      zeroflag(pc),a2
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	move.w     #0,(a0)+
tracker_patt_info2:
	lea.l      notes_table(pc),a6
	moveq.l    #(notes_table_end-notes_table)/6-1,d6
	move.l     #0x2D2D2D20,d4
	move.w     (a4)+,d2
	move.w     (a4)+,d0
tracker_patt_info3:
	cmp.w      (a6),d2
	beq.s      tracker_patt_info4
	addq.l     #6,a6
	dbf        d6,tracker_patt_info3
	bra.s      tracker_patt_info5
tracker_patt_info4:
	move.l     2(a6),d4
	ori.b      #0x20,d4
tracker_patt_info5:
	move.l     d4,(a0)+
	addq.w     #4,(a1)
	move.w     #-1,(a2)
	bsr.s      print4hex
	addq.w     #4,(a1)
	move.b     #' ',(a0)+
	move.b     #' ',(a0)+
	addq.w     #2,(a1)
	dbf        d7,tracker_patt_info2
	subq.l     #2,a0
	move.b     #0,(a0)+
	move.b     #0,(a0)+
	subq.w     #2,(a1)
	move.l     a1,d3         ; return value
	movem.l    (a7)+,d0-d1/d4-d7/a0-a6
	move.w     #0x80,d2      ; flag string type
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_patt_info6:
	movea.l    d3,a0
	bsr        paktype
	move.w     d3,d7
	subq.w     #1,d7
	mulu.w     #10,d3
	lea.l      stringbuf(pc),a0
	movea.l    a0,a1
	move.w     d3,(a0)+
tracker_patt_info7:
	move.l     #0x20202020,(a0)+
	move.l     #0x20202020,(a0)+
	move.w     #0x2020,(a0)+
	dbf        d7,tracker_patt_info7
	move.b     #0,(a0)+
	move.l     a1,d3
	movem.l    (a7)+,d0-d1/d4-d7/a0-a6
	move.w     #0x0080,d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

print4hex:
	movem.l    d0-d7/a1-a6,-(a7)
	exg        d0,d4
	andi.l     #0x0000FFFF,d4
	rol.w      #8,d4
	move.b     d4,d0
	bsr.s      printhex
	rol.w      #8,d4
	move.b     d4,d0
	bsr.s      printhex
	movem.l    (a7)+,d0-d7/a1-a6
	rts

printhex:
	move.b     d0,d5
	andi.l     #0x000000F0,d0
	ror.b      #4,d0
	cmp.b      #9,d0
	ble.s      printhex1
	addq.b     #'A'-'0'-10,d0
printhex1:
	addi.b     #'0',d0
	bsr.s      printdig
	move.b     d5,d0
	andi.l     #15,d0
	cmp.b      #9,d0
	ble.s      printhex2
	addq.b     #'A'-'0'-10,d0
printhex2:
	addi.b     #'0',d0
	bsr.s      printdig
	rts

printdig:
	lea.l      zeroflag(pc),a2
	cmpi.b     #'0',d0
	bne.s      printdig1
	tst.w      (a2)
	beq.s      printdig2
printdig1:
	move.w     #-1,(a2)
	move.b     d0,(a0)+
printdig2:
	rts

* Syntax    : _tracker scope draw
tracker_scope_draw:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	lea.l      scope_active(pc),a0
	tst.w      (a0)
	bne.s      tracker_scope_draw1
	movea.l    returnpc(pc),a0
	jmp        (a0)
tracker_scope_draw1:
	movem.l    d0-d7/a0-a6,-(a7)
	lea.l      status_bits(pc),a2
	btst       #STATUS_INIT,(a2)
	beq        tracker_scope_draw4
	btst       #STATUS_PLAYING,(a2)
	beq        tracker_scope_draw4
	btst       #STATUS_PAUSED,(a2)
	bne        tracker_scope_draw4
	moveq.l    #M_trackerscopedraw,d0
	trap       #7
	tst.w      d0
	beq        tracker_scope_draw5
	lea.l      undraw_flag(pc),a2
	move.w     #0,(a2)
	bsr        undraw_scope
	movea.l    a0,a1
	move.w     scope_x2(pc),d7
	sub.w      scope_x1(pc),d7
	cmp.w      d0,d7
	blt.s      tracker_scope_draw2
	move.w     d0,d7
tracker_scope_draw2:
	subq.w     #1,d7
	movea.l    lineavars(pc),a0
	lea.l      scope_currx(pc),a2
	lea.l      scope_currcolor(pc),a3
	move.w     scope_color(pc),(a3)
	move.w     scope_x1(pc),d2
	move.w     scope_ymid(pc),d3
	move.b     (a1)+,d1
	ext.w      d1
	ext.l      d1
	divs.w     #8,d1
	andi.l     #0x0000FFFF,d1
	add.w      d1,d3
	move.w     d3,scope_curry-scope_currx(a2)
tracker_scope_draw3:
	move.w     scope_ymid(pc),d3
	move.b     (a1)+,d1
	ext.w      d1
	ext.l      d1
	divs.w     #8,d1
	andi.l     #0x0000FFFF,d1
	add.w      d1,d3
	move.w     scope_currx(pc),d0
	move.w     scope_curry(pc),d1
	bsr        draw_line
	move.w     d2,scope_currx-scope_currx(a2)
	move.w     d3,scope_curry-scope_currx(a2)
	addq.w     #1,d2
	dbf        d7,tracker_scope_draw3
	moveq.l    #M_trackerscopeundraw,d0
	trap       #7
	bra.s      tracker_scope_draw5
tracker_scope_draw4:
	lea.l      undraw_flag(pc),a2
	tst.w      (a2)
	bmi.s      tracker_scope_draw5
	bsr.w      undraw_scope
	move.w     #-1,(a2)
tracker_scope_draw5:
	movem.l    (a7)+,d0-d7/a0-a6
	movea.l    returnpc(pc),a0
	jmp        (a0)


undraw_scope:
	movem.l    d0-d7/a0-a6,-(a7)
	lea.l      scope_currcolor(pc),a0
	lea.l      scope_x1(pc),a1
	lea.l      scope_currx(pc),a2
	move.w     #0,(a0)
	movem.w    (a1)+,d0-d3 /* scope_x1/scope_y1/scope_x2/scope_y2 */
	bsr        draw_bars
	move.w     scope_color(pc),(a0)
	move.w     scope_x1(pc),(a2)
	movem.l    (a7)+,d0-d7/a0-a6
	rts

draw_rectangle:
	movem.l    d0-d7/a0-a6,-(a7)
	andi.l     #0x000003FF,d0
	andi.l     #0x000001FF,d1
	andi.l     #0x000003FF,d2
	andi.l     #0x000001FF,d3
	cmp.w      d0,d2
	bcc.s      draw_rectangle_1
	exg        d0,d2
draw_rectangle_1:
	cmp.w      d1,d3
	bcc.s      draw_rectangle_2
	exg        d1,d3
draw_rectangle_2:
	lea.l      cliprect(pc),a1
	/* cmp.w      0(a1),d0 */
	dc.w 0xb069,0 /* XXX */
	bcc.s      draw_rectangle_3
	/* move.w     0(a1),d0 */
	dc.w 0x3029,0
draw_rectangle_3:
	cmp.w      4(a1),d2
	bcs.s      draw_rectangle_4
	move.w     4(a1),d2
draw_rectangle_4:
	cmp.w      2(a1),d1
	bcc.s      draw_rectangle_5
	move.w     2(a1),d1
draw_rectangle_5:
	cmp.w      6(a1),d3
	bcs.s      draw_rectangle_6
	move.w     6(a1),d3
draw_rectangle_6:
	lea.l      rectangle_coords(pc),a4
	movem.w    d0-d3,(a4)
	/* move.w     0(a4),d0 */
	dc.w 0x302c,0 /* XXX */
	move.w     2(a4),d1
	/* move.w     0(a4),d2 */
	dc.w 0x342c,0 /* XXX */
	move.w     6(a4),d3
	bsr        draw_line
	/* move.w     0(a4),d0 */
	dc.w 0x302c,0 /* XXX */
	move.w     2(a4),d1
	move.w     4(a4),d2
	move.w     2(a4),d3
	bsr        draw_line
	move.w     4(a4),d0
	move.w     2(a4),d1
	move.w     4(a4),d2
	move.w     6(a4),d3
	bsr        draw_line
	/* move.w     0(a4),d0 */
	dc.w 0x302c,0 /* XXX */
	move.w     6(a4),d1
	move.w     4(a4),d2
	move.w     6(a4),d3
	bsr        draw_line
	movem.l    (a7)+,d0-d7/a0-a6
	rts
rectangle_coords: ds.w 4

draw_bars:
	movem.l    d0-d7/a0-a6,-(a7)
	andi.l     #0x000003FF,d0
	andi.l     #0x000001FF,d1
	andi.l     #0x000003FF,d2
	andi.l     #0x000001FF,d3
	cmp.w      d0,d2
	bcc.s      draw_bars_1
	exg        d0,d2
draw_bars_1:
	cmp.w      d1,d3
	bcc.s      draw_bars_2
	exg        d1,d3
draw_bars_2:
	lea.l      cliprect(pc),a1
	bra.s      draw_bars_7
draw_bars_3:
	/* cmp.w      0(a1),d0 */
	dc.w 0xb069,0 /* XXX */
	bcc.s      draw_bars_4
	/* move.w     0(a1),d0 */
	dc.w 0x3029,0 /* XXX */
draw_bars_4:
	cmp.w      4(a1),d2
	bcs.s      draw_bars_5
	move.w     4(a1),d2
draw_bars_5:
	cmp.w      2(a1),d1
	bcc.s      draw_bars_6
	move.w     2(a1),d1
draw_bars_6:
	cmp.w      6(a1),d3
	bcs.s      draw_bars_7
	move.w     6(a1),d3
draw_bars_7:
	lea.l      bars_coords(pc),a4
	movem.w    d0-d3,(a4)
	cmp.w      d0,d2
	beq.s      draw_bars_9
	cmp.w      d1,d3
	beq.s      draw_bars_9
	/* move.w     0(a4),d0 */
	dc.w 0x302c,0 /* XXX */
	move.w     2(a4),d1
	move.w     4(a4),d2
	move.w     2(a4),d3
	bsr.w      draw_line
draw_bars_8:
	addq.w     #1,2(a4)
	/* move.w     0(a4),d0 */
	dc.w 0x302c,0 /* XXX */
	move.w     2(a4),d1
	move.w     4(a4),d2
	move.w     2(a4),d3
	bsr        draw_back
	move.w     6(a4),d0
	cmp.w      2(a4),d0
	bne.s      draw_bars_8
	/* move.w     0(a4),d0 */
	dc.w 0x302c,0 /* XXX */
	move.w     6(a4),d1
	move.w     4(a4),d2
	move.w     6(a4),d3
	bsr.w      draw_line
draw_bars_9:
	movem.l    (a7)+,d0-d7/a0-a6
	rts
bars_coords: ds.w 4

draw_line:
	movem.l    d0-d7/a0-a6,-(a7)
	andi.l     #0x0000FFFF,d0
	andi.l     #0x0000FFFF,d1
	andi.l     #0x0000FFFF,d2
	andi.l     #0x0000FFFF,d3
	movea.l    scope_screen(pc),a0
	movea.l    lineavars(pc),a6
	cmpi.w     #16,(a6) /* hicolor? */
	beq        drawhi_line
	cmp.w      d1,d3
	bne.s      draw_line3
	cmp.w      d0,d2
	bcc.s      draw_line1
	exg        d0,d2
draw_line1:
	cmp.w      d1,d3
	bcc.s      draw_line2
	exg        d1,d3
draw_line2:
	bsr        draw_horline
	movem.l    (a7)+,d0-d7/a0-a6
	rts
draw_line3:
	cmp.w      d0,d2
	bne.s      draw_diagline
	cmp.w      d0,d2
	bcc.s      draw_line4
	exg        d0,d2
draw_line4:
	cmp.w      d1,d3
	bcc.s      draw_line5
	exg        d1,d3
draw_line5:
	bsr        calc_screenaddr
	bsr        calc_endaddr
	bsr        draw_vertline
	movem.l    (a7)+,d0-d7/a0-a6
	rts

draw_diagline:
	bsr        calc_screenaddr
	bsr        calc_endaddr
	lea.l      drawdiag_coords(pc),a0
	movem.w    d0-d3,(a0)
	moveq.l    #0,d4
	moveq.l    #0,d5
	moveq.l    #0,d6
	moveq.l    #0,d7
	lea.l      drawdiag_flags(pc),a3
	move.w     drawdiag_coords+0(pc),d0
	move.w     drawdiag_coords+2(pc),d1
	move.w     drawdiag_coords+4(pc),d2
	move.w     drawdiag_coords+6(pc),d3
	sub.w      d0,d2
	sub.w      d1,d3
	move.w     d2,d4
	move.w     d3,d5
	move.w     drawdiag_coords+0(pc),d0
	move.w     drawdiag_coords+2(pc),d1
	tst.w      d4
	bpl.s      draw_diagline1
	neg.w      d4
	move.w     #-1,(a3)
	bra.s      draw_diagline2
draw_diagline1:
	move.w     #1,(a3)
draw_diagline2:
	tst.w      d5
	bpl.s      draw_diagline3
	neg.w      d5
	move.w     #-1,2(a3)
	bra.s      draw_diagline4
draw_diagline3:
	move.w     #1,2(a3)
draw_diagline4:
	tst.w      d5
	bne.s      draw_diagline5
	move.w     #-1,4(a3)
	bra.s      draw_diagline6
draw_diagline5:
	move.w     #0,4(a3)
draw_diagline6:
	cmp.w      drawdiag_coords+4(pc),d0
	bne.s      draw_diagline7
	cmp.w      drawdiag_coords+6(pc),d1
	beq.s      draw_diagline10
draw_diagline7:
	move.w     4(a3),d6
	tst.w      d6
	bge.s      draw_diagline8
	/* add.w      0(a3),d0 */
	dc.w 0xd06b,0 /* XXX */
	add.w      d5,4(a3)
	bra.s      draw_diagline9
draw_diagline8:
	add.w      2(a3),d1
	sub.w      d4,4(a3)
draw_diagline9:
	bsr        setpixel
	bra.s      draw_diagline6
draw_diagline10:
	movem.l    (a7)+,d0-d7/a0-a6
	rts
drawdiag_coords: ds.w 4
drawdiag_flags: ds.w 3

drawhi_line:
	cmp.w      d0,d2
	beq.s      drawhi_line1
	cmp.w      d1,d2
	beq.s      drawhi_line1
	bra        draw_diagline
drawhi_line1:
	lea.l      hiline_coords(pc),a0
	movem.w    d0-d3,(a0)
	movea.l    lineavars(pc),a0
	cmpi.w     #16,(a0)
	bne.w      drawhi_line4
	move.w     #3,-(a7) /* Logbase */
	trap       #14
	addq.l     #2,a7
	movea.l    d0,a0
	moveq.l    #0,d4
	moveq.l    #0,d5
	moveq.l    #0,d6
	moveq.l    #0,d7
	move.w     hiline_coords+0(pc),d4
	move.w     hiline_coords+2(pc),d5
	move.w     hiline_coords+4(pc),d6
	move.w     hiline_coords+6(pc),d7
	cmp.w      d4,d6
	bcc.s      drawhi_line2
	exg        d4,d6
drawhi_line2:
	cmp.w      d5,d7
	bcc.s      drawhi_line3
	exg        d5,d7
drawhi_line3:
	cmp.w      d4,d6
	beq.w      drawhi_vertline
	cmp.w      d5,d7
	beq.w      drawhi_horline
drawhi_line4:
	nop
	movem.l    (a7)+,d0-d7/a0-a6
	rts

drawhi_vertline:
	movea.l    lineavars(pc),a1
	move.w     d5,d0
	sub.w      d5,d7
	move.w     d5,d2
	moveq.l    #0,d1
	move.w     la_bytes_line(pc),d1
	mulu.w     d1,d2
	adda.l     d2,a0
	asl.w      #1,d4
	adda.l     d4,a0
	move.w     scope_colormask(pc),d3
drawhi_vertline1:
	move.w     scope_currcolor(pc),d2
	move.w     d0,d4
	andi.w     #0x000F,d4
	neg.w      d4
	addi.w     #0x000F,d4
	btst       d4,d3
	bne.s      drawhi_vertline2
	not.w      d2
	move.w     d2,(a0)
	bra.s      drawhi_vertline3
drawhi_vertline2:
	move.w     d2,(a0)
drawhi_vertline3:
	nop
	addq.w     #1,d0
	adda.w     d1,a0
	dbf        d7,drawhi_vertline1
	movem.l    (a7)+,d0-d7/a0-a6
	rts

drawhi_horline:
	movea.l    lineavars(pc),a1
	move.w     d4,d0
	sub.w      d4,d6
	move.w     d5,d2
	mulu.w     la_bytes_line(pc),d2
	adda.l     d2,a0
	asl.w      #1,d4
	adda.l     d4,a0
	move.w     scope_colormask(pc),d3
drawhi_horline1:
	move.w     scope_currcolor(pc),d1
	move.w     d0,d4
	andi.w     #15,d4
	neg.w      d4
	addi.w     #15,d4
	btst       d4,d3
	bne.s      drawhi_horline2
	not.w      d1
	move.w     d1,(a0)+
	bra.s      drawhi_horline3
drawhi_horline2:
	move.w     d1,(a0)+
drawhi_horline3:
	addq.w     #1,d0
	dbf        d6,drawhi_horline1
	movem.l    (a7)+,d0-d7/a0-a6
	rts

hiline_coords: ds.w 4

draw_horline:
	bsr        calc_screenaddr
	bsr        calc_endaddr
	movem.l    d0-d7/a0-a6,-(a7)
	move.w     la_planes(pc),d5
	subq.w     #1,d5
	move.w     la_bytes_line(pc),d6
	movea.l    a2,a4
	movea.l    a3,a5
	cmpa.l     a2,a3
	beq        draw_horline11
	suba.l     a4,a5
	cmpa.w     d7,a5
	beq        draw_horline15
	bsr        calc_bitstartpos
	move.w     scope_currcolor(pc),d4
	move.w     scope_colormask(pc),d3
	movem.l    d3-d7,-(a7)
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_horline1:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_horline2
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
	bra.w      draw_horline3 /* XXX */
draw_horline2:
	bfins      d1,d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
draw_horline3:
	dbf        d5,draw_horline1
	movem.l    (a7)+,d3-d7
draw_horline4:
	movem.l    d3-d7,-(a7)
draw_horline5:
	lsr.w      #1,d4
	bcs.s      draw_horline6
	move.w     #0,(a2)+
	bra.w      draw_horline7 /* XXX */
draw_horline6:
	move.w     d3,(a2)+
draw_horline7:
	dbf        d5,draw_horline5
	movem.l    (a7)+,d3-d7
	cmpa.l     a2,a3
	bne.w      draw_horline4 /* XXX */
	bsr        calc_bitendpos
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_horline8:
	move.w     (a3),d0
	lsr.w      #1,d4
	bcs.s      draw_horline9
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a3)+
	bra.w      draw_horline10 /* XXX */
draw_horline9:
	bfins      d1,d0{d6:d7} ; 68020+ only
	move.w     d0,(a3)+
draw_horline10:
	dbf        d5,draw_horline8
	movem.l    (a7)+,d0-d7/a0-a6
	rts
draw_horline11:
	move.w     d0,d6
	move.w     d2,d7
	sub.w      d6,d7
	addq.w     #1,d7
	divu.w     #16,d6
	swap       d6
	addi.w     #16,d6
	move.w     scope_currcolor(pc),d4
	move.w     scope_colormask(pc),d3
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_horline12:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_horline13
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
	bra.w      draw_horline14 /* XXX */
draw_horline13:
	bfins      d1,d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
draw_horline14:
	dbf        d5,draw_horline12
	movem.l    (a7)+,d0-d7/a0-a6
	rts
draw_horline15:
	bsr        calc_bitstartpos
	lea.l      horline_params(pc),a4
	movem.w    d6-d7,(a4)
	bsr        calc_bitendpos
	movem.w    d6-d7,4(a4)
	movem.l    d0-d7/a0-a6,-(a7)
	movem.w    (a4),d6-d7
	move.w     scope_currcolor(pc),d4
	move.w     scope_colormask(pc),d3
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_horline16:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_horline17
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
	bra.w      draw_horline18 /* XXX */
draw_horline17:
	bfins      d1,d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
draw_horline18:
	dbf        d5,draw_horline16
	movem.l    (a7)+,d0-d7/a0-a6
	movem.w    4(a4),d6-d7
	move.w     scope_currcolor(pc),d4
	move.w     scope_colormask(pc),d3
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_horline19:
	move.w     (a3),d0
	lsr.w      #1,d4
	bcs.s      draw_horline20
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a3)+
	bra.w      draw_horline21 /* XXX */
draw_horline20:
	bfins      d1,d0{d6:d7} ; 68020+ only
	move.w     d0,(a3)+
draw_horline21:
	dbf        d5,draw_horline19
	movem.l    (a7)+,d0-d7/a0-a6
	rts
horline_params: ds.w 16

draw_vertline:
	movem.l    d0-d7/a0-a6,-(a7)
	bsr        calc_bitstartpos
	moveq.l    #1,d7
	bsr        calc_scopeaddr
	move.w     d0,d4
	swap       d4
	move.w     scope_currcolor(pc),d4
	move.w     la_planes(pc),d5
	subq.w     #1,d5
draw_vertline1:
	movem.l    d0-d7/a2-a3,-(a7)
	andi.w     #15,d1
	neg.w      d1
	addi.w     #31,d1
	move.w     d1,d6
	moveq.l    #0,d1
	move.w     scope_colormask(pc),d3
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_vertline2:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_vertline3
	swap       d4
	bclr       d4,d0
	swap       d4
	move.w     d0,(a2)+
	bra.w      draw_vertline5
draw_vertline3:
	swap       d4
	bclr       d4,d0
	btst       #0,d1
	beq.w      draw_vertline4
	bset       d4,d0
draw_vertline4:
	swap       d4
	move.w     d0,(a2)+
draw_vertline5:
	dbf        d5,draw_vertline2
	movem.l    (a7)+,d0-d7/a2-a3
	adda.w     la_bytes_line(pc),a2
	addq.w     #1,d1
	cmp.w      d1,d3
	bne.w      draw_vertline1
	movem.l    (a7)+,d0-d7/a0-a6
	rts

setpixel:
	movem.l    d0-d7/a0-a6,-(a7)
	move.w     la_planes(pc),d5
	cmpi.w     #16,d5
	beq.w      sethipixel /* XXX */
	bsr        calc_scopeaddr
	subq.w     #1,d5
	move.w     scope_currcolor(pc),d2
setpixel1:
	move.w     (a0),d1
	lsr.w      #1,d2
	bcs.s      setpixel2
	bclr       d0,d1
	bra.s      setpixel3
setpixel2:
	bset       d0,d1
setpixel3:
	move.w     d1,(a0)+
	dbf        d5,setpixel1
	movem.l    (a7)+,d0-d7/a0-a6
	rts
sethipixel:
	moveq.l    #0,d6
	move.w     la_bytes_line(pc),d6
	mulu.w     d6,d1
	movea.l    scope_screen(pc),a0
	adda.l     d1,a0
	asl.w      #1,d0
	adda.l     d0,a0
	move.w     scope_currcolor(pc),(a0)
	movem.l    (a7)+,d0-d7/a0-a6
	rts


draw_back:
	movem.l    d0-d7/a0-a6,-(a7)
	movea.l    scope_screen(pc),a0
	move.w     la_planes(pc),d5
	cmpi.w     #16,d5
	beq        drawhi_back
	bsr        calc_screenaddr
	bsr        calc_endaddr
	movea.l    x12d66(pc),a1
	subq.w     #1,d5
	move.w     la_bytes_line(pc),d6
	movea.l    a2,a4
	movea.l    a3,a5
	cmpa.l     a2,a3
	beq        draw_back8
	suba.l     a4,a5
	cmpa.w     d7,a5
	beq        draw_back12
	bsr        calc_bitstartpos
	bsr        calc_scopeaddr
	move.w     d0,d4
	swap       d4
	move.w     scope_currcolor(pc),d4
	and.w      x12d6a(pc),d1
	move.w     0(a1,d1.w*2),d3 ; 68020+ only
	movem.l    d3-d7,-(a7)
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_back1:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_back2
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
	bra.w      draw_back2_2 /* XXX */
draw_back2:
	bfins      d1,d0{d6:d7} ; 68020+ only
	swap       d4
	bset       d4,d0
	swap       d4
	move.w     d0,(a2)+
draw_back2_2:
	dbf        d5,draw_back1
	movem.l    (a7)+,d3-d7
draw_back3:
	movem.l    d3-d7,-(a7)
draw_back3_2:
	lsr.w      #1,d4
	bcs.s      draw_back4
	move.w     #0,(a2)+
	bra.w      draw_back5 /* XXX */
draw_back4:
	move.w     d3,(a2)+
draw_back5:
	dbf        d5,draw_back3_2
	movem.l    (a7)+,d3-d7
	cmpa.l     a2,a3
	bne.w      draw_back3 /* XXX */
	bsr        calc_bitendpos
	move.w     d2,d0
	bsr        calc_scopeaddr
	move.w     d0,d2
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_back6:
	move.w     (a3),d0
	lsr.w      #1,d4
	bcs.s      draw_back7
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a3)+
	bra.w      draw_back7_2 /* XXX */
draw_back7:
	bfins      d1,d0{d6:d7} ; 68020+ only
	bset       d2,d0
	move.w     d0,(a3)+
draw_back7_2:
	dbf        d5,draw_back6
	movem.l    (a7)+,d0-d7/a0-a6
	rts
draw_back8:
	move.w     d0,d6
	move.w     d2,d7
	sub.w      d6,d7
	addq.w     #1,d7
	divu.w     #16,d6
	swap       d6
	addi.w     #16,d6
	bsr        calc_scopeaddr
	move.w     d0,d4
	swap       d4
	move.w     d2,d0
	bsr        calc_scopeaddr
	move.w     d0,d2
	move.w     scope_currcolor(pc),d4
	and.w      x12d6a(pc),d1
	move.w     0(a1,d1.w*2),d3 ; 68020+ only
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_back9:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_back10
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
	bra.w      draw_back11 /* XXX */
draw_back10:
	bfins      d1,d0{d6:d7} ; 68020+ only
	swap       d4
	bset       d4,d0
	bset       d2,d0
	swap       d4
	move.w     d0,(a2)+
draw_back11:
	dbf        d5,draw_back9
	movem.l    (a7)+,d0-d7/a0-a6
	rts
draw_back12:
	bsr        calc_bitstartpos
	lea.l      drawback_params(pc),a4
	movem.w    d6-d7,(a4)
	bsr        calc_bitendpos
	movem.w    d6-d7,4(a4)
	movem.l    d0-d7/a0-a6,-(a7)
	movem.w    (a4),d6-d7
	bsr        calc_scopeaddr
	move.w     d0,d4
	swap       d4
	move.w     scope_currcolor(pc),d4
	and.w      x12d6a(pc),d1
	move.w     0(a1,d1.w*2),d3 ; 68020+ only
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_back13:
	move.w     (a2),d0
	lsr.w      #1,d4
	bcs.s      draw_back14
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a2)+
	bra.w      draw_back15 /* XXX */
draw_back14:
	bfins      d1,d0{d6:d7} ; 68020+ only
	swap       d4
	bset       d4,d0
	swap       d4
	move.w     d0,(a2)+
draw_back15:
	dbf        d5,draw_back13
	movem.l    (a7)+,d0-d7/a0-a6
	move.w     d2,d0
	bsr        calc_scopeaddr
	move.w     d0,d2
	movem.w    4(a4),d6-d7
	move.w     scope_currcolor(pc),d4
	and.w      x12d6a(pc),d1
	move.w     0(a1,d1.w*2),d3 ; 68020+ only
	moveq.l    #0,d1
	bfextu     d3{d6:d7},d1 ; 68020+ only
draw_back16:
	move.w     (a3),d0
	lsr.w      #1,d4
	bcs.s      draw_back17
	bfclr      d0{d6:d7} ; 68020+ only
	move.w     d0,(a3)+
	bra.w      draw_back18 /* XXX */
draw_back17:
	bfins      d1,d0{d6:d7} ; 68020+ only
	bset       d2,d0
	move.w     d0,(a3)+
draw_back18:
	dbf        d5,draw_back16
	movem.l    (a7)+,d0-d7/a0-a6
	rts
drawback_params: ds.w 16

drawhi_back:
	lea.l      drawhiback_ccords(pc),a0
	movem.w    d0-d3,(a0)
	movea.l    lineavars(pc),a0
	cmpi.w     #16,(a0)
	bne.w      draw_hiback3
	move.w     #3,-(a7) /* Logbase */
	trap       #14
	addq.l     #2,a7
	movea.l    d0,a0
	moveq.l    #0,d4
	moveq.l    #0,d5
	moveq.l    #0,d6
	moveq.l    #0,d7
	move.w     drawhiback_ccords+0(pc),d4
	move.w     drawhiback_ccords+2(pc),d5
	move.w     drawhiback_ccords+4(pc),d6
	move.w     drawhiback_ccords+6(pc),d7
	cmp.w      d4,d6
	bcc.s      draw_hiback1
	exg        d4,d6
draw_hiback1:
	cmp.w      d5,d7
	bcc.s      draw_hiback2
	exg        d5,d7
draw_hiback2:
	cmp.w      d5,d7
	beq.w      draw_hiback4 /* XXX */
draw_hiback3:
	nop
	movem.l    (a7)+,d0-d7/a0-a6
	rts
draw_hiback4:
	movea.l    x12d66(pc),a2
	movea.l    lineavars(pc),a1
	move.w     d4,d0
	sub.w      d4,d6
	subq.w     #2,d6
	move.w     d5,d2
	mulu.w     la_bytes_line(pc),d2
	adda.l     d2,a0
	asl.w      #1,d4
	adda.l     d4,a0
	and.w      x12d6a(pc),d5
	move.w     0(a2,d5.w*2),d3 ; 68020+ only
	move.w     scope_currcolor(pc),(a0)+
draw_hiback5:
	move.w     scope_currcolor(pc),d1
	move.w     d0,d4
	andi.w     #15,d4
	neg.w      d4
	addi.w     #15,d4
	btst       d4,d3
	bne.s      draw_hiback6
	move.w     #0,(a0)+
	bra.s      draw_hiback7
draw_hiback6:
	move.w     d1,(a0)+
draw_hiback7:
	addq.w     #1,d0
	dbf        d6,draw_hiback5
	move.w     scope_currcolor(pc),(a0)+
	movem.l    (a7)+,d0-d7/a0-a6
	rts
drawhiback_ccords: ds.w 4

calc_screenaddr:
	movem.l    d0-d6/a0-a1,-(a7)
	move.w     la_planes(pc),d5
	subq.w     #1,d5
	move.w     la_bytes_line(pc),d6
	moveq.l    #0,d7
	move.w     d0,d7
	asr.l      #4,d7
	cmpi.w     #1,d5
	beq.s      calc_screenaddr1
	cmpi.w     #3,d5
	beq.s      calc_screenaddr2
	cmpi.w     #7,d5
	beq.s      calc_screenaddr3
	movea.l    a0,a2
	moveq.l    #2,d7
	movem.l    (a7)+,d0-d6/a0-a1
	rts
calc_screenaddr1:
	asl.l      #1,d7
	bra.s      calc_screenaddr4
calc_screenaddr2:
	asl.l      #2,d7
	bra.s      calc_screenaddr4
calc_screenaddr3:
	asl.l      #3,d7
calc_screenaddr4:
	move.w     d5,d4
	addq.w     #1,d4
	asl.w      #1,d4
	mulu.w     d6,d1
	add.l      d7,d1
	add.l      d7,d1
	adda.l     d1,a0
	movea.l    a0,a2
	moveq.l    #0,d7
	move.w     d4,d7
	movem.l    (a7)+,d0-d6/a0-a1
	rts

calc_endaddr:
	movem.l    d0-d7/a0-a1,-(a7)
	move.w     la_planes(pc),d5
	subq.w     #1,d5
	move.w     la_bytes_line(pc),d6
	moveq.l    #0,d7
	move.w     d2,d7
	asr.l      #4,d7
	cmpi.w     #1,d5
	beq.s      calc_endaddr1
	cmpi.w     #3,d5
	beq.s      calc_endaddr2
	cmpi.w     #7,d5
	beq.s      calc_endaddr3
	movea.l    a0,a3
	movem.l    (a7)+,d0-d7/a0-a1
	rts
calc_endaddr1:
	asl.l      #1,d7
	bra.s      calc_endaddr4
calc_endaddr2:
	asl.l      #2,d7
	bra.s      calc_endaddr4
calc_endaddr3:
	asl.l      #3,d7
calc_endaddr4:
	mulu.w     d6,d3
	add.l      d7,d3
	add.l      d7,d3
	adda.l     d3,a0
	movea.l    a0,a3
	movem.l    (a7)+,d0-d7/a0-a1
	rts

*
* calculate bitpos in d6/d7 for bfextu
* for the starting x-coordinate
*
calc_bitstartpos:
	movem.l    d0-d5,-(a7)
	moveq.l    #16,d7
	move.w     d0,d6
	divu.w     #16,d6
	swap       d6
	sub.w      d6,d7
	addq.w     #1,d7
	addi.w     #16,d6
	movem.l    (a7)+,d0-d5
	rts

*
* calculate bitpos in d6/d7 for bfextu
* for the ending x-coordinate
*
calc_bitendpos:
	movem.l    d0-d5,-(a7)
	move.w     d2,d0
	andi.w     #0xFFF0,d0
	sub.w      d0,d2
	move.w     d2,d7
	addq.w     #1,d7
	moveq.l    #16,d6
	movem.l    (a7)+,d0-d5
	rts

calc_scopeaddr:
	movem.l    d1-d7/a1-a6,-(a7)
	move.w     la_planes(pc),d5
	subq.w     #1,d5
	move.w     la_bytes_line(pc),d6
	movea.l    scope_screen(pc),a0
	moveq.l    #0,d7
	move.w     d0,d7
	asr.l      #4,d7
	cmpi.w     #1,d5
	beq.s      calc_scopeaddr1
	cmpi.w     #3,d5
	beq.s      calc_scopeaddr2
	cmpi.w     #7,d5
	beq.s      calc_scopeaddr3
	moveq.l    #0,d0
	movem.l    (a7)+,d1-d7/a1-a6
	rts
calc_scopeaddr1:
	asl.l      #1,d7
	bra.s      calc_scopeaddr4
calc_scopeaddr2:
	asl.l      #2,d7
	bra.s      calc_scopeaddr4
calc_scopeaddr3:
	asl.l      #3,d7
calc_scopeaddr4:
	mulu.w     d6,d1
	add.l      d7,d1
	add.l      d7,d1
	adda.l     d1,a0
	andi.w     #15,d0
	neg.w      d0
	addi.w     #15,d0
	movem.l    (a7)+,d1-d7/a1-a6
	rts

set_screenaddr: /* unused */
	movem.l    d0-d7/a0-a6,-(a7)
	move.w     #3,-(a7) /* Logbase */
	trap       #14
	addq.l     #2,a7
	lea.l      scope_screen(pc),a0
	move.l     d0,(a0)
	movem.l    (a7)+,d0-d7/a0-a6
	rts

* Syntax: X=_tracker tempo()
tracker_tempo:
	move.l     (a7)+,returnpc
	move.l     snd_cookie(pc),d6
	cmpi.l     #FALCON_SND_COOKIE,d6
	bne        illfalconfunc
	tst.w      d0
	bne        syntax
	movem.l    a0-a6,-(a7)
	moveq.l    #M_trackertempo,d0
	trap       #7
	andi.l     #0x0000FFFF,d0
	move.l     d0,d3
	movem.l    (a7)+,a0-a6
	clr.l      d2
	movea.l    returnpc(pc),a0
	jmp        (a0)

	.data

musiclib_id:
	dc.b 'FALCON 030 STOS DSP/Mod 2.85',0,0
musiclib_id_end:

joined_module_id:
	dc.b 'DSP Tracker Joined Module Bank 11051953'
joined_module_id_end:	dc.b 0
generic4_id:
	dc.b generic4_id_end-generic4_id-1
	dc.b '4 Voice 15-Sample format'
generic4_id_end:
	dc.b 0
mk_id:
	dc.b mk_id_end-mk_id-1
	dc.b '4 Voice Noise/Pro-Tracker'
mk_id_end:
	dc.b 0
fa04_id:
	dc.b fa04_id_end-fa04_id-1
	dc.b '4 Voice Digital Tracker'
fa04_id_end:
	dc.b 0
flt4_id:
	dc.b flt4_id_end-flt4_id-1
	dc.b '4 Voice Startrekker v1'
flt4_id_end:
	dc.b 0
rasp_id:
	dc.b rasp_id_end-rasp_id-1
	dc.b '4 Voice Startrekker'
rasp_id_end:
	dc.b 0
fa06_id:
	dc.b fa06_id_end-fa06_id-1
	dc.b '6 Voice Digital Tracker'
fa06_id_end:
	dc.b 0
chn6_id:
	dc.b chn6_id_end-chn6_id-1
	dc.b '6 Voice FastTracker'
chn6_id_end:
	dc.b 0
flt6_id:
	dc.b flt6_id_end-flt6_id-1
	dc.b '6 Voice Startrekker'
flt6_id_end:
	dc.b 0
fa08_id:
	dc.b fa08_id_end-fa08_id-1
	dc.b '8 Voice Digital Tracker'
fa08_id_end:
	dc.b 0
chn8_id:
	dc.b chn8_id_end-chn8_id-1
	dc.b '8 Voice FastTracker'
chn8_id_end:
	dc.b 0
cd81_id:
	dc.b cd81_id_end-cd81_id-1
	dc.b '8 Voice Octalyser'
cd81_id_end:
	dc.b 0
flt8_id:
	dc.b flt8_id_end-flt8_id-1
	dc.b '8 Voice Startrekker'
flt8_id_end:
	dc.b 0
octa_id:
	dc.b octa_id_end-octa_id-1
	dc.b '8 Voice Octalyser'
octa_id_end:
	dc.b 0
	.even

notes_table:
    dc.w 113
	dc.b 'B 3',0
	dc.w 226
	dc.b 'B 2',0
	dc.w 453
	dc.b 'B 1',0
	dc.w 120
	dc.b 'A#3',0
	dc.w 240
	dc.b 'A#2',0
	dc.w 480
	dc.b 'A#1',0
	dc.w 127
	dc.b 'A 3',0
	dc.w 254
	dc.b 'A 2',0
	dc.w 508
	dc.b 'A 1',0
	dc.w 135
	dc.b 'G#3',0
	dc.w 269
	dc.b 'G#2',0
	dc.w 538
	dc.b 'G#1',0
	dc.w 143
	dc.b 'G 3',0
	dc.w 285
	dc.b 'G 2',0
	dc.w 570
	dc.b 'G 1',0
	dc.w 151
	dc.b 'F#3',0
	dc.w 302
	dc.b 'F#2',0
	dc.w 604
	dc.b 'F#1',0
	dc.w 160
	dc.b 'F 3',0
	dc.w 320
	dc.b 'F 2',0
	dc.w 640
	dc.b 'F 1',0
	dc.w 170
	dc.b 'E 3',0
	dc.w 339
	dc.b 'E 2',0
	dc.w 678
	dc.b 'E 1',0
	dc.w 180
	dc.b 'D#3',0
	dc.w 360
	dc.b 'D#2',0
	dc.w 720
	dc.b 'D#1',0
	dc.w 190
	dc.b 'D 3',0
	dc.w 381
	dc.b 'D 2',0
	dc.w 762
	dc.b 'D 1',0
	dc.w 202
	dc.b 'C#3',0
	dc.w 404
	dc.b 'C#2',0
	dc.w 808
	dc.b 'C#1',0
	dc.w 214
	dc.b 'C 3',0
	dc.w 428
	dc.b 'C 2',0
	dc.w 856
	dc.b 'C 1',0
notes_table_end:
	
	.bss

lineavars: ds.l 1 /* 12d32 */
la_bytes_line: ds.w 1 /* 12d36 */
la_planes: ds.w 1 /* 12d38 */
la_pixeloff: ds.w 1 /* 12d3a */
	.ds.l 1 /* unused */
scope_screen: ds.l 1 /* 12d40 */
scope_color: ds.w 1 /* 12d44 */
scope_x1: ds.w 1 /* 12d46 */
scope_y1: ds.w 1 /* 12d48 */
scope_x2: ds.w 1 /* 12d4a */
scope_y2: ds.w 1 /* 12d4c */
scope_ymid: ds.w 1 /* 12d4e */
scope_currx: ds.w 1
scope_curry: ds.w 1
scope_active: ds.w 1
undraw_flag: ds.w 1
cliprect: ds.w 4
scope_currcolor: ds.w 1
        ds.w 1 /* unused */
scope_colormask: ds.w 1
x12d66: ds.l 1
x12d6a: ds.w 1
        ds.l 1 /* unused */
zeroflag: ds.w 1
stringbuf: ds.b 160 /* 12d72 */ /* BUG: too short for pattern info */

load_banknum: ds.w 1 /* 12e12 */
load_faddr: ds.l 1 /* 12e14 */
load_paktype: ds.w 1 /* 12e18 */
loaded_filelength: ds.l 1 /* 12e1a */
dtaptr: ds.l 1 /* 12e1e */
filehandle: ds.w 1 /* 12e22 */
compressed_len: ds.l 1
load_filename: ds.b 128 /* 12e28 */
module_header: ds.l 13

finprg:

	ds.b 8
