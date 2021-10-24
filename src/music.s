
          bra.w debut


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;                   WEDGE MUSICAL, INTERRUPTIONS A 50 HERZ
;
;           (C) FL Software Corporation International, Illimited.
;
;      All Rights Reserved in all Federation, including Alpha Centauris
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;27/7/88;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

*********	Note for the programmer!
*	You can change the music trap to do a better one, but you have to respect
*	a few rules:
*	- Be compatible with old Stos musics. If you defined a totally new music
*	format, you just have to keep the old music player
*	along the new one, and when the user starts a music decide wich one
*	to use. This method could be more simple for you than changing the
*	existing routine.
*	- Keep all entry points correct, keep same registers to communicate
*	parameters, and everything will work fine with basic.
*	- That's all you have to keep with! Not very much isn't it? For all
*	information about this program, you can
*		Fax me at : France - 1 69838163
*		Phone me  : France - 1 69838354
*
*	I'm waiting for the brilliant new routine that will turn Stos into
*	a superb music machine, able to play 1/3 and 1/SQR(2) note lenght!
**********************************************************************************

even
inter:    dc.l 0

; fonctions de la trappe
jumps:    dc.l initsound      ;0:  Sound init
          dc.l startmusic     ;1:  Starts music
          dc.l stopvoice      ;2:  Stop one voice
          dc.l restartvoice   ;3:  Restarts one voice
          dc.l freeze         ;4:  Music freeze
          dc.l unfreeze       ;5:  Un freeze music
          dc.l chgtempo       ;6:  Change tempo
          dc.l startint       ;7:  Init interrupts
          dc.l stopinter      ;8:  End interrupts
          dc.l transpose      ;9:  Transpose
          dc.l voicepos       ;10: Returns music note played
          .IFNE FALCON
          dc.l trackerinit
          dc.l soundreset
          dc.l trackerplay
          dc.l trackerloop
          dc.l trackerffwd
          dc.l trackerpause
          dc.l trackerstop
          dc.l trackerspeed
          dc.l trackersongpos
          dc.l trackerpattpos
          dc.l trackervu
          dc.l trackerspectrum
          dc.l trackersongprev
          dc.l trackersongnext
          dc.l trackerstatus
          dc.l trackerscopedraw
          dc.l trackerscopeundraw
          dc.l trackerpattinfo
          dc.l trackertempo
          .ENDC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Parametres musique
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          dc.b "Musics"       ;benchmark for the basic
even
musicflg: dc.w 0              ;flag music on the way
freezflg: dc.w 0              ;flag frozen music
volume:   dc.b 0,0,0,0        ;volume of the three voices
tempo:    dc.w 0              ;tempo (0--->100)
tempocpt: dc.w 0              ;tempo counter
voixon:   dc.w 0              ;flag: voice currently on the way
avoixon:  dc.w 0
admusic:  dc.l 0              ;absolute starting address music definition
transp:   dc.w 0              ;music transposition
chip      = $ffff8800
chipcopy: ds.w 16             ;copy of sound chip registers
even
; TABLE DES ENVELOPPES ET DES TREMOLOS
envind    = 0               ;.b
envcpt    = 1               ;.b
envdec    = 2               ;.w
envlarg   = 4               ;.w rend proportionnel a la frequence!
envnb     = 6               ;.b
envpos    = 7               ;.b
envad     = 8               ;.l
tenv      = 12
envmolo:  ds.b tenv*7

even
; TABLE DE LA MUSIQUE
muscpt    = 0               ;.w
musdeb    = 2               ;.w depart relatif/admusic de cette voix
muspos    = 4               ;.w
musenv    = 6               ;.w flag: enveloppe en route?
mustre    = 8               ;.w flag: tremolo en route?
musbrr    = 10              ;.w flag: voix musique/bruit
musrep    = 12              ;.w flag/compteur repetition
musrepd   = 14              ;.w adresse relative du redemmarrage
musold    = 16              ;.w adresse du la note jouee actuellement
tmusic    = 18
musique:  ds.b tmusic*3

; TABLE DES PERIODES DES NOTES (8 octaves--->96 notes)
          dc.w 0
periodes: dc.w 0              ;silence!
          ;       C   C#    D   D#    E    F   F#    G   G#    A   A#    B
          dc.w 3822,3608,3405,3214,3034,2863,2703,2551,2408,2273,2145,2025
          dc.w 1911,1804,1703,1607,1517,1432,1351,1276,1204,1136,1073,1012
          dc.w  956, 902, 851, 804, 758, 716, 676, 638, 602, 568, 536, 506
          dc.w  476, 451, 426, 402, 379, 358, 338, 319, 301, 284, 268, 253
          dc.w  239, 225, 213, 201, 190, 179, 169, 159, 150, 142, 134, 127
          dc.w  119, 113, 106, 100,  95,  89,  84,  80,  75,  71,  67,  63
          dc.w   60,  56,  53,  50,  47,  45,  42,  40,  38,  36,  34,  32
          dc.w   30,  28,  27,  25,  24,  22,  21,  20,  19,  18,  17,  16
; TABLE DES LONGUEURS DES NOTES (Tcroche ---> blanche pointee)
longueurs:dc.w 1,2,4,6,8,12,16,24,32,48

VoixOffCpt:      dc.b 0,0,0,0    ;Compteurs voix arretees

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Installation de la trappe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
debut:
		  .IFNE COMPILER
		  move.l #entrappe,$9c          ;trap #7
		  moveq #0,d0
		  rts

		  .ELSE

          pea initrap(pc)               ;initialise sous mode superviseur!
          move.w #38,-(sp)
          trap #14
          addq.l #6,sp
          lea finmusic+16(pc),a0        ;ramene l'adresse de fin du prg; 16 de securite!
          rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
initrap:  move.l #entrappe,$9c          ;trap #7
          rts

          .ENDC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRAP #7,7
;         Start of interruptions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
startint: bsr initsound
          move.l $400,inter
          move.l #wedge,$400
          rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRAP #7,8
;         Arret des interruptions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stopinter: bsr initsound
          move.l inter(pc),d0
          beq.s PaArr
          move.l d0,$400
PaArr:    rts

*
* this string is checked by the extension
* and must stay here, just before the trap entry
*
          .IFNE FALCON
          .IFEQ COMPILER
          dc.b "FALCON 030 STOS DSP/Mod 2.85",0
          .even
          .ENDC
          .ENDC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Entree de la trappe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
entrappe: movem.l d1-d7/a1-a6,-(sp)
          lsl #2,d0
          lea jumps(pc),a1
          move.l 0(a1,d0.w),a1
          jsr (a1)
          movem.l (sp)+,d1-d7/a1-a6
          rte

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Wedge musical
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wedge:    move.w musicflg(pc),d0
          beq finwedge2
          clr.w musicflg
          move.w voixon(pc),d7
; COMPTEURS VOIX ARRETEES: les remet en route
          lea VoixOffCpt(pc),a0
          moveq #2,d0
VxOff1:   tst.b 0(a0,d0.w)
          beq.s VxOff2
          subq.b #1,0(a0,d0.w)
          bne.s VxOff2
          bset d0,d7
VxOff2:   dbra d0,VxOff1
          move.w d7,voixon
; DECOMPTE LE TEMPO
DTempo:   lea chip,a3
          lea chipcopy(pc),a4
          move tempo(pc),d2
          beq adsr
          sub d2,tempocpt
          bcc adsr
          add #100,tempocpt
; SURVEILLE LES VOIX ARRETEES
          cmp avoixon(pc),d7
          beq.s music
; une (ou plusieurs) voix a chang‚ d'etat!
          move avoixon(pc),d6
          moveq #2,d2
voix1:    btst d2,d7
          bne.s voix3
voix2:    dbra d2,voix1
          move d7,avoixon
          bra.s music
voix3:    btst d2,d6                    ;cette voix n'a pas change!
          bne.s voix2
          move d2,d1
          addq #8,d1
          move.b d1,(a3)                ;registre de volume
          move.b 0(a4,d1.w),2(a3)
          move d2,d1
          lsl #1,d1
          move.b d1,(a3)                ;registre de frequence
          move.b 0(a4,d1.w),2(a3)
          addq #1,d1
          move.b d1,(a3)
          move.b 0(a4,d1.w),2(a3)
          bsr mixer                     ;envoie le mixer!
          bra.s voix2
; GERE LA MUSIQUE
music:    lea 2*tmusic+musique,a6
          moveq #2,d6
          move.l admusic(pc),a2         ;adresse de depart des tables
music1:   tst (a6)
          beq.s music2
          sub #1,(a6)
          beq.s music3
music2:   lea -tmusic(a6),a6
          dbra d6,music1
          bra adsr

music3:   lea envmolo(pc),a5
          move.w muspos(a6),d3          ;position dans la table
          move.w 0(a2,d3.w),d5
          bmi music20                   ;etiquette!
          tst musbrr(a6)
          beq.s music3a
; note BRUIT suivante: POKE LA PERIODE
          move.b d5,d0
          andi.b #$1f,d0
          move.b d0,6(a4)               ;poke dans la copy
          btst d6,d7
          beq.s music4
          move.b #6,(a3)                ;poke dans le circuit
          move.b d0,2(a3)
          bra.s music4
; note MUSIQUE suivante: POKE LA PERIODE
music3a:  clr d4
          move.b d5,d4                  ;ne transpose pas les blancs !!!
          beq.s music3e
          add.w transp(pc),d4           ;effectue la transposition
          cmpi.w #96,d4
          bcs.s music3d
          clr d4
music3d:  lsl #1,d4
music3e:  lea periodes(pc),a0
          move.b 0(a0,d4.w),d1
          move.b 1(a0,d4.w),d0
          move d6,d2
          lsl #1,d2
          move.b d0,0(a4,d2.w)          ;poke dans la copie
          move.b d1,1(a4,d2.w)
          btst d6,d7
          beq music4
          move.b d2,(a3)                ;poke dans le chip
          move.b d0,2(a3)
          addq #1,d2
          move.b d2,(a3)
          move.b d1,2(a3)
; poke la longueur de la note
music4:   move d5,d0
          lsr #7,d0                     ;# de longueur * 2
          lea longueurs(pc),a0
          move.w 0(a0,d0.w),(a6)        ;c'est fait!
; pointe la note suivante
          move d3,musold(a6)            ;adresse de la note jouee
          addq #2,d3
          move.w d3,muspos(a6)
          move d6,d0
          mulu #tenv*2,d0
          add d0,a5                     ;pointe la table ENVELOPPE
; fait demarrer un NOUVEAU TREMOLO !!!proportionnel a la periode!!!
          tst mustre(a6)
          beq.s music5
          tst musbrr(a6)                ;pas de tremolo si voix de bruit!
          bne.s music5
          lea periodes(pc),a0
          move.w -2(a0,d4.w),d0         ;prend la periode precedente
          sub.w 0(a0,d4.w),d0           ;moins celle de la note
          beq.s music4a                 ;attention au silence!
          lsr #2,d0                     ;divise par 4 (de 1/4 ton en 1/4 ton)
          bne.s music4a
          moveq #1,d0
music4a:  move.w d0,envlarg(a5)         ;egal taille du tremolo!
          move.l envad(a5),a0
          clr d0
          bsr nxadsr
; fait demarrer une NOUVELLE ENVELOPPE
music5:   tst musenv(a6)                ;enveloppe en route
          beq music2
          lea tenv(a5),a5
          move.l envad(a5),a0           ;pointe la definition
          clr.b 8(a4,d6.w)              ;remet le volume a zero!
          clr d0
          bsr nxadsr
          bra music2

; ETIQUETTE
music20:  lsr #8,d5
          andi.b #$7f,d5
          bne.s music20a

; fin de la musique sur cette voix: %10000000
music10:  tst musrep(a6)                   ;recommencer?
          beq.s music11
          sub #1,musrep(a6)
          beq music12
music11:  move.w musrepd(a6),muspos(a6)    ;repointe la note ou redemmarrer
          bra music3
music12:  clr (a6)                         ;stop !
          bra music2

; ETIQUETTE SUR UN MOT LONG? (%11xxxxxx) = $c000-DECALAGE SIGNE-
music20a: btst #6,d5
          beq music30
          andi.w #$3f,d5
          move.w 2(a2,d3.w),d2
          ext.l d2
          move.l a2,a0
          add.l d2,a0         ;pointe l'adresse en absolu
          addq #4,d3
          move d3,muspos(a6)  ;pointe la note suivante
; Etiquette MARCHE TREMOBRUIT? (%11000000)+ad = $c0+ad
          tst.b d5
          bne.s music21
          lea tenv*6(a5),a5
          move #1,envlarg(a5)
          bsr stadsr
          bra music3
; Etiquette MARCHE ENVELOPPE? (%11000001)+ad = $c1+ad
music21:  move d6,d0
          mulu #tenv*2,d0
          add d0,a5           ;pointe la table d'enveloppe
          cmpi.b #1,d5
          bne.s music22
          move #1,musenv(a6)  ;flag: il y a une enveloppe!
          lea tenv(a5),a5
          move #1,envlarg(a5)
          bsr stadsr
          bra music3
; Etiquette MARCHE TREMOLO? (%11000010)+ad = $c2+ad
music22:  cmpi.b #2,d5
          bne music23
          move #1,mustre(a6)  ;flag: il y a un tremolo!
          bsr stadsr
          bra music3
; Etiquette REPETITION? (%11000011/nbre de repet/ad)= $c3 NN ADAD
music23:  cmpi.b #3,d5
          bne music3
          clr d1
          move.b -3(a2,d3.w),d1         ;nombre de repetitions
          move.w d1,musrep(a6)
          move.w d2,musrepd(a6)         ;endroit ou redemmarer
          bra music3

; ETIQUETTE SUR UN MOT: %101xxxxx xxxxxxxx = $Axxx
music30:  btst #5,d5
          beq music3
          move.w 0(a2,d3.w),d0    ;prend le mot
          addq #2,d3
          move d3,muspos(a6)      ;avance le pointeur
          andi.w #$1f,d5
          cmpi.w #4,d5
          bcc music35
          move d6,d1
          addq #3,d1
; Etiquette VOIX DE MUSIQUE %101xxxx0 = $a000
          tst.b d5
          bne.s music31
          clr musbrr(a6)      ;flag
          bclr d6,7(a4)       ;met la musique
          bset d1,7(a4)       ;arrete le bruit
          bra.s music34
; Etiquette VOIX DE BRUIT %101xxxx1 =$a100
music31:  cmpi.b #1,d5
          bne.s music32
          move #1,musbrr(a6)  ;flag
          bset d6,7(a4)       ;arrete la musique
          bclr d1,7(a4)       ;met le bruit
          bra.s music34
; Etiquette STOP BRUIT ASSOCIE? %101xxx10 = $a200
music32:  cmpi.b #2,d5
          bne music33
          bset d1,7(a4)
          bra music34
; Etiquette MARCHE BRUIT ASSOCIE? %101xxx11 xxFFFFF = $a3FF f=frequence bruit
music33:  cmpi.b #3,d5
          bne music3
          bclr d1,7(a4)       ;arrete dans la copie
          andi.w #$3f,d0
          move.b d0,6(a4)     ;stocke la frequence dans la copie
          btst d6,d7
          beq music3
          move.b #6,(a3)      ;pointe freq bruit
          move.b d0,2(a3)     ;envoie freq bruit
music34:  btst d6,d7
          beq music3
          bsr mixer           ;envoie au MIXER!
          bra music3

; Etiquette ARRET TREMOBRUIT? (%101xx100 xxxxxxxx) = $a400
music35:  cmpi.b #4,d5
          bne.s music36
          move d6,d1
          mulu #tenv*2,d1
          add d1,a5
          lea tenv*6(a5),a5
          clr (a5)
          bra music3
; Etiquette ARRET ENVELOPPE? (%101xx101 xxxxxxxx) = $a500
music36:  cmpi.b #5,d5
          bne.s music37
          move d6,d1
          mulu #tenv*2,d1
          add d1,a5
          clr musenv(a6)      ;plus d'enveloppe!
          clr tenv(a5)        ;arret de la gestion!
          bra music3
; Etiquette ARRET TREMOLO? (%101xx110 xxxxxxxx) = $a600
music37:  cmpi.b #6,d5
          bne.s music38
          move d6,d1
          mulu #tenv*2,d1
          add d1,a5
          clr mustre(a6)
          clr (a5)            ;arret de la gestion!
          bra music3
; Etiquette VOLUME? (%101xx111 xxxxVVVV)= $a70 -VOLUME-
music38:  cmpi.b #7,d5
          bne music3
          andi.w #$0f,d0
          lea volume(pc),a0
          move.b d0,0(a0,d6.w)
          bra music3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GESTION DES ENVELOPPES ET DES TREMOLOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
adsr:     lea 6*tenv+envmolo,a5
          lea volume(pc),a2
          moveq #6,d6
adsr1:    move.b (a5),d0
          beq.s adsr2
          sub.b d0,envcpt(a5)
          bcs.s adsr3
adsr2:    lea -tenv(a5),a5
          dbra d6,adsr1
; fin du wedge: se rebranche a EVENT MULTI
finwedge: move #1,musicflg
finwedge2:move.l inter(pc),a0
          jmp (a0)

adsr3:    add.b #100,envcpt(a5)
          move d6,d0
          btst #0,d0
          bne.s adsr4
          cmpi.w #6,d0
          beq.s adsr7
; registre de frequence (0/2/4)
          move.w 0(a4,d0.w),d1
          rol.w #8,d1
          sub.w envdec(a5),d1
          ror.w #8,d1
          move.w d1,0(a4,d0.w)         ;change la frequence dans la copy
          lsr #1,d0
          btst d0,d7
          beq.s adsr10
          lsl #1,d0
          move.b d0,(a3)               ;selectionne le registre
          move.b 0(a4,d0.w),2(a3)      ;met la frequence
          addq #1,d0
          move.b d0,(a3)
          move.b d1,2(a3)
          bra.s adsr10
; registre de volume
adsr4:    lsr #1,d0
          clr d1
          move.b 8(a4,d0.w),d1
          add.w envdec(a5),d1
          bpl.s adsr5
          clr d1                       ;passe en dessous de zero
          bra.s adsr6
adsr5:    cmp.b 0(a2,d0.w),d1
          bls.s adsr6
          move.b 0(a2,d0.w),d1
adsr6:    move.b d1,8(a4,d0.w)
          btst d0,d7
          beq adsr10
          addq #8,d0
          move.b d0,(a3)               ;selection du registre
          move.b d1,2(a3)              ;poke le volume
          bra.s adsr10
; registre de bruit
adsr7:    clr d1
          move.b 6(a4),d1
          add.w envdec(a5),d1
          bpl.s adsr8
          clr d1
          bra.s adsr9
adsr8:    cmpi.w #31,d1
          bls.s adsr9
          moveq #31,d1
adsr9:    move.b d1,6(a4)
          move.b #6,(a3)
          move.b d1,2(a3)
; passe au son suivant?
adsr10:   sub.b #1,envnb(a5)
          bne adsr2
; passe au son suivant
          move.l envad(a5),a0
          move.b envpos(a5),d0
          move.b 0(a0,d0.w),d1
          bmi.s adsr11
          bsr.s nxadsr
          bra adsr2
adsr11:   andi.b #$7f,d1
          beq.s adsr12
          clr d0                        ;$80=> stop
          bsr.s nxadsr                  ;$81=> recommence
          bra adsr2
adsr12:   clr.b (a5)                    ;arrete le ADSR
          bra adsr2

; SOUS PGM: PASSE A L' ENVELOPPE/TREMOLO SUIVANTE (A0/D0)
stadsr:   move.l a0,envad(a5)           ;START ADSR: demarre une env/trem
          clr d0
nxadsr:   move.b 0(a0,d0.w),(a5)        ;poke la nouvelle vitesse
          move.b 1(a0,d0.w),envnb(a5)   ;poke le nombre
          move.w 2(a0,d0.w),d1
          muls envlarg(a5),d1           ;rend proprotionnel
          move.w d1,envdec(a5)          ;poke le nouveau decalage
          addq.b #4,d0
          move.b d0,envpos(a5)          ;poke la nouvelle position
          clr.b envcpt(a5)              ;fait demarrer immediatement
          rts

; TRAP #7,1
; START MUSIC: START A MUSIC POINTED BY A0
startmusic:  bsr initsound
          cmp.l #$19631969,(a0)         ;code de verification au debut
          bne stm10
          move.l a0,admusic             ;depart absolu!
          addq.l #4,a0
          move.w (a0)+,tempo            ;tempo!
          clr tempocpt                  ;demarre tout de suite
          clr d1
          lea musique,a6
stm1:     move.w (a0)+,d0               ;si zero: pas en route!
          beq stm2
          move.w d0,musdeb(a6)          ;poke l'ecart de depart
          move.w d0,muspos(a6)          ;commence au debut
          move.w d0,musrepd(a6)         ;par securite!
          move #1,musrep(a6)            ;une seule fois
          move #1,(a6)                  ;tout de suite apres!
          clr musenv(a6)
          clr mustre(a6)
stm2:     lea tmusic(a6),a6
          addq #1,d1
          cmpi.w #3,d1
          bne stm1
          move.l #$0f0f0f00,volume      ;par defaut: volume a 15
          move #1,musicflg              ;reautorise la musique
stm10:    rts

; TRAP #7,0
; Init Sound
; Resets sound generator and kills music
initsound: clr musicflg                  ;plus de musique pour l'instant
          clr transp
          move #7,voixon                ;Remet toutes les voix
          move #7,avoixon
          clr.l VoixOffCpt
          lea musique(pc),a1
          moveq #tmusic*3-1,d0
son1:     clr.b (a1)+                   ;nettoie la table musique
          dbra d0,son1
          lea envmolo(pc),a1
          moveq #tenv*7-1,d0
son2:     clr.b (a1)+
          dbra d0,son2
          moveq #13,d0
          lea chipcopy(pc),a1
son3:     clr.b (a1)+                   ;nettoie la table du circuit
          dbra d0,son3
          lea chipcopy(pc),a4
          move.b #%111000,7(a4)         ;par defaut: 3 voix, pas de bruit
          lea chip,a3
; ENVOIE TOUTE LA COPIE DANS LE CIRCUIT SON
pokechip: moveq #13,d2                  ;13 registres
pkchp1:   cmpi.w #7,d2
          bne pkchp2
          bsr mixer
          bra pkchp3
pkchp2:   move.b d2,(a3)                ;selection du registre
          move.b 0(a4,d2.w),2(a3)       ;envoie le son
pkchp3:   dbra d2,pkchp1
          rts

; ENVOIE LE MIXER DANS LE CIRCUIT SON
mixer:    move.b #7,(a3)                ;selection du mixer
          move.b 7(a4),d0
          andi.b #$3f,d0                 ;enleve le port E/S
          move.b (a3),d1
          andi.b #$c0,d1                 ;garde le port E/S
          or.b d1,d0
          move.b d0,2(a3)
          rts

; TRAP #7,2
; STOP A VOICE
; D1= number of voice
; D2= 50th duration of the shutdown
stopvoice: andi.w #3,d1
          beq stpvx
          subq #1,d1
          lea voixon(pc),a0            ;Stop the voice
          move.w (a0),d0
          bclr d1,d0
          move d0,(a0)
          lea VoixOffCpt(pc),a0         ;Poke le delai
          move.b d2,0(a0,d1.w)
          lea chip,a0                   ;Volume a zero!
          addq.w #8,d1
          move.b d1,(a0)
          clr.b 2(a0)
stpvx:    rts

; TRAP #7,3
; TURN ON A VOICE
; D1= number of voice
restartvoice:
          andi.w #3,d1
          beq.s restart1
          subq #1,d1
          lea voixon(pc),a0            ;Remet la voix
          move.w (a0),d0
          bset d1,d0
          move d0,(a0)
          lea VoixOffCpt(pc),a0          ;Arrete l'arret automatique
          clr.b 0(a0,d1.w)
restart1:
          rts

; TRAP #7,4
; FREEZE MUSIC
freeze:   lea freezflg(pc),a3
		  clr.w (a3)
          tst.w musicflg-freezflg(a3)
          beq frzz1
          clr musicflg-freezflg(a3)
          move #1,(a3)
          lea chip,a3
          moveq #8,d0
frzz0:    move.b d0,(a3)                ;Volume des trois voix a zero!
          clr.b 2(a3)
          addq.w #1,d0
          cmpi.w #11,d0
          bne.s frzz0
frzz1:    rts

; TRAP #7,5
; UNFREEZE MUSIC
unfreeze:
          lea chipcopy(pc),a4
          tst.w freezflg-chipcopy(a4)
          beq.s unfreeze1
          lea chip,a3
          bsr pokechip        ;remet la musique
          clr freezflg-chipcopy(a4)
          move #1,musicflg-chipcopy(a4)
unfreeze1:
          rts

; TRAP #7,6
; CHANGE TEMPO
chgtempo: cmpi.w #100,d1
          bhi.s chgt1
		  lea tempo(pc),a3
          move.w d1,(a3)
chgt1:    rts


; TRAP #7,9
; CHANGE TRANSPOSITION
transpose:
		  lea transp(pc),a3
		  move.w d1,(a3)
          rts

; TRAP #7,10
; GET VOICE POS (D1)
voicepos: andi.w #3,d1
          beq.s vp1
          subq #1,d1
          mulu #tmusic,d1
          lea musique(pc),a0
          moveq #0,d0
          tst muscpt(a0,d1.w)                ;bring back 0 if the music is off
          beq.s vp1
          move.w musold(a0,d1.w),d0     ;sinon, ramene la position ACTUELLE
vp1:      rts




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          .IFNE FALCON
          .include "dsptrack.s"
          .ENDC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

finmusic:
