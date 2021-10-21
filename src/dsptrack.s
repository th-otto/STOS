          .mc68020


        .offset 0

Amiga_Name:         ds.b      22
Amiga_Length:       ds.w      1    * Taille cod‚e en words
Amiga_Fine_Tune:    ds.b      1    * de 0 … 15  =  0 … 7 et -8 … -1
Amiga_Volume:       ds.b      1    * de 0 … 64
Amiga_Repeat_Start: ds.w      1
Amiga_Repeat_Length:ds.w      1
Amiga_Size:                        * 30 octets

	.offset 0
Voice_Sample_Length:           ds.l 1 /*  0 */
Voice_Sample_Start:            ds.l 1 /*  4 */
Voice_Sample_Offset:           ds.l 1 /*  8 */
Voice_Sample_Position:         ds.l 1 /* 12 */
Voice_Length:                  ds.l 1 /* 16 */
Voice_Sample_Repeat_Length:    ds.l 1 /* 20 */
Voice_Sample_Volume:           ds.w 1 /* 24 */
Voice_Sample_Period:           ds.w 1 /* 26 */
Voice_Sample_Fine_Tune:        ds.w 1 /* 28 */
Voice_Start:                   ds.l 1 /* 30 */
Voice_Volume:                  ds.w 1 /* 34 */
Voice_Period:                  ds.w 1 /* 36 */
Voice_Wanted_Period:           ds.w 1 /* 38 */
Voice_Note:                    ds.w 1 /* 40 */
Voice_Sample:                  ds.b 1 /* 42 */
Voice_Command:                 ds.b 1 /* 43 */
Voice_Parameters:              ds.b 1 /* 44 */
Voice_Tone_Port_Direction:     ds.b 1 /* 45 */
Voice_Tone_Port_Speed:         ds.b 1 /* 46 */
Voice_Glissando_Control:       ds.b 1 /* 47 */
Voice_Vibrato_Command:         ds.b 1 /* 48 */
Voice_Vibrato_Position:        ds.b 1 /* 49 */
Voice_Vibrato_Control:         ds.b 1 /* 50 */
Voice_Tremolo_Command:         ds.b 1 /* 51 */
Voice_Tremolo_Position:        ds.b 1 /* 52 */
Voice_Tremolo_Control:         ds.b 1 /* 53 */
Voice_Size: /* 54 */

		.text

MAX_TRACKS = 8
MAX_VOICES = 32

tacr        = $fffffa19
tadr        = $fffffa1f
iera        = $fffffa07
isra        = $fffffa0f
imra        = $fffffa13


dmainter   = $ffff8900
dmacontrol = $ffff8901
f_b_um     = $ffff8903    ;. Frame start address (high byte)
f_b_lm     = $ffff8905    ;. Frame start address (mid byte)
f_b_ll     = $ffff8907    ;. Frame start address (low byte)

f_e_um     = $ffff890f    ;. Frame end address (high byte)
f_e_lm     = $ffff8911    ;. Frame end address (mid byte)
f_e_ll     = $ffff8913    ;. Frame end address (low byte)

trackcontrol = $ffff8920
soundctrl   = $ffff8921
mwdata      = $ffff8922
mwmask      = $ffff8924
crossbarsrc = $ffff8930
crossbardst = $ffff8932
prescale    = $ffff8934
dacrec_ctl  = $ffff8936
auxa_ctl    = $ffff8938
auxb_ctl    = $ffff893a

dsp_icr     = $ffffa200 /* Interrupt Control Register */
dsp_cvr     = $ffffa201 /* command vector register */
dsp_isr     = $ffffa202 /* Interrupt Status Register */
dsp_ivr     = $ffffa203 /* Interrupt Vector Register */
TRANSLONG   = $ffffa204

; tracker status bits
STATUS_PLAYING = 0
STATUS_REPEAT  = 1
STATUS_PAUSED  = 2
STATUS_END     = 6
STATUS_INIT    = 7

sound_init_flag: dc.w 0
playing_flag: dc.w 0
pause_flag: dc.w 0
status_flags: dc.b 0,0

; TRAP #7,11
; Initialize a tracker module
; D1=ADDR
; D2=SIZE
trackerinit:
		lea.l      status_flags(pc),a1
		clr.w      (a1)
		lea.l      trackeraddr(pc),a6
		move.l     d1,(a6)
		add.l      d1,d2
		addi.l     #0x00008000,d2
		move.l     d2,trackerend-trackeraddr(a6)
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		movea.l    trackeraddr(pc),a0
		movea.l    trackerend,a1
		bsr        Init_Module
		tst.w      d0
		bmi.w      trackerinit1
		bsr        InitDsp
		tst.w      d0
		bmi.w      trackerinit1
		bsr        save_dmasound
		bsr        init_dmasound
		moveq.l    #1,d0
		bsr        calc_prescale
		st         loopstart_flag
		bsr        start_playing
		move.w     #-1,playing_flag
		move.w     #-1,sound_init_flag
		move.w     #0,pause_flag
		/* moveq.l     #-1,d0 */
		dc.w 0x203c,-1,-1 /* XXX */
		rts
trackerinit1:
		move.w     #0,sound_init_flag
		clr.l      d0
		rts


; TRAP #7,12
; Reset the falcon sound hardware
soundreset:
		tst.w      sound_init_flag
		beq.s      soundreset2
		tst.w      playing_flag
		beq.s      soundreset1
		bsr        stop_timer_a
		bsr        restore_dmasound
soundreset1:
		nop
		move.w     #0,sound_init_flag
		move.w     #0,playing_flag
		move.w     #0,pause_flag
soundreset2:
		rts


; TRAP #7,13
trackerplay:
		tst.w      sound_init_flag
		beq.s      trackerplay1
		tst.w      pause_flag
		bne.s      trackerplay2
		tst.w      playing_flag
		bne.s      trackerplay1
		lea.l      status_flags(pc),a1
		clr.w      (a1)
		moveq.l    #1,d0
		bsr        start_playing
		move.w     #-1,playing_flag
		move.w     #0,pause_flag
trackerplay1:
		rts
trackerplay2:
		bsr        stop_playing
		move.w     #0,pause_flag
		move.w     #-1,playing_flag
		rts


; TRAP #7,14
trackerloop:
		rts

trackerloop0:
		tst.w      sound_init_flag
		beq.s      trackerloop1
		tst.w      playing_flag
		beq.s      trackerloop1
		move.b     d1,loopstart_flag
		clr.b      looprestart_flag
trackerloop1:
		rts


; TRAP #7,15
trackerffwd:
		tst.w      sound_init_flag
		beq.s      trackerffwd1
		tst.w      playing_flag
		beq.s      trackerffwd1
		bsr        song_next
trackerffwd1:
		rts


; TRAP #7,16
trackerpause:
		tst.w      sound_init_flag
		beq.s      trackerpause1
		bsr        stop_playing
		move.w     #-1,pause_flag
		move.w     #0,playing_flag
trackerpause1:
		rts

; TRAP #7,17
trackerstop:
		tst.w      sound_init_flag
		beq.s      trackerstop1
		lea.l      status_flags(pc),a1
		clr.w      (a1)
		bsr        stop_timer_a
		move.w     #0,playing_flag
		move.w     #0,pause_flag
trackerstop1:
		rts

; TRAP #7,18
; D1=speed (0-5)
trackerspeed:
		lea.l      speed_table(pc),a0
		andi.l     #7,d1
		cmpi.w     #5,d1
		bcc.s      trackerspeed1
		asl.w      #1,d1
		move.w     0(a0,d1.w),d0
		bsr        calc_prescale
trackerspeed1:
		rts
speed_table: dc.w 1,2,3,4,5,7,9,11


; TRAP #7,23
trackersongprev:
		tst.w      sound_init_flag
		beq.s      trackersongprev1
		moveq.l    #45,d0
		bsr        song_prev
trackersongprev1:
		rts


; TRAP #7,24
trackersongnext:
		tst.w      sound_init_flag
		beq.s      trackersongnext1
		moveq.l    #43,d0 /* XXX FIXME: unused */
		bsr        song_next
trackersongnext1:
		rts


; TRAP #7,19
trackersongpos:
		move.w     Song_Position(pc),d0
		andi.l     #$FF,d0
		rts


; TRAP #7,20
trackerpattpos:
		move.w     Pattern_Position(pc),d0
		andi.l     #$3F,d0
		rts


; TRAP #7,21
; D1=voice
trackervu:
		tst.w      sound_init_flag
		beq.w      trackervu5
		move.w     Voices_Nb(pc),d7
		andi.l     #0x0000003F,d1
		cmp.w      d1,d7
		bcs.w      trackervu5
		lea.l      Voices(pc),a6
		moveq.l    #1,d2
trackervu1:
		cmp.w      d2,d1
		beq.s      trackervu2
		lea.l      Voice_Size(a6),a6
		addq.w     #1,d2
		bra.s      trackervu1
trackervu2:
		tst.l      Voice_Sample_Start(a6)
		beq.s      trackervu3
		tst.w      Voice_Note(a6)
		beq.s      trackervu3
		moveq.l    #0,d1
		move.w     Voice_Sample_Period(a6),d1
		neg.w      d1
		addi.w     #1234,d1
		tst.w      d1
		beq.s      trackervu3
		move.w     Voice_Volume(a6),d0
		andi.l     #0x0000007F,d0
		lea.l      vubuffer(pc),a5
		subq.w     #1,d2
		move.w     d0,0(a5,d2.w*4) ; 68020+ only
		move.w     d0,2(a5,d2.w*4) ; 68020+ only
		rts
trackervu3:
		lea.l      vubuffer(pc),a5
		subq.w     #1,d2
		move.w     2(a5,d2.w*4),d0 ; 68020+ only
		.IFNE COMPILER
		subq.w     #4,d0 /* hmpf? why diffrent check? */
		.ELSE
		subq.w     #2,d0
		.ENDC
		bpl.s      trackervu4
		moveq.l    #0,d0
trackervu4:
		move.w     d0,2(a5,d2.w*4) ; 68020+ only
		bsr.w      calcvu
		rts
trackervu5:
		moveq.l    #0,d0
		lea.l      vubuffer(pc),a5
		subq.w     #1,d2 ; BUG: d2 not set here
		move.w     d0,0(a5,d2.w*4) ; 68020+ only
		move.w     d0,2(a5,d2.w*4) ; 68020+ only
		bsr.w      calcvu
		rts

calcvu:
		move.w     Voices_Nb(pc),d7
		subq.w     #1,d7
calcvu1:
		move.l     (a5)+,d6
		tst.w      d6
		bne.s      calcvu3
		dbf        d7,calcvu1
		lea.l      vu_active(pc),a0
		move.w     #-1,(a0)
		lea.l      scopebuffer(pc),a5
		move.w     #1024-1,d7
calcvu2:
		move.l     #0,(a5)+
		dbf        d7,calcvu2
		lea.l      vu_max(pc),a5
		move.w     #64,(a5)
calcvu3:
		rts

vubuffer: ds.w MAX_TRACKS*2


; TRAP #7,22
; D1=voice
trackerspectrum:
		tst.w      sound_init_flag
		beq.s      trackerspectrum4
		move.w     Voices_Nb(pc),d7
		andi.l     #0x0000003F,d1
		cmp.w      d1,d7
		bcs.s      trackerspectrum4
		lea.l      vubuffer(pc),a5
		subq.w     #1,d1
		tst.w      2(a5,d1.w*4) ; 68020+ only
		beq.s      trackerspectrum4
		lea.l      Voices(pc),a6
trackerspectrum1:
		tst.w      d1
		beq.s      trackerspectrum2
		lea.l      Voice_Size(a6),a6
		subq.w     #1,d1
		bra.s      trackerspectrum1
trackerspectrum2:
		moveq.l    #0,d0
		move.w     Voice_Note(a6),d0
		tst.w      d0
		bne.s      trackerspectrum3
		move.w     Voice_Sample_Period(a6),d0
		neg.w      d0
		addi.w     #1234,d0
trackerspectrum3:
		rts
trackerspectrum4:
		moveq.l    #0,d0
		rts


; TRAP #7,25
trackerstatus:
		lea.l      status_flags,a1
		cmpi.w     #-1,(a1)
		beq.s      trackerstatus2
		move.w     Song_Position(pc),d0
		bne.s      trackerstatus1
		tst.b      1(a1)
		beq.s      trackerstatus2
		move.b     #-1,status_flags-status_flags(a1)
		bra.s      trackerstatus2
trackerstatus1:
		move.b     #-1,1(a1)
trackerstatus2:
		move.w     (a1),d0
		andi.l     #0x0000FFFF,d0
		rts


; TRAP #7,26
trackerscopedraw:
		lea.l      scopebuffer(pc),a0
		move.w     vu_active(pc),d0
		tst.w      d0
		beq.s      trackerscopedraw1
		move.w     vu_max(pc),d0
trackerscopedraw1:
		rts


; TRAP #7,27
trackerscopeundraw:
		lea.l      vu_active(pc),a0
		move.w     #0,(a0)
		rts


; TRAP #7,28
trackerpattinfo:
		tst.w      sound_init_flag
		beq.s      trackerpattinfo1
		moveq.l    #0,d7
		move.w     Voices_Nb(pc),d7
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     Song_Position(pc),d2
		andi.l     #0x000000FF,d2
		move.w     Pattern_Position(pc),d3
		andi.l     #63,d3
		movea.l    Patterns_Adr(pc),a0
		move.w     Line_Size(pc),d4
		move.w     Pattern_Length(pc),d5
		mulu.w     d4,d5
		mulu.w     d2,d5
		mulu.w     d3,d4
		add.l      d4,d5
		adda.l     d5,a0
		move.l     d7,d0
		subq.w     #1,d0
		rts
trackerpattinfo1:
		/* moveq.l     #-1,d0 */
		dc.w 0x203c,-1,-1 /* XXX */
		rts


; TRAP #7,29
trackertempo:
		tst.w      sound_init_flag
		beq.s      trackertempo1
		moveq.l    #0,d0
		move.w     Tempo(pc),d0   /* Tempo & Speed */
		rts
trackertempo1:
		/* moveq.l     #0,d0 */
		dc.w 0x203c,0,0 /* XXX */
		rts

	.IFEQ COMPILER
trackeraddr: dc.l 0
trackerend: dc.l 0
	.ENDC

calc_prescale:
		move.w     d0,prescale_value
		move.l     #98340,d1
		addq.w     #1,d0
		divu.w     d0,d1
		move.w     d1,dsp_sample_period
		rts


start_playing:
		movem.l    d3-d7/a2-a6,-(a7)
		move.b     #125,Tempo
		move.b     #6,Speed
		move.b     #6,Play_Counter
		bsr        calc_timer_params
		move.w     #0,Song_Position
		move.w     #-1,Pattern_Position
		sf         Pattern_Loop_Flag
		clr.w      Pattern_Loop_Counter
		clr.w      Pattern_Loop_Position
		sf         Pattern_Break_Flag
		clr.w      Pattern_Break_Position
		sf         Position_Jump_Flag
		clr.w      Position_Jump_Pos
		clr.b      Pattern_Delay_Time
		bsr        clear_voices
		sf         dsp_rec_flag
		sf         dsp_rec_flag2
		clr.w      dsp_counter
		sf         timer_a_flag
		sf         stop_flag
		movem.l    (a7)+,d3-d7/a2-a6
		bra        enable_timer_a

stop_playing:
		tst.b      stop_flag(pc)
		bne.s      stop_playing1
		tst.b      timer_a_flag(pc)
		seq        timer_a_flag
		tst.b      timer_a_flag(pc)
		bne        disable_timer_a
		bra        enable_timer_a
stop_playing1:
		rts


stop_timer_a:
		sf         timer_a_flag
		st         stop_flag
		bra        disable_timer_a

song_set:
		cmp.w      Song_Length(pc),d0
		bcs.s      song_set1
		moveq.l    #0,d0
song_set1:
		move.w     d0,Position_Jump_Pos
		st         Position_Jump_Flag
		rts

song_prev:
		move.w     Song_Position(pc),d0
		beq.s      song_prev1
		subq.w     #1,d0
song_prev1:
		move.w     d0,Position_Jump_Pos
		st         Position_Jump_Flag
		rts

song_next:
		move.w     Song_Position(pc),d0
		cmp.w      Song_Length,d0
		beq.s      song_next1
		addq.w     #1,d0
song_next1:
		move.w     d0,Position_Jump_Pos
		st         Position_Jump_Flag
		rts

		rts

		movem.l    d3-d4/d7/a5-a6,-(a7)
		bsr.s      clear_voices
		movem.l    (a7)+,d3-d4/d7/a5-a6
		rts

clear_voices:
		lea.l      voice_init_tab(pc),a5
		move.w     #1234,d4
		lea.l      dsp_voices(pc),a6
		moveq.l    #MAX_VOICES+4-1,d7
clear_a_voice:
		move.l     (a5)+,(a6)+	/* Voice_Sample_Length */
		clr.l      (a6)+	/* Voice_Sample_Start */
		clr.l      (a6)+	/* Voice_Sample_Offset */
		clr.l      (a6)+	/* Voice_Sample_Position */
		clr.l      (a6)+	/* Voice_Length */
		clr.l      (a6)+	/* Voice_Sample_Repeat_Length */
		clr.w      (a6)+	/* Voice_Sample_Volume */
		move.w     d4,(a6)+ /* Voice_Sample_Period */
		clr.w      (a6)+    /* Voice_Sample_Fine_Tune */
		clr.l      (a6)+    /* Voice_Start */
		clr.w      (a6)+	/* Voice_Volume */
		move.w     d4,(a6)+ /* Voice_Period */
		clr.w      (a6)+	/* Voice_Wanted_Period */
		clr.l      (a6)+	/* Voice_Note/Voice_Sample/Voice_Command */
		clr.l      (a6)+	/* Voice_Parameters/Voice_Tone_Port_Direction/Voice_Tone_Port_Speed/Voice_Glissando_Control */
		clr.l      (a6)+	/* Voice_Vibrato_Command/Voice_Vibrato_Position/Voice_Vibrato_Control/Voice_Tremolo_Command */
		clr.w      (a6)+	/* Voice_Tremolo_Position/Voice_Tremolo_Control */
		dbf        d7,clear_a_voice
		rts


Init_Module:
		movem.l    d3-d7/a2-a6,-(a7)
		sf         timer_a_flag
		st         stop_flag
		move.w     #-1,dsp_lengthl
		move.w     #-1,dsp_lengthr
		move.l     a0,Module
		move.l     a1,workspace
		lea.l      20+31*30+2(a0),a5        ; default
		lea.l      4+128(a5),a6             ; Type
		moveq.l    #31,d0                   ; 31 instruments
		moveq.l    #64,d2                   ; lines per pattern
		sf         Old_Module

		move.l     1080(a0),d3              ; ModFile Chunk

; Formats 4 voices
		moveq.l    #4,d1
		cmp.l      #0x4D2E4B2E,d3           ; "M.K."
		beq        Format_Ok
		cmp.l      #0x4D214B21,d3           ; "M!K!"
		beq        Format_Ok
		cmp.l      #0x4D264B26,d3           ; "M&K&"
		beq        Format_Ok
		cmp.l      #0x46413034,d3           ; "FA04"
		beq.s      Format_Digital
		cmp.l      #0x464C5434,d3           ; "FLT4"
		beq.s      Format_Ok
		cmp.l      #0x52415350,d3           ; "RASP"
		beq.s      Format_Ok

; Formats 6 voices
		moveq.l    #6,d1
		cmp.l      #0x46413036,d3           ; "FA06"
		beq.s      Format_Digital
		cmp.l      #0x3643484E,d3           ; "6CHN"
		beq.s      Format_Ok
		.IFNE 0 /* XXX */
        cmp.l     #"FLT6",d3
        beq.s     Format_Ok
        .ENDC

; Formats 8 voices
		moveq.l    #8,d1
		cmp.l      #0x46413038,d3           ; "FA08"
		beq.s      Format_Digital
		cmp.l      #0x3843484E,d3           ; "8CHN"
		beq.s      Format_Ok
		cmp.l      #0x43443831,d3           ; "CD81"
		beq.s      Format_Ok
		cmp.l      #0x464C5438,d3           ; "FLT8"
		beq.s      Format_Ok
		cmp.l      #0x4F435441,d3           ; "OCTA"
		beq.s      Format_Ok
		cmp.w      #0x4348,d3
		bne.s      Format_Old
		subi.l     #0x30300000,d3
		rol.l      #8,d3
		move.b     d3,d1
		ext.w      d1
		mulu.w     #10,d1
		rol.l      #8,d3
		add.b      d3,d1
		bra.s      Format_Ok

; If nothing special then it is an old 15 instrument module
Format_Old:
		lea.l      20+15*30+2(a0),a5
		lea.l      128(a5),a6
		moveq.l    #15,d0
		moveq.l    #4,d1
		st         Old_Module
		bra.s      Format_Ok

Format_Digital:
		move.w     (a6)+,d2
		addq.l     #2,a6
Format_Ok:
		move.l     a5,Sequence_Adr  ; Sequence address
		move.l     a6,Patterns_Adr  ; Pattern address
		move.w     d0,Samples_Nb    ; Number of instruments
		move.w     d1,Voices_Nb     ; Number of voices
		move.w     d2,Pattern_Length
		lsl.w      #2,d1
		move.w     d1,Line_Size     ; Size of a 'row'
		mulu.w     d2,d1
		move.w     d1,Pattern_Size  ; Size of a pattern
		move.b     -2(a5),d0
		move.w     d0,Song_Length   ; Module length 
		move.b     -1(a5),d2
		cmp.b      d0,d2
		bcs.s      Restart_Ok
		moveq.l    #0,d2
Restart_Ok:
		move.w     d2,Song_Restart

		moveq.l    #127,d0                  ; Browse the sequence
		moveq.l    #0,d1                    ; until ... the last position
Sequence_Loop:
		move.b     (a5)+,d2                 ; No Pattern
		cmp.b      d1,d2                    ; Greater than the maximum?
		bcs.s      Seq_No_Max
		move.b     d2,d1
Seq_No_Max:
		dbf        d0,Sequence_Loop
		addq.w     #1,d1                    ; Number of patterns
		mulu.w     Pattern_Size(pc),d1      ; total size
		movea.l    Patterns_Adr(pc),a1      ; start address of samples
		lea.l      0(a1,d1.l),a1
		lea.l      20(a0),a2                ; ptr to Sample 1
		moveq.l    #0,d1
		move.w     Samples_Nb(pc),d7
		subq.w     #1,d7
sTotal_Length:
		moveq.l    #0,d3                    ; length of sample
		move.w     Amiga_Length(a2),d3
		add.l      d3,d3                    ; * 2 because stored ?in words
		add.l      d3,d1                    ; Add to total
		lea.l      Amiga_Size(a2),a2        ; Next instrument
		dbf        d7,sTotal_Length

		movea.l    workspace(pc),a4
		lea.l      0(a1,d1.l),a3
sMove_Samples:
		move.w     -(a3),-(a4)
		subq.l     #2,d1
		bne.s      sMove_Samples

		lea.l      20(a0),a0                ; Point on 1st Sample
		lea.l      Samples_Adr(pc),a2       ; Sample address
		move.w     Samples_Nb(pc),d7
		subq.w     #1,d7
sNext_Sample:
		clr.l      (a2)+                    ; Note Adresse
		move.w     Amiga_Length(a0),d3      ; length zero?
		beq.s      sNextSample              ; So no instrument
		move.l     a1,-4(a2)                ; Note Adresse
		move.w     Amiga_Repeat_Length(a0),d5 ; length of loop
		cmp.w      #1,d5                    ; greater than 1?
		bhi.s      sRepeat_Length           ; So there is a loop
		subq.w     #1,d3
sCopy_1:
		move.w     (a4)+,(a1)+              ; Simply copy the sample
		dbf        d3,sCopy_1
		move.w     #168-1,d0
sCopy_2:
		clr.l      (a1)+                    ; and empties afterwards because it does not loop
		dbf        d0,sCopy_2
		clr.w      Amiga_Repeat_Start(a0)
		clr.w      Amiga_Repeat_Length(a0)
		bra.s      sNextSample
sRepeat_Length:
		move.w     Amiga_Repeat_Start(a0),d4
		beq.s      sNo_Repeat_Start
		move.w     d4,d0
		subq.w     #1,d0
sCopy_4:
		move.w     (a4)+,(a1)+
		dbf        d0,sCopy_4
sNo_Repeat_Start:
		movea.l    a1,a3
		move.w     d5,d0
		subq.w     #1,d0
sCopy_5:
		move.w     (a4)+,(a1)+
		dbf        d0,sCopy_5
		move.w     #336-1,d0
sCopy_6:
		move.w     (a3)+,(a1)+
		dbf        d0,sCopy_6
		sub.w      d5,d3
		sub.w      d4,d3
		lea.l      0(a4,d3.w*2),a4 ; 68020+ only
		add.w      d5,d4
		move.w     d4,Amiga_Length(a0)
		move.w     d5,Amiga_Repeat_Length(a0)
sNextSample:
		cmpa.l     a4,a1
		bhi.s      Init_Module_Err
		lea.l      Amiga_Size(a0),a0
		dbf        d7,sNext_Sample
		move.l     a1,end_of_samples
		bsr        clear_voices
		movem.l    (a7)+,d3-d7/a2-a6
		moveq.l    #0,d0
		rts
Init_Module_Err:
		movem.l    (a7)+,d3-d7/a2-a6
		moveq.l    #-3,d0
		rts


InitDsp:
		pea.l      (a2)
		bsr.s      InitDsp0
		movea.l    (a7)+,a2
		move.l     dsp_error(pc),d0
		rts

InitDsp0:
		move.w     #$0071,-(a7) /* Dsp_RequestUniqueAbility */
		trap       #14
		addq.l     #2,a7
		move.w     d0,-(a7)
		pea.l      ((DSP_End-DSP_Code)/3).w   ; Length in DSP Words
		pea.l      DSP_Code(pc)               ; Binary code address
		move.w     #0x006D,-(a7)			  ; Dsp_ExecProg
		trap       #14
		lea.l      12(a7),a7
		move.l     #87654321,(TRANSLONG).w
		moveq.l    #0,d0
Conct_Get:
		btst       #0,(dsp_isr).w
		bne.s      DSP_Test
		addq.l     #1,d0
		cmp.l      #100000,d0
		beq.s      DSP_Error
		bra.s      Conct_Get
DSP_Test:
		move.l     (TRANSLONG).w,d0
		cmp.l      #12345678,d0
		move.l     #0,dsp_error
		rts
DSP_Error:
		move.l     #-1,dsp_error
		rts

dsp_error: dc.l 0


dsploadprog:
		lea.l      (TRANSLONG).w,a1
		move.b     #0x92,dsp_cvr-TRANSLONG(a1)
dsploadprog_1:
		tst.b      dsp_cvr-TRANSLONG(a1)
		bmi.s      dsploadprog_1
dsploadprog_2:
		btst       #0,(dsp_isr).w
		beq.s      dsploadprog_2
		move.l     (a1),d1
		andi.l     #0x00FFFFFF,d1
		cmp.l      #0x00503536,d1 /* 'P56' */
		bne.s      dsploadprog_2
		subq.w     #1,d0
dsploadprog_3:
		moveq.l    #0,d1
		move.b     (a0)+,d1
		swap       d1
		move.w     (a0)+,d1
dsploadprog_4:
		btst       #1,(dsp_isr).w
		beq.s      dsploadprog_4
		move.l     d1,(a1)
		dbf        d0,dsploadprog_3
dsploadprog_5:
		btst       #1,(dsp_isr).w
		beq.s      dsploadprog_5
		move.l     #-1,(a1)
		rts


init_dmasound:
		pea.l      (a2)           ; FIXME: useless, a2 not modified below
		bsr.s      init_dmasound0
		movea.l    (a7)+,a2
		rts
init_dmasound0:
* Stops DMA playback in case ?...
		clr.b      (dmacontrol).w
* DAC on track 0 (loud quartet)
		move.b     #0x0F,(trackcontrol).w
* Source DSP-Xmit on Internal Clock 25.175 MHz, DSP connected
* Source DMA-Play on Internal Clock 25.175 MHz 
		move.b     #0x11,(crossbarsrc).w
		move.b     #0x11,(crossbarsrc+1).w
* DAC, DMA-Record and External OutPut destinations
* connected to Source DSP-Xmit, Handshaking On
* DSP-Rec destination connected to DMA-Play, DSP connected (Enable)
		move.b     #0x33,(crossbardst).w
		move.b     #0x13,(crossbardst+1).w
* Frequency 49169 Hz
		move.b     #0x02,(dacrec_ctl+1).w
		rts

save_dmasound:
		pea.l      (a2)          /* FIXME: useless, a2 not modified below */
		bsr.s      save_dmasound0
		movea.l    (a7)+,a2
		rts
save_dmasound0:
		lea.l      dmaregs(pc),a0
		move.w     (dmainter).w,(a0)+
		bclr       #7,(dmacontrol).w /* select replay register */
		move.b     (f_b_um).w,(a0)+
		move.b     (f_b_lm).w,(a0)+
		move.b     (f_b_ll).w,(a0)+
		move.b     (f_e_um).w,(a0)+
		move.b     (f_e_lm).w,(a0)+
		move.b     (f_e_ll).w,(a0)+
		bset       #7,(dmacontrol).w /* select record register */
		move.b     (f_b_um).w,(a0)+
		move.b     (f_b_lm).w,(a0)+
		move.b     (f_b_ll).w,(a0)+
		move.b     (f_e_um).w,(a0)+
		move.b     (f_e_lm).w,(a0)+
		move.b     (f_e_ll).w,(a0)+
		move.w     (trackcontrol).w,(a0)+
		move.w     (crossbarsrc).w,(a0)+
		move.w     (crossbardst).w,(a0)+
		move.w     (prescale).w,(a0)+
		move.w     (dacrec_ctl).w,(a0)+
		move.w     (auxa_ctl).w,(a0)+
		move.w     (auxb_ctl).w,(a0)+
		rts

restore_dmasound:
		pea.l      (a2)          /* FIXME: useless, a2 not modified below */
		bsr.s      restore_dmasound0
		movea.l    (a7)+,a2
		rts
restore_dmasound0:
		lea.l      dmaregs(pc),a0
		move.w     (a0)+,d0
		bclr       #7,(dmacontrol).w /* select replay register */
		move.b     (a0)+,(f_b_um).w
		move.b     (a0)+,(f_b_lm).w
		move.b     (a0)+,(f_b_ll).w
		move.b     (a0)+,(f_e_um).w
		move.b     (a0)+,(f_e_lm).w
		move.b     (a0)+,(f_e_ll).w
		bset       #7,(dmacontrol).w /* select record register */
		move.b     (a0)+,(f_b_um).w
		move.b     (a0)+,(f_b_lm).w
		move.b     (a0)+,(f_b_ll).w
		move.b     (a0)+,(f_e_um).w
		move.b     (a0)+,(f_e_lm).w
		move.b     (a0)+,(f_e_ll).w
		move.w     d0,(dmainter).w
		move.w     (a0)+,(trackcontrol).w
		move.w     (a0)+,(crossbarsrc).w
		move.w     (a0)+,(crossbardst).w
		move.w     (a0)+,(prescale).w
		move.w     (a0)+,(dacrec_ctl).w
		move.w     (a0)+,(auxa_ctl).w
		move.w     (a0)+,(auxb_ctl).w
		move.b     #0x94,(dsp_cvr).w /* trigger HC $14 */
		rts

dmaregs: dc.w 0 /* interrupt & control */
        dc.b 0,0,0 /* frame replay start */
        dc.b 0,0,0 /* frame replay end */
        dc.b 0,0,0 /* frame record start */
        dc.b 0,0,0 /* frame record end */
        dc.w 0 /* track control */
        dc.w 0 /* crossbar source */
        dc.w 0 /* crossbar dest */
        dc.w 0 /* prescale */
        dc.w 0 /* dacrec_ctl */
        dc.w 0 /* auxa_ctl */
        dc.w 0 /* auxb_ctl */


enable_timer_a:
		pea.l      (a2)
		pea.l      timer_a(pc)
		moveq.l    #0,d0
		move.b     IT_Timer_Data(pc),d0
		move.w     d0,-(a7)
		move.b     IT_Timer_Control(pc),d0
		move.w     d0,-(a7)
		clr.w      -(a7)
		move.w     #0x001F,-(a7)
		trap       #14
		lea.l      12(a7),a7
		bsr.s      connect_dsp
		movea.l    (a7)+,a2
		rts
connect_dsp:
		bset       #7,(crossbarsrc+1).w
		rts

disable_timer_a:
		pea.l      (a2)
		clr.l      -(a7)
		clr.l      -(a7)
		clr.w      -(a7)
		move.w     #0x001F,-(a7)
		trap       #14
		lea.l      12(a7),a7
		bsr.s      disconnect_dsp
		movea.l    (a7)+,a2
		rts
disconnect_dsp:
		bclr       #7,(crossbarsrc+1).w
		rts

timer_a:
		move.w     #0x2700,sr
		move.b     IT_Timer_Data(pc),(tadr).w
		move.b     IT_Timer_Control(pc),(tacr).w
		tst.b      dsp_rec_flag(pc)
		beq.s      timer_a1
		addq.w     #1,dsp_counter
		bclr       #5,(isra).w
		rte
timer_a1:
		move.b     #0x93,(dsp_cvr).w /* trigger HC $13 */
		movem.l    d0/a6,-(a7)
		lea.l      (TRANSLONG).w,a6
		move.l     (a6),d0
		cmp.l      #0x004D4754,d0 /* 'MGT' */
		beq.s      timer_a2
		st         dsp_rec_flag2
		bra.s      timer_a3
timer_a2:
		st         dsp_rec_flag
		clr.w      (a6)
		move.w     dsp_lengthl(pc),2(a6)
		move.w     dsp_lengthr(pc),2(a6)
		move.w     Voices_Nb(pc),2(a6)
		move.l     #dsp_voices,dsp_voice
* install DSP interrupt
		move.l     #dspinter,(0x03FC).w
* set DSP interrupt vector
		move.b     #0xFF,dsp_ivr-TRANSLONG(a6)
* enable interrupts
		bset       #0,dsp_icr-TRANSLONG(a6)
timer_a3:
		movem.l    (a7)+,d0/a6
		bclr       #5,(isra).w
		rte


dspinter:
		movem.l    d0-d3/a0/a5-a6,-(a7)
		lea.l      (TRANSLONG).w,a6
* disable interrupts
		bclr       #0,dsp_icr-TRANSLONG(a6)
dspinter1:
		move.w     2(a6),d0
		beq        dspinter10
		movea.l    dsp_voice(pc),a5
		move.l     Voice_Sample_Length+dsp_voice-dsp_voice(a5),d0 /* XXX */
		add.l      d0,dsp_voice
		tst.l      Voice_Sample_Start(a5)
		bne.s      dspinter4
dspinter2:
		clr.l      (a6)
dspinter3:
		btst       #0,(dsp_isr).w
		beq.s      dspinter3
		bra.s      dspinter1
dspinter4:
		moveq.l    #0,d0
		move.w     Voice_Sample_Volume(a5),d0
		beq.s      dspinter2
		move.l     d0,(a6)

; Send relative frequency
		move.l     #6990,d1
		moveq.l    #0,d0
		move.w     dsp_sample_period(pc),d2
		mulu.w     Voice_Sample_Period(a5),d2
		divu.l     d2,d1:d0 ; 68020+ only
		lsr.l      #1,d0
		move.l     d0,(a6)
dspinter5:
		btst       #0,(dsp_isr).w
		beq.s      dspinter5
		move.l     (a6),d0
		movea.l    Voice_Sample_Start(a5),a0
		move.l     Voice_Sample_Position(a5),d1
		move.l     d1,d2
		add.l      d0,d2
		tst.l      Voice_Sample_Repeat_Length(a5)
		bne.s      dspinter6
		cmp.l      Voice_Length(a5),d2
		blt.s      dspinter7
		clr.l      Voice_Sample_Start(a5)
		bra.s      dspinter7
dspinter6:
		cmp.l      Voice_Length(a5),d2
		blt.s      dspinter7
		sub.l      Voice_Sample_Repeat_Length(a5),d2
		bra.s      dspinter6
dspinter7:
		move.l     d2,Voice_Sample_Position(a5)
		lea.l      0(a0,d1.l),a0
		lsr.w      #1,d0
		addq.l     #2,a6
		move.w     d0,vu_max
		lea.l      scopebuffer(pc),a5
dspinter8:
		move.w     (a0)+,d1
		tst.w      vu_active
		bne.s      dspinter9
		move.w     d1,(a5)+
dspinter9:
		move.w     d1,(a6)
		dbf        d0,dspinter8
		move.w     #-1,vu_active
		move.w     #0,x12d78
		bset       #0,dsp_icr-2-TRANSLONG(a6) /* -2 because incremented above */
		movem.l    (a7)+,d0-d3/a0/a5-a6
		rte
dspinter10:
		move.b     prescale_value+1(pc),(prescale+1).w
		sf         dsp_rec_flag
		move.w     period_count(pc),d0
		addq.w     #1,d0
		move.w     d0,period_count
		cmp.w      period_shift(pc),d0
		bcs.s      dspinter11
		clr.w      period_count
		movem.l    d4-d7/a1-a4,-(a7)
		bsr.s      Play_Patterns
		movem.l    (a7)+,d4-d7/a1-a4
dspinter11:
		movem.l    (a7)+,d0-d3/a0/a5-a6
		rte

dsp_voice: dc.l 0

Play_Patterns:
		addq.b     #1,Play_Counter
		move.b     Play_Counter(pc),d0
		cmp.b      Speed(pc),d0
		bcs        No_New_Note
		clr.b      Play_Counter
		tst.b      Pattern_Break_Flag(pc)
		bne.s      New_Pattern
		tst.b      Pattern_Delay_Time(pc)
		beq.s      No_Delay
		subq.b     #1,Pattern_Delay_Time
		bra        No_New_Note
No_Delay:
		tst.b      Pattern_Loop_Flag(pc)
		beq.s      No_Pattern_Loop
		move.w     Pattern_Loop_Position(pc),Pattern_Position
		sf         Pattern_Loop_Flag
		bra        New_Notes
No_Pattern_Loop:
		tst.b      Position_Jump_Flag(pc)
		beq.s      New_Line
		move.w     Position_Jump_Pos(pc),d0
		sf         Position_Jump_Flag
		clr.w      Pattern_Break_Position
		bra.s      New_Position
New_Line:
		addq.w     #1,Pattern_Position
		move.w     Pattern_Position(pc),d0
		cmp.w      Pattern_Length(pc),d0
		bcs.s      New_Notes
New_Pattern:
		move.w     Song_Position(pc),d0
		addq.w     #1,d0
New_Position:
		move.w     Pattern_Break_Position(pc),Pattern_Position
		clr.w      Pattern_Break_Position
		sf         Pattern_Break_Flag
		cmp.w      Song_Length(pc),d0
		bcs.s      No_Restart
		move.w     Song_Restart(pc),d0
		bne.s      New_Position1
		move.b     #125,Tempo
		move.b     #6,Speed
		bsr        calc_timer_params
New_Position1:
		tst.b      loopstart_flag(pc)
		bne.s      No_Restart
		st         looprestart_flag
		sf         timer_a_flag
		st         stop_flag
		clr.b      (tacr).w
		bclr       #5,(iera).w
		bclr       #5,(imra).w
		bclr       #7,(crossbarsrc+1).w
No_Restart:
		move.w     d0,Song_Position
New_Notes:
		movea.l    Module(pc),a5
		adda.w     #20,a5           ; ; Ptr to sample info 
		movea.l    Sequence_Adr(pc),a0
		move.w     Song_Position(pc),d1
		moveq.l    #0,d0
		move.b     0(a0,d1.w),d0
		mulu.w     Pattern_Size(pc),d0
		movea.l    Patterns_Adr(pc),a4
		adda.l     d0,a4
		move.w     Pattern_Position(pc),d0
		mulu.w     Line_Size(pc),d0
		adda.w     d0,a4
		lea.l      Voices(pc),a6
		move.w     Voices_Nb(pc),d7
		subq.w     #1,d7
New_Notes_Loop:
		bsr.s      Play_Voice
		lea.l      Voice_Size(a6),a6
		dbf        d7,New_Notes_Loop
		rts
No_New_Note:
		lea.l      Voices(pc),a6
		move.w     Voices_Nb(pc),d7
		subq.w     #1,d7
No_New_Note_Loop:
		moveq.l    #0,d0
		move.b     Voice_Command(a6),d0
		.IFNE 0
        bsr        Simplet_Check_Efx_2
		.ELSE
		jsr        ([Jump_Table_2,d0.w*4])
		.ENDC
		lea.l      Voice_Size(a6),a6
		dbf        d7,No_New_Note_Loop
		rts


Play_Voice:
		move.w     (a4)+,d1
		move.b     (a4)+,d2
		move.b     (a4)+,Voice_Parameters(a6)
		move.w     d1,d0
		andi.w     #0x0FFF,d0
		move.w     d0,Voice_Note(a6)
		andi.w     #0xF000,d1
		lsr.w      #8,d1
		move.b     d2,d0
		lsr.b      #4,d0
		add.b      d1,d0
		move.b     d0,Voice_Sample(a6)
		andi.b     #15,d2
		move.b     d2,Voice_Command(a6)
		moveq.l    #0,d2
		move.b     Voice_Sample(a6),d2
		beq.s      No_New_Sample
		subq.w     #1,d2
		lea.l      Samples_Adr(pc),a1
		move.l     0(a1,d2.w*4),Voice_Start(a6)
		clr.l      Voice_Sample_Offset(a6)
		mulu.w     #Amiga_Size,d2
		moveq.l    #0,d0
		move.w     Amiga_Length(a5,d2.w),d0
		lsl.l      #1,d0
		move.l     d0,Voice_Length(a6)
		move.w     Amiga_Repeat_Length(a5,d2.w),d0
		lsl.l      #1,d0
		move.l     d0,Voice_Sample_Repeat_Length(a6)
		moveq.l    #0,d0
		move.b     Amiga_Volume(a5,d2.w),d0
		move.w     d0,Voice_Volume(a6)
		move.w     d0,Voice_Sample_Volume(a6)
		move.b     Amiga_Fine_Tune(a5,d2.w),d0
		andi.w     #15,d0
		mulu.w     #12*3*2,d0
		move.w     d0,Voice_Sample_Fine_Tune(a6)
		.IFNE 0
          move.w    Amiga_Repeat_Start(a5,d2.w),d0
          add.l     Voice_Start(a6),d0
          move.l    d0,Voice_Funk_Start(a6)
		.ENDC									
No_New_Sample:
		tst.w      Voice_Note(a6)
		beq        Check_Efx_1
		move.w     Voice_Command(a6),d0
		andi.w     #0x0FF0,d0
		cmp.w      #0x0E50,d0
		beq.s      Do_Set_Fine_Tune
		move.b     Voice_Command(a6),d0
		subq.b     #3,d0      ; 3 = Tone Portamento
		beq        Set_Tone_Portamento
		subq.b     #2,d0      ; 5 = Tone Porta + Vol Slide
		beq        Set_Tone_Portamento
		subq.b     #4,d0      ; 9 = Sample Offset
		bne.s      Set_Period
		bsr        Set_Sample_Offset
		bra.s      Set_Period
Do_Set_Fine_Tune:
		bsr        Set_Fine_Tune
Set_Period:
		lea.l      Period_Table(pc),a0
		move.w     Voice_Note(a6),d0
		bsr        Find_Period
		adda.w     Voice_Sample_Fine_Tune(a6),a0
		move.w     (a0),Voice_Period(a6)
		move.w     Voice_Command(a6),d0
		andi.w     #0x0ff0,d0
		cmp.w      #0x0ed0,d0
		bne.s      No_Note_Delay
		move.b     Voice_Parameters(a6),d0
		andi.b     #15,d0
		beq.s      No_Note_Delay
		rts
No_Note_Delay:
		move.w     Voice_Period(a6),Voice_Sample_Period(a6)
		move.l     Voice_Start(a6),Voice_Sample_Start(a6)
		move.l     Voice_Sample_Offset(a6),Voice_Sample_Position(a6)
	.IFNE 0
          move.l    Voice_Length(a6),d0
          move.l    Voice_Repeat_Length(a6),d1
          add.l     d1,d0
          move.l    d0,Voice_Sample_Length(a6)
          move.l    d1,Voice_Sample_Repeat_Length(a6)
	.ENDC
		btst       #2,Voice_Vibrato_Control(a6)
		bne.s      Vibrato_No_Reset
		clr.b      Voice_Vibrato_Position(a6)
Vibrato_No_Reset:
		btst       #2,Voice_Tremolo_Control(a6)
		bne.s      Tremolo_No_Reset
		clr.b      Voice_Tremolo_Position(a6)
Tremolo_No_Reset:

Check_Efx_1:
          .IFNE 0
          bsr       Simplet_Funk_Update
          .ENDC
		moveq.l    #0,d0
		move.b     Voice_Command(a6),d0
		jmp        ([Jump_Table_1,d0.w*4])
Jump_Table_1:
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Period_Nop
          dc.l      Position_Jump
          dc.l      Volume_Change
          dc.l      Pattern_Break
          dc.l      E_Commands_1
          dc.l      Set_Speed


E_Commands_1:
		move.b     Voice_Parameters(a6),d0
		andi.w     #0x00F0,d0
		lsr.w      #4,d0
		jmp        ([Jump_Table_E1,d0.w*4])

Jump_Table_E1:
          dc.l      Mod_Return
          dc.l      Fine_Portamento_Up
          dc.l      Fine_Portamento_Down
          dc.l      Set_Glissando_Control
          dc.l      Set_Vibrato_Control
          dc.l      Mod_Return
          dc.l      Pattern_Loop
          dc.l      Set_Tremolo_Control
          dc.l      Mod_Return
          dc.l      Retrig_Note
          dc.l      Volume_Fine_Up
          dc.l      Volume_Slide_Down
          dc.l      Note_Cut
          dc.l      Mod_Return
          dc.l      Pattern_Delay
          .IFNE 0
          dc.l      Funk_It
		  .ELSE
          dc.l      Mod_Return
		  .ENDC

	.IFNE 0
Simplet_Check_Efx_2
          bsr       Simplet_Funk_Update
          moveq.l   #0,d0
          move.b    Voice_Command(a6),d0
          jmp       ([Jump_Table_2,d0.w*4])
	.ENDC

Jump_Table_2:
          dc.l      Arpeggio
          dc.l      Portamento_Up
          dc.l      Portamento_Down
          dc.l      Tone_Portamento
          dc.l      Mt_Vibrato
          dc.l      Tone_Portamento_Plus_Volume_Slide
          dc.l      Vibrato_Plus_Volume_Slide
          dc.l      Mt_Tremolo
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Volume_Slide
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      E_Commands_2
          dc.l      Mod_Return

E_Commands_2:
		move.b     Voice_Parameters(a6),d0
		andi.w     #0x00F0,d0
		lsr.w      #4,d0
		jmp        ([Jump_Table_E2,d0.w*4])

Jump_Table_E2:
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Retrig_Note
          dc.l      Mod_Return
          dc.l      Mod_Return
          dc.l      Note_Cut
          dc.l      Note_Delay
          dc.l      Mod_Return
          dc.l      Mod_Return


Find_Period:
		cmp.w      12*2(a0),d0
		bcc.s      Do_Find_Period
		lea.l      12*2(a0),a0
		cmp.w      12*2(a0),d0
		bcc.s      Do_Find_Period
		lea.l      12*2(a0),a0
Do_Find_Period:
		moveq.l    #12-1,d3
Find_Period_Loop:
		cmp.w      (a0)+,d0
		dbcc       d3,Find_Period_Loop
		bcs.s      Period_Found
		subq.l     #2,a0
Period_Found:
		rts

Period_Nop:
		move.w     Voice_Period(a6),Voice_Sample_Period(a6)
Mod_Return:
		rts

Arpeggio_Table:
          dc.b      0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0
          dc.b      1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1

Arpeggio:
		  move.b     Voice_Parameters(a6),d1
          beq.s     Period_Nop
          moveq.l   #0,d0
		move.b     Play_Counter(pc),d0
		move.b     Arpeggio_Table(pc,d0.w),d0
		beq.s      Period_Nop
		subq.b     #2,d0
		beq.s      Arpeggio_2
		lsr.w      #4,d1
Arpeggio_2:
		andi.w     #15,d1
		lea.l      Period_Table(pc),a0
		adda.w     Voice_Sample_Fine_Tune(a6),a0
		move.w     Voice_Period(a6),d0
		bsr.s      Find_Period
		move.w     0(a0,d1.w*2),Voice_Sample_Period(a6)
		rts

Portamento_Up:
		moveq.l    #0,d0
		move.b     Voice_Parameters(a6),d0
Portamento_Up2:
		sub.w      d0,Voice_Period(a6)
		move.w     Voice_Period(a6),d0
		cmp.w      #113,d0
		bhi.s      Portamento_Up_Ok
		move.w     #113,Voice_Period(a6)
Portamento_Up_Ok:
		move.w     Voice_Period(a6),Voice_Sample_Period(a6)
		rts

Portamento_Down:
		moveq.l    #0,d0
		move.b     Voice_Parameters(a6),d0
Portamento_Down2:
		add.w      d0,Voice_Period(a6)
		move.w     Voice_Period(a6),d0
		cmp.w      #856,d0
		bcs.s      Portamento_Down_Ok
		move.w     #856,Voice_Period(a6)
Portamento_Down_Ok:
		move.w     Voice_Period(a6),Voice_Sample_Period(a6)
		rts

Set_Tone_Portamento:
		lea.l      Period_Table(pc),a0
		move.w     Voice_Note(a6),d0
		bsr        Find_Period
		adda.w     Voice_Sample_Fine_Tune(a6),a0
		move.w     (a0),d0
		move.w     d0,Voice_Wanted_Period(a6)
		move.w     Voice_Period(a6),d1
		sf         Voice_Tone_Port_Direction(a6)
		cmp.w      d1,d0
		beq.s      Clear_Tone_Portamento
		bge        Period_Nop
		st         Voice_Tone_Port_Direction(a6)
		rts
Clear_Tone_Portamento:
		clr.w      Voice_Wanted_Period(a6)
		rts

Tone_Portamento:
		move.b     Voice_Parameters(a6),d0
		beq.s      Tone_Portamento_No_Change
		move.b     d0,Voice_Tone_Port_Speed(a6)
		clr.b      Voice_Parameters(a6)
Tone_Portamento_No_Change:
		tst.w      Voice_Wanted_Period(a6)
		beq        Period_Nop
		moveq.l    #0,d0
		move.b     Voice_Tone_Port_Speed(a6),d0
		tst.b      Voice_Tone_Port_Direction(a6)
		bne.s      Tone_Portamento_Up
Tone_Portamento_Down:
		add.w      d0,Voice_Period(a6)
		move.w     Voice_Wanted_Period(a6),d0
		cmp.w      Voice_Period(a6),d0
		bgt.s      Tone_Portamento_Set_Period
		move.w     Voice_Wanted_Period(a6),Voice_Period(a6)
		clr.w      Voice_Wanted_Period(a6)
		bra.s      Tone_Portamento_Set_Period
Tone_Portamento_Up:
		sub.w      d0,Voice_Period(a6)
		move.w     Voice_Wanted_Period(a6),d0
		cmp.w      Voice_Period(a6),d0
		blt.s      Tone_Portamento_Set_Period
		move.w     Voice_Wanted_Period(a6),Voice_Period(a6)
		clr.w      Voice_Wanted_Period(a6)
Tone_Portamento_Set_Period:
		move.w     Voice_Period(a6),d0
		tst.b      Voice_Glissando_Control(a6)
		beq.s      Glissando_Skip
		lea.l      Period_Table(pc),a0
		adda.w     Voice_Sample_Fine_Tune(a6),a0
		bsr        Find_Period
		move.w     (a0),d0
Glissando_Skip:
		move.w     d0,Voice_Sample_Period(a6)
		rts

Mt_Vibrato:
		move.b     Voice_Parameters(a6),d0
		beq.s      Mt_Vibrato2
		move.b     Voice_Vibrato_Command(a6),d2
		andi.b     #15,d0
		beq.s      Mt_VibSkip
		andi.b     #0xF0,d2
		or.b       d0,d2
Mt_VibSkip:
		move.b     Voice_Parameters(a6),d0
		andi.b     #0xF0,d0
		beq.s      Mt_vibskip2
		andi.b     #15,d2
		or.b       d0,d2
Mt_vibskip2:
		move.b     d2,Voice_Vibrato_Command(a6)
Mt_Vibrato2:
		move.b     Voice_Vibrato_Position(a6),d0
		lea.l      Sinus_Table(pc),a3
		lsr.w      #2,d0
		andi.w     #31,d0
		moveq.l    #0,d2
		move.b     Voice_Vibrato_Control(a6),d2
		andi.b     #3,d2
		beq.s      Mt_Vib_Sine
		lsl.b      #3,d0
		cmp.b      #1,d2
		beq.s      Mt_Vib_RampDown
		move.b     #255,d2
		bra.s      Mt_Vib_Set
Mt_Vib_RampDown:
		tst.b      Voice_Vibrato_Position(a6)
		bpl.s      Mt_Vib_RampDown2
		move.b     #255,d2
		sub.b      d0,d2
		bra.s      Mt_Vib_Set
Mt_Vib_RampDown2:
		move.b     d0,d2
		bra.s      Mt_Vib_Set
Mt_Vib_Sine:
		move.b     0(a3,d0.w),d2
Mt_Vib_Set:
		move.b     Voice_Vibrato_Command(a6),d0
		andi.w     #15,d0
		mulu.w     d0,d2
		lsr.w      #7,d2
		move.w     Voice_Period(a6),d0
		tst.b      Voice_Vibrato_Position(a6)
		bmi.s      Mt_VibratoNeg
		add.w      d2,d0
		bra.s      Mt_Vibrato3
Mt_VibratoNeg:
		sub.w      d2,d0
Mt_Vibrato3:
		move.w     d0,Voice_Sample_Period(a6)
		move.b     Voice_Vibrato_Command(a6),d0
		lsr.w      #2,d0
		andi.w     #0x003C,d0
		add.b      d0,Voice_Vibrato_Position(a6)
		rts

Tone_Portamento_Plus_Volume_Slide:
		bsr        Tone_Portamento_No_Change
		bra        Volume_Slide

Vibrato_Plus_Volume_Slide:
		bsr.s      Mt_Vibrato2
		bra        Volume_Slide

Mt_Tremolo:
		move.b     Voice_Parameters(a6),d0
		beq.s      Mt_Tremolo2
		move.b     Voice_Tremolo_Command(a6),d2
		andi.b     #15,d0
		beq.s      Mt_treskip
		andi.b     #0xF0,d2
		or.b       d0,d2
Mt_treskip:
		move.b     Voice_Parameters(a6),d0
		andi.b     #0xF0,d0
		beq.s      Mt_treskip2
		andi.b     #15,d2
		or.b       d0,d2
Mt_treskip2:
		move.b     d2,Voice_Tremolo_Command(a6)
Mt_Tremolo2:
		move.b     Voice_Tremolo_Position(a6),d0
		lea.l      Sinus_Table(pc),a3
		lsr.w      #2,d0
		andi.w     #31,d0
		moveq.l    #0,d2
		move.b     Voice_Tremolo_Control(a6),d2
		andi.b     #3,d2
		beq.s      Mt_tre_sine
		lsl.b      #3,d0
		cmp.b      #1,d2
		beq.s      Mt_tre_rampdown
		move.b     #255,d2
		bra.s      Mt_tre_set
Mt_tre_rampdown:
		tst.b      Voice_Tremolo_Position(a6)
		bpl.s      Mt_tre_rampdown2
		move.b     #255,d2
		sub.b      d0,d2
		bra.s      Mt_tre_set
Mt_tre_rampdown2:
		move.b     d0,d2
		bra.s      Mt_tre_set
Mt_tre_sine:
		move.b     0(a3,d0.w),d2
Mt_tre_set:
		move.b     Voice_Tremolo_Command(a6),d0
		andi.w     #15,d0
		mulu.w     d0,d2
		lsr.w      #6,d2
		moveq.l    #0,d0
		move.w     Voice_Volume(a6),d0
		tst.b      Voice_Tremolo_Position(a6)
		bmi.s      Mt_TremoloNeg
		add.w      d2,d0
		bra.s      Mt_Tremolo3
Mt_TremoloNeg:
		sub.w      d2,d0
Mt_Tremolo3:
		bpl.s      Mt_TremoloSkip
		clr.w      d0
Mt_TremoloSkip:
		cmp.w      #64,d0
		bls.s      Mt_TremoloOk
		move.w     #64,d0
Mt_TremoloOk:
		move.w     d0,Voice_Sample_Volume(a6)
		move.b     Voice_Tremolo_Command(a6),d0
		lsr.w      #2,d0
		andi.w     #0x003C,d0
		add.b      d0,Voice_Tremolo_Position(a6)
		bra        Period_Nop


Set_Sample_Offset:
		move.l     Voice_Sample_Offset(a6),d0
		moveq.l    #0,d1
		move.b     Voice_Parameters(a6),d1
		beq.s      Sample_Offset_No_New
		lsl.w      #8,d1
		move.l     d1,d0
Sample_Offset_No_New:
		add.l      Voice_Sample_Offset(a6),d0
		cmp.l      Voice_Length(a6),d0
		ble.s      Sample_Offset_Ok
		move.l     Voice_Length(a6),d0
Sample_Offset_Ok:
		move.l     Voice_Start(a6),Voice_Sample_Start(a6)
		move.l     d0,Voice_Sample_Offset(a6)
		move.l     d0,Voice_Sample_Position(a6)
		rts

Volume_Slide:
		moveq.l    #0,d0
		move.b     Voice_Parameters(a6),d0
		lsr.w      #4,d0
		beq.s      Volume_Slide_Down
Volume_Slide_Up:
		add.w      d0,Voice_Volume(a6)
		cmpi.w     #64,Voice_Volume(a6)
		ble.s      Volume_Slide_Up_Ok
		move.w     #64,Voice_Volume(a6)
Volume_Slide_Up_Ok:
		move.w     Voice_Volume(a6),Voice_Sample_Volume(a6)
		bra        Period_Nop

Volume_Slide_Down:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		sub.w      d0,Voice_Volume(a6)
		bpl.s      Volume_Slide_Down_Ok
		clr.w      Voice_Volume(a6)
Volume_Slide_Down_Ok:
		move.w     Voice_Volume(a6),Voice_Sample_Volume(a6)
		bra        Period_Nop

Position_Jump:
		moveq.l    #0,d0
		move.b     Voice_Parameters(a6),d0
		move.w     d0,Position_Jump_Pos
		st         Position_Jump_Flag
		rts

Volume_Change:
		moveq.l    #0,d0
		move.b     Voice_Parameters(a6),d0
		cmp.b      #64,d0
		ble.s      Volume_Change_Ok
		moveq.l    #64,d0
Volume_Change_Ok:
		move.w     d0,Voice_Volume(a6)
		move.w     d0,Voice_Sample_Volume(a6)
		rts

Pattern_Break:
		moveq.l    #0,d0
		tst.b      Old_Module(pc)
		bne.s      Pattern_Break_Ok
		move.b     Voice_Parameters(a6),d0
		move.w     d0,d2               ; BCD encoding
		lsr.w      #4,d0               ; first digit
		mulu.w     #10,d0
		andi.w     #15,d2              ; second digit
		add.w      d2,d0
		cmp.w      Pattern_Length(pc),d0
		bcs.s      Pattern_Break_Ok
		moveq.l    #0,d0
Pattern_Break_Ok:
		move.w     d0,Pattern_Break_Position
		st         Pattern_Break_Flag
		rts

Set_Speed:
		moveq.l    #0,d0
		move.b     Voice_Parameters(a6),d0
		beq.s      Set_Speed_End
		cmp.b      #32,d0
		bhi.s      Set_Tempo
		move.b     d0,Speed
Set_Speed_End:
		rts
Set_Tempo:
		move.b     d0,Tempo

calc_timer_params:
		movem.l    d0-d3,-(a7)
		moveq.l    #0,d0
		move.b     Tempo(pc),d0
		moveq.l    #125,d1
		mulu.w     dsp_sample_period(pc),d1
		divul.l    #50,d1:d1
		divul.l    d0,d1:d1
		moveq.l    #0,d3
calc_timer_params1:
		addq.b     #1,d3
		move.l     d1,d2
		divu.w     d3,d2
		cmp.w      #1024,d2
		bhi.s      calc_timer_params1
		move.w     d3,period_shift
		mulu.w     d3,d0
		mulu.w     #12800,d0
		divul.l    #125,d0:d0
		move.l     #0x00300000,d2
		move.l     d2,d3
		divul.l    d0,d2:d2
		move.b     #7,IT_Timer_Control
		move.b     d2,IT_Timer_Data
		movem.l    (a7)+,d0-d3
		rts

Fine_Portamento_Up:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		bra        Portamento_Up2

Fine_Portamento_Down:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		bra        Portamento_Down2

Set_Glissando_Control:
		move.b     Voice_Parameters(a6),Voice_Glissando_Control(a6)
		rts

Set_Vibrato_Control:
		move.b     Voice_Parameters(a6),Voice_Vibrato_Control(a6)
		rts

Set_Fine_Tune:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		mulu.w     #12*3*2,d0
		move.w     d0,Voice_Sample_Fine_Tune(a6)
		rts

Pattern_Loop:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		beq.s      Set_Loop_Position
		tst.w      Pattern_Loop_Counter(pc)
		beq.s      Set_Loop_Counter
		subq.w     #1,Pattern_Loop_Counter
		beq        Mod_Return
Do_Loop:
		st         Pattern_Loop_Flag
		rts
Set_Loop_Counter:
		move.w     d0,Pattern_Loop_Counter
		bra.s      Do_Loop
Set_Loop_Position:
		move.w     Pattern_Position(pc),Pattern_Loop_Position
		rts

Set_Tremolo_Control:
		move.b     Voice_Parameters(a6),Voice_Tremolo_Control(a6)
		rts

Retrig_Note:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		beq.s      No_Retrig_Note
		moveq.l    #0,d1
		move.b     Play_Counter(pc),d1
		bne.s      Retrig_Note_Skip
		tst.w      Voice_Note(a6)
		bne.s      No_Retrig_Note
Retrig_Note_Skip:
		divu.w     d0,d1
		swap       d1
		tst.w      d1
		bne.s      No_Retrig_Note
		move.w     Voice_Period(a6),Voice_Sample_Period(a6)
		move.l     Voice_Sample_Offset(a6),Voice_Sample_Position(a6)
No_Retrig_Note:
		rts

Volume_Fine_Up:
		move.b     Voice_Parameters(a6),d0
		andi.w     #15,d0
		bra        Volume_Slide_Up

Note_Cut:
		move.b     Voice_Parameters(a6),d0
		andi.b     #15,d0
		cmp.b      Play_Counter(pc),d0
		bne        Mod_Return
		clr.w      Voice_Volume(a6)
		clr.w      Voice_Sample_Volume(a6)
		rts

Note_Delay:
		move.b     Voice_Parameters(a6),d0
		andi.b     #15,d0
		cmp.b      Play_Counter(pc),d0
		bne        Mod_Return
		tst.w      Voice_Note(a6)
		beq        Mod_Return
		move.w     Voice_Period(a6),Voice_Sample_Period(a6)
		move.l     Voice_Start(a6),Voice_Sample_Start(a6)
		move.l     Voice_Sample_Offset(a6),Voice_Sample_Position(a6)
		.IFNE 0
          move.l    Voice_Length(a6),d0
          move.l    Voice_Repeat_Length(a6),d1
          add.l     d1,d0
          move.l    d0,Voice_Sample_Length(a6)
          move.l    d1,Voice_Sample_Repeat_Length(a6)
        .ENDC
		rts

Pattern_Delay:
		tst.b      Pattern_Delay_Time(pc)
		bne        Mod_Return
		move.b     Voice_Parameters(a6),d0
		andi.b     #15,d0
		move.b     d0,Pattern_Delay_Time
		rts

	.IFNE 0
Funk_It:
          move.b    Voice_Parameters(a6),d0
          and.b     #15,d0
          move.b    d0,Voice_Funk_Speed(a6)
          beq       Mod_Return

Funk_Update:
          moveq.l   #0,d0
          move.b    Voice_Funk_Speed(a6),d0
          beq       Mod_Return

          lea.l     Funk_Table(pc),a0
          move.b    (a0,d0.w),d0
          add.b     d0,Voice_Funk_Offset(a6)
          btst.b    #7,Voice_Funk_Offset(a6)
          beq       Mod_Return

          clr.b     Voice_Funk_Offset(a6)

          movea.l   Voice_Funk_Position(a6),a0
          addq.w    #1,a0
          cmpa.l    Voice_Repeat_Length(a6),a0
          blo.s     Funk_Ok
          movea.w   #0,a0
Funk_Ok:
          move.l    a0,Voice_Funk_Position(a6)
          add.l     Voice_Funk_Start(a6),a0
          moveq.l   #-1,d0
          sub.b     (a0),d0
          move.b    d0,(a0)
          rts       

Funk_Table:
          dc.b      0,5,6,7,8,10,11,13,16,19,22,26,32,43,64,128

	.ENDC

Sinus_Table:
          dc.b      0,24,49,74,97,120,141,161,180,197,212,224
          dc.b      235,244,250,253,255,253,250,244,235,224
          dc.b      212,197,180,161,141,120,97,74,49,24

Period_Table:
; Tuning 0, Normal
          dc.w 856,808,762,720,678,640,604,570,538,508,480,453
          dc.w 428,404,381,360,339,320,302,285,269,254,240,226
          dc.w 214,202,190,180,170,160,151,143,135,127,120,113
; Tuning 1
          dc.w 850,802,757,715,674,637,601,567,535,505,477,450
          dc.w 425,401,379,357,337,318,300,284,268,253,239,225
          dc.w 213,201,189,179,169,159,150,142,134,126,119,113
; Tuning 2
          dc.w 844,796,752,709,670,632,597,563,532,502,474,447
          dc.w 422,398,376,355,335,316,298,282,266,251,237,224
          dc.w 211,199,188,177,167,158,149,141,133,125,118,112
; Tuning 3
          dc.w 838,791,746,704,665,628,592,559,528,498,470,444
          dc.w 419,395,373,352,332,314,296,280,264,249,235,222
          dc.w 209,198,187,176,166,157,148,140,132,125,118,111
; Tuning 4
          dc.w 832,785,741,699,660,623,588,555,524,495,467,441
          dc.w 416,392,370,350,330,312,294,278,262,247,233,220
          dc.w 208,196,185,175,165,156,147,139,131,124,117,110
; Tuning 5
          dc.w 826,779,736,694,655,619,584,551,520,491,463,437
          dc.w 413,390,368,347,328,309,292,276,260,245,232,219
          dc.w 206,195,184,174,164,155,146,138,130,123,116,109
; Tuning 6
          dc.w 820,774,730,689,651,614,580,547,516,487,460,434
          dc.w 410,387,365,345,325,307,290,274,258,244,230,217
          dc.w 205,193,183,172,163,154,145,137,129,122,115,109
; Tuning 7
          dc.w 814,768,725,684,646,610,575,543,513,484,457,431
          dc.w 407,384,363,342,323,305,288,272,256,242,228,216
          dc.w 204,192,181,171,161,152,144,136,128,121,114,108
; Tuning -8
          dc.w 907,856,808,762,720,678,640,604,570,538,508,480
          dc.w 453,428,404,381,360,339,320,302,285,269,254,240
          dc.w 226,214,202,190,180,170,160,151,143,135,127,120
; Tuning -7
          dc.w 900,850,802,757,715,675,636,601,567,535,505,477
          dc.w 450,425,401,379,357,337,318,300,284,268,253,238
          dc.w 225,212,200,189,179,169,159,150,142,134,126,119
; Tuning -6
          dc.w 894,844,796,752,709,670,632,597,563,532,502,474
          dc.w 447,422,398,376,355,335,316,298,282,266,251,237
          dc.w 223,211,199,188,177,167,158,149,141,133,125,118
; Tuning -5
          dc.w 887,838,791,746,704,665,628,592,559,528,498,470
          dc.w 444,419,395,373,352,332,314,296,280,264,249,235
          dc.w 222,209,198,187,176,166,157,148,140,132,125,118
; Tuning -4
          dc.w 881,832,785,741,699,660,623,588,555,524,494,467
          dc.w 441,416,392,370,350,330,312,294,278,262,247,233
          dc.w 220,208,196,185,175,165,156,147,139,131,123,117
; Tuning -3
          dc.w 875,826,779,736,694,655,619,584,551,520,491,463
          dc.w 437,413,390,368,347,328,309,292,276,260,245,232
          dc.w 219,206,195,184,174,164,155,146,138,130,123,116
; Tuning -2
          dc.w 868,820,774,730,689,651,614,580,547,516,487,460
          dc.w 434,410,387,365,345,325,307,290,274,258,244,230
          dc.w 217,205,193,183,172,163,154,145,137,129,122,115
; Tuning -1
          dc.w 862,814,768,725,684,646,610,575,543,513,484,457
          dc.w 431,407,384,363,342,323,305,288,272,256,242,228
          dc.w 216,203,192,181,171,161,152,144,136,128,121,114

DSP_Code:
	include "tracker.inc"
DSP_End:

	.even

voice_init_tab:
		dc.l 54
		dc.l 54
		dc.l 54
		dc.l 54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54
		dc.l 54
		dc.l 108
		dc.l 108
		dc.l -54

dsp_voices: ds.b 4*Voice_Size
Voices: ds.b 32*Voice_Size
Module: dc.l 0
workspace: dc.l 0
end_of_samples: dc.l 0
Voices_Nb: dc.w 0
Samples_Nb: dc.w 0
Sequence_Adr: dc.l 0
Patterns_Adr: dc.l 0
Samples_Adr: ds.l 31
Line_Size: dc.w 0
Pattern_Size: dc.w 0
Song_Position: dc.w 0
Song_Length: dc.w 0
Song_Restart: dc.w 0
Tempo: dc.b 0
Speed: dc.b 0
Play_Counter: dc.b 0
        .even
loopstart_flag: dc.b 0
looprestart_flag: dc.b 0
timer_a_flag: dc.b 0
stop_flag: dc.b 0
IT_Timer_Control: dc.b 0
IT_Timer_Data: dc.b 0
period_shift: dc.w 0
period_count: dc.w 0
prescale_value: dc.w 0
dsp_sample_period: dc.w 0
dsp_counter: dc.w 0
dsp_rec_flag2: dc.b 0
dsp_rec_flag: dc.b 0
dsp_lengthl: dc.w 0
dsp_lengthr: dc.w 0
Pattern_Position: dc.w 0
Pattern_Length: dc.w 0
Pattern_Loop_Counter: dc.w 0
Pattern_Loop_Position: dc.w 0
Pattern_Break_Position: dc.w 0
Position_Jump_Pos: dc.w 0
Position_Jump_Flag: dc.b 0
Pattern_Loop_Flag: dc.b 0
Pattern_Break_Flag: dc.b 0
Pattern_Delay_Time: dc.b 0
Old_Module: dc.b 0
	.even

	.IFNE COMPILER

	.data

vu_active: ds.w 1
x12d78: ds.w 1
	ds.w 1
	ds.w 1
vu_max: ds.w 1
scopebuffer: ds.l 1024

trackeraddr: dc.l 0
trackerend: dc.l 0

	.text

              ds.l      1048/4          ; WorkSpace
WorkSpace:    ds.l      1000/4              ; premier de la section BSS

	.ELSE
	
	.bss

vu_active: ds.w 1
x12d78: ds.w 1
	ds.w 1
	ds.w 1
vu_max: ds.w 1
scopebuffer: ds.l 1024

              ds.l      1056/4          ; WorkSpace
WorkSpace:    ds.l      1000/4              ; premier de la section BSS

	.ENDC
