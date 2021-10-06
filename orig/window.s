
	/* Output	Stos\Windo102.bin */

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                             GESTION DES FENETRES                           ;
;                                  1/11/1989                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          bra debut
          dc.b "Window"       ;repere pour trouver le debut
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TABLE DE DEFINITION  DES FONCTIONS DE LA TRAPPE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
even
ttrappe:  dc.l chrout,1         ;0
          dc.l prtstring,1      ;1
          dc.l laucate,1        ;2
          dc.l setpaper,0       ;3
          dc.l setpen,0         ;4
          dc.l tstscreen,0      ;5
          dc.l initwind,1       ;6
          dc.l arretint,1       ;7
          dc.l windon,1         ;8
          dc.l effenetre,1      ;9
          dc.l initmode,1       ;10
          dc.l getbuffer,1      ;11
          dc.l hardcopy,0       ;12
          dc.l gcourante,0      ;13
          dc.l fixcursor,1      ;14
          dc.l departint,0      ;15
          dc.l qwindon,1        ;16
          dc.l coordcurs,0      ;17
          dc.l centrage,1       ;18
          dc.l setback,0        ;19
          dc.l autoins,1        ;20
          dc.l join,1           ;21
          dc.l curbas,1         ;22
          dc.l curhaut,1        ;23
          dc.l windmov,1        ;24
          dc.l effenvite,1      ;25
          dc.l newicon,0        ;26
          dc.l actcache,1       ;27
          dc.l getchar,0        ;28
          dc.l setchar,0        ;29
          dc.l border,1         ;30
          dc.l title,1          ;31
          dc.l autobon,1        ;32
          dc.l autoboff,0       ;33
          dc.l ancauto,1        ;34
          dc.l xgraphic,0       ;35
          dc.l ygraphic,0       ;36
          dc.l xtext,0          ;37
          dc.l ytext,0          ;38
          dc.l box,1            ;39
          dc.l update,0         ;40
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TABLE DES COULEURS (ET HACHURES)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tcouleur: dc.w 0,0,0,0
          dc.w $ffff,0,0,0
          dc.w 0,$ffff,0,0
          dc.w $ffff,$ffff,0,0
          dc.w 0,0,$ffff,0
          dc.w $ffff,0,$ffff,0
          dc.w 0,$ffff,$ffff,0
          dc.w $ffff,$ffff,$ffff,0
          dc.w 0,0,0,$ffff
          dc.w $ffff,0,0,$ffff
          dc.w 0,$ffff,0,$ffff
          dc.w $ffff,$ffff,0,$ffff
          dc.w 0,0,$ffff,$ffff
          dc.w $ffff,0,$ffff,$ffff
          dc.w 0,$ffff,$ffff,$ffff
          dc.w $ffff,$ffff,$ffff,$ffff
; table de caracteres hachures! SUPER!
          dc.w 0,0,0,0
          dc.w $aaaa,0,0,0
          dc.w 0,$aaaa,0,0
          dc.w $aaaa,$aaaa,0,0
          dc.w 0,0,$aaaa,0
          dc.w $aaaa,0,$aaaa,0
          dc.w 0,$aaaa,$aaaa,0
          dc.w $aaaa,$aaaa,$aaaa,0
          dc.w 0,0,0,$aaaa
          dc.w $aaaa,0,0,$aaaa
          dc.w 0,$aaaa,0,$aaaa
          dc.w $aaaa,$aaaa,0,$aaaa
          dc.w 0,0,$aaaa,$aaaa
          dc.w $aaaa,0,$aaaa,$aaaa
          dc.w 0,$aaaa,$aaaa,$aaaa
          dc.w $aaaa,$aaaa,$aaaa,$aaaa

;nombre de fenetres utilisables
nbfenetre  = 16

;initialisation au mode de resolution
;nbplan/xoctets/yoctets/tlecran/tcarcopie/vclignote et couleurs du curseur
initres:  dc.w 4,40,200,160,4,2           ;basse resolution
          dc.b 0,0,0,0,0,0,0,0
          dc.w 2,80,200,160,2,2           ;moyenne resolution
          dc.b 0,0,0,0,0,0,0,0
          dc.w 1,80,400,80,2,5            ;haute resolution
          dc.b $ff,$ff,1,1,1,0,0,0

;fond TOTAL utilise par INITMODE
ftotal:   dc.w 0,1,0,0,40,25,1,0
          dc.w 0,2,0,0,80,25,1,0
          dc.w 0,3,0,0,80,25,1,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; donnees propres au mode de resolution
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ecran      = $44e
back:      dc.l 0
mode:      dc.w 0
nbplan:    dc.w 0
xoctets:   dc.w 0
yoctets:   dc.w 0
tlecran:   dc.w 0
tcarcopie: dc.w 0
autoback:  dc.w 0
oldauto:   dc.w 0
nbjeux:    dc.w 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; table des tours de fenetre 16 tours differents!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tbords:   dc.b 192,193,194,195,196,197,198,199    ;1
          dc.b 200,201,202,203,204,205,206,207    ;2
          dc.b 208,209,210,211,212,213,214,215    ;3
          dc.b 216,217,218,219,220,221,222,223    ;4
          dc.b 224,193,225,195,196,226,198,227    ;5
          dc.b 228,201,229,203,204,230,206,231    ;6
          dc.b 232,209,233,211,212,234,214,235    ;7
          dc.b 236,217,237,219,220,238,222,239    ;8
          dc.b 224,240,225,241,242,226,243,227    ;9
          dc.b 192,240,194,241,242,197,243,199    ;10
          dc.b 244,201,245,203,204,246,206,247    ;11
          dc.b 248,193,249,195,196,250,198,251    ;12
          dc.b 248,240,249,241,242,250,243,251    ;13
          dc.b 252,252,252,252,252,252,252,252    ;14
          dc.b 253,253,253,253,253,253,253,253    ;15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; table des caracteres de controle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
controle: dc.l 0              ;0
          dc.l qgauche        ;1
          dc.l qdroite        ;2
          dc.l gauche         ;3
          dc.l scrollht       ;4
          dc.l scrollbs       ;5
          dc.l return         ;6
          dc.l delete         ;7
          dc.l backspace      ;8
          dc.l droite         ;9
          dc.l bas            ;10
          dc.l haut           ;11
          dc.l clears         ;12
          dc.l alaligne       ;13
          dc.l wrt1           ;14
          dc.l wrt2           ;15
          dc.l wrt3           ;16
          dc.l marchcur       ;17
          dc.l normal         ;18
          dc.l ombreoff       ;19
          dc.l arretcur       ;20
          dc.l inverse        ;21
          dc.l ombreon        ;22
          dc.l scrollon       ;23
          dc.l finligne       ;24
          dc.l scrolloff      ;25
          dc.l delete         ;26
          dc.l cescape        ;27
          dc.l insere         ;28
          dc.l souloff        ;29
          dc.l haume          ;30
          dc.l soulon         ;31

; update on/off
upd:      dc.w 0

; fenetre courante
courante: dc.w 0
adcouran: dc.l 0
freelle:  dc.w 0                  ;fenetre avec les bords? (8)
tempinit: dc.w 0
tempeff1: dc.w 0
tempeff2: dc.w 0
tempeff3: dc.w 0
tempeff4: dc.w 0
rapeflag: dc.w 0

; flag routine curseur en marche
inhibc:   dc.w 0    ;0 si autorsation aff curseur
offcur:   dc.w 0    ;0 si autorsation aff curseur

; flags des fenetres ouvertes
flagfen:  dc.l 0

; pile des fenetres affichees
priofen:  ds.b nbfenetre

; nombre d'octets utilises pour les buffers fenetres
topcopie: dc.w 0
maxcopie  = 32000

; table des adresses des jeux de caractere: 16 JEUX MAX
adjeux:   ds.l 16
nomjeux:  dc.b "*.CR"
numjeux:  dc.b 0,0
	even
; donnees propres a la fenetre
; donnees diverses
adjeucar   = 0
chrxsize   = 4
chrysize   = 6
pen        = 8
paper      = 10
adpen      = 12
adpaper    = 16
flags      = 20  ; -89 writing -10 inverse -11 ombre
; gestion du curseur
xcursor    = 22
ycursor    = 24
curseur    = 26
cptcurs    = 28
indcurs    = 30
poscurs    = 32
tabcurs    = 34   ; table des couleurs du curseur: 8 octets
dcurseur   = 42
fcurseur   = 44
flgcurs    = 46
; donnees du TEXT
scrollup   = 48
bordure    = 50
;----------------
txtext     = 52
tytext     = 54
startx     = 56
starty     = 58
txreel     = 60
tyreel     = 62
startxr    = 64
startyr    = 66
;----------------
; adresses systemes
adecran    = 68
copie      = 72
adcopie    = 76
;-----------------
writing    = 80
bufcur     = 82              ;128 bytes for cursor
lfenetre   = 82+128          ;length of a window
tfenetre:  ds.b lfenetre*nbfenetre

; tour des fenetres sur l'imprimante
cartour   = 32
; soulignement
souligne: dc.w $ffff,$ffff,$ffff,$ffff

; ancien vecteur contenu en 4($456)
anc456:   dc.l 0

; DTA
dta:      ds.b 48

;-------------------------------> icones
adicon:   dc.l 0              ;adresse de la banque d'icones
escape:   dc.w 0              ;flag: code escape?
; BUFFER QUI NE SERT A RIEN DE SAUVEGARDE DU DECOR POUR LES ICONES
buficon:  ds.b 300
; BUFFER POUR SHADER UN ICONE
bufshade: ds.b 100

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         INITIALISATION DE LA TRAPPE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
debut: 
;          move.l 4(sp),a0
;          move.l #$100,d6
;          add.l 12(a0),d6
;          add.l 20(a0),d6
;          add.l 28(a0),d6
;          move.l d6,-(sp)
; initialise la trappe
          bsr initrap
; charge les jeux de caractere *.CRx
          move.l #dta,-(sp)
          move.w #$1a,-(sp)
          trap #1             ;SETDTA
          addq.l #6,sp
          clr d7              ;compteur numero du jeu de caracteres
          clr.l d6            ;taille totale des jeux de caracteres
          lea bufcopie+maxcopie+64,a6      ;debut des jeux de caracteres par defaut
debut1:   move.b #"0",numjeux ;*.CR0/*.CR1/....
          add.b d7,numjeux
          clr.w -(sp)
          pea nomjeux
          move #$4e,-(sp)     ;SFIRST
          trap #1
          addq.l #8,sp
          tst d0
          bne.w debut4 /* XXX */
          clr.w -(sp)
          pea dta+30
          move.w #$3d,-(sp)
          trap #1
          addq.l #8,sp
          move d0,d5          ;handle en D5
          bmi.w debut1          ;erreur! /* XXX */
          move.l a6,-(sp)     ;adresse de chargement
          move.l dta+26,-(sp) ;taille du fichier
          move.w d5,-(sp)
          move.w #$3f,-(sp)
          trap #1
          /* add.l #12,sp */
          dc.w 0xdffc,0,12 /* XXX */
          tst.l d0
          bmi.w debut3 /* XXX */
          cmp.l #$06071963,(a6)         ;code de reconnaissance
          bne.w debut3 /* XXX */
          add.l d0,d6                   ;taille totale
          subq.l #4,d0                  ;taille des caracteres (moins code)
          lea adjeux,a0
          move d7,d1
          lsl #2,d1
          addq.l #4,a6         ;saute le code
          move.l a6,0(a0,d1.w) ;poke l'adresse du jeu de caractere charge
          add.l d0,a6          ;pointe le jeu suivant
          addq #1,d7
debut3:   move.w d5,-(sp)
          move.w #$3e,-(sp)
          trap #1             ;close
          addq.l #4,sp
          cmpi.w #16,d7
          bcs debut1

debut4:   move d7,nbjeux       ;premier jeux de caracteres libre!
          move.l a6,a0         ;transmet l'adresse de FIN du programme!
          rts
;          move.l (sp)+,d0     ;recupere la longueur du PGM
;          add.l #maxcopie,d0  ;plus taille du buffer
;          add.l d6,d0         ;plus taille des jeux de caractere
;          add.l #$100,d0
;          clr.w -(sp)         ;sortie en conservant le programme
;          move.l d0,-(sp)
;          move.w #$31,-(sp)   ;KEEP PROCESS
;          trap #1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INITIALISATION/ARRET DES INTERRUPTIONS ET DE LA TRAPPE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INITIALISATION DE LA TRAPPE
initrap:  move.l #entrappe,-(sp)        ;setexec
          move.w #35,-(sp)
          move.w #5,-(sp)               ;initialisation de la
          trap #13                      ;trappe 3
          addq.l #8,sp
          rts
; DEPART DES INTERRUPTIONS
departint:move #-1,offcur               ;empeche l'affichage du curseur
          clr inhibc
          move.l ecran.l,a0 /* XXX */
          sub.l  #$8000,a0               ;par defaut: decor=ecran-$8000
          move.l a0,back
          move.l $456.l,a0 /* XXX */
          move.l 4(a0),anc456
          move.l #gcurseur,4(a0)        ;en deuxieme position
          rts
; ARRET DES INTERRUPTIONS
arretint: move.l $456.l,a0 /* XXX */
          move.l anc456,4(a0)
          rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         ENTREE DE LA TRAPPE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
entrappe: movem.l d1-d7/a1-a6,-(sp)
          lsl #3,d7
          lea ttrappe,a5
          move.l 0(a5,d7.w),a6
          move.l adcouran,a4
          tst 6(a5,d7.w)      ;faut-il arreter les sprites?
          beq.s pastop
; FONCTIONS ARRETANT LA SOURIS ET LES SPRITES
          bsr curoff
          movem.l d0/d1,-(sp)
          moveq #28,d0        ;arret rapide de la souris
          trap #5
          movem.l (sp)+,d0/d1
          jsr (a6)
          bsr curon
          move.l d0,-(sp)
          tst upd
          beq.s entrap0
          tst autoback
          bne.s entrap1
entrap0:  moveq #41,d0        ;mouse bete
          bra.s entrap2
entrap1:  moveq #29,d0        ;remise en route souris ET TOUS LES SPRITES!
entrap2:  trap #5
          move.l (sp)+,d0
          movem.l (sp)+,d1-d7/a1-a6
          rte
; FONCTIONS N'ARRETANT PAS LA SOURIS ET LES SPRITES
pastop:   jsr (a6)
          movem.l (sp)+,d1-d7/a1-a6
          rte

;HARDCOPY DE LA FENETRE OUVERTE
hardcopy: moveq #27,d0         ;RESET imprimante
          bsr outprt
          moveq #64,d0
          bsr outprt
          clr d3
          move bordure(a4),d5
          tst d5               ;impression de la bordure?
          beq.s hard1
          move txreel(a4),d1
          subq #1,d1
hard0:    move #cartour,d0
          bsr outprt
          dbra d1,hard0
hard1:    moveq #13,d0         ;retour a la ligne
          bsr outprt
          moveq #10,d0
          bsr outprt
          clr d2
          tst d5
          beq.s hard2
          move #cartour,d0
          bsr outprt
hard2:    move d2,d0
          move d3,d1
          bsr screen
          cmpi.b #255,d0
          beq.s hard2a
          cmpi.b #32,d0        ;filtre les icones
          bcc.s hard3
hard2a:   move.b #32,d0
hard3:    bsr outprt
          addq #1,d2
          cmp txtext(a4),d2
          blt.s hard2
          tst d5
          beq.s hard4
          move #cartour,d0
          bsr outprt
hard4:    addq #1,d3
          cmp tytext(a4),d3
          blt.w hard1 /* XXX */
          moveq #13,d0
          bsr outprt
          moveq #10,d0
          bsr outprt
          tst d5
          beq.s hard6
          move txreel(a4),d1
          subq #1,d1
hard5:    move #cartour,d0
          bsr outprt
          dbra d1,hard5
hard6:    moveq #13,d0
          bsr outprt
          moveq #10,d0
          bsr outprt
          clr.l d0
          rts

;SORTIE SUR L'IMPRIMANTE
outprt:   move.w d0,-(sp)
          move.w #5,-(sp)
          trap #1
          addq.l #4,sp
          tst.w d0
          bne.s finprt
          addq.l #4,sp        ;POP!
          move #1,d0          ;erreur imprimante
finprt:   rts

; BCONOUT SUR L'ECRAN
bconout2: move.w d0,-(sp)
          move.w #2,-(sp)
          move.w #3,-(sp)
          trap #13
          addq.l #6,sp
          rts

; SETBACK: CHANGE L'ADRESSE DU DECOR
setback:  move.l a0,back      ;que c'est long!
          rts

; UPDATE ON/OFF
update:   move d0,upd
          rts

; INITIALISATION AU MODE DE RESOLUTION et RAZ generale fenetres
initmode: move.w #4,-(sp)     ;getrez
          trap #14
          addq.l #2,sp
          move d0,mode
          mulu #20,d0
          lea initres,a0
          add.w d0,a0
          move (a0)+,nbplan
          move (a0)+,xoctets
          move (a0)+,yoctets
          move (a0)+,tlecran
          move (a0),tcarcopie
; arret du CURSEUR DU VT52
          clr.w -(sp)
          clr.w -(sp)
          move.w #21,-(sp)
          trap #14
          addq.l #6,sp
; initialisation des FENETRES
          lea priofen,a0
          move #nbfenetre-1,d0
initpr:   clr.b (a0)+
          dbra d0,initpr
          clr.l flagfen       ;arret de toutes les fenetres
          clr.w topcopie
          clr.w tempinit
          clr.w escape
          move #1,autoback    ;par defaut AUTOBACK ON
          move #1,upd         ;par defaut UPDATE ON
;INITIALISATION DE LA GRANDE FENETRE SUR TOUT L'ECRAN
          lea ftotal,a0
          clr d0              ;fenetre zero!
          move mode,d1
          lsl #4,d1
          add.w d1,a0
          move (a0)+,d1       ;bords
          swap d1
          move (a0)+,d1       ;jeux de car
          move (a0)+,d2       ;dx
          move (a0)+,d3       ;dy
          move (a0)+,d4       ;tx
          move (a0)+,d5       ;ty
          move (a0)+,d6       ;pen
          swap d6
          move (a0),d6        ;paper
          bsr initwind
; Fin d'initmode
          move nbjeux,d0      ;premier jeu de caracteres accessible!
          rts

; INITIALISATION D'UNE FENETRE: D0 numero de la fenetre
;                               D1 jeu de caractere et bordure
;                               D2/D3 startx et y
;                               D4/D5 txtext et tytext
;                               D6    pen et paper
initwind: andi.w #$000f,d0
          move.l flagfen,d7
          btst d0,d7
          bne error2          ;--->deja ouverte!
          move d0,tempinit    ;stocke le numero de la fenetre
          mulu #lfenetre,d0
          lea tfenetre,a4
          add.w d0,a4           ;a4 contient l'adresse de la fenetre

          tst d1
          beq error6
          cmpi.w #16,d1
          bhi error6          ;--->jeu de caractere n'existe pas
          subq #1,d1
          lsl #2,d1
          lea adjeux,a1
          add.w d1,a1
          tst.l (a1)
          beq error6          ;--->pas de jeu a ce numero!
          move.l (a1),a1     ;a1 pointe le jeu de caracteres
; initialisation du jeu de caractere
          /* move.l a1,adjeucar(a4) */
          dc.w 0x2949,adjeucar /* XXX */
          move (a1)+,d0
          move d0,chrxsize(a4)
          move (a1),d1
          move d1,chrysize(a4)
; initialisation de la taille de la fenetre
          move d2,startxr(a4)
          move d2,startx(a4)
          move d3,startyr(a4)
          move d3,starty(a4)
          move d4,txtext(a4)
          move d4,txreel(a4)
          beq error4          ;---> fenetre trop petite!
          move d5,tytext(a4)
          move d5,tyreel(a4)
          beq error4
          swap d1             ;recupere la bordure
          andi.w #$000f,d1
          move d1,bordure(a4)
          tst d1
          beq.w pasbord /* XXX */
          /* addi.w #1,startx(a4)   ;BORDURE: decale la zone utile */
          dc.w 0x66c,1,startx /* XXX */
          /* addi.w #1,starty(a4)           ;vers le centre de la fenetre */
          dc.w 0x66c,1,starty /* XXX */
          /* subi.w #2,txtext(a4) */
          dc.w 0x46c,2,txtext /* XXX */
          beq error4
          bcs error4          ;---> fenetre trop petite!
          /* subi.w #2,tytext(a4) */
          dc.w 0x46c,2,tytext /* XXX */
          beq error4
          bcs error4          ;---> fenetre trop petite!
pasbord:  swap d1             ;reprend la taille car en Y
          add.w d4,d2
          mulu d0,d2
          cmp xoctets,d2
          bhi error5          ;---> fenetre trop grande en X!
          add.w d5,d3
          mulu d1,d3
          cmp yoctets,d3
          bhi error5          ;---> fenetre trop grande en Y!
; paper et pen
          clr flags(a4)       
          move d6,d0
          bsr setpaper
          swap d6
          move d6,d0
          bsr setpen
; initialisation de la copie texte
          move topcopie,d3
          mulu d5,d4          ;txtext*tytext*tcarcopie = taille copie texte
          mulu tcarcopie,d4
          move d4,d5
          add.w d3,d5
          cmpi.w #maxcopie,d5
          bcc error7          ;---> plus de place buffer!
          move d5,topcopie
          lea bufcopie,a2
          add.w d3,a2
          move.l a2,copie(a4) ;stocke l'adresse de la copie
; initialisations diverses
          move.l a4,adcouran  ;adresse de la fenetre courante=celle-ci
          clr freelle         ;pour pouvoir imprimer IMBECILE!
          move mode,d0
          mulu #20,d0
          lea initres,a0
          lea 10(a0,d0.w),a0  ;a0 pointe sur la table du curseur
          bsr initcurs        ;initialisation du curseur
          bsr normal          ;pas inverse
          bsr wrt1            ;writing 1
          bsr ombreoff        ;pas ombre
          clr escape
; affiche le tour de la fenetre
          move bordure(a4),d0
          beq.w ouvre /* XXX */
          bsr afftour
; active la fenetre elle meme
ouvre:    bsr clears
          bsr scrollon
          move tempinit,d0
          move.l flagfen,d7
          bset d0,d7          ;fenetre ouverte!
          move.l d7,flagfen
          move #1,tempinit
          bra actzero

; BORDER
border:   bsr afftour
          move.l d0,-(sp)
          bsr recopie
          move.l (sp)+,d0
          rts

; AFFICHE LE TOUR D0 DE LA FENETRE COURANTE, si zero, remet la meme!
afftour:  move bordure(a4),d1
          beq tourerr         ;fenetre sans bordure!!!
          andi.w #$f,d0
          bne.w afftour1 /* XXX */
          move d1,d0
afftour1: move d0,bordure(a4)
; prepare la fenetre
          move xcursor(a4),-(sp)
          move ycursor(a4),-(sp)
          move scrollup(a4),-(sp)
          clr scrollup(a4)
          move #8,freelle     ;fenetre entiere!
          bsr haume
          clr writing(a4)
; affiche!
          lea tbords,a2       ;table des caracteres de bordure
          move bordure(a4),d0
          subq #1,d0
          lsl #3,d0
          add.w d0,a2           ;a2 pointe sur les caracteres
          move.b (a2)+,d0
          bsr chrdec          ;coin haut gauche
          move txtext(a4),d1
          subq #1,d1
          move.b (a2)+,d0
initw4:   bsr chrdec          ;ligne du haut
          dbra d1,initw4
          move.b (a2)+,d0
          bsr chrdec          ;coin superieur droit
          addq #1,d0
          move d0,d4
          move tytext(a4),d3  ;d3 compteur en Y
          subq #1,d3
          move #1,d5          ;d5 indice en Y
initw5:   clr d0              ;affichage des lignes de cote
          move d5,d1
          bsr curxy
          move.b (a2),d0
          bsr chrdec
          move txreel(a4),d0
          subq #1,d0
          move d5,d1
          bsr curxy
          move.b 1(a2),d0
          bsr chrdec
          addq #1,d5
          dbra d3,initw5
          addq.l #2,a2
          move.b (a2)+,d0
          bsr chrdec          ;coin inferieur gauche
          move.b (a2)+,d0
          move txtext(a4),d1
          subq #1,d1
initw6:   bsr chrdec          ;ligne du bas
          dbra d1,initw6
          move.b (a2)+,d0
          bsr chrdec          ;coin inferieur droit
; remet tout comme avant
          clr freelle
          move.w (sp)+,scrollup(a4)
          move.w (sp)+,d1
          move.w (sp)+,d0
          bsr curxy
          clr.l d0            ;pas d'erreur
          rts
tourerr:  moveq #1,d0
          rts

; ACTIVATION MULTIPLE (A0 ---> TABLE)
actcache: move.w (a0)+,d0
          bmi.w actch2 /* XXX */
          move.l a0,-(sp)
          move #1,tempinit
          bsr windon2
          tst d0              ;une erreur: recopie et arrete!
          bne.w actch3 /* XXX */
          tst d1              ;peut on dessiner?
          bne.w actch1 /* XXX */
          bsr windaff         ;oui !!!
actch1:   move.l (sp)+,a0
          bra.w actcache /* XXX */
actch2:   bsr recopie         ;pas d'erreur
          clr.l d0
          rts
actch3:   move.l d0,(sp)      ;une erreur: la sauve, recopie!
          bsr recopie
          move.l (sp)+,d0
          rts

; ACTIVATION RAPIDE D'UNE FENETRE
qwindon:  move #1,tempinit
          bra.w windon2 /* XXX */
; ACTIVATION DE LA FENETRE D0
windon:   clr tempinit
windon2:  andi.w #$000f,d0
          move.l flagfen,d7
          btst d0,d7
          beq error3          ;--->pas ouverte!
          cmp courante,d0
          beq.w dejaact         ;banane! Elle est deja activee! /* XXX */
; table des priortes
actzero:  move d0,courante
          lea priofen,a1       ;adresse de la table des priorte
          move.b 0(a1,d0.w),d2 ;ancienne priorte
          bne.w wdon0 /* XXX */
          move #nbfenetre+1,d2
wdon0:    move #nbfenetre-1,d1
wdon1:    move.b 0(a1,d1.w),d3
          beq.w wdon2 /* XXX */
          cmp.b d3,d2
          bls.w wdon2 /* XXX */
          /* add.b #1,0(a1,d1.w)  ;recule celles qui etaient devant elle */
          dc.w 0x631,1,0x1000 /* XXX */
wdon2:    dbra d1,wdon1
          move.b #1,0(a1,d0.w) ;c'est maintenant la premiere

          mulu #lfenetre,d0
          lea tfenetre,a4
          add.w d0,a4           ;a4 contient l'adresse de la fenetre
          move.l a4,adcouran  ;stocke l'adcourante

; Affiche la fenetre telle qu'elle est stockee! SUPER!
          tst tempinit
          bne.w finwindon       ;pas de dessin: la fenetre est vide! /* XXX */
          bsr windaff         ;va la dessiner dans le decor
          bsr recopie         ;recopie rapide sur l'ecran C'EST JOLI...
; fini sans aucune erreur
finwindon:clr tempinit
          clr d0              ;pas d'erreur
          clr d1              ;on peut dessiner...
          rts
; fini avec erreur mineure: elle etait deja activee...
dejaact:  clr tempinit
          clr d0              ;pas d'erreur
          moveq #1,d1         ;mais on peut pas dessiner!
          rts

; SOUS PROGRAMME DE WINDON: AFFICHE UNE FENETRE, (SANS RECOPIE)
; Efface le fond graphique avec les flags actuels!
windaff:  clr escape
	  move #8,freelle	;TOUTE la fenetre! 
          move txreel(a4),d2
          move tyreel(a4),d3
          clr d0
          clr d1
          bsr effecran
; Ecris le tour et la fenetre
          move ycursor(a4),-(sp)
          move xcursor(a4),-(sp)
          bsr haume
          move flags(a4),d7
          move d7,-(sp)
          bclr #9,d7          ;enleve le soulignement!!!
          move d7,d1
          move scrollup(a4),-(sp)
          clr scrollup(a4)    ;pas de scrolling!
          clr writing(a4)     ;writing NORMAL, sinon tout merde!

          move.l a0,a2
          move txreel(a4),d5
          move tyreel(a4),d6
          clr d3
wdon3:    clr d2
wdon4:    tst mode
          beq.s actlow
          move.w (a2)+,d4     ;HI et MID resolution
          move.b d4,d0
          clr.b d4
          bra.w wdon5 /* XXX */
actlow:   move.l (a2)+,d4
          move.b d4,d0
          swap d4
wdon5:    cmpi.b #32,d0        ;caractere different de 32/255
          bne.s wdon5c
          cmp d4,d1
          bne.w wdon5c /* XXX */
wdon5b:   bsr finafact
          bra.w wdon7 /* XXX */
wdon5c:   cmp d7,d4           ;est-ce actualis‚?
          beq.w wdon6           ;oui: c'est bon directement! /* XXX */
          bsr actualise       ;non, on actualise,
          move d4,d7          ;on stocke,
wdon6:    bsr chrdec
wdon7:    addq #1,d2
          cmp d5,d2           ;fin de la ligne?
          bcs.w wdon4 /* XXX */
          addq #1,d3
          cmp d6,d3           ;fin de la page?
          bcs.w wdon3 /* XXX */
; fini: remet le curseur et les flags
          clr freelle         ;fenetre restreinte!
          move (sp)+,scrollup(a4)       ;retabli les scrollings
          move (sp)+,d4       ;flags
          bsr actualise
          move (sp)+,d0       ;xcursor
          move (sp)+,d1       ;ycursor
          bsr curxy
          rts

; REAFFICHE TOUTES LES FENETRES, DANS L'ORDRE INVERSE DES PRIORITES!
reaffiche:move.l adcouran,-(sp)
          moveq #nbfenetre,d7
windm1:   move.l flagfen,d6
          lea priofen,a0
          move #-1,d0
          moveq #nbfenetre-1,d1
windm2:   addq #1,d0
          cmp.b (a0)+,d7
          beq.w windm4 /* XXX */
          dbra d1,windm2
windm3:   subq #1,d7          ;on bouge la fenetre activee=> la premiere
          bne.w windm1          ;====> la derniere a etre affichee! /* XXX */
          move.l (sp)+,a4     ;restore l'ancien ADCOURAN
          move.l a4,adcouran
          rts                 ;====> rien a faire a la fin!!!
windm4:   btst d0,d6          ;pas ouverte!
          beq.w windm3 /* XXX */
          move d7,-(sp)       ;pousse le numero de priorite
          mulu #lfenetre,d0
          lea tfenetre,a4
          add.w d0,a4
          move.l a4,adcouran
          bsr windaff         ;va afficher la fenetre!
          move (sp)+,d7       ;recupere la priorite
          bra.w windm3          ;suivante! /* XXX */

; MOVE WINDOW: CHANGE LA POSITION DE LA FENETRE COURANTE  !!!! GENIAL !!!!
windmov:  move d0,d2
          add.w txreel(a4),d2   ;taille totale en X
          mulu chrxsize(a4),d2
          cmp xoctets,d2      ;trop grande en X
          bhi error5
          move d1,d3
          add.w tyreel(a4),d3
          mulu chrysize(a4),d3
          cmp yoctets,d3      ;trop grande en Y
          bhi error5
; OK, on peut la changer!
          move startx(a4),d2
          sub.w startxr(a4),d2  ;difference bord/interieur en X
          move starty(a4),d3
          sub.w startyr(a4),d3  ;difference bord/interieur en Y
          move d0,startxr(a4)
          add.w d2,d0           ;nouveau start X / start X reel
          move d0,startx(a4)
          move d1,startyr(a4)
          add.w d3,d1           ;nouveau start Y / start Y reel
          move d1,starty(a4)

          bsr reaffiche       ;va reafficher toutes les fenetres
          bsr recopie         ;recopie sur l'ecran
          clr d0              ;pas d'erreur
          rts

; ACTUALISATION DES PARAMETRES D'ECRITURE d4=flags
actualise:movem d0-d7,-(sp)
          move d4,flags(a4)
          tst mode
          beq.w actulow /* XXX */
          lsr #6,d4          ;recupere PAPER et PEN en HI ou MID resolution
          lsr #6,d4
          move d4,d5
          lsr #2,d4          ;d4 paper
          andi.w #$0003,d5      ;d5 pen
          bra.w actua /* XXX */
actulow:  move d4,d5
          lsr #4,d4
          andi.w #$000f,d4      ;d4 paper
          andi.w #$000f,d5      ;d5 pen
actua:    move d4,d0
          bsr setpaper
          move d5,d0
          bsr setpen
          movem (sp)+,d0-d7
          rts

; EFFACEMENT RAPIDE DE LA FENETRE COURANTE
effenvite:move #1,rapeflag
          move courante,d0
          bra.w effenbis /* XXX */
; EFFACEMENT D'UNE FENETRE
effenetre:clr rapeflag
effenbis: andi.w #$000f,d0
          move.l flagfen,d7
          btst d0,d7
          beq.w error3          ;--->pas ouverte! /* XXX */
          bclr d0,d7          ;Fenetre inhibee
          move.l d7,flagfen
          move d0,tempinit
          mulu #lfenetre,d0   ;calcul de l'adresse de cette fenetre
          lea tfenetre,a4
          add.w d0,a4
; effacement de la copie texte de la memoire
videbuf:  move.l copie(a4),a2 ;entree pour effacement rapide!
          move.l a2,a3
          move txreel(a4),d2
          mulu tyreel(a4),d2
          mulu tcarcopie,d2
          add.w d2,a3
          sub.w d2,topcopie       ;baisse topcopie de la taille enlevee
vide0:    lea tfenetre,a4
          move #nbfenetre-1,d3
          move.l flagfen,d7
vide1:    btst d3,d7            ;fenetre en route? BUG BUG BUG BUG BUG BUG
          beq.w vide3 /* XXX */
          cmp.l copie(a4),a3
          bne.w vide3             ;pas egal: essaie la suivante /* XXX */
          move.l a2,copie(a4)   ;stocke la nouvelle adresse de base
          move txreel(a4),d4
          mulu tyreel(a4),d4
          mulu tcarcopie,d4
          lsr #1,d4
          subq #1,d4            ;taille du buffer transfere
vide2:    move.w (a3)+,(a2)+    ;transfere les copies
          dbra d4,vide2
          move xcursor(a4),d0
          move ycursor(a4),d1
          bsr adresse
          move.l a0,adcopie(a4)
          move.l a1,adecran(a4) ;les adresses sont retablies
          bra.w vide0             ;reexplore toute la table /* XXX */
vide3:    add.l #lfenetre,a4      ;fenetre suivante
          addq #1,d3
          cmpi.w #nbfenetre,d3
          bne.w vide1 /* XXX */
; refait la table des priorites
          lea priofen,a0      ;toutes les fenetres des poids
          move tempinit,d1    ;inferieures a elle sont
          move.b 0(a0,d1.w),d0  ;augmentees de 1
          clr.b 0(a0,d1.w)    ;efface la fenetre de la prioritable
          move #nbfenetre-1,d1
refait1:  tst.b 0(a0,d1.w)
          beq.w refait2 /* XXX */
          cmp.b 0(a0,d1.w),d0
          bge.w refait2 /* XXX */
          /* sub.b #1,0(a0,d1.w) */
          dc.w 0x0430,1,0x1000 /* XXX */
refait2:  dbra d1,refait1
; reaffiche tout l'ecran (sauf si effacement rapide)
          tst rapeflag
          bne.w pasrap /* XXX */
          bsr reaffiche
          bsr recopie
; trouve la fenetre courante
pasrap:   move tempinit,d0
          cmp courante,d0     ;la fenetre courante n'est pas celle
          bne.w finieff         ;qui vient d'etre effacee: on change rien! /* XXX */
          move #1,tempinit
          lea priofen,a0
          clr d0
trouv1:   cmp.b #1,(a0)+
          beq.w trouv2          ;active la fenetre de poids le plus fort! /* XXX */
          addq #1,d0
          cmpi.w #nbfenetre,d0
          blt.w trouv1 /* XXX */
finieff:  clr tempinit
          clr d0              ;pas d'erreur
          rts
; cherche une autre fenetre que la 15!
trouv2:   cmpi.w #15,d0          ;active toute fenetre, SAUF LA 15!!! SYSTEME!!!
          bne actzero
          lea priofen,a0
          clr d0
trouv3:   cmp.b #2,(a0)+      ;on peut activer la # deux!!!
          beq actzero
          addq #1,d0
          cmpi.w #nbfenetre,d0
          blt.w trouv3 /* XXX */
; (peu probable): la fenetre 15 est la seule: active le fond!
          clr d0
          bra.w windon /* XXX */

; ERREURS FENETRES
error1:   move #1,d0    ;Out of range
          bra.w finerr /* XXX */
error2:   move #2,d0    ;Already opened
          bra.w finerr /* XXX */
error3:   move #3,d0    ;Not opened
          bra.w finerr /* XXX */
error4:   move #4,d0    ;Too small window
          bra.w finerr /* XXX */
error5:   move #5,d0    ;Too large window
          bra.w finerr /* XXX */
error6:   move #6,d0    ;Char set not found
          bra.w finerr /* XXX */
error7:   move #7,d0    ;No more text buffer space
          bra.w finerr /* XXX */
finerr:   move.l adcouran,a4  ;reprend l'adresse courante!!!
          rts                 ;fin de la trappe

; GETCOURANTE: RAMENE LE NUMERO DE LA FENETRE COURANTE
gcourante: move courante,d0
          rts

; INITIALISATION DU CURSEUR: A0 POINTE LA TABLE DE DEFINITION
initcurs: move (a0)+,indcurs(a4)        ;vitesse de clignotement/couleur
          moveq #0,d0
initc1:   move.b (a0)+,tabcurs(a4,d0.w)
          addq #1,d0
          cmpi.w #8,d0
          blt.w initc1 /* XXX */
          move #1,cptcurs(a4)
          clr poscurs(a4)
          clr flgcurs(a4)
          move chrysize(a4),d0
          move d0,fcurseur(a4)
          /* subq.w #2,d0 */
          dc.w 0x440,2 /* XXX */
          move d0,dcurseur(a4)
          move #1,curseur(a4)
          rts

; CUR BAS: REMET LE CURSEUR EN BAS
curbas:   move.w chrysize(a4),d0
          move d0,fcurseur(a4)
          subq #2,d0
          move d0,dcurseur(a4)
          rts

; CUR HAUT: GRAND CURSEUR
curhaut:  move.w chrysize(a4),d0
          move d0,fcurseur(a4)
          lsr #1,d0
          addq #1,d0
          move d0,dcurseur(a4)
          rts

; AUTOBACK ON
autobon:  move #1,autoback
          rts

; AUTOBACK OFF
autoboff: move autoback,oldauto
          clr autoback
          rts

; OLD AUTO BACK
ancauto:  move oldauto,autoback
          rts

; GESTION DU CURSEUR: AFFICHE LA COULEUR SUIVANTE
gcurseur: cmp #2,mode         ;pas de flash en COULEURS!
          bne.w fincurs1 /* XXX */
          tst offcur          ;CUROFF!
          bne.w fincurs1 /* XXX */
          tst inhibc          ;la routine est en route!
          bne.w fincurs1 /* XXX */
          movem.l d0/a3-a4,-(sp)
          move.l adcouran,a4  ;pas de curseur sur cette fenetre
          tst curseur(a4)
          beq.w fincurs /* XXX */

          /* subq.w #1,cptcurs(a4) */
          dc.w 0x46c,1,cptcurs /* XXX */
          bne.w fincurs /* XXX */
          move indcurs(a4),cptcurs(a4)
          move poscurs(a4),d0
          addq #1,d0
          cmpi.w #8,d0
          blt.w gcur1 /* XXX */
          clr d0
gcur1:    move d0,poscurs(a4)
          move.b tabcurs(a4,d0.w),d0        ;couleur affichee en ce moment
          bsr affcurs

fincurs:  movem.l (sp)+,d0/a3-a4
fincurs1: rts

; AFFICHAGE/EXTINCTION DU CURSEUR
affcurs:  move #1,inhibc
          movem.l d0-d7/a0-a6,-(sp)

          move dcurseur(a4),d1
          mulu tlecran,d1
          move.l adecran(a4),a1      ;pointe le decor
          move.l ecran.l,d7            ;pointe l'ecran! /* XXX */
          sub.l back,d7              ;difference ECRAN/BACK
          add.w d1,a1           ;a1 adresse du premier octet
          move fcurseur(a4),d6
          sub.w dcurseur(a4),d6
          subq #1,d6          ;d6 indice longueur du curseur
          move nbplan,d5
          subq #1,d5          ;d5 indice nbplans
          move d5,d3
          lsl #1,d3           ;d3 repositionnement premier plan
          lea bufcur(a4),a3   ;a3 buffer stockage caractere sous le curseur
          move chrxsize(a4),d4
          subq #1,d4          ;d4 indice largeur curseur
          move tlecran,a0     ;a0 plus ecran

          tst.b d0
          bmi.w extinct /* XXX */
; allumage du curseur dans la couleur d0
          bsr couleurs        ;a6 pointe sur la table des couleurs
          bclr #31,d5
          tst flgcurs(a4)
          beq.w afcur1 /* XXX */
          bset #31,d5
afcur1:   move d4,d1          ;nouvelle ligne: init cpt X
          move.l a1,a2
          move a2,d2
afcur2:   move d5,d0          ;nouvel octet
          move.l a6,a5
afcur3:   btst #31,d5
          bne.w paspris /* XXX */
          move.b (a2),(a3)+         ;stockage octet sous curseur
paspris:  move.b (a5),(a2)          ;pokage dans le decor
          move.b (a5),0(a2,d7.l)    ;pokage dans l'ecran
          addq #2,a2
          addq #2,a5
          dbra d0,afcur3      ;autre plan?
          bchg #0,d2
          bne.w afcur4 /* XXX */
          sub.w d3,a2
afcur4:   subq #1,a2
          dbra d1,afcur2      ;autre octet en largeur?
          add.w a0,a1
          dbra d6,afcur1      ;autre ligne?
          move #1,flgcurs(a4)
          bra.w fincur /* XXX */
; extinction du curseur
extinct:  tst flgcurs(a4)     ;si deja eteint: on ne fait rien!
          beq.w fincur /* XXX */
excur1:   move d4,d1
          move.l a1,a2
          move a2,d2
excur2:   move d5,d0
excur3:   move.b (a3),(a2)          ;poke dans le decor
          move.b (a3)+,0(a2,d7.l)   ;poke dans l'ecran
          addq #2,a2
          dbra d0,excur3
          bchg #0,d2
          bne.w excur4 /* XXX */
          sub.w d3,a2
excur4:   subq #1,a2
          dbra d1,excur2
          add.w a0,a1
          dbra d6,excur1
          clr flgcurs(a4)

fincur:   movem.l (sp)+,d0-d7/a0-a6
          clr inhibc          ;reautorse la routine d'interruptions.
          rts
;-----------------------------------------------------------------------------
;
;                           
;
;-----------------------------------------------------------------------------

; CALCULE L'ADRESSE DU CURSEUR (D0/D1) DANS LE DECOR ET LA COPIE
adresse:  move d0,d6
          move d1,d7
          tst freelle         ;si fenetre entiere: pas de marge
          bne.w ad1 /* XXX */
          tst bordure(a4)     ;si bordure: ajouter 1 aux marges texte
          beq.w ad1 /* XXX */
          addq #1,d6
          addq #1,d7
ad1:      mulu txreel(a4),d7
          add.w d6,d7
          mulu tcarcopie,d7
          move.l copie(a4),a0
          add.w d7,a0          ;ADRESSE COPIE TEXTE DANS A0

          move freelle,d7
          add.w startx(a4,d7.w),d0
          add.w starty(a4,d7.w),d1
          move d1,d7
          mulu chrysize(a4),d7
          mulu tlecran,d7
          move d0,d6
          mulu chrxsize(a4),d6
          lsr #1,d6
          mulu nbplan,d6
          roxl #1,d6
          add.w d6,d7
          move.l back,a1
          add.w d7,a1          ;ADRESSE BACK DANS A1
          rts

; CALCULE L'ADRESSE DANS LA TABLE DES COULEURS (D0->A6)
couleurs: lea tcouleur,a6
          tst mode
          beq.w cbas /* XXX */
          cmp #1,mode
          beq.w cmoy /* XXX */
          andi.w #$0001,d0
          lsl #6,d0           ;multiplie par 64 (hires)
          /* addq.w #6,d0 */
          dc.w 0x640,6 /* XXX */
          bra.w crien /* XXX */
cmoy:     andi.w #$0003,d0
          lsl #5,d0           ;multiplie par 32 (midres)
          /* addq.w #4,d0 */
          dc.w 0x640,4
          bra.w crien /* XXX */
cbas:     andi.w #$000f,d0
          lsl #3,d0           ;multiplie par 8 (lowres)
crien:    add.w d0,a6
          move flags(a4),d0   ;teste si c'est ombre...
          btst #11,d0
          beq.w finc /* XXX */
          add.w #128,a6
finc:     rts

; ssprg: CLEAR UN CARRE D0/D1-D2/D3 DANS L'ECRAN !!!
effecran: bsr adresse
          move.l adpaper(a4),a6
          move flags(a4),d4
          btst #10,d4             ;a6 pointe sur la table couleurs
          beq.w effac3 /* XXX */
          move.l adpen(a4),a6     ;INVERSE!

effac3:   movem d0-d3,-(sp)       ;sauve les donnees pour l'effacement copie
          clr.l d4
          move d2,d4
          mulu chrxsize(a4),d4    ;d4 compteur en X
          move d4,d0
          mulu nbplan,d0
          cmp tlecran,d0
          beq efrapide            ;SUPER! EFFACEMENT RAPIDE!

          move a1,d0
          move d0,d1
          add.w d4,d1
          btst #0,d0
          beq.w effac1 /* XXX */
          bset #31,d4         ;flag gauche: #31 de d4
          subq #1,d4
effac1:   btst #0,d1
          beq.w effac2 /* XXX */
          bset #30,d4         ;flag droite: #30 de d4
          subq #1,d4
effac2:   lsr #1,d4
          subq #1,d4          ;compteur milieu: d4/d5

          move chrysize(a4),a5
          subq #1,a5          ;a5/d2 compteur YSIZE
          move nbplan,d1
          subq #1,d1          ;d1: nbplan
          subq #1,d3          ;d3: compteur nb caractere en Y
          move tlecran,d6     ;d6: plus ecran
          move txtext(a4),d7
          subq #1,d7          ;d7: compteur txtext

eff1:     move a5,d2          ;nouveau caractere en Y: compteur hauteur
eff2:     move d4,d5          ;nouvelle ligne ecran: compteur milieu
          move.l a1,a3
; effacement octet de gauche
          btst #31,d4
          beq.w efmilieu /* XXX */
          move d1,d0          ;compteur plans
          move.l a6,a2        ;couleurs
eff3:     move.b (a2),(a3)    ;effacement ecran
          addq #2,a2
          addq #2,a3
          dbra d0,eff3        ;autre plan?
          subq #1,a3          ;retabli l'adresse
; effacement rapide du milieu
efmilieu: tst d4
          bmi.w efdroite /* XXX */
eff5:     move d1,d0          ;compteur plans
          move.l a6,a2        ;couleurs
eff6:     move.w (a2)+,(a3)+
          dbra d0,eff6        ;autre plan?
          dbra d5,eff5
; effacement octet de droite
efdroite: btst #30,d4
          beq.w effin /* XXX */
          move d1,d0          ;compteur plans
          move.l a6,a2        ;couleurs
eff7:     move.b (a2),(a3)
          addq #2,a2
          addq #2,a3
          dbra d0,eff7

effin:    add.w d6,a1
          dbra d2,eff2

          dbra d3,eff1        ;encore une ligne?
          bra.w sorteff /* XXX */

; effacement rapide: genial
efrapide: move d3,d0
          mulu tlecran,d0
          mulu chrysize(a4),d0
          lsr #3,d0
          subq #1,d0          ;d0 compteur effacement ecran
          tst mode
          beq.w efrbas
          cmp #1,mode
          beq.w efrmoy /* XXX */
          move (a6),d6        ;couleurs haute resolution
          swap d6
          move (a6),d6
          move.l d6,d7
          bra.w effrap1 /* XXX */
efrmoy:   move.l (a6),d6      ;couleurs moyenne resolution
          move.l d6,d7
          bra.w effrap1 /* XXX */
efrbas:   move.l (a6)+,d6     ;couleurs basse resolution
          move.l (a6),d7

effrap1:  move.l d6,(a1)+
          move.l d7,(a1)+
          dbra d0,effrap1

sorteff:  movem (sp)+,d0-d3
          rts

; ssprg: EFFACEMENT DE LA COPIE!
effcopie: subq #1,d3          ;d3 compteur en Y
          subq #1,d2          ;d2/d5 compteur en x
          move txreel(a4),d4
          mulu tcarcopie,d4   ;d4 plus copie
          tst mode
          beq.w efcop3 /* XXX */
; eff copie en HI et MID resolution: par MOTS!
          move flags(a4),d0
          andi.w #$ff00,d0
          addi.w #32,d0          ;32 code blanc
efcop1:   move d2,d5          ;nouvelle ligne
          move.l a0,a2
efcop2:   move.w d0,(a2)+
          dbra d5,efcop2
          add.w d4,a0
          dbra d3,efcop1
          bra.w fineff /* XXX */
; eff copie en LOW resolution: travaille par MOTS LONGS!
efcop3:   move.l flags(a4),d0
          andi.l #$ffff0000,d0
          addi.w #32,d0
efcop4:   move d2,d5          ;nouvelle ligne
          move.l a0,a2
efcop5:   move.l d0,(a2)+
          dbra d5,efcop5
          add.w d4,a0
          dbra d3,efcop4
fineff:   rts

; CLEAR LIGNE D1
cligne:   movem.l d0-d7/a0-a6,-(sp)
          move d1,-(sp)
          move txtext(a4),d2
          clr d0
          moveq #1,d3
          bsr effecran
          bsr effcopie
          move (sp)+,d1
          bsr.w endline         ;met un 255 au bout! /* XXX */
          bsr recopie
          movem.l (sp)+,d0-d7/a0-a6
          rts

; CLEAR SCREEN
clears:   movem.l d0-d7/a0-a6,-(sp)
          move txtext(a4),d2
          move tytext(a4),d3
          clr d0
          clr d1
          bsr effecran
          bsr effcopie
; ecris la ligne de 255 verticale
          clr d1
clears1:  bsr.w endline /* XXX */
          addq #1,d1
          cmp tytext(a4),d1
          bne.w clears1 /* XXX */
          bsr haume
          bsr recopie
          movem.l (sp)+,d0-d7/a0-a6
          rts

; END LINE: MET UN 255 AU BOUT DE LA LIGNE D1 DANS LA COPIE 
endline:  move d1,-(sp)
          move txtext(a4),d0
          subq #1,d0
          bsr adresse
          tst mode
          beq.w endllow /* XXX */
          move.w flags(a4),d1
          andi.w #$ff00,d1
          ori.b #255,d1
          move.w d1,(a0)
          move (sp)+,d1
          rts
endllow:  move.w flags(a4),d1
          swap d1
          clr d1
          ori.b #255,d1
          move.l d1,(a0)
          move (sp)+,d1
          rts

; LOCATE D0,D1
laucate:  cmp txtext(a4),d0
          bcc.w sorti /* XXX */
          cmp tytext(a4),d1
          bcc.w sorti /* XXX */
          bsr curxy
          clr d0                  ;pas d'erreur
          rts     
sorti:    move #1,d0
          rts

curxy:    move d0,xcursor(a4)
          move d1,ycursor(a4)
          bsr adresse
          move.l a0,adcopie(a4)
          move.l a1,adecran(a4)   ;adresses absolues du curseur
          rts

;POSCURSEUR: RAMENE LA POSITION DU CURSEUR EN D0.L
coordcurs:move xcursor(a4),d0
          swap d0
          move ycursor(a4),d0
          rts

; XGRAPHIC: COORD CURS X ---> COORDS GRAPHIC
xgraphic: cmp txtext(a4),d0             ;ramene -1 si sort
          bcc.w cxgr1 /* XXX */
          add.w startx(a4),d0
          mulu chrxsize(a4),d0
          lsl #3,d0
          rts

; YGRAPHIC: COORD CURS Y ---> COORDS GRAPHIC
ygraphic: cmp tytext(a4),d0             ;ramene -1 si sort
          bcc.w cxgr1 /* XXX */
          add.w starty(a4),d0
          mulu chrysize(a4),d0
          rts

; XTEXT: TRANSFORME UNE POSITION GRAPHIQUE X(d0) EN COORDONNEE CURSEUR
xtext:    move.w startx(a4),d1
          move.w d1,d2
          add.w txtext(a4),d2
          lsl #3,d1
          mulu chrxsize(a4),d1          ;debut (0-639) de la fenetre
          lsl #3,d2
          mulu chrxsize(a4),d2          ;fin graphique de la fenetre
          cmp.w d2,d0
          bcc.w cxgr1 /* XXX */
          sub.w d1,d0
          bcs.w cxgr1 /* XXX */
          lsr #3,d0
          divu chrxsize(a4),d0
          andi.l #$ffff,d0
          rts
cxgr1:    moveq #-1,d0
          rts

; YTEXT: TRANSFORME UNE POSITION GRAPHIQUE (Y) EN COORDONNEE CURSEUR
ytext:    move.w starty(a4),d1
          move.w d1,d2
          add.w tytext(a4),d2
          mulu chrysize(a4),d1          ;debut (0-639) de la fenetre
          mulu chrysize(a4),d2          ;fin graphique de la fenetre
          cmp.w d2,d0
          bcc.w cxgr1 /* XXX */
          sub.w d1,d0
          bcs.w cxgr1 /* XXX */
          divu chrysize(a4),d0
          andi.l #$ffff,d0               ;enleve le reste!
          rts

; HOME
haume:    clr d0
          clr d1
          bra curxy

; ROUTINE DE SCROLLING uniquement pour l'interieur d'une fenetre
scrolling:movem.l d0-d6/a0,-(sp)

          clr.l d4            ;RAZ des flags debut/fin ligne
          move txtext(a4),d4
          mulu chrxsize(a4),d4    ;d4 compteur en X
          move d4,d0
          mulu nbplan,d0
          cmp tlecran,d0
          beq scrapide        ;SCROLLING RAPIDE: super

          move a1,d0
          move d0,d1
          add.w d4,d1
          btst #0,d0          ;test GAUCHE
          beq.w scrll1 /* XXX */
          bset #31,d4         ;flag: demarre sur impair
          subq #1,d4          ;un octet en moins au milieu
scrll1:   btst #0,d1          ;test DROITE
          beq.w scrll2 /* XXX */
          bset #30,d4         ;flag: fin sur pair
          subq #1,d4
scrll2:   lsr #1,d4           ;travaille par mots: /2
          subq #1,d4

          move chrysize(a4),a5
          subq #1,a5          ;a5/d1 compteur hauteur caractere
          subq #1,d5          ;compteur nombre de lignes
          move nbplan,a6
          subq #1,a6          ;indice nbplan: a6, cpt en d0
          move txtext(a4),a2  ;indice txtext: a2
          move d4,a4          ;a4 indice en X milieu

scrl1:    move a5,d1          ;nouveau caractere: compteur hauteur caractere
scrl2:    move a4,d4          ;nouvelle ligne: compteur milieu ligne
          move.l a1,a3        ;actualisation adresse dans l'ecran
          lea 0(a3,d3.w),a0
; transfert octet de gauche
          btst #31,d4
          beq.w scmilieu /* XXX */
          move a6,d0          ;compteur plans
scrl3:    move.b (a0),(a3) ;transfert dans l'ecran
          addq #2,a0
          addq #2,a3
          dbra d0,scrl3       ;autre plan?
          subq #1,a0
          subq #1,a3          ;retablissement au premier plan suivant
; transfert rapide du milieu
scmilieu: tst d4
          bmi.w scdroite /* XXX */
scrl5:    move a6,d0          ;compteur plans
scrl6:    move.w (a0)+,(a3)+
          dbra d0,scrl6       ;autre plan?
          dbra d4,scrl5       ;autre mot?
; transfert octet de droite
scdroite: btst #30,d4
          beq.w finsc /* XXX */
          move a6,d0
scrl7:    move.b (a0),(a3)
          addq #2,a0
          addq #2,a3
          dbra d0,scrl7

finsc:    add.w d7,a1
          dbra d1,scrl2       ;autre ligne? fini la hauteur d'un caractere

          dbra d5,scrl1       ;autre caractere? fini le scrolling
          bra.w scrollcop /* XXX */

; SCROLLING RAPIDE: GENIAL!
scrapide: mulu tlecran,d5
          mulu chrysize(a4),d5
          lsr #2,d5
          subq #1,d5          ;d5: compteur scroll ecran
          tst d3
          bmi.w scrbs /* XXX */
; scrolling rapide vers le haut
          lea 0(a1,d3.w),a3
scrht1:   move.l (a3)+,(a1)+
          dbra d5,scrht1
          bra.w scrollcop /* XXX */
; scrolling rapide vers le bas
scrbs:    add.w tlecran,a1
          lea 0(a1,d3.w),a3
scrbs1:   move.l -(a3),-(a1)
          dbra d5,scrbs1

; SCROLLING DANS LA COPIE
scrollcop:movem.l (sp)+,d0-d6/a0  ;recupere les donnees
          move.l adcouran,a4      ;adresse de la fenetre courante
          move txtext(a4),d7
          subq #1,d7              ;d7 indice en X
          subq #1,d5              ;d5 compteur en Y
          tst mode
          beq.w scrcop3 /* XXX */
scrcop1:  move d7,d4              ;HI et MID res: mot
          move.l a0,a2
scrcop2:  move.w 0(a2,d2.w),(a2)+
          dbra d4,scrcop2
          add.w d6,a0
          dbra d5,scrcop1
          bra.w finscroll /* XXX */
scrcop3:  move d7,d4              ;LOW res: mot long
          move.l a0,a2
scrcop4:  move.l 0(a2,d2.w),(a2)+
          dbra d4,scrcop4
          add.w d6,a0
          dbra d5,scrcop3

finscroll:rts

; SCROLLING VERS LE HAUT A PARTIE DE LA LIGNE D1
scrollht: movem.l d0-d7/a0-a6,-(sp)
          /* cmp #0,d1           ;une seule ligne: pas de scrolling... */
          dc.w 0xc41,0 /* XXX */
          beq.w finscrl /* XXX */
          move d1,d5          ;nombre de caractere en Y
          clr d0
          clr d1
          bsr adresse
          move txreel(a4),d2
          mulu tcarcopie,d2   ;decalage copie
          move d2,d6          ;plus copie|
          move tlecran,d3     ;          |=> explore de haut en bas
          move d3,d7          ;plus ecran|
          mulu chrysize(a4),d3   ;decalage ecran

          bsr scrolling

finscrl:  movem.l (sp)+,d0-d7/a0-a6
          bsr cligne          ;effacement de la ligne du curseur
          rts

; SCROLLING VERS LE BAS A PARTIR DE LA LIGNE D1
scrollbs: movem.l d0-d7/a0-a6,-(sp)
          move tytext(a4),d5
          sub.w d1,d5
          subq #1,d5          ;nombre de caractere a scroller en Y
          beq.w finscrl         ;une seule ligne: pas de scroll /* XXX */
          clr d0
          move tytext(a4),d1
          bsr adresse
          move txreel(a4),d2
          mulu tcarcopie,d2   ;tlcopie en d2
          sub.w d2,a0
          sub.w tlecran,a1
          neg d2              ;decalage copie 
          move d2,d6          ;plus copie|
          move tlecran,d3     ;          |=> explore l'ecran de bas
          move d3,d7          ;          |   en haut
          neg d7              ;plus ecran|
          mulu chrysize(a4),d3
          neg d3              ;decalage ecran

          bsr scrolling

          bra.w finscrl /* XXX */

; CURSEUR VERS DROITE
droite:   move xcursor(a4),d0
          move freelle,d1
          addq #1,d0
          cmp txtext(a4,d1.w),d0
          beq.w drt1 /* XXX */
          move ycursor(a4),d1
          bra curxy
drt1:     bsr alaligne        ;scroll vers le haut
          bra.w bas

; CURSEUR VERS GAUCHE
gauche:   move xcursor(a4),d0
          beq.w gch1 /* XXX */
          move ycursor(a4),d1
          subq #1,d0
          bra curxy
gch1:     move txtext(a4),d0
          subq #1,d0
          move d0,xcursor(a4)
          bra.w haut /* XXX */

; CURSEUR VERS LE HAUT
haut:     move xcursor(a4),d0
          move ycursor(a4),d1
          beq.w haut1
          subq #1,d1
          bra curxy
haut1:    tst scrollup(a4)
          bne scrollbs
          move tytext(a4),d1
          subq #1,d1
          bra curxy

; CURSEUR VERS LE BAS
bas:      move freelle,d0
          move ycursor(a4),d1
          addq #1,d1
          cmp tytext(a4,d0.w),d1
          beq.w bas1 /* XXX */
          move xcursor(a4),d0
          bra curxy
bas1:     tst scrollup(a4)    ;scrolling autorse?
          beq.w bas2 /* XXX */
          subq #1,d1
          bra scrollht
bas2:     move xcursor(a4),d0
          clr d1
          bra curxy

; CURSEUR A LA LIGNE
alaligne: clr d0
          move ycursor(a4),d1
          bra curxy

; RETURN
return:   bsr alaligne
          bra.w bas /* XXX */

; ARRET CURSEUR/CUROFF
arretcur: clr.w curseur(a4)
curoff:   tst offcur
          bmi.w cof1 /* XXX */
          move #1,offcur      ;flag CUROFF: n'affiche plus!
          move.l d0,-(sp)
          move.b #$ff,d0
          bsr affcurs
          move.l (sp)+,d0
cof1:     rts

; MARCHE CURSEUR/CURON
marchcur: move #1,curseur(a4)
curon:    tst curseur(a4)     ;si arrete, ne le remet pas!!!
          beq.w cof1 /* XXX */
          clr offcur
          move #1,cptcurs(a4)
          cmp #2,mode         ;si mode 2: reaffiche par les interruptions
          beq.w cof1 /* XXX */
          move.l d0,-(sp)
          move indcurs(a4),d0
          bsr affcurs
          move.l (sp)+,d0
          rts

; INVERSE
inverse:  move flags(a4),d0
          bset #10,d0
          move d0,flags(a4)
          rts

; NORMAL
normal:   move flags(a4),d0
          bclr #10,d0
          move d0,flags(a4)
          rts

; OMBRE ON
ombreon:  move flags(a4),d0
          bset #11,d0
          move d0,flags(a4)
ombre:    move pen(a4),d0
          bsr couleurs
          move.l a6,adpen(a4)
          move paper(a4),d0
          bsr couleurs
          move.l a6,adpaper(a4)
          rts

; OMBRE OFF
ombreoff: move flags(a4),d0
          bclr #11,d0
          move d0,flags(a4)
          bra.w ombre /* XXX */

; SOULIGNE OFF
soulon:   move flags(a4),d0
          bset #9,d0
          move d0,flags(a4)
          rts

; SOULIGNE ON
souloff:  move flags(a4),d0
          bclr #9,d0
          move d0,flags(a4)
          rts

; PEN
setpen:   move d0,pen(a4)
          move d0,d7
          tst mode
          beq.w penlow /* XXX */
          andi.w #$0003,d7
          lsl #6,d7
          lsl #6,d7
          andi.w #%1100111111111111,flags(a4)
          bra.w finpen /* XXX */
penlow:   andi.w #$fff0,flags(a4)
          andi.w #$000f,d7
finpen:   or.w d7,flags(a4)
          bsr couleurs
          move.l a6,adpen(a4)
          rts

; PAPER
setpaper: move d0,paper(a4)
          move d0,d7
          tst mode
          beq.w paperlow /* XXX */
          andi.w #$0003,d7
          lsl #7,d7
          lsl #7,d7
          andi.w #%0011111111111111,flags(a4)
          bra.w finpaper /* XXX */
paperlow: andi.w #$ff0f,flags(a4)
          lsl #4,d7
          andi.w #$00f0,d7
finpaper: or.w d7,flags(a4)
          bsr couleurs
          move.l a6,adpaper(a4)
          rts

; WRITING
wrt1:     clr d0
          bra.w wrt /* XXX */
wrt2:     moveq #1,d0
          bra.w wrt /* XXX */
wrt3:     moveq #2,d0
wrt:      move d0,writing(a4)
          rts

; AFFICHAGE DEROULANT
scrollon: move #1,scrollup(a4)
          rts

; AFFICHAGE PAGE PAR PAGE
scrolloff:clr scrollup(a4)
          rts

; SCREEN: ramene le caractere sous d0/d1 en d0 et flags en d4
cscreen:  move xcursor(a4),d0
          move ycursor(a4),d1
          bra.w screen /* XXX */
tstscreen:cmp txtext(a4),d0
          bge.w scrn2 /* XXX */
          cmp tytext(a4),d1
          bge.w scrn2 /* XXX */
screen:   bsr adresse
          clr d0
          tst mode
          beq.w scrn1 /* XXX */
          move.w (a0),d4
          move.b d4,d0
          andi.w #$ff00,d4       ;cretin!
          cmpi.b #32,d0        ;filtre les codes d'icones
          bcc.s scrn0
          move.b #32,d0
scrn0:    rts
scrn1:    move.l (a0),d4
          move.b d4,d0
          swap d4
          cmpi.b #32,d0        ;filtre les codes d'icones
          bcc.s scrn0
          move.b #32,d0
          rts
scrn2:    move #-1,d0         ;erreur: sorti de la fenetre
          rts

; GETCHAR: RAMENE L'ADRESSE D'UN JEU DE CARACTERE
getchar:  andi.w #$f,d0
          lsl #2,d0
          lea adjeux,a0
          move.l 0(a0,d0.w),d0  ;prend son adresse
          beq.w getch1 /* XXX */
          subq.l #4,d0          ;pointe le code de reconnaissance!
getch1:   rts

; SET CHAR (xx): INITIALISE UN JEU DE CARACTERES: #=d0/ad=a0
setchar:  andi.w #$f,d0
          beq.w setchar1        ;pas les jeux systeme! /* XXX */
          cmpi.w #1,d0
          beq.w setchar1 /* XXX */
          lsl #2,d0
          lea adjeux,a1
          clr.l 0(a1,d0.w)
          cmpi.l #$06071963,(a0)+
          bne.w setchar1 /* XXX */
          move.l a0,0(a1,d0.w)
setchar1: rts

; DELETE
delete:   move xcursor(a4),-(sp)
          move ycursor(a4),-(sp)
          move flags(a4),d5
          move d5,-(sp)
          move scrollup(a4),-(sp)
          clr scrollup(a4)
          clr writing(a4)
          bsr cscreen         ;on ne peut relier des lignes
          cmpi.b #255,d0       ;avec DELETE ou BACKSPACE
          beq.w depile /* XXX */
del0:     bsr droite
          tst xcursor(a4)               ;securite si plus de 255!
          bne.w del0a /* XXX */
          tst ycursor(a4)
          beq.w del2 /* XXX */
del0a:    bsr cscreen
          cmpi.b #255,d0
          beq.w del2 /* XXX */
          move d0,-(sp)
          bsr gauche
          cmp d4,d5
          beq.w del1 /* XXX */
          bsr actualise
          move d4,d5
del1:     move (sp)+,d0
          bsr chrout
          bra.w del0 /* XXX */
del2:     bsr gauche
          move.b #32,d0
          bsr chrout
depile:   move (sp)+,scrollup(a4)
          move (sp)+,d4
          bsr actualise
          move d4,flags(a4)
          move (sp)+,d1
          move (sp)+,d0
          bsr curxy
          rts

; BACKSPACE
backspace:tst xcursor(a4)               ;pas en haut a gauche de l'ecran!
          bne.w back1 /* XXX */
          tst ycursor(a4)
          beq.w back2 /* XXX */
back1:    bsr gauche
          bsr cscreen                   ;on ne peut pas relier deux
          cmpi.b #255,d0                 ;lignes avec BACKSPACES!
          bne.w delete /* XXX */
          bsr droite
back2:    rts

; EFFACEMENT JUSQU'A LA FIN DE LA LIGNE
finligne: move xcursor(a4),-(sp)
          move ycursor(a4),-(sp)
          move flags(a4),-(sp)
          move scrollup(a4),-(sp)
          bsr normal
          bsr ombreoff
          clr writing(a4)
          clr scrollup(a4)
efl1:     bsr cscreen
          cmpi.b #255,d0
          beq.w depile /* XXX */
          move.b #32,d0
          bsr chrout
          bra.w efl1 /* XXX */

; FIXE LA TAILLE DU CURSEUR d0= haut, d1= bas, d2= vitesse si hires
fixcursor:cmp d0,d1
          bls.w fix1 /* XXX */
          cmp chrysize(a4),d1
          bhi.w fix1 /* XXX */
          move d0,dcurseur(a4)
          move d1,fcurseur(a4)
fix1:     cmpi.w #2,mode                   ;pas de vitesse si LOW/MID res!
          bne.w fix2 /* XXX */
          tst d2
          beq.w fix2 /* XXX */
          andi.w #$ff,d2
          move d2,indcurs(a4)
fix2:     rts

; AUTOINS: AFFICHE D0 APRES AVOIR INSERE UN CARACTERE
autoins:  move txtext(a4),d1
          subq #1,d1
          cmp xcursor(a4),d1
          bne.w oto1 /* XXX */
          move tytext(a4),d1
          subq #1,d1
          cmp ycursor(a4),d1
          beq.w oto2 /* XXX */
; fait un INSERE!
oto1:     move d0,-(sp)
          bsr insere
          move (sp)+,d0
          bra chrout
; tout en bas a droite!
oto2:     tst scrollup(a4)
          bne chrout          ;si scrolling en route: CHROUT (fait un scroll)
          bra.w oto1            ;si non: fait un INSERE! /* XXX */

; INSERTION D'UN CARACTERE
insere:   move xcursor(a4),d2
          move ycursor(a4),d3
          move flags(a4),d5
          move d5,-(sp)
          clr writing(a4)
          bsr cscreen
          cmpi.b #255,d0
          bne.s ins0a 
; curseur sur la fin d'une ligne
          move #32,d0
          bsr inscroll
          bra.w ins5 /* XXX */
; cherche la fin de la ligne
ins0:     bsr cscreen                   ;trouve la fin de la ligne
          cmpi.b #255,d0
          beq.s ins1
ins0a:    bsr droite
          tst xcursor(a4)
          bne.s ins0
          tst ycursor(a4)
          bne.s ins0
          bra.w ins5 /* XXX */
; FIN TROUVEE: fait un scrolling ???
ins1:     bsr gauche
          bsr cscreen
          cmpi.b #32,d0                  ;si rien a gauche du marqueur
          beq.s ins2                      ;pas de scrolling
          move d0,-(sp)
          bsr droite
          move (sp)+,d0
          bsr inscroll
          bsr gauche
; BOUGE LE RESTE DE LA LIGNE
ins2:     tst xcursor(a4)               ;securite si plus de 255!
          bne.s ins2a
          tst ycursor(a4)
          beq.s ins5
ins2a:    cmp xcursor(a4),d2
          bne.s ins3
          cmp ycursor(a4),d3
          beq.s ins5
ins3:     bsr gauche
          bsr cscreen
          move d0,-(sp)
          bsr droite
          cmp d4,d5
          beq.s ins4
          bsr actualise
          move d4,d5
ins4:     move (sp)+,d0
          bsr chrout
          bsr gauche
          bsr gauche
          bra.w ins2 /* XXX */
; fin de l'insertion: efface le caractere sous le curseur
ins5:     move (sp)+,d4
          move d4,flags(a4)
          bsr actualise
          move #32,d0
          bsr chrout
          bsr gauche
          rts

; SSPGM: INSERCROLL, ecris la lettre, fait un scrolling, remet sur la lettre
inscroll: move d0,-(sp)
          cmp d4,d5
          beq.w insc1 /* XXX */
          bsr actualise
          move d4,d5
insc1:    move (sp)+,d6
          move xcursor(a4),d0
          move ycursor(a4),d1
          movem d0-d3,-(sp)
          move txtext(a4),d2            ;si tout en bas a droite,
          subq #1,d2
          cmp d2,d0
          bne.w insc1a /* XXX */
          move tytext(a4),d3            ;un simple CHROUT suffit!
          subq #1,d3
          cmp d3,d1
          beq.w insc3 /* XXX */
insc1a:   move d6,d0
          bsr chrout
          move tytext(a4),d0
          lsr #1,d0
          cmp d0,d1
          bcc.w insc2 /* XXX */
; LIGNE DU HAUT: fait un scrolling vers le bas
          addq #1,d1
          bsr scrollbs
          movem (sp)+,d0-d3
          bsr curxy
          rts
; LIGNE DU BAS: fait un scrolling vers le haut
insc2:    bsr scrollht
insc2a:   movem (sp)+,d0-d3
          subq #1,d1          ;remonte d'une ligne!!!
          subq #1,d3          ;remonte aussi l'arret!!!
          bsr curxy
          rts
; TOUT EN BAS A DROITE!
insc3:    move d6,d0
          bsr chrout
          bra.w insc2a /* XXX */

; JOIN: joint deux "lignes"
join:     move xcursor(a4),-(sp)
          move ycursor(a4),-(sp)
join0:    move txtext(a4),d0
          subq #1,d0
          cmp xcursor(a4),d0
          bne.w join1 /* XXX */
          move tytext(a4),d1
          subq #1,d1
          cmp ycursor(a4),d1
          beq.w join5 /* XXX */
join1:    bsr cscreen
          cmpi.b #255,d0
          beq.w join2 /* XXX */
          bsr droite
          bra.w join0 /* XXX */
join2:    move.w #32,d0
          bsr chrout
join5:    move.w (sp)+,d1
          move.w (sp)+,d0
          bsr curxy
          rts

; CURSEUR VERS LA DROITE RAPIDE
qdroite:  bsr droite
          bsr tests
          bne.w qdroite /* XXX */
          rts

; CURSEUR VERS LA GAUCHE RAPIDE
qgauche:  bsr gauche
          bsr tests
          bne.w qgauche /* XXX */
          rts

; TESTS: ARRET DU CURSEUR?
tests:    bsr cscreen
          tst.b d0            ;>128
          bmi.w staup /* XXX */
          cmpi.b #48,d0        ;<48: stop
          blt.w staup /* XXX */
          cmpi.b #58,d0        ;<58:chiffre
          blt.w cont /* XXX */
          cmpi.b #65,d0        ;<65:stop
          blt.w staup /* XXX */
          cmpi.b #91,d0        ;<91:majuscule
          blt.w cont /* XXX */
          cmpi.b #97,d0        ;<97:stop
          blt.w staup /* XXX */
          cmpi.b #123,d0       ;<123:minuscule
          blt.w cont /* XXX */
staup:    clr.w d0
          rts
cont:     move.w #1,d0
          rts

; GETBUFFER: REMPLIT LE BUFFER EN A0, LONGUEUR D0 CARACTERES
getbuffer:move scrollup(a4),-(sp)  ; met un zero a la fin
          clr scrollup(a4)
          move.l a0,a2
          move.l a0,a3
          move d0,d2
          subq #2,d2
get2:     tst xcursor(a4)          ;securite en haut a gauche!
          bne.w get3 /* XXX */
          tst ycursor(a4)
          beq.w get5b /* XXX */
get3:     bsr gauche
          bsr cscreen
          cmpi.b #255,d0
          bne.w get2 /* XXX */
get4:     move txtext(a4),d0       ;securite en bas a droite!
          subq #1,d0
          cmp xcursor(a4),d0
          bne.w get5a /* XXX */
          move tytext(a4),d0
          subq #1,d0
          cmp ycursor(a4),d0
          beq.w get6 /* XXX */
get5a:    bsr droite
get5b:    bsr cscreen
          cmpi.b #255,d0
          beq.w get6 /* XXX */
          move.b d0,(a2)+
          cmpi.b #32,d0
          beq.w get5c /* XXX */
          move.l a2,a3                  ;dernier NON BLANC!
get5c:    dbra d2,get4
get5:     move.l a2,d2
          sub.l a3,d2                   ;nombre de caracteres significatifs
          bne.w get6 /* XXX */
          move #1,d0
          bra.w get7 /* XXX */
get6:     clr d0
get7:     clr.b (a3)                    ;arrete au dernier NON BLANC!
          move (sp)+,scrollup(a4)
          rts

; BOX: BORDER D0, TX/D1, TY/D2 
box:      move d1,d4
          move d2,d5
          subq #3,d4
          subq #3,d5
          lea tbords,a2
          subq #1,d0
          lsl #3,d0
          add.w d0,a2
          move.b (a2),d0      ;coin superieur gauche
          bsr chrout
          move.b 1(a2),d0     ;dessus
          move d4,d3
box1:     bsr chrout
          dbra d3,box1
          move.b 2(a2),d0     ;coin superieur droit
          bsr chrout
          move d5,d3
box2:     bsr gauche          ;ligne droite
          bsr bas
          move.b 4(a2),d0
          bsr chrout
          dbra d3,box2
          bsr gauche
          bsr bas
          move.b 7(a2),d0     ;coin inferieur droit
          bsr chrout
box3:     bsr gauche
          bsr gauche
          move.b 6(a2),d0     ;ligne inferieure
          bsr chrout
          dbra d4,box3
          bsr gauche
          bsr gauche
          move.b 5(a2),d0     ;coin inferieur gauche
          bsr chrout
box4:     bsr gauche
          bsr haut
          move.b 3(a2),d0     ;ligne gauche
          bsr chrout
          dbra d5,box4
          rts          

; TITLE A0: ECRIS UNE CHAINE SUR LA LIGNE DU HAUT D'UNE FENETRE
title:    tst bordure(a4)
          beq.w titlerr         ;pas de tour a cette fenetre! /* XXX */
          move #8,freelle
          move.w xcursor(a4),-(sp)
          move.w ycursor(a4),-(sp)
          move.l a0,-(sp)
          bsr haume
          move.l (sp)+,a0
          bsr centrage        ;affiche la chaine en la centrant
          clr freelle         ;retour a la normale
          move.w (sp)+,d1
          move.w (sp)+,d0
          bsr curxy           ;remet le curseur ou il etait
title5:   clr.l d0
          rts
titlerr:  moveq #1,d0
          rts

;CENTRAGE: ECRIS UNE CHAINE EN LA CENTRANT
centrage: move.l a0,a2
          move.l a0,a1
          clr d1
cent1:    move.b (a1)+,d0
          beq.w cent2 /* XXX */
          cmpi.b #32,d0
          bcs.w cent1 /* XXX */
          addq #1,d1
          bra.w cent1 /* XXX */
cent2:    tst freelle
          beq.w cent3 /* XXX */
          move txreel(a4),d0
          bra.w cent4 /* XXX */
cent3:    move txtext(a4),d0
cent4:    sub.w d1,d0
          bcs.w prtstring /* XXX */
          lsr #1,d0
          move ycursor(a4),d1
          bsr curxy
          move.l a2,a0

;PRINT STRING: ECRIS LA CHAINE DE CARACTERES POINTEE PAR A0
prtstring: move.b (a0)+,d0
          beq.w prt1 /* XXX */
          bsr.w chrout /* XXX */
          bra.w prtstring /* XXX */
prt1:     rts

; IMPRESSION D'UN CARACTERE SUR LE DECOR SUPER, INTERCEPTE LES ICONES!!!
chrdec:   movem.l d0-d7/a0-a6,-(sp)
          clr.l d6
          bra.w chr0 /* XXX */
; IMPRESSION D'UN CARACTERE SUR LES DEUX ECRANS
chrout:   movem.l d0-d7/a0-a6,-(sp)
          move.l ecran.l,d6 /* XXX */
          sub.l back,d6        ;difference entre ecran LOGIQUE et BACK
chr0:     move.l adcouran,a4   ;a4 pointe sur la fenetre courante!
          andi.w #$00ff,d0

          cmpi.b #32,d0
          bcc.w pascont /* XXX */
; CARACTERES DE CONTROLE
          tst escape
          bne.s chr5
          move d0,d2          ;sauve le code pour ESCAPE
          lsl #2,d0
          lea controle,a0     ;table des adresse des routines
          add.w d0,a0
          tst.l (a0)
          beq.w sortie          ;pas implement‚e /* XXX */
          move.l (a0),a1
          move xcursor(a4),d0
          move ycursor(a4),d1
          clr escape
          jsr (a1)
          bra.w sortie /* XXX */

; AFFICHE UNE ICONE POUR LA PREMIERE FOIS
chr5:     bsr afficon              ;va afficher!
          clr escape               ;poke dans la copie, si rien a afficher,
escbis:   move.l adcopie(a4),a0    ;c'est pas grave!!!
          tst mode
          beq.w chr6 /* XXX */
          move.w flags(a4),d1
          clr.b d1
          or.b d0,d1
          move.w d1,(a0)
          bra.w finaff /* XXX */
chr6:     move.w flags(a4),d1
          swap d1
          clr d1
          or.b d0,d1
          move.l d1,(a0)
          bra finaff               ;curseur a droite, et revient

; STOCKAGE DU CARACTERE DANS LA COPIE
pascont:  tst escape
          bne.s chr5
          move.l adcopie(a4),a0
          tst mode
          beq.w stocklow /* XXX */
          move.w flags(a4),d1           ;HI et MID res: copie sur MOT
          clr.b d1
          or.b d0,d1
          move.w d1,(a0)
          bra.w affcar /* XXX */
stocklow: move.w flags(a4),d1           ;LOW res: copie sur MOT LONG!
          swap d1
          clr d1
          or.b d0,d1
          move.l d1,(a0)

; AFFICHAGE DU CARACTERE D0 A L'ECRAN
affcar:   /* move.l adjeucar(a4),a0 */
		  dc.w 0x206c,adjeucar /* XXX */
          move.b 4(a0,d0.w),d0  ;charge adresse du caractere a afficher
          mulu chrxsize(a4),d0
          mulu chrysize(a4),d0
          addi.w #$0100,d0         ;saute la table
          lea 4(a0,d0.w),a0     ;adresse effective du caractere en a0
          move.l adecran(a4),a1
          move.l adpen(a4),a5          ;pen en a5
          move.l adpaper(a4),a6        ;paper en a6
          move flags(a4),d4
          btst #10,d4
          beq.w affnorm /* XXX */
          exg a6,a5                ;INVERSE! on echange PAPER et PEN
affnorm:  move.b writing+1(a4),d4  ;writing dans d4.b
          move chrysize(a4),d7
          subq #1,d7           ;compteur en Y
          move tlecran,a3      ;taille ligne d'ecran
          move chrxsize(a4),a4
          subq #1,a4           ;compteur en X: a4/d5

          cmpi.w #2,mode
          bne.w affmoy /* XXX */
; HIRES
affht1:   move.l a1,a2        ;debut ligne
          move a4,d5          ;init nb d'octets
affht2:   move.b (a0)+,d0
          move.b d0,d1
          not.b d1
          tst.b d4
          bne.w wrt1ht /* XXX */
; writing 0: pokage simple dans l'ecran
          and.w (a5),d0
          and.w (a6),d1
          or.b d1,d0
          move.b d0,0(a2,d6.l)
          move.b d0,(a2)+
          dbra d5,affht2
lignesh:  add.w a3,a1           ;passage ligne suivante
          dbra d7,affht1      ;autre ligne?
          bclr #9,d4          ;souligne ?
          beq.w finaff /* XXX */
          lea souligne,a0     ;par magouille
          sub.w a3,a1           ;reecris la ligne de soulignement!!!
          clr d7
          bra.w affht1 /* XXX */
wrt1ht:   cmpi.b #1,d4
          bne.w wrt2ht /* XXX */
; writing 1: transparent
          and.w (a5),d0         ;d0: couleur pen, d1=masque decor
          and.b d1,(a2)
          or.b d0,(a2)
          move.b (a2)+,-1(a2,d6.l)
          dbra d5,affht2
          bra.w lignesh /* XXX */
; writing 2: eor avec l'ecran
wrt2ht:   and.w (a5),d0
          and.w (a6),d1
          or.b d1,d0
          eor.b d0,(a2)
          move.b (a2)+,-1(a2,d6.l)
          dbra d5,affht2
          bra.w lignesh /* XXX */

; MIDRES
affmoy:   cmpi.w #1,mode
          bne affbas
affmy1:   move.l a1,a2        ;debut ligne
          move a2,d2          ;flag pair/impair
          move a4,d5          ;init nb octets
affmy2:   moveq #1,d3         ;init cpt plans
affmy3:   move.b (a0),d0
          move.b d0,d1
          not.b d1
          tst.b d4
          bne.s wrt1my
; writing 0: pokage simple dans l'ecran
          and.w (a5)+,d0
          and.w (a6)+,d1
          or.b d1,d0
          move.b d0,0(a2,d6.l)
          move.b d0,(a2)
          addq #2,a2
          dbra d3,affmy3      ;deuxieme plan!
octetsm:  subq #4,a5          ;RAZ plans couleur
          subq #4,a6
          addq #1,a0          ;octet suivant
          subq #1,d5          ;decompte AVANT l'addition: plus rapide!
          bpl.s affmy5
          add.w a3,a1
          dbra d7,affmy1
          bclr #9,d4          ;souligne?
          beq finaff
          lea souligne,a0     ;souligne par magouille!
          sub.w a3,a1
          clr d7
          bra.w affmy1 /* XXX */
affmy5:   subq #1,a2
          bchg #0,d2
          bne.s affmy2
          subq #2,a2
          bra.w affmy2 /* XXX */
wrt1my:   cmpi.b #1,d4
          bne.s wrt2my
; writing 1: transparent
          and.w (a5)+,d0        ;d0: couleur pen, d1=masque decor
          and.b d1,(a2)
          or.b d0,(a2)
          move.b (a2),-1(a2,d6.l)
          addq #2,a2
          dbra d5,affht2
          bra.w octetsm /* XXX */
; writing 2: eor avec l'ecran
wrt2my:   and.w (a5)+,d0
          and.w (a6)+,d1
          or.b d1,d0
          eor.b d0,(a2)
          move.b (a2),-1(a2,d6.l)
          addq #2,a2
          dbra d5,affht2
          bra.w octetsm /* XXX */

; LOWRES
affbas:   move.l a1,a2        ;debut ligne
          move a2,d2          ;flag pair/impair
          move a4,d5          ;init nb octets
affbs2:   moveq #3,d3         ;init cpt plans
affbs3:   move.b (a0),d0
          move.b d0,d1
          not.b d1
          tst.b d4
          bne.s wrt1bs
; writing 0 pokage simple dans l'ecran
          and.w (a5)+,d0
          and.w (a6)+,d1
          or.b d1,d0
          move.b d0,0(a2,d6.l)
          move.b d0,(a2)
          addq #2,a2
          dbra d3,affbs3      ;deuxieme plan!
octetsb:  subq #8,a5          ;RAZ plans couleur
          subq #8,a6
          addq #1,a0          ;octet suivant
          subq #1,d5          ;decompte AVANT: plus rapide!
          bpl.s affbs5
          add.w a3,a1
          dbra d7,affbas
          bclr #9,d4          ;souligne?
          beq.w finaff /* XXX */
          lea souligne,a0     ;souligne par magouille!
          sub.w a3,a1
          clr d7
          bra.w affbas /* XXX */
affbs5:   subq #1,a2
          bchg #0,d2          ;passage a l'octet suivant
          bne.s affbs2
          subq #6,a2
          bra.w affbs2 /* XXX */
wrt1bs:   cmpi.b #1,d4
          bne.s wrt2bs
; writing 1: transparent
          and.w (a5),d0         ;d0: couleur pen, d1=masque decor
          and.b d1,(a2)
          or.b d0,(a2)
          move.b (a2),0(a2,d6.l)
          addq #2,a2
          dbra d5,affht2
          bra.w octetsb /* XXX */
; writing 2: eor avec l'ecran
wrt2bs:   and.w (a5),d0
          and.w (a6),d1
          or.b d1,d0
          eor.b d0,(a2)
          move.b (a2),0(a2,d6.l)
          addq #2,a2
          dbra d5,affht2
          bra.w octetsb /* XXX */

; MOUVEMENT DU CURSEUR
finaff:   move.l adcouran,a4
          move xcursor(a4),d0
          move freelle,d1
          addq #1,d0
          cmp txtext(a4,d1.w),d0
          beq.w finaff5 /* XXX */
          move d0,xcursor(a4)
          cmpi.w #2,mode
          bne.s finaffl
;curseur vers la droite HAUTE
          clr.l d0
          move chrxsize(a4),d0
          add.l d0,adecran(a4)
          /* addq.l #2,adcopie(a4) */
          dc.w 0x06ac,0,2,adcopie /* XXX */
          bra.w sortie /* XXX */
;curseur vers droite BASSE
finaffl:  tst mode
          bne.s finaffm
          /* addq.l #4,adcopie(a4) */
          dc.w 0x06ac,0,4,adcopie /* XXX */
          bra.w finaff2 /* XXX */
;curseur vers droite MOYENNE
finaffm:  /* addq.l #2,adcopie(a4) */
          dc.w 0x06ac,0,2,adcopie /* XXX */
;calculs moyenne et basse
finaff2:  move nbplan,d1
          subq #1,d1
          lsl #1,d1
          move.l adecran(a4),d0
          move chrxsize(a4),d2
          subq #1,d2
finaff3:  btst #0,d0
          beq.s finaff4
          add.w d1,d0
finaff4:  addq #1,d0
          dbra d2,finaff3
          move.l d0,adecran(a4)
sortie:   movem.l (sp)+,d0-d7/a0-a6
          rts
finaff5:  bsr alaligne
          bsr bas
          bra.w sortie
; FINAFF active: DROITE RAPIDE!
finafact: movem.l d0-d7/a0-a6,-(sp)
          bra.w finaff /* XXX */

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         GESTION GENIALE DES ICONES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; CHANGEMENT DU JEU D'ICONE (a0)
newicon:  clr.l adicon
          cmpi.l #$28091960,(a0)+
          bne.w newic /* XXX */
          move.l a0,adicon
newic:    rts

; CODE ESCAPE
cescape:  move #1,escape
          move d2,d0
          addq.l #4,sp
          bra.w escbis /* XXX */

; PUT DROIT: met le code CURDROITE
putdroit: moveq #9,d0
          move.l adcopie(a4),a0 
          tst mode
          beq.s pd1
          move.w flags(a4),d1
          clr.b d1
          or.b d0,d1
          move.w d1,(a0)
          rts
pd1:      move.w flags(a4),d1
          swap d1
          clr d1
          or.b d0,d1
          move.l d1,(a0)
          rts

; AFFICHAGE D'UNE ICONE DANS LES ECRANS (icone 1->31)
afficon:  movem.l d0-d7/a0-a6,-(sp)
          tst.l adicon
          beq.w finicon /* XXX */
          subq #1,d0          ;pas d'icone zero!
          andi.w #$ff,d0
          move.l adicon,a0
          cmp (a0)+,d0        ;compare au nombre d'icones
          bcc.w finicon         ;pas assez d'icones /* XXX */
; ok: affiche l'icone!
          cmpi.w #2,mode
          beq.w buggic /* XXX */
          movem.l d0-d7/a0-a6,-(sp)
          move xcursor(a4),-(sp)
          move ycursor(a4),-(sp)
          bsr bas
          bsr putdroit
          bsr gauche
          bsr putdroit
          move (sp)+,d1
          move (sp)+,d0
          bsr curxy
          movem.l (sp)+,d0-d7/a0-a6
buggic:   mulu #42*2,d0       ;84 octets par icone
          lea 0(a0,d0.w),a0   ;pointe l'icone
          clr.w 4(a0)         ;mode normal!
          move.w xcursor(a4),d0
          add.w startxr(a4),d0
          move.w ycursor(a4),d1
          add.w startyr(a4),d1
          tst freelle         ;si fenetre entiere: pas de marge
          bne.w affica /* XXX */
          tst bordure(a4)     ;si bordure: ajouter 1 aux marges texte
          beq.w affica /* XXX */
          addq #1,d0
          addq #1,d1
affica:   mulu chrxsize(a4),d0
          lsl #3,d0             ;coord 0---> 639 (339)
          mulu chrysize(a4),d1  ;coord 0---> 399 (199)
          lea buficon,a2      ;buffer de sauvegarde, qui ne sert a rien!
          move paper(a4),d2
          move pen(a4),d3
; inverse?
          move flags(a4),d4
          btst #10,d4
          beq.w affic0 /* XXX */
          exg d2,d3
affic0:   move d2,6(a0)
          move d3,8(a0)
; shade?
          btst #11,d4
          beq.w affic3 /* XXX */
          lea bufshade,a3
          moveq #41,d2
affic1:   move.w (a0)+,(a3)+  ;recopie l'icone
          dbra d2,affic1
          lea bufshade,a3
          lea 12(a3),a3
          moveq #15,d2
affic2:   and.w #$aaaa,(a3)
          addq.l #4,a3
          dbra d2,affic2
          lea bufshade,a0

affic3:   tst.l d6            ;un seul ecran
          beq.w affic4 /* XXX */
; affiche l'icone dans l'ecran
          movem.l d0/d1/a0/a2,-(sp)
          dc.w $a00d          ;DRAW SPRITE LIGNE A
          movem.l (sp)+,d0/d1/a0/a2
; affiche l'icone dans le decor
affic4:   move.l ecran.l,-(sp) /* XXX */
          move.l back,ecran.l /* XXX */
          dc.w $a00d          ;DRAW SPRITE LIGNE A
          move.l (sp)+,ecran.l /* XXX */

; pas d'erreur d'iconage
finicon:  movem.l (sp)+,d0-d7/a0-a6
          rts

; RECOPIE RAPIDE DU DECOR VERS L'ECRAN
recopie:  move #249,d7
          move.l back,a0
          move.l ecran.l,a1 /* XXX */
rec:      move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+

          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+

          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+

          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          move.l (a0)+,(a1)+
          dbra d7,rec
          rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	even
pair:     dc.l 0
bufcopie:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          end






