
;**************************************************************************
;*
;*      EXTENSION COMPACTEUR/DECOMPACTEUR D'IMAGES POUR STOS BASIC
;*
;*      (c) FL Soft 1987
;*
;**************************************************************************

;**************************************************************************

        .text

	.dc.w 0x0000
	.dc.w 0x0010
	.dc.w 0x0000
	.dc.w 0x0052
	.dc.w 0x0000
	.dc.w 0x00b8
	.dc.w 0x025a
	.dc.w 0x0220
	.dc.w 0x0002
	.dc.w 0x0002
	.dc.w 0x0008
	.dc.w 0x0029
	.dc.w 0x0000
	.dc.w 0x0100
	.dc.w 0x2c00
	.dc.w 0x0100
	.dc.w 0x2c00
	.dc.w 0x2c00
	.dc.w 0x0100
	.dc.w 0x2c00
	.dc.w 0x2c00
	.dc.w 0x2c00
	.dc.w 0x0100
	.dc.w 0x2c00
	.dc.w 0x2c00
	.dc.w 0x2c00
	.dc.w 0x2c00
	.dc.w 0x0101
	.dc.w 0x0000
	.dc.w 0x002c
	.dc.w 0x0001
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x002c
	.dc.w 0x0001
	.dc.w 0x0100

; Adaptation au Stos basic
entry:
        bra.w load
        even

params: ds.w 9
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

load:
        lea load1(pc),a2
load1:  rts


;**************************************************************************

;       Unpack origine[ ,ecran [,flags] [,dx,dy] ]

;**************************************************************************

unpackreloc:
	.dc.w unpackreloc1-unpackreloc
	.dc.w unpackreloc2-unpackreloc
	.dc.w unpackreloc3-unpackreloc
	.dc.w unpackreloc4-unpackreloc
	.dc 0

unpack:
	movea.l    2348(a5),a3
	movea.l    0(a3,d1.w),a3
	clr.w      unpflg-entry(a3)
	lea.l      params-entry(a3),a2

        move.w #-1,(a2)         ;flags par defaut
        move.l 406(a5),2(a2)    ;decor des sprites
        move.w #-1,6(a2)        ;dx
        move.w #-1,8(a2)        ;dy
;
        cmp.w #1,d0
        beq unp4
        cmp.w #2,d0
        beq unp3
        cmp.w #3,d0
        beq unp1
        cmp.w #4,d0
        beq unp2
; Cinq parametres
        move.l     (a6)+,d3      ;Dy
        move.w d3,8(a2)
        move.l     (a6)+,d3      ;Dx
        lsr.w #4,d3     ;divise par 16!
        move.w d3,6(a2)
; Trois parametres
unp1:   move.l     (a6)+,d3      ;Flags
        move.w d3,(a2)
        bra.s unp3
; Quatre parametres
unp2:   move.l     (a6)+,d3      ;Dy
        move.w d3,8(a2)
        move.l     (a6)+,d3      ;Dx
        lsr.w #4,d3     ;divise par 16!
        move.w d3,6(a2)
; Deux parametres
unp3:   move #1,unpflg-entry(a3)  ;Image
unpackreloc1:
        jsr        0x000000EA.l /* XXX ext_adscreen */
        move.l d3,2(a2)
; Un parametre          ;Origine
unp4:   
unpackreloc2:
        jsr        0x000000D6.l /* XXX ext_adoubank */
        move.l d3,a0            ;adresse d'origine
        move.l 2(a2),a1         ;adresse destination
        move.w 6(a2),d1         ;dx
        move.w 8(a2),d2         ;dy
        move.w (a2),d3          ;flags
;
        tst unpflg-entry(a3)              ;si l'adresse d'ecran est precisee              
        bne.s unp5              ;aucune gestion d'autoback
unpackreloc3:
        jsr        0x00000242.l                ;autoback UN /* XXX ext_abck */
unp5:   bsr decomp
        tst unpflg-entry(a3)
        bne.s unp6
        move.w d0,-(sp)
unpackreloc4:
        jsr        0x00000243.l     ;autoback DEUX /* XXX ext_abis */
        move.w (sp)+,d0    
;
unp6:   tst d0
        bne foncall
;
        rts

; Illegal function call
foncall:moveq #13,d0
	movea.l    2364(a5),a0
	jmp        (a0)

;**************************************************************************

        
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

decomp: movem.l    a3-a6,-(a7)
        /* cmpi.l #$06071963,code(a0)       ;verifie le code */
        dc.w 0x0ca8,0x0607,0x1963,code /* XXX */
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
        pea palnul-entry(a3)
        move.w #6,-(sp)
        trap #14
        addq.l #6,sp
        movem.l (sp)+,a0-a1/d1-d2
;
flag1:  lea -10(sp),sp            ;place pour les parametres
        move.l a1,a4            ;a4--> adresse ecran
        lea tmode-entry(a3),a2
        move.w mode(a0),d0
        lsl.w #3,d0
        move.w 0(a2,d0.w),d7    ;d7--> taille ligne
        move.w 2(a2,d0.w),d6    ;d6--> taille plans
        move.w 4(a2,d0.w),d5    ;d5--> nbplans
        move.w 6(a2,d0.w),d4    ;d4--> taille en Y ecran
        move.w d5,nbplan-entry(a3)
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
        move.l a1,6(a7)         ;  A3 --> adresse ecran de destination     
        move tcar(a0),d0
        mulu d7,d0
        move d0,2(sp)           ;2(sp)--> addition change de ligne de carre
        move d6,(sp)            ; (sp)--> addition change de carre
        move tcar(a0),d6        ;D6--> indice hauteur carre
        move.w tx(a0),d0
        subq #1,d0
        move d0,taillex-entry(a3)
        move.w ty(a0),d0        
        move d0,tailley-entry(a3)
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
dplan:  move.l 6(a7),a2
        move.w tailley-entry(a3),4(sp)    ;4(sp)--> compteur tailleY
dligne: move.l a2,a1
        move.w taillex-entry(a3),d5
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
        /* subq.w #1,4(sp) */
        dc.w 0x046f,1,4 /* XXX */
        bne.w dligne /* XXX */
        addq.l #2,6(a7)            ;autre plan couleur?
        /* subq.w #1,nbplan-entry(a3) */
        dc.w 0x046b,1,nbplan-entry /* XXX */
        bne dplan
;
        lea 10(a7),a7            ;retabli la pile

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
findec: movem.l    (a7)+,a3-a6
        moveq #0,d0
        rts

; Erreur!
erreur: lea 20(a7),sp              ;restore la pile!
erreur2:movem.l    (a7)+,a3-a6
        moveq #-1,d0
        rts

;**************************************************************************

;       PACK (image,destination [,mode,flags,hauteur,dx,dy,tx,ty])

;**************************************************************************

packreloc:
	.dc.w packreloc1-packreloc
	.dc.w packreloc2-packreloc
	.dc.w 0
	
pack:
	movea.l    2348(a5),a3
	movea.l    0(a3,d1.w),a3
; Parametres par defaut
        lea params-entry(a3),a2
        moveq #0,d4
        move.b resol.l,d4         ;resolution .B! /* XXX */
        move.w d4,d1
        lsl.w #3,d1
        lea tmode-entry(a3),a0
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
        cmp.w #1,d0
        beq pack3
; Neuf parametres
        lea params-entry(a3),a2
        moveq #6,d7
pack2:  move.l (a6)+,d3      ;empile les cinq params
        move.w d3,(a2)+
        dbra d7,pack2
; deux parametres
pack3:  
packreloc1:
        jsr 0xd6.l      ;va chercher "destination" /* XXX ext_adoubank */
        move.l d3,-(a7)
packreloc2:
        jsr 0xea.l      ;va chercher "origine" /* XXX ext_adscreen */
        move.l d3,-(a7)
; Verifie les parametres
;
        lea params-entry(a3),a2   
        move.w 12(a2),d0        ;resolution image
        cmp.w #2,d0
        bhi foncall2
        lsl #3,d0
        lea tmode-entry(a3),a0
        moveq #0,d1
        move.w 0(a0,d0.w),d1    ;verifie en X
        divu 2(a0,d0.w),d1
        move.w 6(a2),d2
        add.w 2(a2),d2
        cmp.w d1,d2
        bhi foncall2
        move.w (a2),d2          ;verifie en Y
        mulu 8(a2),d2
        add.w 4(a2),d2
        cmp.w 6(a0,d0.w),d2
        bhi foncall2
        move.w (a2)+,d5         ;ty
        beq foncall2
        move.w (a2)+,d4         ;tx
        beq foncall2
        move.w (a2)+,d3         ;dy
        move.w (a2)+,d2         ;dx
        move.w (a2)+,d1         ;hauteur
        beq foncall2
        move.w (a2)+,d6         ;flags
        move.w (a2)+,d7         ;resolution
;
        move.l (a7)+,a0
        move.l (a7)+,a1

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
compact:movem.l    a4-a6,-(a7)
        move.l a1,adobjet-entry(a3)
        /* move.l #$06071963,code(a1) */
        dc.w 0x237c,0x0607,0x1963,code /* XXX */
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
        lea palette(a1),a4
copal:  move.w (a2)+,(a4)+ 
        dbra d0,copal

; Preparation des parametres
        move.l a0,a4            ;a4--> adresse image
        lea dcomp(a1),a5        ;a5--> adresse TABLE 1
        lea 32000(a5),a6        ;a6--> adresse POINTEUR 1
        move.l a6,-(sp)         ;pour plus tard!
        subq #1,d5
        move d5,tailley-entry(a3)         ;taille en Y de l'image
        move d1,d5
        move.w mode(a1),d0
        lsl #3,d0
        lea tmode-entry(a3),a0
        move.w 0(a0,d0.w),d7    ;d7--> taille ligne
        move.w 2(a0,d0.w),d6    ;d6--> taille plans
        move.w 4(a0,d0.w),d0    ;d0--> nbplans
        move d0,nbplan-entry(a3)
        move d7,d0
        mulu d5,d0
        move d0,adycar-entry(a3)          ;passage en Y d'un carre a l'autre
        subq #1,d5              ;D5--> indice taille en Y du carre
        subq #1,d4
        move d4,a0              ;a0--> indice taille en X
        move.w dy(a1),d0
        mulu d7,d0
        add.w d0,a4
        move.w dx(a1),d0
        mulu d6,d0
        add.w d0,a4             ;a4--> adresse dans l'ecran
        move.l a4,-(a7)
        moveq #7,d1             ;indice compactage
        clr.b (a5)              ;premier octet a zero
        clr.b (a6)              

; Compactage proprement dit
plan:   move.l (a7),a4
        move.w tailley-entry(a3),d4
ligne:  move.l a4,a2
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
        add.w adycar-entry(a3),a4         ;passe a la ligne de carre suivante
        dbra d4,ligne
        addq.l #2,(a7)            ;passe au plan couleur suivant
        /* subq.w #1,nbplan-entry(a3) */
        dc.w 0x046b,1,nbplan-entry
        bne.s plan
        addq.l #4,a7

; Compactage de la table de pointeurs 1
        move.l adobjet-entry(a3),a1
        addq.l #1,a5
        move.l a5,d0
        sub.l a1,d0
        move.l d0,table2(a1)    ;adresse de la table intermediaire
        move.l (sp)+,a4         ;recupere le debut des pointeurs
        lea -1(a4),a0           ;nouveaux pointeurs: juste avant!
        move.l a0,-(sp)         ;pour plus tard
        moveq #7,d1
        clr.b (a5)
        clr.b (a0)
comp2:  move.b (a4)+,d0
        cmp.b (a5),d0
        beq.s comp2a
        addq.l #1,a5
        move.b d0,(a5)
        bset d1,(a0)
comp2a: dbra d1,comp2b
        moveq #7,d1
        addq.l #1,a0
        clr.b (a0)
comp2b: cmp.l a6,a4             ;compile toute la table des pointeurs
        bls.s comp2

; Termine le compactage
        addq.l #1,a5
        move.l a5,d0
        sub.l a1,d0
        move.l d0,point2(a1)    ;distance debut-pointeurs 2
        move.l (sp)+,a4
comp2c: move.b (a4)+,(a5)+
        cmp.l a0,a4             ;recopie la table des pointeurs
        bls.s comp2c

; Fini!
        move.l a5,d0
        sub.l a1,d0
        addq.l #1,d0            ;taille de l'image compactee en D0

;
        movem.l (sp)+,a4-a6
        move.l d0,-(a6)            ;ramene la longueur de la table
        clr.b d2
;
        rts


; Illegal function call
foncall2:moveq #13,d0
	movea.l    2364(a5),a0
	jmp        (a0)

        
;************************************************************************
        dc.w 0
finprg:



