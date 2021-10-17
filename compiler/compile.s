;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   |COMPILATEUR STOS BASIC 29/12/1990|       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

        .include "lib.inc"
        .include "equates.inc"
        .include "adapt.inc"
        .include "tokens.inc"
        .include "system.inc"
        .include "window.inc"
        .include "music.inc"
        .include "sprites.inc"
        .include "float.inc"
        .include "errors.inc"

        .text

*************************************************************************
    bra.w setpar    ;JUMP set params
    bra.w DStos     ;JUMP compile
    bra.w Grab      ;GRABber de programmes
    bra.w Version   ;Get version number
*************************************************************************

;-------------------------> Management of the 30 open files!
Poignee         = 0
Longfyche       = 2
Posfyche        = 6
TFyche          = 10
Nfyche          = 32

DebD           = 128                 ;DeD-debprg
**********************************
; Non relocatables
atable         = DebD+$00            ;Adresse de la table
otbufsp        = DebD+$04
omaxcop        = DebD+$08
ovide          = DebD+$12
; relocatables
debrel         = DebD+$10
ochvide        = DebD+$10            ;Chaine vide
oreloc         = DebD+$14            ;debut de la table de relocation
otrappes       = DebD+$18            ;debut des buffers trappes
oerror         = DebD+$1c            ;Traitement des erreur
oliad          = DebD+$20            ;table #LIGNE----> ADRESSE
oadstr         = DebD+$24
ofdata         = DebD+$28
oadmenu        = DebD+$2C
otrap3         = DebD+$30            ;Adresses des trappes
otrap5         = DebD+$34
otrap6         = DebD+$38
otrap7         = DebD+$3C
oext           = DebD+$40            ;Offset (debut/fin) des 26 extensions
ocr0           = MAX_EXTENSIONS*8+oext
ocr1           = ocr0+4
ocr2           = ocr1+4
omou           = ocr2+4
LDeb           = omou+4

*************************************************************************

cdta:   ds 48
SauveP: dc.l 0

;-------------------------------------> Variables compilateur

debwork:        dc.l 0          ;Zone de travail
topwork:        dc.l 0
tbuffers:       dc.l 0

Source:         dc.l 0          ;Adresse du code source
LSource:        dc.l 0
LFile:          dc.l 0

stobjet:        dc.l 0          ;Adresse du debut objet
objet:          dc.l 0          ;Adresse du debut du PROGRAMME

BReloc:         dc.l 0          ;table de relocation
OldRel:         dc.l 0

hivar:          dc.l 0          ;table des variables
lovar:          dc.l 0
botvar:         dc.l 0
AdADefn:        dc.l 0
ADefn:          dc.l 0

routin:         dc.l 0          ;routines a charger
bufcalc:        dc.l 0          ;Pile des expressions

LongCode:       dc.l 0          ;Longueur du code
LongRel:        dc.l 0          ;Longueur table de relocation
LongChai:       dc.l 0          ;Longueur des chaines
LongProg:       dc.l 0          ;Longueur des trois
LongBank:       dc.l 0          ;Longueur des banques
LongOb:         dc.l 0          ;Longueur totale de l'objet
LongVar:        dc.l 0          ;Longueur des variables RUN-TIME

litoad:         dc.l 0          ;table numeros de ligne ---> adresses pgm
alitoad:        dc.l 0
nblines:        dc.w 0
adline:         dc.l 0
curline:        dc.w 0
newline:        dc.l 0
parenth:        dc.w 0
flagstos:       dc.w 0
CptInst:        dc.w 0

AdChai:         dc.l 0
BAdChai:        dc.l 0
Badstring:      dc.l 0
adstring:       dc.l 0
BufVar:         ds.b 64
passe:          dc.w 0

; Tests cycliques
Tests:          dc.w 1

; Pointeurs boucles
coldf:          dc.l 0          ;Oldfind
cnboucle:       dc.w 0
ctstnbcle:      dc.w 0
cposbcle:       dc.l 0
ccptnext:       dc.w 0

; Pile des boucles (28 octets / boucle)
cmaxbcle:       ds 28*10
cbufbcle:

; Pile des IF THEN ELSE
Pif:            dc.l 0
Tif:            dc.l 0

; Datas
FstData:        dc.l 0
OlData:         dc.l 0

; Flag GEM RUN
cflaggem:       dc.w 0          ;0= STOS-RUN / 1= GEM-RUN

; Flag MENUS
menucall:       dc.l 0
flagmenu:       dc.w 0

; Librairies
AdCata:         dc.l 0
OLibr:          dc.l 0

; Interface stos / Chargements / Extensions
nomin:          dc.l 0
nomout:         dc.l 0
prgnb:          dc.w 0
vtable:         dc.l 0
advector:       dc.l 0
ADtprg:         dc.l 0
ADtbnk:         dc.l 0
AdExtAd:        dc.l 0
AdExtAp:        dc.l 0
AdExtPa:        dc.l 0
PAdExtAd:       dc.l 0
PAdExtAp:       dc.l 0
BufLoad:        dc.l 0
MaxLoad:        dc.l 0
extflag:        dc.l 0
floflag:        dc.w 0
ValFlo:         dc.w 0
nomcr0:         dc.l 0
nomcr1:         dc.l 0
nomcr2:         dc.l 0
nommou:         dc.l 0
tbufsp:         dc.l 2500
maxcop:         dc.l 32000
bufob:          dc.l 0
debbob:         dc.l 0
finbob:         dc.l 0
topob:          dc.l 0
maxbob:         dc.l 0
bordbob:        dc.l 0
BufSou:         dc.l 0
TopSou:         dc.l 0
MaxBso:         dc.l 0
BordBso:        dc.l 0
DebBso:         dc.l 0
FinBso:         dc.l 0

; Affichage compilation
LigneA:     dc.l 0
resol:      dc.w 0
XLine:      dc.w 0
YLine:      dc.w 0
LBar:       dc.w 0
HBar:       dc.w 0
BasBar:     dc.w 0
Bar1:       dc.w 0
Bar2:       dc.w 0
Bar3:       dc.w 0
Bar4:       dc.w 0
Bar5:       dc.w 0
LongSou:    dc.l 0
CptRout:    dc.l 0
NbRout:     dc.l 0

; Filtres / Noms des fichiers
nomsrc:         dc.b "ESSAI.BAS",0
nomobj:         dc.b "ESSAIRUN.PRG",0
nomlib:         dc.b "COMPILER\BASIC*.LIB",0
nomspr:         dc.b "COMPILER\SPRIT*.LIB",0
nomwin:         dc.b "COMPILER\WINDO*.LIB",0
nommus:         dc.b "COMPILER\MUSIC*.LIB",0
nomflo:         dc.b "COMPILER\FLOAT*.LIB",0
ncr0:           dc.b "COMPILER\8X8.CR0",0
ncr1:           dc.b "COMPILER\8X8.CR1",0
ncr2:           dc.b "COMPILER\8X16.CR2",0
nmouse:         dc.b "COMPILER\MOUSE.SPR",0
nomext:         dc.b "COMPILER\*.EC?",0
nomdisk:        dc.b "COMPILER\"
bufdisk:        ds.b 16

        even

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | TABLE DES JUMPS COMPILATION     |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
debop           = $EA
DebFonc         = $B8

jumps:  dc.l csynt     ; $80
        dc.l csynt
        dc.l Cnext
        dc.l Cwend
        dc.l Cuntil
        dc.l Cdim
        dc.l pok
        dc.l dok
        dc.l lok
        dc.l Cread
        dc.l Crem
        dc.l Creturn
        dc.l Cpop
        dc.l Cresn
        dc.l Cresume
        dc.l Conerrror
        dc.l Cscreencopy  ; $90
        dc.l Cswap
        dc.l Cplot
        dc.l Cpie
        dc.l Cdraw
        dc.l Cpolyline
        dc.l Cpolymark
        dc.l csynt
        dc.l Cgoto
        dc.l Cgosub
        dc.l csynt
        dc.l Celse
        dc.l Crestore
        dc.l Cfor
        dc.l Cwhile
        dc.l Crepeat
        dc.l Cextensions   ; $a0
        dc.l Cprint
        dc.l Cif
        dc.l Cupdate
        dc.l Csprite
        dc.l Cfreeze
        dc.l Coff
        dc.l Con
        dc.l Cextensionsi
        dc.l Clocate
        dc.l Cpaper
        dc.l Cpen
        dc.l Chome
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l Ccup          ; $b0
        dc.l Ccdown
        dc.l Ccleft
        dc.l Ccright
        dc.l Ccls
        dc.l Cinc
        dc.l Cdec
        dc.l Cscreenswap
; Fonctions/instructions
        dc.l csynt
        dc.l Cpsg
        dc.l csynt
        dc.l Cdreg
        dc.l Careg
        dc.l csynt
        dc.l Csetdrive2
        dc.l Csetdir
        dc.l csynt
        dc.l csynt
        dc.l Ccolour
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l Csetdrive
        dc.l Csettimer
        dc.l Clog
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l Cmidset
        dc.l CIright
        dc.l CIleft
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l Cxmouse
        dc.l Cymouse
        dc.l csynt
        dc.l Csetphysic
        dc.l Cback
        dc.l csynt
        dc.l Cpofset
        dc.l Csmode
        dc.l Csettime
        dc.l Csetdate
        dc.l Cscreenput
        dc.l Cdefault
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l Clet
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt

; ADRESSE DES FONCTIONS
fnjumps:dc.l FEten
        dc.l CFpsg
        dc.l CFTSc
        dc.l CFDrg
        dc.l CFArg
        dc.l CPoin
        dc.l Cgetdrive
        dc.l Cgetdir
        dc.l Cextf
        dc.l CAbs
        dc.l CFCol
        dc.l CFKey
        dc.l CSin
        dc.l CCos
        dc.l Cgetdrive2
        dc.l Cgettimer
        dc.l Cflog
        dc.l CFn
        dc.l CNot
        dc.l CRnd
        dc.l CVal
        dc.l Casc
        dc.l Cchr
        dc.l CInky
        dc.l Cscancode
        dc.l Cmidget
        dc.l Cright
        dc.l Cleft
        dc.l CLeng
        dc.l Cstart
        dc.l CLen
        dc.l CPi
        dc.l pik
        dc.l dik
        dc.l lik
        dc.l CZo
        dc.l Cxsprite
        dc.l Cysprite
        dc.l CFXm
        dc.l CFYm
        dc.l CFKm
        dc.l Cgetphysic
        dc.l CFBak
        dc.l Clog1
        dc.l Cpofget
        dc.l Cfmode
        dc.l CTime
        dc.l CDate
        dc.l Cscreenget
        dc.l CFDfo
; ... operateurs
        dc.l csynt             ;$E0-$E9
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
; ... variable
        dc.l Var
; ... constantes                    ;$F0-$Ff
        dc.l CEnt
        dc.l CChai
        dc.l CEnt
        dc.l CEnt
        dc.l CFlo

; ADRESSE DES OPERATEURS
opjumps:dc.l csynt                   ;$EA-$Ef
        dc.l CXor
        dc.l COr
        dc.l CAnd
        dc.l CDiff
        dc.l CInfe
        dc.l CSupe                   ;$F0-$Ff
        dc.l CEgal
        dc.l CInf
        dc.l CSup
        dc.l CPlus
        dc.l CMoin
        dc.l Cmodu
        dc.l CMult
        dc.l CDivi
        dc.l CPuis
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt

; ADRESSE DES INSTRUCTIONS ETENDUES
ExtJump:dc.l Cdirw
        dc.l CFad
        dc.l Cbcop
        dc.l CSqa
        dc.l Cprevious
        dc.l Ctranspose
        dc.l CShif
        dc.l Cwaitkey
        dc.l CDir
        dc.l CLDir
        dc.l CBlo
        dc.l CBsa
        dc.l Cqwdo
        dc.l csynt
        dc.l Ccharcopy
        dc.l Cund
        dc.l Cmenu
        dc.l Cmeno
        dc.l Ctit
        dc.l CBor
        dc.l CHard
        dc.l CWind
        dc.l Credr
        dc.l Ccen
        dc.l Ctempo
        dc.l CVol
        dc.l CEnv
        dc.l CExpl
        dc.l Cshoot
        dc.l CPing
        dc.l CNaut
        dc.l CNoi
        dc.l CVoi
        dc.l CMus
        dc.l CBox
        dc.l CRBox
        dc.l CBar
        dc.l CRBar
        dc.l CApp
        dc.l Cbclr
        dc.l Cbset
        dc.l CRol
        dc.l CRor
        dc.l Ccurs
        dc.l CClw
        dc.l Cbchg
        dc.l Ccall
        dc.l Ctrap
        dc.l csynt
        dc.l CRun
        dc.l Cclky
        dc.l Clinp
        dc.l CInpu
        dc.l csynt
        dc.l CData
        dc.l CEnd
        dc.l Cerase
        dc.l CRese
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l csynt
        dc.l CCopy
        dc.l CDef
        dc.l CHid
        dc.l CSho
        dc.l CChgm
        dc.l CLimm
        dc.l Cmovex
        dc.l Cmovey
        dc.l Cfix
        dc.l Cbgra
        dc.l csynt
        dc.l CFill
        dc.l csynt
        dc.l Ckeyspeed
        dc.l CMve
        dc.l CAni
        dc.l Cunfreeze
        dc.l Csetzone
        dc.l Cresetzone
        dc.l Climitsprite
        dc.l Cpri
        dc.l CRedu
        dc.l Cputsprite
        dc.l Cgetsprite
        dc.l CLoad
        dc.l CSave
        dc.l CPal
        dc.l CSync
        dc.l CErr
        dc.l Cbreak
        dc.l CLLet
        dc.l CKey
        dc.l COpin
        dc.l COpou
        dc.l COpen
        dc.l CClo
        dc.l CFiel
        dc.l csynt
        dc.l Cputkey
        dc.l CGPal
        dc.l CKill
        dc.l CRena
        dc.l Crmdir
        dc.l Cmkdir
        dc.l CStop
        dc.l Cwvbl
        dc.l CSort
        dc.l CGet
        dc.l CFlas
        dc.l csynt
        dc.l Clprt
        dc.l CAuto
        dc.l Csetline
        dc.l Cgrwriting
        dc.l Csetmark
        dc.l Csetpaint
        dc.l csynt
        dc.l Csetpattern
        dc.l Cclip
        dc.l Carc
        dc.l Cpolygone
        dc.l Ccircle
        dc.l CEarc
        dc.l CEpie
        dc.l Cellipse
        dc.l CWr
        dc.l Cpaint
        dc.l Cink
        dc.l CWait
        dc.l CClic
        dc.l CPut
        dc.l CZoo
        dc.l Cscur
        dc.l CScd
        dc.l CScu
        dc.l Cscroll
        dc.l CInv
        dc.l CSha
        dc.l Cwindopen
        dc.l CWdo
        dc.l CWdm
        dc.l CWdl

; ADRESSE DES FONCTIONS ETENDUES
ExtFonc:dc.l CSinh,CCosh,CTanh,CAsin,CAcos,CAtan,CUpp,CLow
        dc.l CCurr,CMach,Cerrn,Cerrl,Cvarptr,Cfinp,Cflip,Cfree
        dc.l CStr,CHex,Cbin,Cstring,Cspc,CInst,CMax,CMin
        dc.l CLof,CEof,CDirF,CDirN,CBtst,Ccollide,CAccn,CLang
        dc.l csynt,CHunt,CVrai,CFaux,CCx,CCy,Cjup,Cjleft
        dc.l Cjright,Cjdown,CFire,CJoy,Cmovon,Cicon,CTab,CExp
        dc.l CChl,CChoi,CItem,Cwdn,CXt,CYt,CXg,CYg
        dc.l csynt,CSqr,CDx,CDy,Clogn,CTan,CDMap,CFsel
        dc.l Cdfree,CSgn,CPort,Cpvoi,CInt,Cdetect,CDeg,CRad

;-----------------------------> Formats de parametres
en             = $00
ch             = $80
fl             = $40
to             = $80

parent: dc.b en,1
        dc.b en,",",en,1
        dc.b en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,",",en,",",en,",",en,1
        dc.b 1

;----------------------------> MESSAGES D'ERREUR
merror: dc.b 13,10,"Erreur number ",0
merr:   dc.b "in line ",0

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | INSTRUCTIONS RECOPIEES          |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
        even
cjsr            = $4eb9 /* jsr $xxxxx */
cjmp            = $4ef9 /* jmp $fffffe */
cbra            = $6000 /* bra.w xxxx */
cleaa0          = $41f9 /* lea $ffffff,a0 */
cleaa2          = $45f9 /* lea $ffffff,a2 */
cmvima6         = $2d3c /* move.l #$ffffffff,-(a6) */
cmvqd0          = $7000 /* moveq #0,d0 */
cmvqd1          = $7200 /* moveq #0,d1 */
cmvqd2          = $7400 /* moveq #0,d2 */
cmvd1           = $323cffff /* move.w #$ffff,d1 */
crts            = $4e75 /* rts */

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | PROGRAMME                       |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
        even


*********************************************************************
* Ramene la version
***************************
Version:
        move.w #$0301,d0
        rts

*********************************************************************
* GRABBER DE PROGRAMME POUR LE STOS BASIC
* AREG(0)= debut PRG
* AREG(1)= fin PRG
* AREG(2)= compad
* AREG(3)= back
* DREG(0)= programme ou grabber
**************************************

******* Poke et appelle le grabber
Grab:   lea Grabber(pc),a4
        lea GrabEnd(pc),a5
        move.l a3,-(sp)
Grb:    move.l (a4)+,(a3)+
        cmp.l a5,a4
        bcs.s Grb
        rts

Grabber:move.l a2,a6            ;A6= compad
        move.l sys_vectors(a6),a5       ;A5= tables
        move.l a0,a2            ;A2= adresse du .PRG
        move.l a1,d3
        sub.l a2,d3             ;D3= longueur du .PRG
        move.w d0,d7            ;# du programme ou grabber
        move.w d0,program(a5)
        clr.w accflg(a5)        ;Plus d'accessoire!

        move.l adatabank(a5),a0
        move.l (a0)+,d0
        moveq #14,d1
Grb1:   clr.l (a0)+             ;Efface les banques!
        dbra d1,Grb1
        move.l adataprg(a5),a0
        move.l (a0),a3          ;Adresse de recopie
        move.l d0,4(a0)         ;Longueur compil= longueur basic.
        add.l d0,a3             ;Pointe la fin du compilateur
        move.l d3,-(sp)
        move.l $28(a6),a0
        jsr (a0)                ;Transmem
        lsl.w #3,d7
        lea dataprg(a5),a4
        add.w d7,a4
        move.l 8(a4),a2         ;debut du prg au dessus
        move.l (sp),d3
; Fait tourner les buffers
Tour0:  move.l #32000,d0
        cmp.l d3,d0
        bcs.s Tour1
        move.l d3,d0
Tour1:  sub.l d0,d3
        move.l adback(a5),a1    ;Recopie dans le buffer
        add.l #32768,a1
        move.l a3,a0
        lsr.w #1,d0
        subq.w #1,d0
        move.w d0,d1
Tour2:  move.w -(a0),-(a1)
        dbra d0,Tour2
        move.l a3,a1            ;Monte le programme
Tour3:  move.w -(a0),-(a1)
        cmp.l a2,a0
        bhi.s Tour3
        move.l adback(a5),a0    ;Remet le bout d'ecran
        add.l #32768,a0
Tour4:  move.w -(a0),-(a1)
        dbra d1,Tour4
        tst.l d3
        bne.s Tour0
; Remonte le gros bout de basic
        move.l (sp)+,d3
        move.l a2,-(sp)
        add.l d3,a2
        move.l a3,d3
        sub.l a2,d3
        move.l adataprg(a5),a0
        move.l 8(a0),a3
        sub.l d3,a3
        move.l $28(a6),a0
        jsr (a0)
; Change les adresses des programmes
        move.l adataprg(a5),a0
Tour5:  sub.l 4(a0),a3
        move.l a3,(a0)
        subq.l #8,a0
        cmp.l a4,a0
        bhi.s Tour5
; Descend le .PRG
        lsl.w #3,d7
        lea databank(a5),a0
        add.w d7,a0
        move.l a0,adatabank(a5)
        move.l a4,adataprg(a5)
        move.l (a4),a3
        move.l (sp)+,a2
        lea 10(a2),a2                   ;Saute lionpoulos
        move.l (a2)+,d3
        move.l d3,4(a4)                 ;Longueur totale prg
        moveq #15,d0
Des1:   move.l (a2)+,(a0)+              ;Copie databank
        dbra d0,Des1
        move.l $28(a6),a0               ;Descend le programme
        jsr (a0)
        move.l $74(a6),a0               ;Dechaine le programme
        jsr (a0)
        move.l $40(a6),a0               ;Prend DIR JUMPS
        move.l 14*4(a0),a0              ;WARM
        jmp (a0)
GrabEnd:

*************************************************************************
*       Depart SEKA
***********************
w:      clr.w flagstos
        clr.l vtable
        dc.w $a000
        move.l a0,LigneA
        move.l #finprg,a0
        move.l #$F0000,a1
        move.l #$F0000,a2
        move.l #$F8000,a3
        move.l #nomsrc,nomin
        move.l #nomobj,nomout
        clr.l vtable
        clr.w prgnb
        move.l #ncr0,nomcr0
        move.l #ncr1,nomcr1
        move.l #ncr2,nomcr2
        move.l #nmouse,nommou
        move.w #1,cflaggem
        move.w #0,XLine
        move.w #0,YLine
        move.w #64,LBar
        move.w #100,HBar
        lea $f0000,sp
        bra.w Ds

*************************************************************************
*       FIXE LES PARAMETRES DE COMPILATION
*       A0= table vectors
*       A1= Sprites souris
*       A2= CR0
*       A3= CR1
*       A4= CR2
*       A5= parametres DEFAULT
*       D0= pgm#
*       D1= flaggem
*       D2= XBarre
*       D3= YBarre
*       D4= Taille barre X
*       D5= Taille barre Y
*       D6= Tmaxcopie
*       D7= BufSprites
***********************
setpar: move.l a0,vtable
        move.l a1,nommou
        move.l a2,nomcr0
        move.l a3,nomcr1
        move.l a4,nomcr2
        subq.w #1,d0
        move.w d0,prgnb
        move.w d1,cflaggem
        move.w d2,XLine
        move.w d3,YLine
        move.w d4,LBar
        move.w d5,HBar
        move.l d6,maxcop
        move.l d7,tbufsp
        moveq #44-1,d0
        lea oamb(pc),a0
setp:   move.b (a5)+,(a0)+
        dbra d0,setp
; Adresses ligne A / control-c
        move.l vtable(pc),d0
        bmi.s Sp1
        move.l d0,a0
        move.l sys_vectors(a0),a0
        bra.s Sp2
Sp1:    bclr #31,d0
        move.l d0,a0
Sp2:    move.l a0,advector
        move.l laad(a0),LigneA
        rts

*************************************************************************
*       COMPILATION STOS
*       a0= debut du buffer WORK
*       a1= Fin du buffer WORK
*       a2= bas buffer BACK
*       a3= haut buffer BACK
*       a4= nom entree / 0 sinon
*       a5= nom sortie / 0 sinon
* d0= compiler TEST 0 / 1 / 2
* d1= zero float (1)
* d2= zero float (2)
**********************************************
DStos:  move.w #1,flagstos
        move.w d0,Tests
        move.l d1,ozero
        move.l d2,ozero+4
        move.l a4,nomin
        move.l a5,nomout

*************************************************************************
*       Fixe les buffers fixes
*************************************************************************
Ds:     move.l sp,SauveP

        move.l a0,debwork
        move.l a1,topwork

; RAZ buffer BACK
        move.l a2,a0
RazB:   clr.l (a0)+
        cmp.l a3,a0
        bcs.s RazB
; table des variables / descendantes
        move.l a3,hivar
; buffer de chargement librairie
        move.l a2,BufLoad
        move.l #$2000,MaxLoad
        add.l MaxLoad(pc),a2
; buffer de chargement SOURCE
        tst.l nomin
        beq.s Rab1
        move.l a2,BufSou
        move.l #$1000,MaxBso
        add.l MaxBso(pc),a2
        move.l #256,BordBso
        move.l a2,ADtbnk
        lea 17*4(a2),a2
; buffer de sauvegarde OBJET
Rab1:   tst.l nomout
        beq.s Rab2
        move.l a2,bufob
        move.l #$1000,maxbob
        add.l maxbob(pc),a2
        move.l #512,bordbob
Rab2:
; table des gestions fichiers
        move.l a2,Datafyche
        lea Nfyche*TFyche(a2),a2
; table des IFTHENELSE longueur FIXE
        move.l a2,Tif
        add.l #8*32,a2
; buffer de calcul, longueur FIXE, descendant
        add.l #4*100,a2
        move.l a2,bufcalc
; table des routines a copier: routin, longueur FIXE
        move.l a2,routin
        add.l #(L_RoutMx+1)*4,a2    ;Nombre de routines
        move.l a2,a6

*************************************************************************
*       Charge le catalogue de la librairie
*************************************************************************
        bsr RazDisk
        moveq #0,d7                     ;Librairie = 0
        lea nomlib(pc),a0
        bsr fsfirst
        bne diskerr
        bsr Open
        moveq #$1c,d0                   ;Saute l'entete
        bsr LSeek
        move.l a6,a0
        moveq #4,d0
        bsr load
        move.l (a6),d0
        move.l d0,OLibr
        subq.l #4,d0
        move.l a6,a0
        move.l a0,AdCata
        bsr load
        move.l a0,a6

*************************************************************************
*       Charge le catalogue des extensions
*************************************************************************
        move.l a6,AdExtAd            ;Adresse table adresse CATALOGUE
        move.l a6,a5
        lea MAX_EXTENSIONS*4(a6),a6
        move.l a6,AdExtPa            ;Adresse table EXTENSIONS PARAMS
        move.l a6,a4
        lea MAX_EXTENSIONS*4(a6),a6
        move.l a6,AdExtAp            ;Adresse table EXTENSION APPELLEE
        move.l a6,a3
        lea MAX_EXTENSIONS*4(a6),a6

        lea nomext(pc),a0
        bsr fsfirst
        bne.s LdE3
LdE1:   lea nomdisk(pc),a0
LdE2:   cmp.b #".",(a0)+
        bne.s LdE2
        clr d6
        move.b 2(a0),d6
        cmp.w #'Z'+1,d6
        bcc.s lde7
        cmp.w #'A',d6
        bcs.s lde5
        subi.w #'A',d6
        bra.s lde6
lde5:   cmp.w #'z'+1,d6
        bcc.s lde7
        cmp.w #'a',d6
        bcs.s lde7
        subi.w #'a',d6
lde6:   move.w d6,d7
        addq.w #1,d7
        lsl.w #2,d6
        bsr Open
        moveq #$1c,d0                   ;Saute l'entete
        bsr LSeek
        moveq #12,d0
        move.l a6,a0
        move.l a0,0(a5,d6.w)            ;Adresse du CATALOGUE
        bsr load
        move.l a6,a1
        add.l (a6),a1
        move.l a1,0(a4,d6.w)            ;Adresse PARAMS
        move.l 4(a6),d0                 ;Charge catalogue/params
        subi.l #12,d0
        bsr load
        move.l a0,a6
        move.l a6,0(a3,d6.w)            ;Adresse de la table appels
        move.w (a1),d5                  ;Nb de routines
        lsl.w #2,d5                     ;Reserve la JUSTE place pour
        addq.w #8,d5                    ;les appels!
        add.w d5,a6
lde7:
        bsr fsnext
        beq.s LdE1
LdE3:

*************************************************************************
*       buffer des DEFFN / variable / montant
*************************************************************************
        move.l a6,AdADefn

*************************************************************************
*       SOURCE
*************************************************************************
        tst.l nomin
        bne.s LdSou
; Programme en memoire
        move.l vtable,a0
        move.l sys_vectors(a0),a5
        move.w prgnb,d0
        lea dataprg(a5),a0
        lea databank(a5),a1
        lsl.w #3,d0
        lea 0(a0,d0.w),a0               ;Pointe dataprg
        lsl.w #3,d0
        lea 0(a1,d0.w),a1               ;Pointe DATABANK
        move.l a0,ADtprg
        move.l a1,ADtbnk
        move.l (a0),Source              ;Adresse du source!
        move.l (a1),LongSou             ;Longueur du source
        bra FLdSou

;-----> Ouvre le programme .BAS
LdSou:  moveq #30,d7
        move.l nomin,a0
        bsr fsfirst
        bne diskerr
        move.l nomin,a0
        bsr Open2
        move.l d0,TopSou
; Charge le debut
        clr.l Source
        clr.l DebBso
        move.l MaxBso(pc),FinBso
        bsr LoadBso
        move.l BufSou(pc),a0
        lea HeadStos(pc),a1
        moveq #10-1,d0
OpSo:   cmpm.b (a0)+,(a1)+
        bne diskerr
        dbra d0,OpSo
; Copie ADATABANK
        move.l BufSou(pc),a0
        lea 10+4(a0),a0
        move.l ADtbnk(pc),a1
        move.l (a0),d0
        addi.l #17*4+10,d0
        move.l d0,LongSou
        moveq #15,d0
Opso1:  move.l (a0)+,(a1)+
        dbra d0,Opso1
FLdSou:

*************************************************************************
*       COMPILATION
*************************************************************************

;-----> Donnees affichage
        move.w XLine(pc),d0
        move.w d0,BasBar
        move.w LBar(pc),d1
        add.w d1,d0
        move.w d0,Bar1
        add.w d1,d0
        move.w d0,Bar2
        add.w d1,d0
        move.w d0,Bar3
        add.w d1,d0
        move.w d0,Bar4
        add.w d1,d0
        move.w d0,Bar5
        move.w #4,-(sp)
        trap #14
        lea 2(sp),sp
        move.w d0,resol

;-----> passe 0: Test des erreurs / Calcul de la longueur
        clr.w passe
        bsr passe0
        bne cout
        move.w Bar1(pc),d0
        move.w d0,BasBar
        bsr AffBar

;-----> Ouvre le fichier OBJET si sur disque
        tst.l nomout
        beq.s PaDis
        moveq #31,d7
        move.l nomout(pc),a0
        bsr Create2
        move.l stobjet(pc),topob
        clr.l debbob
        move.l maxbob(pc),finbob
PaDis:

;-----> passe 1:
        move.w #1,passe
        bsr passe1
        move.w Bar4(pc),d0
        move.w d0,BasBar
        bsr AffBar

;-----> passe 2
        move.w #2,passe
        bsr passe2
        move.w Bar5(pc),d0
        bsr AffBar

;-----> Add the headers
        move.l stobjet(pc),a5
        tst.w cflaggem
        bne.s Head1
; Header STOS
        lea HeadStos(pc),a0
        lea 10(a0),a1
        bra.s Head2
; Header GEM
Head1:  lea HeadTos(pc),a0
        lea $1c+2(a0),a1
Head2:  bsr CodeF

;-----> Si disque, sauve le dernier buffer
        tst.w nomout
        beq.s Head3
        bsr SaveBob
Head3:

;-----> Ferme tous les fichiers
        bsr Close

;-----> FINI:
;       si memoire : A0= debut / A1= fin de l'objet
;       si disque  : a0= longueur objet
;       a2= longueur buffers
        tst.w nomout
        beq.s Head4
; Sur disque : taille de l'objet
        moveq #31,d7
        bsr GetFich
        move.l Longfyche(a3),a0
        bra.s Head5
; En memoire---> ramene debut / fin
Head4:  moveq #0,d0
        move.l stobjet(pc),a0
        move.l objet(pc),a1
        add.l LongOb(pc),a1
        tst.w cflaggem
        beq.s Head5
        addq.l #8,a1
; Taille des buffers
Head5:  move.l tbuffers(pc),a2          ;Taille buffers utilises
        move.l SauveP,sp
; Nombre d'instructions en D2
        moveq #0,d2
        move.w CptInst(pc),d2
        tst.w flagstos
        beq FinSeka
        rts
FinSeka:illegal

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | AFFICHAGE COMPILATION           |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> Calcule et affiche un pourcentage: D0 / D1
AffPour:cmp.w d1,d0
        bcc.s Afp1
        swap d0
        clr.w d0
        divu d1,d0
        mulu LBar(pc),d0
        swap d0
Afp0:   add.w BasBar(pc),d0
        bsr AffBar
        rts
Afp1:   move.w LBar(pc),d0
        bra.s Afp0

;-----> Affiche une ligne depuis la position courante---> D0
AffBar: move.w d1,-(sp)
        move.w d0,d1
        move.w XLine,d0
        bra.s afb1
afb0:   bsr AffLine
        addq.w #1,d0
afb1:   cmp.w d1,d0
        bcs.s afb0
        move.w d0,XLine
        move.w (sp)+,d1
        rts

;-----> Affiche une ligne VERTICALE en X=d0
AffLine:movem.l d0-d3/a0-a3,-(sp)
        move.l LigneA(pc),a0
        move.w YLine(pc),d1
        move.w d1,d2
        add.w HBar(pc),d2
        tst.w resol                     ;Si HIRES: *2
        beq.s Ali1
        lsl.w #1,d0
        lsl.w #1,d1
        lsl.w #1,d2
Ali1:   move.w d0,38(a0)                ;X
        move.w d0,42(a0)
        move.w d1,40(a0)                ;Y
        move.w d2,44(a0)
        move.l #$FFFFFFFF,24(a0)        ;Plans de couleur
        move.l #$FFFFFFFF,28(a0)
        clr.w 36(a0)                    ;Writing
        move.w #$FFFF,34(a0)            ;Ligne parcourue
        move.w #-1,32(a0)
        dc.w $a003
        tst.l vtable
        beq.s Ali3
; Teste le CONTRL-C
        move.l advector(pc),a0
        move.b interflg(a0),d0
        bpl.s Ali3
        andi.b #$7f,d0
        beq.s Ali2
        bclr #0,d0
        beq.s Ali2
        moveq #E_noline,d0                     ;BREAK!
        bra cerror
Ali2:   move.b d0,(a0)
Ali3:   movem.l (sp)+,d0-d3/a0-a3
        rts




;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | ERREURS DU COMPILATEUR          |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
; Out of memory!
cout:   moveq #E_nomem,d0
        bra cerror
; Rien a compiler!
CRien:  moveq #E_badformat,d0
        bra cerror
; Message normaux
csynt:  moveq #E_syntax,d0            ;Syntax error
        bra cerror
ctype:  moveq #E_typemismatch,d0            ;Type mismatch
        bra cerror
diskerr:moveq #-1,d0
        moveq #0,d1
        bra cerror2

;-----> Entree ERREURS
cerror: moveq #0,d1
        move.w curline(pc),d1
cerror2:andi.w #$ffff,d0 /* YYY useless */
        movem.l d0-d1,-(sp)
        bsr Close
        movem.l (sp)+,d0-d1
        tst.w flagstos          ;Si STOS---> D0= # de l'erreur
        beq.s CEro              ;D1= # de la ligne
        move.l SauveP,sp
        rts
CEro:   move.w d1,-(sp)
        move.w d0,-(sp)
        lea merror,a0
        bsr print
        move.w (sp)+,d0
        bsr affword
        lea merr,a0
        bsr print
        move.w (sp)+,d0
        bsr affword
        bsr AffRet
        illegal

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | ZEROIEME PASSE: FIXE LES BUFFERS|       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

passe0:

;-----> Met tout a zero
        clr.l litoad
        clr.l BReloc
        clr.l Badstring
        clr.l BAdChai
        clr.l objet
        clr.w ValFlo
        clr.l NbRout
        bsr passe1                      ;Fait la passe 1
        move.w floflag,ValFlo
        move.l debwork,a6

;-----> buffer litoad
        move.l a6,litoad
        move.l alitoad,d0
        addq.l #8,d0
        add.l d0,a6
        bsr pair

;-----> buffer relocation
        move.l a6,BReloc
        move.l LongRel,d0
        cmp.l #$1000,d0
        bcc.s BRel
        move.l #$1000,d0
BRel:   addi.l #$400,d0
        add.l d0,a6
        bsr pair

;-----> buffer adstring
        move.l a6,Badstring
        move.l adstring,d0
        addq.l #8,d0
        add.l d0,a6
        bsr pair

;-----> buffer adresses constantes alphanumeriques
        move.l a6,BAdChai
        move.l AdChai,d0
        addq.l #8,d0
        add.l d0,a6
        bsr pair

;-----> buffer objet
        tst.l nomout
        bne.s bob1
; En Memoire
        move.l a6,stobjet
; Si debugg
        tst.w flagstos
        bne.s bob2
        move.l #$d0000-$1c-2,stobjet
        bra.s bob2
; Sur disque ---> adresse base=0
bob1:   clr.l stobjet
; Rajoute le HEADER (Stos ou Gem)
bob2:   move.l stobjet(pc),d0
        tst.w cflaggem
        bne.s bob3
        addi.l #HeadStosEnd-HeadStos,d0
        bra.s bob4
bob3:   addi.l #HeadTosEnd-HeadTos,d0
bob4:   move.l d0,objet

;-----> Out of mem ???
        cmp.l topwork(pc),a6
        bcc cout
        sub.l debwork,a6
        move.l a6,tbuffers
        moveq #0,d0
        rts

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | PREMIERE PASSE                  |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

passe1:
;-----> Initialisations
        move.l Source,a6                ;A6= debut du source
        tst.l nomin
        beq.s Pasa
        lea 17*4+10(a6),a6
Pasa:
        move.l objet,a5                 ;A5= pointe l'objet
        move.l BReloc,a4                ;A4= table de relocation
        move.l bufcalc,a3               ;A3= buffer de calcul

        move.l routin,a0
        move.w #L_RoutMx-1,d0           ;RAZ buffer routin
Pas0:   clr.l (a0)+
        dbra d0,Pas0
        move.l #-1,(a0)                 ;Signale la fin

        clr.w floflag                   ;Pas de float!
        move.l hivar,a0                 ;Pas de variable
        clr.w -(a0)
        move.l a0,lovar
        move.l AdADefn,a0               ;Pas de DefFn
        move.l a0,ADefn
        clr.l (a0)+
        move.l a0,botvar

        move.l a5,OldRel                ;Initialise la relocation

        move.l Badstring,adstring       ;Pas de chaine
        move.l BAdChai,a0
        move.l a0,AdChai
        tst.w passe
        beq.s Pap
        clr.l (a0)
Pap:
        move.l #cbufbcle,cposbcle       ;Init des boucles
        clr.w cnboucle
        clr.w ctstnbcle

        move.l Tif,Pif                  ;table des IF THEN ELSE

        move.l litoad,alitoad           ;table des GOTO
        clr.w nblines

        clr.l FstData                   ;Pas de datas
        clr.l OlData
        clr.w flagmenu                  ;Pas de menu!
        clr.w CptInst                   ;Compteur instructions
        move.w #$ffff,curline

; Extensions
        clr.l extflag
        move.l AdExtAp(pc),a0
        move.l AdExtPa(pc),a1
        moveq #MAX_EXTENSIONS-1,d0
InEx1:  tst.l (a0)
        beq.s InEx3
        move.l (a1),a2
        move.w (a2),d2
        move.l (a0),a2
        subq.w #1,d2
InEx2:  clr.l (a2)+
        dbra d2,InEx2
        move.l #-1,(a2)
InEx3:  lea 4(a0),a0
        lea 4(a1),a1
        dbra d0,InEx1

;-----> Saute les routines d'initialisation
        move.l #debprgf,d1
        subi.l #debprg,d1
        tst.w cflaggem
        bne.s p1in1
        addi.l #InaF,d1           ;STOS-run
        subi.l #Ina,d1
        bra.s p1in2
p1in1:  addi.l #inbf,d1           ;GEM-run
        subi.l #Inb,d1
p1in2:  add.l a5,d1
; Rempli de zero les routines INIT
p1in3:  clr.w d0
        bsr outword
        cmp.l d1,a5
        bne.s p1in3
        tst.w cflaggem
        beq.s p1in4
        move.w #L_defgem,d0          ;JSR redessin
        bsr crefonc
        move.w #L_movedata,d0           ;MOVE DATA
        bsr crefonc
        move.w #L_calclong,d0           ;Calclong
        bsr crefonc
p1in4:

;-----> Appel a RAZ PRG
        moveq #L_razprg,d0
        bsr crefonc
        move.l a5,-(sp)         ;Position au debut compilation
        bra.s DebChr

;-----> Exploration du source
FinLine:bsr RelBra              ;reloge les BRA <LIGNE SUIVANTE>
        move.l newline,a6
DebChr: move.l a6,adline
        bsr GetWord
        beq FinPas1
        move.w d0,d1
        move.l alitoad,a0       ;table #ligne / adresses
        bsr GetWord
        cmp.w #$ffff,d0         ;Pas de ligne 65535!
        beq csynt
        move.w d0,curline
        tst.w passe             ;Si PASSE=0 ne poke pas!
        bne.s ChG1
        addq.l #6,a0
        bra.s ChG2
ChG1:   move.w d0,(a0)+         ;Numero de la ligne
        move.l a5,(a0)+         ;Adresse de la ligne
ChG2:   move.l a0,alitoad
        lea -4(a6),a1
        add.w d1,a1
        move.l a1,newline
        addq.w #1,nblines        ;1 ligne de plus! */
; Affiche la position
        move.l a6,d0
        sub.l Source,d0
        lsr.l #8,d0
        move.l LongSou,d1
        lsr.l #8,d1
        bsr AffPour
; Prend la prochaine instruction
ChrGet: bsr getbyte
        move.b d0,d1
        beq.s FinLine
        bmi.s Chr1
        cmp.b #":",d1
        beq ChrGet
        bra csynt
; Appele l'instruction
Chr1:   andi.w #$7f,d1
        lsl.w #2,d1
        lea jumps,a1
        move.l (a1,d1.w),a1
        move.l #$49fafffe,d0
        bsr outlong
        addq.w #1,CptInst
        jsr (a1)
        bra.s ChrGet

;-----> End of the first pass: call of the end routine
FinPas1:cmp.l (sp)+,a5                  ;Quelque chose de compile?
        beq CRien
        move.l #$49fafffe,d0
        bsr outlong
        moveq #L_finistos,d0
        tst.w cflaggem
        beq.s FinP
        moveq #L_finigem,d0
FinP:   bsr crefonc

;------------------------------------> APPEL DES TESTS DES MENUS
        tst.w flagmenu
        beq.s pamen
        move.l a5,menucall
        move.w #L_menumanage,d0
        bsr crejmp
pamen:
;------------------------------------> APPEL DE LA ROUTINE D'ERREUR
        move.l a5,d0
        sub.l objet,d0                  ;Offset---> routine
        lea debprg,a0
        move.l d0,oerror(a0)            ;Variable relogeable!
        moveq #L_error,d0
        bsr crefonc                     ;routine d'erreur
        moveq #L_error2,d0
        tst.w cflaggem
        beq.s Ent1
        addq.w #1,d0                    ; -> L_error3
Ent1:   bsr crefonc                     ;Retour STOS / GEM

;------------------------------------> COPIE LES INITS DES EXTENSIONS
        lea debprg(pc),a0
        lea oext(a0),a0
        move.l a0,a2
        moveq #MAX_EXTENSIONS-1,d0                  ;Nettoie la table
CIni1:  clr.l (a0)+
        dbra d0,CIni1
        moveq #1,d7                     ;Numero extension / fyche
        move.l extflag,d6
; Recopie les initialisations
CIni2:  btst d7,d6
        beq.s CIni5
        move.l AdExtAd(pc),a1
        move.w d7,d1
        lsl.w #2,d1
        move.l -4(a1,d1.w),a1
        tst.w passe
        bne.s CIni3
; passe 0 : additionne la taille
        move.l  8(a1),d0
        sub.l   4(a1),d0
        add.l   d0,a5
        bra.s   CIni5
; passe 1 : charge
CIni3:
        move.l  a5,d1
        sub.l   objet(pc),d1
        move.l  d1,(a2)                  ;Adresse de l'extension
        move.l  4(a1),d0                 ;Pointe l'init
        addi.l  #$1c,d0
        bsr     LSeek
        
        move.l  8(a1),d5                 ;Longueur a charger
        sub.l   4(a1),d5
CIni3a: move.l  d5,d0
        cmp.l   MaxLoad(pc),d5
        bcs.s   CIni3b
        move.l  MaxLoad(pc),d0
CIni3b:  sub.l  d0,d5
        move.l  BufLoad(pc),a0
        bsr     load
        move.l  BufLoad(pc),a1
        move.l  d0,d1
        lsr.w   #1,d1
        subq.w  #1,d1
CIni4:  move.w  (a1)+,d0
        bsr     outword
        dbra    d1,CIni4
        tst.l   d5
        bne.s   CIni3a
CIni5:  lea     4(a2),a2
        addq.w  #1,d7
        cmp.w   #27,d7
        bcs.s   CIni2

;------------------------------------> COPIE LES ROUTINES LIBRAIRIE
                                        ;A6= debut des routines
                                        ;A5= position objet
                                        ;A4= position relocation
        move.l OldRel,d7                ;D7= derniere relocation

; Explore la table
CLib1:  move.l routin,a6                ;A6= debut flags routines
        move.l AdExtAp,PAdExtAp         ;debut flags extensions
        move.l AdExtAd,PAdExtAd         ;debut des catalogues ext
        move.l AdCata,a3                ;A3= debut du catalogue
        moveq #0,d5                     ;D5= debut de la librairie
        moveq #0,d6                     ;Flag
        tst.w passe
        beq.s CLib2
        clr.l CptRout                   ;Initialise l'affichage
        move.w Bar2,BasBar

; Prend une routine
CLib2:  move.l (a6)+,d0                 ;routine selectionnee?
        beq.s CLib3
        cmp.l #-1,d0                    ;Fin de la table?
        beq.s CLib4
        cmp.l #1,d0                     ;Deja copiee?
        beq.s CLib5
CLib3:  moveq #0,d0                     ;Pointe la routine suivante
        move.w (a3)+,d0
        add.l d0,d5
        bra.s CLib2
; go to the next extension ...
CLib4:  swap d6
        move.l PAdExtAp,a0
        move.l PAdExtAd,a1
CLib4b: lea 4(a0),a0
        lea 4(a1),a1
        addq.w #1,d6
        tst.w -4(a0)
        bne.s CLib4c
        cmp.w #27,d6
        bne.s CLib4b
        swap d6
        tst.w d6                        ;A fait une tour: encore 1?
        bne.w CLib1
        bra CLibFin
CLib4c: move.l a0,PAdExtAp
        move.l a1,PAdExtAd
        move.l -4(a0),a6
        move.l -4(a1),a3
        moveq #0,d5
        lea 12(a3),a3
        swap d6
        bra.s CLib2
; Recopie une routine / marque les routines appelee
CLib5:  move.l a5,-4(a6)                ;Marque la routin
        move.l d5,a2                    ;debut de la routine a recopier
        tst.w passe
        beq CLib10
; Charge le bout de routine dans BUFLOAD
        movem.l d0-d7/a0-a6,-(sp)
        move.w (a3),-(sp)               ;Longueur de la routine
        move.l d5,d0
        addi.l #$1c,d0
        swap d6
        move.w d6,d7
        bne.s CLib5a
        add.l OLibr(pc),d0              ;Offset  DEBUT / CATA ---> LIB
        bra.s CLib5b
CLib5a: move.l PAdExtAd(pc),a0
        move.l -4(a0),a0
        add.l 8(a0),d0                  ;Offset DEBUT / CATA ----> EXT
CLib5b: bsr LSeek
        moveq #0,d0
        move.w (sp)+,d0
        cmp.w MaxLoad+2(pc),d0          ;Taille maxi des routines
        bcc csynt
        move.l BufLoad(pc),a0
        bsr load
        addq.l #1,CptRout             ;Affyche le nombre de routines */
        move.l CptRout,d0
        move.l NbRout,d1
        bsr AffPour
        movem.l (sp)+,d0-d7/a0-a6
; Recopie la routine
        move.l BufLoad(pc),a1
        move.l a1,a2
CLib6:  tst.w (a2)+                     ;Cherche le debut du CODE
        bne.s CLib6
        moveq #0,d4                     ;Calcule l'ad de l'appel
        move.w (a1)+,d4
        add.l BufLoad(pc),d4
        moveq #0,d3
        move.w (a3),d3
        add.l BufLoad(pc),d3            ;Pointe la fin de la routine
; Boucle de recopie
CLib7:  cmp.l d3,a2                     ;Tout est recopie?
        bcc.w CLib3
        cmp.l d4,a2                     ;Appel a une autre routine
        beq.s CLib8
        move.w (a2)+,d0                 ;Envoie le mot
        bsr outword
        bra.s CLib7
; Un appel...
CLib8:  move.w (a2)+,d0                 ;Envoie le JSR / JMP
        bsr outword
; ...reloge...
        move.l a5,d0
        sub.l d7,d0                     ;... derniere relocation
ReR1:   cmp.w #126,d0
        bls.s ReR2
        bsr OutRel1                     ;>126: met 1 et boucle
        subi.w #126,d0
        bra.s ReR1
ReR2:   bclr #7,d0                      ;Flag #7=0 ---> JSR
        bsr OutRel                      ;<126: met le chiffre
        move.l a5,d7                    ;Derniere relocation...
        moveq #0,d4                     ;Pointe l'appel suivant, s'il existe
        move.w (a1)+,d4
        add.l BufLoad(pc),d4
; ...marque la table routin
        move.l (a2)+,d0                 ;Envoie le # routine
        bclr #31,d0
        beq.s ReR3
; Internal call to the extension (BUG BUG BUG!)
        move.l  d0,d1
        andi.w  #$00FF,d0
        swap    d6
        lsl.w   #8,d6
        or.w    d6,d0
        subi.w  #$0100,d0
        lsr.w   #8,d6
        swap    d6
        bset    #28,d0
        bsr     outlong
        lsl.w   #2,d1
        move.l  PAdExtAp(pc),a0
        move.l  -4(a0),a0
        add.w   d1,a0
        tst.l   (a0)
        bne.s   CLib7
        move.l  #1,(a0)
        addq.w  #1,d6
        bra.s   CLib7
; Appelle de la librairie normale
ReR3:   bsr outlong
        lsl.w #2,d0
        move.l routin,a0
        add.w d0,a0                     ;Pointe dans la table
        tst.l (a0)                      ;Deja appele?
        bne CLib7
        move.l #1,(a0)                  ;Marque
        addq.w #1,d6                    ;Flag: refaire un tour
        bra.w CLib7
;-----> C'est la passe 0!
CLib10: moveq #0,d3                     ;Longueur de la routine
        move.w (a3),d3
        add.l d3,a5
        addq.l #2,a4
        lea 256(a5),a5                  ;Plus 256 octets/routine
        lea 12(a4),a4                   ;Plus 8 octets relocation
        addq.l #1,NbRout
        bra CLib3
;-----> Fini de copier
CLibFin:moveq #0,d0                     ;Termine la table de relocation!
        bsr OutRel
        bsr OutRel
        move.l a4,LongRel

;-------------------------------> STOP si passe 0
        tst.w passe
        beq EndP1
; Initialise l'affichage  COPIE TRAPPES
        move.w Bar3(pc),d0
        move.w d0,BasBar
        bsr AffBar

;-------------------------------> Longueur du CODE
        move.l a5,d0
        sub.l objet,d0
        move.l d0,LongCode

;-------------------------------> Recopie la table de relocation
        move.l a5,d6
        sub.l objet,d6          ;Pointeur ---> table relocation
        move.l BReloc,a2
CRel:   move.b (a2)+,d0
        bsr OutByte
        tst.b d0
        beq.s CRel1
        btst #7,d0
        beq.s CRel
        move.b (a2)+,d0
        bsr OutByte
        bra.s CRel
CRel1:  move.w a5,d1            ;Rend pair
        btst #0,d1
        beq.s CRel2
        bsr OutByte
CRel2:  sub.l BReloc,a2         ;Longueur de la table de relocation
        move.l a2,LongRel
        moveq #1,d0
        moveq #28,d1
        bsr AffPour

;-------------------------------> Recopie la table litoad
        move.l a5,d5
        sub.l objet,d5
        move.l litoad,a2        ;debut de la table
CLi:    cmp.l alitoad,a2
        bcc.s CLi1
        move.w (a2)+,d0
        bsr outword
        move.l (a2),d0
        sub.l objet,d0
        move.l d0,(a2)+
        bsr outlong
        bra.s CLi
CLi1:   move.w #$ffff,d0
        bsr outword
        moveq #0,d0
        bsr outlong
        moveq #2,d0
        moveq #28,d1
        bsr AffPour

;-------------------------------> Poke la chaine vide
        move.l a5,d7            ;D7= ad chaine vide
        clr.w d0
        bsr outword

;-------------------------------> Recopie les CONSTANTES ALPHANUMERIQUES
        move.l BAdChai,a1
        moveq #0,d2             ;longueur
p2c1:   tst.l (a1)              ;ZERO= termine
        beq.s p2c4
        move.l (a1),a6          ;Adresse dans le source
        move.l a5,(a1)+         ;Nouvelle adresse dans l'objet
        addq.w #2,a6
        bsr GetWord             ;Prend la longueur de la chaine
        tst.w d0
        bne.s p2c2
        move.l d7,-4(a1)        ;Si chaine vide---> pointe la bonne
        bra.s p2c1
p2c2:   bsr outword
        addq.l #2,d2
        move.w d0,d1
        addq.w #1,d1
        lsr.w #1,d1
        subq.w #1,d1            ;Travaille par mots
p2c3:   bsr GetWord             ;Recopie la chaine
        bsr outword
        addq.l #2,d2
        dbra d1,p2c3
        bra.s p2c1
p2c4:   move.l d2,LongChai      ;Longueur des chaines
        moveq #0,d0             ;Securite d'un mot long
        bsr outlong
        moveq #3,d0
        moveq #28,d1
        bsr AffPour

;----------------------------> Laisse l'espace pour la table VarChaine
        move.l a5,d4            ;Offset oadstr
        sub.l objet,d4
        move.l adstring,d0
        sub.l Badstring,d0
        add.l d0,a5
        moveq #0,d0             ;Met au moins un zero!
        bsr outlong

;----------------------------> Copie les TRAPPES si programme GEM-RUN
        movem.l d4-d7,-(sp)
        tst.w cflaggem
        beq.w PaTrap
; Copie WINDO101.LIB
CoTrap: lea nomwin(pc),a0
        move.l #otrap3,a1
        bsr LoTrap
        moveq #4,d0
        moveq #28,d1
        bsr AffPour
        lea debprg(pc),a0       ;Jeux de caracteres par defaut
        move.l a5,d0
        sub.l objet(pc),d0
        move.l d0,ocr0(a5)
        move.l d0,ocr1(a5)
        move.l d0,ocr2(a5)
        tst.l nomcr0
        beq.s Cot1
        move.l nomcr0(pc),a0
        move.l #ocr0,a1
        bsr LoTrap
Cot1:   moveq #5,d0
        moveq #28,d1
        bsr AffPour
        tst.l nomcr1
        beq.s Cot2
        move.l nomcr1(pc),a0
        move.l #ocr1,a1
        bsr LoTrap
Cot2:   moveq #6,d0
        moveq #28,d1
        bsr AffPour
        tst.l nomcr2
        beq.s Cot3
        move.l nomcr2(pc),a0
        move.l #ocr2,a1
        bsr LoTrap
; Copie SPRIT101.LIB
Cot3:   moveq #7,d0
        moveq #28,d1
        bsr AffPour
        lea nomspr(pc),a0
        move.l #otrap5,a1
        bsr LoTrap
        moveq #8,d0
        moveq #28,d1
        bsr AffPour
        move.l nommou(pc),a0
        move.l #omou,a1
        bsr LoTrap
        moveq #9,d0
        moveq #28,d1
        bsr AffPour
; Copie MUSIC101.LIB
        lea nommus(pc),a0
        move.l #otrap7,a1
        bsr LoTrap
        moveq #10,d0
        moveq #28,d1
        bsr AffPour
; Copy FLOAT101.LIB if necessary
jlo:    lea debprg(pc),a0
        clr.l otrap6(a0)
        tst.w floflag
        beq.s PaTrap
        moveq #31,d7
        lea nomflo(pc),a0
        move.l #otrap6,a1
        bsr LoTrap
        moveq #11,d0
        moveq #28,d1
        bsr AffPour
PaTrap:
        movem.l (sp)+,d4-d7

;----------------------------> Loke la longueur du PROGRAMME / BANQUE 0
        moveq #0,d0             ;Securite un mot long
        bsr outlong
        move.l a5,d0            ;D0= debut des variables
        sub.l objet,d0
        move.l d0,LongProg
        subi.l #17*4,d0          ;Longueur de la banque 0
        move.l d0,brdatab       ;---> dans le header

;----------------------------> Recopie les BANQUES (garder a4/d6/d7)
        move.l ADtbnk,a3
        move.l Source,a6        ;debut du source
        tst.w nomin
        beq.s CopB2a
        lea 17*4+10(a6),a6      ;Saute les entetes
CopB2a: lea brdatab+4,a2
        add.l (a3)+,a6          ;debut de la premiere banque
        moveq #0,d2
        moveq #0,d3
CopB3:  move.l (a3)+,d1
        move.l d1,(a2)+
        andi.l #$ffffff,d1
        beq.s CopB5
; Copie la banque
        add.l d1,d3
        lsr.l #2,d1
CopB4:  bsr GetLong
        bsr outlong
        subq.l #1,d1
        bne.s CopB4
CopB5:  moveq #12,d0
        add.w d2,d0
        moveq #28,d1
        bsr AffPour
        addq.w #1,d2
        cmp.w #15,d2
        bcs.s CopB3
FCopB:  move.l d3,LongBank

;----------------------------> Longueur totale du programme
        move.l a5,d1
        sub.l objet(pc),d1
        move.l d1,LongOb
        move.l d1,d0
        subi.l #17*4,d0                  ;Longueur TOTALE ---> header
        move.l d0,brlong
; Fausse table de relocation
        move.l #ovide-4,d0              ;Pour la table de relocation
        bsr outlong
        moveq #0,d0
        bsr outlong
        addq.l #2,d1
        move.l d1,HeadTos+2

;----------------------------> Loke les pointeurs dans l'initialisation
        lea debprg,a5
        move.l d4,oadstr(a5)            ;table adresse var alphanumeriques
        move.l d5,oliad(a5)             ;table #LIGNE----> Adresse
        move.l d6,oreloc(a5)            ;Sauve la position relocation
        sub.l objet,d7
        move.l d7,ochvide(a5)           ;Sauve la position chaine vide
        move.l FstData,ofdata(a5)       ;Premiere ligne de datas
        move.l menucall,d0              ;Adresse de l'appel des menus
        sub.l objet,d0
        move.l d0,oadmenu(a5)
        move.l tbufsp(pc),otbufsp(a5)
        move.l maxcop(pc),omaxcop(a5)
        move.w ValFlo(pc),oflola

;----------------------------> Fin de la passe1
EndP1:  rts

***********************************************************************

; Copie une trappe dans le programme
LoTrap: move.l a5,d1                    ;PAIR!
        btst #0,d1
        beq.s Lotp
        addq.l #1,d1
        addq.l #1,a5
Lotp:   sub.l objet(pc),d1
        add.l #debprg,a1
        move.l d1,(a1)
        moveq #28,d7
        bsr fsfirst
        bne diskerr
        bsr Open
        move.l d0,d6
Lot0:   move.l BufLoad(pc),a0
        move.l MaxLoad(pc),d0
        cmp.l d0,d6
        bcc.s Lot1
        move.l d6,d0
Lot1:   bsr load
        move.l d0,d1
        sub.l d1,d6
        move.l BufLoad(pc),a0
Lot2:   move.l (a0)+,d0
        bsr outlong
        subq.l #4,d1
        bmi.s Lot3
        bne.s Lot2
Lot3:   tst.l d6
        bne.s Lot0
        bsr Clofyche
        rts

;-----> Entree des instructions etendues (en $A0)
Cextensions:  clr.w d0
        bsr getbyte
        cmp.b #32,d0
        bcs.s CEt1
; Appelle la routine
        subi.w #$70,d0
        bcs csynt
        lsl.w #2,d0
        lea ExtJump,a0
        move.l 0(a0,d0.w),a0
        jmp (a0)
; Commande directe!
CEt1:   moveq #E_directcommand,d0
        bra cerror

;-----> Entree des fonctions etendues (en $B8)
FEten:  clr.w d0
        bsr getbyte
        subi.w #$80,d0
        bcs csynt
; Appelle la routine
        lsl.w #2,d0
        lea ExtFonc,a0
        move.l 0(a0,d0.w),a0
        jmp (a0)

;-----> Entree des instructions EXTENSIONS
Cextensionsi:  bsr test0
        bsr extpar
        movem.w d2/d6/d7,-(sp)
        cmp.b #1,(a2)                   ;Si pas de params!
        beq.s Exti1
        bsr parinst
Exti1:  bra.s extcall

;-----> Entree des fonctions EXTENSIONS
Cextf:  bsr extpar
        movem.w d2/d6/d7,-(sp)
        cmp.b #1,(a2)
        beq.s Extf1
        bsr parfonc
Extf1:
; Appelle la fonction / instruction
extcall:movem.w (sp)+,d2/d6/d7
        move.w #cmvqd0,d1
        move.b d0,d1
        move.w d1,d0
        bsr outword           /* number of parameters passed in d0 */
        move.w #cmvd1>>16,d0
        bsr outword
        move.w d6,d0
        lsl.b #2,d0
        addi.w #oext,d0       /* offset to extension data ptr passed in d1 */
        bsr outword
        move.w #cjsr,d0
        bsr outword
        bsr reljsr
        moveq #0,d0
        move.b d6,d0
        lsl.w #8,d0
        move.b d7,d0
        bset #28,d0
        bsr outlong
        rts

; Pointe la definition des parametres   ---> A2
;                                       ---> D6= #extension
;                                       ---> D7= #instructio
extpar: moveq #0,d0
        bsr getbyte
        cmp.b #2,d0
        bne.s extp1
; Directive compilateur
        move.w d0,d1
        bsr getbyte
        cmp.b #$88,d0
        beq.s cpt3
        cmp.b #$86,d0
        beq.s cpt2
        cmp.b #$84,d0
        beq.s cpt1
        cmp.b #$82,d0
        beq.s cpt0
        subq.l #1,a6
        move.w d1,d0
        bra.s extp1
; Comptest off
cpt0:   clr.w Tests
        bra.s cpt4
; Comptest on
cpt1:   move.w #1,Tests
        bra.s cpt4
; Comptest always
cpt2:   move.w #2,Tests
        bra.s cpt4
; Comptest
cpt3:   moveq #L_tester,d0
        bsr crefonc
; Fin: POP!
cpt4:   addq.l #4,sp
        rts
; Normale ---> extension presente?
extp1:  move.w d0,d6
        move.l extflag,d1               ;Marque l'extension appelee
        addq.w #1,d0
        bset d0,d1
        subq.w #1,d0
        move.l d1,extflag
        lsl.b #2,d0
        move.l AdExtAd(pc),a0
        tst.l 0(a0,d0.w)
        beq.s Expala
        move.l AdExtPa(pc),a0
        move.l 0(a0,d0.w),a2            ;Adresse des parametres
        move.l AdExtAp(pc),a0
        move.l 0(a0,d0.w),a0
        bsr getbyte
        andi.w #$7f,d0
        cmp.w 2(a2),d0
        bhi csynt
        move.w d0,d7
        lsl.b #1,d0
        add.w 4(a2,d0.w),a2             ;Pointe les params
        lsl.b #1,d0
        move.l #1,0(a0,d0.w)            ;Force l'appel de la routine
        clr.w d2
        move.b (a2)+,d2                 ;Ramene le type de retour
        rts
Expala: moveq #E_extension_noent,d0
        bra cerror

;-----> L'instruction est-elle finie
finie:  bsr getbyte
        subq.l #1,a6
        tst.b d0                ;0 / : / ELSE
        beq.s Fi
        cmp.b #":",d0
        beq.s Fi
        cmp.b #$9b,d0
Fi:     rts

;-----> ON ou OFF ou FREEZE
onoff:  bsr getbyte
        cmp.b #$a6,d0
        beq.s onof1
        cmp.b #$a7,d0
        beq.s onof2
        cmp.b #$a5,d0
        beq.s onof3
        subq.l #1,a6
        moveq #-1,d0
        rts
onof1:  clr.w d0
        rts
onof2:  moveq #1,d0
        rts
onof3:  clr.w d0
        subq.w #1,d0
        rts

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | DEUXIEME PASSE                  |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
passe2:

;--------------------------------------> reloge le programme
        move.l objet,d7         ;Base de toute les adresses
        move.l d7,a5            ;debut de l'exploration
        move.l routin,a3        ;Catalogue de la librairie
        move.l BReloc,a6        ;table de relocation
        move.l LongProg,a4      ;debut des variables
        move.l a4,d4            ;---> addition
        move.l Badstring,a2     ;table des variables chaines
P2a:    move.b (a6)+,d0
        beq.w P2f
        cmp.b #1,d0
        bne.s P2b
        add.w #126,a5
        bra.s P2a
; Affyche la position
P2b:    move.w d0,-(sp)
        move.l a6,d0
        sub.l BReloc,d0
        move.l LongRel,d1
        bsr AffPour
        move.w (sp)+,d0
        move.b d0,d1
        andi.w #$7f,d1
        add.w d1,a5
        btst #7,d0
        bne.w p2c
; Routine librairie ou constante alphanumerique
        bsr gtolong
        subq.l #4,a5
        btst #31,d0
        bne.s P2g
        btst #30,d0
        bne.s P2h
        btst #29,d0
        bne.s P2i
        btst #28,d0
        bne.w p2m
; Trouve l'adresse d'une routine librairie
        lsl.w #2,d0
        move.l 0(a3,d0.w),d0    ;Adresse absolue de la routine
        sub.l d7,d0
        bsr outlong
        subq.l #4,a5
        bra P2a
; Trouve l'adresse d'une constante alphanumerique
P2g:    andi.l #$ffffff,d0
        move.l d0,a0
        move.l (a0),d0          ;Adresse absolue de la constante
        sub.l objet,d0          ;---> relative
        bsr outlong
        subq.l #4,a5
        bra.w P2a
; Simple adresse a l'interieur du programmme
P2h:    andi.l #$ffffff,d0
        bsr outlong
        subq.l #4,a5
        bra.w P2a
; Trouve l'adresse d'un GOTO / GOSUB
P2i:    move.l litoad,a0
        move.l alitoad,a1
P2j:    cmp.l a1,a0
        bcc.s P2l
        cmp.w (a0),d0
        beq.s P2k
        bcs.s P2l
        addq.l #6,a0
        bra.s P2j
P2k:    move.l 2(a0),d0
        bsr outlong
        subq.l #4,a5
        bra.w P2a
P2l:    move.l litoad,a0
        move.l alitoad,a1
        sub.l objet,a5
p2l1:   lea 6(a0),a0
        cmp.l a1,a0
        bcc.s p2l2
        cmp.l 2(a0),a5
        bhi.s p2l1
p2l2:   moveq #0,d1
        move.w -6(a0),d1
        moveq #E_undefined_line,d0
        bra cerror2
; Trouve l'adresse d'un appel a une extension
p2m:    move.l AdExtAp(pc),a0
        move.w d0,d1
        lsr.w #8,d1
        lsl.w #2,d1
        move.l 0(a0,d1.w),a0
        andi.w #$ff,d0
        lsl.w #2,d0
        move.l 0(a0,d0.w),d0            ;Adresse absolue
        sub.l d7,d0
        bsr outlong
        subq.l #4,a5
        bra P2a
; Trouve l'adresse d'une variable / pointe la suivante
p2c:    bsr gtolong
        subq.l #4,a5
        move.l d0,a0            ;Pointe la table des variables
        move.b (a0),d0
        bne.s P2d
; Deja passe: reprend l'adresse
        move.l (a0),d0
        bsr outlong
        subq.l #4,a5
        addq.l #1,a6            ;Saute le flag
        bra P2a
; Premiere utilisation de cette variable
P2d:    move.l a4,d0            ;Position relative dans les variables
        move.l d0,(a0)          ;Repoke dans les variables
        bsr outlong
        subq.l #4,a5
        move.b (a6)+,d0
        andi.b #$e0,d0
        bpl.s P2e1
        move.l a4,(a2)+         ;Construit la tables des variables alpha
        btst #5,d0              ;$8000xxxx si tableau!
        beq.s P2e1
        bset #7,-4(a2)
P2e1:   btst #5,d0              ;tableau: pointeur sur tableau
        bne.s P2e
        tst.b d0
        beq.s P2e
        bmi.s P2e
        addq.l #4,a4
P2e:    addq.l #4,a4
        bra P2a
; Fin: loke l'offset de fin des variables / debut des trappes
P2f:    clr.l (a2)              ;Arret adstring
        addq.l #8,a4            ;Saute la derniere variable
        lea debprg,a5
        move.l a4,otrappes(a5)
        sub.l d4,a4             ;Longueur des variables
        move.l a4,LongVar

;--------------------------------> Copie la table adstring
        move.l oadstr(a5),a5
        add.l objet,a5
        move.l Badstring,a0
P2s:    move.l (a0),d0
        bsr outlong
        tst.l (a0)+
        bne.s P2s

;--------------------------------> Copie le debut du programme
        move.l objet,a5
        move.l #debprg,a0       ;Copie les variables
        move.l #debprgf,a1
        bsr CodeF
        tst.w cflaggem
        bne.s P2t
        move.l #Ina,a0          ;Initialisation STOS-RESIDENT
        move.l #InaF,a1
        bsr CodeF
        rts
P2t:    move.l #Inb,a0          ;Initialisation GEM-run
        move.l #inbf,a1
        bsr CodeF
        rts



*************************************************************************
*       MANUFACTURING OF THE BASIC RESIDENT PROGRAM
        even
; Header STOS
HeadStos:
        dc.b "Lionpoulos"
   .even
HeadStosEnd:

; Header TOS
HeadTos:
        dc.b $60,$1a
        dc.l ovide-4
        ds.b $1c-6
        bra.s ButDe
HeadTosEnd:

; Programme
debprg:

;-----> Datas banques
brlong: dc.l 0
brdatab:ds.l 16
        dc.w $0008,$ffff
        dc.b $a8,$02,$80,$00
        dc.w 0000
OLong   = 0
ODataB  = 4
;-----> Programme
ButDe:  bra     DPrg
        dc.b    "STOS basic compiler V3.01 by Francois Lionet"
glu:
        dcb.b DebD-(glu-debprg),0 /* pad to 128 bytes */
        even

**********************************
        ds.b LDeb                       ;Reserve la place
        dc.w $ff00                      ;Signal de fin des relogeables
**************************************************************************
*       Zone de donnees FIXES

; Flag FLOAT present!
oflola: dc.w 0
ooflola = oflola-debprg
ozero:  dc.l 0,$12345678
oozero  = ozero-debprg

; TABLE DE DEFSCROLL
odfst:  ds.w 16*8
oodfst  = odfst-debprg

; AMBIANCE PAR DEFAUT
oamb:   dc.w $000,$777,$070,$000,$770,$420,$430,$450
        dc.w $555,$333,$733,$373,$773,$337,$737,$337
ooamb   = oamb-debprg
; CURSEUR PAR DEFAUT
        dc.w 0
; TOUCHES DE FONCTION PAR DEFAUT
        dc.w 0
; MODE PAR DEFAUT
        dc.w 0
; LANGUE PAR DEFAUT
        dc.w 1
; BLACK et WHITE env
        dc.w 1
; HIDE / SHOW
        dc.w 0

*************************************************************************
;-----> start of program
DPrg:   lea debprg(pc),a6               ;debut du programme

;-----> reloge les adresses systeme
        move.l a6,d6
        lea debrel(a6),a5
DPrg2:  cmp.w #$FF00,(a5)
        beq.s DPrg3
        add.l d6,(a5)+
        bra.s DPrg2
DPrg3:

;-----> reloge la table des GOTO
        move.l oliad(a6),a5
DPrg4:  cmp.w #65535,(a5)+
        beq.s DPrg5
        add.l d6,(a5)+
        bra.s DPrg4
DPrg5:

;-----> reloge la table des adstring
        move.l oadstr(a6),a5
DPrg6:  tst.l (a5)
        beq.s DPrg7
        add.l d6,(a5)+
        bra.s DPrg6
DPrg7:

;-----> Efface la table des defscroll
        lea odfst(pc),a1
        move.w #16*8-1,d0
cd2:    clr.w (a1)+
        dbra d0,cd2

; passe la main a la suite...
debprgf:

************************************************************************

************************************************************************
*       Initilisation BASIC RESIDENT
*       Relocation des variables


Ina:    move.l a0,atable(a6)    ;Adresse de la table d'adresses
        move.l sys_vectors(a0),a0       ;Pointer to vectors
        move.l topmem(a0),a5    ;Trouve la fin de la memoire!

        move.l oreloc(a6),a0    ;Pointe la table de relocation
        move.l a6,a2            ;debut a reloger
        move.l ochvide(a6),a4   ;Chaine vide
        clr.w d7                ;Flag Out of mem
        move.l oozero(a6),d3    ;Prend le ZERO float!
        move.l oozero+4(a6),d4

Ina1:   move.b (a0)+,d0
        beq.s Ina10
Ina2:   cmp.b #1,d0
        bne.s Ina3
        add.w #126,a2
        bra.s Ina1
Ina3:   move.b d0,d1
        andi.w #$007F,d1
        add.w d1,a2
; reloge...
        btst #7,d0
        bne.s Ina4
; reloge un JSR / JMP ...
        add.l d6,(a2)           ;Additionne la base
        bra.s Ina1
; reloge et CLEAR une variable
Ina4:   add.l d6,(a2)           ;Additionne la base
        move.l (a2),a3
        cmp.l a3,a5
        bcc.s Ina7              ;Out of mem!
        moveq #1,d7
Ina7:   move.b (a0)+,d0         ;Prend le flag de la variable
        btst #4,d0              ;Pas d'init
        beq.s Ina1
        tst.w d7                ;Out of mem
        bne.s Ina1
        btst #5,d0              ;tableau: RAZ du pointeur!
        bne.s Ina5
        andi.b #$C0,d0
        bmi.s Ina6
        bne.s Ina8
Ina5:   clr.l (a3)              ;Clear une entiere
        bra.s Ina1
Ina6:   move.l a4,(a3)          ;Adresse de la chaine vide
        bra.s Ina1
Ina8:   move.l d3,(a3)+         ;Clear une float
        move.l d4,(a3)
        bra.s Ina1
; Sauve les adresses importantes
Ina10:
        move.l atable(a6),a0
        move.l sys_vectors(a0),a5               ;Pointer to vectors
        move.l a6,debut(a5)             ;debut du programme
        move.l oerror(a6),error(a5)     ;Traitement des erreurs
        move.l otrappes(a6),d0
        move.l d0,lochaine(a5)          ;Nouveau, pour pas deranger
        move.l d0,hichaine(a5)          ;fsource!
        move.l a4,chvide(a5)            ;Chaine vide
        move.l sp,spile(a5)             ;Sauve la pile
        move.l sp,lowpile(a5)           ;Niveau zero de la pile!
        addq.l #4,lowpile(a5)
        move.l oliad(a6),liad(a5)       ;Adresse des litoad
        move.l oadstr(a6),adstr(a5)     ;Adresse Ad-Strings
        move.l ofdata(a6),datastart(a5) ;Datas
        move.l oadmenu(a6),admenu(a5)   ;Menus
        move.l a0,table(a5)             ;Adresse de la table d'adresses

; Donnees pour le programme
        move.l sys_dta(a0),dta(a5)
        move.l sys_files(a0),fichiers(a5)
        move.l sys_contrl(a0),contrl(a5)
        move.l sys_intin(a0),intin(a5)
        move.l sys_ptsin(a0),ptsin(a5)
        move.l sys_vdipb(a0),vdipb(a5)
        move.l sys_buffunc(a0),buffunc(a5)      ;NOUVEAU 2.04: adresses touches!
        move.l sys_funcname(a0),funcname(a5)
        lea oodfst(a6),a1
        move.l a1,dfst(a5)
        move.w ooflola(a6),flola(a5)    ;Float present?
        move.l oozero(a6),zerofl(a5)    ;RAZ zero float
        move.l oozero+4(a6),zerofl+4(a5)
        clr.w flgrun(a5)
; buffers
        move.l sys_buffer(a0),d0
        move.l d0,buffer(a5)            ;Adresse du buffer (monte)
        move.l d0,name1(a5)
        move.l d0,name2(a5)
        add.l #64,name2(a5)
        move.l d0,d1
        addi.l #256,d1
        move.l d1,fsname(a5)
        addi.l #32,d1
        move.l d1,fsbuff(a5)
        move.l d0,a0                    ;Adresse pour calculs...
        move.l d0,a6
        move.l a6,bufpar(a5)            ;buffer des parametres (desc)
        subi.w #512,d0
        move.l d0,defloat(a5)           ;buffer ecriture float
        subi.w #$180,d0
        move.l d0,work(a5)              ;Definition workstation

; save some system exception vectors
        lea svect(a5),a0
        move.l $8,(a0)+
        move.l $c,(a0)+
        move.l $404,(a0)+
        move.l $10,(a0)+
        move.l $14,(a0)+
        lea CErrbus(pc),a0
        move.l a0,$8
        lea CErradr(pc),a0
        move.l a0,$c
        lea CCritic(pc),a0
        move.l a0,$404
        lea CIllins(pc),a0
        move.l a0,$10
        lea CDbyzer(pc),a0
        move.l a0,$14

        tst.w d7                        ;Si Out of MEM
        bne InaErr

; Initialise les extensions
        clr.w flaggem(a5)
        move.l debut(a5),a3
        lea oext(a3),a2
        moveq #MAX_EXTENSIONS-1,d2
        move.l lochaine(a5),a0
        move.l lowvar(a5),a1
Ina20:  cmp.l (a2),a3
        beq.s Ina21
        movem.l d2/a2/a3/a4/a5/a6,-(sp)
        move.l (a2),a2
        clr.w d0
        jsr (a2)
        move.l a2,d1
        movem.l (sp)+,d2/a2/a3/a4/a5/a6
        tst.w d0
        bne.s InaErr
        move.l d1,MAX_EXTENSIONS*4(a2)                      ;Adresse de fin
Ina21:  lea 4(a2),a2
        dbra d2,Ina20
        move.l a0,lochaine(a5)
        move.l a0,hichaine(a5)
        bra.s InaF

;-----> Erreurs systeme
InaErr: moveq #8,d0
        bra errgo
CErrbus:moveq #31,d0
        bra errgo
CErradr:moveq #32,d0
        bra errgo
CCritic:rts
CIllins:moveq #82,d0
        bra errgo
CDbyzer:moveq #46,d0
errgo:  move.l error(a5),a0
        jmp (a0)

; Fin de la sequence de code
InaF:

*************************************************************************
*       DEBUT POUR GEM
*************************************************************************
Inb:

;-----> Efface / Recopie les touches de fonctions ---> buffer
        lea df(pc),a1
        lea bf(pc),a2
        move #20-1,d0
cd0:    move.l a2,a3
cd1:    move.b (a1)+,(a3)+
        bne.s cd1
        add #40,a2
        dbra d0,cd0

*********************** GLOADER.PRG
;-----> Efface SOURIS / CURSEUR
        dc.w $a00a                    ;enleve la souris
        pea cursec(pc)
        move #9,-(sp)
        trap #1
        addq.l #6,sp

;-----> switch to SUPERVISOR mode -if not already-
        clr.l -(sp)         ;passage en mode SUPERVISEUR
        move.w #$20,-(sp)
        trap #1
        addq.l #6,sp
DejaSup:
;-----> Sauve les donnees ecran
        lea dataec(pc),a5
        move.w #3,-(sp)       ;cherche l'adresse LOGIQUE
        trap #14
        addq.l #2,sp
        move.l d0,imagec(a5)
;-----> SAUVE LA PALETTE et ADAPTE A L'ORDINATEUR
;       installe aussi la fausse trappe FLOAT!
        lea $ffff8240,a0
        lea dataec(pc),a1
        moveq #15,d0
bgp1:   move.w (a0)+,(a1)+
        dbra d0,bgp1

; Adapt to ROMS respecting the system
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        lea     adapt(pc),a4
        dc.w    $A000
        lea     -602(a0),a1     ; Position souris
        move.l  a1,adapt_gcurx(a4)
        lea     -692(a0),a1     ; table VDI 1
        move.l  a1,adapt_devtab(a4)
        lea     -498(a0),a1     ; table VDI 2
        move.l  a1,adapt_siztab(a4)

        move.w  #1,-(sp)        ; Adresse du buffer clavier
        move.w  #14,-(sp)
        trap    #14
        addq.l  #4,sp
        move.l  d0,8(a4)

        move.w  #34,-(sp)       ; Adresse des interruptions souris
        trap    #14
        addq.l  #2,sp
        move.l  d0,a0
        lea     16(a0),a1               ; Adresse souris
        move.l  a1,adapt_mousevec(a4)
        lea     24(a0),a0
        lea     Joy_In(pc),a1
        move.l  a0,Joy_Ad-Joy_In(a1)
        move.l  (a0),Joy_Sav-Joy_In(a1)
        move.l  a1,(a0)                 ; Branche la routine joystick
        lea     Joy_Pos+1(pc),a1
        move.l  a1,adapt_joy(a4)          ; Adresse du resultat

; Fausse trappe FLOAT en trappe 6
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        lea FauxFloat(pc),a0
        move.l a0,$98

;-----> Suite sauvegarde
        lea dataec+32(pc),a4
        move.w #4,-(sp)
        trap #14              ; get res
        addq.l #2,sp
        move d0,modec(a5)
        lea adapt(pc),a3
        move.l adapt_devtab(a3),a0              ;table VDI 1
        moveq #45-1,d0
sv1:    move.w (a0)+,(a4)+            ;recopie...
        dbra d0,sv1
        move.l adapt_siztab(a3),a0              ;table VDI 2
        moveq #12-1,d0
sv2:    move.w (a0)+,(a4)+            ;recopie...
        dbra d0,sv2
        move.l adapt_gcurx(a3),a0               ;coordonnees de la souris
        move.l (a0),(a4)+

*********************** CREE LA FAUSSE TABLE DE DONNEES
        move.l $42e,a5
        sub.l #$10000,a5
        sub.l #libre+256,a5             ;debut VAR / Fin Pile!
        move.l a5,a0
        lea -256*4(a0),a4               ;Taille pile: 256 mots longs
        move.l #(libre+256)/4-1,d0
inbt1:  clr.l (a0)+
        dbra d0,inbt1

        move.l 4(sp),a0
        lea 128(a0),a0
        move.l #$01234568,callreg(a5)   ;Command line!
        move.l a0,callreg+4(a5)
        move.l sp,spile(a5)             ;Sauve la pile
        move.l a5,sp                    ;Nouvelle pile
        lea adapt(pc),a3
        move.l a3,ada(a5)               ;adresse adaptation
        move.l adapt_gcurx(a3),adm(a5)             ;adresse souris
        move.l adapt_kbiorec(a3),adk(a5)            ;adresse clavier
        move.l adapt_sndtable(a3),ads(a5)           ;adresse sons

        clr.l -(a4)                     ;Initialise dataprg
        lea dataprg(a5),a0
        move.l a0,adataprg(a5)
        lea 8(a0),a0
        moveq #14,d0
inbb1:  move.l a4,(a0)+
        move.l #2,(a0)+
        dbra d0,inbb1
        move.l a4,d4                    ;TOPMEM multiple de 256
        clr.b d4
        move.l d4,a4
        move.l a4,topmem(a5)
        lea 17*4(a6),a0
        move.l a0,dsource(a5)
        move.l a0,dataprg(a5)
        lea databank(a5),a0             ;DATABANK
        move.l a0,adatabank(a5)
        lea 16*4(a0),a0
        moveq #14,d0
ig3:    move.l #2,(a0)+                 ;Premiere banque: source de deux octets
        moveq #14,d1
ig4:    clr.l (a0)+                     ;Autre banques: longueur nulle
        dbra d1,ig4
        dbra d0,ig3

        move.l $42e,d0                  ;fin de la memoire physique
        subi.l #$8000,d0                ;moins 32 k
        move.l d0,deflog(a5)            ;= ecran logique & physique
        subi.l #$8000,d0                ;moins 32 k
        move.l d0,defback(a5)           ;= decor des sprites

*********************** BOUGE LES BANQUES AU BOUT DE LA MEMOIRE
        move.l OLong(a6),d0             ;Longueur TOTALE
        move.l d0,dataprg+4(a5)
        sub.l ODataB(a6),d0             ;- banque 0 = long banques
        move.l dsource(a5),a0
        add.l ODataB(a6),a0             ;Pointe la premiere banque
        move.l a0,a2
        add.l d0,a0                     ;Pointe la FIN
        move.l topmem(a5),a1            ;Haut de la memoire
        bra.s InbC1
; Copie
InbC0:  move.l -(a0),-(a1)
        move.l -(a0),-(a1)
        move.l -(a0),-(a1)
        move.l -(a0),-(a1)
InbC1:  cmp.l a2,a0
        bhi.s InbC0
        move.l a1,himem(a5)
        move.l a1,lowvar(a5)

        lea ODataB(a6),a0               ;Copie DATABANK
        lea databank(a5),a1
        moveq #16-1,d0
InbC2:  move.l (a0)+,(a1)+
        dbra d0,InbC2

*********************** RELOGE LE PROGRAMME
        move.l a6,d6            ;Addition a reloger
        move.l oreloc(a6),a0    ;Pointe la table de relocation
        move.l a6,a2            ;debut a reloger
        move.l ochvide(a6),a4   ;Chaine vide
        move.l himem(a5),d5     ;Fin de la memoire
        clr.w d7                ;Flag Out of mem
        move.l oozero(a6),d3    ;Zero float
        move.l oozero+4(a6),d4

inb1:   move.b (a0)+,d0
        beq.s inb10
inb2:   cmp.b #1,d0
        bne.s inb3
        add.w #126,a2
        bra.s inb1
inb3:   move.b d0,d1
        andi.w #$007F,d1
        add.w d1,a2
; reloge...
        btst #7,d0
        bne.s inb4
; reloge un JSR / JMP ...
        add.l d6,(a2)           ;Additionne la base
        bra.s inb1
; reloge et CLEAR une variable
inb4:   add.l d6,(a2)           ;Additionne la base
        move.l (a2),a3
        cmp.l a3,d5
        bcc.s inb7              ;Out of mem!
        moveq #1,d7
inb7:   move.b (a0)+,d0         ;Prend le flag de la variable
        btst #4,d0              ;Pas d'init
        beq.s inb1
        tst.w d7                ;Out of mem
        bne.s inb1
        btst #5,d0              ;tableau: RAZ du pointeur!
        bne.s inb5
        andi.b #$C0,d0
        bmi.s inb6
        bne.s inb8
inb5:   clr.l (a3)              ;Clear une entiere
        bra.s inb1
inb6:   move.l a4,(a3)          ;Adresse de la chaine vide
        bra.s inb1
inb8:   move.l d3,(a3)+         ;RAZ float
        move.l d4,(a3)
        bra.s inb1

; Sauve les adresses importantes
inb10:  tst.w d7
        bne ErrM1
        move.l a6,debut(a5)             ;debut du programme
        move.l oerror(a6),error(a5)     ;Traitement des erreurs
        move.l a4,chvide(a5)            ;Chaine vide
        move.l sp,lowpile(a5)           ;Niveau zero de la pile!
        addq.l #4,lowpile(a5)
        move.l oliad(a6),liad(a5)       ;Adresse des litoad
        move.l oadstr(a6),adstr(a5)     ;Adresse Ad-Strings
        move.l ofdata(a6),datastart(a5) ;Datas
        move.l oadmenu(a6),admenu(a5)   ;Menus

; tables VDI...
        lea cvdipb(pc),a2
        move.l a2,vdipb(a5)
        move.l otrappes(a6),a4
        move.l a4,fsource(a5)
        move.l a4,a3
        move.l a4,dta(a5)
        lea 48(a4),a4
        move.l a4,fichiers(a5)
        lea 106*10(a4),a4
        move.l a4,contrl(a5)
        move.l a4,(a2)
        lea 12*2(a4),a4
        move.l a4,intin(a5)
        move.l a4,4(a2)
        lea 128*2(a4),a4
        move.l a4,ptsin(a5)
        move.l a4,8(a2)
        lea 128*2(a4),a4
        move.l a4,12(a2)
        lea 128*2(a4),a4
        move.l a4,16(a2)
        lea 128*2(a4),a4
; buffers
        move.l a4,work(a5)              ;Definition workstation
        lea $180(a4),a4
        move.l a4,defloat(a5)
        lea 512(a4),a4
        move.l a4,bufpar(a5)            ;Parametres, descendant
        move.l a4,buffer(a5)            ;Adresse du buffer (monte)
        move.l a4,a0
        move.l a0,name1(a5)
        move.l a0,name2(a5)
        add.l #64,name2(a5)
        lea 256(a0),a0
        move.l a0,fsname(a5)
        lea 32(a0),a0
        move.l a0,fsbuff(a5)
        lea 512+512+32(a4),a4
; Donnees editeur
        lea bf(pc),a1
        move.l a1,buffunc(a5)
        lea fn(pc),a1
        move.l a1,funcname(a5)
        lea oodfst(a6),a1
        move.l a1,dfst(a5)
        lea ooamb(a6),a1
        move.l a1,amb(a5)
        move.w 36(a1),defmod(a5)
        move.w 38(a1),language(a5)
        clr.w flgrun(a5)
        move.l oozero(a6),zerofl(a5)
        move.l oozero+4(a6),zerofl+4(a5)
; Out of mem?
        cmp.l lowvar(a5),a4
        bcc ErrM1
; Nettoie tous les buffers
inbcl:  clr.l (a3)+
        cmp.l a4,a3
        bcs.s inbcl

; Premier appel des trappes
        move.l a4,a0
        move.l lowvar(a5),a1
; Fenetres
        move.l otrap3(a6),a2
        bsr reloge
        move.l ocr0(a6),a2
        move.l ocr1(a6),a3
        move.l ocr2(a6),a4
        move.l omaxcop(a6),d0
        move.l a6,-(sp)
        move.l otrap3(a6),a6
        jsr (a6)
        move.l (sp)+,a6
        tst.w d0
        bne ErrM1
; Sprites
        move.l otrap5(a6),a2
        bsr reloge
        move.l omou(a6),a2
        lea adapt(pc),a3
        move.l otbufsp(a6),d0
        move.l otrap5(a6),a4
        jsr (a4)
        tst.w d0
        bne ErrM1
; Float?
        move.w ooflola(a6),flola(a5)
        beq.s InbPaf
        move.l otrap6(a6),a2
        bsr reloge
        movem.l a0-a6,-(sp)
        jsr (a2)
        movem.l (sp)+,a0-a6
; Music
InbPaf: move.l otrap7(a6),a2
        bsr reloge
        jsr (a2)
        tst.w d0
        bne ErrM1
        move.l a0,lochaine(a5)

; save some system exception vectors
        lea svect(a5),a0
        move.l $8,(a0)+
        move.l $c,(a0)+
        move.l $404,(a0)+
        move.l $10,(a0)+
        move.l $14,(a0)+
        lea berrbus(pc),a0
        move.l a0,$8
        lea berradr(pc),a0
        move.l a0,$c
        lea bcritic(pc),a0
        move.l a0,$404
        lea billins(pc),a0
        move.l a0,$10
        lea bdbyzer(pc),a0
        move.l a0,$14
; Init inter trappes
        moveq #S_startinter,d0
        lea interflg(a5),a0
        trap #5
        moveq #W_startinter,d7
        trap #3
        moveq #M_startinter,d0
        trap #7
        move.l adk(a5),a0
        move.w 8(a0),ancdb8(a5)
        move.l $400,anc400(a5)
        lea inter50(pc),a0 /* FIXME: self-modifying */
        move.l a5,2(a0)                 ;LOKE l'adresse de la table
        move.l a0,$400

; Initialise les extensions
        move.l bufpar(a5),a6
        lea fingem(pc),a0
        move.l a0,oend(a5)

        move.w #1,flaggem(a5)
        move.l debut(a5),a3
        lea oext(a3),a2
        moveq #MAX_EXTENSIONS-1,d2
        move.l lochaine(a5),a0
        move.l lowvar(a5),a1
inb20:  cmp.l (a2),a3
        beq.s inb21
        movem.l d2/a2/a3/a4/a5/a6,-(sp)
        move.l (a2),a2
        clr.w d0
        jsr (a2)
        move.l a2,d1
        movem.l (sp)+,d2/a2/a3/a4/a5/a6
        tst.w d0
        bne boutmem
        move.l d1,MAX_EXTENSIONS*4(a2)
inb21:  lea 4(a2),a2
        dbra d2,inb20
        move.l a0,lochaine(a5)
        move.l a0,hichaine(a5)

; Fin du programme sous GEM
        move.w #37,-(sp)
        trap #14
        lea 2(sp),sp
        move.l amb(a5),-(sp)            ;Envoie la palette
        move.w #6,-(sp)
        trap #14
        lea 6(sp),sp
        move.l deflog(a5),a0            ;Efface l'ecran
        move.w #32768/8-1,d0
InEc:   clr.l (a0)+
        clr.l (a0)+
        dbra d0,InEc
        bra.w inbf
    
**********************************************
;-----> Erreurs systeme
boutmem:move.w #8,d0
        bra.s berrgo
; Erreur programme
berrbus:moveq #31,d0
        bra.s berrgo
berradr:moveq #32,d0
        bra.s berrgo
bcritic:rts
billins:moveq #82,d0
        bra.s berrgo
bdbyzer:moveq #46,d0
berrgo: move.l error(a5),a0
        jmp (a0)
**********************************************
;-----> FAUSSE TRAPPE FLOAT!
FauxFloat:
        cmp.b #$0c,d0         ;Ramene toujours 0
        beq.s FxFl1
        moveq #0,d0
        moveq #0,d1
        rte
FxFl1:  move.b #"0",(a0)      ;Ramene toujours la chaine nulle
        move.b #".",1(a0)
        move.b #"0",2(a0)
        clr.b 3(a0)
        moveq #3,d0
        rte
**********************************************
; ENTREE DES INTERRUPTIONS 50 HERZ
inter50:lea $ffffff,a2
        addq.l #1,timer(a2)                ;timer!
        tst.l waitcpt(a2)
        beq.s i5
        subq.l #1,waitcpt(a2)             ;compteur WAIT
; A-T-ON APPUYE SUR UNE TOUCHE?
i5:     move.l adk(a2),a1
        move 8(a1),d1
        cmp.w ancdb8(a2),d1
        beq fi5
; BUFFER PLEIN ???
        addq #4,d1
        cmp 6(a1),d1                  ;buffer PLEIN!
        bne.s i5e
        subq #4,d1
        move.l (a1),a0                ;prend le dernier code
        move.l 0(a0,d1.w),d0
        move.w ancdb8(a2),d1          ;et le met a l'avant dernier
        move.w d1,8(a1)
        move.l d0,0(a0,d1.w)          ;pointe l'avant dernier
        bra.s i5f
; test du CONTRL/C, BIP DES TOUCHES
i5e:    subq #4,d1
        move d1,ancdb8(a2)
        move.l (a1),a0                ;buffer clavier
        move.w 2(a0,d1.w),d0          ;code ASCII de la derniere touche
i5f:    cmp.w #3,d0                   ;CONTRL-C (i5ab)
        bne.s i5a
        bset #7,interflg(a2)              ;provoque un test immediat
        bset #0,interflg(a2)              ;OUI: met le flag
i5a:    tst.b bip(a2)                     ;flag: bruit des touches
        bne.s fi5
        cmp #3,d0
        bne.s i5b
        lea b1(pc),a0
        bra.s i5z
i5b:    cmp #13,d0
        bne.s i5c
        lea b2(pc),a0
        bra.s i5z
i5c:    cmp #32,d0
        bcc.s i5d
        lea b3(pc),a0
        bra.s i5z
i5d:    lea b4(pc),a0
i5z:
        sub.l   #23*2,$4a2            ; Safe BIOS interrupt call
        move.l  a0,-(sp)
        move.w  #32,-(sp)
        trap    #14
        addq.l  #6,sp
        add.l   #23*2,$4a2
; fin des interruptions: se rebranche a la routine normale
fi5:    move.l anc400(a2),a0
        jmp (a0)
; BRUIT DES TOUCHES
b1:     dc.b 8,$10,9,$10,10,$10,11,0,12,$10,13,9
        dc.b 0,239,1,0,2,190,3,0,4,159,5,0,6,0,7,$f8,$ff,0
b2:     dc.b 8,$10,9,0,10,0,11,0,12,5,13,9
        dc.b 0,219,1,1,2,0,3,0,4,0,5,0,6,0,7,$fe,$ff,0
b3:     dc.b 8,$10,9,0,10,0,11,0,12,2,13,3
        dc.b 0,119,1,0,2,0,3,0,4,0,5,0,6,0,7,$fe,$ff,0
b4:     dc.b 8,$10,9,0,10,0,13,3,11,$80,12,1
        dc.b 0,80,1,0,2,0,3,0,4,0,5,0,6,0,7,$fe,$ff,0
        even
**********************************************
; RELOGE LES TRAPPES
reloge: movem.l d0-d3/a0-a3,-(sp)
        move.l a2,a1
        move.l 2(a1),d0     ;distance a la table
        add.l 6(a1),d0
        andi.l #$ffffff,d0
        add #$1c,a1         ;pointe le debut du programme
        move.l a1,a2
        move.l a2,d2        ;d2=debut du programme
        add.l d0,a1
        clr.l d0
        tst.l (a1)
        beq.s exec3
        add.l (a1)+,a2      ;pointe la premiere adresse a reloger !!!
        bra.s exec1
exec0:  move.b (a1)+,d0
        beq.s exec3
        cmp.b #1,d0
        beq.s exec2
        add d0,a2           ;pointe dans le prg
exec1:  add.l d2,(a2)       ;change dans le programme
        bra.s exec0
exec2:  add.w #254,a2       ;si 1 saute 254 octets
        bra.s exec0
exec3:  movem.l (sp)+,d0-d3/a0-a3
        rts

**********************************************
* ROUTINE GESTION DU JOYSTICK
**********************************************
Joy_In:
        move.l  a1,-(sp)
        lea     Joy_Pos(pc),a1
        move.b  1(a0),(a1)+
        move.b  2(a0),(a1)
        move.l  (sp)+,a1
        rts

**********************************************
;       FIN BASIC SOUS GEM
**********************************************
fingem: move.l anc400(a5),$400
        moveq #M_stopinter,d0
        trap #7
        moveq #W_stopinter,d7
        trap #3
        moveq #S_stopinter,d0
        trap #5
; Enleve la workstation
        lea otrp1(pc),a0
        move.l $84,(a0)
        lea trp1(pc),a0
        move.l a0,$84
        lea trp2(pc),a0
        move.l work(a5),2(a0)
        move.l contrl(a5),a0
        move.w #101,(a0)
        clr 2(a0)
        clr 6(a0)
        move.w grh(a5),12(a0)
        moveq #$73,d0
        move.l vdipb(a5),d1
        trap #2
        move.l otrp1(pc),$84
; Remet le click des touches
        move.b #7,$484
; Restore la routine d'entree du joystick
        move.l  Joy_Ad(pc),d0
        beq.s   .Skip
        move.l  d0,a0
        move.l  Joy_Sav(pc),(a0)
; RETOUR au gem
.Skip:   lea dataec+32(pc),a4
        lea adapt(pc),a3
        move.l adapt_devtab(a3),a0      ;table VDI 1
        moveq #45-1,d0
lv1:    move.w (a4)+,(a0)+
        dbra d0,lv1
        move.l adapt_siztab(a3),a0      ;table VDI 2
        moveq #12-1,d0
lv2:    move.w (a4)+,(a0)+
        dbra d0,lv2
        move.l adapt_gcurx(a3),a0       ;adresse souris
        move.l (a4)+,(a0)     ;coords de la souris
; Palette / images
        lea dataec(pc),a4
        move.w modec(a4),-(sp)
        move.l imagec(a4),-(sp)
        move.l imagec(a4),-(sp)
        move.w #5,-(sp)
        trap #14
        add #12,sp
        pea dataec(pc)
        move #6,-(sp)
        trap #14
        addq.l #6,sp
; RETOUR!
        tst.w flgrun(a5)                ;Est-ce un RUN?
        bne.s PaRt
ErrM1:  move.l spile(a5),sp
        clr.w -(sp)
        trap #1
PaRt:   rts
; Fausse trappe 1
trp1:   cmp.b #$48,6(sp)
        beq.s trp2
        cmp.b #$49,6(sp)
        beq.s trp3
        move.l otrp1(pc),-(sp)
        rts
trp2:   moveq.l #-1,d0
        rte
trp3:   clr.l d0
        rte
otrp1:  dc.l 0
**********************************************
cvdipb: dc.l 0,0,0,0,0
**********************************************
;-----------------------------> Adaptation aux differentes ROMS
tosversion: .dc.w    0
adapt:      .ds.b    adapt_sizeof
Joy_Sav:        dc.l    0               ; Adresses de gestion du joystick
Joy_Pos:        dc.l    0
Joy_Ad: dc.l    0

dataec:         ds.b    152+4+4
modec   =       152
imagec  =       156
cursec: dc.b    27,"f",0
        even
; BUFFER DES TOUCHES DE FONCTIONS
bf:     ds.b 40*20
        ds.b 64                      ;buffer pour PUT KEY
;DEFAULT FUNCTION KEYS
df:     dc.b " ",0             ;0
        dc.b "list ",0         ;1
        dc.b "listbank`",0     ;2
        dc.b "fload",34,"*.bas",34,"`",0   ;3
        dc.b "fsave",34,"*.bas",34,"`",0   ;4
        dc.b "run`",0          ;5
        dc.b "dir`",0      ;6
        dc.b "dir$= dir$ + ",34,"\`",0      ;7
        dc.b "previous`",0                 ;8
        dc.b "off`",0      ;9
        dc.b "full`",0        ;10
        dc.b "multi 2`",0      ;11
        dc.b "multi 3`",0      ;12
        dc.b "multi 4`",0      ;13
        dc.b "mode 0`",0       ;14
        dc.b "mode 1`",0       ;15
        dc.b "accnew:accload",34,"*",34,"`",0 ;16
        dc.b "default`",0      ;17
        dc.b "env`",0          ;18
        dc.b "key list`",0     ;19
; AFFICHAGE DES TOUCHES DE FONCTION: NOMS
fn:     dc.b "f1: ",0,"f2: ",0,"f3: ",0,"f4: ",0,"f5: ",0
        dc.b "f6: ",0,"f7: ",0,"f8: ",0,"f9: ",0,"f10:",0
        dc.b "f11:",0,"f12:",0,"f13:",0,"f14:",0,"f15:",0
        dc.b "f16:",0,"f17:",0,"f18:",0,"f19:",0,"f20:",0
        even
**********************************************
; Fin de la sequence de code
inbf:




*************************************************************************
*       ROUTINES COMPILATEUR

Hande:  dc.w 0

;-----> Converti et imprime un mot hexa D0
affword:movem.l d0-d7/a0-a6,-(sp)
        swap d0
        move.l d0,d7
        moveq #3,d6
        bra.s Al0
;-----> Converti et imprime un mot long hexa D0
AffLong:movem.l d0-d7/a0-a6,-(sp)
        move.l d0,d7
        moveq #7,d6
Al0:
Al1:    rol.l #4,d7
        move.b d7,d0
        andi.w #$f,d0
        cmp.b #10,d0
        bcs.s Al2
        addq.b #7,d0
Al2:    addi.b #48,d0
        move.w d0,-(sp)
        move.w #2,-(sp)
        move.w #3,-(sp)
        trap #13
        addq.l #6,sp
        dbra d6,Al1
        move.w #32,-(sp)
        move.w #2,-(sp)
        move.w #3,-(sp)
        trap #13
        addq.l #6,sp
        movem.l (sp)+,d0-d7/a0-a6
        rts

AffRet: movem.l d0-d7/a0-a6,-(sp)
        move.w #13,-(sp)
        move.w #2,-(sp)
        move.w #3,-(sp)
        trap #13
        addq.l #6,sp
        move.w #10,-(sp)
        move.w #2,-(sp)
        move.w #3,-(sp)
        trap #13
        addq.l #6,sp
        movem.l (sp)+,d0-d7/a0-a6
        rts

WaitKey:movem.l d1-d7/a0-a6,-(sp)
        move.w #2,-(sp)
        move.w #2,-(sp)
        trap #13
        addq.l #4,sp
        cmp.b #27,d0
        beq csynt
        movem.l (sp)+,d1-d7/a0-a6
        rts

; print
print:  move.l a0,-(sp)
        move.w #$09,-(sp)
        trap #1
        addq.l #6,sp
        rts

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | GESTION DU DISQUE               |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

Datafyche:      dc.l 0

;-----> Set Dta
SetDta: pea cdta
        move.w #$1a,-(sp)
        trap #1
        addq.l #6,sp
        rts

;-----> Initialisation disque
RazDisk:bsr SetDta
        move.l Datafyche(pc),a0
        moveq #Nfyche-1,d0
Rzd0:   moveq #TFyche-1,d1
Rzd1:   clr.b (a0)+
        dbra d1,Rzd1
        dbra d0,Rzd0
        rts

;-----> Ramene la fyche en fonction de D7
GetFich:move.w d7,-(sp)
        mulu #TFyche,d7
        move.l Datafyche(pc),a3
        add.w d7,a3
        move.w (sp)+,d7
        rts

;-----> fsfirst / Copie le nom
;       D7= # de la fyche
fsfirst: move.w #$00,-(sp)
        move.l a0,-(sp)
        move.w #$4e,-(sp)
        trap #1
        addq.l #8,sp
SF:     tst.w d0
        bne.s pala
        lea cdta(pc),a1
        move.l 26(a1),d0
        lea 30(a1),a1
        lea bufdisk(pc),a0
SF1:    move.b (a1)+,(a0)+
        bne.s SF1
        clr.w d1
pala:   rts

; fsnext
fsnext:  move.w #$4f,-(sp)
        trap #1
        addq.l #2,sp
        bra.s SF

;-----> Open /  FAIRE UN SFIRST AVANT!
Open:   lea nomdisk(pc),a0
Open2:  clr.w -(sp)
        move.l a0,-(sp)
        move.w #$3d,-(sp)
        trap #1                         ;OPEN
        addq.l #8,sp
        tst.w d0
        bmi diskerr
        move.l a3,-(sp)
        bsr GetFich
        move.w d0,Poignee(a3)           ;Ouvre la fyche
        move.l cdta+26(pc),d0
        move.l d0,Longfyche(a3)
        clr.l Posfyche(a3)
        move.l (sp)+,a3
        rts

;-----> Create
Create: lea nomdisk(pc),a0
Create2:clr.w -(sp)
        move.l a0,-(sp)
        move.w #$3c,-(sp)
        trap #1                    ;OPEN
        addq.l #8,sp
        tst.w d0
        bmi diskerr
        move.l a3,-(sp)
        bsr GetFich
        move.w d0,Poignee(a3)
        clr.l Longfyche(a3)
        clr.l Posfyche(a3)
        move.l (sp)+,a3
        rts

;-----> LSeek
LSeek:  move.l a3,-(sp)
        bsr GetFich
        sub.l Longfyche(a3),d0
        move.w #2,-(sp)
        move.w (a3),-(sp)
        beq diskerr
        move.l d0,-(sp)
        move.w #$42,-(sp)
        trap #1
        lea 10(sp),sp
        tst.l d0
        bmi diskerr
        move.l d0,Posfyche(a3)
        move.l (sp)+,a3
        rts

;-----> Load
load:   move.l a3,-(sp)
        bsr GetFich
        move.l a0,-(sp)                 ;adresse de chargement
        move.l d0,-(sp)                 ;taille du fichier!
        move.w (a3),-(sp)
        beq diskerr
        move.w #$3f,-(sp)
        trap #1
        lea 4(sp),sp
        cmp.l (sp)+,d0
        bne diskerr
        add.l d0,Posfyche(a3)           ;Change la position du pointeur
        move.l (sp)+,a0
        add.l d0,a0
        move.l (sp)+,a3
        rts

;-----> Write
Write:  move.l a3,-(sp)
        bsr GetFich
        move.l a0,-(sp)                 ;adresse de sauvegarde
        move.l d0,-(sp)                 ;taille du fichier!
        move.w (a3),-(sp)
        beq diskerr
        move.w #$40,-(sp)
        trap #1
        lea 4(sp),sp
        cmp.l (sp)+,d0
        bne diskerr
        add.l d0,Posfyche(a3)           ;Position du pointeur
        move.l Posfyche(a3),d0
        cmp.l Longfyche(a3),d0          ;Augmente la taille de la fyche
        bcs.s Writ1
        move.l d0,Longfyche(a3)
Writ1:  addq.l #4,sp
        move.l (sp)+,a3
        rts

;-----> Ferme un seul fichier
Clofyche:
        bsr GetFich
        tst.w (a3)
        beq.s Clf
        move.w (a3),-(sp)
        move.w #$3e,-(sp)
        trap #1
        addq.l #4,sp
Clf:    rts

;-----> Close: ferme TOUS les fichiers
Close:  moveq #0,d7
Clo1:   bsr GetFich
        tst.w (a3)
        beq.s Clo2
        move.w (a3),-(sp)
        move.w #$3e,-(sp)
        trap #1
        addq.l #4,sp
Clo2:   addq.w #1,d7
        cmp.w #Nfyche,d7
        bcs.s Clo1
        rts

****************************************************************************
*
*       INSTRUCTIONS / FONCTIONS
*
****************************************************************************

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | VARIABLES / EXPRESSIONS         |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> Instruction LET
CLLet:  bsr getbyte
        cmp.b #$fa,d0           ;Veut une variable
        bne csynt

;-----> Entree directe
Clet:   bsr test0               ;Teste les interruptions!
        bsr vari                ;Cree la variable
        move.w d2,-(sp)
        move.l a1,-(sp)
        move.l a0,-(sp)
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr evalue              ;Va evaluer
        tst.w parenth
        bne csynt
        andi.w #$c0,d2
        move.w 8(sp),d1
        bsr eqtype
        bne ctype
; Egalise la variable
Let3:   move.l (sp)+,a0
        move.l (sp)+,a1
        move.w (sp)+,d2
        move.l a0,-(sp)
        bsr varad               ;Cree le LEA varad,a0
        andi.b #$c0,d2
        beq.s Let4
        bmi.s Let4
        move.w #1,floflag
        lea Let6,a0
        bsr code0
        move.l (sp)+,a0
        rts
Let4:   lea Let5,a0
        bsr code0
        move.l (sp)+,a0
        rts
; Chargement variable ENTIERE / ALPHANUMERIQUE
Let5:   move.l (a6)+,(a0)
        dc.w 0
; Chargement variable FLOAT
Let6:   move.l (a6)+,4(a0)
        move.l (a6)+,(a0)
        dc.w 0

;-----> Prend le contenu d'une variable
Var:    bsr vari                ;Va chercher l'adresse
        bsr varad               ;Poke dans le code
        andi.b #$c0,d2           ;Enleve les autres flags
        beq.s VarCE
        bmi.s VarCE
; Variable FLOAT
        move.w #1,floflag
        lea VarCF,a0
        bra code0
VarCF:  move.l (a0)+,-(a6)
        move.l (a0),-(a6)
        dc.w 0
; Variable CHAINE / ENTIERE
VarCE:  lea VarCC,a0
        bra code0
VarCC:  move.l (a0),-(a6)
        dc.w 0

;-----> DIM
Cdim:   bsr getbyte
        cmp.b #$fa,d0           ;Veut une variable
        bne csynt
        bsr vari                ;Va chercher la variable
; Si revient: elle etait deja dimensionnee
RetDim: moveq #E_array_dim,d0             ;Erreur: deja dimensionne!
        bra cerror

;-----> Veritable entree de DIM
EntDim: cmp.l #RetDim,(sp)      ;Vient de DIM???
        addq.l #4,sp
        beq.s CDi1              ;OUI! continue!
; Variable non dimensionnee
        moveq #E_noarray,d0
        bra cerror
; Va chercher le nombre de dimension
CDi1:   bset #4,d1              ;Flag nettoyage!
        move.l a0,-(sp)
        move.w d1,-(sp)
        lea parent,a2           ;Va chercher les parametres
        bsr parfonc
; Poke le nombre de dimensions dans la table et dans le source
        move.w (sp)+,d2
        move.l (sp),a0
        move.b d0,1(a0)
        lea cddim,a0
        subq.w #1,d0            ;Nb de dimensions -1!
        move.b d0,1(a0)
        moveq #2,d1
        move.b d2,d0
        andi.b #$c0,d0
        move.b d0,5(a0)         ;Flag de la variable
        beq.s Vt8
        bmi.s Vt8
        moveq #3,d1
Vt8:    move.b d1,3(a0)         ;Nombre de shifts
        bsr code0
; Poke le LEA
        move.l (sp)+,a0
        bsr ReV0
; Installe la routine
        move.w #L_setdim,d0
        bsr crefonc
;---> Encore une variable?
        bsr getbyte
        cmp.b #",",d0
        beq Cdim
        subq.l #1,a6
        rts
cddim:  moveq #0,d0             ;Nb Dim-1
        moveq #0,d1             ;Nb shifts
        moveq #0,d2             ;Flag
        dc.w $0

;-----> Gestion des adresses des variables
PreVari:bsr getbyte
        cmp.b #$fa,d0
        bne csynt
vari:   bsr pair
        bsr getbyte             ;Prend le flag
        move.b d0,d1
        addq.l #3,a6            ;Pointe le nom
; Copie la variable dans un buffer et saute le nom
        lea BufVar,a0
        move.b d1,d2
        andi.w #$1f,d2
        subq.w #1,d2
Va0:    bsr getbyte
        move.b d0,(a0)+
        dbra d2,Va0
        move.l lovar,a0         ;Adresse des variables
; Explore la table des variables
Va1:    move.l a0,a1
        move.b (a1)+,d2         ;Fin de la table = zero
        beq.s Va5
        cmp.b d1,d2             ;Pas le meme flag?
        bne.s Va3
        addq.l #3,a1            ;Saute le flag
        lea BufVar,a2
        andi.w #$1f,d2
        subq.w #1,d2
Va2:    cmpm.b (a1)+,(a2)+
        bne.s Va3
        dbra d2,Va2
        bra.w VaT
Va3:    add.w 2(a0),a0          ;Pointe la variable suivante
        bra.s Va1
; Stocke la variable, en DESCENDANT vers l'objet
Va5:    move.l lovar,a1
        lea -4(a1),a0
        move.b d1,d2
        andi.w #$1f,d2
        sub.w d2,a0
        move.w a0,d0
        btst #0,d0
        beq.s Va6
        subq.l #1,a0
Va6:    cmp.l botvar,a0         ;Ne descend pas trop bas?
        bcs cout
        move.l a0,lovar
        move.b d1,(a0)          ;Flag
        clr.b 1(a0)
        sub.l a0,a1
        move.w a1,2(a0)         ;Distance a la suivante
        addq.l #4,a0
        subq.w #1,d2
        lea BufVar,a2
Va7:    move.b (a2)+,(a0)+      ;Recopie le nom
        dbra d2,Va7
        move.l lovar,a0         ;Adresse de la variable
        bset #4,d1              ;Flag CLEAR
        move.b d1,d0
        andi.b #$c0,d0
        bpl.s Va7a
        addq.l #4,adstring       ;Taille de la table Ad variables alpha
Va7a:   btst #6,d1              ;Variable FLOAT?
        beq.s Va7b
        move.w #1,floflag       ;Met le FLOAT!
Va7b:   btst #5,d1
        bne EntDim
;---> Variable trouvee!
VaT:    move.b d1,d2            ;Ramene le flag en D2 / A0=adresse
        andi.b #$F0,d2           ;Garde le flag tableau / flag clear
        btst #5,d2
        bne.s VaT0
        rts
;---> Variable tableau: saute la parenthese
VaT0:   move.l a6,a1            ;CHRGET au debut de la ( )
        movem.l a0/a1/d2,-(sp)
        movem.l a4/a5,-(sp)
        move.l OldRel,-(sp)
        lea parent,a2
        bsr parfonc
        move.l (sp)+,OldRel
        movem.l (sp)+,a4/a5
        movem.l (sp)+,a0/a1/d2
        cmp.b 1(a0),d0          ;Est-ce le bon nombre de dimensions?
        bne csynt
        rts

;-----> Code prend adresse variable: LEA VARAD,A0
varad:  btst #5,d2
        bne.s ReT
; Variable simple ...
ReV0:   move.w #cleaa0,d0        ;Code: LEA adresse variable,a0
        bsr outword
; Change la table de relocation
        move.l a5,d0
        sub.l OldRel,d0
ReV1:   cmp.w #126,d0
        bls.s ReV2
        bsr OutRel1             ;>126: met 1 et boucle
        subi.w #126,d0
        bra.s ReV1
ReV2:   bset #7,d0              ;Flag #7=1 ---> VARIABLE
        bsr OutRel
        move.b d2,d0
        bsr OutRel              ;Poke le flag
        move.l a5,OldRel
        move.l a0,d0
        bsr outlong
        rts
; Variable TABLEAU
ReT:    move.l a6,-(sp)
        move.l a1,a6            ;Adresse du debut ( , , )
        movem.l a0/d2,-(sp)
        lea parent,a2
        bsr parfonc
        movem.l (sp)+,a0/d2
        cmp.b 1(a0),d0          ;Meme nombre de dimensions?
        bne csynt
        move.l (sp)+,a6         ;Repointe au bon endroit
        bsr ReV0                ;Poke le LEA
        move.w #L_getdim,d0       ;Trouve l'adresse
        bra crefonc

;----------------------------------> EXPRESSIONS

;-----> Empile les parametres d'une instruction
;       A2 pointe sur la table de d‚finition des parametres
parinst:
        move.l a2,-(sp)         ;Definitions des formats
        movem.l a4-a6,-(a3)     ;Stocke les parametres
        move.l OldRel,-(a3)
        lea -32(a3),a3          ;Stocke la definition dans la pile
        move.l a3,a2            ;debut du format
; Recupere les parametres / stocke le format
Ins1:   move.l a2,-(sp)
        bsr evalue
        move.l (sp)+,a2
        andi.b #$c0,d2
        move.b d2,(a2)+         ;Stocke le type
        tst.w parenth
        bne csynt
        bsr getbyte
        tst.b d0
        beq.s Ins2
        cmp.b #":",d0
        beq.s Ins2
        cmp.b #$9b,d0           ;Else
        beq.s Ins2
        move.b d0,(a2)+         ;Stocke le separateur
        bra.s Ins1
Ins2:   move.b #1,(a2)+
        subq.l #1,a6            ;Reste sur le separateur
; Trouve la bonne chaine
        lea 32(a3),a3           ;Remet la pile
        move.l (sp)+,a2         ;debut de la definition
        moveq #0,d4             ;Numero du format
Ins3:   lea -32(a3),a1          ;debut du format trouve
        move.l a2,a0            ;debut du format definition
        clr.w d0                ;Flag "PRESQUE CA"
        addq.w #1,d4
Ins4:   move.b (a0)+,d1         ;Prend le parametre DEFINITION
        move.b (a1)+,d2         ;Prend le parametre TROUVE
        cmp.b d1,d2
        bne.s Ins5
Ins0:   move.b (a0)+,d1         ;Compare les separateurs
        move.b (a1)+,d2
        cmp.b d1,d2             ;Les separateurs doivent etre le mm
        bne.s Ins6
        cmp.b #1,d1             ;Trouve?
        bne.s Ins4
        beq.s Ins7
Ins5:   cmp.b #1,d1             ;Un des 2 est a la fin
        beq.s Ins6
        cmp.b #1,d2
        beq.s Ins6
        tst.b d1                ;Type mismatch?
        bmi.s Ins6
        tst.b d2
        bmi.s Ins6
        addq.l #1,d0            ;Flag "PRESQUE CA"
        bra.s Ins0
Ins6:   cmp.b #1,(a2)+          ;Definition suivante: cherche la fin
        bne.s Ins6
        cmp.b #1,(a2)           ;C'est le dernier!
        bne.s Ins3
; Rate! aucun ne va
        bra csynt
; On a trouve une chaine
Ins7:   tst.w d0                ;Des conversion FL/INT a faire?
        bne.s InsR              ;Non---> c'est fini!
        lea 16(a3),a3           ;Restore la pile
        move.w d4,d0            ;Met les flags
        rts
; Il faut recommencer l'evaluation en adaptant les formats
InsR:   move.w d4,-(sp)
        move.l (a3)+,OldRel     ;Restore tous les registres
        movem.l (a3)+,a4-a6
Ins8:   move.l a2,-(sp)
        bsr evalue
        move.l (sp)+,a2
        move.b (a2)+,d1
        bsr eqtype
        addq.l #1,a6
        cmp.b #1,(a2)+
        bne.s Ins8
        subq.l #1,a6            ;Reste sur le separateur
        move.w (sp)+,d0
        rts

;-----> Empile les parametres d'une fonction
;       A2 pointe sur la table de d‚finition des parametres
parfonc:
        move.w parenth,-(sp)
        bsr getbyte
        cmp.b #"(",d0
        bne csynt
        move.l a2,-(sp)         ;Definitions des formats
        movem.l a4-a6,-(a3)     ;Stocke les parametres
        move.l OldRel,-(a3)
        lea -32(a3),a3          ;Stocke la definition dans la pile
        move.l a3,a2            ;debut du format
; Recupere les parametres / stocke le format
Fnc1:   move.l a2,-(sp)
        bsr evalue
        move.l (sp)+,a2
        andi.b #$c0,d2
        move.b d2,(a2)+         ;Stocke le type
        cmp.w #-1,parenth
        beq.s Fnc2
        tst.w parenth
        bne csynt
        bsr getbyte
        move.b d0,(a2)+         ;Stocke le separateur
        bra.s Fnc1
Fnc2:   move.b #1,(a2)+
; Trouve la bonne chaine
        lea 32(a3),a3           ;Remet la pile
        move.l (sp)+,a2         ;debut de la definition
        moveq #0,d4             ;Numero du format
Fnc3:   lea -32(a3),a1          ;debut du format trouve
        move.l a2,a0            ;debut du format definition
        clr.w d0                ;Flag "PRESQUE CA"
        addq.w #1,d4
Fnc4:   move.b (a0)+,d1         ;Prend le parametre DEFINITION
        move.b (a1)+,d2         ;Prend le parametre TROUVE
        cmp.b d1,d2
        bne.s Fnc5
Fnc0:   move.b (a0)+,d1         ;Compare les separateurs
        move.b (a1)+,d2
        cmp.b d1,d2
        bne.s Fnc6
        cmp.b #1,d1             ;Trouve?
        bne.s Fnc4
        beq.s Fnc7
Fnc5:   cmp.b #1,d1             ;Un des 2 est a la fin
        beq.s Fnc6
        cmp.b #1,d2
        beq.s Fnc6
        tst.b d1                ;Type mismatch?
        bmi.s Fnc6
        tst.b d2
        bmi.s Fnc6
        addq.l #1,d0            ;Flag "PRESQUE CA"
        bra.s Fnc0
Fnc6:   cmp.b #1,(a2)+          ;Definition suivante: cherche la fin
        bne.s Fnc6
        cmp.b #1,(a2)           ;C'est le dernier!
        bne.s Fnc3
; Rate! aucun ne va
        bra csynt
; On a trouve une chaine
Fnc7:   tst.w d0                ;Des conversion FL/INT a faire?
        bne.s Fncr              ;Non---> c'est fini!
        lea 16(a3),a3           ;Restore la pile
        move.w (sp)+,parenth    ;Niveau de parentheses
        move.w d4,d0            ;Met les flags
        rts
; Il faut recommencer l'evaluation en adaptant les formats
Fncr:   move.w d4,-(sp)
        move.l (a3)+,OldRel     ;Restore tous les registres
        movem.l (a3)+,a4-a6
Fnc8:   move.l a2,-(sp)
        bsr evalue
        move.l (sp)+,a2
        move.b (a2)+,d1
        bsr eqtype
        cmp.b #1,(a2)+
        beq.s Fnc9
        addq.l #1,a6
        bra.s Fnc8
Fnc9:   move.w (sp)+,d0
        move.w (sp)+,parenth
        rts

;-----> Evaluation d'une expression
evalue: clr parenth
; Entree recursive
EvalBis:move.w #debop,d0        ;Signal de fin
        bra.s Ev1
Ev0:    move.w d2,-(a3)
Ev1:    move.w d0,-(a3)
        bsr Operand
Ev2:    bsr getbyte             ;Prend l'operateur
        andi.w #$ff,d0
        cmp.w (a3),d0
        bhi.s Ev0

        subq.l #1,a6            ;Reste sur le meme pointeur
        move.w (a3)+,d1         ;Depile l'operateur
        subi.w #debop,d1
        beq.s EvFin
        lsl.w #2,d1
        lea opjumps,a0
        move.l 0(a0,d1.w),a0
        move.w (a3)+,d5         ;Depile le 1er operande
        jsr (a0)                ;Effectue l'operateur
        bra.s Ev2

EvFin:  cmp.b #")",d0           ;Fermeture d'une parenthese?
        bne.s Ev3
        subq.w #1,parenth
        bsr getbyte
Ev3:    rts

;-----> Prend un operande
Operand:clr.w -(sp)             ;Pas de signe moins devant
Op0:    bsr getbyte
        beq csynt
        bpl.s Op3
        cmp.b #$F5,d0           ;Signe moins?
        beq.s Op2
        andi.w #$ff,d0
        subi.w #DebFonc,d0
        bcs csynt
        addq.w #1,CptInst
        lsl.w #2,d0             ;Appelle la routine
        lea fnjumps,a0
        move.l 0(a0,d0.w),a0
        jsr (a0)
; Changement de signe?
Op1:    move.w (sp)+,d0         ;Ressort le signe
        bne.s Cs5
        rts
Cs5:    tst.b d2
        beq.s Cs3
        bmi csynt
; Changement de signe float
        lea Cs2,a0
        bra code0
Cs2:    move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_inv,d0
        trap #6
        move.l d3,-(a6)
        move.l d4,-(a6)
        dc.w 0
; Changement de signe entier
Cs3:    lea Cs4,a0
        bra code0
Cs4:    neg.l (a6)
        dc.w 0
; Signe moins
Op2:    tst.w (sp)
        bne csynt
        move.w #1,(sp)
        bra.s Op0
; parenthese?
Op3:    cmp.b #"(",d0
        bne csynt
        addq.w #1,parenth
        bsr EvalBis
        bra Op1

;-----> Egalise le type du resultat (D2/(A6))
;       au type demande D1
eqtype: movem.w d1-d2,-(sp)
        andi.b #$c0,d1
        andi.b #$c0,d2
        cmp.b d1,d2             ;Compare les flags
        beq.s Eqt3
        tst.b d1                ;Une des deux alphanumerique?
        bmi.s Eqt4
        tst.b d2
        bmi.s Eqt4
        tst.b d1                ;Fait la conversion
        beq.s Eqt1
        move.w #1,floflag
        moveq #L_inttofl,d0       ;JSR inttofl
        move.b #$40,d2
        bra.s Eqt2
Eqt1:   move.w #1,floflag
        moveq #L_fltoint,d0     ;JSR fltoint
        clr.b d2
Eqt2:   bsr crefonc
Eqt3:   movem.w (sp)+,d1-d2     ;Retour: 0= OK
        moveq #0,d0
        rts
Eqt4:   movem.w (sp)+,d1-d2     ;1= Type mismatch
        moveq #1,d0
        rts

;-----> Prend une constante ENTIERE
CEnt:   move.w #cmvima6,d0
        bsr outword
        bsr pair
        bsr GetLong
        bsr outlong
        clr.b d2
        rts

;-----> Prend une constante FLOAT
CFlo:   move.w #1,floflag
        bsr pair
        move.w #cmvima6,d0
        bsr outword
        bsr GetLong
        bsr outlong
        move.w #cmvima6,d0
        bsr outword
        bsr GetLong
        bsr outlong
        move.b #$40,d2
        rts

;-----> Prend une constante CHAINE
CChai:  bsr pair
        move.w #cmvima6,d0       ;Adresse de la constante ---> -(A6)
        bsr outword
        bsr reljsr              ;Poke la table de relocation
        move.l AdChai,a0
        move.l a0,d0            ;Adresse dans la table AdChaines
        ori.l #$80000000,d0      ;Marque qu'il s'agit d'une constante!
        bsr outlong
        tst.w passe
        beq.s CCh1
        move.l a6,(a0)+         ;NON: loke l'adresse dans le source
        clr.l (a0)              ;Fin des constantes
        move.l a0,AdChai
        addq.l #2,a6
        bsr GetWord
        add.w d0,a6             ;Saute la constante
        move.b #$80,d2          ;Chaine
        rts
CCh1:   addq.l #4,a0            ;Ne poke pas si passe 0
        move.l a0,AdChai
        moveq #0,d0
        addq.l #2,a6
        bsr GetWord             ;Compte la longueur des constantes
        add.w d0,a6
        add.l d0,LongChai
        addq.l #2,LongChai
        move.b #$80,d2
        rts

;-----> Meme type d'operande (FLOAT si <>)
compat: cmp.b d2,d5
        bne.s quefloat
        tst.b d2
        rts

;-----> Que des floats
quefloat:
        move.w #1,floflag
        tst.b d2                ;Change le 2eme en FLOAT
        bmi ctype
        bne.s Qf1
        moveq #L_inttofl,d0
        bsr crefonc
        move.w #$40,d2
Qf1:    tst.b d5                ;Change le 1er en FLOAT
        bmi ctype
        bne.s Qf2
        lea Qf3,a0              ;depile le 2eme
        bsr code0
        moveq #L_inttofl,d0     ;Change
        bsr crefonc
        lea Qf4,a0              ;rempile
        bsr code0
        move.b #$40,d5
Qf2:    rts
Qf3:    move.l (a6)+,d5
        move.l (a6)+,d4
        dc.w 0
Qf4:    move.l d4,-(a6)
        move.l d5,-(a6)
        dc.w 0

;-----> Que des entiers
Quentier:
        tst.b d2
        beq.s Qe1
        bmi ctype
        move.w #1,floflag
        moveq #L_fltoint,d0
        bsr crefonc
        clr.b d2
Qe1:    tst.b d5
        beq.s Qe2
        bmi ctype
        lea Qe3,a0
        bsr code0
        move.w #1,floflag
        moveq #L_fltoint,d0
        bsr crefonc
        clr.b d5
        lea Qe4,a0
        bsr code0
Qe2:    rts
Qe3:    move.l (a6)+,d4
        dc.w 0
Qe4:    move.l d4,-(a6)
        dc.w 0

;-----> Expression ALPHANUMERIQUE seulement
expalpha:
        bsr evalue
        tst.w parenth
        bne csynt
        tst.b d2
        bpl ctype
        rts

;-----> Expression ENTIERE seulement
expentier:
        bsr evalue
        tst.w parenth
        bne csynt
        tst.b d2
        bmi ctype
        beq.s Exe
        clr.b d2
        move.w #1,floflag
        moveq #L_fltoint,d0
        bsr crefonc
Exe:    rts

;-----> CONSTANTE? D1=1 oui (D0=const) (pour GOTO / GOSUB ...)
Constant:
        bsr getbyte
        subq.l #1,a6
        cmp.b #$fe,d0
        bne.s Cst2
; Ca commence bien!
        movem.l a4-a6,-(sp)
        move.l OldRel,-(sp)
        move.l a6,d2
        addq.l #1,a6
        bsr pair                        ;Saute la constante
        addq.l #4,a6
        move.l a6,-(sp)
        move.l d2,a6                    ;Repointe la constante
        bsr expentier                   ;Va evaluer
        cmp.l (sp)+,a6                  ;Pointe au meme endroit
        bne.s Cst1
; C'est une constante!
        move.l (sp)+,OldRel             ;Repointe au debut
        movem.l (sp)+,a4-a6
        addq.l #1,a6
        bsr pair
        bsr GetLong
        move.l d0,d1                    ;Ramene la constante
        moveq #1,d0
        rts
; C'est pas une constante!
Cst1:   move.l (sp)+,OldRel
        movem.l (sp)+,a4-a6
; evalue l'expression
Cst2:   bsr expentier
        moveq #0,d0
        rts

;-----> Fonction UN param FLOAT seulement
Flop:   dc.b fl,1,1,0
   .even
fflo:   lea Flop,a2
        bra parfonc

;-----> Fonction UN param ENTIER seulement
Flep:   dc.b en,1,1,0
   .even
fent:   lea Flep,a2
        bra parfonc

;-----> Fonction UN param CHAINE seulement
Flap:   dc.b ch,1,1,0
   .even
FChai:  lea Flap,a2
        bra parfonc

;-----> Fonction UN param CHIFFRE seulement BEQ-> entier / BNE-> FLOAT
FArg:   bsr getbyte
        cmp.b #"(",d0
        bne csynt
        move.w parenth,-(sp)
        bsr evalue
        cmp.w #-1,parenth
        bne csynt
        move.w (sp)+,parenth
        tst.b d2
        bmi ctype
        rts


;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | CALCULS / FONCTION MATHEMATIQUE |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> TRUE
CVrai:  lea ctru(pc),a0
        bsr code0
        clr.b d2
        rts
;-----> FALSE
CFaux:  lea cfal(pc),a0
        bsr code0
        clr.b d2
        rts
ctru:   move.l #$ffffffff,-(a6)
        dc.w 0
cfal:   clr.l -(a6)
        dc.w 0

;-----> DEF FN
CDef:   bsr getbyte
        cmp.b #T_fn,d0
        beq.s df0
        cmp.b #T_extinst,d0                 ;Cherche un defscroll
        bne csynt
        bsr getbyte
        cmp.b #T_exti_scroll,d0
        beq Cdefscroll
        bne csynt
df0:    move.w #cbra,d0
        bsr outword
        move.l a5,-(sp)
        clr.w d0
        bsr outword
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        andi.b #$c0,d2
        bne csynt
; Recupere les adresses des variables
        move.l ADefn,a2                 ;table des Deffn
        move.l a0,(a2)+                 ;Adresse de la variable
        move.l a5,(a2)+                 ;Adresse dans l'objet
        clr.w (a2)+
        bsr getbyte
        subq.l #1,a6
        cmp.b #"(",d0
        bne.s Df2
        addq.l #1,a6
Df1:    bsr getbyte
        cmp.b #$fa,d0                   ;Veut une variable
        bne csynt
        move.l a2,-(sp)
        bsr vari
        bsr varad
        lea cddf,a0
        bsr code0
        andi.w #$c0,d2
        bset #15,d2
        move.l (sp)+,a2                 ;Stocke le flag
        move.w d2,(a2)+
        bsr getbyte
        cmp.b #",",d0
        beq.s Df1
        cmp.b #")",d0
        bne csynt
Df2:    bsr getbyte
        cmp.b #$f1,d0                   ;EGAL?
        bne csynt
        clr.w (a2)+
        clr.l (a2)                      ;Signale la fin!
        cmp.l lovar,a2
        bcc cout
        move.l a2,-(sp)
; evalue l'expression
        bsr evalue
        tst.w parenth
        bne csynt
        move.w #crts,d0
        bsr outword
; Poke le type de l'expression / remonte botvar
        move.l ADefn,a2
        move.w d2,8(a2)
        move.l (sp)+,d0
        move.l d0,ADefn
        addq.l #4,d0
        move.l d0,botvar
; reloge le BRA
        move.l (sp)+,d0
        move.l a5,-(sp)
        sub.l d0,a5
        exg d0,a5
        bsr outword
        move.l (sp)+,a5
        rts
cddf:   lea cddf1(pc),a2
        rts
cddf1:  dc.w 0

;-----> FNxxxc (skjk,qslmdjqs)
CFn:    move.w parenth,-(sp)
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        move.l AdADefn,a2
CFn1:   tst.l (a2)              ;Cherche dans la table
        beq CFn9
        cmp.l (a2)+,a0
        beq.s CFn3
        addq.l #6,a2            ;Adresse / flag
CFn2:   tst.w (a2)+
        bne.s CFn2
        bra.s CFn1
CFn3:   move.w #cleaa2,d0       ;LEA adresse,a2
        bsr outword             ;MOVE.L A2,-(SP)
        bsr reljsr
        move.l (a2)+,d0
        sub.l objet,d0
        bset #30,d0
        bsr outlong
        lea cdfn1,a0
        bsr code0
        move.w (a2)+,-(sp)      ;Pousse le flag de l'expression
; Prend les expressions/egalise
        bsr getbyte
        subq.l #1,a6
        cmp.b #"(",d0
        bne.s CFn5
        addq.l #1,a6
cfn4:   move.l a2,-(sp)
        bsr evalue
        andi.w #$c0,d2
        move.l (sp)+,a2
        move.w (a2)+,d1
        beq.s CFn8
        andi.w #$c0,d1
        bsr eqtype
        bne ctype
        lea cdfn2,a0
        bsr code0
        lea Let5,a0
        tst.b d1
        beq.s cfn4a
        bmi.s cfn4a
        lea Let6,a0
cfn4a:  bsr code0
        cmp.w #-1,parenth
        beq.s CFn5
        tst.w parenth
        bne csynt
        bsr getbyte
        cmp.b #",",d0
        beq.s cfn4
        bra csynt
; Fini
CFn5:   tst.w (a2)
        bne.s CFn8
        lea cdfn3,a0                    ;Appelle l'expression
        bsr code0
        move.w (sp)+,d2                 ;Flag de l'expression
        move.w (sp)+,parenth
        rts
cdfn1:  move.l a2,-(sp)
        dc.w 0
cdfn2:  move.l (sp)+,a2
        jsr (a2)
        move.l a2,-(sp)
        dc.w 0
cdfn3:  move.l (sp)+,a2
        jsr (a2)
        dc.w 0
CFn8:   moveq #E_illegalcall,d0                    ;Illegal user
        bra cerror
CFn9:   moveq #E_userfunction,d0                    ;User not def
        bra cerror

;-----> SWAP
Cswap:  bsr test0
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bsr varad
        move.w d2,-(sp)
        lea CSw,a0
        bsr code0
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bsr varad
        move.w (sp)+,d1
        andi.w #$c0,d1
        andi.w #$c0,d2
        cmp.w d1,d2
        bne ctype
        tst.b d1
        beq.s CSw1
        bmi.s CSw1
        move.w #1,floflag
        move.w #L_swap_f,d0
        bra crefonc
CSw1:   move.w #L_swap,d0
        bra crefonc
CSw:    move.l a0,-(a6)
        dc.w 0

;-----> INC
Cinc:   bsr test0
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bsr varad
        andi.b #$c0,d2
        bne ctype
        lea CdIn,a0
        bra code1
CdIn:   addq.l #1,(a0)
        dc.w $1111

;-----> DEC
Cdec:   bsr test0
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bsr varad
        andi.b #$c0,d2
        bne ctype
        lea CdDe,a0
        bra code1
CdDe:   subq.l #1,(a0)
        dc.w $1111

;-----> SORT
CSort:  bsr test0
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bclr #5,d2              ;Veut un tableau
        beq ctype
        bsr varad               ;Ne met QUE LE POINTEUR!
        andi.b #$c0,d2
        move.w #cmvqd0,d0
        move.b d2,d0
        bsr outword
        move.w #L_sort,d0
        bra crefonc

;-----> MATCH(a(0),b)
CMach:  bsr getbyte
        cmp.b #"(",d0
        bne csynt
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bclr #5,d2
        beq ctype
        move.l a0,-(sp)
        move.w d2,-(sp)
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        move.w parenth,-(sp)
        bsr evalue
        cmp.w #-1,parenth
        bne csynt
        move.w (sp)+,parenth
        move.w (sp),d1                 ;Egalise les types
        bsr eqtype
        bne ctype
        move.w (sp)+,d2
        move.l (sp)+,a0
        bsr varad
        move.w #cmvqd0,d0                ;Moveq #type,d0
        andi.b #$c0,d2
        move.b d2,d0
        bsr outword
        move.w #L_match,d0
        bra creent

;-----> Operateur PLUS
CPlus:  bsr compat
        beq.s CPl2
        bmi.s CPl1
; Addition FLOAT
        move.w #1,floflag
        moveq #L_plusfl,d0
        bra crefonc
; Addition de CHAINES
CPl1:   moveq #L_plusch,d0
        bra crefonc
; Addition entiere DIRECTE
CPl2:   lea CPl3,a0
        bra code0
CPl3:   move.l (a6)+,d0
        add.l d0,(a6)
        dc.w 0

;-----> Operateur MOINS
CMoin:  bsr compat
        beq.s CMo2
        bmi.s CMo1
; Soustraction FLOAT
        move.w #1,floflag
        moveq #L_moinfl,d0
        bra crefonc
; Soustraction de CHAINES
CMo1:   moveq #L_moinch,d0
        bra crefonc
; Soustraction entiere DIRECTE
CMo2:   lea CMo3,a0
        bra code0
CMo3:   move.l (a6)+,d0
        sub.l d0,(a6)
        dc.w 0

;-----> Operateur *
CMult:  bsr compat
        beq.s CMu
        bmi ctype
; Mult FLOAT
        move.w #1,floflag
        moveq #L_multfl,d0
        bra crefonc
; Mult Entiere
CMu:    moveq #L_multen,d0
        bra crefonc

;-----> Operateur /
CDivi:  bsr compat
        beq.s CDi
        bmi ctype
; Divi FLOAT
        move.w #1,floflag
        moveq #L_divifl,d0
        bra crefonc
; Divi Entiere
CDi:    moveq #L_divien,d0
        bra crefonc

;-----> Operateur MODULO
Cmodu:  bsr Quentier
        moveq #L_modulo,d0
        bra crefonc

;-----> Operateur POWER
CPuis:  bsr quefloat
        moveq #L_power,d0
        bra crefonc

;-----> Operateur =
CEgal:  moveq #L_egal,d0
        bra.s CompAll
;-----> Operateur <>
CDiff:  moveq #L_diff,d0
        bra.s CompAll
;-----> Operateur <
CInf:   moveq #L_inf,d0
        bra.s CompAll
;-----> Operateur >
CSup:   moveq #L_sup,d0
        bra.s CompAll
;-----> Operateur <=
CInfe:  moveq #L_infe,d0
        bra.s CompAll
;-----> Operateur >=
CSupe:  moveq #L_supe,d0

; Comparateurs sur les trois types
CompAll:move.w d0,-(sp)
        bsr compat
        move.w (sp)+,d0
        tst.b d2
        beq.s Opa3
        bmi.s Opa1
        move.w #1,floflag
        bne.s Opa2
Opa1:   addq.w #1,d0
Opa2:   addq.w #1,d0
Opa3:   bsr crefonc
        clr.b d2                ;Resultat ENTIER
        rts

;-----> Operateur OR
COr:    bsr Quentier
        lea COr2,a0
COr1:   bsr code0
        clr.b d2
        rts
COr2:   move.l (a6)+,d0
        or.l d0,(a6)
        dc.w 0

;-----> Operateur AND
CAnd:   bsr Quentier
        lea CAnd1,a0
        bra.s COr1
CAnd1:  move.l (a6)+,d0
        and.l d0,(a6)
        dc.w 0

;-----> Operateur XOR
CXor:   bsr Quentier
        lea CXor1,a0
        bra.s COr1
CXor1:  move.l (a6)+,d0
        eor.l d0,(a6)
        dc.w 0

;-----> Fonction NOT
CNot:   bsr fent
        lea CNt,a0
        bra.s COr1
CNt:    not.l (a6)
        dc.w 0

;-----> RAD
CRad:   bsr fflo
        moveq #L_raddbl,d0
        bra creflo
;-----> DEG
CDeg:   bsr fflo
        moveq #L_degdbl,d0
        bra creflo
;-----> PI
CPi:    moveq #L_pidbl,d0
        bra creflo

;-----> SINUS
CSin:   moveq #L_sin,d0
CS1:    move.w d0,-(sp)
        bsr fflo                ;1 param FLOAT
        move.w (sp)+,d0
        bra creflo              ;Cree le JSR / ramene un FLOAT
;-----> COSINUS
CCos:   moveq #L_cos,d0
        bra.s CS1
;-----> TANGENTE
CTan:   moveq #L_tan,d0
        bra.s CS1
;-----> EXPONANTIELLE
CExp:   moveq #L_exp,d0
        bra.s CS1
;-----> LOGN
Clogn:  moveq #L_logn,d0
        bra.s CS1
;-----> LOG10
Clog1:  moveq #L_log,d0
        bra.s CS1
;-----> SQR
CSqr:   moveq #L_sqr,d0
        bra.s CS1
;-----> SINH
CSinh:  moveq #L_sinh,d0
        bra.s CS1
;-----> CCOSH
CCosh:  moveq #L_cosh,d0
        bra.s CS1
;-----> CTANH
CTanh:  moveq #L_tanh,d0
        bra.s CS1
;-----> ASIN
CAsin:  moveq #L_asin,d0
        bra.s CS1
;-----> ACOS
CAcos:  moveq #L_acos,d0
        bra.s CS1
;-----> ATAN
CAtan:  moveq #L_atan,d0
        bra.s CS1

;-----> ABS
CAbs:   bsr FArg
        bne.s Ca1
        moveq #L_abs,d0
creent: clr.b d2
        bra crefonc
Ca1:    moveq #L_fabs,d0
creflo: move.w #1,floflag
        move.b #$40,d2
        bra crefonc

;-----> INT
CInt:   bsr FArg
        beq.s Ci1               ;INT(entier)= IDIOT!
        moveq #L_int,d0
        bra creflo
Ci1:    rts

;-----> SGN
CSgn:   bsr FArg
        bne.s Ci2
        moveq #L_sgn,d0
        bra creent
Ci2:    move.w #1,floflag
        moveq #L_sgnf,d0
        bra creent

;-----> RND
CRnd:   bsr fent
        moveq #L_rnd,d0
        bra creent

;-----> Sous prg MAX / MIN
MaxMin: bsr getbyte
        cmp.b #"(",d0
        bne csynt
        move.w parenth,-(sp)
        bsr evalue
        tst.w parenth
        bne csynt
        move.w d2,-(sp)
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr evalue
        cmp.w #-1,parenth
        bne csynt
        move.w (sp)+,d5
        move.w (sp)+,parenth
        bsr compat
        rts

;-----> MAX
CMax:   bsr MaxMin
        move.w #L_max,d0
Cm0:    tst.b d2
        beq creent
        addq.l #1,d0       ; -> L_max_f/L_min_f
        tst.b d2
        bpl creflo
        addq.l #1,d0       ; -> L_max_s/L_min_s
        bra crech

;-----> MIN
CMin:   bsr MaxMin
        move.w #L_min,d0
        bra.s Cm0

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | BOUCLES / BRANCHEMENTS          |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;------------------------------> TESTS DU COMPILATEUR

;-----> Instruction de NIVEAU 0 : RAPIDE!
test0:  cmp.w #2,Tests
        bne.s Ptt1
Ptt0:   movem.l d0-d7/a0-a2,-(sp)
        moveq #L_tester,d0
        bsr crefonc
        movem.l (sp)+,d0-d7/a0-a2
Ptt1:   rts

;-----> Instruction de NIVEAU 1 : BRANCHEMENT!
Test1:  tst.w Tests
        beq.s Ptt1
        bne.s Ptt0

;------------------------------> REM!
Crem:   addq.l #4,sp            ;Va a la ligne suivante
        subq.l #4,a5            ;Enleve le LEA
        bra FinLine

;------------------------------> END
CEnd:   moveq #L_finistos,d0
        tst.w cflaggem
        beq crefonc
        moveq #L_finigem,d0
        bra crefonc

;------------------------------> STOP
CStop:  lea cdstp,a0
        bra code0
cdstp:  moveq #17,d0
        move.l error(a5),a0
        jmp (a0)

;------------------------------> GOTO
Cgoto:  bsr Test1
        bsr pair
        addq.l #4,a6
        bsr Constant
        beq.s Gt1
; GOTO #LIGNE
Gto:    move.w #cjmp,d0
        bsr outword
        bsr reljsr
        move.l d1,d0            ;Loke le # de ligne
        cmp.l #65535,d0
        bcc csynt
        bset #29,d0             ;reloger ---> # de ligne
        bra outlong
; GOTO expression
Gt1:    moveq #L_goto,d0
        bra crefonc

; GOSUB
Cgosub:  bsr Test1
        bsr pair
        addq.l #4,a6
        bsr Constant
        beq.s Gs1
; GOSUB #LIGNE
        lea cdgs,a0             ;MOVE.L SP,LOWPILE(A5)
        bsr code0
        move.w #cjsr,d0
        bsr outword
        bsr reljsr
        bsr pair
        move.l d1,d0            ;Loke le # de ligne
        cmp.l #65535,d0
        bcc csynt
        bset #29,d0             ;reloger ---> # de ligne
        bra outlong
; GOSUB expression
Gs1:    lea cdgs,a0             ;MOVE.L SP,LOWPILE(A5)
        bsr code0
        moveq #L_gosub,d0
        bra crefonc
cdgs:   move.l sp,lowpile(a5)
        dc.w 0

; RETURN
Creturn:  bsr test0
        moveq #L_return,d0
        bra crefonc
; POP
Cpop:   bsr test0
        moveq #L_pop,d0
        bra crefonc

; ON xx GOTO / GOSUB
Con:    bsr Test1
        bsr getbyte
        cmp.b #T_extinst,d0
        bne.s Ona1
        bsr getbyte
        cmp.b #T_exti_menu,d0
        beq onmenu
Ona:    subq.l #1,a6
Ona1:   subq.l #1,a6
        bsr expentier           ;Prend la variable
        move.l a5,-(sp)         ;Place pour le MOVEQ
        addq.l #2,a5
        bsr getbyte             ;GOTO ou GOSUB
        bsr pair
        addq.l #4,a6
        cmp.b #T_goto,d0           ;GOTO?
        bne.s On0
        moveq #L_ongoto,d0
        bra.s On1
On0:    cmp.b #$99,d0
        bne csynt
*        lea cdgs,a0             ;MOVE.L SP,LOWPILE(A5)
*        bsr code0
        moveq #L_ongosub,d0
On1:    bsr crefonc
        move.w #cbra,d0
        bsr outword
        move.l a5,-(sp)         ;Adresse du BRA
        bsr outword
; Compte et poke les numeros de ligne
        clr.w -(sp)
On2:    move.w #cjmp,d0
        bsr outword
        bsr reljsr
        bsr Constant
        beq csynt
        cmp.l #65535,d1
        bcc csynt
        move.l d1,d0
        bset #29,d0
        bsr outlong
        addq.w #1,(sp)
        bsr getbyte
        cmp.b #",",d0
        beq.s On2
        subq.l #1,a6
        move.w (sp)+,d1
        move.w d1,d0
        mulu #6,d0                      ;Doke le BRA
        addq.w #2,d0
        move.l a5,d7
        move.l (sp)+,a5
        bsr outword
        move.w #cmvqd0,d0                ;Doke le MOVEQ
        move.b d1,d0
        move.l (sp)+,a5
        bsr outword
        move.l d7,a5
        rts


;------------------------------> IF THEN ELSE
Cif:    bsr test0
        bsr expentier           ;ramene VRAI ou FAUX
; Cherche le THEN
        bsr getbyte
        cmp.b #$9a,d0
        bne csynt
        bsr pair                ;Saute le flag du THEN
        addq.l #4,a6
        lea cthen(pc),a0        ;Poke TST.L (A6)+ / BEQ XXXXX
        bsr code1
; Cherche le ELSE
        move.l a6,a0
        move.w #1,ccptnext
If1:    move.b #$9a,d0
        move.b #$9b,d1
        bsr ftoken
        beq.s If3
        bmi.s If2
; Found a THEN
        addq.w #1,ccptnext
        bra.s If1
; Found an ELSE
If2:    subq.w #1,ccptnext
        bne.s If1
; Found the right ELSE
        bra.s If4
; Pas de ELSE
If3:    move.l #$1,a1
; Store in the addressing table
If4:    move.l Pif,a0
        move.l a1,(a0)+
        move.l a5,(a0)+
        move.l a0,Pif
; Line number after THEN?
        bsr getbyte
        subq.l #1,a6
        cmp.b #$fe,d0
        beq.s If5
        rts
If5:    bsr Constant
        beq csynt
        bsr Test1
        bra Gto
cthen:  tst.l (a6)+
        beq.w Celse /* !!! must be word branch */
        dc.w $1111

;-----> ELSE
Celse:
; Do a GOTO next line
        move.w #cbra,d0                 ;Poke le BRA
        bsr outword
        clr.w d0
        bsr outword
        move.l Pif,a0                   ;Force le relogeage
        move.l #$1,(a0)+
        move.l a5,(a0)+
        move.l a0,Pif
; reloge le IF
        move.l Tif,a0                   ;Origine table des IF
        subq.l #1,a6
Ce1:    cmp.l Pif,a0                    ;ELSE non reference?
        beq csynt
        cmp.l (a0),a6                   ;trouve le bon IF
        beq.s Ce2
        lea 8(a0),a0
        bra.s Ce1
Ce2:    clr.l (a0)                      ;ELSE deja reloge!
        move.l a5,d0
        move.l a5,-(sp)
        move.l 4(a0),a5
        sub.l a5,d0                     ;Distance THEN / ELSE
        addq.w #2,d0
        subq.l #2,a5
        bsr outword
        move.l (sp)+,a5
; Un numero de ligne apres le ELSE?
        addq.l #1,a6
        bsr pair                        ;Saute le flag du ELSE
        addq.l #4,a6
        bsr getbyte
        subq.l #1,a6
        cmp.b #$fe,d0
        beq If5
        rts

;-----> reloge les BRA a la fin d'une ligne
RelBra: move.l Tif,a2
Rb1:    cmp.l Pif,a2
        beq.s Rb3
        cmp.l #1,(a2)
        bne.s Rb2
; reloge!
        clr.l (a2)
        move.l a5,d0
        move.l a5,-(sp)
        move.l 4(a2),a5
        sub.l a5,d0                     ;Distance au THEN
        addq.w #2,d0
        subq.l #2,a5
        bsr outword
        move.l (sp)+,a5
Rb2:    lea 8(a2),a2
        bra.s Rb1
; Fini: RAZ de la table
Rb3:    move.l Tif,Pif
        rts

;------------------------------> FOR TO STEP
Cfor:   bsr test0
        bsr pair
        addq.l #4,a6            ;Saute le flag

; Prend et egalise la variable
        bsr CLLet
        tst.b d2
        bmi ctype
        move.w d2,-(sp)         ;Sauve le type
        move.l a6,-(sp)         ;Sauve le CHRGET
        move.l a0,-(sp)
        lea forcd1,a0           ;MOVE.L A0,-(A6)
        bsr code0

;-----> Trouve le bon NEXT
        move.l a6,a0
        move #1,ccptnext
        move.l adline,coldf
for2:   move.b #$9d,d0
        move.b #$82,d1
        bsr supfind
        beq CFonx               ;For without next error
        bmi.s for4
; a trouve un FOR
        bsr GetByt0
        subq.l #1,a0
        cmp.b #$fa,d2           ;si SYNTAX ERR: n'en tient pas compte
        bne.s for2
        lea 1(a0),a6
        bsr vari
        cmp.l (sp),a0
        move.l a6,a0            ;La meme variable?
        bne.s for2
        addq.w #1,ccptnext
        bra.s for2
; a trouve un NEXT
for4:   move.l a1,a2            ;a1 pointe le NEXT
        bsr GetByt0             ;Si NEXT seul
        subq.l #1,a0
        cmp.b #$fa,d2           ;ou erreur, decremente le compteur
        bne.s for5
        lea 1(a0),a6
        move.l a2,-(sp)
        bsr vari                ;va chercher la variable
        move.l (sp)+,a2
        cmp.l (sp),a0           ;compare la variable
        move.l a6,a0
        bne for2
for5:   subq.w #1,ccptnext
        bne for2
        move.l a2,(sp)          ;pointe le NEXT
        move.l 4(sp),a6         ;a6 repointe le TO

;-----> LE NEXT EST TROUVE

; Compile le TO
        bsr getbyte
        cmp.b #$80,d0           ;cherche le TO
        bne csynt
        bsr evalue
        move.w 8(sp),d1         ;Type de la boucle
        bsr eqtype              ;egalise les types
        bne ctype
; Compile le STEP
        bsr getbyte
        subq.l #1,a6
        cmp.b #$81,d0           ;cherche un STEP
        bne.s for11
        addq.l #1,a6
        bsr evalue              ;va chercher le STEP
        bra.s for12
for11:  lea forcd2,a0           ;MOVE.L #$1,-(A6)
        bsr code1
        clr.b d2                ;entier!
for12:  move.w 8(sp),d1
        bsr eqtype              ;Egalise les type TO / STEP
        bne ctype

;-----> Poke les tables du compilateur
        move.l cposbcle,a0
        lea -16(a0),a0
        move.l a0,cposbcle
        addq.w #1,cnboucle
        move.l a6,(a0)          ;debut de la boucle
        move.l (sp)+,4(a0)      ;Fin de la boucle
        move.l a5,8(a0)         ;Adresse du chargement de adresses
        addq.l #4,sp
        move.w (sp)+,d7
        move.w d7,12(a0)        ;Type de la boucle: INT ou FLOAT

;-----> Poke dans le source
        move.w #cleaa2,d0       ;Adresse ou poker
        bsr outword
        bsr reljsr
        addq.l #4,a5
        moveq #L_for,d0         ;Fonction qui poke
        tst.b d7
        beq.s For13
        addq.w #1,d0            ; -> L_for_f
For13:  bra crefonc

CFonx:  moveq #E_missing_next,d0
        bra cerror

;-----> Code pour FOR
forcd1: move.l a0,-(a6)
        dc.w 0
forcd2: move.l #1,-(a6)
        dc.w $1111

;-----------------------------------> NEXT
Cnext:  bsr Test1
        move.w ctstnbcle,d0     ;a loop from the last gosub?
        cmp.w cnboucle,d0
        beq cnxfo
; Skip the variable (if it exists)
        pea -1(a6)              ;address of NEXT
        bsr getbyte
        subq.l #1,a6
        cmp.b #T_var,d0
        bne.s CNx0
        addq.l #1,a6
        bsr vari
CNx0:   move.l (sp)+,d0
; Check that it is the right next
        move.l cposbcle,a0
        cmp.l 4(a0),d0          ;Good loop?
        bne cnxfo
        add.l #16,cposbcle      ;unstack
        subq.w #1,cnboucle
        move.w 12(a0),d2        ;loop type
; Loke the address of the NEXT in the LEA of the FOR -completely brilliant shit-
        move.l a5,-(sp)
        move.l a5,d0            ;Indicates the RTS address after the call
        sub.l objet,d0          ;en relatif
        bset #30,d0             ;Signale une adresse INTERNE au prg
        move.l 8(a0),a5         ;Adresse du LEA
        lea 2(a5),a5            ;-2
        bsr outlong
        move.l (sp)+,a5
; Poke le code de chargement des parametres
        tst.b d2
        bne.s CNx1
        lea cdnx1,a0
        bsr code0
        moveq #L_next,d0
        bra crefonc
CNx1:   lea cdnx2,a0
        bsr code0
        moveq #L_next_f,d0
        bra crefonc
; Integer parameter loading code
cdnx1:  lea $ffffff,a2          ;loopback address
        lea $ffffff,a3          ;addresse of the variable
        move.l #$00ffffff,d1    ;limite
        move.l #$00ffffff,d2    ;step
        dc.w 0
; Code chargement parametres FLOAT
cdnx2:  lea $ffffff,a2
        lea $ffffff,a3
        move.l #$00ffffff,d5
        move.l #$00ffffff,d6
        move.l #$00ffffff,d3
        move.l #$00ffffff,d4
        dc.w 0
; For without next
cnxfo:  moveq #E_missing_for,d0
        bra cerror

;-----> WHILE
Cwhile:  bsr pair
        addq.l #4,a6
        move.l a6,a0
        move.l adline,coldf
        move.w #1,ccptnext
wh2:    move.b #$9e,d0
        move.b #$83,d1
        bsr supfind
        beq.s cwhw
        bmi.s wh3
; a trouve un while
        addq.w #1,ccptnext
        bra.s wh2
; a trouve un wend
wh3:    subq.w #1,ccptnext
        bne.s wh2
; a trouve le bon wend
        move.l a5,-(sp)         ;Adresse du debut de la boucle (objet)
        move.l a1,-(sp)         ;Adresse du wend (source)
        bsr expentier
; poke la boucle
        move.l cposbcle,a0
        lea -16(a0),a0
        move.l a0,cposbcle
        addq.w #1,cnboucle
        move.l a6,(a0)          ;debut de la boucle (source)
        move.l (sp)+,4(a0)      ;Fin de la boucle (source)
        move.l a5,8(a0)         ;Adresse de l'adresse NEXT (objet)
        move.l (sp)+,12(a0)     ;Adresse de la boucle (objet)
; Termine...
        move.w #cleaa2,d0        ;Adresse du WEND
        bsr outword
        bsr reljsr
        addq.l #4,a5
        moveq #L_while,d0
        bra crefonc

cwhw:   moveq #E_missing_wend,d0
        bra cerror
cwwh:   moveq #E_missing_while,d0
        bra cerror

;-----> WEND
Cwend:  move.w ctstnbcle,d0
        cmp.w cnboucle,d0
        beq.s cwwh
        move.l cposbcle,a2
        subq.l #1,a6
        cmp.l 4(a2),a6
        bne.s cwwh
        addq.l #1,a6
; Une boucle de moins
        add.l #16,cposbcle
        subq.w #1,cnboucle
; Loke l'adresse du WEND dans le LEA du WHILE
        bsr Test1
        move.l a5,-(sp)
        move.l a5,d0            ;Pointe l'adresse du RTS apres l'appel
        addq.l #6,d0            ;de WEND
        sub.l objet,d0          ;en relatif
        bset #30,d0             ;Signale une adresse INTERNE au prg
        move.l 8(a2),a5         ;Adresse du LEA
        lea 2(a5),a5            ;-2
        bsr outlong
        move.l (sp)+,a5
; JMP boucle
        move.w #cjmp,d0
        bsr outword
        bsr reljsr
        move.l 12(a2),d0
        sub.l objet,d0
        bset #30,d0
        bra outlong

;-----> REPEAT
Crepeat:  bsr pair
        addq.l #4,a6
        move.l adline,coldf
        move.l a6,a0
        move.w #1,ccptnext
rp2:    move.b #$9f,d0
        move.b #$84,d1
        bsr supfind
        beq.w crpu
        bmi.s rp3
; a trouve un repeat
        addq.w #1,ccptnext
        bra.s rp2
; a trouve un until
rp3:    subq.w #1,ccptnext
        bne.s rp2
; a trouve le bon until
        move.l cposbcle,a0
        lea -16(a0),a0
        move.l a0,cposbcle
        addq.w #1,cnboucle
        move.l a6,(a0)          ;debut de la boucle (source)
        move.l a1,4(a0)         ;Fin de la boucle (source)
        move.l a5,8(a0)         ;Adresse de la boucle (objet)
        rts

;-----> UNTIL
Cuntil:  move.w ctstnbcle,d0
        cmp.w cnboucle,d0
        beq.s curp
        move.l cposbcle,a2
        subq.l #1,a6
        cmp.l 4(a2),a6
        bne.s curp
        addq.l #1,a6
; Une boucle de moins
        add.l #16,cposbcle
        subq.w #1,cnboucle
; evalue l'expression
        bsr Test1
        move.l a2,-(sp)
        bsr expentier
        move.l (sp)+,a2
; Charge l'adresse de la boucle
        move.w #cleaa2,d0
        bsr outword
        bsr reljsr
        move.l 8(a2),d0
        sub.l objet,d0
        bset #30,d0
        bsr outlong
; Appelle la librairie
        moveq #L_until,d0
        bra crefonc
crpu:   moveq #E_missing_until,d0
        bra cerror
curp:   moveq #E_missing_repeat,d0
        bra cerror

;-----> ON ERROR GOTO
Conerrror:  bsr test0
        bsr getbyte
        cmp.b #$98,d0
        bne csynt
        bsr pair
        addq.l #4,a6
        bsr expentier
        move.w #L_onerr,d0
        bra crefonc

;-----> ERROR xx
CErr:   bsr test0
        bsr expentier
        move.w #L_err,d0
        bra crefonc

;-----> RESUME [xxxx]
Cresume:  bsr Test1
        bsr finie
        beq.s Resu1
; RESUME #ligne
        bsr expentier
        move.w #L_resline,d0
        bra crefonc
; RESUME seul#
Resu1:  move.w #L_reseul,d0
        bra crefonc

;-----> RESUME NEXT
Cresn:  bsr Test1
        move.w #L_resnex,d0
        bra crefonc

;-----> ERRL
Cerrl:  move.w #L_errl,d0
        bra creent

;-----> ERRN
Cerrn:  move.w #L_errn,d0
        bra creent

;-----> BREAK ON/OFF
Cbreak:  bsr test0
        bsr onoff
        bmi csynt
        bne.s brk
        move.w #L_breakoff,d0
        bra crefonc
brk:    move.w #L_breakon,d0
        bra crefonc

; SUPER FIND: CHERCHE UN TOKEN DANS LA SUITE DU PROGRAMME a partir de a0!
supfind:bsr ftoken
        bne.s sf5
        move.l coldf,a0
        bsr GetWor0
        subq.l #2,a0
        add.w d2,a0
        bsr GetWor0
        subq.l #2,a0
        tst.w d2
        beq.s sf5
        move.l a0,coldf
        addq.l #4,a0
        bra supfind
sf5:    rts

; FIND TOKEN: CHERCHE UN TOKEN DANS LA LIGNE ACTUELLE
ftoken: move.l a0,a1        ;ramene l'adresse juste en a1
        bsr GetByt0         ;ramene l'adresse juste apres en a0!
        beq.s ft8           ;fin de la ligne
        bpl.s ft5
        cmp.b #T_extinst,d2       ;instruction etendue
        beq.s ft1a
        cmp.b #T_extfunc,d2       ;fonction etendue
        beq.s ft1a
        cmp.b #T_extensioninst,d2       ;.EXT instruction
        beq.s ft1
        cmp.b #T_extensionfunc,d2       ;.EXT fonction
        bne.s ft2
ft1:    addq.l #1,a0
ft1a:   addq.l #1,a0
        bra.s ft5
ft2:    cmp.b #T_var,d2       ;variable ou constante?
        bcc.s ft3
        cmp.b #T_goto,d2
        bcs.s ft5
        cmp.b #T_repeat+1,d2
        bcc.s ft5
ft3:    move a0,d3          ;rend pair
        btst #0,d3
        beq.s ft4
        addq.l #1,a0
ft4:    cmp.b #T_constflt,d2
        bne.s ft4a
        addq.l #4,a0        ;constantes float sur huit octets!
ft4a:   cmp.b #T_conststr,d2
        bne.s ft0
        move.w d2,-(sp)
        addq.l #2,a0
        bsr GetWor0
        subq.l #4,a0
        add.w d2,a0         ;chaines alphanumerique! saute la chaine
        move.w (sp)+,d2
ft0:    addq.l #4,a0        ;saute le flag
ft5:    cmp.b d2,d1
        beq.s ft7
        cmp.b d2,d0
        bne.s ftoken
ft6:    move #1,d2          ;trouve le premier
        rts
ft7:    move #-1,d2         ;trouve le second
        rts
ft8:    subq.l #1,a0        ;reste sur le zero!!!
        rts                 ;pas trouve!

;-----> Prend un octet du programme (A0)---> D2
GetByt0:tst.w nomin
        bne.s gdb0
        move.b (a0)+,d2
        rts
gdb0:   movem.l a0/a6,-(sp)
        move.l a0,a6
        bsr SoDisk
        move.b (a0),d2
        movem.l (sp)+,a0/a6
        addq.l #1,a0
        tst.b d2
        rts
;-----> Prend un MOT du programme (A0)---> D2
GetWor0:tst.w nomin
        bne.s gdw0
        move.w (a0)+,d2
        rts
gdw0:   movem.l a0/a6,-(sp)
        move.l a0,a6
        bsr SoDisk
        move.w (a0),d2
        movem.l (sp)+,a0/a6
        addq.l #2,a0
        tst.w d2
        rts



;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | ACCES MEMOIRE                   |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> TIMER=
Csettimer:  bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr test0
        bsr expentier
        moveq #L_settimer,d0
        bra crefonc
;-----> =TIMER
Cgettimer:  moveq #L_gettimer,d0
        bra creent

;-----> POKE DOKE LOKE: rapide, pas de JSR
pok:    lea Po,a0               ;Poke
        bra.s Lok1
Po:     move.b d0,(a0)
        dc.w 0
dok:    lea Do,a0               ;Doke
        bra.s Lok1
Do:     move.w d0,(a0)
        dc.w 0
lok:    lea Lo,a0               ;Loke
Lok1:   bsr test0
        move.l a0,-(sp)
        lea parent,a2           ;2 params entiers
        bsr parinst
        cmp.w #2,d0
        bne csynt
        lea Lok2,a0
        bsr code0
        move.l (sp)+,a0
        bsr code0
        rts
Lo:     move.l d0,(a0)
        dc.w 0
Lok2:   move.l (a6)+,d0
        move.l (a6)+,a0
        dc.w 0

;-----> PEEK DEEK LEEK rapide: pas de JSR
pik:    bsr FArg
        lea Cpik,a0
        bra.s FPik
dik:    bsr FArg
        lea Cdik,a0
        bra.s FPik
lik:    bsr FArg
        lea Clik,a0
FPik:   bsr code0
        clr.b d2
        rts
Cpik:   move.l (a6)+,a0
        moveq #0,d0
        move.b (a0),d0
        move.l d0,-(a6)
        dc.w 0
Cdik:   move.l (a6)+,a0
        moveq #0,d0
        move.w (a0),d0
        move.l d0,-(a6)
        dc.w 0
Clik:   move.l (a6),a0
        move.l (a0),(a6)
        dc.w 0

;-----> FREE
Cfree:  move.w #L_free,d0
        bra creent

;-----> VARPTR
Cvarptr:  bsr getbyte
        cmp.b #"(",d0
        bne csynt
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bsr varad
        bsr getbyte
        cmp.b #")",d0
        bne csynt
        tst.b d2
        bmi.s cv1
        lea cdv1,a0
        bra.s cv2
cv1:    lea cdv2,a0
cv2:    bsr code0
        clr.b d2
        rts
cdv1:   move.l a0,-(a6)
        dc.w 0
cdv2:   move.l (a0),d0
        addq.l #2,d0
        move.l d0,-(a6)
        dc.w 0

;-----> BSET/CLR/CHG
Cbset:  move.w #L_bset,-(sp)
        bra.s cbit
Cbclr:  move.w #L_bclr,-(sp)
        bra.s cbit
Cbchg:  move.w #L_bchg,-(sp)
cbit:   bsr test0
        bsr expentier
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr PreVari
        bsr varad
        andi.b #$c0,d2
        bne ctype
        move.w (sp)+,d0
        bra crefonc

;-----> BTST
CBtst:  lea parent,a2
        bsr parfonc
        cmp.w #2,d0
        bne csynt
        move.w #L_btst,d0
        bra creent

;-----> ROL .b / .w / .l
CRol:   move.w #L_rolb,-(sp)
        bra.s rr1
;-----> ROR
CRor:   move.w #L_rorb,-(sp)
rr1:    moveq #L_rolw-L_rolb,d1 ; -> L_rolw/L_rorw
        bsr getbyte
        subq.l #1,a6
        cmp.b #$ad,d0           ;Octet?
        beq.s rr2
        cmp.b #$ae,d0           ;Mot?
        beq.s rr3
        cmp.b #$af,d0           ;Mot long?
        bne.s rr4
        moveq #L_roll-L_rolb,d1 ;Mot long -> L_roll/L_rorl
        bra.s rr3
rr2:    moveq #0,d1             ;Octet
rr3:    addq.l #1,a6
rr4:    move.w d1,-(sp)
        bsr expentier
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr PreVari
        bsr varad
        andi.b #$c0,d2
        bne ctype
        move.w (sp)+,d0
        add.w (sp)+,d0
        bra crefonc

;-----> D/A REG(0-7)=
Cdreg:  move.w #L_dreg,-(sp)
        bra.s Dr1
Careg:  move.w #L_areg,-(sp)
Dr1:    bsr test0
        bsr fent
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w (sp)+,d0
        bra crefonc

;-----> = A/D REG(0-7)
CFDrg:  move.w #L_dreg2,-(sp)
        bra.s Dr2
CFArg:  move.w #L_areg2,-(sp)
Dr2:    bsr fent
        move.w (sp)+,d0
        bra creent

;-----> CALL
Ccall:  move.w #L_call,-(sp)
        bra.s ctr0
;-----> TRAP
Ctrap:  move.w #L_trap,-(sp)
ctr0:   bsr test0
        bsr expentier
        lea cdtr1,a0
        bsr code0
ctr1:   bsr getbyte
        subq.l #1,a6
        beq.s ctr6
        cmp.b #":",d0
        beq.s ctr6
        cmp.b #$9b,d0
        beq.s ctr6
        cmp.b #",",d0
        bne csynt
        addq.l #1,a6
        clr.w -(sp)
        bsr getbyte
        subq.l #1,a6
        cmp.b #$ae,d0
        beq.s ctr2
        cmp.b #$af,d0
        bne.s ctr3
        move.w #1,(sp)
ctr2:   addq.l #1,a6
ctr3:   bsr evalue
        tst.w parenth
        bne csynt
        tst.b d2
        beq.s ctr5
        bmi.s ctr4
        moveq #L_inttofl,d0
        bsr crefonc
        bra.s ctr5
ctr4:   move.w #3,(sp)          ;LONG et CHAINE!
ctr5:   lea cdtr2,a0            ;MOVE.W TYPE,-(a6)
        move.w (sp)+,2(a0)
        bsr code1
        bra.s ctr1
ctr6:   move.w (sp)+,d0
        bra crefonc
cdtr1:  move.w #-1,-(a6)
        dc.w 0
cdtr2:  move.w #$2222,-(a6)
        dc.w $1111

;-----> FILL
ParFil: dc.b en,to,en,",",en,1
        dc.b 1,0
   .even
CFill:  move.w #L_fill,-(sp)
        lea ParFil,a2
        bra.s CCo
;-----> COPY
ParCop: dc.b en,",",en,to,en,1
        dc.b 1,0
   .even
CCopy:  move.w #L_copy,-(sp)
        lea ParCop,a2
CCo:    bsr test0
        bsr parinst
        move.w (sp)+,d0
        bra crefonc

;-----> HUNT
ParUnt: dc.b en,to,en,",",ch,1
        dc.b 1,0
   .even
CHunt:  lea ParUnt,a2
        bsr parfonc
        move.w #L_hunt,d0
        bra creent

;-----> RESERVE
CRese:  bsr test0
        bsr getbyte
        cmp.b #T_extinst,d0
        bne csynt
        bsr getbyte
        cmp.b #T_exti_asdatascreen,d0
        beq.s res2
        cmp.b #T_exti_aswork,d0
        beq.s res3
        cmp.b #T_exti_asscreen,d0
        beq.s res1
        cmp.b #T_exti_asset,d0
        beq.s res2a
        move #$81,d1                    ;data!
        bra.s res4
res1:   move #$2,d1                     ;screen!
        bra.s res4
res2:   move #$82,d1                    ;datascreen!
        bra.s res4
res2a:  move #$84,d1
        bra.s res4
res3:   move #$1,d1
res4:   move.w d1,-(sp)
        bsr expentier                   ;# de la banque
        move.w (sp),d0
        andi.w #$0f,d0
        cmp.b #2,d0
        beq.s res5
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expentier                   ;Taille
res5:   move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_rese,d0
        bra crefonc

;-----> ERASE
Cerase:  bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #2,d0
        beq.s cer1
        cmp.w #1,d0
        bne csynt
        move.w #L_erase,d0
        bra crefonc
cer1:   moveq #E_directcommand,d0
        bra cerror

;-----> BCOPY
Parbc:  dc.b en,to,en,1
        dc.b 1,0
        .even
Cbcop:  bsr test0
        lea Parbc,a2
        bsr parinst
        move.w #L_bcop,d0
        bra crefonc

;-----> BGRAB
Cbgra:  bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #2,d0
        beq.s CBg
        cmp.w #1,d0
        bne csynt
        move.w #L_bgrab,d0
        bra crefonc
CBg:    move.w #L_bgrab2,d0
        bra crefonc

;-----> =LENGTH
CLeng:  move.w #L_length,-(sp)
        bra.s CSr

;-----> =START
Cstart:  move.w #L_start,-(sp)
CSr:    lea parent,a2
        bsr parfonc
        cmp.w #2,d0
        beq.s CSr1
        cmp.w #1,d0
        bne csynt
        move.w (sp)+,d0
        bra creent
CSr1:   move.w (sp)+,d0
        addq.w #1,d0 /* -> L_start2/L_length2 */
        bra creent

;-----> CURRENT
CCurr:  move.w #L_curr,d0
        bra creent

;-----> ACCNB
CAccn:  move.w #L_accnb,d0
        bra creent

;-----> LANGAGE
CLang:  move.w #L_lang,d0
        bra creent

;-----> OFF
Coff:   bsr test0
        move.w #L_off,d0
        bra crefonc

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | TEXTE / ALPHANUMERIQUE          |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
; Formats des MIDS
PMid:   dc.b ch,",",en,1
        dc.b ch,",",en,",",en,1
        dc.b 1
   .even
;-----> =LEFT$(a$,xx)
Cleft:  lea PMid,a2
        bsr parfonc
        cmp.w #1,d0
        bne csynt
        moveq #L_left,d0
crech:  bsr crefonc
        move.b #$80,d2
        rts

;-----> =RIGHT$(a$,xx)
Cright:  lea PMid,a2
        bsr parfonc
        cmp.w #1,d0
        bne csynt
        moveq #L_right,d0
        bra.s crech

;-----> =MID$(a$,xx) / =MID$(a$,xx,yy)
Cmidget:   lea PMid,a2
        bsr parfonc
        cmp.w #1,d0
        bne.s CMd
        moveq #L_mid1,d0
        bra.s crech
CMd:    moveq #L_mid2,d0
        bra.s crech

;-----> LEFT$(a$,xx)=
CIleft:  bsr Cim
        cmp.w #1,d7
        bne csynt
        moveq #L_ileft,d0
        bra crefonc

;-----> RIGHT$(a$,xx)=
CIright:  bsr Cim
        cmp.w #1,d7
        bne csynt
        moveq #L_irigh,d0
        bra crefonc

;-----> MID$(a$,xx)= / MID$(a$,xx,yy)=
Cmidset:  bsr Cim
        cmp.w #2,d7
        beq cimd
        moveq #L_imid1,d0
        bra crefonc
cimd:   moveq #L_imid2,d0
        bra crefonc

; Routine commune LEFT/RIGHT/MID en INSTRUCTIONS
Cim:    bsr test0
        bsr getbyte                 ;parenthese
        cmp.b #"(",d0
        bne csynt
        bsr getbyte                 ;Variable
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        tst.b d2
        bpl ctype
        move.w d2,-(sp)         ;Sauve pour apres
        movem.l a0/a1,-(sp)
; Prend les parametres
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr evalue
        clr.b d1                ;Veut un entier
        bsr eqtype
        bne ctype
        moveq #1,d7
        cmp.w #-1,parenth
        beq.s Cim2
        tst.w parenth
        bne csynt

        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr evalue
        clr.b d1
        bsr eqtype
        bne ctype
        moveq #2,d7
        cmp.w #-1,parenth
        bne csynt
Cim2:   bsr getbyte             ;Veut un EGAL
        cmp.b #$f1,d0
        bne csynt
        move.w d7,-(sp)
        bsr expalpha            ;Va evaluer la CHAINE
        move.w (sp)+,d7         ;Nombre de params
        movem.l (sp)+,a0/a1     ;Recupere la variable
        move.w (sp)+,d2
        bsr varad
        rts

;-----> =INSTR(a$,xx)
Cinstr:   dc.b ch,",",ch,1
        dc.b ch,",",ch,",",en,1
        dc.b 1,0
   .even
CInst:  lea Cinstr,a2
        bsr parfonc
        cmp.w #1,d0
        bne.s CIn
        moveq #L_inst,d0
        bra creent
CIn:    moveq #L_inst3,d0
        bra creent

;-----> =LEN(a$)
CLen:   bsr FChai
        moveq #L_len,d0
        bra creent

;-----> =FLIP$(a$)
Cflip:  bsr FChai
        moveq #L_flip,d0
        bra crech

;-----> =SPACE$(xx)
Cspc:   bsr fent
        moveq #L_spc,d0
        bra crech

;-----> =STRING$(a$,xx)
Cstring:  lea PMid,a2
        bsr parfonc
        cmp.w #1,d0
        bne csynt
        moveq #L_string,d0
        bra crech

;-----> =CHR$(xx)
Cchr:   bsr fent
        moveq #L_chr,d0
        bra crech

;-----> =ASC(a$)
Casc:   bsr FChai
        moveq #L_asc,d0
        bra creent

;-----> =BIN$(xx) / BIN$(xx,yy)
Cbin:   lea parent,a2
        bsr parfonc
        cmp.w #2,d0
        beq.s cb1
        cmp.w #1,d0
        bne csynt
        moveq #L_bin,d0
        bra crech
cb1:    moveq #L_bin2,d0
        bra crech

;-----> =HEX$(xx) / HEX$(xx,yy)
CHex:   lea parent,a2
        bsr parfonc
        cmp.w #2,d0
        beq.s Ch1
        cmp.w #1,d0
        bne csynt
        moveq #L_hex,d0
        bra crech
Ch1:    moveq #L_hex2,d0
        bra crech

;-----> =STR$(xx)
CStr:   bsr FArg
        bne.s Cst
        moveq #L_str,d0
        bra crech
Cst:    moveq #L_str2,d0
        bra crech

;-----> =VAL(a$)
CVal:   bsr FChai
        moveq #L_val,d0
        tst.w ValFlo
        beq creent
        bra creflo

;-----> UPPER$ (inverse)
CLow:   bsr FChai
        move.w #L_upp,d0
        bra crech

;-----> LOWER$ (inverse)
CUpp:   bsr FChai
        move.w #L_low,d0
        bra crech

;-----> TIME$ en fonction
CTime:  move.w #L_time,d0
        bra crech

;-----> DATE$ en fonction
CDate:  move.w #L_date,d0
        bra crech

;-----> SETTIME
Csettime:  bsr test0
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expalpha
        move.w #L_stime,d0
        bra crefonc

;-----> SETDATE
Csetdate:  bsr test0
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expalpha
        move.w #L_sdate,d0
        bra crefonc

;-----> CLICK ON/OFF
CClic:  bsr test0
        bsr onoff
        bmi csynt
        bne.s CCl
        move.w #L_clickoff,d0
        bra crefonc
CCl:    move.w #L_clickon,d0
        bra crefonc

;-----> KEY
CKey:   bsr test0
        bsr onoff
        bmi.s Cki2
        bne.s Cki1
; KEY OFF
        move.w #L_keyoff,d0
        bra crefonc
; KEY ON
Cki1:   move.w #L_keyon,d0
        bra crefonc
; KEY(XX)="kkkkkkkkkkkkkkkk"
Cki2:   bsr fent
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expalpha
        move.w #L_keyx,d0
        bra crefonc

; =FKEY
CFKey:  move.w #L_fkey,d0
        bra creent

; =INKEY$
CInky:  move.w #L_inkey,d0
        bra crech

; =SCANCODE
Cscancode:  move.w #L_scancode,d0
        bra creent

; CLEARKEY
Cclky:  bsr test0
        move.w #L_clearkey,d0
        bra crefonc

; WAIT KEY
Cwaitkey:  move.w #L_waitkey,d0
        bra crefonc

; PUTKEY
Cputkey:  bsr test0
        bsr expalpha
        move.w #L_putkey,d0
        bra crefonc


;----------------------------------> DATA / READ / RESTORE
;-----> DATA
CData:
; Premiere ligne de datas?
        tst.l FstData
        bne.s Cda1
        move.l a5,d0
        sub.l objet,d0
        move.l d0,FstData
        bra.s Cda2
; reloge la ligne precedente
Cda1:   move.l a5,-(sp)
        move.l a5,d0                    ;Saute le BRA
        sub.l objet,d0
        bset #30,d0
        move.l OlData,a5
        bsr outlong
        move.l (sp)+,a5
; Fait un BRA a la ligne suivante
Cda2:   subq.l #4,a5                    ;Pas de LEA
        move.w #cbra,d0
        bsr outword
        clr.w d0
        bsr outword
        move.l Pif,a0
        move.l #$1,(a0)+
        move.l a5,(a0)+
        move.l a0,Pif
; evalue tous les datas
Cda3:   bsr getbyte
        subq.l #1,a6
        cmp.b #",",d0
        bne.s Cda4
; Une virgule!
        move.b #1,d2                    ;Vide!
        bra.s Cda5
; Une expression
Cda4:   bsr evalue                      ;evalue l'expression
        andi.b #$c0,d2
Cda5:   move.w #cmvqd0,d0
        move.b d2,d0                    ;Type de l'expression
        bsr outword
        move.l #$45fa0004,d0            ;LEA expression suivante,a2
        bsr outlong
        move.w #crts,d0                 ;Met un RTS
        bsr outword
        bsr getbyte
        cmp.b #",",d0
        beq.s Cda3
        subq.l #1,a6
; Pointe la ligne suivante de datas
        move.w #cleaa2,d0                ;Retour: D0= 2
        bsr outword                     ;A2= adresse prochaine ligne
        bsr reljsr
        move.l a5,OlData
        moveq #0,d0
        bset #30,d0
        bsr outlong
        move.w #cmvqd0,d0
        move.b #2,d0
        bsr outword
        move.w #crts,d0
        bsr outword
; Fini!
        rts

;-----> RESTORE
Crestore:  bsr test0
        bsr pair
        addq.l #4,a6
        bsr finie
        bne.s CRe1
; Restore seul
        move.w #L_restore,d0
        bra crefonc
; Restore EXPRESSION
CRe1:   bsr Constant
        beq.s CRe2
; Restore CONSTANTE
        move.w #cleaa2,d0
        bsr outword
        bsr reljsr
        move.l d1,d0            ;Loke le # de ligne
        cmp.l #65535,d0
        bcc csynt
        bset #29,d0             ;reloger ---> # de ligne
        bsr outlong
        move.w #L_restoreconst,d0
        bra crefonc
; Restore EXPRESSION
CRe2:   move.w #L_restoreexp,d0
        bra crefonc

;-----> READ
Cread:  bsr test0
CRi1:   bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        bsr varad
        andi.b #$c0,d2
        move.w #cmvqd0,d0
        move.b d2,d0
        bsr outword
        move.w #L_read,d0
        bsr crefonc
        bsr getbyte
        cmp.b #",",d0
        beq.s CRi1
        subq.l #1,a6
        rts

;----------------------------------> LINE INPUT
Clinp:  lea cdin1,a0
        bra.s CIn1
;----------------------------------> INPUT
CInpu:  lea cdin2,a0
CIn1:   bsr code0
        clr.w -(sp)
; Est-ce INPUT#
        bsr getbyte
        subq.l #1,a6
        cmp.b #"#",d0
        bne.s CIn5
;-->    Input en provenance de fichier
        addq.l #1,a6
        bsr expentier
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        clr.w -(sp)
        bsr getbyte
        subq.l #1,a6
        cmp.b #$fa,d0
        beq.s CIn2
        bsr expentier
        move.w #1,(sp)
        bsr getbyte
        cmp.b #",",d0
        bne csynt
CIn2:   move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_input5,d0
        bsr crefonc
        move.w #1,(sp)
        bsr getbyte
        subq.l #1,a6
        cmp.b #$fa,d0
        beq.s CIn7
        bra csynt
;-->    Continue...
CIn5:   cmp.b #$fa,d0                   ;Variable?
        beq.s CIn6
        cmp.b #$fc,d0                   ;Chaine alphanumerique?
        bne csynt
; Chain printing
        bsr expalpha
        move.w #L_input,d0
        bsr crefonc
        bsr getbyte
        cmp.b #";",d0
        bne csynt
        bsr getbyte
        subq.l #1,a6
        cmp.b #$fa,d0
        bne csynt
        bra.s CIn7
; Put the question mark
CIn6:   move.w #L_input2,d0
        bsr crefonc
; Stocke la liste des variable ---> -(A6) / moveq #NB,d0
CIn7:   addq.l #1,a6
        clr.w -(sp)                     ;Nbre de variables
CIn8:   bsr vari                        ;cherche la variable
        bsr varad                       ;LEA varad,a0
        andi.w #$c0,d2
        move.w d2,cdin3+2               ;FLAG de la variable
        lea cdin3,a0
        bsr code1                       ;move.w flg,-(a6)/move.l a0,-(a6)
        addq.w #1,(sp)
        bsr getbyte
        cmp.b #",",d0                   ;encore une?
        bne.s CIn9
        bsr getbyte
        cmp.b #$fa,d0
        beq.s CIn8
        bra csynt
CIn9:   subq.l #1,a6
        move.w #cmvqd0,d0               ;Doke le MOVEQ
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
; Appele la fonction
        move.w #L_input3,d0
        tst.w (sp)+
        beq crefonc
        move.w #L_input4,d0
        bra crefonc

cdin1:  clr.w inputype(a5)
        dc.w 0
cdin2:  move.w #",",inputype(a5)
        dc.w 0
cdin3:  move.w #$ffff,-(a6)
        move.l a0,-(a6)
        dc.w $1111

;-----> INPUT$
Cfinp:  bsr getbyte
        cmp.b #"(",d0
        bne csynt
        bsr getbyte
        subq.l #1,a6
        cmp.b #"#",d0
        beq.s cfi1
        subq.l #1,a6
        bsr fent
        move.w #L_input6,d0
        bra crech
cfi1:   addq.l #1,a6
        move.w parenth(pc),-(sp)
        bsr evalue
        tst.w parenth
        bne csynt
        andi.b #$c0,d2
        beq.s cfi2
        bmi ctype
        move.w #L_fltoint,d0
        bsr crefonc
cfi2:   bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr evalue
        cmp.w #-1,parenth
        bne csynt
        andi.b #$c0,d2
        beq.s cfi3
        bmi ctype
        move.w #L_fltoint,d0
        bsr crefonc
cfi3:   move.w (sp)+,parenth
        move.w #L_input7,d0
        bra crech

;-----> LPRINT
Clprt:  bsr Test1
        lea Lp1,a0
        bra.s Cp0

Lp0:    clr.l usingflg(a5)      ;USING=0 / PRT=0 / TYPE=0
        move.l a4,printpos(a5)
        dc.w 0
Lp1:    clr.l usingflg(a5)      ;USING=0 / PRT=1 / TYPE=0
        move.b #1,impflg(a5)
        move.l a4,printpos(a5)
        dc.w 0
Lp2:    clr.l printpos(a5)      ;Arret print
        dc.w 0
StUs:   move.b #1,usingflg(a5)  ;Demarrage du USING
        dc.w 0

;-----> PRINT
Cprint:  bsr Test1
        lea Lp0,a0
Cp0:    bsr code0
        clr.w -(sp)             ;CODE fichier/normal
        bsr getbyte
        subq.l #1,a6
        cmp.b #"#",d0
        bne.s cp2
; Impression dans un fichier
        addq.l #1,a6
        bsr expentier           ;Prend le numero du fichier
        move.w #36,d0
        bsr crefonc
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        move.w #1,(sp)
; Prend les expressions
cp2:    bsr getbyte
        tst.b d0
        beq.w cp9
        cmp.b #":",d0
        beq.w cp9
        cmp.b #$9b,d0
        beq.w cp9
        cmp.b #$a0,d0           ;Code etendu de USING?
        bne.s cp4
        bsr getbyte
        subq.l #1,a6
        cmp.b #$df,d0
        bne.s cp4
; USING: prend la chaine et marque le using
        move.l #$49fa0002,d0    ;LEA adexp,A4
        bsr outlong
        addq.l #1,a6
        bsr expalpha            ;Stocke la chaine
        lea StUs,a0             ;USING en route!
        bsr code0
        bsr getbyte
        cmp.b #";",d0
        bne csynt
        bra.s cp4a
; Prend la chaine et pousse
cp4:    move.l #$49fa0002,d0    ;LEA adexp,A4
        bsr outlong
        subq.l #1,a6
cp4a:   bsr evalue
        tst parenth
        bne csynt
        tst.b d2
        beq.s cp5
        bmi.s cp6
        moveq #L_prtfl,d0         ;Chiffre FLOAT
        tst.w (sp)
        beq.s cp7
        move.w #L_printfloat,d0   ;FLOAT---> FICHIER
        bra.s cp7
cp5:    moveq #L_prten,d0         ;Chiffre ENTIER
        tst.w (sp)
        beq.s cp7
        move.w #L_printlong,d0    ;ENTIER---> FICHIER
        bra.s cp7
cp6:    moveq #L_prtch,d0         ;Chaine
        tst.w (sp)
        beq.s cp7
        move.w #548,d0
cp7:    bsr crefonc

; Prend le separateur
cp8:    bsr getbyte
cp9:    cmp.b #";",d0
        beq.s cp13
        cmp.b #",",d0
        beq.s cp11
        subq.l #1,a6
        tst.b d0
        beq.s cp10
        cmp.b #":",d0
        beq.s cp10
        cmp.b #$9b,d0
        beq.s cp10
        bra csynt
cp10:   moveq #L_prtret,d0
        tst.w (sp)
        beq.s cp12
        move.w #L_printback,d0          ;RETURN ---> file
        bra.s cp12
cp11:   moveq #L_prtvir,d0
        tst.w (sp)
        beq.s cp12
        move.w #L_printcomma,d0         ;VIRGULE---> Fichier
cp12:   bsr crefonc

; Encore quelque chose a imprimer?
cp13:   bsr finie
        bne cp2
        addq.l #2,sp
        lea Lp2,a0              ;Sortie NORMALE du print
        bsr code0
        rts


;-----> KEY SPEED
Ckeyspeed:   bsr test0
        lea parent2(pc),a2
        bsr parinst
        move.w #L_keyspeed,d0
        bra crefonc

;-----> FIX
Cfix:   bsr test0
        bsr expentier
        move.w #L_fix,d0
        bra crefonc

;-----> ICON$
Cicon:    bsr fent
        move.w #L_icon,d0
        bra crech

;-----> TAB
CTab:   bsr fent
        move.w #L_tab,d0
        bra crech

;-----> CHARLEN
CChl:   bsr fent
        move.w #L_charlen,d0
        bra creent

;-----> CHARCOPY
parchc: dc.b en,to,en,1,1,0
   .even
Ccharcopy:   bsr test0
        lea parchc(pc),a2
        bsr parinst
        move.w #L_charcopy,d0
        bra crefonc

;-----> WINDOPEN
Cwindopen:  bsr test0
        lea parent(pc),a2
        bsr parinst
        subq.w #5,d0
        bcs csynt
        cmp.w #3,d0
        bcc csynt
        addi.w #L_windopen5,d0
        bra crefonc

;-----> WINDOW
CWdo:   bsr test0
        lea parent(pc),a2
        bsr parinst
        move.w #cmvqd0,d1
        move.b d0,d1
        move.w d1,d0
        bsr outword
        move.w #L_window,d0
        bra crefonc

;-----> QWINDOW
Cqwdo:  bsr test0
        bsr expentier
        move.w #L_qwindow,d0
        bra crefonc

;-----> WINDON
Cwdn:   move.w #L_windon,d0
        bra creent

;-----> WINDMOVE
CWdm:   bsr test0
        lea parent2(pc),a2
        bsr parinst
        move.w #L_windmove,d0
        bra crefonc

;-----> WINDEL
CWdl:   bsr test0
        bsr expentier
        move.w #L_windel,d0
        bra crefonc

;-----> LOCATE
Clocate:   bsr test0
        lea parent2(pc),a2
        bsr parinst
        move.w #L_locate,d0
        bra crefonc

;-----> CURS X
CCx:    move.w #L_cursx,d0
        bra creent

;-----> CURS Y
CCy:    move.w #L_cursy,d0
        bra creent

;-----> XTEXT
CXt:    bsr fent
        move.w #L_xtext,d0
        bra creent

;-----> YTEXT
CYt:    bsr fent
        move.w #L_ytext,d0
        bra creent

;-----> XGRAPHIC
CXg:    bsr fent
        move.w #L_xgraphic,d0
        bra creent

;-----> YGRAPHIC
CYg:    bsr fent
        move.w #L_ygraphic,d0
        bra creent

;-----> DIVX
CDx:    move.w #L_divx,d0
        bra creent

;-----> DIVY
CDy:    move.w #L_divy,d0
        bra creent

;-----> SCREEN
CFTSc:  lea parent2(pc),a2
        bsr parfonc
        move.w #L_screen,d0
        bra creent

;-----> PAPER
Cpaper:   bsr test0
        bsr expentier
        move.w #L_paper,d0
        bra crefonc

;-----> PEN
Cpen:   bsr test0
        bsr expentier
        move.w #L_pen,d0
        bra crefonc

;-----> CUP
Ccup:   bsr test0
        move.w #L_cup,d0
        bra crefonc

;-----> CDOWN
Ccdown:   bsr test0
        move.w #L_cdown,d0
        bra crefonc

;-----> CLEFT
Ccleft:   bsr test0
        move.w #L_cleft,d0
        bra crefonc

;-----> CRIGHT
Ccright:   bsr test0
        move.w #L_cright,d0
        bra crefonc

;-----> SCROLL
Cscroll:  bsr test0
        bsr onoff
        bmi gscro               ; SCROLLING GRAPHIQUE
        bne.s sco
        move.w #L_scrolloff,d0
        bra crefonc
sco:    move.w #L_scrollon,d0
        bra crefonc

;-----> SCROLL DOWN
CScd:   bsr test0
        move.w #L_scrolldown,d0
        bra crefonc

;-----> SCROLL UP
CScu:   bsr test0
        move.w #L_scrollup,d0
        bra crefonc

;-----> HOME
Chome:  bsr test0
        move.w #L_home,d0
        bra crefonc

;-----> CLW
CClw:   bsr test0
        move.w #L_clw,d0
        bra crefonc

;-----> SQUARE
CSqa:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #3,d0
        bne csynt
        move.w #L_square,d0
        bra crefonc

;-----> CLS
parcls: dc.b en,1
        dc.b en,",",en,1
        dc.b en,",",en,",",en,",",en,to,en,",",en,1
        dc.b 1,0
   .even
Ccls:   bsr test0
        bsr finie
        bne.s cls1
        move.w #L_cls,d0
        bra crefonc
cls1:   lea parcls,a2
        bsr parinst
        addi.w #L_cls,d0
        bra crefonc

;-----> INVERSE
CInv:   move.w #L_inverseoff,-(sp)
        bra.s cun

;-----> SHADE
CSha:   move.w #L_shadeoff,-(sp)
        bra.s cun
;-----> UNDER
Cund:   move.w #L_underoff,-(sp)

cun:    bsr test0
        bsr onoff
        bmi csynt
        bne.s cun1
        move.w (sp)+,d0
        bra crefonc
cun1:   move.w (sp)+,d0
        addq.w #1,d0
        bra crefonc

;-----> WRITING
CWr:    bsr test0
        bsr expentier
        move.w #L_writing,d0
        bra crefonc

;-----> CENTER a$
Ccen:   bsr test0
        bsr expalpha
        move.w #L_center,d0
        bra crefonc

;-----> TITLE a$
Ctit:   bsr test0
        bsr expalpha
        move.w #L_title,d0
        bra crefonc

;-----> BORDER
CBor:   bsr test0
        bsr finie
        bne.s bor1
        move.w #L_border,d0
        bra crefonc
bor1:   bsr expentier
        move.w #L_border2,d0
        bra crefonc

;-----> HARDCOPY
CHard:  bsr test0
        move.w #L_hardcopy,d0
        bra crefonc

;-----> WINDCOPY
CWind:  bsr test0
        move.w #L_windcopy,d0
        bra crefonc

;-----> MENU$(xx) MENU$(xx,yy)=
parmen: dc.b ch,1
        dc.b ch,1
        dc.b ch,",",en,",",en,1
        dc.b 1,0
   .even
Cmenu:  move.w #1,flagmenu
        bsr test0
        lea parent(pc),a2
        bsr parfonc
        cmp.w #2,d0
        beq.s cmn1
        cmp.b #1,d0
        bne csynt
; MENU$(XX)=
        move.w #L_setmenu,-(sp)
        bra.s cmn4
; MENU$(xx,yy)
cmn1:   move.w #L_setmenu3,-(sp)
cmn2:   bsr onoff
        bmi.s cmn4
        bne.s cmn3
; MENU$(xx,yy) OFF
        clr.w d0
        move.w #L_menuxyoff,(sp)
        bra.s cmn5
; MENU$(xx,yy) ON
cmn3:   move.w #L_menuxyon,(sp)
        clr.w d0
        bra.s cmn5
; MENU$(xx,yy)=
cmn4:   bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        lea parmen(pc),a2
        bsr parinst
cmn5:   move.w #cmvqd0,d1
        move.b d0,d1
        move.w d1,d0
        bsr outword
        move.w (sp)+,d0
        bra crefonc

;-----> MENU$ OFF / FREEZE / ON
Cmeno:  move.w #1,flagmenu
        bsr test0
        bsr onoff
        bcs.s cmnf
        bmi csynt
        bne cmno
; Off
        move.w #L_menuoff,d0
        bra crefonc
; Frezze
cmnf:   move.w #L_menufreeze,d0
        bra crefonc
; On / paper / pen
cmno:   clr.w -(sp)
        bsr finie
        beq.s cmno1
        lea parent(pc),a2
        bsr parinst
        cmp.w #2,d0
        bhi csynt
        move.w d0,(sp)
cmno1:  move.w (sp)+,d1
        move.w #cmvqd0,d0
        move.b d1,d0
        bsr outword
        move.w #L_menuon,d0
        bra crefonc

;-----> CHOICE
CChoi:  move.w #L_menuchoice,d0
        bra creent
;-----> ITEM
CItem:  move.w #L_menuitem,d0
        bra creent

;-----> ON MENU ON / OFF / GOTO ...
onmenu: bsr test0
        bsr onoff
        bmi.s onmn2
        bne.s onmn1
        move.w #L_onmenuoff,d0          ;ON MENU OFF
        bra crefonc
onmn1:  move.w #L_onmenuon,d0          ;ON MENU ON
        bra crefonc
onmn2:  bcs csynt
        bsr getbyte
        cmp.b #$98,d0           ;veut un GOTO
        bne csynt
        bsr pair
        addq.l #4,a6
; Prend et compte les numeros de ligne
        clr.w -(sp)
onmn3:  bsr Constant
        beq csynt
        cmp.l #65535,d1
        bcc csynt
        move.w #cmvima6,d0
        bsr outword
        move.l d1,d0
        bsr outlong
        addq.w #1,(sp)
        bsr getbyte
        cmp.b #",",d0
        beq.s onmn3
        subq.l #1,a6
        move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_onmenugoto,d0
        bra crefonc

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | GRAPHIQUES                      |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> =LOGIC
Cflog:  move.w #L_logic,d0
        bra creent
;-----> LOGIC=
Clog:   move.w #L_logic2,-(sp)
        bra.s Cbk
;-----> =PHYSIC
Cgetphysic:  move.w #L_physic,d0
        bra creent
;-----> PHYSIC=
Csetphysic:   move.w #L_physic2,-(sp)
        bra.s Cbk
;-----> =BACK
CFBak:  move.w #L_back,d0
        bra creent
;-----> BACK=
Cback:   move.w #L_back2,-(sp)
Cbk:    bsr test0
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w (sp)+,d0
        bra crefonc

;-----> = DEFAULT
CFDfo:  bsr getbyte
        move.b d0,d1
        move.w #L_defback,d0
        cmp.b #$e2,d1
        beq creent
        move.w #L_deflogic,d0
        cmp.b #$c8,d1
        beq creent
        cmp.b #$e1,d1
        beq creent
        bra csynt

;-----> SCREEN SWAP
Cscreenswap:  bsr test0
        move.w #L_sswap,d0
        bra crefonc

;-----> WAITVBL
Cwvbl:  move.w #L_waitvbl,d0
        bsr crefonc
        bra Test1

;-----> WAIT xx
CWait:  bsr test0
        bsr expentier
        move.w #L_wait,d0
        bra crefonc

;-----> =XMOUSE
CFXm:   move.w #L_xmouse,d0
        bra creent
;-----> XMOUSE=
Cxmouse:    bsr test0
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w #L_xmouse2,d0
        bra crefonc

;-----> =YMOUSE
CFYm:   move.w #L_ymouse,d0
        bra creent
;-----> YMOUSE=
Cymouse:    bsr test0
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w #L_ymouse2,d0
        bra crefonc

;-----> =MOUSEKEY
CFKm:   move.w #L_mousekey,d0
        bra creent

;-----> =JOY
CJoy:   move.w #L_joy,d0
        bra creent
;-----> =FIRE
CFire:  move.w #L_fire,d0
        bra creent
;-----> =JRIGHT
Cjright:  move.w #L_jright,d0
        bra creent
;-----> =JLEFT
Cjleft:  move.w #L_jleft,d0
        bra creent
;-----> =JDOWN
Cjdown:  move.w #L_jdown,d0
        bra creent
;-----> =JUP
Cjup:   move.w #L_jup,d0
        bra creent

;-----> =MODE
Cfmode:  move.w #L_fmode,d0
        bra creent
;-----> MODE=
Csmode:   bsr test0
        bsr expentier
        move.w #L_smode,d0
        bra crefonc

;-----> INK
Cink:   bsr test0
        bsr expentier
        move.w #L_inkk,d0
        bra crefonc

;-----> GRWRITING
Cgrwriting:   bsr test0
        bsr expentier
        move.w #L_grwriting,d0
        bra crefonc

;-----> SET LINE
Csetline:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #4,d0
        bne csynt
        move.w #L_setline,d0
        bra crefonc

;-----> SET MARK
Csetmark:   bsr test0
        lea parent2,a2
        bsr parinst
        move.w #L_setmark,d0
        bra crefonc

;-----> SET PAINT
Csetpaint:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #3,d0
        bne csynt
        move.w #L_setpaint,d0
        bra crefonc

;-----> SET PATTERN
Csetpattern:   bsr test0
        bsr evalue
        tst.b d2
        bmi.s Cpat2
        beq.s Cpat1
        move.w #L_fltoint,d0
        bsr crefonc
Cpat1:  move.w #L_setpattern,d0
        bra crefonc
Cpat2:  move.w #L_setpattern2,d0
        bra crefonc

;-----> CLIP OFF
parcli: dc.b en,",",en,to,en,",",en,1
        dc.b 1,0
   .even
Cclip:  bsr test0
        bsr onoff
        bmi.s clp
        bne csynt
        move.w #L_clipoff,d0
        bra crefonc
clp:    lea parcli,a2
        bsr parinst
        move.w #L_clip,d0
        bra crefonc

;-----> AUTOBACK
CAuto:  bsr test0
        bsr onoff
        bmi csynt
        bne.s cao
        move.w #L_autobackoff,d0
        bra crefonc
cao:    move.w #L_autobackon,d0
        bra crefonc

;-----> PLOT
Cplot:  bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #3,d0
        beq.s cpl
        cmp.w #2,d0
        bne csynt
        move.w #L_plot,d0
        bra crefonc
cpl:    move.w #L_plot2,d0
        bra crefonc

;-----> POINT
CPoin:  lea parent2,a2
        bsr parfonc
        move.w #L_point,d0
        bra creent

;-----> PAINT
Cpaint:  bsr test0
        lea parent2,a2
        bsr parinst
        move.w #L_paint,d0
        bra crefonc

;-----> POLYPARS ---> empile les parametres D0= nb coords / D1= pas debut?
polyp:  bsr test0
        clr.w -(sp)
        clr.w -(sp)
        bsr getbyte
        subq.l #1,a6
        cmp.b #$80,d0
        bne.s cpp1
        addq.l #1,a6
        addq.w #1,(sp)
        move.w #1,2(sp)
cpp1:   bsr expentier
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expentier
        addq.w #1,(sp)
        bsr getbyte
        cmp.b #$80,d0
        beq.s cpp1
        subq.l #1,a6
        move.w #cmvqd0,d0
        move.w (sp),d1
        move.b d1,d0
        bsr outword
        move.w #cmvqd1,d0
        move.w 2(sp),d1
        move.b d1,d0
        bsr outword
        move.w (sp)+,d0
        move.w (sp)+,d1
        rts

;-----> DRAW
Cdraw:   bsr polyp
        cmp.w #2,d0
        bne csynt
        tst.w d1
        bne.s cdr
        move.w #L_draw,d0
        bra crefonc
cdr:    move.w #L_draw2,d0
        bra crefonc

;-----> POLYLINE
Cpolyline:  bsr polyp
        move.w #L_polyline,d0
        bra crefonc

;-----> POLYGONE
Cpolygone:  bsr polyp
        move.w #L_polygone,d0
        bra crefonc

;-----> POLYMARK
Cpolymark:  bsr test0
        clr.w -(sp)
pm1:    bsr expentier
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expentier
        addq.w #1,(sp)
        bsr getbyte
        cmp.b #";",d0
        beq.s pm1
        subq.l #1,a6
        move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_polymark,d0
        bra crefonc

;-----> BAR
CBar:   bsr polyp
        cmp.w #2,d0
        bne csynt
        move.w #L_bar,d0
        bra crefonc

;-----> RBOX
CRBox:  bsr polyp
        cmp.w #2,d0
        bne csynt
        move.w #L_rbox,d0
        bra crefonc

;-----> RBAR
CRBar:  bsr polyp
        cmp.w #2,d0
        bne csynt
        move.w #L_rbar,d0
        bra crefonc

;-----> BOX
CBox:   bsr polyp
        cmp.w #2,d0
        bne csynt
        move.w #L_box,d0
        bra crefonc

;-----> ARC
Carc:   move.w #L_arc,-(sp)
        bra.s caa
;-----> PIE
Cpie:   move.w #L_pie,-(sp)
caa:    bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #5,d0
        bne csynt
        move.w (sp)+,d0
        bra crefonc

;-----> EARC
CEarc:  move.w #L_ellarc,-(sp)
        bra.s cab
;-----> EPPIE
CEpie:  move.w #L_ellpie,-(sp)
cab:    bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #6,d0
        bne csynt
        move.w (sp)+,d0
        bra crefonc

;-----> CIRCLE
Ccircle:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #3,d0
        bne csynt
        move.w #L_circle,d0
        bra crefonc

;-----> ELLIPSE
Cellipse:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #4,d0
        bne csynt
        move.w #L_ellipse,d0
        bra crefonc

;-----> CURS ON / OFF
Ccurs:   bsr test0
        bsr onoff
        bmi csynt
        bne.s ccu
        move.w #L_cursoff,d0
        bra crefonc
ccu:    move.w #L_curson,d0
        bra crefonc

;-----> SET CURS
Cscur:  bsr test0
        lea parent2,a2
        bsr parinst
        move.w #L_setcurs,d0
        bra crefonc

;-----> PREND LES PARAMETRES PALETTE
getpal: clr.w d1
        moveq #0,d2
        clr.w d3
gp1:    bsr finie
        beq.s gp3
        bsr getbyte
        subq.l #1,a6
        cmp.b #",",d0
        beq.s gp2
        movem.w d1-d3,-(sp)
        bsr expentier
        movem.w (sp)+,d1-d3
        bset d1,d2
        addq.w #1,d3
gp2:    addq.w #1,d1
        cmp.w #16,d1
        beq.s gp3
        bsr finie
        beq.s gp3
        bsr getbyte
        cmp.b #",",d0
        beq.s gp1
        bne csynt
gp3:    move.w #cmvqd0,d0
        move.b d1,d0
        bsr outword
        move.l #cmvd1,d0
        move.w d2,d0
        bsr outlong
        move.w #cmvqd2,d0
        move.b d3,d0
        bsr outword
        rts

;-----> PALETTE
CPal:   bsr test0
        bsr getpal
        move.w #L_palette,d0
        bra crefonc

;-----> GET PALETTE (ecran)
CGPal:  bsr test0
        bsr fent
        move.w #L_palette4,d0
        bra crefonc

;-----> COLOUR xx,nn
parent2:dc.b en,",",en,1,1,0
   .even
Ccolour:   bsr test0
        lea parent2,a2
        bsr parinst
        move.w #L_setcolor,d0
        bra crefonc

;-----> = COLOUR(xx)
CFCol:  bsr fent
        move.w #L_getcolor,d0
        bra creent

;-----> SHOW / SHOW ON
CSho:   move.w #L_showoff,-(sp)
        bra.s cho

;-----> HIDE / HIDE ON
CHid:   move.w #L_hideoff,-(sp)
cho:    bsr test0
        bsr finie
        beq.s cho1
        bsr onoff
        bmi csynt
        beq csynt
        addq.w #1,(sp) ; -> L_showon/L_Hideon
cho1:   move.w (sp)+,d0
        bra crefonc

;-----> CHANGE MOUSE
CChgm:  bsr test0
        bsr expentier
        move.w #L_changemouse,d0
        bra crefonc

;-----> LIMIT MOUSE
CLimm:  bsr finie
        beq.s clm
        lea parcli,a2
        bsr parinst
        move.w #L_limitmouse2,d0
        bra crefonc
clm:    move.w #L_limitmouse,d0
        bra crefonc

;-----> SYNCHRO / On / Off
CSync:  move.w #L_sync,-(sp)
        bra.s CSy
;-----> UPDATE / On / Off
Cupdate:   move.w #L_update,-(sp)
CSy:    bsr test0
        bsr onoff
        bmi.s csy2
        beq.s csy1
        addq.w #1,(sp) ; -> L_syncon
csy1:   addq.w #1,(sp) ; -> L_syncoff
csy2:   bcs csynt
        move.w (sp)+,d0
        bra crefonc

;-----> REDRAW
Credr:  bsr test0
        move.w #L_redraw,d0
        bra crefonc

;-----> SPRITE
Csprite:   bsr test0
        bsr onoff
        bmi.s csp5
        bne.s csp0
        clr.w -(sp)
        bra.w csp1
csp0:   move.w #1,-(sp)
csp1:   bsr finie
        bne.s csp2
        move.w #L_spriteoff,d0          ;SPRITE ON/OFF
        add.w (sp)+,d0
        bra crefonc
csp2:   bsr expentier           ;SPRITE ON/OFF xx
        move.w #L_spriteoff2,d0
        add.w (sp)+,d0
        bra crefonc
csp5:   bcs csynt               ;SPRITE X,Y,Z,[N]
        lea parent,a2
        bsr parinst
        cmp.w #4,d0
        beq.s csp6
        cmp.w #3,d0
        bne csynt
        move.w #L_spriteoff3,d0
        bra crefonc
csp6:   move.w #L_spriteon3,d0
        bra crefonc

;-----> MOVE ON/OFF/FREEZE [xx]
CMve:   move.w #L_moveoff,-(sp)
        bra.s mv0
;-----> ANIM ON/OFF/FREEZE [xx]
parani: dc.b en,",",ch,1,1,0
   .even
CAni:   move.w #L_animoff,-(sp)
mv0:    bsr test0
        bsr onoff
        bcs.s mv1
        bmi.s mv5
        beq.s mv2               ;Off
        addq.w #1,(sp)          ;On
        bra.s mv2
mv1:    addq.w #2,(sp)           ;Freeze
mv2:    bsr finie
        bne.s mv3
        move.w (sp)+,d0          ;Pas de param
        bra crefonc
mv3:    bsr expentier           ;Param!
        move.w (sp)+,d0
        addq.w #3,d0
        bra crefonc
mv5:    cmp.w #L_animoff,(sp)+        ;ANIM seul avec params!
        bne csynt
        lea parani,a2
        bsr parinst
        move.w #L_animate,d0
        bra crefonc

;-----> MOVEX
Cmovex:   move.w #L_movex,-(sp)
        bra.s mvx1
;-----> MOVEY
Cmovey:   move.w #L_movey,-(sp)
mvx1:   bsr test0
        lea parani,a2
        bsr parinst
        move.w (sp)+,d0
        bra crefonc

;-----> MOVON
Cmovon:   bsr fent
        move.w #L_movon,d0
        bra creent

;-----> COLLIDE
Ccollide:  lea parent,a2
        bsr parfonc
        cmp.w #3,d0
        bne csynt
        move.w #L_collide,d0
        bra creent

;-----> DETECT(cc)
Cdetect:  bsr fent
        move.w #L_detect,d0
        bra creent

;-----> FREEZE
Cfreeze:   bsr test0
        move.w #L_freeze,d0
        bra crefonc

;-----> UNFREEZE
Cunfreeze:  bsr test0
        move.w #L_unfreeze,d0
        bra crefonc

;-----> XPSPRITE
Cxsprite:   bsr fent
        move.w #L_xsprite,d0
        bra creent

;-----> YSPRITE
Cysprite:   bsr fent
        move.w #L_ysprite,d0
        bra creent

;-----> LIMIT SPRITE
Climitsprite:   bsr test0
        bsr finie
        beq.s clsp1
        lea parcli,a2
        bsr parinst
        move.w #L_limitsprite2,d0
        bra crefonc
clsp1:  move.w #L_limitsprite,d0
        bra crefonc

;-----> PUT SPRITE xx
Cputsprite:   bsr test0
        bsr expentier
        move.w #L_putsprite,d0
        bra crefonc

;-----> GET SPRITE
Cgetsprite:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #4,d0
        beq.s gsp1
        cmp.w #3,d0
        bne csynt
        move.w #L_getsprite3,d0
        bra crefonc
gsp1:   move.w #L_getsprite4,d0
        bra crefonc

;-----> PRIORITY ON/OFF
Cpri:   bsr test0
        bsr onoff
        bmi csynt
        bne.s cpn
        move.w #L_priorityoff,d0
        bra crefonc
cpn:    move.w #L_priorityon,d0
        bra crefonc

;-----> SCREEN COPY
parscc: dc.b en,to,en,1
        dc.b en,",",en,",",en,",",en,",",en,to,en,",",en,",",en,1
        dc.b 1,0
   .even
Cscreencopy:   bsr test0
        lea parscc(pc),a2
        bsr parinst
        cmp.w #1,d0
        beq.s csc1
        cmp.w #2,d0
        bne csynt
        move.w #L_screencopy2,d0
        bra crefonc
csc1:   move.w #L_screencopy,d0
        bra crefonc

;-----> =SCREEN$
parsc:  dc.b en,",",en,",",en,to,en,",",en,1,1,0
   .even
Cscreenget:   lea parsc(pc),a2
        bsr parfonc
        move.w #L_screenget,d0
        bra crech

;-----> SCREEN$=
Cscreenput:    bsr test0
        lea parent(pc),a2
        bsr parfonc
        cmp.w #3,d0
        bne csynt
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expalpha
        move.w #L_screenput,d0
        bra crefonc

;-----> DEFSCROLL
pardsc: dc.b en,",",en,",",en,to,en,",",en,",",en,",",en,1,1,0
   .even
Cdefscroll:   bsr test0
        lea pardsc(pc),a2
        bsr parinst
        move.w #L_defscroll,d0
        bra crefonc
;-----> SCROLL
gscro:  bsr expentier
        move.w #L_scroll,d0
        bra crefonc

;-----> RESET ZONE
Cresetzone:   bsr test0
        bsr finie
        beq.s rez1
        bsr expentier
        move.w #L_resetzone2,d0
        bra crefonc
rez1:   move.w #L_resetzone,d0
        bra crefonc
;-----> SET ZONE
parzo:  dc.b en,",",en,",",en,to,en,",",en,1,1,0
   .even
Csetzone:   bsr test0
        lea parzo(pc),a2
        bsr parinst
        move.w #L_setzone,d0
        bra crefonc
;-----> = ZONE
CZo:    bsr fent
        move.w #L_getzone,d0
        bra creent

;-----> REDUCE
CRedu:  bsr test0
        bsr getbyte
        subq.l #1,a6
        cmp.b #$80,d0
        bne.s cru2
; To
        addq.l #1,a6
        lea parent,a2
        bsr parinst
        cmp.w #5,d0
        beq.s cru1
        cmp.w #4,d0
        bne csynt
        move.w #L_reduceto,d0
        bra crefonc
cru1:   move.w #L_reducetoscreen,d0
        bra crefonc
; ecran To
cru2:   bsr expentier
        bsr getbyte
        cmp.b #$80,d0
        bne csynt
        lea parent,a2
        bsr parinst
        cmp.w #5,d0
        beq.s cru6
        cmp.w #4,d0
        bne csynt
        move.w #L_reducescreen,d0
        bra crefonc
cru6:   move.w #L_reducescreentoscreen,d0
        bra crefonc

;-----> ZOOM
parzoo: dc.b en,",",en,",",en,",",en,to,en,",",en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,",",en,to,en,",",en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,to,en,",",en,",",en,",",en,",",en,1
        dc.b en,",",en,",",en,",",en,",",en
        dc.b to,en,",",en,",",en,",",en,",",en,1
        dc.b 1,0
   .even
CZoo:   bsr test0
        lea parzoo(pc),a2
        bsr parinst
        addi.w #L_zoomto-1,d0
        bra crefonc

;-----> APPEAR
CApp:   bsr test0
        lea parent(pc),a2
        bsr parinst
        cmp.w #2,d0
        beq.s cap1
        move.w #L_appear,d0
        bra crefonc
cap1:   move.w #L_appear2,d0
        bra crefonc

;-----> FADE
CFad:   bsr test0
        bsr expentier
        bsr getbyte
        cmp.b #",",d0
        beq.s CFa2
        cmp.b #$80,d0
        beq.s CFa1
        subq.l #1,a6
        move.w #L_fade1,d0
        bra crefonc
CFa1:   bsr expentier
        move.w #L_fade2,d0
        bra crefonc
CFa2:   bsr getpal
        move.w #L_fade3,d0
        bra crefonc

;-----> FLASH
CFlas:  bsr test0
        bsr onoff
        bmi.s CFl1
        bne csynt
        move.w #L_flashoff,d0
        bra crefonc
CFl1:   bcs csynt
        lea parani(pc),a2
        bsr parinst
        move.w #L_flash,d0
        bra crefonc

;-----> SHIFT OFF / xx
CShif:  bsr test0
        bsr onoff
        bmi.s csh1
        bne csynt
        move.w #L_shiftoff,d0
        bra crefonc
csh1:   bcs csynt
        lea parent(pc),a2
        bsr parinst
        cmp.w #2,d0
        bhi csynt
        addi.w #L_shiftoff,d0
        bra crefonc

;-----> DEFAULT
Cdefault:  bsr test0
        tst.w cflaggem
        beq.s CDefo1
; Si GEM
        move.w #L_defgem,d0
        bra crefonc
; Si STOS
CDefo1: move.w #L_deftos,d0
        bra crefonc


;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | MUSIQUE ET SONS                 |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> MUSIC
CMus:   bsr test0
        bsr onoff
        bmi.s mu2
        bne.s mu1
        move.w #L_musicoff,d0          ;OFF
        bra crefonc
mu1:    move.w #L_musicon,d0        ;ON
        bra crefonc
mu2:    bcc.s mu3
        move.w #L_musicfreeze,d0        ;FREEZE
        bra crefonc
mu3:    bsr expentier
        move.w #L_music,d0
        bra crefonc

;-----> PVOICE
Cpvoi:  bsr fent
        move.w #L_pvoice,d0
        bra creent

;-----> VOICE
CVoi:   bsr test0
        bsr onoff
        bmi csynt
        bne.s vo2
; OFF
        bsr finie
        bne.s vo0
        move.w #L_voiceoff,d0
        bra crefonc
vo0:    lea parent(pc),a2
        bsr parinst
        cmp.w #2,d0
        beq.s vo1
        cmp.w #1,d0
        bne csynt
        move.w #L_voiceoff2,d0
        bra crefonc
vo1:    move.w #L_voiceoff3,d0
        bra crefonc
; ON
vo2:    bsr finie
        bne.s vo3
        move.w #L_voiceon,d0
        bra crefonc
vo3:    bsr expentier
        move.w #L_voiceon2,d0
        bra crefonc

;-----> TEMPO
Ctempo:  bsr test0
        bsr expentier
        move.w #L_tempo,d0
        bra crefonc

;-----> TRANSPOSE
Ctranspose:  bsr test0
        bsr expentier
        move.w #L_transpose,d0
        bra crefonc

;-----> SHOOT
Cshoot:  bsr test0
        move.w #L_shoot,d0
        bra crefonc

;-----> EXPLODE
CExpl:  bsr test0
        move.w #L_explode,d0
        bra crefonc

;-----> PING
CPing:  bsr test0
        move.w #L_ping,d0
        bra crefonc

;-----> ENVEL
CEnv:   bsr test0
        lea parent2(pc),a2
        bsr parinst
        move.w #L_envel,d0
        bra crefonc

;-----> VOLUME
CVol:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #2,d0
        beq.s cvo1
        cmp.w #1,d0
        bne csynt
        move.w #L_volume,d0
        bra crefonc
cvo1:   move.w #L_volume2,d0
        bra crefonc

;-----> NOISE
CNoi:   bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #2,d0
        beq.s cn1
        cmp.w #1,d0
        bne csynt
        move.w #L_noise,d0
        bra crefonc
cn1:    move.w #L_noise2,d0
        bra crefonc

;-----> NOTE
CNaut:  bsr test0
        lea parent,a2
        bsr parinst
        cmp.w #3,d0
        beq.s cn2
        cmp.w #2,d0
        bne csynt
cn2:    move.w d0,d1
        move.w #cmvqd0,d0
        move.b d1,d0
        bsr outword
        move.w #L_note,d0
        bra crefonc

;-----> =PSG
CFpsg:  bsr fent
        move.w #L_getpsg,d0
        bra creent

;-----> PSG=
Cpsg:   bsr test0
        bsr fent
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w #L_setpsg,d0
        bra crefonc

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | FICHIERS                        |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------

;-----> RUN
CRun:   bsr finie
        bne.s CRun1
; Run seul
        move.w #L_run,d0
        bra crefonc
; Run NOM$
CRun1:  bsr expalpha
        move.w #L_runname,d0
        bra crefonc

;-----> LOAD / SAVE
parld:  dc.b ch,1
        dc.b ch,",",en,1
        dc.b ch,",",en,",",en,1
        dc.b 1,0
        .even
CLoad:  move.w #L_load,-(sp)
        bra.s Clo
CSave:  move.w #L_save,-(sp)

Clo:    bsr test0
        lea parld(pc),a2
        bsr parinst
        move.w #cmvqd0,d1
        move.b d0,d1
        move.w d1,d0
        bsr outword
        move.w (sp)+,d0
        bra crefonc

;-----> BLOAD
parblo: dc.b ch,",",en,1,1,0
        .even
CBlo:   bsr test0
        lea parblo(pc),a2
        bsr parinst
        move.w #L_bload,d0
        bra crefonc

;-----> BSAVE
parbsa: dc.b ch,",",en,to,en,1,1,0
   .even
CBsa:   bsr test0
        lea parbsa(pc),a2
        bsr parinst
        move.w #L_bsave,d0
        bra crefonc

;-----> Getfile number
getf:   bsr getbyte
        cmp.b #"#",d0
        beq.s gf1
        subq.l #1,a6
gf1:    bsr expentier
        rts
;-----> idem
fgetf:  move.w parenth,-(sp)
        bsr getbyte
        cmp.b #"(",d0
        bne csynt
        bsr getbyte
        cmp.b #"#",d0
        beq.s gf2
        subq.l #1,a6
gf2:    bsr evalue
        cmp.w #-1,parenth
        bne csynt
        tst.b d2
        bmi ctype
        beq.s gf3
        move.w #L_inttofl,d0
        bsr crefonc
gf3:    move.w (sp)+,parenth
        rts

;-----> OPENIN
COpin:  bsr test0
        bsr getf
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expalpha
        move.w #L_openin,d0
        bra crefonc
;-----> OPENOUT
COpou:  bsr test0
        bsr getf
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expalpha
        clr.w -(sp)
        bsr finie
        beq.s Cop1
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expentier
        move.w #1,(sp)
Cop1:   move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_openout,d0
        bra crefonc

;-----> OPEN #xx,"llk"[,a$]
COpen:  bsr test0
        bsr getf
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expalpha
        clr.w -(sp)
        bsr finie
        beq.s Cop2
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expalpha
        move.w #1,(sp)
Cop2:   move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_openfile,d0
        bra crefonc

;-----> PORT(xx)
CPort:  bsr fgetf
        move.w #L_port,d0
        bra creent

;-----> CLOSE
CClo:   bsr test0
        bsr finie
        bne.s CClo1
        move.w #L_closefile,d0
        bra crefonc
CClo1:  bsr getf
        move.w #L_closefile1,d0
        bra crefonc

;-----> LOF
CLof:   bsr fgetf
        move.w #L_lof,d0
        bra creent

;-----> EOF
CEof:   bsr fgetf
        move.w #L_eof,d0
        bra creent

;-----> =POF
Cpofget:  bsr fgetf
        move.w #L_pofget,d0
        bra creent
;-----> POF=
Cpofset:   bsr test0
        bsr fgetf
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w #L_pofset,d0
        bra crefonc

;-----> FIELD
CFiel:  bsr test0
        bsr getf
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        clr.w -(sp)
CFld:   bsr expentier
        bsr getbyte
        cmp.b #$a0,d0
        bne csynt
        bsr getbyte
        cmp.b #$d3,d0
        bne csynt
        bsr getbyte
        cmp.b #$fa,d0
        bne csynt
        bsr vari
        tst.b d2
        bpl ctype
        btst #5,d2
        bne csynt
        bsr varad
        lea Cfield(pc),a0
        bsr code0
        addq.w #1,(sp)
        bsr getbyte
        cmp.b #",",d0
        beq.s CFld
        subq.l #1,a6
        move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w #L_field,d0
        bra crefonc
Cfield: move.l a0,-(a6)
        dc.w 0

;-----> GET #xx,nn
CGet:   bsr test0
        bsr getf
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expentier
        move.w #L_get,d0
        bra crefonc
;-----> PUT #xx,nn
CPut:   bsr test0
        bsr getf
        bsr getbyte
        cmp.b #",",d0
        bne csynt
        bsr expentier
        move.w #L_put,d0
        bra crefonc

;-----> DFREE
Cdfree: move.w #L_dfree,d0
        bra creent

;-----> MKDIR
Cmkdir:   bsr test0
        bsr expalpha
        move.w #L_mkdir,d0
        bra crefonc

;-----> RMDIR
Crmdir:   bsr test0
        bsr expalpha
        move.w #L_rmdir,d0
        bra crefonc

;-----> DIR$="
Csetdir:   bsr test0
        bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expalpha
        move.w #L_setdir,d0
        bra crefonc
;-----> =DIR$
Cgetdir:  move.w #L_getdir,d0
        bra crech

;-----> PREVIOUS
Cprevious:  bsr test0
        move.w #L_previous,d0
        bra crefonc

;-----> =DRIVE$
Cgetdrive:  move.w #L_getdrive,d0
        bra crech
;-----> =DRIVE
Cgetdrive2:   move.w #L_getdrive2,d0
        bra creent
;-----> DRIVE=
Csetdrive:   bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expentier
        move.w #L_setdrive,d0
        bra crefonc
;-----> DRIVE$=
Csetdrive2:  bsr getbyte
        cmp.b #$f1,d0
        bne csynt
        bsr expalpha
        move.w #L_setdrive2,d0
        bra crefonc

;-----> DRVMAP
CDMap:  move.w #L_drvmap,d0
        bra creent

;-----> DIRFIRST$
pardir: dc.b ch,",",en,1,1,0
   .even
CDirF:  lea pardir(pc),a2
        bsr parfonc
        move.w #L_dirfirst,d0
        bra crech
;-----> DIRNEXT$
CDirN:  move.w #L_dirnext,d0
        bra crech

;-----> KILL
CKill:  bsr test0
        bsr expalpha
        move.w #L_kill,d0
        bra crefonc
;-----> RENAME
paren:  dc.b ch,to,ch,1,1,0
   .even
CRena:  bsr test0
        lea paren(pc),a2
        bsr parinst
        move.w #L_rename,d0
        bra crefonc

;-----> DIRW
Cdirw:  move.w #L_dirw,-(sp)
        bra.s dir
;-----> LDIR
CLDir:  move.w #L_ldir,-(sp)
        bra.s dir
;-----> DIR
CDir:   move.w #L_dir,-(sp)
dir:    clr.w -(sp)
        bsr finie
        beq.s Dir1
        bsr expalpha
        move.w #1,(sp)
Dir1:   move.w #cmvqd0,d0
        move.w (sp)+,d1
        move.b d1,d0
        bsr outword
        move.w (sp)+,d0
        bra crefonc

;-----> FILE SELECT$
parfsl: dc.b ch,1
        dc.b ch,",",ch,1
        dc.b ch,",",ch,",",en,1
        dc.b 1,0
   .even
CFsel:  lea parfsl(pc),a2
        bsr parfonc
        addi.w #L_fileselect1-1,d0
        bra crech

;----------------------------------> Routines annexes
;-----> Rend l'adresse paire
pair:   move.w d0,-(sp)
        move.w a6,d0
        btst #0,d0
        beq.s Per
        addq.l #1,a6
Per:    move.w (sp)+,d0
        rts

;-----> Prend un octet du programme (A6)
getbyte:tst.w nomin
        bne.s gdb
        move.b (a6)+,d0
        rts
gdb:    move.l a0,-(sp)
        bsr SoDisk
        move.b (a0),d0
        addq.l #1,a6
        move.l (sp)+,a0
        rts

;-----> Prend un MOT du programme (A6)
GetWord:tst.w nomin
        bne.s gdw
        move.w (a6)+,d0
        rts
gdw:    move.l a0,-(sp)
        bsr SoDisk
        move.w (a0),d0
        addq.l #2,a6
        move.l (sp)+,a0
        rts

;-----> Prend un MOTLONG du programme (A6)
GetLong:tst.w nomin
        bne.s gdl
        move.l (a6)+,d0
        rts
gdl:    move.l a0,-(sp)
        bsr SoDisk
        move.l (a0),d0
        addq.l #4,a6
        move.l (sp)+,a0
        rts

;-----> Gestion du buffer entree SOURCE
SoDisk: cmp.l DebBso(pc),a6
        bcs.s SoDi1
        lea 4(a6),a0
        cmp.l FinBso(pc),a0
        bcc.s SoDi1
; Adresse RELATIVE dans le buffer
        move.l a6,a0
        sub.l DebBso(pc),a0
        add.l BufSou(pc),a0
        rts
; Change la position du buffer
SoDi1:  movem.l d0-d7/a0-a6,-(sp)
; Bouge le bout
        move.l DebBso(pc),d0
        move.l FinBso(pc),d1
        move.l MaxBso(pc),d2
        sub.l BordBso(pc),d2
        lea 4(a6),a0
SoDi3:  cmp.l d0,a6
        bcs.s SoDi4
        cmp.l d1,a0
        bcs.s SoDi5
; Monte le buffer
        add.l d2,d0
        add.l d2,d1
        bra.s SoDi3
; Descend le buffer
SoDi4:  sub.l d2,d0
        sub.l d2,d1
        bra.s SoDi3
SoDi5:  move.l d0,DebBso
        move.l d1,FinBso
        bsr LoadBso
; Trouve l'adresse relative
        movem.l (sp)+,d0-d7/a0-a6
        move.l a6,a0
        sub.l DebBso(pc),a0
        add.l BufSou,a0
        rts

;-----> Charge le buffer SOURCE
LoadBso:moveq #30,d7
        move.l DebBso(pc),d0
        bsr LSeek
; Sauve l'ancien
        move.l BufSou(pc),a0
        move.l TopSou(pc),d0
        sub.l DebBso(pc),d0
        cmp.l MaxBso(pc),d0
        bcs.s SoDi2
        move.l FinBso(pc),d0
        sub.l DebBso(pc),d0
SoDi2:  bsr load
        rts

;-----> Create a jmp to routine # D0
crejmp: sub.l a0,a0
        move.w d0,a0
        move.w #cjmp,d0
        bra.s CreF

;-----> Create a call to a subroutine # D0
crefonc:sub.l a0,a0
        move.w d0,a0
        move.w #cjsr,d0         ;Dans le source: JSR
CreF:   bsr outword
        bsr reljsr              ;Pointe la table de relocation ici
        move.l a0,d0
        bsr outlong             ;#ROUTINE.L
; Met le flag dans routin
        move.w a0,d0
        lsl.w #2,d0
        move.l routin,a0
        move.l #1,0(a0,d0.w)     ;Force la recopie de la routine
        lsr.w #2,d0
        rts

;-----> reloge un JSR ou une CONSTANTE ALPHANUMERIQUE
reljsr: move.l d0,-(sp)
        move.l a5,d0
        sub.l OldRel,d0
ReJ1:   cmp.w #126,d0
        bls.s ReJ2
        bsr OutRel1             ;>126: met 1 et boucle
        subi.w #126,d0
        bra.s ReJ1
ReJ2:   bclr #7,d0              ;Flag #7=0 ---> JSR ou CHAINE
        bsr OutRel              ;<126: met le chiffre
        move.l a5,OldRel
        move.l (sp)+,d0
        rts
; Poke a byte in the relocation table
OutRel: tst.w passe
        beq.s OutR
        move.b d0,(a4)+
        rts
OutRel1:tst.w passe
        beq.s OutR
        move.b #1,(a4)+
        rts
OutR:   addq.l #1,a4
        rts

;-----> Copie la portion de code A0 dans le source (RELOCATABLE)
code1:  movem.l a0/d0/d1,-(sp)
        move.w #$1111,d1        ;Termine par 1
        bra.s cod
code0:  movem.l a0/d0/d1,-(sp)
        clr.w d1        ;Termine par 0
cod:    move.w (a0)+,d0
        cmp.w d0,d1
        beq.s codfin
        bsr outword
        bra.s cod
codfin: movem.l (sp)+,a0/d0/d1
        rts

;-----> Copy the code portion A0 -> A1 in the source (RELOCATABLE)
CodeF:  move.w (a0)+,d0
        bsr outword
        cmp.l a1,a0
        bcs.s CodeF
        rts

;-----> Poke un OCTET dans l'objet
OutByte:tst.w passe
        beq.s PaOB
        tst.w nomout
        beq.s PaDB
; Sur disque
        move.l a0,-(sp)
        bsr obdisk
        move.b d0,(a0)+
        addq.l #1,a5
        move.l (sp)+,a0
        cmp.l topob(pc),a5
        bcs.s PamB
        move.l a5,topob
PamB:   rts
; En memoire
PaDB:   move.b d0,(a5)+         ;Poke
        cmp.l topwork(pc),a5
        bcc cout
        rts
; passe 0
PaOB:   addq.l #1,a5
        rts

;-----> Poke un MOT dans l'objet
outword:tst.w passe
        beq.s paow
        tst.w nomout
        beq.s padw
; Sur disque
        move.l a0,-(sp)
        bsr obdisk
        move.w d0,(a0)+
        addq.l #2,a5
        move.l (sp)+,a0
        cmp.l topob(pc),a5
        bcs.s pamw
        move.l a5,topob
pamw:   rts
; En memoire
padw:   move.w d0,(a5)+
        cmp.l topwork(pc),a5
        bcc cout
        rts
; passe 0
paow:   addq.l #2,a5
        rts

;-----> Poke un MOT LONG dans l'objet
outlong:tst.w passe
        beq.s paol
        tst.w nomout
        beq.s padl
; Sur disque
        move.l a0,-(sp)
        bsr obdisk
        move.l d0,(a0)+
        addq.l #4,a5
        move.l (sp)+,a0
        cmp.l topob(pc),a5
        bcs.s paml
        move.l a5,topob
paml:   rts
; En memoire
padl:   move.l d0,(a5)+         ;Poke
        cmp.l topwork(pc),a5
        bcc cout
        rts
; passe 0
paol:   addq.l #4,a5
        rts

;-----> Prend un mot long dans l'objet
gtolong:tst.w nomout
        beq.s pagl
; Sur disque
        move.l a0,-(sp)
        bsr obdisk
        move.l (a0)+,d0
        addq.l #4,a5
        move.l (sp)+,a0
        rts
; En memoire
pagl:   move.l (a5)+,d0
        rts

;-----> BUFFER objet DISQUE
obdisk: cmp.l debbob(pc),a5
        bcs.s obdi1
        lea 4(a5),a0
        cmp.l finbob(pc),a0
        bcc.s obdi1
; Adresse RELATIVE dans le buffer
        move.l a5,a0
        sub.l debbob(pc),a0
        add.l bufob(pc),a0
        rts
; Change la position du buffer
obdi1:  movem.l d0-d7/a0-a6,-(sp)
; Sauve le buffer
        bsr SaveBob
; Bouge le bout
        move.l debbob(pc),d0
        move.l finbob(pc),d1
        move.l maxbob(pc),d2
        sub.l bordbob(pc),d2
        lea 4(a5),a0
obdi3:  cmp.l d0,a5
        bcs.s obdi4
        cmp.l d1,a0
        bcs.s obdi5
; Monte le buffer
        add.l d2,d0
        add.l d2,d1
        bra.s obdi3
; Descend le buffer
obdi4:  sub.l d2,d0
        sub.l d2,d1
        bra.s obdi3
obdi5:  move.l d0,debbob
        move.l d1,finbob
        bsr LSeek
; Charge le nouveau bout
        move.l debbob(pc),a0
        move.l finbob(pc),d0
        cmp.l topob(pc),d0
        bcs.s obdi6
        move.l topob(pc),d0
obdi6:  sub.l a0,d0
        beq.s obdi7
        move.l bufob(pc),a0
        bsr load
; Trouve l'adresse relative
obdi7:  movem.l (sp)+,d0-d7/a0-a6
        move.l a5,a0
        sub.l debbob(pc),a0
        add.l bufob,a0
        rts
;-----> Sauve le buffer objet
SaveBob:moveq #31,d7
        move.l debbob(pc),d0
        bsr LSeek
; Sauve l'ancien
        move.l bufob(pc),a0
        move.l topob(pc),d0
        sub.l debbob(pc),d0
        cmp.l maxbob(pc),d0
        bcs.s obdi2
        move.l finbob(pc),d0
        sub.l debbob(pc),d0
obdi2:  bsr Write
        rts

;-----------------------------------------    --- ----- ---   ---    -------
;   -----------------------------------      |      |  |   | |
;   | DEPART DES BUFFERS              |       ---   |  |   |  ---
;   -----------------------------------          |  |  |   |     |
;-----------------------------------------    ---       ---   ---    -------
        dc.l 0
finprg: dc.l 0
