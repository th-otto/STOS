************************************************
* D‚sassemblage de BASIC206.PRG                *
*      Par Pink Elephant Software Inc .        *
*                 Juin 1992                    *
************************************************
/*        opt     d+ */
/*        output  basload.prg */

	.include "adapt.inc"

	.text

Debut:  BRA     start

; Adaptation tables
; In order :
; Word: Tos version
; .l  : Mouse adr (linea-602, GCURX)
; .l  : Adr joystick (#Joy_Pos)
; .l  : Keyboard Buffer (Iorec(1))
; .l  : Table Vdi 1 (linea-692, DEV_TAB)
; .l  : Table Vdi 2 (linea-498, SIZ_TAB)
; .l  : Mouse interrupt vector (Kbdvbase())
; .l  : Start of a sound (sndtable)
tosversion: .dc.w    0
Adapt:      .ds.b    adapt_sizeof

extend:	.ds.l     26             ;26 adresses d'extensions

dta:    .ds.w    13              ;Buffer DTA
size:   .dc.l    0               ;Taille du fichier
name:   .dc.w    0               ;Son nom
        .ds.w    9               ;Buffer Dta (Suite)

Joy_Sav:  .dc.l	0		; Gestion du joystick
Joy_Pos:  .dc.l	0
Joy_Ad:	  .dc.l	0
fake_sndtable: ds.b 6

end_adr: .dc.l    0               ;Adresse fin de fichier
logic:   .dc.l    0               ;Adresse de l'‚cran logique
res:     .dc.w    0               ;R‚solution au boot
handle:  .dc.w    0               ;Handle de fichier
Cmd_Tail:.dc.l    0              ;Command Tail
sav_col: .ds.w    16              ;Buffer for 16 colors
vdi_1:   .ds.w    45             ;Table VDI 1 (devtab)
         .ds.w    12             ;Table VDI 2 (siztab)
         .ds.l    1               ;mouse coordinates


curs_off:
        .dc.b    27,'f',27,'v',0  ;Curs Off
folder:  .dc.b    "\stos",0       ;Folder \Stos

path:    .ds.b    128             ;Buffer
newpath: .ds.b    128             ;Autre buffer
piclow:  .dc.b    "pic.pi1",0     ;Image basse r‚olution
pichi:   .dc.b    "pic.pi3",0     ;Image haute r‚solution
sprit:   .dc.b    "sprites.bin",0 ; Sprite trap
windo:   .dc.b    "window.bin",0 ; Window Trap
float:   .dc.b    "float.bin",0 ; Float Trap
music:   .dc.b    "music.bin",0 ; Music Trap
basic:   .dc.b    "basic.bin",0 ; Basic lui meme
namext:  .dc.b "*.ex"
numbext: .dc.b 0,0
        even
BUFFER3: .ds.b    13
        EVEN
;D‚but du programme
LOADER: .dc.b    "BASLOAD.PRG",0
        EVEN

start:  lea Cmd_Tail(pc),a6
        clr.l (a6)
        movea.l 4(a7),a0        ;Adresse Basepage
        lea     128(a0),a0      ;Nb de caractŠres ds ligne de commande
        tst.b   (a0)            ;=0 ?
        beq.s   Skip0          ;cherche Adr logique
        addq.l  #1,a0           ;Ligne de commande
        move.l  a0,(a6)         ;Stocke son adresse
Skip0:
; Trouve les adresses en respectant le systeme
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	lea	Adapt(pc),a6
	.dc.w	$a000
	lea	-602(a0),a1	; Position souris
	move.l	a1,adapt_gcurx(a6)
	lea	-692(a0),a1	; Table VDI 1
	move.l	a1,adapt_devtab(a6)
	lea	-498(a0),a1	; Table VDI 2
	move.l	a1,adapt_siztab(a6)
	lea fake_sndtable(pc),a1
	move.l  a1,adapt_sndtable(a6)

	move.w	#1,-(sp)	; Adresse du buffer clavier
	move.w	#14,-(sp)   ; Iorec
	trap 	#14
	addq.l	#4,sp
	move.l	d0,adapt_kbiorec(a6)

	move.w	#34,-(sp)	; Adresse des interruptions souris
	trap 	#14
	addq.l	#2,sp
	move.l	d0,a0
	move.l	a0,adapt_kbdvbase(a6)
	lea	24(a0),a0
	lea Joy_Pos(pc),a1
	move.l	a0,Joy_Ad-Joy_Pos(a1)
	move.l	(a0),Joy_Sav-Joy_Pos(a1)
	move.l	a1,adapt_joy(a6)		; Adresse du resultat
	lea Joy_In(pc),a1
	move.l	a1,(a0)		; Branche la routine joystick

; Trouve l'adresse de l'‚cran
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~
        move.w  #3,-(a7)        ;Logbase
        trap    #14
        addq.l  #2,a7
        lea logic(pc),a0
        move.l  d0,(a0)         ;Range adresse logic
        pea     sav_vect(pc)    ;Sauvegarde la configuration
        move.w  #38,-(a7)       ;Supexec
        trap    #14
        addq.l  #6,a7
        lea     vdi_1(pc),a6
        move.w  #4,-(a7)        ;Getrez
        trap    #14
        addq.l  #2,a7
        lea     Adapt(pc),a5    ;Adresse vecteurs
        move.w  d0,res-Adapt(a5)    ;Range r‚solution
        move.w  d0,d7
        movea.l adapt_devtab(a5),a0       ;Adr Table VDI 1
        moveq   #45-1,d0        ;Copie 45 mots
bcl1:
        move.w  (a0)+,(a6)+     ;(Soit 90 octets)
        dbf     d0,bcl1         ;
        movea.l adapt_siztab(a5),a0       ;Adresse Table VDI 2
        moveq   #12-1,d0        ;Copier 12 mots
bcl2:
        move.w  (a0)+,(a6)+     ;(Soit 24 octets)
        dbf     d0,bcl2
        movea.l adapt_gcurx(a5),a0
        move.l  (a0),(a6)+      ;mouse coordinates
        lea EXIT(pc),a0
        lea end_adr(pc),a1
        move.l a0,(a1)          ;BASLOAD.PRG end address
        bsr     set_dta         ;Fixe tampon I/O
        clr.w   -(a7)           ;Unit‚ actuelle
        pea     path(pc)        ;Buffer de 64 octets : chemin d'accŠs
        move.w  #$47,-(a7)      ;Dgetpath
        trap    #1
        addq.l  #8,a7
        tst.w   d0
        bne     set_scr         ;ProblŠme...
        lea     path(pc),a0     ;Chemin actuel
        lea     newpath(pc),a1  ;Recopie ds un buffer
Copy_path:
        move.b  (a0)+,(a1)+
        bne.s   Copy_path
        lea     path(pc),a0
        tst.b   (a0)            ;Fin du chemin ?
        bne.s   lbl1            ;Non , d‚cr‚mente
        move.b  #'\',(a0)+      ;Antislash
        clr.b   (a0)            ;Fin de chemin
lbl1:
        subq.l  #1,a1
        lea     folder(pc),a0   ;Recopie \STOS
Copy_Folder:
        move.b  (a0)+,(a1)+
        bne.s   Copy_Folder
        lea     newpath(pc),a0  ;Fixe chemin \STOS
        bsr     set_path
        bne     Error1          ;Pas trouv‚
        cmpi.w  #2,d7           ;High resolution?
        beq.s   hi_res          ;vouiiiiii!
        lea     piclow(pc),a0   ;'PIC.PI1' : zouli image
        bra.s   affiche         ;Va la chercher
hi_res:
        lea     pichi(pc),a0    ;'PIC.PI3'
affiche:
        bsr     fs_first        ;Existe-t-elle ?
        bne     No_Image        ;Non...
        bsr     fopen           ;
        movea.l logic(pc),a0    ;Logic-32768 : Back
        suba.l  #32768,a0       ;...
        move.l  #32034,d0       ;Lire 32034 octets (Degas)
        bsr     fread           ;Lit
        bsr     fclose          ;Ferme

        .dc.w    $a00a           ;mouse cover
        tst.w   d7              ;Low Res ?
        beq     fix_scr         ;Oui
        cmpi.w  #2,d7           ;Hi Res ?
        beq     fix_scr         ;Oui
        clr.w   -(a7)           ;Mid Res: passe en basse
        moveq   #-1,d0
        move.l  d0,-(a7)
        move.l  d0,-(a7)
        move.w  #5,-(a7)        ;Setscreen
        trap    #14
        lea     12(a7),a7
fix_scr:
        lea     curs_off(pc),a0 ;EnlŠve curseur
        bsr     print           ;Emulation VT52
        move.l  logic(pc),-(a7) ;
        subi.l  #32766,(a7)     ;Adresse palette
        move.w  #6,-(a7)        ;Setpalette
        trap    #14
        addq.l  #6,a7
        moveq   #1,d6

; Recopie l'image avec un effet...

copy_scr:
        movea.l logic(pc),a2
        movea.l a2,a3
        adda.l  #99*160,a2      ;Ligne 99
        adda.l  #100*160,a3     ;Ligne 100
        movea.l a2,a0
        movea.l a3,a1
        suba.l  #32734,a0
        suba.l  #32734,a1
        moveq   #99,d7
        addq.w  #1,d6
        cmp.w   #100,d6         ;Ligne 100 atteinte ?
        bhi     load            ;Oui...
        moveq   #50,d5
Effect:
        add.w   d6,d5
        cmp.w   #100,d5
        bcs.s   cpy_scr
        subi.w  #100,d5
        movem.l a0-a3,-(a7)
        moveq   #9,d0
BitMap_Copy:
        move.l  (a0)+,(a2)+
        move.l  (a0)+,(a2)+
        move.l  (a0)+,(a2)+
        move.l  (a0)+,(a2)+
        move.l  (a1)+,(a3)+
        move.l  (a1)+,(a3)+
        move.l  (a1)+,(a3)+
        move.l  (a1)+,(a3)+
        dbf     d0,BitMap_Copy
        movem.l (a7)+,a0-a3
        suba.l  #160,a2
        adda.l  #160,a3
cpy_scr:
        suba.l  #160,a0
        adda.l  #160,a1
        dbf     d7,Effect
        bra     copy_scr
No_Image:
        .dc.w   $a00a           ;Cache la souris
        lea     curs_off(pc),a0 ;EnlŠve le curseur
        bsr     print
load:
        lea     sprit(pc),a0    ;Filtre 'SPRIT???.BIN'
        bsr     get_im          ;Charge fichier
        lea     Adapt(pc),a3    ;Adresses
        jsr     (a0)            ;Installe trappe
        lea end_adr(pc),a1
        move.l  a0,(a1)

        lea     windo(pc),a0    ;Filtre 'WINDO???.BIN'
        bsr     get_im          ;Charge fichier
        lea     Adapt(pc),a3    ;Adresses
        jsr     (a0)            ;Installe trappe
        lea end_adr(pc),a1
        move.l  a0,(a1)

        lea     float(pc),a0    ;Filtre 'FLOAT???.BIN'
        bsr     get_bin         ;Charge fichier
        bne     load_zik        ;Si pas l… , tant pis!
        lea     Adapt(pc),a3    ;Adresses
        jsr     (a0)            ;Installe trappe

load_zik:
        lea     music(pc),a0    ;Filtre 'MUSIC???.BIN'
        bsr     get_im          ;Charge fichier
        lea     Adapt(pc),a3    ;Adresses
        jsr     (a0)            ;Installe trappe
        lea end_adr(pc),a1
        move.l  a0,(a1)

; charge et appelle les extensions, poke les adresses
        clr     d7
        lea     extend(pc),a6
load5:  move.b  d7,numbext-extend(a6)
        add.b   #'a',numbext-extend(a6)
        lea     namext(pc),a0
        bsr     fs_first
        bne.s   load6
        lea     namext(pc),a0
        bsr     get_im
        movem.l a6/d6/d7,-(sp)
        lea     Adapt(pc),a3
        jsr     (a0)
        lea end_adr(pc),a2
        move.l  a0,(a2)
        movem.l (sp)+,a6/d6/d7
        move    d7,d6
        lsl     #2,d6
        move.l  a1,0(a6,d6.w)          ;poke l'adresse de debut
load6:  addq    #1,d7
        cmp     #26,d7
        bcs.s   load5

        lea     basic(pc),a0    ;Filtre 'BASIC???.BIN'
        bsr     get_im          ;Charger
        move.l  a0,-(a7)        ;Sauve l'adresse sur la pile
        lea     path(pc),a0     ;Chemin de boot
        bsr     set_path        ;Le remettre
        movea.l (a7)+,a6        ;Adresse BASIC.BIN
        move.w  #$25,-(a7)      ;Vsync
        trap    #14
        addq.l  #2,a7
        movea.l logic(pc),a0    ;effacer logic
        move.w  #7999,d0        ;8000-1 (dbf)
cls:
        clr.l   (a0)+
        dbf     d0,cls
        move.w  res(pc),d7
        cmpi.w  #2,d7           ;Haute r‚solution ?
        beq.s   hi              ;oui
        move.w  #1,-(a7)        ;MidRes
        moveq   #-1,d0
        move.l  d0,-(a7)
        move.l  d0,-(a7)
        move.w  #5,-(a7)        ;Setscreen
        trap    #14
        lea     12(a7),a7
hi:
        lea     extend(pc),a0   ;Extensions address
        lea     Adapt(pc),a3    ;Address adaptations
        movea.l Cmd_Tail(pc),a4 ;Command Tail
        clr.l   d0              ;d0=0
        jsr     (a6)            ;Saute au basic
        bra     set_scr         ;fin du basic

; Erreur de chargement >>> sortie
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
errmsg:
        .dc.b " not found",13,10,0
        .even
ErrorLoad:
        bsr print
        lea errmsg(pc),a0
        bsr print
        move.w #8,-(a7)
        trap #1
        addq.w #2,a7
        bra.s Error1
Error:
        bsr     fclose
Error1:
        lea     path(pc),a0
        bsr     set_path
; Restoration du systeme
; ~~~~~~~~~~~~~~~~~~~~~~
set_scr:
; Restore la routine d'entree du joystick
	move.l	Joy_Ad(pc),d0
	beq.s	Skip
	move.l	d0,a0
	move.l	Joy_Sav(pc),(a0)
Skip:
; Les ecrans
        move.w  res(pc),-(a7)   ;restore r‚solution
        move.l  logic(pc),-(a7) ;adresses ‚crans
        move.l  logic(pc),-(a7)
        move.w  #5,-(a7)        ;Setscreen
        trap    #14
        lea     12(a7),a7

        lea     vdi_1(pc),a6    ;Remet vecteurs
        lea     Adapt(pc),a5
        movea.l adapt_devtab(a5),a0
        moveq   #45-1,d0
bcl7:
        move.w  (a6)+,(a0)+
        dbf     d0,bcl7
        movea.l adapt_siztab(a5),a0
        moveq   #12-1,d0
bcl8:
        move.w  (a6)+,(a0)+
        dbf     d0,bcl8
        movea.l adapt_gcurx(a5),a0
        move.l  (a6)+,(a5)
        pea     sav_col(pc)     ;Remet couleurs
        move.w  #6,-(a7)        ;Setpalette
        trap    #14
        addq.l  #6,a7
        move.w  #$25,-(a7)      ;Vsync
        trap    #14
        addq.l  #2,a7
        clr.w   -(a7)           ;Pterm
        trap    #1

; Routine d'entree du joystick
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Joy_In:	lea Joy_Pos(pc),a2
        move.b	2(a0),(a2)
        rts

; En superviseur
; ~~~~~~~~~~~~~~~
sav_vect:
; Copie de la palette
        lea     $ffff8240,a0
        lea     sav_col(pc),a1
        moveq   #$F,d0
bcl8A:
        move.w  (a0)+,(a1)+
        dbf     d0,bcl8A
; Fausse trappe float
        lea     fake_fl(pc),a0
        move.l  a0,$98
        rts

; Fausse trap float
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fake_fl:cmp.b   #12,d0
        beq.s   fltoa
        moveq   #0,d0
        moveq   #0,d1
        rte
; Fonction $c 'FLTOA'
; ~~~~~~~~~~~~~~~~~~~
fltoa:  move.b  #'0',(a0)
        move.b  #'.',1(a0)
        move.b  #'0',2(a0)
        clr.b   3(a0)
        rte

; Routines d'interfa‡age disque
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fsnext:
        move.w  #$4f,-(sp)
        trap    #1
        addq.l  #2,sp
        rts
set_dta:
        move.l  a0,-(a7)
        pea     dta(pc)
        move.w  #26,-(a7)
        trap    #1
        addq.l  #6,a7
        movea.l (a7)+,a0
        rts

set_path:
        move.l  a0,-(a7)
        move.w  #59,-(a7)
        trap    #1
        addq.l  #6,a7
        tst.w   d0
        rts

fs_first:
        move.l  a0,-(a7)
        clr.w   -(a7)
        move.l  a0,-(a7)
        move.w  #78,-(a7)
        trap    #1
        addq.l  #8,a7
        move.l  (a7)+,a0
        tst.w   d0
        bne.s   fsfirst1
        lea     name(pc),a0
fsfirst1:
        rts

fopen:
        clr.w   -(a7)
        move.l  a0,-(a7)
        move.w  #61,-(a7)
        trap    #1
        addq.l  #8,a7
        tst.w   d0
        bmi     Error1
        lea handle(pc),a0
        move.w  d0,(a0)
        rts

charge:
        move.l  size(pc),d0
fread:
        move.l  a0,-(a7)
        move.l  d0,-(a7)
        move.w  handle(pc),-(a7)
        move.w  #63,-(a7)
        trap    #1
        lea     12(a7),a7
        tst.l   d0
        bmi     Error
        rts
fclose:
        move.w  handle(pc),-(a7)
        move.w  #62,-(a7)
        trap    #1
        addq.l  #4,a7
        rts
print:
        move.l  a0,-(a7)
        move.w  #9,-(a7)
        trap    #1
        addq.l  #6,a7
        rts
get_im:
        bsr     get_bin
        bne     ErrorLoad
        rts
get_bin:
        movem.l d1-d7/a1-a6,-(a7)
        bsr     set_dta
        bsr     fs_first
        bne     failed
        move.l  end_adr(pc),d3
        add.l   size(pc),d3
        addi.l  #60000,d3
        cmp.l   logic(pc),d3
        bcc     Error
        bsr     fopen
        movea.l end_adr(pc),a0
        bsr     charge
        bsr     fclose
        movea.l end_adr(pc),a1
        move.l  $2(a1),d0
        add.l   6(a1),d0
        andi.l  #$ffffff,d0
        adda.w  #28,a1
        movea.l a1,a2
        move.l  a2,d2
        adda.l  d0,a1
        clr.l   d0
        tst.l   (a1)
        beq.s   reloge
        adda.l  (a1)+,a2
        bra.s   noerr
err:
        move.b  (a1)+,d0
        beq.s   reloge
        cmp.b   #1,d0
        beq.s   do_asc
        adda.w  d0,a2
noerr:
        add.l   d2,(a2)
        bra.s   err
do_asc:
        adda.w  #254,a2
        bra.s   err
reloge:
        lea.l   end_adr(pc),a0
        move.l  (a0),d0
        move.l  d0,d1
        add.l   size(pc),d1
        btst    #0,d1
        beq.s   pair
        addq.l  #1,d1
pair:
        move.l  d1,(a0)
        movem.l (a7)+,d1-d7/a1-a6
        move.l  d0,a0
        moveq   #0,d0
        rts
failed:
        movem.l (a7)+,d1-d7/a1-a6
        moveq   #1,d0
        rts

EXIT:   .dc.l    0
