
;**************************************************************************
;*
;*      EXTENSION COMPACTEUR/DECOMPACTEUR D'IMAGES POUR STOS BASIC
;*
;*      (c) FL Soft 1987
;*
;**************************************************************************

;**************************************************************************

	.include "extend.inc"

	.text

; Adaptation au Stos basic
        bra.w load
        even
        dc.b $80
tokens: dc.b "unpack",$80
        dc.b "pack",$81
        dc.b 0
        even
jumps:  dc.w 2
        dc.l 0 /* unpack */
        dc.l 0 /* pack */
        even
welcome:dc.b "PICTURE COMPACTOR extension",0
        dc.b "Extension COMPACTEUR D'IMAGES",0
        dc.b 0
        even
table:  dc.l 0
params: ds.w 9
retour: dc.l 0
larg:   dc.w 0
haut:   dc.w 0
unpflg: dc.w 0
resol   = $44c

;**************************************************************************

; entete de l'image compactee
code    = 0           ;code de reconnaissance: $06071963
mode    = 4           ;resolution
dx      = 6           ;debut en X (mots)
dy      = 8           ;debut en Y (pixels)
tx      = 10          ;taille en X (mots)
ty      = 12          ;taille en Y (carres de compactage)
tcar    = 16          ;taille du carre de compactage
flags   = 18          ;flags divers
table2  = 20          ;adresse de la table 2
point2  = 24          ;adressse des pointeurs 2
palette = 38          ;palette de couleurs
dcomp   = 70          ;debut du compactage de l'image

adobjet:dc.l 0          ;adresse de compactage
nbplan: dc.w 0
taillex:dc.w 0
tailley:dc.w 0
adycar: dc.w 0

tmode:  dc.w 160,8,4,200        ;adaptation a la resolution
        dc.w 160,4,2,200
        dc.w 80,2,1,400

palnul: ds.w 16

;**************************************************************************

; Called when loaded
; Inputs:
;   -
; Outputs:
;   a0: address of proram memory end
;   a1: address of coldboot function
;
load:   lea jumps+2(pc),a0
        lea unpack(pc),a1
        move.l a1,(a0)+
        lea pack(pc),a1
        move.l a1,(a0)+
        lea finprg(pc),a0
        lea cold(pc),a1
        rts

; Called during coldboot
; Inputs:
;   a0: pointer to table of functions that the extension may need
;      (see extend.inc)
; Outputs:
;   a0: welcome message
;   a1: address of warmboot function (called upon "new")
;   a2: address of tokens
;   a3: address of jump table for tokens
;   a4: (optional) address of reset function
;
cold:   lea table(pc),a1
        move.l a0,(a1)
        lea welcome(pc),a0
        lea warm(pc),a1
        lea tokens(pc),a2
        lea jumps(pc),a3
warm:   rts                     ;depart a chaud: ne fait rien

; Routine: depile et ramene un entier en D3.L
entier: move.l (sp)+,d0
        movem.l (sp)+,d2-d4
        move.l d0,-(sp)
        tst.b d2
        bmi typemis
        beq.s finent
        movem.l a0-a2,-(sp)
        move.l table(pc),a0
        move.l ext_fltoint(a0),a0
        jsr (a0)                ;FL TO INT
        movem.l (sp)+,a0-a2
finent: rts

; Adoubank
adoubank:movem.l a0-a2,-(sp)
        move.l table(pc),a0
        move.l ext_adoubank(a0),a0
        jsr (a0)
        movem.l (sp)+,a0-a2
        rts

; Adecran
adecran:movem.l a0-a2,-(sp)
        move.l table(pc),a0
        move.l ext_adscreen(a0),a0
        jsr (a0)
        movem.l (sp)+,a0-a2
        rts

; Syntax error
syntax: moveq #12,d0
        bra.s error
; Type mismatch
typemis:moveq #19,d0
        bra.s error
; Illegal function call
foncall:moveq #13,d0

; Appel des erreurs
error:  move.l table(pc),a0
        move.l ext_error(a0),a0
        jmp (a0)

;**************************************************************************

;       PACK (image,destination [,mode,flags,hauteur,dx,dy,tx,ty])

;**************************************************************************

pack:   lea retour(pc),a2
        move.l (sp)+,(a2)       ;adresse de retour
; Parametres par defaut
        lea params(pc),a2
        moveq #0,d4
        move.b resol,d4         ;resolution .B!
        move.w d4,d1
        lsl.w #3,d1
        lea tmode(pc),a0
        moveq #0,d2
        move.w 6(a0,d1.w),d2    ;taille ecran en Y
        moveq #5,d3
        divu d3,d2
        move.w d2,(a2)+         ;TY
        moveq #0,d2
        move.w 0(a0,d1.w),d2    ;taille ligne en octets
        divu 2(a0,d1.w),d2      ;divise par taille plan en octet
        move.w d2,(a2)+         ;TX
        clr.w (a2)+             ;dy
        clr.w (a2)+             ;dx
        move.w d3,(a2)+         ;hauteur
        move.w #%11,(a2)+       ;flags
        move.w d4,(a2)+         ;resolution
;
        cmpi.w #2,d0
        beq.s pack3
        cmpi.w #9,d0
        bne syntax
; Neuf parametres
        lea params(pc),a2
        moveq #6,d7
pack2:  bsr entier      ;empile les cinq params
        move.w d3,(a2)+
        dbra d7,pack2
; deux parametres
pack3:  bsr entier      ;va chercher "destination"
        bsr adoubank
        move.l d3,a1
        bsr entier      ;va chercher "origine"
        bsr adecran
        move.l d3,a0
; Verifie les parametres
        movem.l a3-a6,-(sp)
;
        lea params(pc),a2
        move.w 12(a2),d0        ;resolution image
        cmpi.w #2,d0
        bhi foncall
        lsl #3,d0
        lea tmode(pc),a3
        moveq #0,d1
        move.w 0(a3,d0.w),d1    ;verifie en X
        divu 2(a3,d0.w),d1
        move.w 6(a2),d2
        add.w 2(a2),d2
        cmp.w d1,d2
        bhi foncall
        move.w (a2),d2          ;verifie en Y
        mulu 8(a2),d2
        add.w 4(a2),d2
        cmp.w 6(a3,d0.w),d2
        bhi foncall
        move.w (a2)+,d5         ;ty
        beq foncall
        move.w (a2)+,d4         ;tx
        beq foncall
        move.w (a2)+,d3         ;dy
        move.w (a2)+,d2         ;dx
        move.w (a2)+,d1         ;hauteur
        beq foncall
        move.w (a2)+,d6         ;flags
        move.w (a2)+,d7         ;resolution
;
        bsr compact             ;va compacter
;
        move.l d0,d3            ;ramene la longueur de la table
        clr.b d2
;
fini:   movem.l (sp)+,a3-a6
        move.l retour(pc),-(sp)
        rts


;**************************************************************************

;       Unpack origine[ ,ecran [,flags] [,dx,dy] ]

;**************************************************************************

unpack:
        lea retour(pc),a2
        move.l (sp)+,(a2)
        lea params(pc),a2
        clr unpflg-params(a2)
        move.w #-1,(a2)         ;flags par defaut
        move.l table(pc),a0
        move.l ext_graphic(a0),a0  ;donnees graphiques
        move.l 6(a0),2(a2)      ;decor des sprites
        move.w #-1,dx(a2)        ;dx
        move.w #-1,dy(a2)        ;dy
;
        cmpi.w #1,d0
        beq unp4
        cmpi.w #2,d0
        beq unp3
        cmpi.w #3,d0
        beq unp1
        cmpi.w #4,d0
        beq unp2
        cmpi.w #5,d0
        bne syntax
; Cinq parametres
        bsr entier      ;Dy
        move.w d3,dy(a2)
        bsr entier      ;Dx
        lsr.w #4,d3     ;divise par 16!
        move.w d3,dx(a2)
; Trois parametres
unp1:   bsr entier      ;Flags
        move.w d3,(a2)
        bra.s unp3
; Quatre parametres
unp2:   bsr entier      ;Dy
        move.w d3,dy(a2)
        bsr entier      ;Dx
        lsr.w #4,d3     ;divise par 16!
        move.w d3,dx(a2)
; Deux parametres
unp3:   move #1,unpflg-params(a2)  ;Image
        bsr entier
        bsr adecran
        move.l d3,2(a2)
; Un parametre          ;Origine
unp4:   bsr entier
        bsr adoubank
        move.l d3,a0            ;adresse d'origine
        move.l 2(a2),a1         ;adresse destination
        move.w dx(a2),d1         ;dx
        move.w dy(a2),d2         ;dy
        move.w (a2),d3          ;flags
        movem.l a3-a6,-(sp)     ;sauve les registres importants
;
        tst unpflg-params(a2)              ;si l'adresse d'ecran est precisee
        bne.s unp5              ;aucune gestion d'autoback
        movem.l d1-d3/a0-a1,-(sp)
        move.l table(pc),a0
        move.l ext_abck(a0),a0
        jsr (a0)                ;autoback UN
        movem.l (sp)+,d1-d3/a0-a1
unp5:   bsr decomp
        lea params(pc),a2
        tst unpflg-params(a2)
        bne.s unp6
        move.w d0,-(sp)
        move.l table(pc),a0
        move.l ext_abis(a0),a0
        jsr (a0)                ;autoback DEUX
        move.w (sp)+,d0
;
unp6:   tst d0
        bne foncall
;
        bra fini

;**************************************************************************


;**************************************************************************
;
;       COMPACTEUR
;                       A0: ad image d'origine
;                       A1: ad image de destination
;                       D1: hauteur du carre de compactage
;                       D2: DX
;                       D3: DY
;                       D4: TX
;                       D5: TY
;                       D6: effacement ou non de l'image
;                       D7: resolution
;
;**************************************************************************

; Preparation de l'entete de l'image compactee
compact:
        lea adobjet(pc),a3
        move.l a1,(a3)
        move.l #$06071963,code(a1)
        move.w d7,mode(a1)
        move.w d2,dx(a1)
        move.w d3,dy(a1)
        move.w d4,tx(a1)
        move.w d5,ty(a1)
        move.w d1,tcar(a1)
        move.w d6,flags(a1)

; Copie de la palette
        moveq #15,d0
        lea 32000(a0),a2        ;palette de couleurs apres l'image
        lea palette(a1),a3
copal:  move.w (a2)+,(a3)+
        dbra d0,copal

; Preparation des parametres
        move.l a0,a4            ;a4--> adresse image
        lea dcomp(a1),a5        ;a5--> adresse TABLE 1
        lea 32000(a5),a6        ;a6--> adresse POINTEUR 1
        move.l a6,-(sp)         ;pour plus tard!
        subq #1,d5
        lea adobjet(pc),a3
        move d5,tailley-adobjet(a3)         ;taille en Y de l'image
        move d1,d5
        move.w mode(a1),d0
        lsl #3,d0
        lea tmode(pc),a0
        move.w 0(a0,d0.w),d7    ;d7--> taille ligne
        move.w 2(a0,d0.w),d6    ;d6--> taille plans
        move.w 4(a0,d0.w),d0    ;d0--> nbplans
        move d0,nbplan-adobjet(a3)
        move d7,d0
        mulu d5,d0
        move d0,adycar-adobjet(a3)          ;passage en Y d'un carre a l'autre
        subq #1,d5              ;D5--> indice taille en Y du carre
        subq #1,d4
        move d4,a0              ;a0--> indice taille en X
        move.w dy(a1),d0
        mulu d7,d0
        add.w d0,a4
        move.w dx(a1),d0
        mulu d6,d0
        add.w d0,a4             ;a4--> adresse dans l'ecran
        moveq #7,d1             ;indice compactage
        clr.b (a5)              ;premier octet a zero
        clr.b (a6)

; Compactage proprement dit
plan:   move.l a4,a3
        move.w tailley(pc),d4
ligne:  move.l a3,a2
        move.w a0,d3
carre:  move.l a2,a1
        move.w d5,d2
;
octet1: move.b (a1),d0          ;compacte le carre de gauche
        cmp.b (a5),d0
        beq.s oct1
        addq.l #1,a5
        move.b d0,(a5)
        bset d1,(a6)
oct1:   dbra d1,oct2
        moveq #7,d1
        addq.l #1,a6
        clr.b (a6)
oct2:   add.w d7,a1
        dbra d2,octet1
        move.l a2,a1
;
        move.w d5,d2
        move.l a2,a1
octet2: move.b 1(a1),d0         ;compacte le carre de droite
        cmp.b (a5),d0
        beq.s oct3
        addq.l #1,a5
        move.b d0,(a5)
        bset d1,(a6)
oct3:   dbra d1,oct4
        moveq #7,d1
        addq.l #1,a6
        clr.b (a6)
oct4:   add.w d7,a1             ;passe a la ligne d'ecran suivante
        dbra d2,octet2
;
        add.w d6,a2             ;passe au carre suivant
        dbra d3,carre
        add.w adycar(pc),a3         ;passe a la ligne de carre suivante
        dbra d4,ligne
        addq.l #2,a4            ;passe au plan couleur suivant
        lea nbplan(pc),a3
        subq.w #1,(a3)
        bne.s plan

; Compactage de la table de pointeurs 1
        move.l adobjet(pc),a1
        addq.l #1,a5
        move.l a5,d0
        sub.l a1,d0
        move.l d0,table2(a1)    ;adresse de la table intermediaire
        move.l (sp)+,a4         ;recupere le debut des pointeurs
        lea -1(a4),a3           ;nouveaux pointeurs: juste avant!
        move.l a3,-(sp)         ;pour plus tard
        moveq #7,d1
        clr.b (a5)
        clr.b (a3)
comp2:  move.b (a4)+,d0
        cmp.b (a5),d0
        beq.s comp2a
        addq.l #1,a5
        move.b d0,(a5)
        bset d1,(a3)
comp2a: dbra d1,comp2b
        moveq #7,d1
        addq.l #1,a3
        clr.b (a3)
comp2b: cmp.l a6,a4             ;compile toute la table des pointeurs
        bls.s comp2

; Termine le compactage
        addq.l #1,a5
        move.l a5,d0
        sub.l a1,d0
        move.l d0,point2(a1)    ;distance debut-pointeurs 2
        move.l (sp)+,a4
comp2c: move.b (a4)+,(a5)+
        cmp.l a3,a4             ;recopie la table des pointeurs
        bls.s comp2c

; Fini!
        move.l a5,d0
        sub.l a1,d0
        addq.l #1,d0            ;taille de l'image compactee en D0
        rts

;************************************************************************
;
;       DECOMPACTEUR
;
;                               A0.L: adresse image d'origine
;                               A1.L: adresse image destination
;                               D1.W: nouveau DX (<0 si meme)
;                               D2.W: nouveau DY (<0 si meme)
;                               D3.W: nouveaux flags (<0 si memes)
;
;************************************************************************

decomp: cmpi.l #$06071963,code(a0)       ;verifie le code
        bne erreur2

; Prepare les parametres
        move.l a0,-(sp)         ;adresse d'origine
        move.l a1,-(sp)         ;adresse destination
;
        tst.w d3
        bpl.s dflag
        move.w flags(a0),d3
dflag:  move.w d3,-(sp)         ;pousse les flags
        btst #0,d3
        beq.s flag1
; Toutes les couleurs a zero pendant le travail! FLAG= XXXXXXX1
        movem.l a0-a1/d1-d2,-(sp)
        pea palnul(pc)
        move.w #6,-(sp)
        trap #14
        addq.l #6,sp
        movem.l (sp)+,a0-a1/d1-d2
;
flag1:  subq.l #6,sp            ;place pour les parametres
        move.l a1,a4            ;a4--> adresse ecran
        lea tmode(pc),a2
        move.w mode(a0),d0
        lsl.w #3,d0
        move.w 0(a2,d0.w),d7    ;d7--> taille ligne
        move.w 2(a2,d0.w),d6    ;d6--> taille plans
        move.w 4(a2,d0.w),d5    ;d5--> nbplans
        move.w 6(a2,d0.w),d4    ;d4--> taille en Y ecran
        move.w d5,nbplan-tmode(a2)
        tst.w d1
        bpl.s dec1
        move.w dx(a0),d1
dec1:   tst.w d2
        bpl.s dec2
        move.w dy(a0),d2
dec2:   mulu d6,d1              ;calcule et verifie en X
        add.w d1,a1
        move.w tx(a0),d0        ;taille en X en mots
        mulu d6,d0
        add d0,d1
        cmp d7,d1
        bhi erreur
        move.w ty(a0),d0        ;calcule et verifie en Y
        mulu tcar(a0),d0
        add.w d2,d0
        cmp.w d4,d0
        bhi erreur
        mulu d7,d2
        add.w d2,a1
        move.l a1,a3            ;  A3 --> adresse ecran de destination
        move tcar(a0),d0
        mulu d7,d0
        move d0,2(sp)           ;2(sp)--> addition change de ligne de carre
        move d6,(sp)            ; (sp)--> addition change de carre
        move tcar(a0),d6        ;D6--> indice hauteur carre
        move.w tx(a0),d0
        subq #1,d0
        lea taillex(pc),a4
        move d0,(a4)
        move.w ty(a0),d0
        move d0,tailley-taillex(a4)
        lea dcomp(a0),a4        ;a4--> table octets 1
        move.l a0,a5
        move.l a0,a6
        add.l table2(a0),a5     ;a5--> table octets 2
        add.l point2(a0),a6     ;a6--> table pointeurs
        moveq #7,d0             ;prepare les variables de compactage
        moveq #7,d1
        move.b (a5)+,d2
        move.b (a4)+,d3
        btst d1,(a6)
        beq.s prep
        move.b (a5)+,d2
prep:   subq #1,d1

; Decompactage proprement dit
dplan:  move.l a3,a2
        move.w tailley(pc),4(sp)    ;4(sp)--> compteur tailleY
dligne: move.l a2,a1
        move.w taillex(pc),d5
dcarre: move.l a1,a0
        move.w d6,d4            ;  D4 --> compteur hauteur carre
;
doctet1:subq.w #1,d4
        bmi.s doct3
        btst d0,d2
        beq.s doct1
        move.b (a4)+,d3
doct1:  move.b d3,(a0)
        add.w d7,a0
        dbra d0,doctet1
        moveq #7,d0
        btst d1,(a6)
        beq.s doct2
        move.b (a5)+,d2
doct2:  dbra d1,doctet1
        moveq #7,d1
        addq.l #1,a6
        bra.s doctet1
doct3:  move.l a1,a0
        move.w d6,d4
;
doctet2:subq.w #1,d4
        bmi.s doct7
        btst d0,d2
        beq.s doct5
        move.b (a4)+,d3
doct5:  move.b d3,1(a0)
        add.w d7,a0
        dbra d0,doctet2
        moveq #7,d0
        btst d1,(a6)
        beq.s doct6
        move.b (a5)+,d2
doct6:  dbra d1,doctet2
        moveq #7,d1
        addq.l #1,a6
        bra.s doctet2
;
doct7:  add.w (sp),a1           ;autre carres ?
        dbra d5,dcarre
        add.w 2(sp),a2          ;autre ligne de carres?
        subq.w #1,4(sp)
        bne dligne
        addq.l #2,a3            ;autre plan couleur?
        lea nbplan(pc),a2
        subq.w #1,(a2)
        bne dplan
;
        addq.l #6,sp            ;retabli la pile

; Fin du decompactage
        move.w (sp)+,d1         ;recupere les flags
        move.l (sp)+,a1         ;adresse de destination
        move.l (sp)+,a0         ;adresse de l'image
        lea palette(a0),a0
        lea 32000(a1),a1
        move.l a1,a2
        moveq #15,d0
dpal:   move.w (a0)+,(a1)+
        dbra d0,dpal
        btst #1,d1              ;ne pas changer les couleurs de l'ecran
        beq.s findec
        move.l a2,-(sp)         ;change les couleurs de l'ecran
        move.w #6,-(sp)
        trap #14
        addq.l #6,sp
;
findec: moveq #0,d0
        rts

; Erreur!
erreur: add #16,sp              ;restore la pile!
erreur2:moveq #-1,d0
        rts


;************************************************************************
        dc.l 0
finprg:
