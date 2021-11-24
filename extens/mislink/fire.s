; Fire unpack-source, (C) by Axe of Delight
; a0 = Pack-Adresse, d0 = Length

fire_decrunch:
		link       a3,#-120
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      120(a0),a4
		movea.l    a4,a6
		bsr.s      .getlongword   ; Kenn-Langwort holen
		cmpi.l     #PACK_FIRE,d0  ; Kennung gefunden?
		.IFNE COMPILER
		bne.s      .not_packed    ; nein: nicht gepackt
		.ELSE
		bne.w      .not_packed    ; nein: nicht gepackt
		.ENDC
		bsr.s      .getlongword   ; Laenge holen
		lea.l      -8(a0,d0.l),a5 ; a5 = end of data
		bsr.s      .getlongword   ; erstes Informationslangwort
		move.l     d0,(a7)
		adda.l     d0,a6
		movea.l    a6,a1
		moveq.l    #120-1,d0
.save:
		move.b     -(a1),-(a3)
		dbf        d0,.save
		movea.l    a6,a3          ; merken fuer spaeter
		move.b     -(a5),d7
		lea.l      .tabellen(pc),a2 ; a2 = Zeiger auf Datenbereich
		moveq.l    #1,d6
		swap       d6             ; d6 = $10000
		moveq.l    #0,d5          ; d5 = 0 (oberes Wort: immer 0!)
.normal_bytes:
		bsr.s      .get_1_bit
		bcc.s      .test_if_end   ; Bit %0: keine Daten
		moveq.l    #0,d1          ; falls zu copy_direkt
		bsr.s      .get_1_bit
		bcc.s      .copy_direkt   ; Bitfolge: %10: 1 Byte direkt kop.
;	lea.l	.direkt_tab+16-.tabellen(a4),a1	; ... see next line
		movea.l    a2,a0
		moveq.l    #3,d3
.nextgb:
		move.l     -(a0),d0       ; d0.w Bytes lesen
		bsr.s      .get_d0_bits
		swap       d0
		cmp.w      d0,d1          ; alle gelesenen Bits gesetzt?
		dbne       d3,.nextgb     ; ja: dann weiter Bits lesen
		add.l      16(a0),d1      ; Anzahl der zu uebertragenen Bytes
.copy_direkt:
		move.b     -(a5),-(a6)    ; Daten direkt kopieren
		dbf        d1,.copy_direkt ; noch ein Byte
.test_if_end:
		cmpa.l     a4,a6          ; Fertig?
		bgt.s      .strings       ; Weiter wenn Ende nicht erreicht

; move all data
		movem.l    (a7),d0-d7/a0-a2/a5
.move:
		move.b     (a4)+,(a0)+
		subq.l     #1,d0
		bne.s      .move
		moveq.l    #120-1,d0      ; restore saved data
.rest:
		move.b     -(a5),-(a3)
		dbf        d0,.rest

.not_packed:
		movem.l    (a7)+,d0-d7/a0-a6
		unlk       a3
		rts

;************************** Unterroutinen: wegen Optimierung nicht am Schluss
.getlongword:
		moveq.l    #4-1,d1
.glw:
		rol.l      #8,d0
		move.b     (a0)+,d0
		dbf        d1,.glw
		rts

.get_1_bit:
		add.b      d7,d7          ; hole ein bit
		beq.s      .not_found2    ; quellfeld leer
		rts
.not_found2:
		move.b     -(a5),d7
		addx.b     d7,d7          ; hole ein bit
		rts

.get_d0_bits:
		moveq.l    #0,d1          ; ergebnisfeld vorbereiten
.hole_bit_loop:
		add.b      d7,d7          ; hole ein bit
		beq.s      .not_found     ; quellfeld leer
.on_d0:
		addx.w     d1,d1          ; und uebernimm es
		dbf        d0,.hole_bit_loop ; bis alle bits geholt wurden
		rts
.not_found:
		move.b     -(a5),d7
		addx.b     d7,d7
		bra.s      .on_d0

.strings:
		moveq.l    #1,d0          ; 2 Bits lesen
		bsr.s      .get_d0_bits
		subq.w     #1,d1
		bmi.s      .gleich_morestring ; %00
		beq.s      .length_2      ; %01
		subq.w     #1,d1
		beq.s      .length_3      ; %10
		bsr.s      .get_1_bit
		bcc.s      .bitset        ; %110
		bsr.s      .get_1_bit
		bcc.s      .length_4      ; %1110
		bra.s      .length_5      ; %1111

.get_short_offset:
		moveq.l    #1,d0
		bsr.s      .get_d0_bits   ; d1:  0,  1,  2,  3
		subq.w     #1,d1
		bpl.s      .contoffs
		moveq.l    #0,d0          ; Sonderfall
		rts

.get_long_offset:
		moveq.l    #1,d0
		bsr.s      .get_d0_bits
.contoffs:
		add.w      d1,d1
		add.w      d1,d1
		movem.w    .offset_table-.tabellen(a2,d1.w),d0/d5
		bsr.s      .get_d0_bits
		add.l      d5,d1
		rts

.gleich_morestring:               ; %00
		moveq.l    #1,d0          ; 2 Bits lesen
		bsr.s      .get_d0_bits   ; d1:  0,  1,  2,  3
		subq.w     #1,d1
		bmi.s      .gleich_string ; %0000
		add.w      d1,d1          ; d1:      0,  2,  4
		add.w      d1,d1          ; d1:      0,  4,  8
		movem.w    .more_table-.tabellen(a2,d1.w),d0/d2
		bsr.s      .get_d0_bits
		add.w      d1,d2          ; d2 = Stringlaenge
		bsr.s      .get_long_offset
		move.w     d2,d0          ; d0 = Stringlaenge
		bra.s      .copy_longstring

.bitset:
		moveq.l    #2,d0          ; %110
		bsr.s      .get_d0_bits
		moveq.l    #0,d0
		bset       d1,d0
		bra.s      .put_d0

.length_2:
		moveq.l    #7,d0          ; %01
		bsr.s      .get_d0_bits
		moveq.l    #2-2,d0
		bra.s      .copy_string

.length_3:
		bsr.s      .get_short_offset ; %10
		tst.w      d0
		.IFNE COMPILER
		beq.s      .put_d0
		.ELSE
		beq.w      .put_d0
		.ENDC
		moveq.l    #3-2,d0
		bra.s      .copy_string

.length_4:
		bsr.s      .get_short_offset ; %1110
		tst.w      d0
		beq.s      .copy_pred
		moveq.l    #4-2,d0
		bra.s      .copy_string

.length_5:
		bsr.s      .get_short_offset ; %1111
		tst.w      d0
		beq.s      .put_ff
		moveq.l    #5-2,d0
		bra.s      .copy_string
.put_ff:
		moveq.l    #-1,d0
		bra.s      .put_d0
.copy_pred:
		move.b     (a6),d0
.put_d0:
		move.b     d0,-(a6)
		bra.s      .backmain

.gleich_string:
		bsr.s      .get_long_offset ; Anzahl gleicher Bytes lesen
		beq.s      .backmain       ; 0: zurueck
		move.b     (a6),d0
.copy_gl:
		move.b     d0,-(a6)
		dbf        d1,.copy_gl
		sub.l      d6,d1
		bmi.s      .backmain
		bra.s      .copy_gl

.copy_longstring:
		subq.w     #2,d0          ; Stringlaenge - 2 (wegen dbf)
.copy_string:                      ; d1 = Offset, d0 = Anzahl Bytes -2
		lea.l      2(a6,d1.l),a0  ; Hier stehen die Originaldaten
		adda.w     d0,a0          ; dazu die Stringlaenge-2
		move.b     -(a0),-(a6)    ; ein Byte auf jeden Fall kopieren
.dep_b:
		move.b     -(a0),-(a6)    ; mehr Bytes kopieren
		dbf        d0,.dep_b      ; und noch ein Mal
.backmain:
		bra        .normal_bytes   ; Jetzt kommen wieder normale Bytes

.direkt_tab:
	dc.l	$03ff0009,$00070002,$00030001,$00030001 ; Anzahl 1-Bits

.tabellen:
		dc.l	    15-1,      8-1,      5-1,      2-1  ; Anz. Bytes

.offset_table:
	dc.w	 3,             0
	dc.w	 7,          16+0
	dc.w	11,      256+16+0
	dc.w	15, 4096+256+16+0
.more_table:
	dc.w	3,       5
	dc.w	5,    16+5
	dc.w	7, 64+16+5
;*************************************************** Ende der Unpackroutine

