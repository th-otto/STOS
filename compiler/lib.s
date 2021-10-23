        .include "lib.inc"
        .include "file.inc"
        .include "equates.inc"
        .include "system.inc"
        .include "music.inc"
        .include "window.inc"
        .include "sprites.inc"
        .include "tokens.inc"
        .include "errors.inc"
        .include "adapt.inc"
        .include "float.inc"

        .text

**************************** 05/01/1989 *********************************
delib:  dc.l librairie-delib
*************************************************************************
        dc.w L1-L0,L2-L1,L3-L2,L4-L3,L5-L4
        dc.w L6-L5,L7-L6,L8-L7,L9-L8,L10-L9
        dc.w L11-L10,L12-L11,L13-L12,L14-L13,L15-L14
        dc.w L16-L15,L17-L16,L18-L17,L19-L18,L20-L19
        dc.w L21-L20,L22-L21,L23-L22,L24-L23,L25-L24
        dc.w L26-L25,L27-L26,L28-L27,L29-L28,L30-L29
        dc.w L31-L30,L32-L31,L33-L32,L34-L33,L35-L34
        dc.w L36-L35,L37-L36,L38-L37,L39-L38,L40-L39
        dc.w L41-L40,L42-L41,L43-L42,L44-L43,L45-L44
        dc.w L46-L45,L47-L46,L48-L47,L49-L48,L50-L49
        dc.w L51-L50,L52-L51,L53-L52,L54-L53,L55-L54
        dc.w L56-L55,L57-L56,L58-L57,L59-L58,L60-L59
        dc.w L61-L60,L62-L61,L63-L62,L64-L63,L65-L64
        dc.w L66-L65,L67-L66,L68-L67,L69-L68,L70-L69
        dc.w L71-L70,L72-L71,L73-L72,L74-L73,L75-L74
        dc.w L76-L75,L77-L76,L78-L77,L79-L78,L80-L79
        dc.w L81-L80,L82-L81,L83-L82,L84-L83,L85-L84
        dc.w L86-L85,L87-L86,L88-L87,L89-L88,L90-L89
        dc.w L91-L90,L92-L91,L93-L92,L94-L93,L95-L94
        dc.w L96-L95,L97-L96,L98-L97,L99-L98,L100-L99
        dc.w L101-L100,L102-L101,L103-L102,L104-L103,L105-L104
        dc.w L106-L105,L107-L106,L108-L107,L109-L108,L110-L109
        dc.w L111-L110,L112-L111,L113-L112,L114-L113,L115-L114
        dc.w L116-L115,L117-L116,L118-L117,L119-L118,L120-L119
        dc.w L121-L120,L122-L121,L123-L122,L124-L123,L125-L124
        dc.w L126-L125,L127-L126,L128-L127,L129-L128,L130-L129
        dc.w L131-L130,L132-L131,L133-L132,L134-L133,L135-L134
        dc.w L136-L135,L137-L136,L138-L137,L139-L138,L140-L139
        dc.w L141-L140,L142-L141,L143-L142,L144-L143,L145-L144
        dc.w L146-L145,L147-L146,L148-L147,L149-L148,L150-L149
        dc.w L151-L150,L152-L151,L153-L152,L154-L153,L155-L154
        dc.w L156-L155,L157-L156,L158-L157,L159-L158,L160-L159
        dc.w L161-L160,L162-L161,L163-L162,L164-L163,L165-L164
        dc.w L166-L165,L167-L166,L168-L167,L169-L168,L170-L169
        dc.w L171-L170,L172-L171,L173-L172,L174-L173,L175-L174
        dc.w L176-L175,L177-L176,L178-L177,L179-L178,L180-L179
        dc.w L181-L180,L182-L181,L183-L182,L184-L183,L185-L184
        dc.w L186-L185,L187-L186,L188-L187,L189-L188,L190-L189
        dc.w L191-L190,L192-L191,L193-L192,L194-L193,L195-L194
        dc.w L196-L195,L197-L196,L198-L197,L199-L198,L200-L199
        dc.w L201-L200,L202-L201,L203-L202,L204-L203,L205-L204
        dc.w L206-L205,L207-L206,L208-L207,L209-L208,L210-L209
        dc.w L211-L210,L212-L211,L213-L212,L214-L213,L215-L214
        dc.w L216-L215,L217-L216,L218-L217,L219-L218,L220-L219
        dc.w L221-L220,L222-L221,L223-L222,L224-L223,L225-L224
        dc.w L226-L225,L227-L226,L228-L227,L229-L228,L230-L229
        dc.w L231-L230,L232-L231,L233-L232,L234-L233,L235-L234
        dc.w L236-L235,L237-L236,L238-L237,L239-L238,L240-L239
        dc.w L241-L240,L242-L241,L243-L242,L244-L243,L245-L244
        dc.w L246-L245,L247-L246,L248-L247,L249-L248,L250-L249
        dc.w L251-L250,L252-L251,L253-L252,L254-L253,L255-L254
        dc.w L256-L255,L257-L256,L258-L257,L259-L258,L260-L259
        dc.w L261-L260,L262-L261,L263-L262,L264-L263,L265-L264
        dc.w L266-L265,L267-L266,L268-L267,L269-L268,L270-L269
        dc.w L271-L270,L272-L271,L273-L272,L274-L273,L275-L274
        dc.w L276-L275,L277-L276,L278-L277,L279-L278,L280-L279
        dc.w L281-L280,L282-L281,L283-L282,L284-L283,L285-L284
        dc.w L286-L285,L287-L286,L288-L287,L289-L288,L290-L289
        dc.w L291-L290,L292-L291,L293-L292,L294-L293,L295-L294
        dc.w L296-L295,L297-L296,L298-L297,L299-L298,L300-L299
        dc.w L301-L300,L302-L301,L303-L302,L304-L303,L305-L304
        dc.w L306-L305,L307-L306,L308-L307,L309-L308,L310-L309
        dc.w L311-L310,L312-L311,L313-L312,L314-L313,L315-L314
        dc.w L316-L315,L317-L316,L318-L317,L319-L318,L320-L319
        dc.w L321-L320,L322-L321,L323-L322,L324-L323,L325-L324
        dc.w L326-L325,L327-L326,L328-L327,L329-L328,L330-L329
        dc.w L331-L330,L332-L331,L333-L332,L334-L333,L335-L334
        dc.w L336-L335,L337-L336,L338-L337,L339-L338,L340-L339
        dc.w L341-L340,L342-L341,L343-L342,L344-L343,L345-L344
        dc.w L346-L345,L347-L346,L348-L347,L349-L348,L350-L349
        dc.w L351-L350,L352-L351,L353-L352,L354-L353,L355-L354
        dc.w L356-L355,L357-L356,L358-L357,L359-L358,L360-L359
        dc.w L361-L360,L362-L361,L363-L362,L364-L363,L365-L364
        dc.w L366-L365,L367-L366,L368-L367,L369-L368,L370-L369
        dc.w L371-L370,L372-L371,L373-L372,L374-L373,L375-L374
        dc.w L376-L375,L377-L376,L378-L377,L379-L378,L380-L379
        dc.w L381-L380,L382-L381,L383-L382,L384-L383,L385-L384
        dc.w L386-L385,L387-L386,L388-L387,L389-L388,L390-L389
        dc.w L391-L390,L392-L391,L393-L392,L394-L393,L395-L394
        dc.w L396-L395,L397-L396,L398-L397,L399-L398,L400-L399
        dc.w L401-L400,L402-L401,L403-L402,L404-L403,L405-L404
        dc.w L406-L405,L407-L406,L408-L407,L409-L408,L410-L409
        dc.w L411-L410,L412-L411,L413-L412,L414-L413,L415-L414
        dc.w L416-L415,L417-L416,L418-L417,L419-L418,L420-L419
        dc.w L421-L420,L422-L421,L423-L422,L424-L423,L425-L424
        dc.w L426-L425,L427-L426,L428-L427,L429-L428,L430-L429
        dc.w L431-L430,L432-L431,L433-L432,L434-L433,L435-L434
        dc.w L436-L435,L437-L436,L438-L437,L439-L438,L440-L439
        dc.w L441-L440,L442-L441,L443-L442,L444-L443,L445-L444
        dc.w L446-L445,L447-L446,L448-L447,L449-L448,L450-L449
        dc.w L451-L450,L452-L451,L453-L452,L454-L453,L455-L454
        dc.w L456-L455,L457-L456,L458-L457,L459-L458,L460-L459
        dc.w L461-L460,L462-L461,L463-L462,L464-L463,L465-L464
        dc.w L466-L465,L467-L466,L468-L467,L469-L468,L470-L469
        dc.w L471-L470,L472-L471,L473-L472,L474-L473,L475-L474
        dc.w L476-L475,L477-L476,L478-L477,L479-L478,L480-L479
        dc.w L481-L480,L482-L481,L483-L482,L484-L483,L485-L484
        dc.w L486-L485,L487-L486,L488-L487,L489-L488,L490-L489
        dc.w L491-L490,L492-L491,L493-L492,L494-L493,L495-L494
        dc.w L496-L495,L497-L496,L498-L497,L499-L498,L500-L499
        dc.w L501-L500,L502-L501,L503-L502,L504-L503,L505-L504
        dc.w L506-L505,L507-L506,L508-L507,L509-L508,L510-L509
        dc.w L511-L510,L512-L511,L513-L512,L514-L513,L515-L514
        dc.w L516-L515,L517-L516,L518-L517,L519-L518,L520-L519
        dc.w L521-L520,L522-L521,L523-L522,L524-L523,L525-L524
        dc.w L526-L525,L527-L526,L528-L527,L529-L528,L530-L529
        dc.w L531-L530,L532-L531,L533-L532,L534-L533,L535-L534
        dc.w L536-L535,L537-L536,L538-L537,L539-L538,L540-L539
        dc.w L541-L540,L542-L541,L543-L542,L544-L543,L545-L544
        dc.w L546-L545,L547-L546,L548-L547,L549-L548,L550-L549
        dc.w L551-L550,L552-L551,L553-L552,L554-L553,L555-L554
        dc.w L556-L555,L557-L556,L558-L557,L559-L558,L560-L559
        dc.w L561-L560,L562-L561,L563-L562,L564-L563,L565-L564
        dc.w L566-L565,L567-L566,L568-L567,L569-L568,L570-L569
        dc.w L571-L570,L572-L571,L573-L572,L574-L573,L575-L574
        dc.w L576-L575,L577-L576,L578-L577,L579-L578,L580-L579
        dc.w L581-L580,L582-L581,L583-L582,L584-L583

        dc.l 0


***************************************************************************
*       VARIABLES DEBUT DU PROGRAMME
DebD            = 128
**********************************
; Non relogeables
atable         equ DebD+$00            ;Adresse de la table
otbufsp        equ DebD+$04
omaxcop        equ DebD+$08
ovide          equ DebD+$12
; Relogeables
debrel         equ DebD+$10
ochvide        equ DebD+$10            ;Chaine vide
oreloc         equ DebD+$14            ;debut de la table de relocation
otrappes       equ DebD+$18            ;debut des buffers trappes
oerror         equ DebD+$1c            ;Traitement des erreur
oliad          equ DebD+$20            ;Table #LIGNE----> ADRESSE
oadstr         equ DebD+$24
ofdata         equ DebD+$28
oadmenu        equ DebD+$2C
otrap3         equ DebD+$30            ;Adresses des trappes
otrap5         equ DebD+$34
otrap6         equ DebD+$38
otrap7         equ DebD+$3C
oext           equ DebD+$40            ;Offset (debut/fin) des 26 extensions
ocr0           equ 26*8+oext
ocr1           equ ocr0+4
ocr2           equ ocr1+4
omou           equ ocr2+4
LDeb           equ omou+4
*************************************************************************

*************************************************************************

librairie:

************************************************************************
*       RUN sous GEM
L0:     nop

*************************************************************************
*       DELOGE le programme!
L1:     dc.w 0
****************************
; Empeche le plantage en cas de STOS RUN
        move.l himem(a5),lowvar(a5)
        move.l fsource(a5),a0
        clr.w (a0)+
        move.l a0,hichaine(a5)

        move.l debut(a5),a6     ;debut du programme
; Appelle la fin des trappes
        lea oext(a6),a2
        moveq #26-1,d2
Ft1:    cmp.l (a2),a6
        beq.s Ft2
        move.l 26*4(a2),a0
        movem.l a2/a5/a6/d2,-(sp)
        jsr (a0)
        movem.l (sp)+,a2/a5/a6/d2
Ft2:    lea 4(a2),a2
        dbra d2,Ft1

; Delete the program
        move.l a6,d6
Del0:   move.l oreloc(a6),a0    ;Pointe la table de relocation
        move.l a6,a2            ;debut a reloger
Del1:   move.b (a0)+,d0
        beq.s Del5
Del2:   cmp.b #1,d0
        bne.s Del3
        add.w #126,a2
        bra.s Del1
Del3:   move.b d0,d1
        andi.w #$007F,d1
        add.w d1,a2
; Deloge...
        btst #7,d0
        bne.s Del4
; Deloge un JSR / JMP ...
        sub.l d6,(a2)           ;Soustraie la base
        bra.s Del1
; Deloge une variable
Del4:   sub.l d6,(a2)           ;Soustraie la base
        addq.l #1,a0            ;Saute le flag de la variable
        bra.s Del1

; Deloge les adresses lignes
Del5:   move.l oliad(a6),a0
Del6:   cmp.w #$ffff,(a0)+
        beq.s Del7
        sub.l d6,(a0)+
        bra.s Del6

; Deloge les adresses strings
Del7:   move.l oadstr(a6),a0
Del8:   tst.l (a0)
        beq.s Del9
        sub.l d6,(a0)+
        bra.s Del8

; Deloge les donnees
Del9:   lea debrel(a6),a0
Del10:  cmp.w #$FF00,(a0)
        beq.s Del11
        sub.l d6,(a0)+
        bra.s Del10

; Restore exception vectors
Del11:  lea svect(a5),a0
        move.l (a0)+,$8
        move.l (a0)+,$c
        move.l (a0)+,$404
        move.l (a0)+,$10
        move.l (a0)+,$14
        rts

*************************************************************************
*       PLUS float
L2:             dc.w 0
***********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_add,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

*************************************************************************
*       PLUS Chaine
L3:     dc.w L3a-L3,0
**********************
        move.l (a6)+,a3         ;Deuxieme chaine
        move.l (a6)+,a2         ;Premiere chaine

        move.w (a2)+,d6
        beq.s L3g
        move.w (a3)+,d7
        beq.s L3h

        moveq #0,d3
        move.w d6,d3
        add.w d7,d3
        bcs.s L3z               ;String too long?
        cmp.w #$fff0,d3
        bcc.s L3z
L3a:    jsr L_malloc.l

        move.l a0,-(a6)         ;Empile le resultat
        move.w d3,(a0)+         ;Longueur resultante
        addq.l #2,a1
        add.w d6,a1             ;Adresse debut deuxieme chaine

; Copie la premiere chaine par MOTS LONGS (+++ rapide)
        addq.w #4,d6
        lsr.w #2,d6
        subq.w #1,d6            ;Travaille par mot longs
L3b:    move.l (a2)+,(a0)+
        dbra d6,L3b

; Copie la deuxieme chaine (par octet, helas!)
        subq.w #1,d7
L3c:    move.b (a3)+,(a1)+
        dbra d7,L3c
; Rend pair
        move.w a1,d0
        btst #0,d0
        beq.s L3d
        addq.l #1,a1
L3d:    move.l a1,hichaine(a5)
        rts
; 1ere chaine nulle
L3g:    move.l a3,-(a6)         ;Ramene la 2eme
        rts
; 2eme chaine nulle
L3h:    subq.l #2,a2
        move.l a2,-(a6)         ;Ramene la 1ere
        rts
; String too long
L3z:    moveq #E_string_too_long,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOINS float
L4:             dc.w 0
***********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_sub,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

*************************************************************************
*       MOINS Chaine
L5:     dc.w L5a-L5,L5b-L5,0
**********************
        move.l (a6)+,d4
        move.l (a6)+,a2
        moveq #0,d3
        move.w (a2)+,d3
        move.l d3,d1
L5a:    jsr L_malloc.l         ;prend la place une fois pour toute!
        move.w d3,(a0)+
        beq.s ms4
        addq #1,d3
        lsr #1,d3
        subq #1,d3
ms3:    move.w (a2)+,(a0)+  ;recopie la chaine
        dbra d3,ms3
ms4:    move.l a0,hichaine(a5)
        addq.l #2,a1        ;chaine dont auquelle on soustrait en a1/d1
        move.l d4,a2
        moveq #0,d2
        move (a2)+,d2       ;chaine a soustraire en a2/d2

ms5:    clr.l d4
        movem.l d1-d2/a1-a2,-(sp)
L5b:    jsr L_instrfind.l       ;recherche la chaine!
        movem.l (sp)+,d1-d2/a1-a2
        tst.l d3
        beq.s ms9
        move.l a1,a0
        move.l a1,d4        ;pour plus tard!
        subq.l #1,d3
        move.l d3,d5        ;taille du debut a garder
        add.l d3,a1         ;pointe ou transferer la fin
        add.l d2,d3
        add.l d3,a0         ;pointe la fin a recopier
        sub.l d3,d1
        add.l d1,d5         ;taille finale en memoire
        subq.l #1,d1
        bmi.s ms7
ms6:    move.b (a0)+,(a1)+
        dbra d1,ms6
ms7:    move a0,d0          ;rend pair
        btst #0,d0
        beq.s ms8
        addq.l #1,a0
ms8:    move.l a0,hichaine(a5)  ;baisse la limite!
        move.l d4,a1
        move.w d5,-2(a1)
        move.l d5,d1
        bra.s ms5
ms9:    subq.l #2,a1
        move.l a1,-(a6)
        rts

*************************************************************************
*       Int To Float
L6:             dc.w 0
**********************
        move.l (a6),d1
        moveq #F_ltof,d0
        trap #6
        move.l d0,(a6)
        move.l d1,-(a6)
        rts

*************************************************************************
*       Float To Int
L7:             dc.w 0
**********************
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_ftol,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Multiplication entiere
L8:             dc.w 0
**********************
        move.l (a6)+,d3
        move.l (a6),d6
        cmp.l #$00008000,d3
        bcc.s mlt0
        cmp.l #$00008000,d6
        bcc.s mlt0
        muls d6,d3          ;quand on le peut: multiplication directe!
        move.l d3,(a6)
        rts
mlt0:   clr d4              ;multiplication signee 32*32 bits
        tst.l d3            ;aabb*ccdd
        bpl.s mlt1
        neg.l d3
        not d4
mlt1:   tst.l d6            ;tests des signes
        bpl.s mlt2
        neg.l d6
        not d4
mlt2:   move d6,d1
        mulu d3,d1
        bmi.s mlto
        swap d6
        move d6,d0
        mulu d3,d0
        swap d0
        bmi.s mlto
        tst d0
        bne.s mlto
        add.l d0,d1
        bvs.s mlto
        swap d3
        move d6,d0
        mulu d3,d0
        bne.s mlto
        swap d6
        move d6,d0
        mulu d3,d0
        swap d0
        bmi.s mlto
        tst d0
        bne.s mlto
        add.l d0,d1
        bvs.s mlto
        tst d4              ;signe du resultat
        beq.s mlt3
        neg.l d1
mlt3:   move.l d1,(a6)
        rts
mlto:   moveq #E_overflow,d0        ;OVERFLOW
        move.l error(a5),a0
        jmp (a0)

***************************************************************************
*       Multiplication FLOAT
L9:             dc.w 0
**********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_mul,d0
        trap #6
        move.l d0,(a6)
        move.l d1,-(a6)
        rts

***************************************************************************
*       DIVISION entiere
L10:            dc.w 0
**********************
        move.l (a6)+,d3
        move.l (a6),d6
        tst.l d3
        beq.s dbz1          ;division par zero!
        clr d7
        tst.l d6
        bpl.s dva
        not d7
        neg.l d6
dva:    cmp.l #$10000,d3    ;Division rapide ou non?
        bcc.s dv0
        tst.l d3
        bpl.s dvb
        not d7
        neg.l d3
dvb:    move.l d6,d0
        divu d3,d0          ;division rapide: 32/16 bits
        bvs.s dv0
        moveq #0,d3
        move d0,d3
        bra.s dvc
dv0:    tst.l d3
        bpl.s dv3
        not d7
        neg.l d3
dv3:    moveq #31,d5         ;division lente: 32/32 bits
        moveq #-1,d4
        clr.l d1
dv2:    lsl.l #1,d6
        roxl.l #1,d1
        cmp.l d3,d1
        bcs.s dv1
        sub.l d3,d1
        lsr #1,d4           ;met X a un!
dv1:    roxl.l #1,d0
        dbra d5,dv2
        move.l d0,d3
dvc:    tst d7
        beq.s dvd
        neg.l d3
dvd:    move.l d3,(a6)
        rts
dbz1:   moveq #E_divzero,d0
        move.l error(a5),a0
        jmp (a0)


******************************************************************************
*       DIVISION Float
L11:            dc.w 0
**********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_div,d0
        trap #6
        move.l d0,(a6)
        move.l d1,-(a6)
        rts

*************************************************************************
*       Operateur MODULO (que des entiers)
L12:            dc.w 0
**********************
        move.l (a6)+,d3
        beq.s md5
        move.l (a6),d6
        moveq #31,d5            ;division lente: 32/32 bits
        moveq #-1,d4
        clr.l d1
md2:    lsl.l #1,d6
        roxl.l #1,d1
        cmp.l d3,d1
        bcs.s md1
        sub.l d3,d1
        lsr #1,d4               ;met X a un!
md1:    roxl.l #1,d0
        dbra d5,md2
        move.l d1,(a6)          ;Prend le reste
        rts
md5:    moveq #E_illegalfunc,d0            ;illegal function call
        move.l error(a5),a0
        jmp (a0)


*************************************************************************
*       Operateur PUISSANCE (que des Floats)
L13:            dc.w 0
**********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_pow,d0
        trap #6
        move.l d0,(a6)
        move.l d1,-(a6)
        rts

*************************************************************************
*       Operateur EGAL - entiers -
L14:            dc.w 0
**********************
        move.l (a6)+,d0
        cmp.l (a6),d0
        beq.s Eg
        clr.l (a6)
        rts
Eg:     moveq #-1,d0
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur EGAL - floats -
L15:            dc.w 0
**********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_eq,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur EGAL - chaines -
L16:    dc.w l16a-L16,0
***********************
l16a:   jsr L_compch.l
        cmp.w d3,d6
        beq.s l16b
        clr.l -(a6)
        rts
l16b:   moveq #-1,d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       Operateur DIFFERENT - entiers -
L17:    dc.w 0
**************
        move.l (a6)+,d0
        cmp.l (a6),d0
        bne.s Di
        clr.l (a6)
        rts
Di:     moveq #-1,d0
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur DIFFERENT - floats -
L18:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_ne,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur DIFFERENT -chaines-
L19:    dc.w l19a-L19,0
***********************
l19a:   jsr L_compch.l
        cmp.w d3,d6
        bne.s l19b
        clr.l -(a6)
        rts
l19b:   moveq #-1,d0
        move.l d0,-(a6)
        rts

**************************************************************************
*       Operateur INFERIEUR - entiers
L20:    dc.w 0
**************
        move.l (a6)+,d0
        cmp.l (a6),d0
        bgt.s l20a
        clr.l (a6)
        rts
l20a:   moveq #-1,d0
        move.l d0,(a6)
        rts

**************************************************************************
*       Operateur INFERIEUR - floats -
L21:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_lt,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur INFERIEUR - chaines
L22:    dc.w l22a-L22,0
***********************
l22a:   jsr L_compch.l
        cmp.w d3,d6
        blt.s l22b
        clr.l -(a6)
        rts
l22b:   moveq #-1,d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       Operateur SUPERIEUR - entiers -
L23:    dc.w 0
**************
        move.l (a6)+,d0
        cmp.l (a6),d0
        blt.s l23a
        clr.l (a6)
        rts
l23a:   moveq #-1,d0
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur SUPERIEUR - floats -
L24:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_gt,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur SUPERIEUR - chaines -
L25:    dc.w l25a-L25,0
***********************
l25a:   jsr L_compch.l
        cmp.w d3,d6
        bgt.s l25b
        clr.l -(a6)
        rts
l25b:   moveq #-1,d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       Operateur INFERIEUR OU EGAL - entiers -
L26:    dc.w 0
**************
        move.l (a6)+,d0
        cmp.l (a6),d0
        bge.s l26a
        clr.l (a6)
        rts
l26a:   moveq #-1,d0
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur INFERIEUR OU EGAL - floats -
L27:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_le,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur INFERIEUR OU EGAL - entiers -
L28:    dc.w l28a-L28,0
***********************
l28a:   jsr L_compch.l
        cmp.w d3,d6
        ble.s l28b
        clr.l -(a6)
        rts
l28b:   moveq #-1,d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       Operateur SUPERIEUR OU EGAL - entiers -
L29:    dc.w 0
**************
        move.l (a6)+,d0
        cmp.l (a6),d0
        ble.s l29a
        clr.l (a6)
        rts
l29a:   moveq #-1,d0
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur SUPERIEUR OU EGAL - floats -
L30:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6),d1
        moveq #F_ge,d0
        trap #6
        move.l d0,(a6)
        rts

*************************************************************************
*       Operateur SUPERIEUR EGAL - chaines -
L31:    dc.w l31a-L31,0
***********************
l31a:   jsr L_compch.l
        cmp.w d3,d6
        bge.s l31b
        clr.l -(a6)
        rts
l31b:   moveq #-1,d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       Routine de comparaison de chaines
L32:    dc.w 0
**************
        move.l (a6)+,a1
        move.l (a6)+,a0
        moveq #0,d3
        moveq #0,d6
        move.w (a0)+,d0
        move.w (a1)+,d1
        beq.s cpch8
        tst d0
        beq.s cpch7
cpch1:  cmpm.b (a0)+,(a1)+
        bne.s cpch6
        subq #1,d0
        beq.s cpch3
        subq #1,d1
        bne.s cpch1
; on est arrive au bout d'une des chaines
cpch2:  moveq #1,d6         ;A$>B$
        rts
cpch3:  subq #1,d1          ;egalite!
        beq.s cpch5
cpch4:  moveq #1,d3         ;B$>A$
cpch5:  rts
; on est pas arrive au bout des chaines
cpch6:  bcc.s cpch4
        bcs.s cpch2
; a$ est nulle
cpch7:  tst d1
        beq.s cpch5           ;deux chaines nulles
        bne.s cpch4           ;B$>A$
; b$ est nulle
cpch8:  tst d0
        beq.s cpch5           ;deux chaines nulles
        bne.s cpch2           ;A$>B$

*************************************************************************
*       IMPRESSION d'un chiffer ENTIER
L33:    dc.w l33a-L33,l33b-L33,l33d-L33,0
*****************************************
        moveq #-1,d3            ;Proportionnel
        moveq #1,d4             ;Avec signe
        move.l buffer(a5),a0
        move.l (a6)+,d0
l33a:   jsr L_longdec.l
        clr.b (a0)
        tst.b usingflg(a5)
        beq.s l33c
l33b:   jsr L_usingcf.l
l33c:   move.l buffer(a5),a0
l33d:   jmp L_impfin.l

*************************************************************************
*       IMPRESSION d'un chiffre FLOAT
L34:    dc.w l34a-L34,l34b-L34,l34d-L34,0
*****************************************
        move.l buffer(a5),a0
        move.w fixflg(a5),d0
l34a:   jsr L_strflasc.l
        clr.b (a0)
        tst.b usingflg(a5)
        beq.s l34c
l34b:   jsr L_usingcf.l
l34c:   move.l buffer(a5),a0
l34d:   jmp L_impfin.l

*************************************************************************
*       IMPRESSION d'une chaine
L35:    dc.w l35c-L35,l35e-L35,0
********************************
        move.l (a6)+,a1
        move.w (a1)+,d1
l35r:   move.l buffer(a5),a0
        beq.s l35b
        moveq #120,d0           ;Par salves de 120
l35a:   move.b (a1)+,(a0)+      ;Recopie dans le buffer
        subq.w #1,d1
        beq.s l35b
        dbra d0,l35a
l35b:   clr.b (a0)
        move.w d1,-(sp)
        move.l a1,-(sp)
        tst.b usingflg(a5)      ;Si using
        beq.s l35d
l35c:   jsr L_usingch.l                  ;appelle
        clr.w 4(sp)             ;1 seule fois!

l35d:   move.l buffer(a5),a0
l35e:   jsr L_impfin.l              ;Imprime ... et revient
        move.l (sp)+,a1
        move.w (sp)+,d1
        bne.s l35r
        rts

*************************************************************************
*       START PRINTING IN A DEVICE
L36:    dc.w l36a-L36,0
****************
l36a:   jsr L_getfile.l
        beq.s l36no
        bmi.s l36tm
        cmp.w #5,d0
        beq.s l36tm
        move.w d0,printype(a5)
        move.l a2,printfile(a5)
        rts
l36no:  moveq #59,d0
        bra.s l36go
l36tm:  moveq #E_file_mismatch,d0
l36go:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FIN DE L'IMPRESSION : ENVOIE AUX PERIPHERIQUES
*       A0 pointe la fin de la chaine dans le buffer
*       FAIRE TESTER LES INTERRUPTIONS!
L37:    dc.w ip1-L37,l37a-L37,l37b-L37,0
**********************
        tst.b impflg(a5)
        bne.s ip
; Sortie sur l'ecran
        move #W_prtstring,d7          ;sur l'ecran!
        trap #3
        rts
; Sortie sur l'imprimante
ip:     move.l a3,-(sp)
        move.l a0,a3
        move.w #800,d3
        bra.s ip2
ip1:    jsr L_waitvbl.l
ip2:    clr.w -(sp)         ;bcostat sur l'imprimante
        move.w #8,-(sp)
        trap #13
        addq.l #4,sp
        tst d0              ;attend que l'imprimante soit prete
        bne.s ip3           ;en gerant les interruptions
l37a:   jsr L_tester.l
        dbra d3,ip1         ;compte les balayages d'ecran!
        moveq #E_printer,d0            ;Printer not ready
        move.l error(a5),a0
        jmp (a0)
ip3:    clr.w d0
        move.b (a3)+,d0     ;c'est pret! envoyez c'est pes‚!
        beq.s fip
        move.w d0,-(sp)
        clr.w -(sp)
        move.w #3,-(sp)
        trap #13
        addq.l #6,sp
        move.w #800,d3      ;autorise +/- 7 secondes de delai
        bra.s ip2
fip:    move.l (sp)+,a3
l37b:   jsr L_tester.l
        rts

*************************************************************************
*       WAIT VBL
L38:    dc.w 0
**************
        move.w #37,-(sp)
        trap #14
        addq.l #2,sp
        rts

*************************************************************************
*       CONVERSION ALPHA---> DECIMAL
*       Dans (A0)
L39:    dc.w 0
**************
        tst.l d0
        bpl.s hexy
        move.b #"-",(a0)+
        neg.l d0
        bra.s hexz
hexy:   tst d4
        beq.s hexz
        move.b #32,(a0)+
hexz:   tst.l d3
        bmi.s hexv
        neg.l d3
        addi.l #10,d3
hexv:   moveq.l #9,d4
        lea mdx(pc),a1
hxx0:   move.l (a1)+,d1     ;table des multiples de dix
        move.b #$ff,d2
hxx1:   addq.b #1,d2
        sub.l d1,d0
        bcc.s hxx1
        add.l d1,d0
        tst.l d3
        beq.s hxx4
        bpl.s hxx3
        btst #31,d4
        bne.s hxx4
        tst d4
        beq.s hxx4
        tst.b d2
        beq.s hxx5
        bset #31,d4
        bra.s hxx4
hxx3:   subq.l #1,d3
        bra.s hxx5
hxx4:   addi.w #48,d2
        move.b d2,(a0)+
hxx5:   dbra d4,hxx0
        rts
mdx:    dc.l 1000000000,100000000,10000000,1000000
        dc.l 100000,10000,1000,100,10,1,0

*************************************************************************
*       CONVERSION FLOAT--->DECIMAL
*       en (A0)
L40:    dc.w 0
**************
        move.l a4,-(sp)         ;Utilise A4
        move.l a0,a4            ;comme pointeur sur le buffer
        movem.l a0/a1/d0,-(sp)
        move.l (a6),d4
        move.l 4(a6),d3
        move.w #F_getsgn,d0
        trap #6
        tst.w d0
        bmi.s L40a              ;met un espace si positif
        move.b #32,(a4)+
L40a:   movem.l (sp)+,a0/a1/d0
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #0,d4
        moveq #0,d5
        move.w d0,d4
        move expflg(a5),d5
; entree pour la tokenisation
        move.l defloat(a5),a0   ;buffer d'ecriture du float
        move #F_ftoa,d0
        trap #6
        tst d4
        bmi.s pkb
pka:    move.b (a0)+,(a4)+      ;FIX: imprime tout defloat!
        bne.s pka
        bra p7
pkb:    move.l a0,a2
p1:     move.b (a2)+,d0
        cmp.b #".",d0
        beq.s p1a
        move.b d0,(a4)+
        bne.s p1
        bra.s p7
p1a:    move.l a2,a1        ;a1= ancien non nul
        move.l a2,a0
p2:     move.b (a0)+,d0
        beq.s p3
        cmp.b #"E",d0
        beq.s p3
        cmp.b #"0",d0
        beq.s p2
        move.l a0,a1
        bra.s p2
p3:     subq.l #1,a0
        move.l a0,d0        ;adresse de la fin du chiffre
        cmp.l a2,a1         ;imprime les chiffres utiles
        beq.s p5
        move.b #".",(a4)+
p4:     move.b (a2)+,(a4)+
        cmp.l a2,a1
        bne.s p4
p5:     move.l d0,a2
        cmp.b #"E",(a2)
        bne.s p6
        move.b #32,(a4)+    ;imprime un espace avant le E
p6:     move.b (a2)+,(a4)+
        bne.s p6
p7:     subq.l #1,a4        ;a0 pointe le zero de fin!
        move.l a4,a0
        move.l (sp)+,a4
        rts
;TABLE DES FIX ASCII
fxt:    dc.b "0800010203040506070809101112131415"

*************************************************************************
*       USING CHIFFRES
L41:    dc.w 0
**************
; Chaine de formattage
        move.l (a6)+,a0
        move.l buffer(a5),a1
        lea 256(a1),a1
        move.w (a0)+,d0
        beq.s l41a3
        cmp.w #127,d0
        bcs.s l41a1
        moveq #127,d0
l41a1:  subq.w #1,d0
l41a2:  move.b (a0)+,(a1)+
        dbra d0,l41a2
l41a3:  clr.b (a1)
; USING pour les CHIFFRES
        move.l buffer(a5),a1
        lea 128(a1),a2
        moveq #127,d0
us2:    move.b (a1),(a2)+   ;recopie la chaine, et fait le menage!!!
        move.b #32,(a1)+
        dbra d0,us2
        move.l buffer(a5),a0
        lea 128(a0),a1      ;a1 pointe la chaine
        move.l a1,d6        ;debut chaine a formatter
        move.l buffer(a5),a2
        lea 256(a2),a2    ;a2 pointe la chaine de definition
        move.l a2,d7        ;debut chaine de format
us3:    move.b (a2),d0
        beq.s us5
        cmp.b #".",d0       ;cherche la fin du format de chiffre
        beq.s us5
        cmp.b #";",d0
        beq.s us5
        cmp.b #"E",d0
        beq.s us5
        addq.l #1,a0
        addq.l #1,a2
        bra.s us3
us5:    move.b (a1),d0
        beq.s us6
        cmp.b #".",d0       ;trouve le point de la chaine a formatter
        beq.s us6             ;ou la fin
        cmp.b #"E",d0
        beq.s us6
        addq.l #1,a1
        bra.s us5
us6:    movem.l a0-a2,-(sp)
; ecris la gauche du chiffre
us7:    cmp.l d7,a2         ;fini a gauche???
        beq us15
        move.b -(a2),d0
        cmp.b #"#",d0
        beq.s us8
        cmp.b #"-",d0
        beq.s us11
        cmp.b #"+",d0
        beq.s us12
        move.b d0,-(a0)     ;aucun signe reserve: le met simplement!
        bra.s us7
us8:    cmp.l d6,a1         ;-----> "#"
        bne.s us10
us9:    move.b #" ",-(a0)   ;arrive au debut du chiffre!
        bra.s us7
us10:   move.b -(a1),d0
        cmp.b #"0",d0       ;pas un chiffre (signe)
        bcs.s us9
        cmp.b #"9",d0
        bhi.s us9
        move.b d0,-(a0)     ;OK, chiffre: poke!
        bra.s us7
us11:   move.l d6,a3        ;-----> "-"
        move.b (a3),-(a0)   ;met le "signe": 32 ou "-"
        bra.s us7
us12:   move.l d6,a3
        move.b (a3),d0
        cmp.b #"-",d0
        beq.s us13
        move.b #"+",d0
us13:   move.b d0,-(a0)     ;-----> "+"
        bra us7
; ecrit la droite du chiffre
us15:   movem.l (sp)+,a0-a2 ;recupere les adresses pivot
        clr.l d2            ;flag puissance
        cmp.b #".",(a1)     ;saute le point dans le chiffre a afficher
        bne.s us16
        addq.l #1,a1
us16:   move.b (a2)+,d0
        beq finus         ;fini OUF!
        cmp.b #";",d0       ;";" marque la virgule sans l'ecrire!
        beq.s us18z
        cmp.b #"#",d0
        beq.s us17
        cmp.b #"^",d0
        beq.s us20
        move.b d0,(a0)+     ;ne correspond a rien: POKE!
        bra.s us16
us17:   move.b (a1),d0      ;-----> "#"
        bne.s us19
us18:   tst d2
        beq.s us18a
us18z:  move.b #" ",(a0)+   ;si puissance passee: met des espaces
        bra.s us16
us18a:  move.b #"0",(a0)+   ;fin du chiffre: met un zero apres la virgule
        bra.s us16
us19:   cmp.b #"0",d0
        bcs.s us18
        cmp.b #"9",d0
        bhi.s us18
        addq.l #1,a1
        move.b d0,(a0)+
        bra us16
us20:   tst d2              ;-----> "^"
        bmi.s us24
        bne.s us25
us21:   move.b (a1),d0
        beq.s us22
        cmp.b #"E",d0
        beq.s us23
        addq.l #1,a1
        bra.s us21
us22:   move #1,d2          ;pas de puissance: en fabrique une!
        bra.s us25
us23:   move #-1,d2
us24:   move.b (a1),d0      ;si fin du chiffre: met des espaces
        beq us18
        addq.l #1,a1
        cmp.b #32,d0        ;saute l'espace entre E et +/-
        beq.s us24
        move.b d0,(a0)+
        bra us16
us25:   lea usip(pc),a3
        move.b -1(a3,d2.w),(a0)+ ;met une fausse puissance!
        cmp.b #6,d2
        beq us16
        addq #1,d2
        bra us16
finus:  clr.b usingflg(a5)
        clr.b (a0)
        rts
usip:   dc.b "E+000  "
        even

*************************************************************************
*       USING CHAINES
L42:    dc.w 0
**************
; Chaine de formattage
        move.l (a6)+,a0
        move.l buffer(a5),a1
        lea 256(a1),a1
        move.w (a0)+,d0
        beq.s l42a3
        cmp.w #127,d0
        bcs.s l42a1
        moveq #127,d0
l42a1:  subq.w #1,d0
l42a2:  move.b (a0)+,(a1)+
        dbra d0,l42a2
l42a3:  clr.b (a1)

        move.l buffer(a5),a0
        lea 128(a0),a1
        moveq #127,d0
us51:   move.b (a0)+,(a1)+  ;recopie la chaine, et fait le menage!!!
        dbra d0,us51
        move.l buffer(a5),a0
        lea 128(a0),a1          ;a1 pointe la chaine
        lea 128(a1),a2          ;a2 pointe la chaine de definition
; ecris la chaine dans le buffer
us52:   move.b (a2)+,d0
        beq.s fnusc
        cmp.b #"~",d0
        beq.s us53
        move.b d0,(a0)+
        bra.s us52
us53:   move.b (a1),d0      ;----> "~"
        bne.s us54
        move.b #32,(a0)+
        bra.s us52
us54:   addq.l #1,a1
        move.b d0,(a0)+
        bra.s us52
fnusc:  clr.b usingflg(a5)
        clr.b (a0)
        rts

*************************************************************************
*       PRINT RETOUR CHARIOT
L43:    dc.w L43a-L43,0
***********************
        move.l buffer(a5),a0
        move.b #13,(a0)
        move.b #10,1(a0)
        clr.b 2(a0)
L43a:   jmp L_impfin.l

*************************************************************************
*       PRINT VIRGULE
L44:    dc.w L44a-L44,0
***********************
        move.l buffer(a5),a0
        move.l #$20202000,(a0)
L44a:   jmp L_impfin.l

*************************************************************************
*       PI Simple precision
L45:    dc.w 0
**************
        nop

***************************************************************************
*       PI double precision
L46:    dc.w 0
**************
        move.w #F_pi,d0
        trap #6
        move.l d3,-(a6)
        move.l d4,-(a6)
        rts

*************************************************************************
*       DEG(xx) simple precision
L47:    dc.w 0
**************
        nop

*************************************************************************
*       DEG(xx) double precision
L48:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_deg,d0
        trap #6
        move.l d3,-(a6)
        move.l d4,-(a6)
        rts

************************************************************************
*       RAD(xx) simple precision
L49:    dc.w 0
**************
        nop

************************************************************************
*       RAD(xx) double precision
L50:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_rad,d0
        trap #6
        move.l d3,-(a6)
        move.l d4,-(a6)
        rts

************************************************************************
*       SINUS(xx)
L51:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_sin,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       COSINUS(xx)
L52:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_cos,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       TANGENTE(xx)
L53:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_tan,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       EXP(xx)
L54:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_exp,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       LOGN(xx)
L55:    dc.w 0
*************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_getsgn,d0
        trap #6
        tst d0
        bmi.s L55a
        move.l d3,d1
        move.l d4,d2
        moveq #F_ln,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts
L55a:   moveq #E_negative_operand,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       LOG(xx)
L56:    dc.w 0
*************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_getsgn,d0
        trap #6
        tst d0
        bmi.s L56a
        move.l d3,d1
        move.l d4,d2
        moveq #F_log,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts
L56a:   moveq #E_negative_operand,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       SQR(xx)
L57:    dc.w 0
*************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_getsgn,d0
        trap #6
        tst d0
        bmi.s L57a
        move.l d3,d1
        move.l d4,d2
        moveq #F_sqr,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts
L57a:   moveq #E_negative_operand,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       SINH(xx)
L58:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_sinh,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       COSH(xx)
L59:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_cosh,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       TANH(xx)
L60:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_tanh,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       ASIN(xx)
L61:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_asin,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       ACOS(xx)
L62:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_acos,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       ATAN(xx)
L63:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_atan,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       ABS(xx) ---> ENTIER
L64:    dc.w 0
*************
        tst.l (a6)
        bpl.s L64a
        neg.l (a6)
L64a:   rts

************************************************************************
*       ABS(xx) ---> FLOAT
L65:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_abs,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       INT(xx)
L66:    dc.w 0
*************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #F_int,d0
        trap #6
        move.l d0,-(a6)
        move.l d1,-(a6)
        rts

************************************************************************
*       SGN(xx) ---> ENTIER
L67:    dc.w 0
**************
        tst.l (a6)
        beq.s L67a
        bmi.s L67b
        moveq #1,d0
        move.l d0,(a6)
        rts
L67a:   clr.l (a6)
        rts
L67b:   moveq #-1,d0
        move.l d0,(a6)
        rts

************************************************************************
*       SGN(xx) ---> FLOAT
L68:    dc.w 0
**************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.w #F_getsgn,d0
        trap #6
        move.l d0,-(a6)
        rts

************************************************************************
*       RND(xx)
L69:    dc.w 0
**************
        move.l (a6)+,d3
        bpl.s L69a
        move.l ancrnd2(a5),-(a6)
        rts
L69a:   beq.s L69d
        move.l #$ffffff,d4
        moveq #23,d0
L69b:   lsr.l #1,d4
        cmp.l d3,d4
        dbcs d0,L69b
        roxl.l #1,d4
L69c:   move.w #17,-(sp)
        trap #14
        addq.l #2,sp
        and.l d4,d0
        cmp.l d3,d0
        bhi.s L69c
        move.l d0,-(a6)
        move.l d0,ancrnd2(a5)
        rts
L69d:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)


*************************************************************************
*       DEMANDE une certaine place pour le traitement des chaines
*       si revient, OK!
*       Sinon fait le menage!
L70:    dc.w l70a-L70,0
************************
        move.l lowvar(a5),d0
        move.l hichaine(a5),a1  ;au retour, a1 contient hichaine
        move.l a1,a0
        sub.l d3,d0
        subq.l #4,d0            ;4 octets de securite (pour la longueur)
        cmp.l a1,d0
        bcs.s l70a
        rts
l70a:   jsr L_garbage.l
        cmp.l hichaine(a5),d0
        bcs.s OutM
; Reprend … l'instruction courante
        move.l lowpile(a5),sp
        subq.l #4,sp
        move.l bufpar(a5),a6
        jmp (a4)
; Out of memory!
OutM:   moveq #E_nomem2,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       INSTR FIND: trouve une sous chaine dans une chaine a partir de d4
*       routine appelee par - chaine et INSTR
L71:    dc.w 0
**************
        tst.l d2
        beq.s instf11
        tst.l d4
        beq.s instf1
        subq.l #1,d4
instf1: add.l d4,a1         ;situe dans la chaine
instf3: clr d3
instf4: move.l a2,a3
        addq #1,d4
        cmp d1,d4
        bhi.s instf11
        cmpm.b (a1)+,(a3)+
        bne.s instf4
        move.l a1,a0
        move d4,d0
instf5: addq #1,d3
        cmp d2,d3
        bcc.s instf10
        addq #1,d0
        cmp d1,d0
        bhi.s instf11
        cmpm.b (a0)+,(a3)+
        beq.s instf5
        bra.s instf3
instf10:clr.b d2
        move.l d4,d3                  ;trouve!
        rts
instf11:clr.b d2
        moveq #0,d3
        rts

****************************************************************************
*       FONCTION LEFT$(a$,xx)
L72:    dc.w L72a-L72,0
***********************
        move.l (a6)+,d6
        move.l (a6)+,a2
        moveq #0,d2
        move.w (a2)+,d2
        moveq #0,d5
L72a:   jmp L_finmid.l

****************************************************************************
*       FONCTION RIGHT$(a$,yy)
L73:    dc.w L73a-L73,0
***********************
        move.l (a6)+,d5
        bmi.s L73b
        move.l (a6)+,a2
        moveq #0,d2
        move.w (a2)+,d2
        move.l #$ffff,d6
        cmp.l d2,d5
        bcs.s L73c
        move.l d2,d5
L73c:   neg.l d5
        add.l d2,d5
        addq.l #1,d5
L73a:   jmp L_finmid.l
L73b:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       FONCTION MID$(a$,xx)
L74:    dc.w L74a-L74,0
***********************
        move.l (a6)+,d5
        move.l (a6)+,a2
        moveq #0,d2
        move.w (a2)+,d2
        move.l #$ffff,d6
L74a:   jmp L_finmid.l

****************************************************************************
*       FONCTION MID$(a$,xx,yy)
L75:    dc.w L75a-L75,0
**********************
        move.l (a6)+,d6
        move.l (a6)+,d5
        move.l (a6)+,a2
        moveq #0,d2
        move.w (a2)+,d2
L75a:   jmp L_finmid.l

****************************************************************************
*       ROUTINE COMMUNE LEFT/RIGHT/MID
L76:    dc.w L76a-L76,0
***********************
        tst.l d5                        ;pointe au milieu de la chaine
        bmi.s L76z
        beq.s mi2
        subq.l #1,d5
mi2:    add.l d5,a2
        cmp.l d2,d5                     ;pas pointe trop loin??
        bcc.s mi9                      ;si! chaine vide
mi3:    tst.l d6
        beq.s mi9
        bmi.s L76z
mi4:    add.l d5,d6
        cmp.l d2,d6
        bls.s mi5
        move.l d2,d6
mi5:    sub.l d5,d6
mi6:    move.l d6,d3
L76a:   jsr L_malloc.l
        move d6,(a0)+                   ;poke la longueur
        subq.l #1,d6
        bmi.s mi8
mi7:    move.b (a2)+,(a0)+
        dbra d6,mi7
        move a0,d0                      ;rend pair
        btst #0,d0
        beq.s mi8
        addq.l #1,a0
mi8:    move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
mi9:    move.l chvide(a5),-(a6)         ;ramene la chaine vide
        rts
L76z:   moveq #E_illegalfunc,d0                    ;Foncall
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       ROUTINE COMMUNE LEFT/RIGHT/MID$ en INSTRUCTIONS
*       A0 contient l'adresse de la variable a changer
L77:    dc.w L77a-L77,0
***********************
        move.l (a0),a3
        moveq #0,d3
        move.w (a3)+,d3
        cmp.l lochaine(a5),a3   ;La chaine est-elle une constante?
        bcc.s L77c
        move.l a0,a2            ;Sauve l'adresse de la variable
L77a:   jsr L_malloc.l             ;Recopie la chaine dans le source
        move.l a0,(a2)          ;Change la variable
        move.w d3,d2
        move.w d2,(a0)+         ;Longueur
        subq.w #1,d2
        lsr.w #2,d2
L77b:   move.l (a3)+,(a0)+
        dbra d2,L77b
        move.l a0,hichaine(a5)
        lea 2(a1),a3
L77c:   moveq #0,d2             ;A3/D3= destination
        move.l (a6)+,a2         ;A2/D2= source
        move.w (a2)+,d2
        rts

****************************************************************************
*       LEFT(a$,xx) en INSTRUCTION
L78:    dc.w L78a-L78,L78b-L78,0
********************************
L78a:   jsr L_cimid1.l
        move.l (a6)+,d6
        moveq #0,d5
L78b:   jmp L_cimid2.l

****************************************************************************
*       RIGHT(a$,xx) en INSTRUCTION
L79:    dc.w L79a-L79,L79c-L79,0
********************************
L79a:   jsr L_cimid1.l
        move.l (a6)+,d6
        bmi.s L79z
        moveq #0,d5
        cmp.l d3,d6
        bcc.s L79b
        move.l d3,d5
L79b:   sub.l d6,d5
        addq.l #1,d5
L79c:   jmp L_cimid2.l
L79z:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       MID$(a$,xx) en INSTRUCTION
L80:    dc.w L80a-L80,L80b-L80,0
********************************
L80a:   jsr L_cimid1.l
        move.l (a6)+,d5
        move.l #$ffff,d6
L80b:   jmp L_cimid2.l

****************************************************************************
*       MID$(a$,xx,yy) en INSTRUCTION
L81:    dc.w L81a-L81,L81b-L81,0
********************************
L81a:   jsr L_cimid1.l
        move.l (a6)+,d6
        move.l (a6)+,d5
L81b:   jmp L_cimid2.l

****************************************************************************
*       Routine commune LEFT/RIGHT/MID en INSTRUCTION (II)
L82:    dc.w 0
***********************
        tst.l d5
        bmi.s L82z
        beq.s mdst2
        subq.l #1,d5
mdst2:  add.l d5,a3             ;situe dans la chaine a changer
        cmp.l d3,d5
        bcc.s mdst10            ;trop loin: ne change rien
        tst.l d6
        bmi.s L82z              ;on prend zero caracteres: rien!
        beq.s mdst10
        add.l d5,d6
        cmp.l d3,d6
        bls.s mdst3
        move.l d3,d6
mdst3:  sub.l d5,d6
        cmp.l d2,d6             ;limite par la taille de la chaine source
        bls.s mdst4
        move.l d2,d6
mdst4:  subq.l #1,d6            ;la chaine source est nulle!
        bmi.s mdst10
mdst5:  move.b (a2)+,(a3)+
        dbra d6,mdst5
mdst10: rts
L82z:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       INSTR(a$,b$)
L83:    dc.w L83a-L83,0
***********************
        moveq #0,d2
        move.l (a6)+,a2
        move.w (a2)+,d2
        moveq #0,d1
        move.l (a6)+,a1
        move.w (a1)+,d1
        moveq #0,d4
L83a:   jsr L_instrfind.l
        move.l d3,-(a6)
        rts

****************************************************************************
*       INSTR(a$,b$,xx)
L84:    dc.w L84a-L84,0
***********************
        move.l (a6)+,d4
        bmi.s L84b
        moveq #0,d2
        move.l (a6)+,a2
        move.w (a2)+,d2
        moveq #0,d1
        move.l (a6)+,a1
        move.w (a1)+,d1
L84a:   jsr L_instrfind.l
        move.l d3,-(a6)
        rts
L84b:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       FLIP$(a$)
L85:    dc.w L85a-L85,0
***********************
        moveq #0,d3
        move.l (a6)+,a3
        move.w (a3),d3
        bne.s L85a
        move.l a3,-(a6)
        rts
L85a:   jsr L_malloc.l
        addq.l #2,a3
        move.w d3,(a0)+
        add.l d3,a3
        subq #1,d2
flp1:   move.b -(a3),(a0)+
        dbra d3,flp1
        move.w a0,d0
        btst #0,d0
        beq.s flp2
        addq.l #1,a0
flp2:   move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts

****************************************************************************
*       LEN(a$)
L86:    dc.w 0
**************
        move.l (a6)+,a2
        moveq #0,d2
        move.w (a2)+,d2
        move.l d2,-(a6)
        rts

****************************************************************************
*       SPACE$(xx)
L87:    dc.w L87a-L87,0
***********************
        move.l (a6)+,d3
        move.w #$2020,d1
L87a:   jmp L_fstring.l

****************************************************************************
*       STRING$("a",xx)
L88:    dc.w L88b-L88,0
***********************
        move.l (a6)+,d3
        move.l (a6)+,a2
        move.w (a2)+,d2
        bne.s L88a
        moveq #0,d3
        bra.s L88b
L88a:   move.b (a2),d1
        lsl.w #8,d1
        move.b (a2),d1
L88b:   jmp L_fstring.l

****************************************************************************
*       SUITE et FIN de SPACE$ et STRING$
L89:    dc.w L89a-L89,0
***********************
        tst.l d3
        bmi.s L89z
L89a:   jsr L_malloc.l
        move.l a0,-(a6)
        move.w d3,(a0)+
        beq.s L89c
        subq.w #1,d3
        lsr.w #1,d3
L89b:   move.w d1,(a0)+
        dbra d3,L89b
L89c:   move.l a0,hichaine(a5)
        rts
L89z:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       CHR$(xx)
L90:    dc.w L90a-L90,0
***********************
        move.l (a6)+,d2
        cmp.l #$100,d2
        bcc.s L90z
        lsl.w #8,d2
        moveq #1,d3
L90a:   jsr L_malloc.l
        move.l a0,-(a6)
        move.w d3,(a0)+
        move.w d2,(a0)+
        move.l a0,hichaine(a5)
        rts
L90z:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       ASC(a$)
L91:    dc.w 0
**************
        moveq #0,d0
        move.l (a6)+,a2
        move.w (a2)+,d0
        beq.s L91a
        move.b (a2),d0
L91a:   move.l d0,-(a6)
        rts

****************************************************************************
*       BIN$(xx)
L92:    dc.w L92a-L92,0
***************************
        move.l (a6)+,d1
        moveq #-1,d2
        moveq #33,d3
L92a:   jmp L_binhex.l

****************************************************************************
*       BIN$(xx,yy)
L93:    dc.w L93a-L93,0
***********************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #33,d3
L93a:   jmp L_binhex.l

****************************************************************************
*       HEX$(xx)
L94:    dc.w L94a-L94,0
***********************
        move.l (a6)+,d1
        moveq #-1,d2
        moveq #9,d3
L94a:   jmp L_binhex.l

****************************************************************************
*       HEX$(xx,yy)
L95:    dc.w L95a-L95,0
***********************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #9,d3
L95a:   jmp L_binhex.l

****************************************************************************
*       ROUTINE pour BIN et HEX
L96:    dc.w l96a-L96,hx2-L96,hx3-L96,hx4-L96,0
***************************************
l96a:   jsr L_malloc.l
        move.l d1,d0
        exg d2,d3
        lea 2(a0),a0        ;laisse la place pour la longueur
        cmp #9,d2
        bne.s hx3
hx2:    jsr L_longascii.l
        bra.s hx4
hx3:    jsr L_longbin.l
hx4:    jmp L_finbin.l

****************************************************************************
*       LONGASCII: entier---> hexa ascii
*       Poke dans (A0)+
L97:    dc.w 0
**************
        move.b #"$",(a0)+
        tst.l d3
        bmi.s ha0
        neg.l d3
        addq.l #8,d3
ha0:    clr d4
        move #7,d2
ha1:    rol.l #4,d0
        move.b d0,d1
        andi.b #$0f,d1
        cmp.b #10,d1
        bcs.s ha2
        addq.b #7,d1
ha2:    tst.l d3
        beq.s ha4
        bpl.s ha3
        tst d4
        bne.s ha4
        tst d2
        beq.s ha4
        tst.b d1
        beq.s ha5
        move #1,d4
        bra.s ha4
ha3:    subq.l #1,d3
        bra.s ha5
ha4:    addi.w #48,d1
        move.b d1,(a0)+
ha5:    dbra d2,ha1
        rts

****************************************************************************
*       LONGBIN ---> MOT LONG +++> asci binaire
*       Poke dans (a0)+
L98:    dc.w 0
**************
        move.b #"%",(a0)+
        tst.l d3
        bmi.s hb0
        neg.l d3
        addi.l #32,d3
hb0:    clr d4
        move #31,d2
hb1:    clr d1
        roxl.l #1,d0
        addx.b d1,d1
        tst.l d3            ;si d3<0: representation PROPORTIONNELLE
        beq.s hb3
        bpl.s hb2
        tst d4
        bne.s hb3
        tst d2
        beq.s hb3
        tst.b d1
        beq.s hb4
        move #1,d4
        bra.s hb3
hb2:    subq.l #1,d3
        bra.s hb4
hb3:    addi.b #48,d1
        move.b d1,(a0)+
hb4:    dbra d2,hb1
        rts

****************************************************************************
*       FINBIN: ROUTINE de fin de HEX/BIN/STR$
L99:    dc.w 0
**************
        move.l a0,d0        ;rend pair
        btst #0,d0
        beq.s hx5
        addq.l #1,d0
hx5:    move.l d0,hichaine(a5)
        sub.l a1,a0
        subq.l #2,a0
        move a0,(a1)        ;poke la longueur
        move.l a1,-(a6)     ;Ramene la chaine
        rts

****************************************************************************
*       STR$(xx) ---> entier
L100:   dc.w l100a-L100,l100b-L100,l100c-L100,0
***********************************************
        moveq #16,d3
l100a:  jsr L_malloc.l
        lea 2(a0),a0
        moveq #-1,d3
        moveq #1,d4
        move.l a1,-(sp)
        move.l (a6)+,d0
l100b:  jsr L_longdec.l
        move.l (sp)+,a1
l100c:  jmp L_finbin.l

****************************************************************************
*       STR$(xx) ---> floats
L101:   dc.w l101a-L101,l101b-L101,l101c-L101,0
***********************************************
        moveq #40,d3
l101a:  jsr L_malloc.l
        lea 2(a0),a0
        move.l a1,-(sp)
        move.w fixflg(a5),d0
l101b:  jsr L_strflasc.l
        move.l (sp)+,a1
l101c:  jmp L_finbin.l

***************************************************************************
*       CHVERBUF
L102:   dc.w 0
**************
        moveq #0,d2
        move.l (a6)+,a2
        move.w (a2)+,d2
        move.l a2,a1
        move.l buffer(a5),a0
        move.w d2,d0
        subq.w #1,d0
        bmi.s L102b
        cmp.w #509,d0
        bcs.s L102a
        move.w #508,d0
L102a:  move.b (a1)+,(a0)+
        dbra d0,L102a
L102b:  clr.b (a0)
        rts

****************************************************************************
*       VAL(a$) ---> RAMENE UN entier / float
L103:   dc.w l103a-L103,l103b-L103,0
*********************************************************
l103a:  jsr L_chverbuf.l
        move.l a6,-(sp)
        move.l buffer(a5),a6
l103b:  jsr L_valprg.l
        move.l (sp)+,a6
        tst.b d2                        ;D2= FLAG
        bne.s l103c
        move.l d1,-(a6)                 ;ENTIER si pas de FLOAT
        rts
l103c:  move.l d0,-(a6)                 ;FLOAT si FLOAT
        move.l d1,-(a6)
        rts

****************************************************************************
*       CONVERSION DECIMAL---> HEXA / ENTIERS
L104:   dc.w dh1-L104,0
**************
        clr.l d0
        clr.l d2
        clr d3
        move.l a6,a0
dh1:    jsr L_minichr.l
dh1a:   cmp.b #10,d2
        bcc.s dh5
        move d0,d1
        mulu #10,d1
        swap d0
        mulu #10,d0
        swap d0
        tst d0
        bne.s dh2
        add.l d1,d0
        bcs.s dh2
        add.l d2,d0
        bmi.s dh2
        addq #1,d3
        bra.s dh1
dh2:    move.l a0,a6
        moveq #1,d1         ;out of range: bpl, et recupere l'adresse
        rts
dh5:    subq.l #1,a6
        tst d3
        beq.s dh7
        clr d1              ;OK: chiffre en d0, et beq
        rts
dh7:    moveq #-1,d1        ;pas de chiffre: bmi
        rts

****************************************************************************
*       CONVERSION HEXA-ASCII EN HEXA-HEXA
L105:   dc.w hh1-L105,0
***********************
        clr.l d0
        clr d2
        clr d3
        move.l a6,a0
hh1:    jsr L_minichr.l
        cmp.b #10,d2
        bcs.s hh2
        cmp.b #17,d2
        bcs.s hh3
        subq.w #7,d2
hh2:    cmp.b #16,d2
        bcc.s hh3
        lsl.l #4,d0
        or.b d2,d0
        addq #1,d3
        cmp #9,d3
        bne.s hh1
        move.l a0,a6
hh4:    moveq #1,d1
        rts
hh3:    subq.l #1,a6
        tst d3
        beq.s hh4
        clr d1              ;OK: chiffre en d0, et beq
        rts

****************************************************************************
*       CONVERSION BINAIRE ASCII ---> HEXA SUR QUATRE OCTETS
L106:   dc.w bh1-L106,0
***********************
        clr.l d0
        clr d2
        clr d3
        move.l a6,a0
bh1:    jsr L_minichr.l
        cmp.b #2,d2
        bcc.s bh2
        roxr #1,d2
        roxl.l #1,d0
        bcs.s bh3
        addq #1,d3
        cmp #33,d3
        bne.s bh1
        move.l a0,a6
        moveq #1,d1
        rts
bh2:    subq.l #1,a6
        tst d3
        beq.s bh3
        clr d1              ;OK: chiffre en d0, et beq
        rts
bh3:    move.l a0,a6
        moveq #1,d1
        rts

****************************************************************************
*       MINICHRGET called by conversions
L107:   dc.w 0
**************
mc:     move.b (a6)+,d2
        beq.s mc1
        cmp.b #32,d2
        beq.s mc
        cmp.b #"a",d2       ;si minuscule: majuscule
        bcs.s mc0
        subi.b #"a"-"A",d2
mc0:    subi.b #48,d2
        rts
mc1:    move.b #-1,d2
        rts

****************************************************************************
*       FOR pour ENTIERS
L108:   dc.w 0
**************
        move.l (a6)+,20(a2)             ;Step
        move.l (a6)+,14(a2)             ;Limite
        move.l (a6)+,8(a2)              ;Ad variable
        move.l (sp),2(a2)               ;Ad boucle
        rts

****************************************************************************
*       FOR pour FLOATS
L109:   dc.w 0
**************
        move.l (a6)+,32(a2)             ;Step
        move.l (a6)+,26(a2)
        move.l (a6)+,20(a2)             ;Limite
        move.l (a6)+,14(a2)
        move.l (a6)+,8(a2)              ;Ad variable
        move.l (sp),2(a2)               ;address loop start
        rts

****************************************************************************
*       NEXT pour ENTIERS
L110:   dc.w 0
**************
        add.l d2,(a3)                   ;Var=Var+Step
        tst.l d2
        bmi.s L110b
; Step positive
        cmp.l (a3),d1
        blt.s L110a
        move.l a2,(sp)                  ;Reload the start of the loop
L110a:  rts
; Step negative
L110b:  cmp.l (a3),d1
        bgt.s L110a
        move.l a2,(sp)
        rts

****************************************************************************
*       NEXT pour FLOATS
L111:   dc.w 0
**************
        move.l (a3),d1
        move.l 4(a3),d2
        move.w #F_add,d0
        trap #6
        move.l d0,(a3)+
        move.l d1,(a3)
        move.l d1,d2
        move.l d0,d1
        move.l d1,-(sp)         ;Signe de la step
        move.l d2,-(sp)
        move.w #F_getsgn,d0
        trap #6
        move.l (sp)+,d2
        move.l (sp)+,d1
        tst.w d0
        bpl.s L111a
        moveq #F_lt,d0
        bra.s L111b
L111a:  moveq #F_gt,d0
L111b:  move.l d6,d4
        move.l d5,d3
        trap #6
        tst.w d0
        bne.s L111c
        move.l a2,(sp)
L111c:  rts


*************************************************************************
*       RAZPRG of program addresses
L112:   dc.w l112a-L112,l112b-L112,0
**************************
        clr.l printpos(a5)      ;Pas de print
l112a:  jsr L_restore.l                 ;Restore
l112b:  jsr L_setdta.l

        move.w #1,actualise(a5)
        move.w #1,autoback(a5)
        move.w #-1,fixflg(a5)

        clr mnd+14(a5)
        clr mnd+98(a5)
        lea mnd+100(a5),a0
        moveq #9,d0
l112r:  clr.l (a0)+
        dbra d0,l112r

        rts

*************************************************************************
*       WHILE / WEND
L113:   dc.w 0
***************
        tst.l (a6)+
        bne.s L113a
        move.l a2,(sp)
L113a:  rts

*************************************************************************
*       REPEAT / UNTIL
L114:   dc.w 0
***************
        tst.l (a6)+
        bne.s L114a
        move.l a2,(sp)
L114a:  rts

*************************************************************************
*       GOTO variable
L115:   dc.w 0
**************
        move.l liad(a5),a0
        move.l (a6)+,d0
L115a:  cmp.w (a0),d0
        lea 6(a0),a0
        beq.s L115b
        bcc.s L115a
        moveq #E_undefined_line,d0
        move.l error(a5),a0
        jmp (a0)
L115b:  move.l -4(a0),(sp)
        rts

*************************************************************************
*       GOSUB variable
L116:   dc.w 0
**************
        move.l liad(a5),a0
        move.l (a6)+,d0
L116a:  cmp.w (a0),d0
        lea 6(a0),a0
        beq.s L116b
        bcc.s L116a
        moveq #E_undefined_line,d0
        move.l error(a5),a0
        jmp (a0)
L116b:  move.l -4(a0),a0
        jmp (a0)

*************************************************************************
*       RETURN
L117:   dc.w 0
***************
        move.l lowpile(a5),a0
        lea -4(a0),sp
        cmp.l spile(a5),sp
        beq.s L117z
        lea 4(a0),a0
        move.l a0,lowpile(a5)
        rts
L117z:  moveq #E_missing_gosub,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       POP
L118:   dc.w 0
***************
        move.l (sp),a1
        move.l lowpile(a5),a0
        lea -4(a0),sp
        cmp.l spile(a5),sp
        beq.s L118z
        lea 4(a0),a0
        move.l a0,lowpile(a5)
        addq.l #4,sp
        jmp (a1)
L118z:  moveq #E_pop_gosub,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ON GOTO
L119:   dc.w 0
***************
        move.l (a6)+,d1
        beq.s L119a
        bmi.s L119a
        cmp.l d0,d1
        bhi.s L119a
        subq.w #1,d1
        move.l d1,d2                    ;Fois 6
        add.w d1,d2
        add.w d1,d2
        lsl.w #1,d2
        addq.w #4,d2                    ;Saute le BRA
        add.l d2,(sp)
L119a:  rts

*************************************************************************
*       ON GOSUB
L120:   dc.w 0
***************
        move.l (a6)+,d1
        beq.s L120a
        bmi.s L120a
        cmp.l d0,d1
        bhi.s L120a
        subq.w #1,d1
        move.l d1,d2                    ;Fois 6
        add.w d1,d2
        add.w d1,d2
        lsl.w #1,d2
        addq.w #4,d2                    ;Saute le BRA
        lea 4(sp),a0                    * Correction du bug!
        move.l a0,lowpile(a5)
        move.l (sp),a0
        add.l d2,a0
        jmp (a0)
L120a:  rts

*************************************************************************
*       SET TIMER
L121:   dc.w 0
***************
        move.l (a6)+,timer(a5)
        rts

*************************************************************************
*       GET TIMER
L122:   dc.w 0
***************
        move.l timer(a5),-(a6)
        rts

*************************************************************************
*       TESTS CYCLIQUES
L123:   dc.w 0
***************
        tst.b interflg(a5)
        bmi.s L123a
        rts
L123a:  and.b #$7f,interflg(a5)
        beq.s L123c
        btst #0,interflg(a5)
        beq.s L123b
; Break!
        bclr #0,interflg(a5)
        tst.w brkinhib(a5)
        bne.s L123b
        moveq #E_break,d0
        move.l error(a5),a0
        jmp (a0)
; Actualise les sprites?
L123b:  tst.w actualise(a5)
        beq.s L123c
        movem.l d0-d1/a0,-(sp)
        moveq #S_actualise,d0
        trap #5
        movem.l (sp)+,d0-d1/a0
        bclr #1,interflg(a5)
L123c:
; TEST DES MENUS
        tst mnd(a5)         ;menu en route?
        bne.s mt1
        rts
mt1:    bmi.s mt4           ;menu automatique ???
; manuel
        move.l a0,-(sp)
        move.l adm(a5),a0
        btst #0,7(a0)       ;touche appuyee?
        bne.s mt2
        clr mnd+6(a5)
        move.l (sp)+,a0
        rts
mt2:    move.l (sp)+,a0
        tst mnd+6(a5)         ;pas de rebond?
        beq.s mt3
        rts
mt3:    move #1,mnd+6(a5)     ;dans la barre?
; automatique
mt4:    movem.l d0-d7/a0-a6,-(sp)
        move.l adm(a5),a6
        move mnd+8(a5),d0
        cmp 2(a6),d0
        bcs.s finm            ;compare en Y
        lea mnd+66(a5),a0     ;trouve le choix en X
        move (a6),d0
        clr d1
mt6:    tst (a0)
        beq.s finm
        cmp (a0),d0
        bcs.s mt7
        addq.l #2,a0
        addq #1,d1
        cmp #10,d1
        bne.s mt6
finm:   movem.l (sp)+,d0-d7/a0-a6
        rts
; d1 contient le choix
mt7:    move.l admenu(a5),a0
        jmp (a0)

*************************************************************************
*       FIN SOUS STOS
L124:   dc.w L124a-L124,0
***************
L124a:  jsr L_delete.l
        move.l spile(a5),sp
        rts

*************************************************************************
*       FIN SOUS GEM
L125:   dc.w l125a-L125,0
**************************
l125a:  jsr L_delete.l
        move.l oend(a5),a0
        jmp (a0)

*************************************************************************
*       TREATMENT OF ERRORS
L126:   dc.w l126a-L126,0
***************
        move.w d0,-(sp)
; Flags ---> ZERO
l126a:  jsr L_closys.l                      ;Ferme le fichier systeme
        clr.w sortflg(a5)
        clr.w inputflg(a5)
        move.l adlogic(a5),$44e
; Erreurs detournees?
        move.w (sp)+,d0
        move.w d0,errornb(a5)
        tst.l printpos(a5)
        beq.s PaPr
        move.l printpos(a5),a4          ;debut du print
        clr.l printpos(a5)
PaPr:   move.l a4,errorchr(a5)
        move.l a4,errorline(a5)
        tst.w erroron(a5)
        bne.s L126z
        tst.l onerrline(a5)
        beq.s L126z
; Les erreurs sont detournees
        cmp.w #17,d0                    ;Ne detourne pas le break!
        beq.s L126z
        move.w #1,erroron(a5)
        move.l lowpile(a5),sp           ;Bas de la pile
        subq.l #4,sp
        move.l bufpar(a5),a6            ;Bas des parametres
        move.l onerrline(a5),a0         ;JMP nouvelle ligne
        jmp (a0)
; Les erreurs ne sont pas detournees
L126z:  rts

*************************************************************************
*       NON-DIVERTED ERRORS / STOS
L127:   dc.w l127a-L127,0
**************************
        move.w d0,-(sp)

;; Debug
;        move.l errorchr(a5),d0
;        move.l liad(a5),a0
;L127d:  cmp.w #-1,(a0)
;        beq.s L127a
;        cmp.l 2(a0),d0                  ;1ere ligne ou D0>=AD
;        bcs.s L127b
;        lea 6(a0),a0
;        bra.s L127d
;L127b:  move.w -6(a0),$ffff0
;        move.l #-1,$f8000
;        move.l #-1,$f8004

l127a:  jsr L_delete.l
        clr.l onerrline(a5)             ;Empeche le PLANTAGE du basic!
        clr.w erroron(a5)
        clr.w errornb(a5)
        clr.w runflg(a5)                ;Pas de numero de ligne!
        move.w (sp)+,d0
        move.l table(a5),a0
        move.l sys_error(a0),a0
        jmp (a0)

*************************************************************************
*       NON-DIVERTED ERRORS / GEM
L128:   dc.w l128a-L128,l128b-L128,l128c-L128,l128d-L128,0
*************************************************************
        cmp.w #E_break,d0                    ;Pas le break
        beq.s l128d
; Affiche un message d'erreur
        move.w d0,-(sp)
l128a:  jsr L_defgem.l                         ;DEFAULT
        lea MEGem1(pc),a0
        moveq #W_prtstring,d7
        trap #3
        moveq #0,d6
        move.w (sp)+,d6
        divu #100,d6
        move.w d6,d0
        addi.w #'0',d0
        moveq #W_chrout,d7
        trap #3
        swap d6
        divu #10,d6
        move.w d6,d0
        addi.w #'0',d0
        trap #3
        swap d6
        move.w d6,d0
        addi.w #'0',d0
        trap #3
        lea MEGem2(pc),a0
        moveq #W_prtstring,d7
        trap #3
l128b:  jsr L_clearkey.l
l128c:  jsr L_waitkey.l
; Termine tout / revient au GEM
l128d:  jsr L_delete.l
        move.l oend(a5),a0
        jmp (a0)
MEGem1: dc.b "Error #",0
MEGem2: dc.b ", press any key.",0
        even

***************************************************************************
*       FERME LE FICHIER SYSTEME
L129:   dc.w 0
***************
        move.w handle(a5),d0
        beq.s L129a
        clr.w handle(a5)
        move.w d0,-(sp)
        move.w #$3e,-(sp)
        trap #1
        addq.l #4,sp
L129a:  rts

*************************************************************************
*       ON ERROR GOTO
L130:   dc.w 0
***************
        move.l (a6)+,d0
        beq.s L130d
; Trouve le # de ligne
        cmp.l #65535,d0
        bcc.s L130b
        move.l liad(a5),a0
L130a:  cmp.w (a0),d0
        lea 6(a0),a0
        beq.s L130c
        bcc.s L130a
L130b:  moveq #E_undefined_line,d0
        move.l error(a5),a0
        jmp (a0)
L130c:  move.l -4(a0),d0
L130d:  move.l d0,onerrline(a5)
        rts

************************************************************************
*       ERROR xx
L131:   dc.w 0
***************
        move.l (a6)+,d0
        cmp.l #86,d0
        bcs.s L131a
        moveq #E_illegalfunc,d0
L131a:  move.l error(a5),a0
        jmp (a0)

************************************************************************
*       RESUME #LINE
L132:   dc.w 0
***************
        move.l (a6)+,d0
        tst.w erroron(a5)
        beq.s L132z
; Trouve le # de ligne
        cmp.l #65535,d0
        bcc.s L132b
        move.l liad(a5),a0
L132a:  cmp.w (a0),d0
        lea 6(a0),a0
        beq.s L132c
        bcc.s L132a
L132b:  moveq #E_undefined_line,d0
        move.l error(a5),a0
        jmp (a0)
L132c:  move.l -4(a0),(sp)
        clr.l errorline(a5)
        clr.w errornb(a5)
        clr.w erroron(a5)
        rts
L132z:  moveq #E_resume,d0                    ;Resume without error
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       RESUME seul
L133:   dc.w 0
***************
        tst.w erroron(a5)
        beq.s L133z
        clr.l errorline(a5)
        clr.w errornb(a5)
        clr.w erroron(a5)
        move.l errorchr(a5),(sp)
        rts
L133z:  moveq #E_resume,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       RESUME NEXT
L134:   dc.w 0
***************
        tst.w erroron(a5)
        beq.s L134z
        move.l errorchr(a5),a0
        addq.l #4,a0
L134a:  cmp.l #$49fafffe,(a0)           ;Cherche le prochain LEA
        beq.s L134b
        addq.l #2,a0
        bra.s L134a
L134b:  clr.l errorline(a5)
        clr.w errornb(a5)
        clr.w erroron(a5)
        move.l a0,(sp)
        rts
L134z:  moveq #E_resume,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       ERRL
L135:   dc.w 0
***************
        tst.w erroron(a5)
        beq.s L135z
        move.l errorchr(a5),d0
        move.l liad(a5),a0
L135a:  cmp.w #$ffff,(a0)
        beq.s L135z
        cmp.l 2(a0),d0                  ;1ere ligne ou D0>=AD
        bcs.s L135b
        lea 6(a0),a0
        bra.s L135a
L135b:  moveq #0,d0
        move.w -6(a0),d0
        move.l d0,-(a6)
        rts
L135z:  clr.l -(a6)
        rts

************************************************************************
*       ERRN
L136:   dc.w 0
***************
        moveq #0,d0
        move.w errornb(a5),d0
        move.l d0,-(a6)
        rts

************************************************************************
*       BREAK OFF
L137:   dc.w 0
***************
        move.w #1,brkinhib(a5)
        rts

************************************************************************
*       BREAK ON
L138:   dc.w 0
***************
        clr.w brkinhib(a5)
        rts

************************************************************************
*       MAX pour ENTIERS
L139:   dc.w 0
***************
        move.l (a6)+,d0
        cmp.l (a6),d0
        ble.s L139a
        move.l d0,(a6)
L139a:  rts

************************************************************************
*       MAX pour FLOATS
L140:   dc.w 0
***************
        move.l (a6),d4
        move.l 4(a6),d3
        move.l 8(a6),d2
        move.l 12(a6),d1
        moveq #F_ge,d0
        trap #6
        tst.l d0
        bne.s L140a
        move.l (a6),8(a6)
        move.l 4(a6),12(a6)
L140a:  addq.l #8,a6
        rts

************************************************************************
*       MAX pour CHAINES
L141:   dc.w L141a-L141,0
**************************
L141a:  jsr L_compch.l
        subq.l #4,a6
        cmp.w d3,d6
        beq.s L141b
        tst.w d3
        beq.s L141b
        move.l -4(a6),(a6)
L141b:  rts

************************************************************************
*       MIN pour ENTIERS
L142:   dc.w 0
***************
        move.l (a6)+,d0
        cmp.l (a6),d0
        bge.s L142a
        move.l d0,(a6)
L142a:  rts

************************************************************************
*       MIN pour FLOATS
L143:   dc.w 0
***************
        move.l (a6),d4
        move.l 4(a6),d3
        move.l 8(a6),d2
        move.l 12(a6),d1
        moveq #F_ge,d0
        trap #6
        tst.l d0
        beq.s L143a
        move.l (a6),8(a6)
        move.l 4(a6),12(a6)
L143a:  addq.l #8,a6
        rts

************************************************************************
*       MIN pour CHAINES
L144:   dc.w L144a-L144,0
**************************
L144a:  jsr L_compch.l
        subq.l #4,a6
        cmp.w d3,d6
        beq.s L144b
        tst.w d3
        bne.s L144b
        move.l -4(a6),(a6)
L144b:  rts

*************************************************************************
*       UPPER$
L145:   dc.w L145a-L145,0
**************************
        move.l (a6)+,a2
        moveq #0,d3
        move.w (a2)+,d3
        beq.s fnup4
L145a:  jsr L_malloc.l
        move.w d3,(a0)+
        subq #1,d3
fnup1:  move.b (a2)+,d0
        cmp.b #"A",d0
        bcs.s fnup2
        cmp.b #"Z",d0
        bhi.s fnup2
        addi.b #$20,d0
fnup2:  move.b d0,(a0)+
        dbra d3,fnup1
        move.w a0,d0
        btst #0,d0
        beq.s fnup3
        addq.l #1,a0
fnup3:  move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
fnup4:  move.l chvide(a5),-(a6)
        rts

*************************************************************************
*       LOWER$
L146:   dc.w L146a-L146,0
**************************
        move.l (a6)+,a2
        moveq #0,d3
        move.w (a2)+,d3
        beq.s fnlw4
L146a:  jsr L_malloc.l
        move.w d3,(a0)+
        subq #1,d3
fnlw1:  move.b (a2)+,d0
        cmp.b #"a",d0
        bcs.s fnlw2
        cmp.b #"z",d0
        bhi.s fnlw2
        subi.b #$20,d0
fnlw2:  move.b d0,(a0)+
        dbra d3,fnlw1
        move.w a0,d0
        btst #0,d0
        beq.s fnlw3
        addq.l #1,a0
fnlw3:  move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
fnlw4:  move.l chvide(a5),-(a6)
        rts

***************************************************************************
*       ROUTINE TIME / pour TIME / DIR FIRST / DIR NEXT
L147:   dc.w l147a-L147,l147b-L147,l147c-L147,0
************************************************
        move.l a1,-(sp)
        rol #5,d7
        move d7,d0
        andi.l #%11111,d0
        moveq #2,d3
        moveq #0,d4
l147a:  jsr L_longdec.l
        move.b #":",(a0)+
        rol #6,d7
        move d7,d0
        andi.l #%111111,d0
        moveq #2,d3
        moveq #0,d4
l147b:  jsr L_longdec.l
        move.b #":",(a0)+
        rol #5,d7
        move d7,d0
        lsl #1,d0
        andi.w #%111111,d0
        moveq #2,d3
        moveq #0,d4
l147c:  jsr L_longdec.l
tim1:   move.l (sp)+,a1
        rts

****************************************************************************
*       ROUTINE pour DATE$ : DATE$ / DIR FIRST / DIR NEXT$
L148:   dc.w l148a-L148,l148b-L148,l148c-L148,0
*************************************************
        move.l a1,-(sp)
        move d7,d0
        andi.l #%11111,d0
        moveq #2,d3
        moveq #0,d4
l148a:  jsr L_longdec.l
        move.b #"/",(a0)+
        lsr #5,d7
        move.b d7,d0
        andi.l #%1111,d0
        moveq #2,d3
        moveq #0,d4
l148b:  jsr L_longdec.l
        move.b #"/",(a0)+
        lsr #4,d7
        move.b d7,d0
        andi.l #$7f,d0
        addi.l #1980,d0
        moveq #4,d3
        moveq #0,d4
l148c:  jsr L_longdec.l              ;annee
        move.l (sp)+,a1
        rts

****************************************************************************
*       TIME$ en fonction
L149:   dc.w l149a-L149,l149b-L149,0
*************************************
        move.w #$2c,-(sp)
        trap #1
        move.w d0,(sp)
        moveq #8,d3
l149a:  jsr L_malloc.l
        lea 8+2(a0),a2
        move.l a2,hichaine(a5)
        move.w #8,(a0)+
        move.w (sp)+,d7
l149b:  jsr L_timebis.l
        move.l a1,-(a6)
        rts

****************************************************************************
*       DATE en fonction
L150:   dc.w l150a-L150,l150b-L150,0
*************************************
        move.w #$2a,-(sp)
        trap #1
        move.w d0,(sp)
        moveq #10,d3
l150a:  jsr L_malloc.l
        lea 10+2(a0),a2
        move.l a2,hichaine(a5)
        move.w #10,(a0)+
        move.w (sp)+,d7
l150b:  jsr L_datebis.l
        move.l a1,-(a6)
        rts

****************************************************************************
*       SETTIME: fixe l'heure
L151:   dc.w l151a-L151,l151b-L151,l151c-L151,l151d-L151,0
***********************************************************
l151a:  jsr L_chverbuf.l
        move.l a6,-(sp)
        move.l buffer(a5),a6       ;pointe la chaine
l151b:  jsr L_declong.l
        bne.s badt
        andi.w #%11111,d0
        move d0,d7
        lsl #6,d7           ;heure
        bsr.s svtime
        beq.s badt
l151c:  jsr L_declong.l
        bne.s badt
        andi.w #%111111,d0
        or d0,d7
        lsl #5,d7           ;minutes
        bsr.s svtime
        beq.s badt
l151d:  jsr L_declong.l
        bne.s badt
        lsr #1,d0
        andi.w #%11111,d0
        or d0,d7            ;secondes
        move.w d7,-(sp)
        move.w #$2d,-(sp)
        trap #1             ;set time
        addq.l #4,sp
        tst d0
        bmi.s badt
        move.l (sp)+,a6
        rts
badt:   move.l (sp)+,a6
        moveq #E_badtime,d0
        move.l error(a5),a0
        jmp (a0)
; sous programme
svtime: move.b (a6)+,d0
        beq.s svtt
        cmp.b #32,d0
        beq.s svtime
svtt:   rts

**************************************************************************
*       SET DATE: fixe la date
L152:   dc.w l152a-L152,l152b-L152,l152c-L152,l152d-L152,0
***********************************************************
l152a:  jsr L_chverbuf.l
        move.l a6,-(sp)
        move.l buffer(a5),a6       ;pointe la chaine
l152b:  jsr L_declong.l
        bne.s badd
        andi.w #%11111,d0      ;jour
        move d0,d7
        ror #5,d7
        bsr.s svdate
        beq.s badd
l152c:  jsr L_declong.l
        bne.s badd
        andi.w #%1111,d0       ;mois
        or d0,d7
        ror #4,d7
        bsr.s svdate
        beq.s badd
l152d:  jsr L_declong.l
        bne.s badd
        subi.w #1980,d0
        andi.w #%1111111,d0    ;annee
        or d0,d7
        ror #7,d7
        move d7,-(sp)
        move #$2b,-(sp)
        trap #1             ;set date
        addq.l #4,sp
        tst d0
        bmi.s badd
        move.l (sp)+,a6
        rts
badd:   move.l (sp)+,a6
        moveq #E_baddate,d0
        move.l error(a5),a0
        jmp (a0)
; sous programme
svdate: move.b (a6)+,d0
        beq.s svdt
        cmp.b #32,d0
        beq.s svdate
svdt:   rts

**************************************************************************
*       INPUT#1: print the string
L153:   dc.w 0
***************
        move.l (a6)+,a2
        move.w (a2)+,d2
        beq.s l153b
        subq.w #1,d2
        move.w #W_chrout,d7
l153a:  move.b (a2)+,d0
        trap #3
        dbra d2,l153a
l153b:  move.b #255,d0
        move.w #W_chrout,d7
        trap #3
        move.l bufpar(a5),a6            ;RAZ params
        rts

**************************************************************************
*       INPUT#2: print the question mark
L154:   dc.w 0
***************
        move.b #"?",d0
        move.w #W_chrout,d7
        trap #3
        move.b #255,d0
        trap #3
        move.l bufpar(a5),a6
        rts

**************************************************************************
*       INPUT#3: entry of a string on the keyboard
L155:   dc.w L155a-L155,L155b-L155,0
*************************************
        move.w d0,d6            ;nombre de variables
        move.l bufpar(a5),a6    ;RAZ params
        clr.w orinput(a5)
input3: clr d2                  ;position du curseur
        move.l buffer(a5),a1
rtin0:  movem.l d2-d3/d6/a1,-(sp)
L155a:  jsr L_key.l
        movem.l (sp)+,d2-d3/d6/a1
        tst.b d1
        beq.s rtin15            ;code ascii direct
        bmi.s rtin20
; filtrage des mouvements du curseur
rtin1:  cmp.b #8,d0
        bne.s rtin0
        tst d2                  ;backspace ?
        beq.s rtin0
        subq #1,d2
        clr.b 0(a1,d2.w)
        moveq #3,d0
        move.w #W_chrout,d7
        trap #3
        moveq #' ',d0
        trap #3
        moveq #3,d0
        trap #3
        bra.s rtin0
; code ascii normal
rtin15: cmp.w #255,d2           ;pas plus de 255 caracteres
        bcc.s rtin0
        move.b d0,0(a1,d2.w)
        addq #1,d2
        clr.b 0(a1,d2.w)
        move.w #W_chrout,d7
        trap #3                 ;envoi a la trappe
        bra rtin0
; code special: seul accepte=return
rtin20: cmp.b #$80,d1
        bne rtin0
        clr.b 0(a1,d2.w)        ;un espace a la fin!
; Va evaluer le buffer
L155b:  jsr L_finput.l
        bne.s input3            ;il faut retester?
        move.l bufpar(a5),a6    ;RAZ params
        rts

**************************************************************************
*       INPUT#4: input from file
L156:   dc.w l156a-L156,l156b-L156,l156c-L156,0
**************************************
        move.w d0,d6            ;nombre de variables
        move.l bufpar(a5),a6    ;RAZ params
        move.w #1,orinput(a5)
; remplis le buffer
inpd0:  move.l oradinp(a5),a2   ;recupere la position du fichier
        move #511,d1            ;ne prend que 512 octets
        move inputype(a5),d2
        move flginp(a5),d3
        move chrinp(a5),d4
        move.l buffer(a5),a3
inpd1:
l156a:  jsr L_getbyte.l
        tst.b d2
        beq.s inpd1a
        cmp.b d2,d0         ;input normal: stop aux virgules
        beq.s inpd3
inpd1a: tst.b d3            ;pas de caractere special: 13/10
        bne.s inpd1c
        cmp.b #13,d0        ;stop toujours a return
        beq.s inpd2
inpd1b: move.b d0,(a3)+
        dbra d1,inpd1
        bra l156z           ;input too long!
inpd1c: cmp.b d4,d0
        bne.s inpd1b
        bra.s inpd3
inpd2:
l156b:  jsr L_getbyte.l         ;saute le #10 apres
inpd3:  clr.b (a3)
; Va evaluer le buffer
l156c:  jsr L_finput.l
        bne.s inpd0             ;il faut retester?
        move.l bufpar(a5),a6    ;RAZ params
        rts
l156z:  moveq #E_input_too_long,d0
        move.l error(a5),a0
        jmp (a0)

**************************************************************************
*       FINPUT: evaluation du buffer charge
L157:   dc.w l157a-L157,l157b-L157,l157c-L157,0
************************************************
        move.l buffer(a5),a2
ipu4a:  move.w -2(a6),d2
        tst.b d2
        bpl.s ipu10
; variable alphanumerique
        move.l #500,d3
l157a:  jsr L_malloc.l
        addq.l #2,a0        ;place pour la taille
        clr d1
        move inputype(a5),d4
ipu5:   move.b (a2)+,d0
        beq.s ipu6
        cmp.b d0,d4
        beq.s ipu6
        addq #1,d1
        move.b d0,(a0)+
        bra.s ipu5
ipu6:   subq.l #1,a2        ;reste sur le dernier caractere
        move.w d1,(a1)      ;poke la longueur
        move a0,d0
        btst #0,d0
        beq.s ipu7
        addq.l #1,a0
ipu7:   move.l a0,hichaine(a5)
        move.w -(a6),d0
        move.l -(a6),a0
        move.l a1,(a0)      ;egalisation de la variable!
        bra ipu15
; variable numerique
ipu10:  move.l a6,-(sp)
        move.w d6,-(sp)
        move.l a2,a6
l157b:  jsr L_valprg.l                      ;Ramene un FLOAT!
        move.l a6,a2
        move.w (sp)+,d6
        move.l (sp)+,a6
        move.w -(a6),d5
        move.l -(a6),a3
        clr d3
        move.b (a2),d3
        beq.s ipu11
        cmp inputype(a5),d3
        bne.s ipu12
; Egalise les types
ipu11:  cmp.b d2,d5
        bne.s Ipu
        tst.b d5
        bne.s Ipua
        beq.s Ipuc
Ipu:    tst.b d5
        beq.s Ipub
        moveq #F_ltof,d0                ;INT---> FLOAT
        trap #6
Ipua:   move.l d0,(a3)+
        move.l d1,(a3)
        bra.s ipu15
Ipub:   move.l d1,d2
        move.l d0,d1
        moveq #F_ftol,d0                   ;FLOAT ---> INT
        trap #6
Ipuc:   move.l d0,(a3)
        bra.s ipu15
; redo from start
ipu12:  tst orinput(a5)         ;si vient du disque: type mismatch
        bne.s l157z
        lea redo(pc),a0
l157c:  jsr L_traduit.l         ;va traduire
        moveq #W_prtstring,d7
        trap #3                 ;affichage du message
        move.l a4,(sp)          ;debut de l'input
        rts                     ;Recommence!
l157z:  moveq #E_typemismatch,d0            ;type mismatch
        move.l error(a5),a0
        jmp (a0)
; passage a la variable suivante
ipu15:  subq.w #1,d6            ;encore une variable?
        beq.s ipu20             ;fini!
        cmp.b #",",(a2)+        ;encore une variable disponible?
        beq ipu4a
; ??
        tst orinput(a5)         ;si vient du disque: n'ecris rien
        bne.s ipu22
        lea encore(pc),a0       ;affiche deux points d'interrogation
        moveq #W_prtstring,d7
        trap #3
ipu22:  moveq #1,d0             ;Il faut retester le clavier!
        rts
; fini!
ipu20:  tst orinput(a5)         ;pas de RETURN si vient du disque
        bne.s ipu23
        move.w #W_chrout,d7                ;a la ligne
        moveq #13,d0
        trap #3
        moveq #10,d0
        trap #3
ipu23:  moveq #0,d0
        rts
encore: dc.b 13,10,"?? ",0
redo:   dc.b 13,10,"Please redo from start.",13,10,0
        dc.b 13,10,"Recommencer au d‚but S.V.P.",13,10,0
        even

**************************************************************************
*       VALPRG: sous programme appele par VAL et INPUT
L158:   dc.w l158a-L158,l158b-L158,l158c-L158,0
***********************************************
        move.l a6,-(sp)     ;sauve l'adresse du chiffre si erreur!
        clr d4              ;signe
; y-a-t'il un signe devant?
val1:   move.b (a6)+,d0     ;saute les espaces au debut
        beq val10
        cmp.b #32,d0
        beq.s val1
        move.l a6,a2        ;pointe le premier caractere non nul
        subq.l #1,a2
        cmp.b #"-",d0
        bne.s val1a
        not d4
        bra.s val1c
val1a:  cmp.b #"+",d0
        beq.s val1c
val1b:  subq.l #1,a6
; est-ce un HEXA ou un BINAIRE?
val1c:  move.b (a6),d0
        beq val10
        cmp.b #32,d0
        beq.s val1c
        cmp.b #"$",d0       ;chiffre HEXA
        beq val5
        cmp.b #"%",d0       ;chiffre BINAIRE
        beq val6
        cmp.b #".",d0
        beq.s val2
        cmp.b #"0",d0
        bcs val10
        cmp.b #"9",d0
        bhi val10
; c'est un chiffre DECIMAL: entier ou float?
val2:   move.l a6,a0        ;si float: trouve la fin du chiffre
        clr d3
val3:   move.b (a0)+,d0
        beq.s val4
        cmp.b #32,d0
        beq.s val3
        cmp.b #"0",d0
        bcs.s val3z
        cmp.b #"9",d0
        bls.s val3
val3z:  cmp.b #".",d0       ;cherche une "virgule"
        bne.s val3a
        tst.w flola(a5)     ;Arrete le chiffre ICI si pas float!
        beq.s val3s
        bset #0,d3          ;si deux virgules: fin du chiffre
        beq.s val3
        bne.s val4
val3a:  cmp.b #"e",d0       ;cherche un exposant
        beq.s val3b
        cmp.b #"E",d0       ;autre caractere: fin du chiffre
        bne.s val4
val3ab: move.b #"e",-1(a0)  ;met un E minuscule!!!
val3b:  tst.w flola(a5)
        beq.s val3s
        move.b (a0)+,d0     ;apres un E, accepte -/+ et chiffres
        cmp.b #32,d0
        beq.s val3b
        cmp.b #"+",d0
        beq.s val3c
        cmp.b #"-",d0
        bne.s val3e
val3c:  bset #1,d3          ;+ ou -: c'est un float!
val3d:  move.b (a0)+,d0     ;puis cherche la fin de l'exposant
        cmp.b #32,d0
        beq.s val3d
val3e:  cmp.b #"0",d0
        bcs.s val4
        cmp.b #"9",d0       ;chiffre! c'est un float
        bls.s val3c
val4:
; conversion ASCII--->FLOAT
        tst.w flola(a5)     ;Si pas de FLOAT.LIB ----> entier
        beq.s val7
        subq.l #1,a0        ;pointe la fin du chiffre
        clr.b (a0)          ;arrete la conversion ICI!
        move.l a0,a6        ;Bonne conversion!
        move.l a2,a0        ;pointe le debut du chiffre
        move #F_atof,d0
        trap #6             ;conversion ASCII--->float
        move.w #$40,d2
        bra.s Valf
; chiffre hexa
val5:   addq.l #1,a6
l158a:  jsr L_hexalong.l
        bra.s val8
; chiffre binaire
val6:   addq.l #1,a6
l158b:  jsr L_binlong.l
        bra.s val8
; chiffre FLOAT---> entier
val3s:  clr.b -(a0)
val7:
l158c:  jsr L_declong.l
val8:   tst d1
        bne.s val10           ;si probleme: ramene zero!
; test du signe
        tst d4
        beq.s val8a
        neg.l d0
; si FLOAT present, transforme en FLOAT ---> resultat en D0/D1
; sinon ---> D1 = resultat
val8a:  move.l d0,d1
        clr.b d2
        tst.w flola(a5)
        beq.s Valf
        moveq #F_ltof,d0
        trap #6
        move.b #$40,d2
Valf:   addq.l #4,sp
        moveq #0,d3
        rts
; ramene zero / erreur / repointe le debut du chiffre
val10:  clr.b d2
        moveq #0,d1
        tst.w flola(a5)
        beq.s Valf1
        moveq #F_ltof,d0
        trap #6
        move.b #$40,d2
Valf1:  move.l (sp)+,a6
        moveq #1,d3
        rts

****************************************************************************
*       TRADUIT
L159:   dc.w 0
***************
        tst language(a5)
        beq.s trad2
trad1:  tst.b (a0)+
        bne.s trad1
trad2:  rts

****************************************************************************
*       KEY: test des touches et des touches de fonction
L160:   dc.w l160a-L160,l160b-L160,l160c-L160,0
************************************************
ki:     move funckey(a5),d0
        beq.s k0
        subq #1,d0
        move.l buffunc(a5),a0
        move.b 0(a0,d0.w),d0
        beq.s fct2
        cmp.b #'`',d0
        beq.s fct1
        clr d1
        addq.w #1,funckey(a5)
        rts
fct1:   move.b #13,d0       ;ascii: return
        move.b #$80,d1      ;special: return
        clr funckey(a5)
        rts
fct2:   clr funckey(a5)
;attente d'une touche avec actualisation des touches de fonction
k0:     move.w #-1,-(sp)    ;test des shifts et capslock
        move.w #11,-(sp)
        trap #13
        addq.l #4,sp
        move d0,d2
; Jamais de souris!
        andi.w #$3,d2          ;isolement des shifts
        cmp shift(a5),d2
        beq.s k2
        move d2,shift(a5)
l160a:  jsr L_affonc.l          ;reaffichage des touches de fonction
k2:     clr mousflg(a5)
l160b:  jsr L_tester.l
l160c:  jsr L_incle.l           ;INKEY$
        tst.l d0
        beq k0              ;NON! on boucle

        move shift(a5),d1
        andi.w #$0003,d1       ;isolation des shifts
        beq.s k5
        lea scanshft(pc),a0
        bra.s k6
k5:     lea scan(pc),a0
k6:     clr d1
        swap d0             ;code ascii en D0
        move.b d0,d1        ;scancode en d1
        swap d0
        move.b 0(a0,d1.w),d1  ;correspondance tables du clavier en D1
        cmp #32,d1
        blt.s k7
        cmp #64,d1
        bge.s k7
        subi.w #32,d1          ;appui sur une touche de fonction
k9:     mulu #40,d1
        addq #1,d1
        move d1,funckey(a5)
        bra ki              ;commence a lire la table
k7:     rts

; clavier non shifte
scan:     dc.b $00,$82,$00,$00,$00,$00,$00,$00    ;0-7
          dc.b $00,$00,$00,$00,$00,$00,$08,$83    ;8-f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;10-17
          dc.b $00,$00,$00,$00,$80,$00,$00,$00    ;18-1f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;20-27
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;28-2f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;30-37
          dc.b $00,$00,$00,$20,$21,$22,$23,$24    ;38-3f
          dc.b $25,$26,$27,$28,$29,$00,$00,$1e    ;40-47
          dc.b $0b,$00,$00,$03,$00,$09,$00,$00    ;48-4f
          dc.b $0a,$00,$81,$1a,$2a,$2b,$2c,$2d    ;50-57
          dc.b $2e,$2f,$30,$31,$32,$33,$00,$00    ;58-5f
          dc.b $00,$85,$84,$00,$00,$00,$00,$00    ;60-67
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;68-6f
          dc.b $00,$00,$80,$00,$00,$00,$00,$00    ;70-77
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;78-7f
; clavier shifte:
scanshft: dc.b $00,$82,$00,$00,$00,$00,$00,$00    ;0-7
          dc.b $00,$00,$00,$00,$00,$00,$08,$83    ;8-f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;10-17
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;18-1f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;20-27
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;28-2f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;30-37
          dc.b $00,$00,$00,$20,$21,$22,$23,$24    ;38-3f
          dc.b $25,$26,$27,$28,$29,$00,$00,$0c    ;40-47
          dc.b $0b,$00,$00,$01,$00,$02,$00,$00    ;48-4f
          dc.b $0a,$00,$81,$18,$2a,$2b,$2c,$2d    ;50-57
          dc.b $2e,$2f,$30,$31,$32,$33,$00,$00    ;58-5f
          dc.b $00,$85,$84,$00,$00,$00,$00,$00    ;60-67
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;68-6f
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;70-77
          dc.b $00,$00,$00,$00,$00,$00,$00,$00    ;78-7f

****************************************************************************
*       INKEY$: retour d0.l: 0 si rien
L161:   dc.w 0
***************
        movem.l d1-d7/a0-a6,-(sp)
        move.w #2,-(sp)
        move.w #1,-(sp)
        trap #13            ;caractere disponible au clavier?
        addq.l #4,sp
        tst d0
        bne.s ic
        movem.l (sp)+,d1-d7/a0-a6
        clr.l d0
        rts
ic:     move.w #2,-(sp)     ;OUI: on va le chercher
        move.w #2,-(sp)
        trap #13            ;conin
        addq.l #4,sp
        movem.l (sp)+,d1-d7/a0-a6
        rts

****************************************************************************
*       AFFICHAGE DES TOUCHES DE FONCTION
L162:   dc.w 0
********************************
        move.l a6,-(sp)
        tst mnd+12(a5)
        bne af10              ;les menus sont actives!
        tst foncon(a5)
        beq af10              ;les touches ne sont pas en route!
        move #W_getcurwindow,d7
        trap #3                 ;getcourante
        move d0,-(sp)
        move #15,d0
        move #W_qwindon,d7
        trap #3                 ;activation rapide: windon #15
        move.l defloat(a5),a6
        move.b #30,(a6)+        ;Home
af1:    move shift(a5),d1       ;position des shifts
        andi.w #$3,d1              ;isolement des shifts (pas la peine!)
        bne.s af0
        clr d0
        clr d1
        bra.s af05
af0:    move #50,d0
        move #400,d1
af05:   move.l funcname(a5),a3
        lea 0(a3,d0.w),a3       ;a3 pointe le NOM des touches
        move.l buffunc(a5),a1
        lea 0(a1,d1.w),a1       ;a1 pointe sur les touches de fonction
        tst mode(a5)
        beq.s af2
        move #10,d2
        bra.s af3
af2:    move #6,d2              ;limite en base resolution
af3:    move #1,d1
af4:    move.b #32,(a6)+        ;deux blancs au debut de la ligne
        move.b #32,(a6)+
af5:    move.l a1,a2
        clr d3
        tst mode(a5)
        beq.s af6
        move.b #21,(a6)+        ;inverse ON
        move.l a3,a0
af5a:   move.b (a0)+,(a6)+      ;poke le nom
        bne.s af5a
        subq.l #1,a6
af6:    move.b (a2)+,d0
        beq.s af7
        move.b d0,(a6)+
        addq #1,d3
        cmp d2,d3
        blt.s af6
        bge af8
af7:    cmp d2,d3               ;bourre de #32--->10 caracteres
        bge.s af8
        move.b #32,(a6)+
        addq #1,d3
        bra.s af7

af8:    move.b #18,(a6)+        ;blanc normal entre les touches
        move.b #32,(a6)+
        addq #1,d1              ;touche suivante
        add #40,a1
        addq.w #5,a3
        cmp #6,d1
        blt.s af5
        bne.s af9
        move.b #32,(a6)+        ;fin de la ligne
        bra af4
af9:    cmp #11,d1
        bne af5
        clr.b (a6)
        move.l defloat(a5),a0   ;affichage rapide de toutes les touches
        move #W_prtstring,d7
        trap #3
        move (sp)+,d0
        move #W_qwindon,d7
        trap #3                 ;reactivation rapide de la fenetre de travail
af10:   move.l (sp)+,a6
        rts

*************************************************************************
*       Dimensionnage d'un tableau
*       A0= adresse pointeur
*       D0= nb de dimension-1
*       D1= nb de shifts (2 ou 3)
*       D2= flag
L163:   dc.w L163c-L163,0
**************************
        move.w d0,d7
        move.l a0,a2
; Calcule la taille totale du tableau
        move.l a6,a3
        move.l (a3)+,d3
        cmp.l #65536,d3
        bcc L163z
        addq.l #1,d3
        subq.w #1,d0
        bmi.s L163b
L163a:  move.l (a3)+,d4
        addq.l #1,d4
        cmp.l #65536,d3
        bcc L163z
        cmp.l #65536,d4
        bcc.s L163z
        mulu d4,d3
        dbra d0,L163a
L163b:  move.l d3,d6                    ;Nombre d'elements
        lsl.l d1,d3                     ;Taille totale!
        beq.s L163z
L163c:  jsr L_malloc.l
; Place pour le tableau
        move.l lowvar(a5),a0            ;Bas tableaux
        sub.l d3,a0                     ;- taille tableaux
        move.w d7,d0
        lsl.w #2,d0
        sub.w d0,a0                     ;- taille dimensions
        subq.l #2,a0                    ;- dimension 0
        subq.l #8,a0                    ;- nb dim / shifts / nb elm
        move.l a0,lowvar(a5)
        move.l himem(a5),a1             ;Offset HIMEM/TABLEAU
        sub.l a0,a1
        move.l a1,(a2)
; Poke le tableau
        move.w d7,(a0)+                 ;Nb de dimensions
        move.w d1,(a0)+                 ;Nb shifts
        move.l d6,(a0)+                 ;Nb elements
        move.l (a6)+,d0
        addq.w #1,d0
        move.w d0,(a0)+                 ;Taille maxi derniere dim
        move.w d0,d1
        subq.w #1,d7
        bmi.s L163e
L163d:  move.l (a6)+,d0
        addq.w #1,d0
        move.w d0,(a0)+                 ;Max pour la DIM
        move.w d1,(a0)+                 ;Puis multiplicateur
        mulu d0,d1
        dbra d7,L163d
L163e:  tst.b d2
        beq.s L163g
        bmi.s L163h
; Raz tableau FLOAT
        move.l zerofl(a5),d0            ;Prend le ZERO!
        move.l zerofl+4(a5),d1
L163f:  move.l d0,(a0)+
        move.l d1,(a0)+
        subq.l #1,d6
        bne.s L163f
        rts
; Raz tableau ENTIER
L163g:  clr.l (a0)+
        subq.l #1,d6
        bne.s L163g
        rts
; Raz tableau CHAINES
L163h:  move.l chvide(a5),d0
L163i:  move.l d0,(a0)+
        subq.l #1,d6
        bne.s L163i
        rts
; Erreur!
L163z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       Pointe une variable tableau
*       A0= adresse (distance HIMEM / TABLEAU)
L164:   dc.w 0
***************
        move.l himem(a5),a1
        sub.l (a0),a1                   ;Adresse du tableau
        move.w (a1)+,d0                 ;Nb dims-1
        move.w (a1)+,d1                 ;Nb shifts
        addq.l #4,a1                    ;Saute le nb d'elements

        moveq #0,d3
        moveq #0,d5
        move.l (a6)+,d4
        move.w (a1)+,d5
        cmp.l d5,d4
        bcc.s L164z
        move.l d4,d3
        subq.w #1,d0
        bmi.s L164b
L164a:  move.l (a6)+,d4
        move.w (a1)+,d5
        cmp.l d5,d4
        bcc.s L164z
        mulu (a1)+,d4
        add.l d4,d3
        bcs.s L164z
        dbra d0,L164a
L164b:  lsl.l d1,d3
        lea 0(a1,d3.l),a0               ;Ramene l'adresse!
        rts
L164z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       Fait le menage
L165:   dc.w 0
***************
;-------------------------------> Fait le menage ! VITE !
        movem.l d0-d7/a0-a6,-(sp)

        move.l buffer(a5),d5
        addi.l #512,d5                  ;debut TI
        move.l d5,d6
        addi.l #64*8,d6                  ;Fin TI
        move.l lochaine(a5),d7          ;Ad mini de recopie
        move.l d7,a1

Men0:   move.l adstr(a5),a6             ;Table des ad strings
        moveq #-1,d2                    ;Maxi dans le tableau
        moveq #0,d4                     ;Cpt tableau---> 0
        move.l d5,d3                    ;Rien dans la TI
        move.l d3,a0
        move.l #$ffffff,(a0)
; Rempli la table intermediaire
Men1:   move.l (a6)+,d0
        beq.s Men20
        bmi.s Men2
        move.l d0,a3                    ;Variable simple
        bra.s Men5
Men2:   bclr #31,d0                     ;Variables tableau
        move.l d0,a0
        move.l (a0),d0                  ;Tableau dimensionne?
        beq.s Men1
        move.l himem(a5),a4
        sub.l d0,a4
        move.w (a4)+,d0
        addq.l #2,a4
        move.l (a4)+,d4                 ;Nb d'elements
        addq.l #2,a4
        lsl.w #2,d0
        add.w d0,a4
Men3:   move.l a4,a3                    ;Entree tableau
        addq.l #4,a4
        subq.l #1,d4
; Essai de poker dans la TI
Men5:   move.l (a3),d0
        cmp.l d7,d0                     ;< au minimum?
        bcs.s Men10
        cmp.l d2,d0                     ;>= au maximum?
        bcc.s Men10
        move.l d5,a0
Men6:   cmp.l (a0),d0
        lea 8(a0),a0
        bcc.s Men6
        cmp.l d6,a0
        bne.s Men7
        move.l d0,d2                    ;C'est le dernier element!
        move.l d6,d3
        bra.s Men9
Men7:   move.l d3,a1                    ;Decale les adresses au dessus
        cmp.l d6,d3
        bcs.s Men7a
        lea -8(a1),a1
        move.l -8(a1),d2                ;Remonte la limite haute
        bra.s Men8
Men7a:  addq.l #8,d3
        move.l #$ffffff,8(a1)
Men8:   move.l -(a1),8(a1)
        move.l -(a1),8(a1)
        cmp.l a0,a1
        bcc.s Men8
Men9:   move.l a3,-(a0)                 ;Poke dans la table
        move.l d0,-(a0)
Men10:  tst.l d4
        bne.s Men3
        beq.s Men1

; Recopie toutes les chaines du buffer
Men20:  move.l d5,a3                    ;Adresse TI
        move.l d7,a1                    ;Adresse de recopie
        moveq #0,d7
Men21:  cmp.l d3,a3                     ;Fini-ni?
        bcc.s Men26
        move.l (a3),a0                  ;Adresse de la chaine
        lea 8(a3),a3
        cmp.l a0,d7                     ;Chaine deja bougee?
        beq.s Men25
        move.l a0,d7
        cmp.l a0,a1                     ;Au meme endroit?
        bne.s Men22
; Les 2 chaines sont au meme endroit!
        move.l a1,d1
        moveq #0,d0
        move.w (a1)+,d0
        add.l d0,a1
        move.w a1,d0
        btst #0,d0
        beq.s Men21
        addq.l #1,a1
        bra.s Men21
; Recopie la chaine
Men22:  move.l -4(a3),a2                ;Change la variable
        move.l a1,(a2)
        move.l a1,d1
        move.w (a0)+,d0                 ;Recopie la chaine
        beq.s Men24
        move.w d0,(a1)+
        subq.w #1,d0
        lsr.w #1,d0
Men23:  move.w (a0)+,(a1)+
        dbra d0,Men23
        bra.s Men21
; Chaine vide au milieu: pointe la vraie
Men24:  move.l chvide(a5),d1
        move.l d1,(a2)
        bra.s Men21
; La variable pointait la meme chaine que la precedente
Men25:  move.l -4(a3),a2
        move.l d1,(a2)
        bra.s Men21
; Est-ce completement fini?
Men26:  cmp.l d6,d3                     ;buffer TI rempli?
        bcs.s FinMen                    ;NON---> c'est fini!

;-----> Reexplore les variables a la recherche de la DERNIERE CHAINE
        move.l adstr(a5),a6             ;Table des ad strings
        moveq #0,d4                     ;Cpt tableau---> 0
; Prend la variable
Men31:  move.l (a6)+,d0
        beq.s Men40
        bmi.s Men32
        move.l d0,a3                    ;Variable simple
        bra.s Men35
Men32:  bclr #31,d0                     ;Variables tableau
        move.l d0,a0
        move.l (a0),d0                  ;Tableau deja dimensionne?
        beq.s Men31
        move.l himem(a5),a4
        sub.l d0,a4
        move.w (a4)+,d0
        addq.l #2,a4
        move.l (a4)+,d4                 ;Nb d'elements
        addq.l #2,a4
        lsl.w #2,d0
        add.w d0,a4
Men33:  move.l a4,a3                    ;Entree tableau
        addq.l #4,a4
        subq.l #1,d4
; La variable pointe elle la meme chaine?
Men35:  cmp.l (a3),d7
        beq.s Men36
        tst.l d4
        bne.s Men33
        beq.s Men31
Men36:  move.l d1,(a3)
        tst.l d4
        bne.s Men33
        beq.s Men31

;-----> Refait un tour!
Men40:  move.l a1,d7                    ;Monte la limite <
        bra Men0

;-----> Menage fini!
FinMen: move.l a1,hichaine(a5)
        movem.l (sp)+,d0-d7/a0-a6
        rts

*************************************************************************
*       FREE
L166:   dc.w L166a-L166,0
**************************
L166a:  jsr L_garbage.l
        move.l lowvar(a5),d0
        sub.l hichaine(a5),d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       RESTORE
L167:   dc.w 0
***************
        clr.l datad(a5)
        move.l datastart(a5),d0
        cmp.l debut(a5),d0
        beq.s L167a
        move.l d0,datad(a5)
L167a:  rts

*************************************************************************
*       RESTORE constante
L168:   dc.w 0
***************
        cmp.w #$6000,(a2)               ;Code BRA
        bne.s L168z
        addq.l #4,a2
        move.l a2,datad(a5)
        rts
L168z:  moveq #E_nodata,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       RESTORE expression
L169:   dc.w 0
***************
        move.l liad(a5),a0
        move.l (a6)+,d0
L169a:  cmp.w (a0),d0
        lea 6(a0),a0
        beq.s L169b
        bcc.s L169a
        moveq #E_undefined_line,d0
        move.l error(a5),a0
        jmp (a0)
L169b:  move.l -4(a0),a2
        cmp.w #$6000,(a2)
        bne.s L169c
        addq.l #4,a2
        move.l a2,datad(a5)
        rts
L169c:  moveq #E_nodata,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       READ
L170:   dc.w l170a-L170,l170b-L170,0
*************************************
        move.l datad(a5),d1
        beq l170x
        move.l a0,-(sp)         ;Pousse l'ad variable
        move.w d0,-(sp)         ;et le flag
        move.l d1,a1
l170r:  jsr (a1)                ;Ramene l'expression!
        cmp.b #2,d0
        beq.s l170i
        move.l a2,datad(a5)     ;Pointe le data suivant
        cmp.b #1,d0
        beq.s l170f
; Compare les TYPES
        move.w (sp)+,d1
        cmp.b d0,d1
        beq.s l170c
        tst.b d0
        bmi.s l170y
        tst.b d1
        bmi.s l170y
        bne.s l170b
; Transforme en INT / egalise
l170a:  jsr L_fltoint.l
        move.l (sp)+,a0
        move.l (a6)+,(a0)
        rts
; Transforme en FLOAT / egalise
l170b:  jsr L_inttofl.l
        move.l (sp)+,a0
        move.l (a6)+,4(a0)
        move.l (a6)+,(a0)
        rts
; Types egaux
l170c:  move.l (sp)+,a0
        tst.b d0
        bmi.s l170d
        bne.s l170e
l170d:  move.l (a6)+,(a0)
        rts
l170e:  move.l (a6)+,4(a0)
        move.l (a6)+,(a0)
        rts
; CODE 1 ---> DATA VIDE
l170f:  move.w (sp)+,d1
        move.l (sp)+,a0
        tst.b d1
        beq.s l170g
        bmi.s l170h
; Float
        clr.l (a0)+
l170g:  clr.l (a0)
        rts
; Chaine
l170h:  move.l chvide(a5),(a0)
        rts
; CODE 2 ---> FIN DE LA LIGNE
l170i:  cmp.l debut(a5),a2
        beq.s l170x
        move.l a2,datad(a5)
        move.l a2,a1
        bra.s l170r
; No more datas
l170x:  moveq #34,d0
        bra.s l170z
; Type mismatch
l170y:  moveq #E_typemismatch,d0
l170z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CLICK OFF
L171:   dc.w 0
***************
        move.b #3,bip(a5)
        rts

*************************************************************************
*       CLICK ON
L172:   dc.w 0
***************
        clr.b bip(a5)
        rts

*************************************************************************
*       KEY OFF
L173:   dc.w l173a-L173,0
**************************
        tst.w foncon(a5)
        beq.s l173b
        clr.w foncon(a5)
        tst.w mnd+12(a5)
        bne.s l173b
l173a:  jsr L_modebis.l
l173b:  rts

*************************************************************************
*       KEY ON
L174:   dc.w L174a-L174,0
**************************
        tst.w foncon(a5)
        bne.s L174b
        move.w #1,foncon(a5)
        tst.w mnd+12(a5)
        bne.s L174b
L174a:  jsr L_modebis.l
L174b:  rts

*************************************************************************
*       KEY (xx)="kkkkkkkkkkk"
L175:   dc.w l175a-L175,0
********************************
        move.l (a6)+,a2
        move.l (a6)+,d3
        beq.s l175z
        cmp.l #20,d3
        bhi.s l175z
        subq.l #1,d3
        mulu #40,d3
        add.l buffunc(a5),d3
        move.l d3,a0
        move.w (a2)+,d2
        beq.s ky2
        cmp #38,d2
        bcs.s ky1
        moveq #38,d2
ky1:    move.b (a2)+,(a0)+
        subq #1,d2
        bne.s ky1
ky2:    clr.b (a0)
l175a:  jsr L_affonc.l          ;reaffiche les touches de fonction
        rts
l175z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

****************************************************************************
*       =FKEY
L176:   dc.w L176a-L176,0
**************************
L176a:  jsr L_incle.l
        moveq #0,d3
        tst.l d0
        beq.s fky5
        swap d0
        move.b d0,d3
        cmp.b #59,d3
        bcs.s fky5
        cmp.b #69,d3
        bcc.s fky1
        subi.b #58,d3
        move.l d3,-(a6)
        rts
fky1:   cmp.b #84,d3
        bcs.s fky5
        cmp.b #94,d3
        bcc.s fky5
        subi.b #73,d3
fky5:   move.l d3,-(a6)
        rts

***************************************************************************
*       INKEY
L177:   dc.w L177a-L177,L177b-L177,0
*************************************
L177a:  jsr L_incle.l               ;ramene le caractere en d0.l
        tst.l d0
        beq.s ik1
        move d0,d2
        swap d0
        move d0,scankey(a5)     ;poke le scan-code
        moveq #2,d3
L177b:  jsr L_malloc.l
        move.w #1,(a0)+
        move.b d2,(a0)+
        clr.b (a0)+
        move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
ik1:    clr scankey(a5)         ;pas de touche disponible
        move.l chvide(a5),-(a6)
        rts

*************************************************************************
*       SCANCODE
L178:   dc.w 0
***************
        moveq #0,d0
        move.w scankey(a5),d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       CLEARKEY
L179:   dc.w l179a-L179,0
***************
l179a:  jsr L_incle.l
        tst.l d0
        bne.s l179a
        clr funckey(a5)        ;plus de touche de fonction!
        rts

*************************************************************************
*       PUTKEY
L180:   dc.w 0
***************
        move.l (a6)+,a2
        move.w (a2)+,d2
        cmp #63,d2
        bcc.s L180z
        subq #1,d2
        bcs.s putk3
        move.l buffunc(a5),a0
        lea 40*20(a0),a0
putk1:  move.b (a2)+,d0
        cmp.b #32,d0
        bcc.s putk2
        move.b #32,d0
putk2:  move.b d0,(a0)+
        dbra d2,putk1
        clr.b (a0)
        move.w #40*20+1,funckey(a5)
putk3:  rts
L180z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       WAITKEY
L181:   dc.w l181a-L181,l181b-L181,0
*************************************
l181a:  jsr L_tester.l
l181b:  jsr L_incle.l
        tst.l d0
        beq.s l181a
        rts

*************************************************************************
*       SWAP ---> entier/alphnumeriques
L182:   dc.w 0
***************
        move.l (a6)+,a1
        move.l (a0),d0
        move.l (a1),(a0)
        move.l d0,(a1)
        rts

*************************************************************************
*       SWAP ---> float
L183:   dc.w 0
***************
        move.l (a6)+,a1
        move.l (a0),d0
        move.l 4(a0),d1
        move.l (a1),(a0)
        move.l 4(a1),4(a0)
        move.l d0,(a1)
        move.l d1,4(a1)
        rts

*************************************************************************
*       GET TABLO
L184:   dc.w 0
***************
        move.w d0,d2                    ;Type en D2
        move.l (a0),d0
        beq.s l184z
        move.l himem(a5),a1             ;Ad de debut du tableau
        sub.l d0,a1
        move.w (a1)+,d0
        move.w (a1)+,d7                 ;Nb de decalages
        move.l (a1)+,d6                 ;Nb d'elements
        addq.l #2,a1
        lsl.w #2,d0
        add.w d0,a1                     ;Pointe le 1er element
        rts
l184z:  moveq #E_noarray,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SOUS PRG POUR SORT / MATCH ---> SUPBIS
L185:   dc.w l185c-L185,0
**************************
        beq.s l185a
        bmi.s l185b
; Float
        moveq #F_gt,d0
        move.l d6,d1
        move.l d7,d2
        trap #6
        rts
; Entiers
l185a:  cmp.l d3,d6
        bgt.s l185v
l185f:  moveq #0,d0
        rts
l185v:  moveq #-1,d0
        rts
; Chaines
l185b:  move.l d6,-(a6)
        move.l d3,-(a6)
l185c:  jsr L_compch.l
        cmp.w d3,d6
        bgt.s l185v
        bra.s l185f

*************************************************************************
*       SOUS PRG POUR SORT / MATCH ---> EGBIS
L186:   dc.w l186c-L186,0
**************************
        beq.s l186a
        bmi.s l186b
; Float
        moveq #F_eq,d0
        move.l d6,d1
        move.l d7,d2
        trap #6
        rts
; Entiers
l186a:  cmp.l d3,d6
        beq.s l186v
l186f:  moveq #0,d0
        rts
l186v:  moveq #-1,d0
        rts
; Chaines
l186b:  move.l d6,-(a6)
        move.l d3,-(a6)
l186c:  jsr L_compch.l
        cmp.w d3,d6
        beq.s l186v
        bra.s l186f

*************************************************************************
*       SORT
L187:   dc.w L187a-L187,L187b-L187,0
**************************************
L187a:  jsr L_getablo.l                     ;Params du tableau
        move.l d6,d3
or4:    lsr.l #1,d3         ;E=d3
        beq.s or10
        moveq #1,d5         ;NA=d5
or5:    move.l d5,d4        ;NR=d4 -> NR=NA
or6:    movem.l d3-d7/a1,-(sp)
        move.l a1,a0
        subq.l #1,d4
        lsl.l d7,d4
        add.l d4,a0
        move.l a0,a1
        lsl.l d7,d3
        add.l d3,a1
        move.l (a0),d6      ;n$(nr)
        move.l 4(a0),d7
        move.l (a1),d3      ;n$(nr+e)
        move.l 4(a1),d4
        movem.l d2/a0-a1,-(sp)
        move.b d2,d5
L187b:  jsr L_supbis.l          ;va comparer
        movem.l (sp)+,d2/a0-a1
        tst.l d0
        beq.s or8
; fait le swap
        tst.b d2
        beq.s or7
        bmi.s or7
        move.l 4(a0),d0
        move.l 4(a1),4(a0)
        move.l d0,4(a1)
or7:    move.l (a0),d0
        move.l (a1),(a0)
        move.l d0,(a1)
        movem.l (sp)+,d3-d7/a1
        sub.l d3,d4         ;NR=NR-E
        beq.s or9
        bcc.s or6
        bra.s or9
or8:    movem.l (sp)+,d3-d7/a1
or9:    addq.l #1,d5        ;NA=NA+1
        move.l d6,d0
        sub.l d3,d0
        cmp.l d0,d5
        bls.s or5
        bra.s or4
or10:   rts

************************************************************************
*       MATCH
L188:   dc.w l188a-L188,l188b-L188,l188c-L188,l188d-L188,l188e-L188,0
**********************************************************************
l188a:  jsr L_getablo.l         ;va chercher le tableau
        tst.b d2
        beq.s l188z
        bmi.s l188z
        move.l (a6)+,d4
l188z:  move.l (a6)+,d3
; recherche!
di3:    moveq #0,d5         ;d5= base de recherche
        move.l d6,d1        ;d1= nombre total d'elements
        lsr.l #1,d6         ;d6= pivot de la recherche
di4:    movem.l a1/d1-d7,-(sp)
        add.l d6,d5
        lsl.l d7,d5
        add.l d5,a1         ;pointe la variable du tableau
        move.l (a1),d6
        move.l 4(a1),d7     ;prend les deux: ca fait pas de mal!
        movem.l d2-d7,-(sp)
        move.b d2,d5
l188b:  jsr L_egbis.l           ;egal ???
        tst.l d0
        bne di11          ;trouve!
        movem.l (sp)+,d2-d7
        move.b d2,d5
l188c:  jsr L_supbis.l          ;superieur strictement
        tst.l d0
        beq.s di5
; moitie inferieure de la liste
        movem.l (sp)+,a1/d1-d7
        bra.s di6
; moitie superieure de la liste
di5:    movem.l (sp)+,a1/d1-d7
        add.l d6,d5         ;change de cote!
di6:    tst.l d6
        beq.s di7
        lsr.l #1,d6
        bra.s di4
; pas trouve: cherche le premier element superieur
di7:    cmp.l d1,d5         ;arrive a la fin de la liste?
        bcc.s di10
        movem.l a1/d1-d7,-(sp)
        lsl.l d7,d5
        add.l d5,a1
        move.l (a1),d6
        move.l 4(a1),d7
        movem.l d2-d7,-(sp)
        move.b d2,d5
l188d:  jsr L_egbis.l
        tst.l d0            ;trouve dans la fin!
        bne.s di11
        movem.l (sp)+,d2-d7
        move.b d2,d5
l188e:  jsr L_supbis.l
        tst.l d0
        bne.s di9
        movem.l (sp)+,a1/d1-d7
        addq.l #1,d5
        bra.s di7
di9:    movem.l (sp)+,a1/d1-d7
di10:   move.l d5,d3        ;NEGATIF: pas trouve!
        addq.l #1,d3        ;plus 1=> -1<toute la liste
        neg.l d3            ;<taille liste=> >a toute la liste!!!!
        move.l d3,-(a6)
        rts
; trouve!
di11:   movem.l (sp)+,d2-d7
        movem.l (sp)+,a1/d1-d7
        move.l d5,d3        ;calcule le pointeur dans le tableau
        add.l d6,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       BSET
L189:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        bset d0,d1
        move.l d1,(a0)
        rts

************************************************************************
*       BCLR
L190:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        bclr d0,d1
        move.l d1,(a0)
        rts

************************************************************************
*       BCHG
L191:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        bchg d0,d1
        move.l d1,(a0)
        rts

************************************************************************
*       BTST
L192:   dc.w 0
***************
        move.l (a6)+,d1
        move.l (a6),d0
        btst d0,d1
        bne.s L192a
        moveq #0,d0
        move.l d0,(a6)
        rts
L192a:  moveq #-1,d0
        move.l d0,(a6)
        rts

*************************************************************************
*       ROL .b
L193:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        rol.b d0,d1
        move.l d1,(a0)
        rts

*************************************************************************
*       ROL .w
L194:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        rol.w d0,d1
        move.l d1,(a0)
        rts

*************************************************************************
*       ROL .l
L195:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        rol.l d0,d1
        move.l d1,(a0)
        rts

*************************************************************************
*       ROR .b
L196:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        ror.b d0,d1
        move.l d1,(a0)
        rts

*************************************************************************
*       ROR .w
L197:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        ror.w d0,d1
        move.l d1,(a0)
        rts

*************************************************************************
*       ROR .l
L198:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a0),d1
        ror.l d0,d1
        move.l d1,(a0)
        rts

************************************************************************
*       DREG=
L199:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a6)+,d1
        cmp.l #7,d1
        bhi.s L199z
        lsl.w #2,d1
        lea callreg(a5),a0
        move.l d0,0(a0,d1.w)
        rts
L199z:  moveq #E_illegalfunc,d0
        move.w error(a5),a0
        jmp (a0)

************************************************************************
*       AREG=
L200:   dc.w 0
***************
        move.l (a6)+,d0
        move.l (a6)+,d1
        cmp.l #6,d1
        bhi.s L200z
        lsl.w #2,d1
        lea callreg(a5),a0
        move.l d0,4*8(a0,d1.w)
        rts
L200z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       =DREG
L201:   dc.w 0
***************
        move.l (a6)+,d0
        cmp.l #7,d0
        bhi.s L201z
        lsl.w #2,d0
        lea callreg(a5),a0
        move.l 0(a0,d0.w),-(a6)
        rts
L201z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       =AREG
L202:   dc.w 0
***************
        move.l (a6)+,d0
        cmp.l #6,d0
        bhi.s L202z
        lsl.w #2,d0
        lea callreg(a5),a0
        move.l 4*8(a0,d0.w),-(a6)
        rts
L202z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       TRAP
L203:   dc.w L203a-L203,0
**************************
        movem.l a4-a5,-(sp)
        pea 14*4+callreg(a5)
        lea pipil1(pc),a0
        move.l sp,(a0)
L203r:  move.w (a6)+,d0
        bmi.s L203g
        beq.s L203w
        cmp.w #1,d0
        beq.s L203l
; Chaine alphanumerique
        move.l (a6)+,a2
        moveq #0,d3
        move.w (a2)+,d3
L203a:  jsr L_malloc.l
        subq.w #1,d3
        bmi.s L203c
L203b:  move.b (a2)+,(a0)+
        dbra d3,L203b
L203c:  clr.b (a0)+
        move.l a0,d0
        addq.l #1,d0
        bclr #0,d0
        move.l d0,hichaine(a5)
        move.l a1,-(sp)
        bra.s L203r
; Mot long
L203l:  move.l (a6)+,-(sp)
        bra.s L203r
; Mot
L203w:  move.l (a6)+,d0
        move.w d0,-(sp)
        bra.s L203r
; On y va!
L203g:  move.l (a6)+,d0
        cmp.l #15,d0
        bhi.s L203z
        lea trpap(pc),a1 /* FIXME: self-modifying */
        and.w #$fff0,(a1)
        or.w d0,(a1)
; Appel de la trappe
        lea callreg(a5),a6
        movem.l (a6)+,d0-d7/a0-a5
        move.l (a6),a6
trpap:  trap #3
        move.l pipil1(pc),sp
        move.l a6,-(sp)
        move.l 4(sp),a6
        move.l (sp),(a6)
        addq.l #8,sp
        movem.l d0-d7/a0-a5,-(a6)
        movem.l (sp)+,a4-a5
        move.l bufpar(a5),a6
        rts
L203z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)
pipil1: dc.l 0

************************************************************************
*       CALL adresse
L204:   dc.w l204a-L204,l204g-L204,0
**************************************
        movem.l a4-a5,-(sp)
        pea 14*4+callreg(a5)
        lea pipil2(pc),a0
        move.l sp,(a0)
l204r:  move.w (a6)+,d0
        bmi.s l204g
        beq.s l204w
        cmp.w #1,d2
        beq.s l204l
; Chaine alphanumerique
        move.l (a6)+,a2
        moveq #0,d3
        move.w (a2)+,d3
l204a:  jsr L_malloc.l
        subq.w #1,d3
        bmi.s l204c
l204b:  move.b (a2)+,(a0)+
        dbra d3,l204b
l204c:  clr.b (a0)+
        move.l a0,d0
        addq.l #1,d0
        bclr #0,d0
        move.l d0,hichaine(a5)
        move.l a1,-(sp)
        bra.s l204r
; Mot long
l204l:  move.l (a6)+,-(sp)
        bra.s l204r
; Mot
l204w:  move.l (a6)+,d0
        move.w d0,-(sp)
        bra.s l204r
; On y va!
l204g:  jsr L_addrofbank.l
        pea l204q(pc)
        move.l d3,-(sp)
        lea callreg(a5),a6
        movem.l (a6)+,d0-d7/a0-a5
        move.l (a6),a6
        rts
l204q:  move.l pipil2(pc),sp
        move.l a6,-(sp)
        move.l 4(sp),a6
        move.l (sp),(a6)
        addq.l #8,sp
        movem.l d0-d7/a0-a5,-(a6)
        movem.l (sp)+,a4-a5
        move.l bufpar(a5),a6
        rts
pipil2: dc.l 0

**************************************************************************
*       STOPALL
L205:   dc.w 0
***************
        movem.l d0-d7/a0-a6,-(sp)
        clr.l d2
        moveq #S_movesonoff,d0
        trap #5             ;move off
        moveq #S_animsonoff,d0
        trap #5             ;anim off
        moveq #S_spritesonoff,d0
        trap #5             ;sprite off
        moveq #S_actualise,d0
        trap #5             ;actualise
        moveq #1,d1
        moveq #S_chgmouse,d0
        trap #5             ;mouse par default
        moveq #M_initsound,d0
        trap #7             ;music off
        move nbjeux(a5),d6
sta1:   lea sta1(pc),a0      ;pointe un message <>06071963
        moveq #W_setcharset,d7
        move d6,d0
        trap #3             ;arrete tous les jeux > 3
        addq #1,d6
        cmp #16,d6
        bne.s sta1
        lea sta1(pc),a0      ;pointe un message <>28091960
        moveq #W_newicon,d7
        trap #3             ;arrete les icones
        movem.l (sp)+,d0-d7/a0-a6
        rts

*************************************************************************
*       MOVEDATA
L206:   dc.w l206a-L206,l206b-L206,0
*************************************
        moveq #1,d3         ;Banque #1: SPRITES
l206a:  jsr L_adbank.l
        bne.s mvd1
        lea mvd1(pc),a1     ;pointe un message fixe, <> de 19861987
mvd1:   move.l a1,a0
        moveq #S_chgbank,d0         ;chgbank
        trap #5
        moveq #0,d5
l206b:  jmp L_putchar.l

************************************************************************
*       PUTCHAR
L207:   dc.w l207a-L207,l207b-L207,l207c-L207,0
************************************************
        move.l adatabank(a5),a3
        addq.l #4,a3
        moveq #1,d3
        move nbjeux(a5),d6      ;numero du premier jeu de caractere
mvd2:   cmp.b #$83,(a3)         ;banque programme?
        bne.s mvd3
        tst d5                  ;doit reloger les caracteres seulement?
        bne.s mvd4
l207a:  jsr L_relprg.l
        bra.s mvd4
mvd3:   cmp.b #$84,(a3)         ;banque caractere?
        bne.s mvd4
l207b:  jsr L_adbank.l
        move.l d6,d0            ;reloge la banque de caracteres
        move.l a1,a0
        moveq #W_setcharset,d7
        trap #3
        cmp #16,d6
        bcc.s mvd4
        addq #1,d6              ;une autre banque (si < 16)!
mvd4:   addq.l #4,a3
        addq #1,d3
        cmp #16,d3
        bne.s mvd2
; RELOGE LES ICONES
        moveq #2,d3             ;Banque #2: ICONES
l207c:  jsr L_adbank.l
        bne.s mvd1a
        lea mvd4(pc),a1         ;pointe un message fixe <> $28091960
mvd1a:  move.l a1,a0
        moveq #W_newicon,d7            ;new icones
        trap #3
        rts

*************************************************************************
*       RELOGE UN PROGRAMME
L208:   dc.w l208a-L208,0
**************************
        movem.l d0-d7,-(sp)
l208a:  jsr L_adbank.l               ;va chercher l'adresse de la banque
        move.l a1,a0
        move.l a1,d2
        move.l 2(a1),d0          ;distance a la table
        add.l 6(a1),d0
        andi.l #$ffffff,d0
        add #$1c,a1              ;pointe le debut du programme
        move.l a1,a2
        add.l d0,a1
        sub.l 16(a0),d2          ;d2= difference a additionner au prg
        move.l a0,16(a0)         ;poke la nouvelle adresse
        tst.l (a1)
        beq.s relp3
        add.l (a1)+,a2           ;pointe la table de relocation
        clr.l d0
        bra.s relp1
relp0:  move.b (a1)+,d0
        beq.s relp3
        cmp.b #1,d0
        beq.s relp2
        add d0,a2                ;pointe dans le programme
relp1:  add.l d2,(a2)            ;change dans le programme
        bra.s relp0
relp2:  add.w #254,a2
        bra.s relp0
relp3:  movem.l (sp)+,d0-d7
        rts

*************************************************************************
*       TRANSFERT DE MEMOIRE RAPIDE ET INTELLIGENT a2/pair->a3/pair
L209:   dc.w 0
******************
        move.b d3,d4
        andi.b #3,d4
        cmp.l a2,a3
        bcs.s tm
; a3>a2: remonter le programme
        add.l d3,a2
        add.l d3,a3
        movem.l a2/a3,-(sp)
        lsr.l #2,d3         ;nombre de mots longs
        beq.s tm2
tm1:    move.l -(a2),-(a3)  ;transfert mots longs
        subq.l #1,d3
        bne.s tm1
tm2:    tst.b d4
        beq.s tm3b
tm3:    move.b -(a2),-(a3)  ;transfert octets
        subq.b #1,d4
        bne.s tm3
tm3b:   movem.l (sp)+,a2/a3 ;pointe la fin des zones
        rts
; a2<a3: descendre le programme
tm:     lsr.l #2,d3
        beq.s tm5
tm4:    move.l (a2)+,(a3)+
        subq.l #1,d3
        bne.s tm4
tm5:    tst.b d4
        beq.s tm7
tm6:    move.b (a2)+,(a3)+
        subq.b #1,d4
        bne.s tm6
tm7:    rts

*************************************************************************
*       CALCLONG
L210:   dc.w 0
***************
        movem.l a0/d0-d1,-(sp)
        move.l fsource(a5),d3
        sub.l dsource(a5),d3
        move.l adatabank(a5),a0
        move.l d3,(a0)+     ;poke la longueur du source
        move #14,d1
clcl0:  move.l (a0)+,d0
        beq.s clcl1
        andi.l #$00ffffff,d0
        add.l d0,d3
clcl1:  dbra d1,clcl0
        move.l adataprg(a5),a0
        move.l d3,4(a0)     ;poke la longueur totale du pgm
        movem.l (sp)+,a0/d0-d1
        rts

**************************************************************************
*       EFFACE LES BANQUES DE DONNEE PENDANT CLEARVAR
L211:   dc.w l211a-L211,l211b-L211,l211c-L211,0
************************************************
        move.l topmem(a5),a3
        move.l a3,a2
        move.l adatabank(a5),a1
        add.l #16*4,a1
        move #14,d1
clbk1:  move.l -(a1),d3     ;data de la banque
        beq.s clbk3         ;Vide
        move.l d3,d0
        andi.l #$00ffffff,d3
        sub.l d3,a2         ;debut de la banque
        tst.l d0
        bmi.s clbk2         ;non indispensable!
        clr.l (a1)          ;l'efface!
        bra.s clbk3
clbk2:  sub.l d3,a3
        cmp.l a2,a3         ;pas besoin de poker: tout est a la meme adresse!
        beq.s clbk3
        movem.l a2-a3,-(sp) ;transfere
l211a:  jsr L_transmem.l
        movem.l (sp)+,a2-a3
clbk3:  dbra d1,clbk1
; si on a change quelque chose: ON FAIT UN MOVEDATA !!!
        cmp.l himem(a5),a3
        beq.s clbk4
        move.l a3,himem(a5) ;fin des variables/debut des banques
l211b:  jsr L_stopall.l
l211c:  jsr L_movedata.l
clbk4:  rts

*************************************************************************
*       ADBANK
L212:   dc.w 0
***************
        move.l adatabank(a5),a0
        move.l himem(a5),a1     ;depart des banques
        move.l d1,-(sp)     ;entree pour bgrab
        tst.l d3
        beq.s l212z
        cmp.l #16,d3
        bcc.s l212z
        addq.l #4,a0        ;saute le source
        move d3,d1
        subq #2,d1
        bmi.s adb3
adb1:   move.l (a0)+,d0
        andi.l #$00ffffff,d0
        beq.s adb2
        add.l d0,a1
adb2:   dbra d1,adb1
adb3:   move.l (sp)+,d1
        move.l (a0),d0
        rts
l212z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ADPRG
L213:   dc.w 0
***************
        subq.l #1,d3        ;(1-16)--->(0-15)
        cmp.l #16,d3
        bcc.s l213z
        lsl #3,d3
        lea dataprg(a5),a1
        add d3,a1
        lsl #3,d3
        lea databank(a5),a0
        add d3,a0
        rts
l213z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ADDROFBANK
L214:   dc.w l214a-L214,0
**************************
        move.l (a6)+,d3
        cmp.l #16,d3
        bcc.s adou1
; numero de banque
l214a:  jsr L_adbank.l          ;adresse de la banque
        rol.l #8,d0
        andi.l #$ff,d0
        beq.s l214z
        move.l a1,d3
adou1:  rts
l214z:  moveq #E_not_reserved,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FILL depart(inclus) TO fin(exclue), mot long
L215:   dc.w l215a-L215,l215b-L215,0
*************************************
        move.l (a6)+,d4         ;mot a copier
l215a:  jsr L_addrofbank.l            ;adresse de fin
        move.l d3,d2
l215b:  jsr L_addrofbank.l
        move.l d3,a0
        sub.l a0,d2
        bcs.s l215z
        move.b d2,d1
        lsr.l #2,d2         ;travaille par mot long
        beq.s fil2
fil1:   move.l d4,(a0)+
        subq.l #1,d2
        bne.s fil1
fil2:   andi.w #$0003,d1
        beq.s fil4
fil3:   rol.l #8,d4
        move.b d4,(a0)+
        subq #1,d1
        bne.s fil3
fil4:   rts
l215z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       COPY
L216:   dc.w l216a-L216,l216b-L216,l216c-L216,l216d-L216,0
***********************************************************
l216a:  jsr L_addrofbank.l
        move.l d3,a3            ;Adresse d'arrivee
l216b:  jsr L_addrofbank.l
        move.l d3,-(sp)         ;Adresse de fin
l216c:  jsr L_addrofbank.l
        move.l d3,a2            ;Adresse de depart
        move.l (sp)+,d3
        sub.l a2,d3             ;Taille a bouger
        bcs.s l216z
l216d:  jmp L_transmem.l
l216z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       HUNT
L217:   dc.w l217a-L217,l217b-L217,l217c-L217,0
************************************************
l217a:  jsr L_chverbuf.l            ;Chaine---> buffer
        move.w d2,-(sp)
l217b:  jsr L_addrofbank.l
        move.l d3,d7            ;Adresse de fin
l217c:  jsr L_addrofbank.l
        move.l d3,a0            ;Adresse de recherche
        move.w (sp)+,d2
        subq.w #1,d2
        bcs.s ht3               ;si chaine nulle: ramene zero!
        move.l buffer(a5),d6
        subq.l #1,a0
ht1:    addq.l #1,a0            ;passe a l'octet suivant
        move.l a0,a1
        cmp.l d7,a0             ;pas trouve!
        bcc.s ht3
        move.l d6,a2            ;pointe la chaine recherchee
        move d2,d1
ht2:    cmpm.b (a2)+,(a1)+
        bne.s ht1
        dbra d1,ht2
        move.l a0,-(a6)         ;TROUVE!
        rts
ht3:    clr.l -(a6)
        rts

*************************************************************************
*       RESERVE
L218:   dc.w l218a-L218,l218b-L218,0
*************************************
        move.w d0,d1            ;Flag de la banque
        andi.w #$f,d0
        cmp.w #2,d0
        bne.s l218x
; Banque ecran
        move.l (a6)+,d2
        move.l #32768,d3
        bra.s l218a
; Autres banques
l218x:  move.l (a6)+,d3
        move.l (a6)+,d2
l218a:  jsr L_reservin.l
l218b:  jmp L_resbis.l

*************************************************************************
*       RESERVIN
L219:   dc.w l219a-L219,l219b-L219,l219c-L219,l219d-L219,0
***********************************************************
l219a:  jsr L_stopall.l
        tst.b d3
        beq.s l219b
        clr.b d3
        addi.l #$100,d3
l219b:  jsr L_malloc.l
        exg d2,d3
l219c:  jsr L_adbank.l
        bne.s l219z
        andi.l #$ff,d1
        ror.l #8,d1
        or.l d2,d1
        move.l d1,(a0)
        sub.l d2,himem(a5)
        move.l lowvar(a5),a2
        move.l a2,a3
        sub.l d2,a3
        move.l a3,lowvar(a5)
        move.l a1,d3
        sub.l a2,d3
l219d:  jsr L_transmem.l
        rts
l219z:  moveq #E_bank_reserved,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       RESBIS / reloge banques
L220:   dc.w l220a-L220,l220b-L220,0
************************************************
l220a:  jsr L_calclong.l
l220b:  jsr L_movedata.l
        rts

*************************************************************************
*       ERASE
L221:   dc.w l221a-L221,l221b-L221,0
*************************************
        move.l (a6)+,d3
l221a:  jsr L_effbank.l
        bne.s L221c
l221b:  jmp L_resbis.l
L221c:  rts

*************************************************************************
*       EFFBANK
L222:   dc.w l222a-L222,l222b-L222,l222c-L222,0
************************************************
        move.l d3,-(sp)
l222a:  jsr L_adbank.l
        beq.s eras5
        cmp #15,d3
        bne.s effb1
        tst mnd+14(a5)
        bne.s l222z
effb1:  clr.l (a0)
l222b:  jsr L_stopall.l
        andi.l #$00ffffff,d0
        add.l d0,himem(a5)
        move.l lowvar(a5),a2
        move.l a2,a3
        add.l d0,a3
        move.l a3,lowvar(a5)
        move.l a1,d3
        sub.l a2,d3
l222c:  jsr L_transmem.l
        move.l (sp)+,d3
        clr d0
        rts
eras5:  move.l (sp)+,d3
        move #1,d0
        rts
l222z:  moveq #E_bank15_menu,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       BCOPY X TO Y : COPIE UNE BANQUE MEMOIRE
L223:   dc.w l223a-L223,l223b-L223,l223c-L223,l223d-L223,l223e-L223
        dc.w l223f-L223,l223g-L223,0
*************************************
        move.l (a6)+,d3
l223a:  jsr L_adbank.l              ;Destination
        bne.s l223z             ;deja res
        movem.l d3/a0,-(sp)
        move.l (a6)+,d3
l223b:  jsr L_adbank.l
        beq.s l223x             ;Rien!
        move.l d3,d0
        move.l a0,a2
        movem.l (sp)+,d3/a0
        move.l d3,d2
        cmp d3,d0
        beq.s l223x
        move.l (a2),d1
        move.l d1,d3
        andi.l #$ffffff,d3
        clr d1
        swap d1
        clr.b d1
        ror.w #8,d1
        movem.l d0/d2,-(sp)
l223c:  jsr L_reservin.l
        movem.l (sp)+,d3/d4
l223d:  jsr L_adbank.l
        move.l a1,a2
        move.l d4,d3
l223e:  jsr L_adbank.l
        move.l a1,a3
        move.l (a0),d3
        andi.l #$ffffff,d3
l223f:  jsr L_transmem.l
l223g:  jsr L_resbis.l
l223x:  rts
l223z:  moveq #E_bank_reserved,d0            ;Deja reservee
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       BGRAB Un parametre / toutes les banques
L224:   dc.w l224a-L224,l224b-L224,l224c-L224,l224d-L224,l224e-L224
        dc.w l224f-L224,0
**************************
        move.l (a6)+,d1
        subq.l #1,d1
        cmp program(a5),d1
        beq l224x
        tst mnd+14(a5)
        bne l224z
        addq.l #1,d1
        move.l d1,d3
l224a:  jsr L_adprg.l
        movem.l a0-a1,-(sp)
        move.l topmem(a5),d0
        sub.l himem(a5),d0
        move.l 4(a1),d3
        sub.l (a0),d3
        addi.l #64,d3
        cmp.l d0,d3
        bls.s bgrab6
        sub.l d0,d3
l224b:  jsr L_malloc.l
bgrab6:
l224c:  jsr L_stopall.l
        movem.l (sp)+,a0-a1
        move.l 4(a1),d3
        sub.l (a0),d3
        move.l (a1),a1
        add.l (a0)+,a1
        move.l adatabank(a5),a2
        addq.l #4,a2
        move #14,d0
bgrab7: move.l (a0)+,(a2)+
        dbra d0,bgrab7
; bouge les variables
        movem.l d3/a1,-(sp)
        move.l topmem(a5),a3
        sub.l d3,a3
        move.l lowvar(a5),a2
        move.l himem(a5),d3
        sub.l a2,d3
        sub.l d3,a3
        move.l a3,lowvar(a5)
l224d:  jsr L_transmem.l
        move.l a3,himem(a5)
        movem.l (sp)+,d3/a2
l224e:  jsr L_transmem.l
l224f:  jsr L_resbis.l
l224x:  rts
l224z:  moveq #E_bank15_menu,d0
        move.l error(a5),a0
        jmp (a0)

**************************************************************************
*       BGRAB deux params ---> une seule banque
L225:   dc.w l225a-L225,l225b-L225,l225c-L225,l225d-L225
        dc.w l225e-L225,l225f-L225,l225g-L225,l225h-L225
        dc.w l225i-L225,l225j-L225,0
*************************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        subq.l #1,d2
        cmp program(a5),d2
        beq l225x
        addq.l #1,d2
        move.l d2,d3
l225a:  jsr L_adprg.l
; verifie la taille memoire
        move.l (a1),a1
        add.l (a0),a1
        movem.l a0-a1,-(sp)
        move.l d1,d3
l225b:  jsr L_adbis.l
        cmp #15,d3
        bne.s bgrab0
        tst mnd+14(a5)
        bne.s l225z
bgrab0: andi.l #$ffffff,d0
        move.l d0,d3
        addi.l #64,d3
        move.l d3,-(sp)
        move.l d1,d3
l225c:  jsr L_adbank.l
        andi.l #$ffffff,d0
        move.l (sp)+,d3
        cmp.l d0,d3
        bls.s bgrab1
        sub.l d0,d3
l225d:  jsr L_malloc.l
bgrab1: move.l d1,d3
l225e:  jsr L_effbank.l
        movem.l (sp)+,a0-a1
l225f:  jsr L_adbis.l
        beq.s l225j
        move.l a1,-(sp)
        move.l d3,d2
        move.l d0,d3
        andi.l #$ffffff,d3
        move.l d3,-(sp)
        rol.l #8,d0
        move.b d0,d1
        move.l d2,-(sp)
l225g:  jsr L_reservin.l
        move.l (sp)+,d3
l225h:  jsr L_adbank.l
        move.l a1,a3
        move.l (sp)+,d3
        move.l (sp)+,a2
l225i:  jsr L_transmem.l
l225j:  jsr L_resbis.l
l225x:  rts
l225z:  moveq #E_bank15_menu,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       START (xx)
L226:   dc.w l226a-L226,0
******************************
        move.l (a6)+,d3
l226a:  jsr L_adbank.l
        move.l a1,-(a6)
        rts

*************************************************************************
*       START(xx,yy)
L227:   dc.w l227a-L227,l227b-L227,l227c-L227,0
************************************************
        move.l (a6)+,d2
        move.l (a6)+,d3
        subq.l #1,d3
        cmp.w program(a5),d3
        beq.s l227z
        addq.l #1,d3
l227a:  jsr L_adprg.l
        move.l (a1),a1
        add.l (a0),a1
        move.l d2,d3
l227b:  jsr L_adbis.l
        move.l a1,-(a6)
        rts
l227z:  move.l d2,d3
l227c:  jsr L_adbank.l
        move.l a1,-(a6)
        rts

*************************************************************************
*       ADBIS
L228:   dc.w 0
***************
        move.l d1,-(sp)
        tst.l d3
        beq.s l228z
        cmp.l #16,d3
        bcc.s l228z
        addq.l #4,a0
        move d3,d1
        subq #2,d1
        bmi.s abd3
abd1:   move.l (a0)+,d0
        andi.l #$00ffffff,d0
        beq.s abd2
        add.l d0,a1
abd2:   dbra d1,abd1
abd3:   move.l (sp)+,d1
        move.l (a0),d0
        rts
l228z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       LENGTH(xx)
L229:   dc.w l229a-L229,0
*******************************
        move.l (a6)+,d3
l229a:  jsr L_adbank.l
        andi.l #$ffffff,d0
        move.l d0,-(a6)
        rts

************************************************************************
*       LENGTH(xx,yy)
L230:   dc.w l230a-L230,l230b-L230,l230c-L230,0
************************************************
        move.l (a6)+,d2
        move.l (a6)+,d3
        subq.l #1,d3
        cmp.w program(a5),d3
        beq.s l230z
        addq.l #1,d3
l230a:  jsr L_adprg.l
        move.l (a1),a1
        add.l (a0),a1
        move.l d2,d3
l230b:  jsr L_adbis.l
        andi.l #$00ffffff,d0
        move.l d0,-(a6)
        rts
l230z:  move.l d2,d3
l230c:  jsr L_adbank.l
        andi.l #$00ffffff,d0
        move.l d0,-(a6)
        rts

**************************************************************************
*       CURRENT
L231:   dc.w 0
***************
        moveq #0,d3
        move.w program(a5),d3
        tst.w accflg(a5)
        beq.s l231a
        move.w reactive(a5),d3
l231a:  addq.w #1,d3
        move.l d3,-(a6)
        rts

**************************************************************************
*       ACCNB
L232:   dc.w 0
***************
        moveq #0,d3
        tst.w accflg(a5)
        beq.s l232a
        move.w program(a5),d3
        addq.w #1,d3
l232a:  move.l d3,-(a6)
        rts

**************************************************************************
*       LANGUAGE
L233:   dc.w 0
***************
        moveq #0,d3
        move.w language(a5),d3
        move.l d3,-(a6)
        rts

*************************************************************************
*       ADSCREEN
L234:   dc.w l234a-L234,0
**************************
        move.l (a6)+,d3
        cmp.l #16,d3
        bcc.s ade
l234a:  jsr L_adbank.l
        move.l a1,d3
        rol.l #8,d0
        andi.b #$7f,d0
        beq.s l234w
        cmp.b #2,d0             ;est-ce un ecran?
        bne.s l234y
ade:    tst.b d3                ;cette adresse DOIT etre un multiple de 256
        bne.s l234z
        cmp.l deflog(a5),d3     ;et pas superieure a l'ecran par defaut!
        bhi.s l234x
        rts
l234w:  moveq #E_not_reserved,d0
        bra.s l234e
l234x:  moveq #E_illegalfunc,d0
        bra.s l234e
l234y:  moveq #E_bank_not_screen,d0
        bra.s l234e
l234z:  moveq #E_bad_screen,d0
l234e:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       =LOGIC
L235:   dc.w 0
***************
        move.l adlogic(a5),-(a6)
        rts

*************************************************************************
*       LOGIC=
L236:   dc.w l236a-L236,0
***************
l236a:  jsr L_adscreen.l
        move.l d3,adlogic(a5)
        move.w #-1,-(sp)
        move.l #-1,-(sp)
        move.l d3,-(sp)
        move.w #5,-(sp)
        trap #14
        lea 12(sp),sp
        rts

*************************************************************************
*       =PHYSIC
L237:   dc.w 0
***************
        move.l adphysic(a5),-(a6)
        rts

*************************************************************************
*       PHYSIC=
L238:   dc.w l238a-L238,0
*************************
l238a:  jsr L_adscreen.l
        move.l d3,adphysic(a5)
        move.w #-1,-(sp)
        move.l d3,-(sp)
        move.l #-1,-(sp)
        move.w #5,-(sp)
        trap #14
        lea 12(sp),sp
        rts

*************************************************************************
*       =BACK
L239:   dc.w 0
***************
        move.l adback(a5),-(a6)
        rts

*************************************************************************
*       BACK=
L240:   dc.w l240a-L240,0
**************************
l240a:  jsr L_adscreen.l
        move.l d3,adback(a5)
        move.l d3,a0
        moveq #S_chgscreen,d0
        trap #5
        move.l d3,a0
        moveq #W_setback,d7
        trap #3
        rts

*************************************************************************
*       DEFAULT BACK
L241:   dc.w 0
***************
        move.l defback(a5),-(a6)
        rts

*************************************************************************
*       DEFAULT LOGIC/PHYSIC
L242:   dc.w 0
***************
        move.l deflog(a5),-(a6)
        rts

*************************************************************************
*       SCREEN SWAP
L243:   dc.w 0
***************
        move.l adphysic(a5),d3
        move.l adlogic(a5),d4
        cmp.l adback(a5),d4
        bne.s scsw
; Change BACK to current physic
        move.l d3,adback(a5)
        move.l d3,a0
        moveq #S_chgscreen,d0
        trap #5
        move.l d3,a0
        moveq #W_setback,d7
        trap #3
; Change LOGIC et PHYSIC
scsw:   move.l d3,adlogic(a5)
        move.l d4,adphysic(a5)
        move.w #-1,-(sp)
        move.l d4,-(sp)
        move.l d3,-(sp)
        move.w #5,-(sp)
        trap #14
        lea 12(sp),sp
        rts

************************************************************************
*       WAIT xx
L244:   dc.w l244a-L244,0
**************************
        move.l (a6)+,d3
        beq.s l244b
        bmi.s l244b
        move.l d3,waitcpt(a5)
l244a:  jsr L_tester.l
        tst.l waitcpt(a5)
        bne.s l244a
l244b:  rts

************************************************************************
*       =XMOUSE
L245:   dc.w 0
***************
        moveq #S_mouse,d0
        trap #5
        moveq #0,d3
        move.w d0,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       XMOUSE=
L246:   dc.w 0
***************
        moveq #-1,d2
        move.l (a6)+,d1
        moveq #S_movemouse,d0
        trap #5
        rts

*************************************************************************
*       =YMOUSE
L247:   dc.w 0
***************
        moveq #S_mouse,d0
        trap #5
        moveq #0,d3
        move.w d1,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       YMOUSE=
L248:   dc.w 0
***************
        move.l (a6)+,d2
        moveq #-1,d1
        moveq #S_movemouse,d0
        trap #5
        rts

************************************************************************
*       MOUSEKEY
L249:   dc.w 0
***************
        moveq #S_mousekey,d0
        trap #5
        moveq #0,d3
        move.b d0,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       =JOY
L250:   dc.w 0
***************
        moveq #0,d3
        move.l ada(a5),a0
        move.l adapt_joy(a0),a0
        move.b (a0),d3      ;#$e09...
        move.l adm(a5),a0
        btst #1,7(a0)
        beq.s joy1
        bset #4,d3
joy1:   move.l d3,-(a6)
        rts

************************************************************************
*       FIRE
L251:   dc.w 0
***************
        move.l adm(a5),a0
        btst #1,7(a0)
        bne.s L251a
        moveq #0,d3
        move.l d3,-(a6)
        rts
L251a:  moveq #-1,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       JRIGHT
L252:   dc.w 0
***************
        move.l ada(a5),a0
        move.l adapt_joy(a0),a0
        btst #3,(a0)
        bne.s L252a
        moveq #0,d3
        move.l d3,-(a6)
        rts
L252a:  moveq #-1,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       JLEFT
L253:   dc.w 0
***************
        move.l ada(a5),a0
        move.l adapt_joy(a0),a0
        btst #2,(a0)
        bne.s L253a
        moveq #0,d3
        move.l d3,-(a6)
        rts
L253a:  moveq #-1,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       JDOWN
L254:   dc.w 0
***************
        move.l ada(a5),a0
        move.l adapt_joy(a0),a0
        btst #1,(a0)
        bne.s L254a
        moveq #0,d3
        move.l d3,-(a6)
        rts
L254a:  moveq #-1,d3
        move.l d3,-(a6)
        rts

************************************************************************
*       JUP
L255:   dc.w 0
***************
        move.l ada(a5),a0
        move.l adapt_joy(a0),a0
        btst #0,(a0)
        bne.s L255a
        moveq #0,d3
        move.l d3,-(a6)
        rts
L255a:  moveq #-1,d3
        move.l d3,-(a6)
        rts

***************************************************************************
*       MODE: change la resolution
L256:   dc.w l256a-L256,l256b-L256,l256c-L256,l256d-L256,0
***********************************************************
        moveq #S_stopmouse,d0
        trap #5
l256a:  jsr L_waitvbl.l
        move.l adback(a5),a0
        move #3999,d0
        clr.l d1
maude1: move.l d1,(a0)+
        move.l d1,(a0)+
        dbra d0,maude1
l256b:  jsr L_waitvbl.l
        move.l adlogic(a5),a0
        move #3999,d0
maude2: move.l d1,(a0)+
        move.l d1,(a0)+
        dbra d0,maude2
l256c:  jsr L_waitvbl.l
        move d3,mode(a5)
        move.w d3,-(sp)
        move.l #-1,-(sp)
        move.l #-1,-(sp)
        move.w #5,-(sp)
        trap #14
        lea 12(sp),sp
l256d:  jsr L_waitvbl.l
        rts

*************************************************************************
*       MODEBIS: INITIALISATION DES TRAPPES (entree pour REDESSIN)
L257:   dc.w l257a-L257,l257b-L257,l257c-L257,l257d-L257
        dc.w l257e-L257,l257f-L257,l257g-L257,l257h-L257
        dc.w l257i-L257,l257j-L257,l257k-L257,l257l-L257
        dc.w l257m-L257,l257n-L257,0
*************************************
        movem.l d0-d7/a0-a6,-(sp)
        move.w #S_initmode,d0
        trap #5                 ;initmode sprites
        move #W_initmode,d7
        trap #3                 ;initmode fenetres
        move d0,nbjeux(a5)      ;nombre de jeux de caracteres par defaut!
        moveq #1,d5
l257a:  jsr L_putchar.l             ;remet les jeux de caracteres !!!
        clr typecran(a5)
        clr fenetre(a5)
        clr mousflg(a5)
        move #1,actualise(a5)
        move #1,autoback(a5)
l257b:  jsr L_cursor.l         ;met (ou non) le curseur
        tst mnd+12(a5)
        beq.s md05
; la barre de menu est affichee!!!
        clr d0
        move #W_delwindow,d7
        trap #3             ;arret du plein ecran
        tst mnd+10(a5)
        bne.s md04
        moveq #10,d0        ;menu UNE ligne
        bra.s md04a
md04:   moveq #12,d0        ;menu DEUX lignes
md04a:
l257c:  jsr L_default.l
        move #20,d0
        move.w #W_chrout,d7
        trap #3             ;arret du curseur
        move #W_currwindow,d0
        trap #3             ;scrolloff
l257d:  jsr L_affbarre.l        ;affbarre;va afficher la barre
        tst mnd+10(A5)
        bne.s md04b
        moveq #9,d0
        bra md04c
md04b:  moveq #11,d0
md04c:
l257e:  jsr L_default.l
        bra.s md10            ;saute toutes les touches de fonction!

md05:   tst foncon(a5)          ;pas de touche de fonction: on reste comme ca!
        beq.s md10
;les touches de fonction sont en route: affichage
        clr d0
        moveq #W_delwindow,d7
        trap #3             ;arret du plein ecran
        moveq #8,d0
l257f:  jsr L_default.l          ;creation de la fenetre de fonction
        moveq #20,d0
        move.w #W_chrout,d7
        trap #3             ;arret du curseur
        moveq #W_currwindow,d0
        trap #3             ;scrolloff
        clr.w d0
l257g:  jsr L_affonc.l
l257h:  jsr L_default.l          ;fenetre de texte

;initialisation LIGNE A
md10:   dc.w $a000                    ;init ligne A
        move.l a0,laad(a5)            ;adresse de la ligne A
        move.l 8(a0),laintin(a5)          ;adresse de intin
        move.l 12(a0),laptsin(a5)         ;adresse de ptsin
;init GRAPHIQUES
        move mode(a5),d0
        lsl #3,d0
        lea maxmode(pc),a0
        clr.l d3
        move.w 0(a0,d0.w),d3
        move.l d3,xmax(a5)                ;maximum en X pour la resolution
        move.w 2(a0,d0.w),d3
        move.l d3,ymax(a5)                ;maximum en Y pour la resolution
        move.w 4(a0,d0.w),d3
        move.l d3,colmax(a5)              ;color maximum "  "      "
        clr valpaper(a5)
        subq #1,d3
        move d3,valpen(a5)
        move #1,autoback(a5)
        clr.w xgraph(a5)                  ;origine graphique
        clr.w ygraph(a5)
; init tables du VDI
        move mode(a5),d0
        mulu #$72,d0
        lea vdimode(pc),a0
        add d0,a0                     ;pointe la table VDI du mode
        move.l ada(a5),a2
        move.l adapt_devtab(a2),a1              ;adresse table du VDI 1
        moveq #45-1,d0
md12:   move.w (a0)+,(a1)+            ;poke dans la table
        dbra d0,md12
        move.l adapt_siztab(a2),a1              ;adresse table du VDI 2
        moveq #12-1,d0
md13:   move.w (a0)+,(a1)+
        dbra d0,md13
; initialisation d'une workstation
        move.l work(a5),d0
        lea adtr(pc),a0
        move.l d0,vdihackwork-adtr(a0)
        move.l $84,(a0)
        lea trp1(pc),a0
        move.l a0,$84                   ;init fausse trappe #1
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move #100,(a2)
        move #0,2(a2)
        move #11,6(a2)
        move #0,12(a2)
        move #1,(a3)
        move #1,2(a3)
        move #1,4(a3)
        move #1,6(a3)
        move #1,8(a3)
        move #1,10(a3)
        move #1,12(a3)
        move #1,14(a3)
        move #1,16(a3)
        move #1,18(a3)
        move #2,20(a3)
        moveq #$73,d0
        move.l vdipb(a5),d1
        trap #2
        move.w 12(a2),d0
        move d0,grh(a5)                 ;graphic handle
        move.l adtr(pc),$84             ;remet la trappe1

;pas de CLIP
l257i:  jsr L_clipoff.l
;init du WRITING
        move.l #1,-(a6)                  ;writing normal
l257j:  jsr L_grwriting.l
;init de la COULEUR
        move.l colmax(a5),-(a6)           ;encre graphique 15/3/1
        subq.l #1,(a6)
l257k:  jsr L_inkk.l
        clr valpaper(a5)
        move #1,valpen(a5)
;init des POLYLINES
        move.l #$ffff,-(a6)
        move.l #$1,-(a6)
        clr.l -(a6)
        clr.l -(a6)
l257l:  jsr L_setline.l
;init des POLYMARKER
        move.l #3,-(a6)                ;etoile
        move.l #4,-(a6)
l257m:  jsr L_setmark.l
; init du PAINT
        move.l #1,-(a6)                ;met la bordure
        move.l #1,-(a6)
        move.l #1,-(a6)                ;rempli avec de la couleur
l257n:  jsr L_setpaint.l
; Init du defscroll/scroll
        move.l dfst(a5),a0               ;Table de def scroll
        moveq #16*8-1,d0
isc:    clr.w (a0)+
        dbra d0,isc
        movem.l (sp)+,d0-d7/a0-a6
        rts
; fausse trappe 1
trp1:   btst.b  #5,(sp)     /* are we in supervisor mode? */
        bne trp2
        move.l  usp,a0      /* no, check user stack */
        move.w (a0),d0
        bra trp4
trp2:   tst.w   $59e
        beq     trp3
        move.w  8(sp),d0
        bra     trp4
trp3:   move.w  6(sp),d0
trp4:   cmp.w #$48,d0
        beq.s trp5
        cmp.w #$49,d0
        beq.s trp6
        move.l adtr(pc),-(sp)
        rts
trp5:   move.l vdihackwork(pc),d0          ;"MALLOC" ! /* WTF? */
        rte
trp6:   clr.l d0                      ;"MFREE" !
        rte
adtr:   dc.l 0
vdihackwork: dc.l 0

;RESOLUTION--> coordonnees/couleur maxi
maxmode:  dc.w 320,200,16,0,640,200,4,0,640,400,2,0
;RESOLUTION--> donnees VDI
vdimode:  dc.w $13f,$c7,0,$152,$174     ;VDI 1, lowres, taille $5a
          dc.w 3,7,0,6,8,1,$18,$c
          dc.w $10,$a,1,2,3,4,5,6
          dc.w 7,8,9,$a,3,0,3,3
          dc.w 3,0,3,0,3,2,1,1
          dc.w 1,0,$200,2,1,1,1,2
          dc.w 5,4,7,$d                 ;VDI 2: taille $18
          dc.w 1,0,$28,0,$f,$b,$78,$58
          dc.w $27f,$c7,0,$a9,$174      ;VDI 1, midres
          dc.w 3,7,0,6,8,1,$18,$c
          dc.w 4,$a,1,2,3,4,5,6
          dc.w 7,8,9,$a,3,0,3,3
          dc.w 3,0,3,0,3,2,1,1
          dc.w 1,0,$200,2,1,1,1,2
          dc.w 5,4,7,$d                 ;VDI 2
          dc.w 1,0,$28,0,$f,$b,$78,$58
          dc.w $27f,$18f,0,$174,$174    ;VDI1, hires
          dc.w 3,7,0,6,8,1,$18,$c
          dc.w 2,$a,1,2,3,4,5,6
          dc.w 7,8,9,$a,3,0,3,3
          dc.w 3,0,3,0,3,2,0,1
          dc.w 1,0,2,2,1,1,1,2
          dc.w 5,4,7,$d                 ;VDI 2
          dc.w 1,0,$28,0,$f,$b,$78,$58

*************************************************************************
*       INK
L258:   dc.w l258a-L258,l258b-L258,l258c-L258,0
*************************************************
        move.l (a6)+,d3
        cmp.l colmax(a5),d3
        bcc.s l258z
        move.w d3,ink(a5)      ;INK pour plot
        move.w d3,d7           ;INK pour le VDI
        lea plan0(a5),a0
        clr.l (a0)
        clr.l 4(a0)
        clr.l d1
        move mode(a5),d0
        subq #1,d0
        beq.s si1
        bpl.s si2
        addq #2,d1
        lea vdink2(pc),a1                 ;lowres
        bra.s si1a
si1:    lea vdink1(pc),a1                 ;midres
si1a:   addq #1,d1
        move d7,d0
        lsl #1,d0
        move.w 0(a1,d0.w),d7          ;INK pour le VDI: QUELLE MERDE!!!
si2:    clr d0
si2a:   btst d0,d3
        beq.s si3
        move #1,(a0)
si3:    addq.l #2,a0
        addq #1,d0
        cmp d1,d0
        bls.s si2a
        move.w d7,inkvdi(a5)
; fill color index
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move #25,(a2)
        move d7,(a3)
l258a:  jsr L_vdint.l
; polyline color index
        move #17,(a2)
        move d7,(a3)
l258b:  jsr L_vdint.l
; polymarker color index
        move #20,(a2)
        move d7,(a3)
l258c:  jsr L_vdint.l
        rts
l258z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)
; COULEURS INK--->VDI
vdink2: dc.w 0,2,3,6,4,7,5,8,9,10,11,14,12,15,13,1        ;lowres
vdink1: dc.w 0,2,3,1                                      ;midres

*************************************************************************
*       GRWRITING
L259:   dc.w L259a-L259,0
*************************
        move.l (a6)+,d3
        tst.l d3
        beq.s L259z
        cmp.l #4,d3
        bhi.s L259z
        move d3,grwrite(a5)               ;entree pour MODEBIS
        subq.w #1,grwrite(a5)
; set writing mode
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move #32,(a2)
        move d3,(a3)
L259a:  jmp L_vdint.l
L259z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CLIPOFF
L260:   dc.w l260a-L260,0
*****************************
        clr.l -(a6)
        clr.l -(a6)
        move.l xmax(a5),-(a6)
        move.l ymax(a5),-(a6)
l260a:  jmp L_clip.l

***********************************************************************
*       CLIP
L261:   dc.w l261a-L261,0
********************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d4
        cmp.l ymax(a5),d3
        bhi.s l261z
        cmp.l xmax(a5),d4
        bhi.s l261z
        cmp.l ymax(a5),d1
        bhi.s l261z
        cmp.l xmax(a5),d2
        bhi.s l261z
        cmp.w d1,d3
        bcc.s l261z
        cmp.w d2,d4
        bcc.s l261z
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move.l ptsin(a5),a1
        move d4,(a1)
        move d3,2(a1)
        move d2,4(a1)
        move d1,6(a1)
        move #1,(a3)
        move #129,(a2)
        move #12,2(a2)
        move #1,6(a2)
        move grh(a5),12(a2)
l261a:  jmp L_vdi.l
l261z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SETLINE
L262:   dc.w l262a-L262,l262b-L262,l262c-L262,l262d-L262,0
***********************************************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d4
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move.l ptsin(a5),a1
        move #15,(a2)
        move #7,(a3)
l262a:  jsr L_vdint.l
; set user defined line style pattern
        move #113,(a2)
        move.w d4,(a3)            ;d4: dessin de la ligne
l262b:  jsr L_vdint.l
; set polyline line width
        move #16,(a2)
        move #1,2(a2)
        clr 6(a2)
        move grh(a5),12(a2)
        move d3,(a1)                 ;d3: taille de la ligne
l262c:  jsr L_vdi.l
; set polyline end style
        move #108,(a2)
        clr 2(a2)
        move #2,6(a2)
        move grh(a5),12(a2)
        andi.w #3,d2
        move d2,(a3)                 ;d2: debut de la ligne
        andi.w #3,d1
        move d1,2(a3)                ;d1: fin de la ligne
l262d:  jmp L_vdi.l

*************************************************************************
*       SET MARK
L263:   dc.w l263a-L263,l263b-L263,0
*************************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        tst.l d2
        beq.s l263z
        cmp.l #7,d2
        bcc.s l263z
; set polymarker type
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move #18,(a2)
        move d2,(a3)
l263a:  jsr L_vdint.l
; set polymarker height
        tst.l d1
        bmi.s l263z
        move #19,(a2)
        move #1,2(a2)
        clr 6(a2)
        move grh(a5),12(a2)
        clr (a1)
        move d1,2(a1)
l263b:  jmp L_vdi.l
l263z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SET PAINT
L264:   dc.w l264a-L264,l264b-L264,l264c-L264,0
************************************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        cmp.l #5,d3
        bcc.s l264z
; set fill interior style
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move #23,(a2)
        move d3,(a3)
l264a:  jsr L_vdint.l
; set fill style index
        tst.l d2
        beq.s l264z
        cmp.l #37,d2
        bcc.s l264z
        move #24,(a2)
        move d2,(a3)
l264b:  jsr L_vdint.l
; set fill perimeter visibility
        cmp.l #2,d1
        bcc.s l264z
        move #104,(a2)
        move d1,(a3)
l264c:  jmp L_vdint.l
l264z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SET PATTERN -adresse-
L265:   dc.w l265a-L265,l265b-L265,0
***************************************
        move.l contrl(a5),a2
        move.l intin(a5),a3
        moveq #1,d1
        move mode(a5),d0
        subq #1,d0
        beq.s dp1
        bpl.s dp2
        addq #2,d1                    ;mode 0: 4 plans
dp1:    addq #1,d1                    ;mode 1: 2 plans
dp2:    move.w d1,d0
        lsl.w #4,d0
        move.w d0,6(a2)
; Set pattern (adresse)
        move.w d0,-(sp)
l265a:  jsr L_addrofbank.l
        move.w (sp)+,d1
        move.l d3,a1
        subq #1,d1
dp3:    move.w (a1)+,(a3)+            ;copie les plans
        dbra d1,dp3
        move.w #112,(a2)
        clr.w 2(a2)
l265b:  jmp L_vdi.l

************************************************************************
*       Set pattern -CHAINE-
L266:   dc.w l266a-L266,0
**************************
        move.l contrl(a5),a2
        move.l intin(a5),a3
        moveq #1,d1
        move mode(a5),d0
        subq #1,d0
        beq.s dpp1
        bpl.s dpp2
        addq #2,d1                    ;mode 0: 4 plans
dpp1:   addq #1,d1                    ;mode 1: 2 plans
dpp2:   move.w d1,d0
        lsl.w #4,d0
        move.w d0,6(a2)
; Set pattern (CHAINE$)
        move.l (a6)+,a1
        move.w (a1)+,d2
        cmp.w #8,d2                   ;string is not a screen bloc
        bcs.s l266z
        cmp.l #$44553528,(a1)+
        bne.s l266z
        cmp.w #16,(a1)+
        bne.s l266z
        cmp.w #16,(a1)+
        bne.s l266z
        move.w d1,d0
        lsl.w #1,d0
        subq #1,d1
dpp4:   moveq #15,d2
        move.l a1,a0
dpp5:   move.w (a0),(a3)+
        add.w d0,a0
        dbra d2,dpp5
        addq.l #2,a1
        dbra d1,dpp4
        move #112,(a2)
        clr 2(a2)
l266a:  jmp L_vdi.l
l266z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       VDI: appel vdi simple
L267:   dc.w 0
***************
        movem.l d0-d1,-(sp)
        moveq #$73,d0
        move.l vdipb(a5),d1
        trap #2
        movem.l (sp)+,d0/d1
        rts

*************************************************************************
*       VDINT
L268:   dc.w 0
***************
        clr.w 2(a2)
        move.w #1,6(a2)
        move.w grh(a5),12(a2)
        movem.l d0-d1,-(sp)
        moveq #$73,d0
        move.l vdipb(a5),d1
        trap #2
        movem.l (sp)+,d0/d1
        rts

*************************************************************************
*       VDI FUNCTION CALL WITH AUTOBACK MANAGEMENT
L269:   dc.w 0
***************
        tst.w autoback(a5)
        beq.s atb1
        moveq #S_stopmouse,d0
        trap #5
        move.l adback(a5),$44e
atb1:   movem.l d0-d1,-(sp)
        moveq #$73,d0
        move.l vdipb(a5),d1
        trap #2
        movem.l (sp)+,d0/d1
        tst.w autoback(a5)
        beq.s atb2
        move.l adlogic(a5),a1
        move.l a1,$44e
        move.l adback(a5),a0
        clr.l d5
        moveq #S_scrcopy,d0
        trap #5
        moveq #S_drawsprites,d0
        trap #5
atb2:   rts

*************************************************************************
*       AUTOBACK OFF
L270:   dc.w 0
***************
        clr.w autoback(a5)
        moveq #W_autobackoff,d7
        trap #3
        rts

************************************************************************
*       AUTOBACK ON
L271:   dc.w 0
***************
        move.w #1,autoback(a5)
        moveq #W_autobackon,d7
        trap #3
        rts

************************************************************************
*       PLOT x,y
L272:   dc.w l272a-L272,0
**************************
        moveq #0,d7
        move.w ink(a5),d7
l272a:  jmp L_plot3.l

************************************************************************
*       PLOT x,y,c
L273:   dc.w l273a-L273,0
**************************
        move.l (a6)+,d7
        cmp.l colmax(a5),d7
        bcc.s l273z
l273a:  jmp L_plot3.l
l273z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       PLOT ---> routine
L274:   dc.w 0
***************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l laintin(a5),a0
        move.w d7,(a0)          ;plotte la couleur
        cmp.l xmax(a5),d2
        bcc.s l274z
        cmp.l ymax(a5),d1
        bcc.s l274z
        move.l laptsin(a5),a0
        move.w d2,(a0)
        move.w d2,xgraph(a5)
        move.w d1,2(a0)
        move.w d1,ygraph(a5)
        tst autoback(a5)        ;si AUTOBACK: plotte dans le decor d'abord
        beq.s pl2
        moveq #S_stopmouse,d0            ;stopmouse
        trap #5
        move.l adback(a5),$44e
        dc.w $a001          ;LIGNE A: PUT PIXEL
        move.l adlogic(a5),$44e
pl2:    dc.w $a001          ;LIGNE A: PUT PIXEL
pl3:    tst autoback(a5)
        beq.s pl4
        moveq #S_drawsprites,d0        ;spreaff
        trap #5
pl4:    rts
l274z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       POINT
L275:   dc.w 0
***************
        move.l (a6)+,d2
        move.l (a6)+,d1
        cmp.l xmax(a5),d1
        bcc.s l275z
        cmp.l ymax(a5),d2
        bcc.s l275z
        move.l laptsin(a5),a0
        move.w d1,(a0)      ;poke X
        move.w d1,xgraph(a5)
        move.w d2,2(a0)     ;poke Y
        move.w d2,ygraph(a5)
        tst autoback(a5)    ;si autoback: prend dans le decor
        beq.s pt1
        moveq #S_stopmouse,d0        ;stopmouse
        trap #5
        move.l adback(a5),$44e
pt1:    dc.w $a002          ;LIGNE A: GET PIXEL
        move.l adlogic(a5),$44e
        moveq #0,d3
        move.w d0,d3
        move.l d3,-(a6)
        tst autoback(a5)
        beq.s pt2
        move #S_restartmouse,d0         ;MOUSEBETE: hand over the mouse
        trap #5
pt2:    rts
l275z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

***********************************************************************
*       DRAW 4 params
L276:   dc.w l276a-L276,0
**************************
        move.l (a6)+,d1
        move.l (a6)+,d0
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l d0,-(a6)
        move.l d1,-(a6)
        cmp.l xmax(a5),d3
        bcc.s l276z
        cmp.l ymax(a5),d2
        bcc.s l276z
        move.w d3,xgraph(a5)
        move.w d2,ygraph(a5)
l276a:  jmp L_draw2.l
l276z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

***********************************************************************
*       DRAW 2 params
L277:   dc.w 0
********************
        move.l (a6)+,d1
        move.l (a6)+,d2
        cmp.l xmax(a5),d2
        bcc.s l277z
        cmp.l ymax(a5),d1
        bcc.s l277z
        move.l laad(a5),a0
        move.w xgraph(a5),38(a0)          ;X1
        move.w ygraph(a5),40(a0)          ;Y1
        move.w d2,42(a0)              ;X2
        move.w d2,xgraph(a5)
        move.w d1,44(a0)              ;Y2
        move.w d1,ygraph(a5)
        move.l plan0(a5),24(a0)           ;plans 0-1
        move.l plan0+4(a5),28(a0)         ;plans 2-3
        move.w grwrite(a5),36(a0)         ;writing Ligne A
        move.w #$ffff,34(a0)          ;ligne parcourue
        move #-1,32(a0)               ;LSTLIN= -1!
        tst autoback(a5)
        beq.s dw3
        moveq #S_stopmouse,d0
        trap #5
        move.l adback(a5),$44e
        dc.w $a003
        move.l adlogic(a5),$44e
dw3:    dc.w $a003
        tst.w autoback(a5)
        beq.s dw4
        moveq #S_drawsprites,d0
        trap #5
dw4:    rts
l277z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       PAINT xx,yy
L278:   dc.w l278a-L278,0
**************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        cmp.l xmax(a5),d2
        bcc.s l278z
        cmp.l ymax(a5),d1
        bcc.s l278z
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move #-1,(a3)
        move d2,xgraph(a5)
        move d2,(a1)
        move d1,ygraph(a5)
        move d1,2(a1)
        move #103,(a2)
        move #1,2(a2)
        move #1,6(a2)
        move grh(a5),12(a2)
l278a:  jmp L_avdi.l
l278z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

**************************************************************************
*       BAR
L279:   dc.w l279a-L279,l279b-L279,0
*************************************
l279a:  jsr L_polypar.l
        move.w #1,10(a2)
        move.w #11,(a2)
        clr.w 6(a2)
        move.w grh(a5),12(a2)
l279b:  jmp L_avdi.l

**************************************************************************
*       RBOX
L280:   dc.w l280a-L280,l280b-L280,0
*************************************
l280a:  jsr L_polypar.l
        move.w #8,10(a2)
        move.w #11,(a2)
        clr.w 6(a2)
        move.w grh(a5),12(a2)
l280b:  jmp L_avdi.l

**************************************************************************
*       RBAR
L281:   dc.w l281a-L281,l281b-L281,0
*************************************
l281a:  jsr L_polypar.l
        move.w #9,10(a2)
        move.w #11,(a2)
        clr.w 6(a2)
        move.w grh(a5),12(a2)
l281b:  jmp L_avdi.l

**************************************************************************
*       BOX
L282:   dc.w l282a-L282,0
*************************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d4
        cmp.l xmax(a5),d4
        bcc.s l282z
        cmp.l ymax(a5),d3
        bcc.s l282z
        cmp.l xmax(a5),d2
        bcc.s l282z
        cmp.l ymax(a5),d1
        bcc.s l282z
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move d4,(a1)       ;x1-y1
        move d3,2(a1)
        move d2,4(a1)      ;x2-y1
        move d3,6(a1)
        move d2,8(a1)     ;x2-y2
        move d1,10(a1)
        move d4,12(a1)    ;x1-y2
        move d1,14(a1)
        move d4,16(a1)    ;x1-y1
        move d3,18(a1)
        move #6,(a2)
        move #5,2(a2)
        clr 6(a2)
        move grh(a5),12(a2)
l282a:  jmp L_avdi.l
l282z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

***************************************************************************
*       POLYGONE x1,y1 TO x2,y2 TO ....
L283:   dc.w l283a-L283,l283b-L283,0
*************************************
l283a:  jsr L_polypar.l                   ;va chercher le parametres
        move #9,(a2)
        clr 6(a2)
        move grh(a5),12(a2)
l283b:  jmp L_avdi.l

***************************************************************************
*       POLYMARK x1,y1;x2,y2,...
L284:   dc.w l284a-L284,0
**************************
        clr.w d7
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
l284b:  move.l (a6)+,d1
        move.l (a6)+,d2
        cmp.l xmax(a5),d2
        bcc.s l284z
        cmp.l ymax(a5),d1
        bcc.s l284z
        move d7,d6
        lsl #2,d6
        move d2,0(a1,d6.w)
        move d1,2(a1,d6.w)
        tst.w d7
        bne.s l284c
        move.w d2,xgraph(a5)
        move.w d1,ygraph(a5)
l284c:  addq #1,d7
        cmp.w d7,d0
        bne.s l284b
        move #7,(a2)
        move d7,2(a2)
        clr 6(a2)
        move grh(a5),12(a2)
l284a:  jmp L_avdi.l
l284z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

**************************************************************************
*       POLYLINE x1,y1 TO x2,y2 TO x3,y3 TO .....
L285:   dc.w l285a-L285,l285b-L285,0
*************************************
l285a:  jsr L_polypar.l
        move #6,(a2)
        clr 6(a2)
        move grh(a5),12(a2)
l285b:  jmp L_avdi.l

**************************************************************************
*       ARC xx,yy,rayon,angle1,angle2
L286:   dc.w l286a-L286,0
**************************
        moveq #2,d0
l286a:  jmp L_arcpie.l

**************************************************************************
*       PIE xx,yy,rayon,angle1,angle2
L287:   dc.w l287a-L287,0
**************************
        moveq #3,d0
l287a:  jmp L_arcpie.l

**************************************************************************
*       ROUTINE ARC/PIE
L288:   dc.w l288a-L288,0
***********************************
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move.w d0,10(a2)
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d4
        move.l (a6)+,d5
        cmp.l xmax(a5),d5
        bcc.s l288z
        cmp.l ymax(a5),d4
        bcc.s l288z
        move d5,xgraph(a5)
        move d5,(a1)
        move d4,ygraph(a5)
        move d4,2(a1)
        clr.l 4(a1)
        clr.l 8(a1)
        tst.l d3
        bmi.s l288z
        move d3,12(a1)
        clr 14(a1)
        cmp.l #3600,d2
        bhi.s l288z
        cmp.l #3600,d1
        bhi.s l288z
        move d2,(a3)
        move d1,2(a3)
        move #11,(a2)
        move #4,2(a2)
        move #2,6(a2)
        move grh(a5),12(a2)
l288a:  jmp L_avdi.l
l288z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CIRCLE xx,yy,rayon
L289:   dc.w l289a-L289,0
**************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        cmp.l xmax(a5),d3
        bcc.s l289z
        cmp.l ymax(a5),d2
        bcc.s l289z
        tst.l d1
        bmi.s l289z
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move d3,xgraph(a5)
        move d3,(a1)
        move d2,ygraph(a5)
        move d2,2(a1)
        clr.l 4(a1)
        move d1,8(a1)
        clr 10(a1)
        move #11,(a2)
        move #3,2(a2)
        clr 6(a2)
        move #4,10(a2)
        move grh(a5),12(a2)
l289a:  jmp L_avdi.l
l289z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       EARC xx,yy,rx,ry,angle1,angle2
L290:   dc.w l290a-L290,0
**************************
        move #6,d0
l290a:  jmp L_ellarcpie.l

*************************************************************************
*       EPIE xx,yy,rx,ry,angle1,angle2
L291:   dc.w l291a-L291,0
**************************
        move #7,d0
l291a:  jmp L_ellarcpie.l

*************************************************************************
*       Routine EARC/EPIE
L292:   dc.w l292a-L292,0
**************************
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move.l intin(a5),a3
        move.w d0,10(a2)
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d4
        move.l (a6)+,d5
        move.l (a6)+,d6
        cmp.l xmax(a5),d6
        bcc.s l292z
        cmp.l ymax(a5),d5
        bcc.s l292z
        tst.l d4
        bmi.s l292z
        tst.l d3
        bmi.s l292z
        cmp.l #3600,d2
        bhi.s l292z
        cmp.l #3600,d1
        bhi.s l292z
        move d6,xgraph(a5)
        move d6,(a1)
        move d5,ygraph(a5)
        move d5,2(a1)
        move d4,4(a1)
        move d3,6(a1)
        move d2,(a3)
        move d1,2(a3)
        move #11,(a2)
        move #2,2(a2)
        move #2,6(a2)
        move grh(a5),12(a2)
l292a:  jmp L_avdi.l
l292z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ELLIPSE xx,yy,rx,ry
L293:   dc.w l293a-L293,0
***************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d4
        cmp.l xmax(a5),d4
        bcc.s l293z
        cmp.l ymax(a5),d3
        bcc.s l293z
        tst.l d2
        bmi.s l293z
        tst.l d1
        bmi.s l293z
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        move d4,xgraph(a5)
        move d4,(a1)
        move d3,ygraph(a5)
        move d3,2(a1)
        move d2,4(a1)
        move d1,6(a1)
        move #11,(a2)
        move #2,2(a2)
        clr 6(a2)
        move #5,10(a2)
        move grh(a5),12(a2)
l293a:  jmp L_avdi.l
l293z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       POLYPARAMS
L294:   dc.w 0
**************************
        move.w d0,d2                    ;Prend les params dans l'ordre!
        lsl.w #3,d2
        add.w d2,a6
        move.l a6,a3
        clr.w d7
        move.l ptsin(a5),a1
        move.l contrl(a5),a2
        tst.w d1
        beq.s pp0
        move.w xgraph(a5),d2
        move.w ygraph(a5),d1
        lea -8(a3),a3
        lea -8(a6),a6
        bra.s pp1
pp0:    move.l -(a3),d2
        move.l -(a3),d1
        cmp.l xmax(a5),d2
        bcc.s l294z
        cmp.l ymax(a5),d1
        bcc.s l294z
pp1:    move.w d7,d6
        lsl.w #2,d6
        move.w d2,0(a1,d6.w)
        move.w d1,2(a1,d6.w)
        move.w d2,xgraph(a5)
        move.w d1,ygraph(a5)
        addq.w #1,d7
        cmp.w d0,d7
        bne.s pp0
        move.w d7,2(a2)
        rts
l294z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CURSOR: SET OR NOT THE CURSOR
L295:   dc.w l295a-L295,0
****************************
        tst cursflg(a5)
        bne.s cu3
; arret du curseur
        cmp #2,mode(a5)
        beq.s cu0
        moveq #S_initflash,d0        ;arrete les flash
        trap #5
l295a:  jsr L_palette3.l    ;remet les couleurs
cu0:    moveq #20,d0        ;code arret cur
        bra.s cu1
; marche du curseur
cu3:    cmp #2,mode(a5)
        beq.s cu2
        lea fd(pc),a0       ;fait flasher la couleur #2
        moveq #2,d1
        moveq #S_flash,d0
        trap #5
cu2:    moveq #17,d0
cu1:    moveq #W_chrout,d7
        trap #3
        rts
fd:     dc.b "(000,2)(220,2)(440,2)(550,2)(660,2)(770,2)(772,2)(774,2)"
        dc.b "(776,2)(777,2)(557,2)(446,2)(335,2)(113,2)(002,2)(001,2)"
        dc.b 0
        even

**************************************************************************
*       CURS OFF
L296:   dc.w l296a-L296,0
***************************
        clr.w cursflg(a5)
l296a:  jmp L_cursor.l

**************************************************************************
*       CURSON
L297:   dc.w l297a-L297,0
**************************
        move.w #1,cursflg(a5)
l297a:  jmp L_cursor.l

**************************************************************************
*       SET CURS dy,fy
L298:   dc.w 0
***************************
        move.l (a6)+,d1
        bmi.s l298z
        move.l (a6)+,d0
        bmi.s l298z
        moveq #W_fixcursor,d7
        trap #3
        rts
l298z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

**************************************************************************
*       DEFAULT
L299:   dc.w 0
***************
        movem.l d1-d7/a0,-(sp)
        lea fe(pc),a0
        mulu #3*18,d0
        move.w mode(a5),d1
        mulu #18,d1
        add.w d1,d0
        add.w d0,a0
        move.w (a0)+,d0
        move.w (a0)+,d1
        swap d1
        move.w (a0)+,d1
        move.w (a0)+,d2
        move.w (a0)+,d3
        move.w (a0)+,d4
        move.w (a0)+,d5
        move.w (a0)+,d6
        swap d6
        move.w (a0),d6
        moveq #W_initwind,d7
        trap #3
        movem.l (sp)+,d1-d7/a0
        rts
;FENETRES DE L'EDITEUR
fe:     dc.w 0,0,1,0,4,40,21,1,0     ;0:fond partiel
        dc.w 0,0,2,0,4,80,21,1,0
        dc.w 0,0,3,0,2,80,23,1,0
        dc.w 1,1,1,0,4,40,11,1,0     ;1:fenetre moitie #1
        dc.w 1,1,2,0,4,80,11,1,0
        dc.w 1,1,1,0,4,80,23,1,0
        dc.w 2,1,1,0,15,40,10,1,0    ;2:fenetre moitie #2
        dc.w 2,1,2,0,15,80,10,1,0
        dc.w 2,1,1,0,27,80,23,1,0
        dc.w 3,1,1,0,4,20,11,1,0     ;3:fenetre quart #1
        dc.w 3,1,2,0,4,40,11,1,0
        dc.w 3,1,1,0,4,40,23,1,0
        dc.w 4,1,1,20,4,20,11,1,0    ;4:fenetre quart #2
        dc.w 4,1,2,40,4,40,11,1,0
        dc.w 4,1,1,40,4,40,23,1,0
        dc.w 5,1,1,0,15,20,10,1,0    ;5:fenetre quart #3
        dc.w 5,1,2,0,15,40,10,1,0
        dc.w 5,1,1,0,27,40,23,1,0
        dc.w 6,1,1,20,15,20,10,1,0   ;6:fenetre quart #4
        dc.w 6,1,2,40,15,40,10,1,0
        dc.w 6,1,1,40,27,40,23,1,0
        dc.w 14,7,1,0,5,40,19,0,1    ;7:fenetre HELP
        dc.w 14,7,2,20,5,40,19,0,1
        dc.w 14,7,2,20,16,40,19,0,1
        dc.w 15,1,1,0,0,40,4,1,0     ;8: fenetre de fonction
        dc.w 15,1,2,0,0,80,4,1,0
        dc.w 15,1,1,0,0,80,4,1,0
        dc.w 0,0,1,0,1,40,24,1,0     ;9: fond partiel menu UNE LIGNE
        dc.w 0,0,2,0,1,80,24,1,0
        dc.w 0,0,3,0,1,80,24,1,0
        dc.w 15,0,1,0,0,40,1,1,0     ;10: fenetre de menu UNE LIGNE
        dc.w 15,0,2,0,0,80,1,1,0
        dc.w 15,0,3,0,0,80,1,1,0
        dc.w 0,0,1,0,2,40,23,1,0     ;11: fond partiel menu DEUX LIGNES
        dc.w 0,0,2,0,2,80,23,1,0
        dc.w 0,0,3,0,2,80,23,1,0
        dc.w 15,0,1,0,0,40,2,1,0     ;12: fenetre de menus DEUX LIGNES
        dc.w 15,0,2,0,0,80,2,1,0
        dc.w 15,0,3,0,0,80,2,1,0

*************************************************************************+
*       OFF
L300:   dc.w l300a-L300,l300b-L300,0
*************************************
l300a:  jsr L_stopall.l
        moveq #1,d5
l300b:  jmp L_putchar.l

*************************************************************************
*       Fonction MODE
L301:   dc.w 0
***************
        moveq #0,d3
        move.w mode(a5),d3
        move.l d3,-(a6)
        rts

*************************************************************************
*       Instruction MODE
L302:   dc.w l302a-L302,l302b-L302,0
*************************************
        move.l (a6)+,d3
        cmp.l #2,d3
        bcc.s l302x
        cmp.w #2,mode(a5)
        beq.s l302y
l302a:  jsr L_mode.l
l302b:  jmp L_modebis.l
l302x:  moveq #E_illegalfunc,d0
        bra.s l302z
l302y:  moveq #E_resolution,d0
l302z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       PALETTE
L303:   dc.w l303a-L303,l303b-L303,0
*************************************
        move.l adlogic(a5),a0
        lea 32000(a0),a0
l303a:  jsr L_palette2.l
l303b:  jmp L_palette3.l

*************************************************************************
*       LIS LES PARAMETRES D'UNE PALETTE D0=nb / D1=flags
L304:   dc.w 0
***************
        lsl.w #2,d2
        add.w d2,a6
        move.l a6,a3
        subq.w #1,d0
        bmi.s l304c
        clr.w d2
l304a:  btst d2,d1
        beq.s l304b
        move.l -(a3),d4
        andi.w #$777,d4
        move.w d2,d3
        lsl.w #1,d3
        move.w d4,0(a0,d3.w)
l304b:  addq.w #1,d2
        dbra d0,l304a
l304c:  rts

*************************************************************************
*       ENVOIE LA PALETTE AU XBIOS
L305:   dc.w 0
***************
        move.l adlogic(a5),a0
        cmp.l adphysic(a5),a0
        bne.s s7
        lea 32000(a0),a0    ;palette logique
        move.l a0,a1
        move.l adback(a5),a2
        lea 32000(a2),a2     ;palette back
        moveq #15,d0
s6:     move.w (a1)+,(a2)+  ;copie la palette
        dbra d0,s6
        move.l a0,-(sp)
        move.w #6,-(sp)
        trap #14            ;envoie!!!
        addq.l #6,sp
s7:     rts

*************************************************************************
*       GET PALETTE(adecran): ENVOIE AU XBIOS LA PALETTE DE L'IMAGE
L306:   dc.w l306a-L306,0
*************************************
l306a:  jsr L_adscreen.l
        move.l d3,a0
        move.l a0,a1
        move.l adlogic(a5),a2
        lea 32000(a1),a1
        lea 32000(a2),a2
        moveq #15,d0
gtp:    move.w (a1)+,(a2)+  ;copie dans LOGIC
        dbra d0,gtp
        lea 32000(a0),a0
        move.l a0,a1
        move.l adback(a5),a2
        lea 32000(a2),a2
        moveq #15,d0
gts:    move.w (a1)+,(a2)+
        dbra d0,gts
        move.l a0,-(sp)
        move.w #6,-(sp)
        trap #14
        addq.l #6,sp
        rts

*************************************************************************
*       COLOUR
L307:   dc.w l307a-L307,0
**************************
        move.l (a6)+,d1
        andi.l #$777,d1
        move.l (a6)+,d2
        cmp.l #16,d2
        bhi.s l307z
        lsl.w #1,d2
        move.l adlogic(a5),a0
        lea 32000(a0),a0
        move.w d1,0(a0,d2.w)
l307a:  jmp L_palette3.l
l307z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

************************************************************************
*       GET COLOUR
L308:   dc.w 0
***************
        move.l (a6)+,d0
        cmp.l #16,d0
        bcc.s l308z
        lea $ff8240,a0
        lsl.w #1,d0
        move.w 0(a0,d0.w),d3
        andi.l #$777,d3
        move.l d3,-(a6)
        rts
l308z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SHOW OFF
L309:   dc.w 0
***************
        moveq #S_show,d0
        moveq #-1,d1
        trap #5
        rts

*************************************************************************
*       SHOW ON
L310:   dc.w 0
***************
        moveq #S_show,d0
        moveq #0,d1
        trap #5
        rts

*************************************************************************
*       HIDE OFF
L311:   dc.w 0
***************
        moveq #S_hide,d0
        moveq #-1,d1
        trap #5
        rts

*************************************************************************
*       HIDE ON
L312:   dc.w 0
***************
        moveq #S_hide,d0
        moveq #0,d1
        trap #5
        rts

*************************************************************************
*       CHANGE MOUSE
L313:   dc.w 0
***************
        move.l (a6)+,d1
        moveq #S_chgmouse,d0
        trap #5
        rts

*************************************************************************
*       LIMIT MOUSE
L314:   dc.w 0
***************
        moveq #S_limitmouse,d0
        moveq #0,d3
        trap #5
        rts

*************************************************************************
*       LIMIT MOUSE par
L315:   dc.w 0
***************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        cmp.l xmax(a5),d1
        bcc.s l315z
        cmp.l xmax(a5),d3
        bcc.s l315z
        cmp.l ymax(a5),d2
        bcc.s l315z
        cmp.l ymax(a5),d4
        bcc.s l315z
        moveq #S_limitmouse,d0
        trap #5
        rts
l315z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SYNCHRO seul
L316:   dc.w 0
***************
        moveq #S_inter,d0
        trap #5
        rts

*************************************************************************
*       SYNCHRO OFF
L317:   dc.w 0
***************
        moveq #0,d1
        moveq #S_intersynconoff,d0
        trap #5
        rts

*************************************************************************
*       SYNCHRO ON
L318:   dc.w 0
***************
        moveq #1,d1
        moveq #S_intersynconoff,d0
        trap #5
        rts

*************************************************************************
*       UPDATE seul
L319:   dc.w 0
***************
        moveq #S_actualise,d0
        trap #5
        rts

************************************************************************
*       UPDATE off
L320:   dc.w 0
***************
        clr.w actualise(a5)
        moveq #W_update,d7
        moveq #0,d0
        trap #3
        rts

*************************************************************************
*       UPDATE on
L321:   dc.w 0
***************
        move.w #1,actualise(a5)
        moveq #W_update,d7
        moveq #1,d0
        trap #3
        rts

*************************************************************************
*       REDRAW
L322:   dc.w 0
***************
        moveq #S_redraw,d0
        trap #5
        rts

*************************************************************************
*       SPRITE off
L323:   dc.w 0
***************
        moveq #S_spritesonoff,d0
        moveq #0,d2
        trap #5
        rts

*************************************************************************
*       SPRITE on
L324:   dc.w 0
***********************
        moveq #S_spritesonoff,d0
        moveq #1,d2
        trap #5
        rts

*************************************************************************
*       SPRITE off XX
L325:   dc.w 0
***********************
        moveq #S_spritenonoff,d0
        move.l (a6)+,d1
        moveq #0,d2
        trap #5
        tst d0
        bne.s l325z
        rts
l325z:  moveq #E_spriterror,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SPRITE ON xx
L326:   dc.w 0
***********************
        moveq #1,d2
        move.l (a6)+,d1
        moveq #S_spritenonoff,d0
        trap #5
        tst d0
        bne.s l326z
        rts
l326z:  moveq #E_spriterror,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SPRITE xx,yy,zz
L327:   dc.w 0
***********************
        moveq #0,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #S_sprite,d0
        trap #5
        tst d0
        bne.s l327z
        rts
l327z:  moveq #E_spriterror,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SPRITE xx,yy,zz,ii
L328:   dc.w 0
***********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #S_sprite,d0
        trap #5
        tst d0
        bne.s l328z
        rts
l328z:  moveq #E_spriterror,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOVE off
L329:   dc.w 0
***********************
        moveq #0,d2
        moveq #S_movesonoff,d0
        trap #5
        rts

*************************************************************************
*       MOVE on
L330:   dc.w 0
***********************
        moveq #2,d2
        moveq #S_movesonoff,d0
        trap #5
        rts

*************************************************************************
*       MOVE freeze
L331:   dc.w 0
***********************
        moveq #1,d2
        moveq #S_movesonoff,d0
        trap #5
        rts

*************************************************************************
*       MOVE off XX
L332:   dc.w 0
***********************
        moveq #0,d2
        move.l (a6)+,d1
        moveq #S_movenonoff,d0
        trap #5
        tst d0
        bne.s l332z
        rts
l332z:  moveq #E_move_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOVE on XX
L333:   dc.w 0
***********************
        moveq #2,d2
        move.l (a6)+,d1
        moveq #S_movenonoff,d0
        trap #5
        tst d0
        bne.s l333z
        rts
l333z:  moveq #E_move_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOVE frezze XX
L334:   dc.w 0
***********************
        moveq #1,d2
        move.l (a6)+,d1
        moveq #S_movenonoff,d0
        trap #5
        tst d0
        bne.s l334z
        rts
l334z:  moveq #E_move_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ANIM off
L335:   dc.w 0
***********************
        moveq #0,d2
        moveq #S_animsonoff,d0
        trap #5
        rts

*************************************************************************
*       ANIM on
L336:   dc.w 0
***********************
        moveq #2,d2
        moveq #S_animsonoff,d0
        trap #5
        rts

*************************************************************************
*       ANIM freeze
L337:   dc.w 0
***********************
        moveq #1,d2
        moveq #S_animsonoff,d0
        trap #5
        rts

*************************************************************************
*       ANIM off XX
L338:   dc.w 0
***********************
        moveq #0,d2
        move.l (a6)+,d1
        moveq #S_animnonoff,d0
        trap #5
        tst d0
        bne.s l338z
        rts
l338z:  moveq #E_anim_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ANIM on XX
L339:   dc.w 0
***********************
        moveq #2,d2
        move.l (a6)+,d1
        moveq #S_animnonoff,d0
        trap #5
        tst d0
        bne.s l339z
        rts
l339z:  moveq #E_anim_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ANIM freeze XX
L340:   dc.w 0
***********************
        moveq #1,d2
        move.l (a6)+,d1
        moveq #S_animnonoff,d0
        trap #5
        tst d0
        bne.s l340z
        rts
l340z:  moveq #E_anim_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ANIM xx,a$
L341:   dc.w l341a-L341,0
**************************
l341a:  jsr L_chverbuf.l
        cmp.w #250,d2
        bcc.s l341y
        move.l buffer(a5),a0
        moveq #0,d2
        move.l (a6)+,d1
        moveq #S_animinit,d0
        trap #5
        tst d0
        bne.s l341x
        rts
l341x:  moveq #E_anim_decl,d0
        bra.s l341z
l341y:  moveq #E_illegalfunc,d0
l341z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOVE X
L342:   dc.w l342a-L342,0
**************************
l342a:  jsr L_chverbuf.l
        cmp.w #250,d2
        bcc.s l342y
        move.l buffer(a5),a0
        moveq #0,d2
        move.l (a6)+,d1
        moveq #S_moveinit,d0
        trap #5
        tst d0
        bne.s l342x
        rts
l342x:  moveq #E_move_decl,d0
        bra.s l342z
l342y:  moveq #E_illegalfunc,d0
l342z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOVE Y
L343:   dc.w l343a-L343,0
**************************
l343a:  jsr L_chverbuf.l
        cmp.w #250,d2
        bcc.s l343y
        move.l buffer(a5),a0
        moveq #1,d2
        move.l (a6)+,d1
        moveq #S_moveinit,d0
        trap #5
        tst d0
        bne.s l343x
        rts
l343x:  moveq #E_move_decl,d0
        bra.s l343z
l343y:  moveq #E_illegalfunc,d0
l343z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MOVON
L344:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #S_moveon,d0
        trap #5
        move.l d0,-(a6)
        rts

*************************************************************************
*       COLLIDE
L345:   dc.w 0
***********************
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #S_collide,d0
        trap #5
        move.l d0,-(a6)
        rts

*************************************************************************
*       DETECT
L346:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #S_posprite,d0
        trap #5
        cmp.w xmax+2(a5),d0
        bcc.s dtc1
        cmp.w ymax+2(a5),d1
        bcc.s dtc1
        move.l laptsin(a5),a2
        move.w d0,(a2)
        move.w d1,2(a2)
        moveq #S_stopmouse,d0
        trap #5
        move.l adback(a5),$44e
        dc.w $a002
        move.l adlogic(a5),$44e
        moveq #0,d3
        move.w d0,d3
        move.l d3,-(a6)
        moveq #S_restartmouse,d0
        trap #5
        rts
dtc1:   move.l #-1,-(a6)
        rts

*************************************************************************
*       FREEZE
L347:   dc.w 0
***********************
        moveq #M_freeze,d0
        trap #7
        moveq #1,d2
        moveq #S_movesonoff,d0
        trap #5
        moveq #S_animsonoff,d0
        trap #5
        rts

*************************************************************************
*       UNFREEZE
L348:   dc.w 0
***********************
        moveq #M_unfreeze,d0
        trap #7
        moveq #2,d2
        moveq #S_movesonoff,d0
        trap #5
        moveq #S_animsonoff,d0
        trap #5
        rts

*************************************************************************
*       XSPRITE
L349:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #S_posprite,d0
        trap #5
        ext.l d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       YSPRITE
L350:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #S_posprite,d0
        trap #5
        ext.l d1
        move.l d1,-(a6)
        rts

*************************************************************************
*       LIMIT SPRITE
L351:   dc.w 0
***********************
        move.w #-1000,d1
        clr d2
        clr d3
        clr d3
        moveq #S_chglimit,d0
        trap #5
        rts

*************************************************************************
*       LIMIT SPRITE
L352:   dc.w 0
***********************
        move.l (a6)+,d4
        move.l (a6)+,d2
        move.l (a6)+,d3
        move.l (a6)+,d1
        moveq #S_chglimit,d0
        trap #5
        rts

*************************************************************************
*       PUTSPRITE
L353:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #S_putsprite,d0
        trap #5
        rts

*************************************************************************
*       GET SPRITE 3
L354:   dc.w 0
***********************
        moveq #0,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #S_getsprite,d0
        trap #5
        tst d0
        bne.s l354z
        rts
l354z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       GET SPRITE 4
L355:   dc.w 0
***********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #S_getsprite,d0
        trap #5
        tst d0
        bne.s l355z
        rts
l355z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       PRIORITY OFF
L356:   dc.w 0
***********************
        moveq #0,d1
        moveq #S_priority,d0
        trap #5
        rts

*************************************************************************
*       PRIORITY ON
L357:   dc.w 0
***********************
        moveq #1,d1
        moveq #S_priority,d0
        trap #5
        rts


*************************************************************************
*       SCREEN COPY / CALCULATIONS
L358:   dc.w 0
***************
        moveq #0,d7
        move d1,d7          ;garde le decalage en D7
        andi.w #$fff0,d1
        andi.w #$fff0,d3
        andi.w #$fff0,d5
        andi.w #$f,d7
        move d2,-(sp)
        move d1,-(sp)
        tst d1              ;X1
        bpl.s scc6
        clr d1
        bset #31,d7         ;met le flag: tronqu‚ a gauche!!!
scc6:   cmp.w xmax+2(a5),d1
        bcc pascc1
        tst d2              ;Y1
        bpl.s scc7
        clr d2
scc7:   cmp.w ymax+2(a5),d2
        bcc pascc1
        tst d5              ;X2
        bmi pascc1
        beq pascc1
        cmp.w xmax+2(a5),d5
        bcs.s scc8
        move.w xmax+2(a5),d5
scc8:   tst d6              ;Y2
        bmi pascc1
        beq pascc1
        cmp.w ymax+2(a5),d6
        bcs.s scc9
        move.w ymax+2(a5),d6
scc9:   sub d1,d5           ;calcule TX
        bcs.s pascc1
        beq.s pascc1
        sub d2,d6           ;calcule TY
        beq.s pascc1
        bcs.s pascc1
; TESTE L'ARRIVEE
        move d1,d0
        sub (sp)+,d0
        add d0,d3           ;decale l'arrivee vers la droite
        btst #31,d7
        beq.s scc9a
        andi.w #$000f,d7
        beq.s scc9a           ;Si coupe a gauche ET decalage,
        subi.w #16,d3
        addi.w #16,d5
scc9a:  move d2,d0
        sub (sp)+,d0
        add d0,d4           ;decale l'arrivee vers le bas
        cmp xmax+2(a5),d3
        bge.s pascc2
        cmp ymax+2(a5),d4
        bge.s pascc2
; limite l'arrivee a gauche
        tst d3
        bpl.s scc10
        move d3,d0
        clr d3
        neg d0              ;taille rajoutee!
        sub d0,d5           ;diminue TX
        bcs.s pascc2
        beq.s pascc2        ;si plus grand: sortie!!!
        add d0,d1           ;decale a droite X1
; limite l'arrivee en haut
scc10:  tst d4
        bpl.s scc11
        move d4,d0
        clr d4
        neg d0
        sub d0,d6
        bcs.s pascc2
        beq.s pascc2
        add d0,d2
; limite l'arrivee a droite
scc11:  move d3,d0
        add d5,d0
        sub xmax+2(a5),d0
        bcs.s scc12
        sub d0,d5           ;limite la TX
        beq.s pascc2
; limite l'arrivee en bas
scc12:  move d4,d0
        add d6,d0
        sub ymax+2(a5),d0
        bcs.s scc13
        sub d0,d6           ;limite la TY
        beq.s pascc2
; les tests sont finis! OUF!
scc13:  moveq #0,d0         ;Pas d'erreur!
        rts
pascc1: addq.l #4,sp
pascc2: moveq #1,d0         ;erreur!
        rts

*************************************************************************
*       SCREEN COPY complet
L359:   dc.w l359a-L359,l359b-L359,0
***************************************
l359a:  jsr L_adscreen.l
        move.l d3,-(sp)
l359b:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,a1
        moveq #0,d5
        moveq #S_scrcopy,d0
        trap #5
        rts

*************************************************************************
*       SCREEN COPY partiel
L360:   dc.w l360a-L360,l360b-L360,l360c-L360,0
************************************************
        move.l (a6)+,-(sp)
        move.l (a6)+,-(sp)
l360a:  jsr L_adscreen.l
        move.l d3,-(sp)
        move.l (a6)+,d6
        move.l (a6)+,d5
        move.l (a6)+,d2
        move.l (a6)+,d1
l360b:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,a1
        move.l (sp)+,d3
        move.l (sp)+,d4
l360c:  jsr L_screencalc.l
        bne.s l360z
        moveq #S_scrcopy,d0
        trap #5
l360z:  rts

*************************************************************************
*       =SCREEN$
L361:   dc.w l361a-L361,l361b-L361,0
*************************************
        move.l (a6)+,d4
        move.l (a6)+,d7
        move.l (a6)+,d2
        move.l (a6)+,d1
l361a:  jsr L_adscreen.l
        move.l d3,a1
        move.l d7,d3
        andi.w #$fff0,d1
        andi.w #$fff0,d3
        cmp.l xmax(a5),d1
        bcc.s l361z
        cmp.l ymax(a5),d2
        bcc.s l361z
        cmp.l xmax(a5),d3
        bhi.s l361z
        cmp.l ymax(a5),d4
        bhi.s l361z
        sub.l d1,d3           ;Calcule TX et TY
        bcs.s l361z
        beq.s l361z
        sub.l d2,d4
        bcs.s l361z
        beq.s l361z
        move.w d3,d5
        lsr.w #4,d5
        mulu d4,d5            ;TX*TY
        moveq #3,d0
        sub.w mode(a5),d0
        lsl.w d0,d5           ;fois NBPLANS*2
        addq.l #8,d5          ;plus flags---> taille de la chaine
        movem.l a1/d1/d2/d3/d4,-(sp)
        move.l d5,d3
l361b:  jsr L_malloc.l
        move.l a0,-(a6)       ;debut de la chaine
        move.l a0,a2
        move.w d3,(a2)+       ;poke la taille
        movem.l (sp)+,a1/d1/d2/d3/d4
; Appel de la trappe
        moveq #S_getblock,d0
        trap #5
        btst #0,d0
        beq.s l361x
        addq.l #1,d0
l361x:  move.l d0,hichaine(a5) ;Ramene la fin de la chaine
        rts
l361z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SCREEN()=
L362:   dc.w l362a-L362,0
**************************
        move.l (a6)+,-(sp)    ;Adresse chaine
        move.l (a6)+,d2
        move.l (a6)+,d1
l362a:  jsr L_adscreen.l
        move.l d3,a2
        move.l (sp)+,a1
        cmp.w #8,(a1)+
        bcs.s l362z
        moveq #S_putblock,d0
        trap #5
        tst d0
        bne.s l362z
        rts
l362z:  moveq #E_string_notblock,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       DEF SCROLL
L363:   dc.w l363a-L363,0
**************************
        move.l (a6)+,d2
        move.l (a6)+,d1
        move.l (a6)+,d6
        move.l (a6)+,d5
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,-(sp)
        andi.w #$fff0,d3       ;Multiple de 16 en X
        neg.l d1
        neg.l d2
        add.l d3,d1
        add.l d4,d2
l363a:  jsr L_screencalc.l            ;Calcule les parametres screen copy
        bne.s l363z
        move.l (sp)+,d0       ;Numero du scrolling
        subq.l #1,d0
        cmp.l #16,d0
        bcc.s l363z
        lsl #4,d0
        move.l dfst(a5),a0
        add.w d0,a0
        move.w d1,(a0)+       ;Stocke dans la table
        move.w d2,(a0)+
        move.w d3,(a0)+
        move.w d4,(a0)+
        move.w d5,(a0)+
        move.w d6,(a0)+
        move.l d7,(a0)
        rts
l363z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SCROLL
L364:   dc.w 0
***********************
        move.l (a6)+,d3
        subq.l #1,d3
        cmp.l #16,d3
        bcc.s scr1
        lsl.w #4,d3
        move.l dfst(a5),a0
        add.w d3,a0
        move.w (a0)+,d1
        move.w (a0)+,d2
        move.w (a0)+,d3
        move.w (a0)+,d4
        move.w (a0)+,d5
        beq.s scr1
        move.w (a0)+,d6
        beq.s scr1
        move.l (a0),d7
        move.l adlogic(a5),a0
        move.l a0,a1
        moveq #S_scrcopy,d0
        trap #5
        rts
scr1:   moveq #E_scroll_def,d0          ;Scrolling non defini
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       RESET ZONE seul
L365:   dc.w 0
***********************
        moveq #S_initzones,d0
        trap #5
        rts

*************************************************************************
*       RESET ZONE param
L366:   dc.w 0
***********************
        move.l (a6)+,d1
        cmp.l #128,d1
        bcc.s l366z
        moveq #0,d2
        moveq #1,d3
        moveq #0,d4
        moveq #1,d5
        moveq #S_setzone,d0
        trap #5
        rts
l366z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SET ZONE
L367:   dc.w 0
***********************
        move.l (a6)+,d5
        move.l (a6)+,d3
        move.l (a6)+,d4
        move.l (a6)+,d2
        move.l (a6)+,d1
        addi.l #640,d2
        addi.l #640,d3
        addi.l #400,d4
        addi.l #400,d5
        moveq #S_setzone,d0
        trap #5
        tst.w d0
        bne.s l367z
        rts
l367z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ZONE(xx)
L368:   dc.w 0
***********************
        move.l (a6)+,d1
        cmp.l #128,d1
        bcc.s l368z
        moveq #S_zone,d0
        trap #5
        moveq #0,d3
        move.w d1,d3
        move.l d3,-(a6)
        rts
l368z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       REDUCE TO x,x,x,x
L369:   dc.w l369a-L369,0
***************************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        move.l adlogic(a5),a0
        move.l a0,a1
        moveq #1,d7                     ;AUTOBACK!
l369a:  jmp L_reduce.l

*************************************************************************
*       REDUCE ecran to x,x,x,x
L370:   dc.w l370a-L370,l370b-L370,0
**********************************************
        move.l (a6)+,d4
        move.l (a6)+,-(sp)
        move.l (a6)+,d2
        move.l (a6)+,-(sp)
l370a:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,d1
        move.l (sp)+,d3
        move.l adlogic(a5),a1
        moveq #1,d7
l370b:  jmp L_reduce.l

*************************************************************************
*       REDUCE to ecran,x,x,x,x
L371:   dc.w l371a-L371,l371b-L371,0
**********************************************
        move.l (a6)+,d4
        move.l (a6)+,-(sp)
        move.l (a6)+,d2
        move.l (a6)+,-(sp)
l371a:  jsr L_adscreen.l
        move.l d3,a1
        move.l (sp)+,d1
        move.l (sp)+,d3
        move.l adlogic(a5),a0
        moveq #0,d7
l371b:  jmp L_reduce.l

*************************************************************************
*       REDUCE ecran to ecran,x,x,x,x
L372:   dc.w l372a-L372,l372b-L372,l372c-L372,0
**********************************************
        move.l (a6)+,d4
        move.l (a6)+,-(sp)
        move.l (a6)+,d2
        move.l (a6)+,-(sp)
l372a:  jsr L_adscreen.l
        move.l d3,-(sp)
l372b:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,a1
        move.l (sp)+,d1
        move.l (sp)+,d3
        moveq #0,d7
l372c:  jmp L_reduce.l

*************************************************************************
*       REDUCE!
L373:   dc.w 0
***********************
        cmp.l xmax(a5),d1
        bcc.s l373z
        cmp.l ymax(a5),d2
        bcc.s l373z
        cmp.l xmax(a5),d3
        bcc.s l373z
        cmp.l ymax(a5),d4
        bcc.s l373z
        sub d1,d3
        beq.s l373z
        bcs.s l373z
        sub d2,d4
        beq.s l373z
        bcs.s l373z
        tst.w d7
        bne.s rdc2
; DEUX ADRESSES D'ECRAN
rdc1:   move #S_reduce,d0
        trap #5
        rts
; AUTOBACK
rdc2:   tst autoback(a5)
        beq.s rdc1
        move d1,-(sp)
        moveq #S_stopmouse,d0
        trap #5
        move (sp)+,d1
        move.l adback(a5),a1            ;Appel!
        moveq #S_reduce,d0
        trap #5
        move.l adlogic(a5),a1
        move.l adback(a5),a0
        moveq #0,d5
        moveq #S_scrcopy,d0
        trap #5
        moveq #S_drawsprites,d0
        trap #5
        rts
l373z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       ZOOM x,x,x,x to x,x,x,x
L374:   dc.w l374a-L374,0
**************************
        move.l (a6)+,a3
        move.l (a6)+,a2
        move.l (a6)+,d6
        move.l (a6)+,d5
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        move.l adlogic(a5),a0
        move.l a0,a1
        moveq #1,d7
l374a:  jmp L_zoom.l

*************************************************************************
*       ZOOM ecran,x,x,x,x to x,x,x,x
L375:   dc.w l375a-L375,l375b-L375,0
**********************************************
        move.l (a6)+,a3
        move.l (a6)+,a2
        move.l (a6)+,d6
        move.l (a6)+,d5
        move.l (a6)+,d4
        move.l (a6)+,-(sp)
        move.l (a6)+,d2
        move.l (a6)+,-(sp)
l375a:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,d1
        move.l (sp)+,d3
        move.l adlogic(a5),a1
        moveq #1,d7
l375b:  jmp L_zoom.l

*************************************************************************
*       ZOOM x,x,x,x to ECRAN,x,x,x,x
L376:   dc.w l376a-L376,l376b-L376,0
**********************************************
        move.l (a6)+,a3
        move.l (a6)+,a2
        move.l (a6)+,d6
        move.l (a6)+,d5
l376a:  jsr L_adscreen.l
        move.l d3,a1
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        move.l adlogic(a5),a0
        moveq #0,d7
l376b:  jmp L_zoom.l

*************************************************************************
*       ZOOM ecran,x,x,x,x to ecran,x,x,x,x
L377:   dc.w l377a-L377,l377b-L377,l377c-L377,0
**********************************************
        move.l (a6)+,a3
        move.l (a6)+,a2
        move.l (a6)+,d6
        move.l (a6)+,d5
l377a:  jsr L_adscreen.l
        move.l d3,-(sp)
        move.l (a6)+,d4
        move.l (a6)+,-(sp)
        move.l (a6)+,d2
        move.l (a6)+,-(sp)
l377b:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,d1
        move.l (sp)+,d3
        move.l (sp)+,a1
        moveq #0,d7
l377c:  jmp L_zoom.l

*************************************************************************
*       ZOOM !
L378:   dc.w 0
***********************
        cmp.l xmax(a5),d1
        bcc l378z
        cmp.l ymax(a5),d2
        bcc l378z
        cmp.l xmax(a5),d3
        bcc.s l378z
        cmp.l ymax(a5),d4
        bcc.s l378z
        sub.l d1,d3
        beq.s l378z
        bcs.s l378z
        sub.l d2,d4
        beq.s l378z
        bcs.s l378z
        cmp.l xmax(a5),d5
        bcc.s l378z
        cmp.l ymax(a5),d6
        bcc.s l378z
        cmp.l xmax(a5),a2
        bcc.s l378z
        cmp.l ymax(a5),a3
        bcc.s l378z
        move.l a2,d0
        sub.l d5,d0
        beq.s l378z
        bcs.s l378z
        move.l d0,a2
        move.l a3,d0
        sub.l d6,d0
        beq.s l378z
        bcs.s l378z
        move.l d0,a3
        cmp d3,a2
        bcs.s l378z
        cmp d4,a3
        bcs.s l378z
        tst.w d7
        bne.s zm2
; ecran de destination CHOISI!
zm1:    moveq #S_zoom,d0        ;fonction ZOOM de la trappe
        trap #5
        rts
; ecran de destination par defaut!
zm2:    tst autoback(a5)
        beq.s zm1
        move d1,-(sp)
        moveq #S_stopmouse,d0
        trap #5
        move (sp)+,d1
        move.l adback(a5),a1
        moveq #S_zoom,d0
        trap #5
        move.l adlogic(a5),a1
        move.l adback(a5),a0
        clr.l d5
        moveq #S_scrcopy,d0
        trap #5
        moveq #S_drawsprites,d0
        trap #5
        rts
l378z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       APPEAR -un param
L379:   dc.w l379a-L379,l379b-L379,0
**********************************************
l379a:  jsr L_adscreen.l
        move.l d3,-(sp)
        move.l #70,-(a6)
l379b:  jsr L_rnd.l
        move.l (a6)+,d1
        addq.w #1,d1
        move.l (sp)+,a0
        move.l adphysic(a5),a1
        moveq #S_appear,d0
        trap #5
        rts

*************************************************************************
*       APPEAR -deux params
L380:   dc.w l380a-L380,0
***********************
        move.l (a6)+,-(sp)
l380a:  jsr L_adscreen.l
        move.l d3,a0
        move.l adphysic(a5),a1
        move.l (sp)+,d1
        cmp.l #80,d1
        bhi.s l380z
        moveq #S_appear,d0
        trap #5
        rts
l380z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FADE 1
L381:   dc.w l381a-L381,0
***********************
        move.l adlogic(a5),a0
        lea 32000(a0),a0
        moveq #15,d0
l381p:  clr.w (a0)+
        dbra d0,l381p
        move.w #$ffff,d1
l381a:  jmp L_fade.l

*************************************************************************
*       FADE 2
L382:   dc.w l382a-L382,l382b-L382,0
**********************************************
l382a:  jsr L_adscreen.l
        move.l d3,a0
        move.l adlogic(a5),a1
        lea 32000(a0),a0
        lea 32000(a1),a1
        moveq #15,d0
l382p:  move.w (a0)+,(a1)+
        dbra d0,l382p
        move.w #$ffff,d1
l382b:  jmp L_fade.l

*************************************************************************
*       FADE 3
L383:   dc.w l383a-L383,l383b-L383,0
**********************************************
        move.w d1,-(sp)
        move.l adlogic(a5),a0
        lea 32000(a0),a0
l383a:  jsr L_palette2.l
        move.w (sp)+,d1
l383b:  jmp L_fade.l

*************************************************************************
*       FADE!
L384:   dc.w 0
***********************
        move.l adlogic(a5),a0
        move.l adback(a5),a1
        lea 32000(a0),a0
        lea 32000(a1),a1
        moveq #15,d0
g6:     move.w (a0)+,(a1)+  ;copie dans le back
        dbra d0,g6
        move.w d1,d2        ;FLAG
        move.l (a6)+,d1
        beq.s g7
        cmp.l #1000,d1
        bcc.s g7
        moveq #S_fade,d0        ;Fonction FADE
        trap #5             ;debut
        rts
g7:     moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FLASH OFF
L385:   dc.w 0
***********************
        moveq #S_initflash,d0
        trap #5
        rts

*************************************************************************
*       FLASH xx,a$
L386:   dc.w l386a-L386,0
***********************
l386a:  jsr L_chverbuf.l
        move.l (a6)+,d1
        move.l buffer(a5),a0
        moveq #S_flash,d0
        trap #5
        tst.w d0
        bne.s l386z
        rts
l386z:  moveq #E_flash_decl,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SHIFT OFF
L387:   dc.w 0
***********************
        moveq #0,d1
        moveq #S_shifton,d0
        trap #5
        rts

*************************************************************************
*       SHIFT nn
L388:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #1,d2
        moveq #S_shifton,d0
        trap #5
        rts

*************************************************************************
*       SHIFT nn,x
L389:   dc.w 0
***********************
        move.l (a6)+,d2
        move.l colmax(a5),d0
        subq.l #1,d0
        cmp.l d0,d2
        bcc.s l389z
        move.l (a6)+,d1
        moveq #S_shifton,d0
        trap #5
        rts
l389z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       REDESSIN -1
L390:   dc.w l390a-L390,0
**************************
        move.l defback(a5),d3
        move.l d3,adback(a5)
        move.l d3,a0
        moveq #S_chgscreen,d0
        trap #5
        move.l d3,a0
        moveq #W_setback,d7
        trap #3
        move.l deflog(a5),d0
        move.l d0,adlogic(a5)
        move.l d0,adphysic(a5)
        move.w #-1,-(sp)
        move.l d0,-(sp)
        move.l d0,-(sp)
        move #5,-(sp)
        trap #14
        lea 12(sp),sp
        move.w #4,-(sp)
        trap #14
        addq.l #2,sp
        move d0,mode(a5)
        cmp.w #2,d0
        beq.s l390z
        cmp.w defmod(a5),d0             ;MODE par DEFAUT?
        beq.s l390z
        moveq #0,d3
        move.w defmod(a5),d0
l390a:  jsr L_mode.l
l390z:  rts

*************************************************************************
*       REDESSIN -2
L391:   dc.w l391a-L391,l391b-L391,l391c-L391,0
*************************************
        move.l amb(a5),a0
        move.w 32(a0),cursflg(a5)       ;Prend le curseur par 299!
        move.w 32+2(a0),foncon(a5)      ;Touches de fonction
        clr mnd+12(a5)
l391a:  jsr L_menuoff.l                 ;menuoff
l391b:  jsr L_modebis.l

; Poke l'ambiance par 299
        move.l amb(a5),a0
        move.w 40(a0),d2
        move.l adlogic(a5),a1
        lea 32000(a1),a1
        move.l a1,a2
        moveq #15,d0
l391p:  move.w (a0)+,(a1)+
        dbra d0,l391p
        cmp.w #2,mode(a5)               ;Si noir et blanc---> poke inverse
        bne.s l391c
        move.w d2,(a2)
l391c:  jsr L_palette3.l

; Termine
        move.l amb(a5),a0
        tst.w 42(a0)
        beq.s PaCho
        moveq #S_show,d0
        moveq #0,d1
        trap #5
PaCho:  moveq #M_initsound,d0
        trap #7
        move.b #6,$484 /* FIXME */
        clr.b bip(a5)
        rts

*************************************************************************
*       DEFAULT
L392:   dc.w l392a-L392,l392b-L392,0
**********************************************
l392a:  jsr L_redessin.l
l392b:  jmp L_redessin2.l

*************************************************************************
*       MUSIC off
L393:   dc.w 0
***********************
        moveq #M_initsound,d0
        trap #7
        bclr #1,bip(a5)
        rts

*************************************************************************
*       MUSIC FREEZE
L394:   dc.w 0
***********************
        moveq #M_freeze,d0
        trap #7
        rts

*************************************************************************
*       MUSIC ON
L395:   dc.w 0
***********************
        moveq #M_unfreeze,d0
        trap #7
        bset #1,bip(a5)
        rts

*************************************************************************
*       MUSIC nn
L396:   dc.w l396a-L396,0
**************************
        moveq #3,d3
l396a:  jsr L_adbank.l
        beq.s l396z
        cmp.l #$13490157,(a1)
        bne.s l396z
        move.l (a6)+,d3
        beq.s l396z
        cmp.l #32,d3
        bhi.s l396z
        lsl.w #2,d3
        move.l 0(a1,d3.w),d0
        beq.s l396z
        move.l d0,a0
        add.l a1,a0
        moveq #M_startmusic,d0
        trap #7
        bset #1,bip(a5)
        rts
l396z:  moveq #E_music_def,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       PVOICE
L397:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #M_voicepos,d0
        trap #7
        move.l d0,-(a6)
        rts

*************************************************************************
*       VOICE off
L398:   dc.w l398a-L398,0
**************************
        moveq #0,d2
l398a:  jmp L_setvoice.l

*************************************************************************
*       VOICE on
L399:   dc.w 0
***********************
        moveq #M_restartvoice,d0         ;remet toutes les voix
        moveq #1,d1
        trap #7
        moveq #M_restartvoice,d0
        moveq #2,d1
        trap #7
        moveq #M_restartvoice,d0
        moveq #3,d1
        trap #7
        rts

*************************************************************************
*       VOICE OFF nn
L400:   dc.w 0
***********************
        moveq #0,d2
        move.l (a6)+,d1
        moveq #M_stopvoice,d0
        trap #7
        rts

*************************************************************************
*       VOICE ON nn
L401:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #M_restartvoice,d0
        trap #7
        rts

*************************************************************************
*       VOICE OFF xx,tt
L402:   dc.w 0
***********************
        move.l (a6)+,d2
        move.l (a6)+,d1
        moveq #M_stopvoice,d0
        trap #7
        rts

*************************************************************************
*       TEMPO
L403:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #M_tempo,d0
        trap #7
        rts

*************************************************************************
*       TRANSPOSE
L404:   dc.w 0
***********************
        move.l (a6)+,d1
        moveq #M_transpose,d0
        trap #7
        rts

*************************************************************************
*       VO
L405:   dc.w 0
***********************
        moveq #M_stopvoice,d0
        moveq #1,d1
        trap #7
        moveq #M_stopvoice,d0
        moveq #2,d1
        trap #7
        moveq #M_stopvoice,d0
        moveq #3,d1
        trap #7
        rts

*************************************************************************
*       STMUS
L406:   dc.w l406a-L406,0
**************************
        move.l a0,a3
stm1:   move.b (a3)+,d1
        cmp.b #16,d1
        bcc.s stm2
        move.b (a3)+,d0
l406a:  jsr L_putgia.l
        bra.s stm1
stm2:   rts

*************************************************************************
*       STENV
L407:   dc.w l407a-L407,l407b-L407,0
**********************************************
        moveq #13,d1
l407a:  jsr L_getgia.l
        moveq #13,d1
l407b:  jmp L_putgia.l

*************************************************************************
*       GETGIA: prend le registre D1 du circuit son
L408:   dc.w 0
***********************
        andi.w #$f,d1
        bclr #7,d1
        move.w d1,-(sp)
        clr.w -(sp)
        move.w #28,-(sp) /* Giaccess */
        trap #14
        addq.l #6,sp
        rts

*************************************************************************
*       PUTGIA: met D0 dans le registre D1 du circuit son
L409:   dc.w 0
***********************
        andi.w #$f,d1
        bset #7,d1
        move.w d1,-(sp)
        move.w d0,-(sp)
        move.w #28,-(sp) /* Giaccess */
        trap #14
        addq.l #6,sp
        rts

*************************************************************************
*       SHOOT
L410:   dc.w l410a-L410,l410b-L410,0
*************************************
        moveq #40,d2
l410a:  jsr L_setvoice.l
        lea tshoot(pc),a0
l410b:  jmp L_setmusic.l
tshoot: dc.b 0,0,1,0,2,0,3,0,4,0,5,0,6,12
        dc.b 8,$10,9,$10,10,$10,11,0,12,12,13,9,7,$c0,$ff,0

*************************************************************************
*       EXPLODE
L411:   dc.w l411a-L411,l411b-L411,0
**********************************************
        moveq #60,d2
l411a:  jsr L_setvoice.l
        lea texp(pc),a0
l411b:  jmp L_setmusic.l
texp:   dc.b 0,0,1,0,2,0,3,0,4,0,5,0,6,31
        dc.b 8,$10,9,$10,10,$10,11,0,12,50,13,9,7,$c0,$ff,0

*************************************************************************
*       PING
L412:   dc.w l412a-L412,l412b-L412,0
**********************************************
        moveq #50,d2
l412a:  jsr L_setvoice.l
        lea tping(pc),a0
l412b:  jmp L_setmusic.l
tping:  dc.b 8,$10,9,0,10,0,11,0,12,20,13,9
        dc.b 0,47,1,0,2,47,3,0,4,47,5,0,6,0,7,$f8,$ff,0

*************************************************************************
*       ENVEL
L413:   dc.w l413a-L413,l413b-L413,l413c-L413,0
**********************************************
        move.l (a6),d0
        moveq #11,d1
l413a:  jsr L_putgia.l
        move.l (a6)+,d0
        lsr #8,d0
        moveq #12,d1
l413b:  jsr L_putgia.l
        move.l (a6)+,d0
        andi.w #$f,d0
        moveq #13,d1
l413c:  jmp L_putgia.l

*************************************************************************
*       VOLUME xx
L414:   dc.w l414a-L414,l414b-L414,l414c-L414,0
**********************************************
        move.l (a6)+,d3
        move.b d3,volumes(a5)
        move.b d3,volumes+1(a5)
        move.b d3,volumes+2(a5)
        moveq #8,d1
        move d3,d0
l414a:  jsr L_putgia.l
        move d3,d0
        moveq #9,d1
l414b:  jsr L_putgia.l
        move d3,d0
        moveq #10,d1
l414c:  jmp L_putgia.l

*************************************************************************
*       VOLUME xx,nn
L415:   dc.w l415a-L415,0
***********************
        move.l (a6)+,d0
        move.l (a6)+,d1
        beq.s l415z
        cmp.l #4,d1
        bcc.s l415z
        lea volumes(a5),a0
        move.b d0,-1(a0,d1.w)
        addq #7,d1
l415a:  jsr L_putgia.l
l415z:  rts

*************************************************************************
*       NOISE freq
L416:   dc.w l416a-L416,l416b-L416,0
**********************************************
        move.l (a6)+,d1
        andi.w #$1f,d1
        lea tn(pc),a0
        move.b d1,1(a0)
l416a:  jsr L_setmusic.l
l416b:  jmp L_setenvelope.l
tn:     dc.b 6,0,0,0,1,0,2,0,3,0,4,0,5,0,7,$c0,$ff,0

*************************************************************************
*       NOISE voix,freq
L417:   dc.w l417a-L417,l417b-L417,l417c-L417,l417d-L417,0
*********************************************************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        beq.s l417z
        cmp.l #4,d2
        beq.s l417z
        andi.w #$1f,d1
        move d2,d7
        subq #2,d2
        beq.s ns6
        bpl.s ns7
        lea tn1(pc),a0
        move.w #%11110110,d3
        bra.s ns8
ns6:    lea tn2(pc),a0
        move.w #%11101101,d3
        bra.s ns8
ns7:    lea tn3(pc),a0
        move.w #%11011011,d3
ns8:    move.b d1,1(a0)
l417a:  jsr L_setmusic.l
        moveq #7,d1
l417b:  jsr L_getgia.l
        and d3,d0
        moveq #7,d1
l417c:  jsr L_putgia.l
        lea volumes(a5),a0
        cmp.b #16,-1(a0,d7.w)
        beq.s l417d
l417z:  rts
l417d:  jmp L_setenvelope.l
tn1:    dc.b 6,0,0,0,1,0,$ff,0
tn2:    dc.b 6,0,2,0,3,0,$ff,0
tn3:    dc.b 6,0,4,0,5,0,$ff,0


*************************************************************************
*       NOTE TWO / THREE VOICES
L418:   dc.w l418a-L418,l418b-L418,l418c-L418,l418d-L418
        dc.w l418e-L418,l418f-L418,l418g-L418,0
*************************************
        cmp.w #3,d0
        beq.s nt5
        move.l (a6)+,-(sp)
        move.l (a6)+,d2
        cmp.l #97,d2
        bcc nt10
        lea tfreq(pc),a0
        lsl #1,d2
        move.w 0(a0,d2.w),d0
        lea te(pc),a0
        move.b d0,1(a0)
        move.b d0,3(a0)
        move.b d0,5(a0)
        lsr #8,d0
        move.b d0,7(a0)
        move.b d0,9(a0)
        move.b d0,11(a0)
l418a:  jsr L_setmusic.l
l418b:  jsr L_setenvelope.l
        bra.s nt10
; note sur une SEULE VOIX
nt5:    move.l (a6)+,-(sp)
        move.l (a6)+,d2
        move.l (a6)+,d3
        beq.s nt10
        cmp.l #4,d3
        bcc.s nt10
        move d3,d7
        subq #2,d3
        beq.s nt6
        bpl.s nt7
        lea te1(pc),a0
        move.w #%11111110,d3
        bra.s nt8
nt6:    lea te2(pc),a0
        move.w #%11111101,d3
        bra.s nt8
nt7:    lea te3(pc),a0
        move.w #%11111011,d3
nt8:    lea tfreq(pc),a1
        cmp.l #97,d2
        bcc.s nt10
        lsl #1,d2
        move.w 0(a1,d2.w),d0
        move.b d0,1(a0)
        lsr #8,d0
        move.b d0,3(a0)
l418c:  jsr L_setmusic.l
        moveq #7,d1
l418d:  jsr L_getgia.l
        and d3,d0
        moveq #7,d1
l418e:  jsr L_putgia.l
        lea volumes(a5),a0
        cmp.b #16,-1(a0,d7.w)
        bne.s nt10
l418f:  jsr L_setenvelope.l
; attend la fin de la note
nt10:   move.l (sp)+,d0
        bne.s nt11
        rts
nt11:   move.l d0,-(a6)
l418g:  jmp L_wait.l
te:     dc.b 0,0,2,0,4,0,1,0,3,0,5,0,7,$f8,$ff,0
te1:    dc.b 0,0,1,0,$ff,0
te2:    dc.b 2,0,3,0,$ff,0
te3:    dc.b 4,0,5,0,$ff,0
tfreq:  dc.w 0
        dc.w 3822,3608,3405,3214,3034,2863,2703,2551,2408,2273,2145,2025
        dc.w 1911,1804,1703,1607,1517,1432,1351,1276,1204,1136,1073,1012
        dc.w 956,902,851,804,758,716,676,638,602,568,536,506
        dc.w 476,451,426,402,379,358,338,319,301,284,268,253
        dc.w 239,225,213,201,190,179,169,159,150,142,134,127
        dc.w 119,113,106,100,95,89,84,80,75,71,67,63
        dc.w 60,56,53,50,47,45,42,40,38,36,34,32
        dc.w 30,28,27,25,24,22,21,20,19,18,17,16

*************************************************************************
*       =PSG
L419:   dc.w l419a-L419,0
**************************
        moveq #0,d3
        move.l (a6)+,d1
        cmp.l #14,d1
        bcc.s l419z
l419a:  jsr L_getgia.l
        move.b d0,d3
l419z:  move.l d3,-(a6)
        rts

*************************************************************************
*       PSG=
L420:   dc.w l420a-L420,0
***********************
        move.l (a6)+,d0
        andi.l #$ff,d0
        move.l (a6)+,d1
        cmp.l #14,d1
        bcc.s l420z
l420a:  jsr L_putgia.l
l420z:  rts


*************************************************************************
*       KEY SPEED
L421:   dc.w 0
***********************
        move.l (a6)+,d1
        move.l (a6)+,d2
        cmp.l #$8000,d1
        bcs.s ksp1
        moveq #-1,d0
ksp1:   cmp.l #$8000,d2
        bcs.s ksp2
        moveq #-1,d2
ksp2:   move.w d2,-(sp)
        move.w d1,-(sp)
        move.w #35,-(sp)
        trap #14            ;appel de KBRATE
        addq.l #6,sp
        rts

*************************************************************************
*       FIX le nombre de decimales
L422:   dc.w 0
***********************
        move.l (a6)+,d3
        tst.l d3
        bmi.s fx2            ;fix>0 : mode normal
        clr expflg(a5)
fx0:    cmp.l #16,d3        ;fix >15: force proportionnel
        bcs.s fx1
        move #-1,d3
fx1:    move d3,fixflg(a5)
        rts
fx2:    neg.l d3
        move #1,expflg(a5)
        bra.s fx0

*************************************************************************
*       ICON$ (xx): CHR$(27)+CHR$(XX)
L423:   dc.w l423a-L423,0
***********************
        moveq #3,d3
l423a:  jsr L_malloc.l
        move.l (a6)+,d3
        beq.s l423z
        cmp.l #256,d3
        bcc.s l423z
        move.w #2,(a0)+
        move.b #27,(a0)+
        move.b d3,(a0)+
        move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
l423z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       TAB (xx): FONCTION !!!
L424:   dc.w l424a-L424,0
***********************
        move.l (a6)+,d3
        beq.s l424v
        cmp.l #65500,d3
        bcc.s l424z
l424a:  jsr L_malloc.l
        move.w d3,(a0)+
        subq #1,d3
tab1:   move.b #9,(a0)+
        dbra d3,tab1
        move.w a0,d0
        btst #0,d0
        beq.s tab2
        addq.l #1,a0
tab2:   move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
l424v:  move.l chvide(a5),-(a6)
        rts
l424z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CHARLEN(xx): RAMENE LA LONGUEUR D'UN JEU DE CARACTERES
L425:   dc.w 0
***********************
        move.l (a6)+,d0
        subq #1,d0
        bcs.s l425z
        cmp.w #16,d0
        bcc.s l425z
        andi.w #$f,d0
        moveq #W_getcharset,d7
        trap #3
        tst.l d0
        beq.s charl1
        move.l d0,a1
        move 4(a1),d0
        mulu 6(a1),d0
        mulu #224,d0
        addi.w #264,d0
charl1: move.l d0,-(a6)
        rts
l425z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CHAR COPY xx TO # de banque
L426:   dc.w l426a-L426,l426b-L426,l426c-L426,l426d-L426
        dc.w l426e-L426,l426f-L426,l426g-L426,l426h-L426
        dc.w l426i-L426,0
**************************
        move.l (a6)+,-(sp)
l426a:  jsr L_charlen.l
        move.l (sp)+,d3
        move.l (a6)+,d0
        tst.l d0
        beq.s l426y
        move.l a1,-(sp)
        move.l d0,-(sp)
        cmp.l #15,d3
        bne.s cp1
        tst mnd+14(a5)
        bne.s l426z
cp1:    move.l d3,-(sp)
l426b:  jsr L_adbank.l
        beq.s cp2
l426c:  jsr L_effbank.l         ;va effacer!
l426d:  jsr L_resbis.l
cp2:    move.l 4(sp),d3     ;longueur
l426e:  jsr L_malloc.l
        move #$84,d1        ;flag CARACTERE
        move.l (sp),d2      ;numero de la banque demandee
l426f:  jsr L_reservin.l        ;va reserver!
        move.l (sp)+,d3
l426g:  jsr L_adbank.l          ;va chercher l'adresse de la banque
        move.l a1,a3        ;destination
        move.l (sp)+,d3     ;longueur
        move.l (sp)+,a2     ;adresse du jeu a copier
l426h:  jsr L_transmem.l        ;recopie!
l426i:  jsr L_resbis.l          ;remet tout normalement!!!
        rts
l426y:  moveq #E_character_set,d0
        bra.s l426w
l426z:  moveq #E_bank15_menu,d0
l426w:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       WINDOPEN 5
L427:   dc.w l427a-L427,0
**************************
        moveq #1,d2
        moveq #0,d1
        move.w mode(a5),d1
        addq.l #1,d1
l427a:  jmp L_windopen8.l

*************************************************************************
*       WINDOPEN 6
L428:   dc.w l428a-L428,0
***********************
        move.l (a6)+,d2
        moveq #0,d1
        move.w mode(a5),d1
        addq.l #1,d1
l428a:  jmp L_windopen8.l

*************************************************************************
*       WINDOPEN 7
L429:   dc.w l429a-L429,0
***********************
        move.l (a6)+,d1
        move.l (a6)+,d2
l429a:  jmp L_windopen8.l

*************************************************************************
*       WINDOPEN !
L430:   dc.w l430a-L430,0
***********************
        move.l (a6)+,d3
        move.l (a6)+,d4
        move.l (a6)+,d5
        move.l (a6)+,d6
        move.l (a6)+,d7
        move.l d7,d0
        beq.s l430x
        cmp.l #16,d0
        bcc.s l430y
        cmp.l #14,d0
        bcc.s l430x
        swap d1
        cmp.l #16,d2
        bhi.s l430y
        move.w d2,d1
        swap d1
        exg d3,d6
        exg d4,d5
        movem.l d3-d6,-(sp)
        movem.l (sp)+,d2-d5
        move valpen(a5),d6
        swap d6
        move valpaper(a5),d6    ;paper actuel
        moveq #W_initwind,d7
        trap #3             ;init window
l430a:  jmp L_winderr.l
l430x:  moveq #E_system_window,d0
        bra.s l430z
l430y:  moveq #E_illegalfunc,d0
l430z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       erreurs fenetres
L431:   dc.w 0
***********************
        tst.w d0
        bne.s wr
        rts
wr:     cmp #7,d0
        bhi.s wr1
        addi.w #E_window_param-1,d0
        bra.s wr2
wr1:    moveq #E_illegalfunc,d0
wr2:    move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       WINDOW xx[,yy,zz...]: active des fenetres
L432:   dc.w l432a-L432,0
***********************
        move.l buffer(a5),a0
        subq.w #1,d0
ww:     move.l (a6)+,d1
        cmp.l #16,d1
        bcc.s l432y
        cmp.l #14,d1
        bcc.s l432y
        move.w d1,(a0)+
        dbra d0,ww
        move.w #-1,(a0)
        move.l buffer(a5),a0
        moveq #W_actcache,d7
        trap #3
l432a:  jmp L_winderr.l
l432x:  moveq #E_system_window,d0
        bra.s l432z
l432y:  moveq #E_illegalfunc,d0
l432z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       QWINDOW: activation rapide de fenetres
L433:   dc.w l433a-L433,0
***********************
        move.l (a6)+,d0
        cmp.l #16,d0
        bcc.s l433y
        cmp.l #14,d0
        bcc.s l433x
        moveq #W_qwindon,d7
        trap #3
l433a:  jmp L_winderr.l
l433x:  moveq #E_system_window,d0
        bra.s l433z
l433y:  moveq #E_illegalfunc,d0
l433z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       WINDON: RAMENE LA FENETRE ACTIVEE
L434:   dc.w 0
***********************
        moveq #W_getcurwindow,d7
        trap #3
        clr.l d3
        move d0,d3
        move.l d3,-(a6)
        rts

*************************************************************************
*       WINDMOVE XX,YY: BOUGE LA FENETRE COURANTE
L435:   dc.w l435a-L435,0
**************************
        move.l (a6)+,d1
        move.l (a6)+,d2
        tst.l d1
        bmi.s l435z
        tst.l d2
        bmi.s l435z
        move d2,d0
        moveq #W_windmove,d7        ;function #24: move window
        trap #3
l435a:  jmp L_winderr.l
l435z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       WINDEL xx: detruit une fenetre
L436:   dc.w l436a-L436,0
***********************
        move.l (a6)+,d3
        tst.l d3
        beq.s l436x
        cmp.l #16,d3
        bcc.s l436y
        cmp.l #14,d3
        bcc.s l436x
        moveq #W_delwindow,d7
        move.l d3,d0
        trap #3
l436a:  jmp L_winderr.l
l436x:  moveq #E_system_window,d0
        bra.s l436z
l436y:  moveq #E_illegalfunc,d0
l436z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       LOCATE x,y
L437:   dc.w 0
***********************
        moveq #W_locate,d7
        move.l (a6)+,d1
        bmi.s l437z
        move.l (a6)+,d0
        bmi.s l437z
        trap #3
        tst.w d0
        bne.s l437z
        rts
l437z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CURS X
L438:   dc.w 0
***********************
        moveq #W_coordcurs,d7
        trap #3
        clr.w d0
        swap d0
        move.l d0,-(a6)
        rts

*************************************************************************
*       CURS Y
L439:   dc.w 0
***********************
        moveq #W_coordcurs,d7
        trap #3
        clr.l d3
        move d0,d3
        move.l d3,-(a6)
        rts

*************************************************************************
*       XTEXT (xx): CONVERTION GRAPHIQUE ---> TEXTE X
L440:   dc.w 0
***********************
        move.l (a6)+,d0
        moveq #W_xtext,d7
        trap #3
        move.l d0,-(a6)
        rts

*************************************************************************
*       YTEXT (yy): CONVERTION GRAPHIQUE ---> TEXTE Y
L441:   dc.w 0
***********************
        moveq #W_ytext,d7
        move.l (a6)+,d0
        trap #3
        move.l d0,-(a6)
        rts

*************************************************************************
*       XGRAPHIC (xx): CONVERTION TEXTE X ---> GRAPHIQUE
L442:   dc.w 0
***********************
        moveq #W_xgraphic,d7
        move.l (a6)+,d0
        trap #3
        move.l d0,-(a6)
        rts

*************************************************************************
*       YGRAPHIC (yy): CONVERSION TEXTE Y ---> GRAPHIQUE
L443:   dc.w 0
***********************
        moveq #W_ygraphic,d7
        move.l (a6)+,d0
        trap #3
        move.l d0,-(a6)
        rts

*************************************************************************
*       DIVX: diviseur en X selon le mode
L444:   dc.w 0
***********************
        tst mode(a5)
        beq.s divx
        move.l #$1,-(a6)
        rts
divx:   move.l #$2,-(a6)
        rts

*************************************************************************
*       DIVY: diviseur en Y selon le mode
L445:   dc.w 0
***********************
        cmp #2,mode(a5)
        bne.s divy
        move.l #$1,-(a6)
        rts
divy:   move.l #$2,-(a6)
        rts

*************************************************************************
*       SCREEN (xx,yy)
L446:   dc.w 0
***********************
        move.l (a6)+,d1
        bmi.s l446z
        move.l (a6)+,d0
        bmi.s l446z
        moveq #W_tstscreen,d7
        trap #3
        tst d0
        bmi.s l446z
        andi.l #$ff,d0
        move.l d0,-(a6)
        rts
l446z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       PAPER xx
L447:   dc.w 0
***********************
        move.l (a6)+,d0
        cmp.l colmax(a5),d0
        bcc.s l447z
        move d0,valpaper(a5)
        moveq #W_setpaper,d7
        trap #3
        rts
l447z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       PEN xx
L448:   dc.w 0
***********************
        move.l (a6)+,d0
        cmp.l colmax(a5),d0
        bcc.s l448z
        move d0,valpen(a5)
        moveq #W_setpen,d7
        trap #3
        rts
l448z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CUP
L449:   dc.w 0
***********************
        moveq #11,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       CDOWN
L450:   dc.w 0
***********************
        moveq #10,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       CLEFT
L451:   dc.w 0
***********************
        moveq #3,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       CRIGHT
L452:   dc.w 0
***********************
        moveq #9,d0
        move.w #W_chrout,d7
        trap #3
        rts


*************************************************************************
*       SCROLL off
L453:   dc.w 0
***********************
        moveq #25,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       scroll ON
L454:   dc.w 0
***********************
        moveq #23,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       SCROLL DOWN
L455:   dc.w 0
***********************
        moveq #5,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       SCROLL UP
L456:   dc.w 0
***********************
        moveq #4,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       HOME
L457:   dc.w 0
***********************
        moveq #30,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       CLW
L458:   dc.w 0
***********************
        moveq #12,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       SQUARE tx,ty,border
L459:   dc.w 0
***********************
        move.l (a6)+,d0
        beq.s l459z
        move.l (a6)+,d2
        move.l (a6)+,d1
        cmp.l #16,d0
        bcc.s l459z
        cmp.l #3,d1
        bcs.s l459z
        cmp.l #80,d1
        bcc.s l459z
        cmp.l #3,d2
        bcs.s l459z
        cmp.l #80,d2
        bcc.s l459z
        moveq #W_box,d7
        trap #3
        rts
l459z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CLS -seul
L460:   dc.w l460a-L460,0
***********************
l460a:  jmp L_modebis.l

*************************************************************************
*       CLS ecran
L461:   dc.w l461a-L461,0
***********************
l461a:  jsr L_adscreen.l
        move.l d3,a0
        moveq #0,d3
        moveq #0,d5
        moveq #S_cls,d0
        trap #5
        rts

*************************************************************************
*       CLS screen,color
L462:   dc.w l462a-L462,0
***********************
        move.l (a6)+,-(sp)
l462a:  jsr L_adscreen.l
        move.l d3,a0
        move.l (sp)+,d5
        cmp.l colmax(a5),d5
        bcc.s l462z
        moveq #0,d3
        moveq #S_cls,d0
        trap #5
        rts
l462z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CLS screen,color,x,y to x,y
L463:   dc.w l463a-L463,0
***********************
        move.l (a6)+,d4
        move.l (a6)+,d3
        move.l (a6)+,d2
        move.l (a6)+,d1
        andi.w #$fff0,d1
        andi.w #$fff0,d3
        cmp.l xmax(a5),d1
        bcc.s l463z
        cmp.l ymax(a5),d2
        bcc.s l463z
        cmp.l xmax(a5),d3
        bhi.s l463z
        cmp.l ymax(a5),d4
        bhi.s l463z
        sub.l d1,d3
        bcs.s l463z
        beq.s l463z
        sub.l d2,d4
        bcs.s l463z
        beq.s l463z
        move.l (a6)+,d5
        cmp.l colmax(a5),d5
        bcc.s l463z
        movem.w d1-d5,-(sp)
l463a:  jsr L_adscreen.l
        move.l d3,a0
        movem.w (sp)+,d1-d5
        moveq #S_cls,d0
        trap #5
        rts
l463z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       INVERSE OFF
L464:   dc.w 0
***********************
        moveq #18,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       INVERSE ON
L465:   dc.w 0
***********************
        moveq #21,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       SHADE OFF
L466:   dc.w 0
***********************
        moveq #19,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       SHADE ON
L467:   dc.w 0
***********************
        moveq #22,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       UNDERLINE OFF
L468:   dc.w 0
***********************
        moveq #29,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       UNDERLINE ON
L469:   dc.w 0
***********************
        moveq #31,d0
        move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       WRITING 1-3
L470:   dc.w 0
***********************
        move.l (a6)+,d0
        tst.l d0
        beq.s l470z
        cmp.l #4,d0
        bcc.s l470z
        addi.w #13,d0
        moveq #W_chrout,d7
        trap #3
        rts
l470z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CENTER a$: affiche une chaine CENTREE dans la fenetre courante
L471:   dc.w l471a-L471,0
***********************
l471a:  jsr L_chverbuf.l
        tst.w d2
        beq.s l471z
        cmp.l #80,d2
        bcc.s l471z
        moveq #W_centre,d7
        move.l buffer(a5),a0
        trap #3
        rts
l471z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       TITLE a$: affiche une chaine CENTREE dans le HAUT DE LA FENETRE
L472:   dc.w l472a-L472,0
***********************
l472a:  jsr L_chverbuf.l
        tst.w d2
        beq.s l472z
        cmp.l #80,d2
        bcc.s l472z
        moveq #W_title,d7
        move.l buffer(a5),a0
        trap #3
        tst.w d0
        bne.s l472z
        rts
l472z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       BORDER
L473:   dc.w 0
***********************
        moveq #0,d0
        moveq #W_border,d7
        trap #3
        tst.w d0
        bne.s l473z
        rts
l473z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       BORDER xx
L474:   dc.w 0
***********************
        move.l (a6)+,d0
        cmp.l #17,d0
        bcc.s l474z
        moveq #W_border,d7
        trap #3
        tst d0
        bne.s l474z
        rts
l474z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       HARDCOPY
L475:   dc.w 0
***********************
        move.w #20,-(sp)
        trap #14
        addq.l #2,sp
        rts

*************************************************************************
*       WINDCOPY
L476:   dc.w 0
***********************
        move #W_hardcopy,d7
        trap #3
        tst d0
        bne.s l476z
        rts
l476z:  moveq #E_printer,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SETDTA
L477:   dc.w 0
***********************
        move.l dta(a5),-(sp)
        move.w #$1a,-(sp)
        trap #1
        addq.l #6,sp
        rts

*************************************************************************
*       SFIRST: CHERCHE UN NOM SUR LE DISQUE (A0) POINTE LE NOM
L478:   dc.w 0
***********************
        move.w d0,-(sp)
        move.l a0,-(sp)
        move.w #$4e,-(sp)
        trap #1
        addq.l #8,sp
        move.l dta(a5),a0
        add.w #30,a0
        tst d0
        rts

*************************************************************************
*       SNEXT
L479:   dc.w 0
***********************
        move.w #$4f,-(sp)
        trap #1
        addq.l #2,sp
        move.l dta(a5),a0
        add #30,a0          ;pointe le nom du fichier
        tst d0
        rts

*************************************************************************
*       CREATE: CREE UN FICHIER SUR LA DISQUETTE
L480:   dc.w 0
***********************
        move.w d0,-(sp)
        move.l a0,-(sp)
        move.w #$3c,-(sp)
        trap #1
        addq.l #8,sp
        tst d0
        rts

*************************************************************************
*       OPEN: OUVRE UN FICHIER DEJA CREE
L481:   dc.w 0
***********************
        move.w d0,-(sp)
        move.l a0,-(sp)
        move.w #$3d,-(sp)
        trap #1
        addq.l #8,sp
        tst d0
        rts

*************************************************************************
*       WRITE: ECRIS LES DONNEES POINTEES PAR A0 LONG D0, EN HANDLE D7
L482:   dc.w 0
***********************
        move.l d1,-(sp)
        move.l a0,-(sp)
        move.l d0,-(sp)
        move.w handle(a5),-(sp)
        move.w #$40,-(sp)
        trap #1
        addq.l #4,sp
        move.l (sp)+,d1
        addq.l #4,sp
        tst.l d0
        bmi.s l482z
        cmp.l d0,d1
        beq.s l482z
        moveq #-39,d0
l482z:  move.l (sp)+,d1     ;recupere D1
        tst.l d0
        rts

*************************************************************************
*       READ: LIS LES DONNEES DANS UN TAMPON (A0) LONG D0
L483:   dc.w 0
***********************
        move.l a0,-(sp)
        move.l d0,-(sp)
        move.w handle(a5),-(sp)
        move.w #$3f,-(sp)
        trap #1
        lea 12(sp),sp
        tst.l d0
        rts

*************************************************************************
*       NAMEDISK: RETOUR 1 SI IL Y A UNE EXTENSION
L484:   dc.w 0
***********************
        move.l (a6)+,a2
        move.w (a2)+,d2
        beq.s l484x
        cmp #63,d2
        bcc.s l484y
        subq #1,d2
        move d2,d1
        move.l name1(a5),a1
nd1:    move.b (a2)+,(a1)+
        dbra d2,nd1
        clr.b (a1)
        move.l a1,a0
nd2:    cmp.b #".",-(a0)
        beq.s nd5
        cmp.b #"\",(a0)
        beq.s nd3
        dbra d1,nd2
nd3:    move.l a1,a0
        clr.l d0
        rts
nd5:    addq.l #1,a0
        moveq #1,d0
        rts
l484x:  moveq #E_badfilename,d0
        bra.s l484z
l484y:  moveq #E_illegalfunc,d0
l484z:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       DISK ERR
L485:   dc.w 0
***********************
        cmp #-33,d0
        beq.s dk1
        cmp #-39,d0
        beq.s dk2
        cmp #-2,d0
        beq.s dk3
        cmp #-13,d0
        beq.s dk4
dk:     moveq #E_diskerror,d0
        bra.s dk5
dk1:    moveq #E_noent,d0
        bra.s dk5
dk2:    moveq #E_nospace,d0
        bra.s dk5
dk3:    moveq #E_drive_not_ready,d0
        bra.s dk5
dk4:    moveq #E_wrpro,d0
dk5:    move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       OUVREBNK
L486:   dc.w l486a-L486,l486b-L486,l486c-L486,l486d-L486,0
***********************************************************
        lea cbk(pc),a1
        move.l a0,-(sp)
        clr.l d0
l486a:  jsr L_sfirst.l
        bne.s l486y
        move.l dta(a5),a0
        move.l 26(a0),d6
        move.l (sp)+,a0
        moveq #0,d0
l486b:  jsr L_open.l
        bmi.s l486d
        move d0,handle(a5)
        moveq.l #10,d0       ;lis le codage du fichier
        move.l buffer(a5),a0
l486c:  jsr L_readdisk.l
        bmi.s l486d
        move.l buffer(a5),a0
        move #9,d0
ouvre2: move.b (a0)+,d1
        cmp.b (a1)+,d1
        bne.s nofo
        dbra d0,ouvre2
        subi.l #10,d6        ;ramene la longueur du fichier en D6
        clr d0
        rts
l486d:  jmp L_diskerr.l
nofo:   moveq #E_badformat,d0
        bra.s l486v
l486y:  moveq #E_noent,d0
        bra.s l486v
l486z:  moveq #E_noent,d0
l486v:  move.l error(a5),a0
        jmp (a0)
cbk:    dc.b "Lionpoubnk"

*************************************************************************
*       DISKNOM: teste l'extension: ;1=IMG, 2=PI0, 3=PI1, 4=PI2
L487:   dc.w 0
***********************
        lea nomdisk(pc),a2
        moveq #1,d0
npic1:  moveq #2,d1
        move.l a0,a1
npic2:  move.b (a1)+,d2
        cmp.b #"A",d2
        bcs.s npic2a
        cmp.b #"Z",d2
        bhi.s npic2a
        addi.b #$20,d2
npic2a: cmp.b (a2)+,d2
        bne.s npic3
        dbra d1,npic2
        rts                 ;trouvee!
npic3:  tst.b (a2)+
        bne.s npic3
        addq #1,d0
        cmp #10,d0
        bne.s npic1
        clr.l d0            ;pas trouvee!
        rts
; NOMS DE RECONNAISSANCE DES FICHIERS
nomdisk:dc.b "neo",0,"pi1",0,"pi2",0,"pi3",0
        dc.b "mbk",0,"mbs",0,"prg",0,"var",0,"asc",0

*************************************************************************
*       LOAD
L488:   dc.w l488a-L488,l488b-L488,l488c-L488
        dc.w ldpic-L488,ldmbk-L488,ldmbs-L488,ldprg-L488,0
*********************************************************************
        move.w d0,d7
        cmp.w #1,d0
        beq.s l4881
        cmp.w #2,d0
        beq.s l4880
        cmp.w #3,d0
        bne.s l488s
        move.l (a6)+,d5
l4880:  move.l (a6)+,d6
l4881:  movem.l d5/d6/d7,-(sp)
l488a:  jsr L_setdta.l
l488b:  jsr L_namedisk.l
        beq.s pald
l488c:  jsr L_diskname.l
        movem.l (sp)+,d5/d6/d7
        tst d0
        beq.s pald
        cmp #4,d0
        bls.s ldpic
        cmp #5,d0
        beq.s ldmbk
        cmp #6,d0
        beq.s ldmbs
        cmp #7,d0
        beq.s ldprg
pald:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)
ldpic:  jmp L_loadpic.l
ldmbk:  jmp L_loadbank.l
ldmbs:  jmp L_loadall.l
ldprg:  jmp L_loadprg.l
l488s:  moveq #E_syntax,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       LOAD "xx.NEO/.PI1/.PI2/.PI3"[,adecran[,0]]: SCREEN LOAD
L489:   dc.w l489a-L489,l489b-L489,l489c-L489,l489d-L489
        dc.w l489e-L489,l489f-L489,l489g-L489,l489h-L489
        dc.w l489i-L489,l489j-L489,l489z-L489,0
***********************
        move.l adback(a5),a0
        clr d1
        cmp.w #1,d7
        beq.s picop
        cmp.w #2,d7
        beq.s pic1
        cmp.w #3,d7
        bne l489s
        move.l d5,d1
pic1:   movem.w d0-d1,-(sp)
        move.l d6,-(a6)
l489a:  jsr L_adscreen.l
        move.l d3,a0
        movem.w (sp)+,d0-d1
; ouvre le fichier
picop:  movem.l d0-d1/a0,-(sp)
        moveq #0,d0
        move.l name1(a5),a0
l489b:  jsr L_open.l
        bmi l489z
        move d0,handle(a5)
        movem.l (sp)+,d4-d5/a3
        cmp #1,d4
        bne.s picdeg
; IMAGE AU FORMAT NEO!!!
        move.l a3,a0
        lea 32000-4(a0),a0
        move.l #128,d0      ;lis tout d'un coup: 4oct, palette, et caca
l489c:  jsr L_readdisk.l
        bmi l489z
        move.l a3,a0
        move.l #32000,d0    ;lis l'image
l489d:  jsr L_readdisk.l
        bmi.s l489z
        bra pokpal          ;va poker la palette
; IMAGE AU FORMAT DEGAS
picdeg: move.l buffer(a5),a0
        moveq #2,d0         ;saute le mode
l489e:  jsr L_readdisk.l
        bmi.s l489z
        move.l a3,a0
        lea 32000(a0),a0
        moveq #32,d0        ;lis la palette
l489f:  jsr L_readdisk.l
        bmi.s l489z
        move.l a3,a0
        move.l #32000,d0    ;lis l'image
l489g:  jsr L_readdisk.l
        bmi.s l489z
; POKE LA PALETTE ET FAIT APPARAITRE L'ECRAN (OU NON)
pokpal:
l489h:  jsr L_closys.l
        cmp.l adback(a5),a3
        bne.s plf
        tst d5              ;ET 0 a la fin
        bne.s plf
        lea 32000(a3),a3     ;copie la palette du BACK ---> LOGIC
        moveq #15,d0
        move.l adlogic(a5),a0
        lea 32000(a0),a0
pkp:    move.w (a3)+,(a0)+
        dbra d0,pkp
l489i:  jsr L_palette3.l             ;envoie la palette au XBIOS
l489j:  jsr L_waitvbl.l         ;attend le balayage
        moveq #S_backtoscreen,d0
        trap #5             ;DEC TO EC
        moveq #S_drawsprites,d0
        trap #5             ;SPREAFF
plf:    rts
l489z:  jmp L_diskerr.l
l489s:  moveq #E_syntax,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       LOAD "AAAAAAAA.MBK"[,xx]: load a memory bank
L490:   dc.w l490a-L490,l490b-L490,l490c-L490,l490d-L490
        dc.w l490z-L490,0
**************************
        movem.l d6/d7,-(sp)
        move.l name1(a5),a0
l490a:  jsr L_openbank.l                 ;ouvre le fichier, cherche le codage
        move.l buffer(a5),a0
        moveq #4,d0
l490b:  jsr L_readdisk.l
        bmi.s l490z
        move.l buffer(a5),a0
        tst.l (a0)
        beq.s l490y
; charge UNE banque memoire
        lea 4(a0),a0
        moveq #4,d0
l490c:  jsr L_readdisk.l
        bmi.s l490z
        movem.l (sp)+,d6/d7
        cmp.w #1,d7
        beq.s l490d
        cmp.w #2,d7
        bne.s l490s
        move.l buffer(a5),a0
        move.l d6,(a0)
l490d:  jmp L_loadinput.l
l490x:  moveq #E_illegalfunc,d0
        bra.s l490e
l490y:  moveq #E_badformat,d0
        bra.s l490e
l490z:  jmp L_diskerr.l
l490s:  moveq #E_syntax,d0
l490e:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       LOAD "AAAAAAAA.MBS": load all memory banks!
L491:   dc.w l491a-L491,l491b-L491,l491c-L491,l491d-L491
        dc.w l491e-L491,l491f-L491,l491g-L491,l491h-L491
        dc.w l491i-L491,l491j-L491,l491k-L491,l491z-L491,0
**********************************************
        cmp.w #1,d7
        bne l491w
        move.l name1(a5),a0
l491a:  jsr L_openbank.l
        move.l buffer(a5),a0
        moveq #4,d0
l491b:  jsr L_readdisk.l
        bmi l491z
        move.l buffer(a5),a0
        tst.l (a0)
        bne l491x
        tst mnd+14(a5)
        bne l491y
        move.l buffer(a5),a0
        moveq #4,d0
l491c:  jsr L_readdisk.l
        bmi l491z
        move.l buffer(a5),a0
        move.l (a0),-(sp)
        move.l topmem(a5),d0
        sub.l himem(a5),d0
        move.l (sp),d3
        addi.l #64,d3
        cmp.l d0,d3
        bls.s lmbk11
        sub.l d0,d3
l491d:  jsr L_malloc.l
lmbk11:
l491e:  jsr L_stopall.l
        lea unewbank(a5),a1
        move.l adatabank(a5),a0
        addq.l #4,a0
        move.l a0,a2
        moveq #14,d0
lmbk12: move.l (a2)+,(a1)+
        dbra d0,lmbk12
        moveq #15*4,d0
l491f:  jsr L_readdisk.l         ;copie les banques
        bmi.s l491z
        move.l topmem(a5),a3
        sub.l (sp),a3
        move.l lowvar(a5),a2    ;depart des variables
        move.l himem(a5),d3
        sub.l a2,d3         ;taille des variables
        sub.l d3,a3         ;arrivee des variables
        move.l a3,lowvar(a5)    ;nouveau lowvar
l491g:  jsr L_transmem.l        ;bouge les variables
        move.l a3,himem(a5)     ;nouveau himem= arrivee des banques
        move.l a3,a0
        move.l (sp)+,d0
l491h:  jsr L_readdisk.l
        bmi.s errbk2
l491i:  jsr L_closys.l
l491j:  jmp L_resbis.l
; ERREUR EN COURS DE CHARGEMENT DE BANQUES! kADASDROPHE!
errbank:lea unewbank(a5),a0
        move.l adatabank(a5),a1
        addq.l #4,a0
        moveq #14,d1
errbk1: move.l (a0)+,(a1)+            ;remet les banques comme avant!
        dbra d1,errbk1
errbk2: move.l d0,-(sp)
l491k:  jsr L_resbis.l
        move.l (sp)+,d0
l491z:  jmp L_diskerr.l
l491w:  moveq #E_syntax,d0
        bra.s l491q
l491x:  moveq #E_badformat,d0
        bra.s l491q
l491y:  moveq #E_bank15_menu,d0
l491q:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       LOAD "AAAAAAAA.PRG",# bank: load a PROGRAM
L492:   dc.w l492a-L492,l492b-L492,l492c-L492,l492d-L492
        dc.w l492z-L492,0
**************************
        cmp.w #2,d7
        bne l492s
        move.l d6,-(sp)
        clr.l d0
        move.l name1(a5),a0
l492a:  jsr L_sfirst.l
        bne l492t
        clr.l d0
        move.l name1(a5),a0
l492b:  jsr L_open.l                 ;ouvre le fichier
        bmi.s l492z
        move d0,handle(a5)
        move.l buffer(a5),a0
        move.l (sp),(a0)
        move.l dta(a5),a1
        move.l 26(a1),d0         ;taille du fichier
        andi.l #$ffffff,d0
        ori.l #$81000000,d0       ;pour le moment: flag DATA
        move.l d0,4(a0)
l492c:  jsr L_loadinput.l                  ;verifie/reserve/charge: GENIAL!
        move.l (sp)+,d3
l492d:  jsr L_adbank.l               ;adresse de la banque
        beq.s l492t
        andi.l #$ffffff,d0
        ori.l #$83000000,d0
        move.l d0,(a0)           ;change le flag maintenant
; loge pour la premiere fois le programme
        move.l a1,16(a1)         ;16 (start)---> ancienne adresse
        move.l 2(a1),d0          ;distance a la table
        add.l 6(a1),d0
        andi.l #$ffffff,d0
        add #$1c,a1              ;pointe le debut du programme
        move.l a1,a2
        move.l a2,d2             ;d2= debut du programme
        add.l d0,a1
        tst.l (a1)               ;si nul: pas de relocation!
        beq.s lprg3
        add.l (a1)+,a2           ;pointe la table de relocation!
        clr.l d0
        bra.s lprg1
lprg0:  move.b (a1)+,d0
        beq.s lprg3
        cmp.b #1,d0
        beq.s lprg2
        add d0,a2                ;pointe dans le programme
lprg1:  add.l d2,(a2)            ;change dans le programme
        bra.s lprg0
lprg2:  add #254,a2
        bra.s lprg0
lprg3:  rts
l492z:  jmp L_diskerr.l
l492s:  moveq #E_syntax,d0
        bra.s l492y
l492t:  moveq #E_noent,d0
l492y:  move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       input to load a .PRG
L493:   dc.w l493a-L493,l493b-L493,l493c-L493,l493d-L493
        dc.w l493e-L493,l493f-L493,l493g-L493,l493h-L493
        dc.w l493z-L493,0
**************************
        move.l buffer(a5),a2
        move.l (a2),d3
l493a:  jsr L_adbank.l
        cmp #15,d3
        bne lmbk0
        tst mnd+14(a5)
        bne.s l493y
lmbk0:  andi.l #$ffffff,d0             ;taille ACTUELLE de la banque
        move.l 4(a2),d3
        andi.l #$ffffff,d3             ;taille de la banque a charger
        addi.l #64,d3                  ;plus 64 octets de secu
        cmp.l d0,d3
        bls.s lmbk1
        sub.l d0,d3
l493b:  jsr L_malloc.l
lmbk1:  move.l (a2),d3
l493c:  jsr L_effbank.l                   ;va effacer la banque
        move.l buffer(a5),a2
        move.l 4(a2),d1
        move.l d1,d3
        andi.l #$ffffff,d3             ;longueur a reserver
        move.l d3,-(sp)
        rol.l #8,d1
        andi.l #$ff,d1                 ;flag
        move.l (a2),d2              ;numero de la banque
        move.l d2,-(sp)
l493d:  jsr L_reservin.l                  ;va reserver la memoire
        move.l (sp)+,d3
l493e:  jsr L_adbank.l                    ;adresse ou charger
        move.l a1,a0
        move.l (sp)+,d0               ;longueur a charger
l493f:  jsr L_readdisk.l
        bmi.s l493z
l493g:  jsr L_closys.l
l493h:  jmp L_resbis.l                    ;va tout changer dans le programme
l493z:  jmp L_diskerr.l
l493y:  moveq #E_bank15_menu,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       BLOAD "AAAAAAAA.BBB",$depart: load a block of bytes
L494:   dc.w l494a-L494,l494b-L494,l494c-L494
        dc.w l494d-L494,l494e-L494,l494f-L494,l494g-L494
        dc.w l494z-L494,0
**************************
l494a:  jsr L_setdta.l
l494b:  jsr L_addrofbank.l
        move.l d3,-(sp)
l494c:  jsr L_namedisk.l
        clr.l d0
        move.l name1(a5),a0
l494d:  jsr L_sfirst.l          ;ramene la taille du fichier---> dta
        bne.s l494t
        clr.l d0
        move.l name1(a5),a0
l494e:  jsr L_open.l            ;ouvre le fichier
        bmi.s l494z
        move d0,handle(a5)
        move.l (sp)+,a0
        move.l dta(a5),a1
        move.l 26(a1),d0    ;taille du fichier
l494f:  jsr L_readdisk.l         ;charge
        bmi.s l494z
l494g:  jsr L_closys.l
        rts
l494t:  moveq #E_noent,d0
        move.l error(a5),a0
        jmp (a0)
l494z:  jmp L_diskerr.l

*************************************************************************
*       BSAVE "AAAAAAAA.BIN",$depart TO $fin
L495:   dc.w l495a-L495,l495b-L495,l495c-L495
        dc.w l495d-L495,l495e-L495,l495f-L495,l495g-L495
        dc.w l495z-L495,0
**************************
l495a:  jsr L_setdta.l
l495b:  jsr L_addrofbank.l
        move.l d3,-(sp)
l495c:  jsr L_addrofbank.l
        move.l (sp),d0
        move.l d3,(sp)
        move.l d0,-(sp)
l495d:  jsr L_namedisk.l
        clr.l d0
        move.l name1(a5),a0
l495e:  jsr L_create.l
        bmi.s l495z
        move d0,handle(a5)
        move.l (sp)+,d0
        move.l (sp)+,a0     ;debut a sauver
        sub.l a0,d0         ;taille a sauver
l495f:  jsr L_write.l
        bmi.s l495z
l495g:  jsr L_closys.l
        rts
l495z:  jmp L_diskerr.l

*************************************************************************
*       SAVE
L496:   dc.w l496a-L496,l496b-L496,l496c-L496
        dc.w svpic-L496,svmbk-L496,svmbs-L496,0
*********************************************************************
        move.w d0,d7
        cmp.w #1,d0
        beq.s l4961
        cmp.w #2,d0
        beq.s l4960
        cmp.w #3,d0
        bne.s l496s
        move.l (a6)+,d5
l4960:  move.l (a6)+,d6
l4961:  movem.l d5/d6/d7,-(sp)
l496a:  jsr L_setdta.l
l496b:  jsr L_namedisk.l
        beq.s pasv
l496c:  jsr L_diskname.l
        movem.l (sp)+,d5/d6/d7
        tst d0
        beq.s pasv
        cmp #4,d0
        bls.s svpic
        cmp #5,d0
        beq.s svmbk
        cmp #6,d0
        beq.s svmbs
pasv:   moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)
svpic:  jmp L_savepic.l
svmbk:  jmp L_savebank.l
svmbs:  jmp L_saveall.l
l496s:  moveq #E_syntax,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SAVE "aa.NEO/.PI1/.PI2/.PI3"[,adecran]: SCREEN SAVE
L497:   dc.w l497a-L497,l497b-L497,l497c-L497,l497d-L497
        dc.w l497e-L497,l497f-L497,l497g-L497,l497h-L497
        dc.w l497i-L497,l497j-L497
        dc.w l497y-L497,l497z-L497,0
*************************************
        move.l adback(a5),d3    ;par defaut: adresse du decor
        cmp.w #1,d7
        beq.s pics1
        cmp.w #2,d7
        bne l497s
        move.w d0,-(sp)
        move.l d6,-(a6)
l497a:  jsr L_adscreen.l
        move.w (sp)+,d0
pics1:  move d0,d4          ;ouvre le fichier sur la disquette
        clr d0
        move.l name1(a5),a0
l497b:  jsr L_create.l
        bmi l497z
        move d0,handle(a5)
        cmp #1,d4
        bne.s pics5
; Sauve une image au format NEO
        move.l defloat(a5),a0
        moveq #31,d0
pics2:  clr.l (a0)+
        dbra d0,pics2
        move.l defloat(a5),a0
        moveq #4,d0         ; quatre octets inutiles!
l497c:  jsr L_write.l
        bmi.s l497z
        move.l d3,a0        ; palette
        lea 32000(a0),a0
        moveq #32,d0
l497d:  jsr L_write.l
        bmi.s l497y
        move.l defloat(a5),a0      ; cacas
        moveq #92,d0
l497e:  jsr L_write.l
        bmi.s l497y
        move.l d3,a0        ; ecran
        move.l #32000,d0
l497f:  jsr L_write.l
        bmi.s l497y
        bra.s pics10
; Sauve une image au format DEGAS
pics5:  lea mode(a5),a0
        moveq #2,d0
l497g:  jsr L_write.l
        bmi.s l497y
        move.l d3,a0
        lea 32000(a0),a0
        moveq #32,d0
l497h:  jsr L_write.l
        bmi.s l497y
        move.l d3,a0
        move.l #32000,d0
l497i:  jsr L_write.l
        bmi.s l497y
; Ferme le fichiers
pics10:
l497j:  jsr L_closys.l
        rts
l497s:  moveq #E_syntax,d0
        move.l error(a5),a0
        jmp (a0)
l497y:  jmp L_varserr.l
l497z:  jmp L_diskerr.l


*************************************************************************
*       SAVE "AAAAAAAA.MBK",xx: sauve UNE banque
L498:   dc.w l498a-L498,l498b-L498,l498c-L498,l498d-L498
        dc.w l498e-L498,l498f-L498,l498y-L498,l498z-L498
        dc.w 0
***********************
        cmp.w #2,d7
        bne.s l498s
        move.l d6,d3
l498a:  jsr L_adbank.l
        beq.s l498t
        movem.l a0-a1,-(sp)
        move.l name1(a5),a0
        clr d0
l498b:  jsr L_create.l                    ;ouvre le fichier
        bmi.s l498z
        move d0,handle(a5)
        lea cbk1(pc),a0
        moveq #10,d0
l498c:  jsr L_write.l
        bmi.s l498y
        movem.l (sp)+,a0-a1
        move.l buffer(a5),a2
        move.l d3,(a2)
        move.l (a0),4(a2)
        move.l a2,a0
        moveq #8,d0
l498d:  jsr L_write.l
        bmi.s l498y
        move.l a1,a0                  ;adresse de la banque
        move.l buffer(a5),a2
        move.l 4(a2),d0
        andi.l #$ffffff,d0             ;taille de la banque
l498e:  jsr L_write.l
        bmi.s l498y
l498f:  jmp L_closys.l                    ;ferme et revient
l498s:  moveq #E_syntax,d0
        bra l498u
l498t:  moveq #E_not_reserved,d0
l498u:  move.l error(a5),a0
        jmp (a0)
l498y:  jmp L_varserr.l
l498z:  jmp L_diskerr.l
cbk1:   dc.b "Lionpoubnk"

*************************************************************************
*       SAVE "AAAAAAAA.MBS": sauve TOUTES les banques
L499:   dc.w l499a-L499,l499b-L499,l499c-L499,l499d-L499
        dc.w l499e-L499,l499f-L499,l499y-L499,l499z-L499
        dc.w 0
***********************
        cmp.w #1,d7
        bne.s l499s
        move.l himem(a5),d0
        cmp.l topmem(a5),d0
        beq.s l499t
        move.l name1(a5),a0          ;va creer le fichier
        clr d0
l499a:  jsr L_create.l
        bmi.s l499z
        move d0,handle(a5)
        lea cbk2(pc),a0             ;ecris le codage
        moveq #10,d0
l499b:  jsr L_write.l
        bmi.s l499y
        move.l buffer(a5),a0      ;zero---> toutes les banques
        clr.l (a0)
        move.l topmem(a5),d0              ;taille totale des banques
        sub.l himem(a5),d0
        move.l d0,4(a0)
        moveq #8,d0
l499c:  jsr L_write.l
        bmi.s l499y
        move.l adatabank(a5),a0
        lea 4(a0),a0
        moveq #15*4,d0
l499d:  jsr L_write.l                     ;puis datazone-banque zero
        bmi.s l499y
        move.l himem(a5),a0               ;debut des banques
        move.l topmem(a5),d0              ;taille des banques
        sub.l a0,d0
l499e:  jsr L_write.l
        bmi.s l499y
l499f:  jmp L_closys.l                ;ferme et revient
l499y:  jmp L_varserr.l
l499z:  jmp L_diskerr.l
l499s:  moveq #E_syntax,d0
        bra.s l499x
l499t:  moveq #E_not_reserved,d0
l499x:  move.l error(a5),a0
        jmp (a0)
cbk2:   dc.b "Lionpoubnk"

*************************************************************************
*       VARSERR
L500:   dc.w l500a-L500,l500b-L500,l500c-L500,0
**********************************************
        move.l d0,-(sp)
l500a:  jsr L_closys.l
        move.l name1(a5),a0
l500b:  jsr L_unlink.l
        move.l (sp)+,d0
l500c:  jmp L_diskerr.l

*************************************************************************
*       UNLINK
L501:   dc.w 0
***********************
        move.l a0,-(sp)
        move.w #$41,-(sp)
        trap #1
        addq.l #6,sp
        tst.w d0
        rts

*************************************************************************
*       GETFILE
L502:   dc.w 0
***********************
        move.l (a6)+,d3
        beq.s l502z
        cmp.l #10,d3
        bhi.s l502z
        subq.w #1,d3
        mulu #tfiche,d3
        move.l fichiers(a5),a2
        add.w d3,a2
        move.w (a2),d0
        rts
l502z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       OPENIN
L503:   dc.w l503a-L503,l503b-L503,l503c-L503,l503d-L503
        dc.w l503e-L503,l503f-L503,l503z-L503,0
************************************************
l503a:  jsr L_setdta.l
l503b:  jsr L_namedisk.l
l503c:  jsr L_getfile.l
        bne.s l503o
l503d:  jsr L_ficlean.l
        move.l a2,-(sp)
        clr d0
        move.l name1(a5),a0
l503e:  jsr L_sfirst.l
        bne.s l503y
        move.l (sp)+,a2
        move.l dta(a5),a0
        move.l 26(a0),fhl(a2)   ;poke sa longueur
        move.l name1(a5),a0
        clr.l d0                ;accessible en lecture uniquement
l503f:  jsr L_open.l
        bmi.s l503z
        move d0,fha(a2)     ;poke le file handle
        move #5,(a2)            ;fichier DISQUE en LECTURE!
        rts
l503o:  moveq #E_file_open,d0
        bra.s l503t
l503y:  moveq #E_noent,d0
l503t:  move.l error(a5),a0
        jmp (a0)
l503z:  jmp L_diskerr.l

*************************************************************************
*       OPENOUT #xx,"aaaaa.eee"[,attribut]
L504:   dc.w l504a-L504,l504b-L504,l504c-L504,l504d-L504
        dc.w l504e-L504,l504z-L504,0
*************************************
        clr.l -(sp)
        tst.w d0
        beq.s l504a
        move.l (a6)+,(sp)
l504a:  jsr L_setdta.l
l504b:  jsr L_namedisk.l
l504c:  jsr L_getfile.l
        bne.s l504o
l504d:  jsr L_ficlean.l         ;va nettoyer la table
        move.l (sp)+,d0
        move.l a2,-(sp)
        cmp.l #4,d0
        bcc.s l504x
        move.l name1(a5),a0
l504e:  jsr L_create.l          ;va le creer
        bmi.s l504z
        move.l (sp)+,a2
        clr.l fhl(a2)      ;longueur nulle!
        move d0,fha(a2)     ;poke le file handle
        move #6,(a2)            ;fichier en ecriture!
        rts
l504x:  moveq #E_illegalfunc,d0
        bra.s l504t
l504o:  moveq #E_file_open,d0
l504t:  move.l error(a5),a0
        jmp (a0)
l504z:  jmp L_diskerr.l

*************************************************************************
*       OPEN #xx,("R", "MID", "AUX", "PRT")
L505:   dc.w l505a-L505,l505b-L505,l505c-L505,l505d-L505
        dc.w l505e-L505,l505f-L505,l505g-L505,l505z-L505
        dc.w 0
***********************
        move.w d0,-(sp)
        beq.s l505b
l505a:  jsr L_namedisk.l

l505b:  jsr L_setdta.l
        move.l (a6)+,-(sp)
l505c:  jsr L_getfile.l
        bne l505op
l505d:  jsr L_ficlean.l
        move.l (sp)+,a0
        tst.w (a0)+
        beq l505fc
        move.b (a0)+,d0
        cmp.b #"a",d0
        bcs.s hop1
        cmp.b #"z",d0
        bhi.s hop1
        subi.b #$20,d0
hop1:   cmp.b #"R",d0
        beq.s hop2
        cmp.b #"P",d0
        beq hop3
        cmp.b #"A",d0
        beq hop4
        cmp.b #"M",d0
        beq hop5
        bne.s l505fc
; OUVRE UN FICHIER A ACCES DIRECT
hop2:   move.w (sp)+,d0
        beq.s l505sy
        clr d0
        move.l name1(a5),a0
l505e:  jsr L_sfirst.l
        beq.s hop1a
; il faut creer le fichier
        move.l name1(a5),a0
        clr.l d0            ;lecture/ecriture
l505f:  jsr L_create.l
        bmi.s l505z
        move.w d0,fha(a2)         ;handle
        move.w #-1,(a2)               ;fichier en acces direct
        rts
; le fichier existe deja
hop1a:  move.l name1(a5),a0
        moveq #2,d0             ;acces en lecture/ecriture
l505g:  jsr L_open.l
        bmi.s l505z
        move d0,fha(a2)           ;poke le file handle
        move.l dta(a5),a0
        move.l 26(a0),fhl(a2)    ;poke la longueur
        move.w #-1,(a2)               ;fichier a access direct
        rts
; OUVRE UN PORT D'ENTREE/SORTIE
hop3:   moveq #1,d0         ;PRT
        bra.s hop6
hop4:   moveq #2,d0         ;AUX= RS 232
        bra.s hop6
hop5:   moveq #4,d0         ;MIDI
hop6:   move.w d0,(a2)      ;poke le type de fichier ET C'EST TOUT!!!!!!!
        move.w (sp)+,d0
        bne.s l505sy
        rts
l505op: moveq #E_file_open,d0
        bra.s l505go
l505sy: moveq #E_syntax,d0
        bra.s l505go
l505fc: moveq #E_illegalfunc,d0
l505go: move.l error(a5),a0
        jmp (a0)
l505z:  jmp L_diskerr.l

*************************************************************************
*       NETTOIE LA TABLE DE DEFINITION DU FICHIER
L506:   dc.w 0
************************
        movem.l d0/a0,-(sp)
        moveq #tfiche-1,d0
        move.l a2,a0
ficl1:  clr.b (a0)+
        dbra d0,ficl1
        movem.l (sp)+,a0/d0
        rts

*************************************************************************
*       PORT
L507:   dc.w l507a-L507,0
**************************
l507a:  jsr L_getfile.l
        beq.s l507no
        bmi.s l507tm
        cmp #1,d0
        beq.s po1
        cmp #2,d0
        beq.s po1
        cmp #4,d0
        beq.s po1
l507tm: moveq #E_file_mismatch,d0
        bra.s l507go
po1:    subq #1,d0
        move.w d0,-(sp)
        move.w #1,-(sp)
        trap #13
        addq.l #2,sp
        tst d0
        bne.s po2
; pas de caractere
        addq.l #2,sp
        move.l #-1,-(a6)
        rts
; caractere
po2:    move.w #2,-(sp)
        trap #13
        addq.l #4,sp
        moveq #0,d3
        move.b d0,d3
        move.l d3,-(a6)
        rts
l507no: moveq #E_notopen,d0
l507go: move.l error(a5),a0
        jmp (a0)


*************************************************************************
*       CLOSE
L508:   dc.w l508a-L508,0
***********************
        move.l fichiers(a5),a2
        moveq #9,d2
l508a:  jmp L_close.l

*************************************************************************
*       CLOSE #xx
L509:   dc.w l509a-L509,l509b-L509,0
***********************
l509a:  jsr L_getfile.l
        beq.s l509z
        clr.w d2
l509b:  jmp L_close.l
l509z:  moveq #E_file_closed,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       CLOSE!
L510:   dc.w cs3-L510,0
*********************************************
cs1:    move.w (a2),d0
        beq.s cs4
        bmi.s cs2
        cmp #5,d0
        beq.s cs2
        cmp #6,d0
        bne.s cs3
cs2:    move.w fha(a2),-(sp)
        move.w #$3e,-(sp)
        trap #1
        addq.l #4,sp
cs3:    jsr L_ficlean.l
cs4:    lea tfiche(a2),a2
        dbra d2,cs1
        rts

*************************************************************************
*       GETBYTE: PREND UN OCTET DANS LE FICHIER (D7 bouzille)
L511:   dc.w l511a-L511,l511b-L511,l511z-L511,0
**********************************************
        move.w (a2),d7
        beq.s l511no
        cmp #5,d7
        beq.s getb4
        subq #1,d7
        cmp #1,d7           ;rs 232
        beq.s getb0
        cmp #3,d7           ;midi
        bne.s l511tm
;prend un byte dans le port RS-232 ou MIDI
getb0:  movem.l d1-d2/a0-a2,-(sp)
getb1:  move.w d7,-(sp)     ;bconstat
        move.w #1,-(sp)
        trap #13
        addq.l #4,sp
        tst d0
        bne.s getb2
l511a:  jsr L_tester.l
        bra.s getb1
getb2:  move.w d7,-(sp)     ;conin
        move.w #2,-(sp)
        trap #13
        addq.l #4,sp
        movem.l (sp)+,d1-d2/a0-a2
        rts
; prend un byte d'un fichier sequentiel sur disque
getb4:  move.l a0,-(sp)
l511b:  jsr L_pfile.l           ;position du pointeur du fichier
        cmp.l fhl(a2),d0
        bcc.s l511eo       ;End Of File me
        pea getb(pc)
        move.l #1,-(sp)
        move.w fha(a2),-(sp)
        move.w #$3f,-(sp)
        trap #1             ;READ
        lea 12(sp),sp
        tst.l d0
        bmi.s l511z
        move.b getb(pc),d0
        move.l (sp)+,a0
        rts
getb:   dc.l 0
l511eo: moveq #E_eof,d0
        bra.s l511go
l511tm: moveq #E_file_mismatch,d0
        bra.s l511go
l511no: moveq #E_notopen,d0
l511go: move.l error(a5),a0
        jmp (a0)
l511z:  jmp L_diskerr.l

*************************************************************************
*       SSPGM: PFILE: ramene la position du pointeur du fichier en D0.L
L512:   dc.w l512z-L512,0
**************************
        move.l a0,-(sp)
        move.w #1,-(sp)
        move.w fha(a2),-(sp)
        clr.l -(sp)         ;Pas de deplacement!
        move.w #$42,-(sp)
        trap #1
        lea 10(sp),sp
        move.l (sp)+,a0
        tst.l d0
        bmi.s l512z
        rts
l512z:  jmp L_diskerr.l

*************************************************************************
*       LOF
L513:   dc.w l513a-L513,0
***********************
l513a:  jsr L_getfile.l
        beq.s l513no
        bmi.s lof1
        cmp #5,d0
        beq.s lof1
        cmp #6,d0
        bne.s l513tm
lof1:   move.l fhl(a2),-(a6)
        rts
l513no: moveq #E_notopen,d0
        bra.s l513go
l513tm: moveq #E_file_mismatch,d0
l513go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FONCTION: EOF(#xx)
L514:   dc.w l514a-L514,l514b-L514,0
***********************
l514a:  jsr L_getfile.l
        beq.s l514no
        bmi.s eof1
        cmp #5,d0
        beq.s eof1
        cmp #6,d0
        bne.s l514tm
eof1:   clr.l -(a6)
l514b:  jsr L_pfile.l           ;va chercher la position
        cmp.l fhl(a2),d0
        bcs.s eof2
        move.l #-1,(a6)
eof2:   rts
l514no: moveq #E_notopen,d0
        bra.s l514no
l514tm: moveq #E_file_mismatch,d0
l514go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FONCTION: POF(#xx): position dans un fichier
L515:   dc.w l515a-L515,pof1-L515,0
***********************
l515a:  jsr L_getfile.l
        beq.s l515no
        bmi.s pof1
        cmp #5,d0
        beq.s pof1
        cmp #6,d0
        bne.s l515tm
pof1:   jsr L_pfile.l
        move.l d0,-(a6)
        rts
l515no: moveq #E_notopen,d0
        bra.s l515go
l515tm: moveq #E_file_mismatch,d0
l515go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       INSTRUCTION POF(#xx)=xxxx: positionne dans un fichier
L516:   dc.w l516a-L516,l516b-L516,0
*************************************
        move.l (a6)+,-(sp)
l516a:  jsr L_getfile.l
        beq.s l516no
        bmi.s pofi1
        cmp #5,d0
        beq.s pofi1
        cmp #6,d0
        bne.s l516tm
pofi1:  move.l (sp)+,d3
        tst.l d3
        bmi.s l516fc
        cmp.l fhl(a2),d3
        bhi.s l516eo
l516b:  jmp L_seekbis.l
l516fc: moveq #E_illegalfunc,d0
        bra.s l516go
l516no: moveq #E_notopen,d0
        bra.s l516go
l516eo: moveq #E_eof,d0
        bra.s l516go
l516tm: moveq #E_file_mismatch,d0
l516go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FIELD #XX,AA AS XX$,...
L517:   dc.w l517a-L517,0
***********************
        move.w d0,-(sp)
        lsl #3,d0
        add.w d0,a6
        move.l a6,-(sp)
l517a:  jsr L_getfile.l
        beq.s l517no
        bpl.s l517tm
        move.l (sp)+,a3

        moveq #15,d1
field0: move d1,d0          ;nettoie la definition de la fiche
        lsl #1,d0
        clr.w fhc(a2,d0.w)
        lsl #1,d0
        clr.l fhs(a2,d0.w)
        dbra d1,field0
        clr.w fht(a2)
        clr.l d7            ;d7: taille totale des champs
        clr.l d2            ;numero de la variable traitee
field1: move.l -(a3),d3
        beq.s l517fc
        cmp.l #$fff0,d3
        bcc.s l517fc
        add.l d3,d7
        cmp.l #$fff0,d7
        bcc.s l517fl
        move d2,d0
        lsl #1,d0
        move.w d3,fhc(a2,d0.w)   ;taille de la variable
        lsl #1,d0
        move.l -(a3),fhs(a2,d0.w)   ;adresse de celle-ci
        subq.w #1,(sp)
        beq.s field2
        addq #1,d2
        cmp #16,d2
        bcs.s field1
l517fl: moveq #66,d0
        bra.s l517go
field2: addq.l #2,sp
        move.w d7,fht(a2)        ;poke le taille totale du champ
        rts
l517fc: moveq #E_illegalfunc,d0
        bra.s l517go
l517no: moveq #E_notopen,d0
        bra.s l517go
l517tm: moveq #E_file_mismatch,d0
l517go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       LSEEK: POSITIONNE LE POINTEUR DU FICHIER AU BON ENDROIT
L518:   dc.w l518a-L518,0
***********************
        tst.l d3
        beq.s l518fc
        cmp.l #$10000,d3
        bcc.s l518fc
        subq #1,d3
        mulu fht(a2),d3  ;adresse absolue dans le fichier
        cmp.l fhl(a2),d3 ;plus loin que la fin du fichier!
        bhi.s l518eo
l518a:  jmp L_seekbis.l
l518fc: moveq #E_illegalfunc,d0
        bra.s l518go
l518eo: moveq #E_eof,d0
l518go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       SEEKBIS
L519:   dc.w l519a-L519,l519b-L519,0
***********************
l519a:  jsr L_pfile.l
        move.w #1,-(sp)       ;deplacement RELATIF
        move.w fha(a2),-(sp)
        move.l d3,-(sp)
        sub.l d0,(sp)         ;calcule le deplacement relatif
        move.w #$42,-(sp)
        trap #1               ;LSEEK
        lea 10(sp),sp
        tst.l d0              ;ramene en d0 la position dans le fichier
        bmi.s l519b
        rts
l519b:  jmp L_diskerr.l

*************************************************************************
*       GET #xx,yy
L520:   dc.w l520a-L520,l520b-L520,l520c-L520,0
**********************************************
        move.l (a6)+,-(sp)
l520a:  jsr L_getfile.l
        beq.s l520no
        bpl.s l520tm
        move.l (sp)+,d3
l520b:  jsr L_lseek.l           ;positionne ou il faut dans le fichier
        cmp.l fhl(a2),d3
        beq.s l520eo        ;ne permet pas le dernier octet!
        clr.l d7
get1:   move d7,d4
        lsl #1,d4
        clr.l d3
        move.w fhc(a2,d4.w),d3
        beq.s get3
l520c:  jsr L_malloc.l
        lsl #1,d4
        move.l fhs(a2,d4.w),a0        ;prend l'adresse de la variable
        move.l a1,(a0)                ;change la variable
        move.w d3,(a1)+               ;poke la longueur
        move.l a1,-(sp)
        move.l d3,-(sp)
        move.w fha(a2),-(sp)
        move.w #$3f,-(sp)
        trap #1
        lea 12(sp),sp
        tst.l d0
        bmi.s l520z
        add.l d3,a1
        move a1,d0
        btst #0,d0
        beq.s get2
        addq.l #1,a1
get2:   move.l a1,hichaine(a5)  ;remonte les chaines
        addq #1,d7
        cmp #16,d7
        bcs.s get1
get3:   rts
l520no: moveq #E_notopen,d0
        bra.s l520go
l520eo: moveq #E_eof,d0
        bra.s l520go
l520tm: moveq #E_file_mismatch,d0
l520go: move.l error(a5),a0
        jmp (a0)
l520z:  jmp L_diskerr.l

*************************************************************************
*       PUT #xx,yy
L521:   dc.w l521a-L521,l521b-L521,l521c-L521,l521d-L521,l521z-L521,0
**********************************************************************
        move.l (a6)+,-(sp)
l521a:  jsr L_getfile.l
        beq l521no
        bpl l521tm
        move.l (sp)+,d3
l521b:  jsr L_lseek.l           ;positionne ou il faut dans le fichier
        clr.l d7
put1:   move d7,d1
        lsl #1,d1
        clr.l d3
        move.w fhc(a2,d1.w),d3
        beq.s put5
        lsl #1,d1
        move.l fhs(a2,d1.w),a0
        move.l (a0),a0      ;pointe la variable
        clr.l d4
        move.w (a0)+,d4     ;taille de la variable
        cmp d3,d4
        beq.s put2
        bcs.s put2
        move d3,d4          ;variable PLUS GRANDE que le champ
put2:   move.l a0,-(sp)
        move.l d4,-(sp)
        move.w fha(a2),-(sp)
        move.w #$40,-(sp)
        trap #1
        lea 12(sp),sp
        tst.l d0
        bmi.s l521z
        cmp d3,d4
        bcc.s put4
        sub.l d4,d3         ;calcule la difference
l521c:  jsr L_malloc.l
        move.l d3,d0
put3:   move.b #32,(a1)+    ;remplis de blancs
        subq #1,d3
        bne.s put3
        move.l a0,-(sp)
        move.l d0,-(sp)
        move.w fha(a2),-(sp)
        move.w #$40,-(sp)
        trap #1
        lea 12(sp),sp
        tst.l d0
        bmi.s l521z
put4:   addq #1,d7          ;autre variable
        cmp #16,d7
        bcs.s put1
put5:
l521d:  jsr L_pfile.l
        cmp.l fhl(a2),d0    ;si le fichier a grandi
        bcs.s put6
        move.l d0,fhl(a2)   ;poke la nouvelle longueur
put6:   rts
l521no: moveq #E_notopen,d0
        bra.s l521go
l521tm: moveq #E_file_mismatch,d0
l521go: move.l error(a5),a0
        jmp (a0)
l521z:  jmp L_diskerr.l

*************************************************************************
*       DFREE: place libre sur une disque
L522:   dc.w l522z-L522,0
***********************
        move.w #0,-(sp)
        move.l buffer(a5),-(sp)
        move.w #$36,-(sp)
        trap #1             ;get free disk space
        addq.l #8,sp
        tst d0
        bne.s l522z
        move.l buffer(a5),a0
        move.l 8(a0),d6
        move.l 12(a0),d0
        mulu d0,d6
        move.l (a0),d3
        mulu d6,d3
        move.l d3,-(a6)
        rts
l522z:  jmp L_diskerr.l

*************************************************************************
*       MK DIR a$
L523:   dc.w l523a-L523,l523z-L523,0
***********************
l523a:  jsr L_namedisk.l
        move.l name1(a5),-(sp)
        move #$39,-(sp)
        trap #1             ;MKDIR
        addq.l #6,sp
        tst.w d0
        bne.s l523z
        rts
l523z:  jmp L_diskerr.l

*************************************************************************
*       RM DIR a$
L524:   dc.w l524a-L524,l524z-L524,0
***********************
l524a:  jsr L_namedisk.l
        move.l name1(a5),-(sp)
        move #$3a,-(sp)
        trap #1             ;RMDIR
        addq.l #6,sp
        tst.w d0
        bne.s l524z
        rts
l524z:  jmp L_diskerr.l

*************************************************************************
*       DIR$=a$  (instruction)
L525:   dc.w l525a-L525,l525z-L525,0
***********************
l525a:  jsr L_namedisk.l
        move.l name1(a5),-(sp)
        move #$3b,-(sp)
        trap #1             ;CHDIR
        addq.l #6,sp
        tst d0
        bne.s l525z
        rts
l525z:  jmp L_diskerr.l

*************************************************************************
*       DIR$ function
L526:   dc.w l526a-L526,l526z-L526,0
***********************
        move.l #128,d3
l526a:  jsr L_malloc.l         ;longueur de la chaine
        addq.l #2,a0
        clr.w -(sp)         ;drive courant
        move.l a0,-(sp)
        move.w #$47,-(sp)   ;GETDIR
        trap #1
        addq.l #8,sp
        tst.w d0
        bne.s l526z
        lea 2(a1),a0
curdir1:tst.b (a0)+
        bne.s curdir1
        subq.l #1,a0
        move.l a0,d0
        sub.l a1,d0
        subq.l #2,d0
        move.w d0,(a1)      ;longueur de la chaine
        move.l a1,-(a6)
        move.w a0,d0
        btst #0,d0
        beq.s curdir2
        addq.l #1,a0
curdir2:move.l a0,hichaine(a5)
        rts
l526z:  jmp L_diskerr.l

*************************************************************************
*       PREVIOUS: PASSE AU DIRECTORY PRECCEDENT
L527:   dc.w l527z-L527,0
***********************
        clr -(sp)
        move.l buffer(a5),-(sp)
        move.w #$47,-(sp)
        trap #1             ;GETDIR
        addq.l #8,sp
        tst d0
        bne.s l527z
        move.l buffer(a5),a0
        move.l a0,d7
        moveq #-1,d0
pr:     addq #1,d0
        tst.b (a0)+
        bne.s pr
        tst d0
        beq.s pr3
pr1:    cmp.b #"\",-(a0)
        beq.s pr2
        cmp.l d7,a0
        bne.s pr1
pr2:    clr.b 1(a0)
        move.l buffer(a5),-(sp)
        move.w #$3b,-(sp)
        trap #1             ;CHDIR
        addq.l #6,sp
pr3:    rts
l527z:  jmp L_diskerr.l

*************************************************************************
*       DRIVE$ EN FONCTION RAMENE la lettre DU DRIVE COURANT
L528:   dc.w l528a-L528,0
***********************
        move.w #$19,-(sp)
        trap #1
        addq.l #2,sp
        move.b d0,d2
        addi.w #65,d2
        moveq #4,d3
l528a:  jsr L_malloc.l
        move.w #1,(a0)+
        move.b d2,(a0)+
        clr.b (a0)+
        move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts

*************************************************************************
*       DRIVE EN FONCTION: RAMENE le numero DU DRIVE COURANT
L529:   dc.w 0
***********************
        move.w #$19,-(sp)
        trap #1             ;CURRENT DISK
        addq.l #2,sp
        clr.l d3
        move d0,d3
        move.l d3,-(a6)
        rts

*************************************************************************
*       DRIVE EN INSTRUCTION: CHANGE LE DRIVE COURANT
L530:   dc.w l530a-L530,0
**************************
        move.l (a6)+,d3
        addi.w #65,d3
l530a:  jmp L_drive.l

*************************************************************************
*       DRIVE$ EN INSTRUCTION
L531:   dc.w l531a-L531,0
***********************
        move.l (a6)+,a2
        moveq #0,d3
        move.w (a2)+,d2
        move.b (a2)+,d3
l531a:  jmp L_drive.l

*************************************************************************
*       DRIVE
L532:   dc.w l532z-L532,0
***********************
        cmp.w #97,d3
        bcs.s drived1
        subi.w #$20,d3
drived1:subi.w #65,d3
setdrv: move.w #10,-(sp)
        trap #13
        addq.l #2,sp
        cmp.l #26,d3
        bcc.s l532fc
        btst d3,d0
        beq.s l532nc
        move.w d3,-(sp)
        move.w #$e,-(sp)
        trap #1             ;SETDRV
        addq.l #4,sp
        tst d0
        bmi.s l532z
        rts
l532fc: moveq #E_illegalfunc,d0
        bra.s l532go
l532nc: moveq #E_nodrive,d0
l532go: move.l error(a5),a0
        jmp (a0)
l532z:  jmp L_diskerr.l

*************************************************************************
*       DRVMAP: FONCTION ---> CARTE DES DRIVES CONNECTES
L533:   dc.w 0
***********************
        move #10,-(sp)
        trap #13
        addq.l #2,sp
        move.l d0,-(a6)
        rts

*************************************************************************
*       DIR FIRST$(a$,xx): ramene les donnees directory d'un pgm
L534:   dc.w l534a-L534,l534b-L534,l534c-L534,l534d-L534,0
**********************************************
l534a:  jsr L_setdta.l
        move.l (a6)+,-(sp)
l534b:  jsr L_namedisk.l
        move.l (sp)+,d0
        cmp.l #$40,d0
        bcs.s dfrst1
        moveq #%11001,d0    ;par defaut!
dfrst1: move.l name1(a5),a0
l534c:  jsr L_sfirst.l
l534d:  jmp L_dirfirstnext.l

*************************************************************************
*       DIR NEXT$
L535:   dc.w l535a-L535,l535b-L535,0
**********************************************
l535a:  jsr L_snext.l
l535b:  jmp L_dirfirstnext.l

*************************************************************************
*       DIRFIRST DIRNEXT
L536:   dc.w l536a-L536,l536b-L536,l536c-L536,l536d-L536,l536e-L536,0
**********************************************
        tst d0              ;rien trouve: ramene une chaine vide!
        bne l536v
        moveq #50,d3
l536a:  jsr L_malloc.l
        move.l a0,-(a6)
        lea 48(a1),a1
        move.l a1,hichaine(a5)
        move.w #45,(a0)+    ;taille de la chaine
        move.l a0,-(sp)
        moveq #46-1,d0
dnxt2:  move.b #32,(a0)+    ;nettoie la chaine
        dbra d0,dnxt2
        move.l (sp),a0
        move.l dta(a5),a2
        lea 30(a2),a2
dnxt3:  move.b (a2)+,(a0)+  ;copie le nom du fichier: 0
        bne.s dnxt3
        move.b #32,-1(a0)   ;efface le zero!
        move.l dta(a5),a2          ;taille du fichier: 13
        move.l 26(a2),d0
        move.l (sp),a0
        lea 13(a0),a0
        clr.l d4
        moveq #-1,d3
l536b:  jsr L_longdec.l
        move.l dta(a5),a2          ;date: 22
        move.w 24(a2),d7
        move.l (sp),a0
        lea 22(a0),a0
l536c:  jsr L_datebis.l
        move.l dta(a5),a2          ;heure: 33
        move.w 22(a2),d7
        move.l (sp),a0
        lea 33(a0),a0
l536d:  jsr L_timebis.l
        clr.l d0                   ;type de fichier: 42--->45
        move.l dta(a5),a2
        move.b 21(a2),d0
        move.l (sp)+,a0
        lea 42(a0),a0
        clr.l d4
        moveq #-1,d3
l536e:  jsr L_longdec.l
        rts
l536v:  move.l chvide(a5),-(a6)
        rts

*************************************************************************
*       KILL
L537:   dc.w l537a-L537,l537b-L537,l537c-L537,l537d-L537,l537e-L537
        dc.w l537z-L537,0
**********************************************************************
l537a:  jsr L_setdta.l
l537b:  jsr L_namedisk.l        ;cherche le nom
        beq.s l537r
        move.l name1(a5),a0
l537c:  jsr L_sfirst.l
        bne.s l537nf        ;file not found
kill1:
l537d:  jsr L_unlink.l
        bmi.s l537z
l537e:  jsr L_snext.l
        beq.s kill1
l537r:  rts
l537nf: moveq #E_noent,d0
        move.l error(a5),a0
        jmp (a0)
l537z:  jmp L_diskerr.l


*************************************************************************
*       RENAME
L538:   dc.w l538a-L538,l538b-L538,l538c-L538,l538d-L538,l538e-L538
        dc.w l538z-L538,0
**************************
        move.l (a6)+,d0
        move.l (a6)+,d1
        move.l d0,-(a6)
        move.l d1,-(a6)
l538a:  jsr L_setdta.l
l538b:  jsr L_namedisk.l
        beq.s l538x
        move.l name1(a5),a0
        move.l name2(a5),a1
l538r:  move.b (a0)+,(a1)+
        bne.s l538r
l538c:  jsr L_namedisk.l
        beq.s l538y
        move.l name2(a5),a0
l538d:  jsr L_sfirst.l
        bne.s l538nf
ren1:   move.l name1(a5),a1
        move.l a1,-(sp)               ;new name
        move.l a0,-(sp)               ;old name
        clr.w -(sp)
        move #$56,-(sp)
        trap #1
        lea 12(sp),sp
        tst d0
        bmi.s l538z
l538e:  jsr L_snext.l
        beq.s ren1
        rts
l538x:  addq.l #4,a6
l538y:  rts
l538nf: moveq #E_noent,d0
        move.l error(a5),a0
        jmp (a0)
l538z:  jmp L_diskerr.l

*************************************************************************
*       ROUTINES DIRECTORY
L539:   dc.w l539a-L539,l539b-L539,l539z-L539,0
**********************************************
        movem.l a2/d2,-(sp)
l539a:  jsr L_getdrive2.l
        addq.l #4,a6
        move.l buffer(a5),a3
        move.w d3,128(a3)
        clr.w -(sp)         ;drive courant
        pea 130(a3)         ;poke en BUFFER+130
        move.w #$47,-(sp)   ;GETDIR
        trap #1
        addq.l #8,sp
        tst.w d0
        bne l539z
        tst.b 130(a3)
        bne.s dsa
        move.w #$5C00,130(a3)
; analyse la chaine
dsa:    movem.l (sp)+,a2/d2
        move.l name2(a5),a3
        move.l #$2A2E2A00,(a3)      ;*.*---> NAME2
        tst.w d2
        beq ds7
        subq.w #1,d2
        move.l name1(a5),a1
        move.l a1,d4
        move.l a2,a0
        move.w d2,d3
ds0:    move.b (a0)+,d0               ;prend la lettre
        cmp.b #":",d0
        beq.s ds1
        cmp.b #"\",d0
        bne.s ds2
ds1:    move.l a0,a2
        move.w d2,d3
        subq.w #1,d3
        move.l a1,d4
        addq.l #1,d4
ds2:    cmp.b #"*",d0         ;Essaie de reperer la fin du nom
        beq.s ds3
        cmp.b #"?",d0
        beq.s ds3
        move.b d0,(a1)+
        dbra d2,ds0
        clr.b (a1)
        bra.s ds5             ;Pas de nom de filtre---> *.*!
; copie le filtre---> NAME2
ds3:    move.l d4,a1
        clr.b (a1)            ;arrete le path!
        move.l a2,a0
        move.l name2(a5),a1
        tst.w d3
        bmi.s ds5
ds4:    move.b (a0)+,(a1)+
        dbra d3,ds4
        clr.b (a1)
; change le directory s'il faut
ds5:    move.l name1(a5),a3
        tst.b (a3)            ;Ya til un path?
        beq.s ds7
        move.l a3,a2
; change le drive?
        cmp.b #":",1(a2)
        bne.s ds6
        moveq #0,d3
        move.b (a2),d3
        addq.l #2,a2
        move.l a2,-(sp)
l539b:  jsr L_drive.l
        move.l (sp)+,a2
; Change le directory?
ds6:    tst.b (a2)
        beq.s ds7
        move.l a2,-(sp)
        move #$3b,-(sp)
        trap #1
        addq.l #6,sp
        tst d0
        bne.s l539z
; FINI!
ds7:    rts
l539z:  jmp L_diskerr.l

*************************************************************************
*       Restore DRIVE
L540:   dc.w l540a-L540,l540z-L540,0
*************************************
        moveq #0,d3
        move.l buffer(a5),a3
        move.w 128(a3),d3
        addi.w #65,d3
l540a:  jsr L_drive.l
; restore DIRECTORY
        pea 130(a3)
        move #$3b,-(sp)
        trap #1             ;CHDIR
        addq.l #6,sp
        tst d0
        bne.s l540z
        rts
l540z:  jmp L_diskerr.l

*************************************************************************
*       DIRECTORY ON WINDOW
L541:   dc.w l541a-L541,0
***********************
        clr.b impflg(a5)
        move.b #1,d1
l541a:  jmp L_printdir.l

*************************************************************************
*       DIRECTORY ON PRINTER
L542:   dc.w l542a-L542,0
**********************************************
        move.b #1,impflg(a5)
        clr.b d1
l542a:  jmp L_printdir.l

*************************************************************************
*       DIRECTORY
L543:   dc.w l543a-L543,0
***********************
        clr.b impflg(a5)
        clr.b d1
l543a:  jmp L_printdir.l

*************************************************************************
*       DIRECTORY!
L544:   dc.w l544a-L544,l544b-L544,l544c-L544,l544d-L544
        dc.w l544e-L544,l544f-L544,l544g-L544,l544h-L544
        dc.w l544i-L544,l544j-L544,l544k-L544,l544l-L544
        dc.w 0
*********************************************************************
        move.w d0,-(sp)
        move.l buffer(a5),a3
        move.b d1,255(a3)
l544a:  jsr L_setdta.l
        move.l name2(a5),a2
        move.l #$2A2E2A00,(a2)      ;*.* ---> NAME2
        moveq #0,d2
        move.w (sp)+,d0
        beq.s l544b
        move.l (a6)+,a2
        move.w (a2)+,d2
l544b:  jsr L_savedrive.l
; affiche le message de debut de directory
        move.w brkinhib(a5),-(sp)         ;Arrete le break!
        move.w #1,brkinhib(a5)
        movem.l a4-a6,-(sp)
        bsr impr
        lea msd0(pc),a0           ;Drive
l544c:  jsr L_traduit.l
        bsr impc
l544d:  jsr L_getdrive2.l               ;numero du drive
        move.l (a6)+,d0
        addi.b #'A',d0
        move.l defloat(a5),a0
        move.b d0,(a0)
        clr.b 1(a0)
        bsr impc

        lea msd1(pc),a0           ;path
l544e:  jsr L_traduit.l
        bsr impc
        clr.w -(sp)
        move.l defloat(a5),-(sp)
        move.w #$47,-(sp)
        trap #1               ;GETDIR
        addq.l #8,sp
        tst.w d0
        bne l544nr
        move.l defloat(a5),a0
        bsr plusr
        bsr impc

; Va remplir le buffer avec les fichiers
l544f:  jsr L_fillfile.l

; Affichage des noms des fichiers
        clr.l dirsize(a5)
        move.l hichaine(a5),a2
dd3:    subq.w #1,fsd(a5)
        bmi dd10
        move.l buffer(a5),a3
        tst.b 255(a3)
        beq.s dd4
; Affichage condense
        move.l 16(a2),d0
        add.l d0,dirsize(a5)
        move.l a2,a0
        bsr impc
        move.l defloat(a5),a0
        move.l #$20202020,(a0)
        move.l #$20200000,4(a0)
        bsr impc
        bra dd6
; Directory?
dd4:    cmp.b #"*",(a2)
        bne.s dd5
        lea ssdir1(pc),a0
        bsr impc
        lea 1(a2),a0
        bsr impc
        bsr impr
        bra.s dd6
; Fichier normal?
dd5:    lea 1(a2),a0        ;imprime le nom
        bsr impc
        move.l 16(a2),d0    ;prend la taille
        add.l d0,dirsize(a5)    ;additionne a la taille totale
        move.l defloat(a5),a0
        move.w #$2020,(a0)+
        move.l a2,-(sp)
        clr.l d4
        moveq #-1,d3
l544g:  jsr L_longdec.l
        clr.b (a0)
        move.l (sp)+,a2
        move.l defloat(a5),a0      ;affiche la taille
        bsr impc
        bsr impr
dd6:    lea 20(a2),a2
;appui sur les touches
dd7:    bsr ttlist
        beq dd3            ;pas d'appui
        bmi dd15           ;appui sur ESC
dd8:    bsr ttlist
        beq.s dd8
        bmi.s dd15
        bra dd3

; Taille prise et taille restante sur la disquette
dd10:   bsr impr
        move.l dirsize(a5),d0
        move.l defloat(a5),a0
        clr.l d4
        moveq #-1,d3
l544h:  jsr L_longdec.l         ;ecris le nombre de BYTE USED
        clr.b (a0)
        move.l defloat(a5),a0
        bsr impc
        tst.l dirsize(a5)
        beq.s dd11
        cmp.l #1,dirsize(a5)
        bne.s dd12
dd11:   lea msd3(pc),a0
        bra.s dd13
dd12:   lea msd2(pc),a0
dd13:
l544i:  jsr L_traduit.l
        bsr impc
        bsr impr
dd15:
l544j:  jsr L_restoredrive.l                 ;Restore drive!
        movem.l (sp)+,a4-a6
        move.w (sp)+,brkinhib(a5) ;Restore break!
        rts

;-----> Imprime la chaine
impc:   movem.l a1/a2,-(sp)
l544k:  jsr L_impfin.l
        movem.l (sp)+,a1/a2
        rts
;-----> Imprime un retour chariot
impr:   lea rchar(pc),a0
        bra.s impc
rchar:  dc.b 13,10,0,0
;-----> Plus retour
plusr:  move.l a0,-(sp)
plu:    tst.b (a0)+
        bne.s plu
        move.b #13,-1(a0)
        move.b #10,(a0)
        clr.b 1(a0)
        move.l (sp)+,a0
        rts
;-----> TTList
ttlist:
l544l:  jsr L_incle.l
        tst.l d0
        beq.s tl2
        cmp.b #32,d0
        beq.s tl3
        cmp.b #3,d0
        beq.s tl1
        swap d0
        cmp.b #1,d0
        beq.s tl1
        clr d0
        rts
tl1:    moveq #-1,d0
tl2:    rts
tl3:    moveq #1,d0
        rts
l544nr: moveq #E_drive_not_ready,d0
        move.l error(a5),a0
        jmp (a0)
;MESSAGE DU DIRECTORY
msd0:   dc.b "Drive ",0,"Lecteur ",0
msd1:   dc.b ", path: ",0,", dir: ",0
msd2:   dc.b " bytes used.",0," octets utilis‚s.",0
msd3:   dc.b " byte used",0," octet utilise",0
ssdir1: dc.b "* -----------> ",0
        even

*************************************************************************
*       FILL FILE: REMPLIS LE BUFFER AVEC LES FILES ALPHABETIQUEMENT!
L545:   dc.w l545a-L545,l545b-L545,l545c-L545,l545d-L545
        dc.w l545e-L545,l545f-L545,0
*************************************
        move.l lowvar(a5),d0      ;Au moins 2560 octets de libre?
        subi.l #2600,d0
        cmp.l hichaine(a5),d0
        bhi.s F1
l545a:  jsr L_garbage.l
F1:     move.l hichaine(a5),a0    ;Adresse du buffer= hichaine!
        moveq #127,d0         ;128 noms
F2:     moveq #13,d1          ;RAZ du buffer
F3:     move.b #32,(a0)+
        dbra d1,F3
        clr.w (a0)+           ;Fin de la chaine
        clr.l (a0)+           ;Place pour la taille
        dbra d0,F2
l545b:  jsr L_setdta.l
        clr fsd(a5)
; Cherche les directories
        lea etoile(pc),a0
        moveq #$10,d0
l545c:  jsr L_sfirst.l
        bne.s F6
F4:     move.l dta(a5),a2
        cmp.b #$10,21(a2)   ;Ne veut que des directory
        bne.s F5
        bsr putfile
F5:
l545d:  jsr L_snext.l
        beq.s F4
; Cherche les fichiers
F6:     move.l name2(a5),a0
        clr.l d0
l545e:  jsr L_sfirst.l
        bne.s FF
F7:     bsr putfile
l545f:  jsr L_snext.l
        beq.s F7
FF:     rts

; PUT FILE: POKE DANS LE BUFFER
putfile:cmp #128,fsd(a5)        ;Pas plus de 128!
        bcc.s FF
; Poke le nom au debut du buffer
        move.l fsbuff(a5),a0
        move.l a0,a1
        moveq #13,d0
pf0:    move.b #32,(a1)+      ;Nettoie le buffer
        dbra d0,pf0
        clr.w (a1)+
        move.l a0,a1
        move.l dta(a5),a2
        move.l 26(a2),16(a0)  ;Taille du fichier
        btst #4,21(a2)        ;Si directory, met * avant!
        beq.s pf1
        move.b #"*",(a0)
pf1:    addq.l #1,a0
        lea 30(a2),a2
        clr d1
pf2:    move.b (a2)+,d0
        beq.s pf5
        cmp.b #".",d0
        beq.s pf3
        move.b d0,(a0)+
        addq #1,d1
        bra.s pf2
pf3:    tst d1              ;enleve les . et ..
        beq.s FF
        lea 9(a1),a0
        move.b d0,(a0)+
pf4:    move.b (a2)+,d0
        beq.s pf5
        move.b d0,(a0)+
        bra.s pf4
; Cherche la place dans le buffer
pf5:    move.l hichaine(a5),a2
        move.w fsd(a5),d2
        beq.s pfC
        subq.w #1,d2
pf6:    move.l fsbuff(a5),a0
        move.l a2,a1
pf7:    move.b (a0)+,d0
        beq.s pf9
        cmp.b #'*',d0
        bne.s pf8
        move.b #31,d0
pf8:    move.b (a1)+,d1
        beq.s pf9
        cmp.b #'*',d1
        bne.s pfZ
        move.b #31,d1
pfZ:    cmp.b d1,d0
        beq.s pf7
        bcs.s pfA
pf9:    lea 20(a2),a2
        dbra d2,pf6
        bra.s pfC
; Decale le reste du buffer---> fin
pfA:    move.w fsd(a5),d0       ;Adresse du dernier nom!
        mulu #20,d0
        add.l hichaine(a5),d0
        move.l d0,a0
        sub.l a2,d0         ;distance choisi/dernier
        beq.s pfC           ;C'est le dernier
        bcs.s pfC           ;Improbable!
        lsr.w #2,d0         ;Divise par 4---> nb de long mots
        subq.w #1,d0
        lea 20(a0),a1
pfB:    move.l -(a0),-(a1)  ;Boucle de recopie
        dbra d0,pfB
; Recopie du nom
pfC:    moveq #20-1,d0
        move.l fsbuff(a5),a0
pfD:    move.b (a0)+,(a2)+
        dbra d0,pfD
; Un nom de plus!
        addq.w #1,fsd(a5)
        rts
etoile: dc.b "*.*",0

*************************************************************************
*       PRINTING an ENTIRE cipher in a file
L546:   dc.w l546a-L546,l546b-L546,l546c-L546,0
*****************************************
        moveq #-1,d3            ;Proportionnel
        moveq #1,d4             ;Avec signe
        move.l buffer(a5),a0
        move.l (a6)+,d0
l546a:  jsr L_longdec.l
        clr.b (a0)
        tst.b usingflg(a5)
        beq.s l546z
l546b:  jsr L_usingcf.l
l546z:  move.l a0,d7                    ;Taille a imprimer---> D7
        move.l buffer(a5),a2
        sub.l a2,d7
l546c:  jmp L_printfile.l

*************************************************************************
*       PRINTING a FLOAT figure in a file
L547:   dc.w l547a-L547,l547b-L547,l547c-L547,0
*****************************************
        move.l buffer(a5),a0
        move.w fixflg(a5),d0
l547a:  jsr L_strflasc.l
        clr.b (a0)
        tst.b usingflg(a5)
        beq.s l547z
l547b:  jsr L_usingcf.l
l547z:  move.l a0,d7                    ;Taille a imprimer---> D7
        move.l buffer(a5),a2
        sub.l a2,d7
l547c:  jmp L_printfile.l

*************************************************************************
*       PRINTING a string in a file
L548:   dc.w l548a-L548,l548b-L548,l548c-L548,0
********************************
        move.l (a6)+,a2
        move.w (a2)+,d7
; Using en route: UNE SEULE SALVE
        tst.b usingflg(a5)
        beq.s l548c
        move.l buffer(a5),a0
        moveq #127,d0
l5480:  move.b (a2)+,(a0)+
        subq.w #1,d7
        beq.s l548a
        dbra d0,l5480
l548a:  jsr L_usingch.l
        move.l a0,d7
        move.l buffer(a5),a2
        sub.l a2,d7
l548b:  jmp L_printfile.l
; Pas using
l548c:  jmp L_printfile.l

*************************************************************************
*       PRINTING IN A FILE
L549:   dc.w l549a-L549,l549z-L549,0
**********************************************
        move.l printfile(a5),a3
        move.w printype(a5),d0
        cmp #6,d0
        beq.s print5
; port imprimante/midi/rs-232: imprime TOUT, meme les zero!
        subq #1,d7          ;compteur du nombre de caracteres
        bmi.s print6
        move.w d0,d6
        subq #1,d6
        move.l a2,-(sp)
print4: move.w d6,-(sp)     ;bcostat
        move.w #8,-(sp)
        trap #13
        addq.l #4,sp
l549a:  jsr L_tester.l          ;attend que le perif soit pres,
        tst d0              ;en gerant quand meme les interruptions! SUPER!
        beq.s print4
        move.l (sp),a2
        move.b (a2)+,d0     ;c'est pret! envoyez c'est pes‚!
        move.l a2,(sp)
        move.w d0,-(sp)
        move.w d6,-(sp)
        move.w #3,-(sp)
        trap #13
        addq.l #6,sp
        dbra d7,print4
        addq.l #4,sp
        rts
; dans un fichier sequentiel: imprime aussi tout!
print5: tst.w d7            ;chaine vide!
        beq.s print6
        move.l a2,-(sp)
        andi.l #$ffff,d7
        move.l d7,-(sp)
        move.w fha(a3),-(sp)
        move.w #$40,-(sp)
        trap #1             ;Write
        lea 12(sp),sp
        tst.l d0
        bmi.s l549z
        add.l d7,fhl(a3) ;augmente la taille du fichier
print6: rts
l549z:  jmp L_diskerr.l

*************************************************************************
*       PRINTING back ---> FILE
L550:   dc.w l550a-L550,0
***********************
        move.l buffer(a5),a2
        move.b #13,(a2)
        move.b #10,1(a2)
        moveq #2,d7
l550a:  jmp L_printfile.l

*************************************************************************
*       PRINT comma ---> FILE
L551:   dc.w l551a-L551,0
***********************
        move.l buffer(a5),a2
        move.l #$20202020,(a2)
        moveq #3,d7
l551a:  jmp L_printfile.l

*************************************************************************
*       INPUT #----> DEBUT
L552:   dc.w l552a-L552,0
***********************
        clr.w flginp(a5)
        tst.w d0
        beq.s l552a
        move.w #1,flginp(a5)
        move.l (a6)+,d0
        move.w d0,chrinp(a5)
l552a:  jsr L_getfile.l
        beq.s l552no
        move.l a2,oradinp(a5)
        move.w #1,orinput(a5)
        rts
l552no: moveq #E_notopen,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       INPUT$(xx)
L553:   dc.w l553a-L553,l553b-L553,0
*************************************
        move.l (a6)+,d3
        bmi.s l553fc
        beq.s l553v
        cmp.l #$fff0,d3
        bcc.s l553tl
l553a:  jsr L_malloc.l
        move d3,(a0)+
        subq #1,d3
in1:    movem.l a0/a1/d3,-(sp)
l553b:  jsr L_key.l
        movem.l (sp)+,a0/a1/d3
        tst.b d1
        bmi.s in2
        beq.s in2
        cmp #32,d1
        bcs.s in1
        move d1,d0
in2:    move.b d0,(a0)+
        dbra d3,in1
        move.w a0,d0
        btst #0,d0
        beq.s in3
        addq.l #1,a0
in3:    move.l a0,hichaine(a5)
        move.l a1,-(a6)
        rts
l553v:  move.l chvide(a5),-(a6)
        rts
l553fc: moveq #E_illegalfunc,d0
        bra.s l553go
l553tl: moveq #E_string_too_long,d0
l553go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       INPUT$ (#xx,yy)
L554:   dc.w l554a-L554,l554b-L554,l554c-L554,l554d-L554,l554z-L554,0
*********************************************************************
        move.l (a6)+,-(sp)
l554a:  jsr L_getfile.l
        beq l554no
        cmp #5,d0
        beq.s ine
; rs232 ou midi: prend octet par octet
        move.l (sp)+,d3     ;entree rs232, ou midi
        bmi l554fc
        beq l554v
        cmp.l #$fff0,d3
        bcc l554tl
l554b:  jsr L_malloc.l
        move d3,(a0)+       ;poke la longueur
ind:    jsr L_getbyte.l
        move.b d0,(a0)+
        subq.l #1,d3
        bne.s ind
        bra.s l554f
; disque: prend rapidement!
ine:    move.l fhl(a2),d2
l554c:  jsr L_pfile.l
        sub.l d0,d2
        bcs.s l554eo
        beq.s l554eo
        move.l (sp)+,d3
        bmi.s l554fc
        beq.s l554v
        cmp.l #$fff0,d3
        bcc.s l554tl
        cmp.l d2,d3
        bls.s inq
        move.l d2,d3        ;trop grand: ne prend que ce qu'il faut
inq:
l554d:  jsr L_malloc.l
        move.l a1,-(sp)
        move d3,(a0)+
        move.l a0,-(sp)
        move.l d3,-(sp)
        move.w fha(a2),-(sp)
        move.w #$3f,-(sp)
        trap #1
        lea 12(sp),sp
        tst.l d0
        bmi.s l554z
        move.l (sp)+,a1
        move.l a1,a0
        addq.l #2,a0
        add.l d3,a0
l554f:  move.l a1,-(a6)
        move.w a0,d0
        btst #0,d0
        beq.s l554g
        addq.l #1,a0
l554g:  move.l a0,hichaine(a5)
        rts
l554v:  move.l chvide(a5),-(a6)
        rts
l554z:  jmp L_diskerr.l
l554no: moveq #E_notopen,d0
        bra.s l554go
l554eo: moveq #E_eof,d0
        bra.s l554go
l554fc: moveq #E_illegalfunc,d0
        bra.s l554go
l554tl: moveq #E_string_too_long,d0
l554go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FILE SELECTOR (a$)
L555:   dc.w l555a-L555,0
***********************
        move.w #1,fsd+22(a5)
        clr.w fsd+24(a5)
l555a:  jmp L_fileselect.l

*************************************************************************
*       FILE SELECTOR (a$,"titre")
L556:   dc.w l556d-L556,0
***********************
        move.w #1,fsd+22(a5)
        move.w #1,fsd+24(a5)
        move.l (a6)+,a0
        move.l fsbuff(a5),a1
        move.w (a0)+,d0
        beq.s l556c
        cmp.w #80,d0
        bcs.s l556a
        moveq #80,d0
l556a:  subq.w #1,d0
l556b:  move.b (a0)+,(a1)+
        dbra d0,l556b
l556c:  clr.b (a1)
l556d:  jmp L_fileselect.l

*************************************************************************
*       FILE SELECTOR (a$,b$,n)
L557:   dc.w l557d-L557,0
***********************
        move.l (a6)+,d0
        beq.s l557z
        cmp.l #16,d0
        bcc.s l557z
        move.w d0,fsd+22(a5)
        move.w #1,fsd+24(a5)
        move.l (a6)+,a0
        move.l fsbuff(a5),a1
        move.w (a0)+,d0
        beq.s l557c
        cmp.w #80,d0
        bcs.s l557a
        moveq #80,d0
l557a:  subq.w #1,d0
l557b:  move.b (a0)+,(a1)+
        dbra d0,l557b
l557c:  clr.b (a1)
l557d:  jmp L_fileselect.l
l557z:  moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       FILE SELECT!
L558:   dc.w l558a-L558,l558b-L558,l558c-L558,l558d-L558
        dc.w l558e-L558,l558f-L558,l558g-L558,l558h-L558
        dc.w l558i-L558,0
**************************
        clr fsd+26(a5)
        move.l (a6)+,a2
        moveq #0,d2
        move.w (a2)+,d2
l558a:  jsr L_savedrive.l
        moveq #-1,d0
        move.l name2(a5),a0
fs1:    addq.l #1,d0
        tst.b (a0)+
        bne.s fs1
        move.w d0,fsd+18(a5)

; raz du buffer souris
        move.l defloat(a5),a0
        lea 16(a0),a0
        moveq #63,d0
fs3c:   clr.l (a0)+
        dbra d0,fs3c
; dessin de la fenetre
        bsr fz1
        move mode(a5),d0
        mulu #10,d0
        lea fswind(pc),a0
        add d0,a0
        moveq #13,d0
        move.w fsd+22(a5),d1     ;jeux de caractere
        swap d1
        move.w (a0)+,d1     ;bordure
        move.w (a0)+,d2     ;dx
        move.w (a0)+,d3     ;dy
        move.w (a0)+,d4     ;tx
        move.w (a0)+,d5     ;ty
        move.w valpen(a5),d6    ;pen
        swap d6
        move.w valpaper(a5),d6  ;paper
        moveq #W_initwind,d7         ;initwind
        trap #3
        tst d0
        bne l558z

fs4:    moveq #W_chrout,d7
        moveq #20,d0        ;arret curs
        trap #3
        moveq #25,d0        ;scroll off
        trap #3
        tst fsd+24(a5)           ;imprime le titre
        bne.s fs4a
        lea fst(pc),a0
l558b:  jsr L_traduit.l
        moveq #W_centre,d7
        trap #3
        bra.s fs4b
fs4a:   move.l fsbuff(a5),a0
        moveq #W_prtstring,d7
        trap #3
fs4b:   lea fsc(pc),a2      ;imprime les cadres
        moveq #5,d3
fs5:    move.w (a2)+,d0
        move.w (a2)+,d1
        moveq #W_locate,d7
        trap #3
        move.w (a2)+,d1
        move.w (a2)+,d2
        move.w fsd+22(a5),d0
        moveq #W_box,d7
        trap #3
        dbra d3,fs5
        clr d0
fs6:    clr d1
        bsr writext         ;affichage du texte
        addq #1,d0
        cmp #7,d0
        bcs.s fs6
; raz du nom
        clr fsd+16(a5)
        move.l fsname(a5),a0
        moveq #12,d0
fs6a:   clr.b (a0)+
        dbra d0,fs6a
        bsr locnom
; affiche le pathname
        bsr pathaff
; affichage des drives
        bsr drivaff
; remplissage du buffer
l558c:  jsr L_fillfile.l
; affiche tous les fichiers
        clr fsd+2(a5)
        move #-1,fsd+6(a5)
        bsr filesaff
; raz du buffer clavier
l558d:  jsr L_clearkey.l
; boucle d'attente
fswait:
fs9:    moveq #S_mouse,d0        ;trouve la zone de la souris
        trap #5
        clr d2
        move.l defloat(a5),a0
        lea 16(a0),a0
fs10:   cmp (a0),d0
        bcs.s fs11
        cmp 2(a0),d1
        bcs.s fs11
        cmp 4(a0),d0
        bcc.s fs11
        cmp 6(a0),d1
        bcs.s fs12
fs11:   addq.l #8,a0
        addq #1,d2
        cmp #32,d2
        bcs.s fs10
; dans aucune: eteint ce qui etait allume
        tst fsd+4(a5)
        bne.s fs12a
        move #-1,fsd+6(a5)
        bra.s fs19
; dans une zone
fs12:   tst fsd+4(a5)
        beq.s fs13
        cmp fsd+6(a5),d2    ;on reste sur le meme!
        beq fs19
fs12a:  clr d1
        move fsd+6(a5),d2
        move #-1,fsd+6(a5)
        bra.s fs14
fs13:   move d2,fsd+6(a5)
        moveq #1,d1
fs14:   move d1,fsd+4(a5)
        cmp #6,d2           ;inverse une commande
        bcc.s fs15
        move d2,d0
        bsr memocurs
        bsr writext
        bsr remetcurs
        bra.s fs19
fs15:   cmp #16,d2          ;n'inverse pas les drives!
        bcs.s fs19
        move d2,d0
        subi.w #16,d0
        add fsd+2(a5),d0
        cmp fsd(a5),d0
        bcc.s fs19
        bsr memocurs
        bsr fileaff         ;inverse un nom de file
        bsr remetcurs

; TESTS DU CLAVIER
fs19:
l558e:  jsr L_incle.l
        beq fs19z
        bsr fsnorm          ;affichage normal!
        tst.w d0
        bne.s fs19a
        swap d0
        cmp.b #72,d0        ;locate nom
        beq fs26a
        cmp.b #80,d0        ;locate path
        beq fs27a
        bra fswait
fs19a:  cmp.b #13,d0        ;RETURN
        bne.s fs19j
        tst fsd+14(a5)
        beq fs25c           ;si dans NOM----> OK
        bne fs22d           ;si dans PATH---> DIR
fs19j:  tst fsd+14(a5)
        bne fs19p
; dans le nom
        move.l fsname(a5),a1
        move fsd+16(a5),d1
        cmp.b #8,d0
        bne.s fs19c
fs19b:  tst d1              ;backspace
        beq fswait
        subq #1,d1
        move d1,fsd+16(a5)
        move.b 0(a1,d1.w),d2
        move.b #32,0(a1,d1.w)
        lea fsr(pc),a0
        moveq #W_prtstring,d7
        trap #3
        cmp.b #32,d2
        beq.s fs19b
        bra fswait
fs19c:  cmp.b #".",d0       ;point?
        bne fs19d
        cmp #9,d1
        bcc fswait
fs19g:  cmp #8,d1
        beq fs19h
        move.b #32,0(a1,d1.w)
        moveq #' ',d0
        moveq #W_chrout,d7
        trap #3
        addq #1,d1
        bra fs19g
fs19h:  move d1,fsd+16(a5)
        move.b #".",d0
        bra fs19f
fs19d:  cmp.b #97,d0
        bcs.s fs19e
        subi.b #$20,d0
fs19e:  cmp.b #48,d0
        bcs fswait
        cmp.b #58,d0
        bcs.s fs19i
        cmp.b #"_",d0
        beq.s fs19i
        cmp.b #65,d0
        bcs fswait
        cmp.b #91,d0
        bcc fswait
fs19i:  cmp #8,d1
        beq fswait
fs19f:  cmp #12,d1
        bcc fswait
        move.b d0,0(a1,d1.w)
        addq #1,d1
        move d1,fsd+16(a5)
        moveq #W_chrout,d7
        trap #3
        bra fswait
; dans le path
fs19p:  move.l name2(a5),a1
        move fsd+18(a5),d1
        cmp.b #8,d0
        bne.s fs19q
        tst d1
        beq fswait
        subq #1,d1
        move d1,fsd+18(a5)
        clr.b 0(a1,d1.w)
        lea fsr(pc),a0
        moveq #W_prtstring,d7
        trap #3
        bra fswait
fs19q:  cmp.b #97,d0
        bcs.s fs19r
        subi.b #32,d0
fs19r:  cmp.b #"*",d0
        beq.s fs19s
        cmp.b #".",d0
        beq.s fs19s
        cmp.b #"?",d0
        beq.s fs19s
        cmp.b #"_",d0
        beq.s fs19s
        cmp.b #48,d0
        bcs fswait
        cmp.b #58,d0
        bcs.s fs19s
        cmp.b #65,d0
        bcs fswait
        cmp.b #91,d0
        bcc fswait
fs19s:  cmp #12,d1
        bcc fswait
        move d1,d2
        add fsd+20(a5),d2
        cmp #60,d2
        bcc fswait
        move.b d0,0(a1,d1.w)
        addq #1,d1
        clr.b 0(a1,d1.w)
        move d1,fsd+18(a5)
        moveq #W_chrout,d7
        trap #3
        bra fswait

; TESTS DE LA SOURIS
fs19z:  tst fsd+6(a5)         ;pas de choix si rien en inverse!
        bmi fswait
        moveq #S_mousekey,d0
        trap #5             ;mousekey
        tst d0
        bne.s fs20
        clr fsd+8(a5)
        bra fswait
fs20:   tst fsd+8(a5)
        bne fswait
        move #1,fsd+8(a5)
        move fsd+6(a5),d1
        bne.s fs21
; HAUT
        cmp #1,d0
        bne.s fs20a
        moveq #1,d0
        clr fsd+8(a5)
        bra.s fs20b
fs20a:  moveq #13,d0
fs20b:  sub d0,fsd+2(a5)
        bcc.s fs20c
        clr fsd+2(a5)
fs20c:  bsr filesaff
        bra fswait

fs21:   cmp #1,d1
        bne fs22
; BAS
        cmp #1,d0
        bne.s fs21a
        moveq #1,d0
        clr fsd+8(a5)
        bra.s fs21b
fs21a:  moveq #13,d0
fs21b:  cmp #13,fsd(a5)
        bls fswait
        add fsd+2(a5),d0
        move d0,d1
        addi.w #13,d1
        cmp fsd(a5),d1
        bls fs21c
        move fsd(a5),d0
        subi.w #13,d0
fs21c:  move d0,fsd+2(a5)
        bsr filesaff
        bra fswait

fs22:   cmp #2,d1
        bne fs23
; PREVIOUS DIR
        move.l name1(a5),a0
        lea 2(a0),a1
fs22a:  tst.b (a0)+
        bne.s fs22a
        cmp.l a1,a0
        beq fswait
fs22b:  cmp.b #"\",-(a0)
        bne fs22b
fs22c:  cmp.b #"\",-(a0)
        bne.s fs22c
        clr.b 1(a0)
fs22d:  move.l name1(a5),-(sp)
        move.w #$3b,-(sp)
        trap #1
        addq.l #6,sp
        bsr pathaff
l558f:  jsr L_fillfile.l
        clr fsd+2(a5)
        bsr filesaff
        bra fswait

fs23:   cmp #3,d1
        bne fs24
; DIR
        bra fs22d

fs24:   cmp #4,d1
        bne fs25
; QUIT
fs24a:  moveq #13,d0
        moveq #W_delwindow,d7
        trap #3             ;efface la fenetre
l558z:  bsr ufz1            ;remet tout en route!
        move.l chvide(a5),-(a6)
        rts

fs25:   cmp #5,d1
        bne fs26
; RETURN
fs25c:  moveq #13,d0
        moveq #W_delwindow,d7
        trap #3
        moveq #12,d3
l558g:  jsr L_malloc.l
        addq.l #2,a0
        move.l fsname(a5),a2
        clr d1
fs25a:  move.b (a2)+,d0
        beq.s fs25b
        cmp.b #32,d0
        beq.s fs25a
        move.b d0,(a0)+
        addq #1,d1
        bra.s fs25a
fs25b:  move.w d1,(a1)
        movem.l a0-a1,-(sp) ;remet les sprites
        bsr ufz1
        movem.l (sp)+,a0-a1
        move.l a1,-(a6)
        move.w a0,d0
        btst #0,d0
        beq.s fs25q
        addq.l #1,a0
fs25q:  move.l a0,hichaine(a5)
        rts

fs26:   cmp #6,d1
        bne fs27
; LOCATE DANS LE NOM
fs26a:  bsr locnom
        bra fswait

fs27:   cmp #7,d1
        bne fs28
; LOCATE DANS LE PATH
fs27a:  bsr locpath
        bra fswait

fs28:   cmp #16,d1
        bcc fs29
; CHANGEMENT DE DRIVE
        subq #8,d1
        move d1,-(sp)
        move #10,-(sp)
        trap #13            ;drvmap
        addq.l #2,sp
        move (sp)+,d1
        clr d2
        clr d3
fs28a:  btst d3,d0
        beq.s fs28b
        cmp d2,d1
        beq.s fs28c
        addq #1,d2
fs28b:  addq #1,d3
        bra.s fs28a
fs28c:  move.w d3,-(sp)
        move.w #$e,-(sp)
        trap #1             ;setdrive
        addq.l #4,sp
        bsr drivaff         ;reaffiche les drives
        move.l name1(a5),a0        ;raz du path
        move.b #"\",(a0)+
        clr.b (a0)
        bra fs22d

; DANS LES FICHIERS
fs29:   subi.w #16,d1
        add fsd+2(a5),d1
        cmp fsd(a5),d1
        bcc fswait
        move d1,d0
        bsr adbufile
        cmp.b #"*",(a0)+
        bne fs29d
; met un sous directory
        move.l name1(a5),a1
        lea 63(a1),a3
fs29a:  tst.b (a1)+
        bne.s fs29a
        subq.l #1,a1
fs29b:  move.b (a0)+,d0
        beq.s fs29c
        cmp.b #32,d0
        beq.s fs29b
        move.b d0,(a1)+
        cmp.l a3,a1
        bcs.s fs29b
        bsr pathaff         ;si trop de ss directory: ignore!
        bra fswait
fs29c:  clr.b (a1)
        bra fs22d         ;branche a PREVIOUS
; prend un nom de fichier normal
fs29d:  clr fsd+16(a5)
        bsr locnom
        bsr fsnorm
        move.l fsname(a5),a1
        clr d1
        clr d2
        clr d3
fs29e:  move.b (a0)+,d0     ;recopie et compte la taille du nom
        addq #1,d1
        cmp.b #32,d0
        beq.s fs29f
        move d1,d2
fs29f:  cmp.b (a1),d0
        bne.s fs29g
        addq #1,d3
fs29g:  move.b d0,(a1)+
        cmp #12,d1
        bne.s fs29e
        clr.b (a1)
        move.w d2,fsd+16(a5)
        move.l fsname(a5),a0       ;reaffiche
        moveq #W_prtstring,d7
        trap #3
        bsr locnom          ;curseur a la fin du nom
        cmp #12,d3
        beq fs25c           ;si le meme nom: RETURN
        bra fswait

; Pitit ss pgm---> adresse dans le buffer
adbufile:
        mulu #20,d0
        move.l hichaine(a5),a0
        add d0,a0
        move.l a0,a1
        rts

; D1-> normal/inverse
norminv:tst d1
        bne.s fsinv
fsnorm: movem.l d0/d7/a0,-(sp)
        moveq #0,d7
        moveq #W_centre,d0
        trap #3
        movem.l (sp)+,d0/d7/a0
        rts
fsinv:  movem.l d0/d7/a0,-(sp)
        moveq #0,d7
        moveq #W_join,d0
        trap #3
        movem.l (sp)+,d0/d7/a0
        rts

; memorise le curseur
memocurs:
        movem.l d0/d7/a0,-(sp)
        moveq #W_chrout,d7
        moveq #20,d0
        trap #3
        moveq #W_coordcurs,d7
        trap #3
        move.l d0,fsd+10(a5)
        movem.l (sp)+,d0/d7/a0
        rts

; remet le curseur
remetcurs:
        movem.l d0/d7/a0,-(sp)
        move.l fsd+10(a5),d0
        move d0,d1
        swap d0
        moveq #W_locate,d7
        trap #3
        moveq #W_chrout,d7
        moveq #17,d0
        trap #3
        movem.l (sp)+,d0/d7/a0
        rts

; WRITEPOS: ECRIS UN MOT (a0) EN D0/D1 ET STOCKE DANS LA TABLE SOURIS (D2)
writepos:
        movem.l d0-d7/a0-a2,-(sp)
        lsl #3,d2
        move.l defloat(a5),a2
        lea 16(a2),a2           ;fsmouse
        add d2,a2
        move.l a0,a1
        move d0,d2
        moveq #W_locate,d7
        trap #3             ;locate
        move d2,d0
        moveq #W_xgraphic,d7
        trap #3
        move d0,(a2)+       ;fixe DX
        move d1,d0
        moveq #W_ygraphic,d7
        trap #3
        move d0,(a2)+       ;fixe DY
        move.l a1,a0
        moveq #W_prtstring,d7
        trap #3             ;imprime le mot
        moveq #W_coordcurs,d7
        trap #3
        move d0,d1
        swap d0
        moveq #W_xgraphic,d7
        trap #3
        move d0,(a2)+       ;fixe FX
        move d1,d0
        moveq #W_ygraphic,d7
        trap #3
        cmp #2,mode(a5)
        bne.s wrtp1
        addq #8,d0
wrtp1:  addq #8,d0
        move d0,(a2)+
        movem.l (sp)+,d0-d7/a0-a2
        rts

; WRITEXT: ECRIS LA PHRASE #D0, D1-INVERSE/NORMAL
writext:movem.l d0-d2/a0-a2,-(sp)
        bsr norminv
        move d0,d2
        lsl #3,d0
        lea fstext(pc),a1
        add d0,a1
        lea fst(pc),a0
        add.l (a1)+,a0
        cmp #6,d2
        bcc.s wt3
l558h:  jsr L_traduit.l
wt3:    move.w (a1)+,d0
        move.w (a1)+,d1
        bsr writepos
        movem.l (sp)+,d0-d2/a0-a2
        rts

; TROUVE ET AFFICHE LE PATHNAME
pathaff:bsr memocurs
        moveq #7,d0
        clr d1
        bsr writext
        lea 7*8+fstext(pc),a0
        move.w 4(a0),d0     ;locate
        move.w 6(a0),d1
        moveq #W_locate,d7
        trap #3
l558i:  jsr L_getdrive2.l             ;cherche le disque courant
        addq.l #4,a6
        move.l name1(a5),a0
        addi.b #65,d3
        move.b d3,(a0)+
        move.b #":",(a0)+
        clr.w -(sp)         ;cherche le path courant
        move.l a0,-(sp)
        move.w #$47,-(sp)
        trap #1
        addq.l #8,sp
        move.l name1(a5),a0        ;affiche le path
        move.l a0,a1
ph1:    tst.b (a1)+
        bne.s ph1
        move.b #"\",-1(a1)
        clr.b (a1)
        moveq #W_prtstring,d7
        trap #3
        move.l name2(a5),a0     ;affiche le filtre
        trap #3
        bsr remetcurs
        tst fsd+14(a5)        ;reloge le curseur si dans le path!
        beq.s ph2
        bsr locpath
ph2:    rts

; AFFICHE LES DRIVES
drivaff:bsr memocurs
        movem.l d0-d7/a0-a2,-(sp)
        move.w #10,-(sp)
        trap #13            ;DRVMAP
        addq.l #2,sp
        move.l d0,d6
        move #$19,-(sp)
        trap #1             ;CURRENT DISK
        addq.l #2,sp
        move d0,d5
        clr d4              ;compteur 0-7: # du carre
da0:    clr d2
        clr d3
da1:    btst d3,d6
        beq.s da2
        cmp d2,d4
        beq.s da3
        addq #1,d2
da2:    addq #1,d3
        cmp #26,d3
        bcs.s da1
        bra da10
da3:    lea fsdriv(pc),a2
        move d4,d0
        lsl #2,d0
        add d0,a2
        move 0(a2),d0
        move 2(a2),d1
        moveq #W_locate,d7
        trap #3             ;locate
        bsr fsnorm
        move fsd+22(a5),d0
        moveq #3,d1
        moveq #3,d2
        moveq #W_box,d7
        trap #3             ;cadre
        moveq #0,d1
        cmp d3,d5
        bne.s da4
        moveq #1,d1
da4:    bsr norminv         ;normal/inverse
        move 0(a2),d0
        move 2(a2),d1
        addq #1,d0
        addq #1,d1
        move d4,d2
        addq.w #8,d2           ;drives: 8--->15
        addi.w #65,d3
        move.l defloat(a5),a0
        move.b d3,(a0)
        clr.b 1(a0)
        bsr writepos        ;ecris et stocke
da10:   addq #1,d4
        cmp #8,d4
        bcs da0
        clr fsd+4(a5)
        movem.l (sp)+,d0-d7/a0-a2
        bsr remetcurs
        rts

; AFFICHE LE NOM FICHIER d0 EN INVERSE/NORMAL d1
fileaff:movem.l d0-d2/a0-a1,-(sp)
        bsr norminv
        move d0,d1
        bsr adbufile
        sub fsd+2(a5),d1
        move d1,d2
        addq #3,d1          ;locate
        moveq #1,d0
        addi.w #16,d2          ;table: 16--->29
        bsr writepos
        movem.l (sp)+,d0-d2/a0-a1
        rts

; AFFICHE TOUS LES NOMS DE FICHIER DANS LA FENETRE
filesaff:
        bsr memocurs
        move fsd+2(a5),d0
        moveq #12,d2
        clr d1
fa1:    bsr fileaff
        addq #1,d0
        dbra d2,fa1
        bsr remetcurs
        rts

; locate dans le nom
locnom: movem.l d0/d1/d7/a0,-(sp)
        lea 6*8+fstext(pc),a0
        move.w 4(a0),d0
        add fsd+16(a5),d0
        move.w 6(a0),d1
        moveq #W_locate,d7
        trap #3
        clr fsd+14(a5)
        movem.l (sp)+,d0/d1/d7/a0
        rts

; locate dans le path
locpath:movem.l d0/d1/d7/a0/a1,-(sp)
        move.l name1(a5),a0
lp1:    tst.b (a0)+
        bne.s lp1
        sub.l name1(a5),a0
        subq.l #1,a0
        move a0,fsd+20(a5)
        lea 7*8+fstext(pc),a1
        move.w 4(a1),d0
        add.w a0,d0
        add.w fsd+18(a5),d0
        clr d1
        cmp.w #32,d0        ;sur la deuxieme ligne?
        bcs.s lp2
        moveq #1,d1
        subi.w #32,d0
lp2:    add.w 6(a1),d1
        moveq #W_locate,d7
        trap #3
        move #1,fsd+14(a5)
        movem.l (sp)+,d0/d1/d7/a0/a1
        rts

; FREEZE
fz1:    moveq #1,d2
        moveq #S_movesonoff,d0
        trap #5
        moveq #S_animsonoff,d0
        trap #5
        rts
; UNFREEZE
ufz1:   moveq #2,d2
        moveq #S_movesonoff,d0
        trap #5
        moveq #S_animsonoff,d0
        trap #5
        rts

;FILE SELECTOR
fswind: dc.w 1,3,2,34,21
        dc.w 2,23,2,34,21
        dc.w 3,23,2,34,21
fst:    dc.b "FILE SELECTOR",0
        dc.b "SELECTEUR DE FICHIER",0
fst1:   dc.b "     UP     ",0
        dc.b "    HAUT    ",0
fst2:   dc.b "    DOWN    ",0
        dc.b "    BAS     ",0
fst3:   dc.b "PREVIOUS",0
        dc.b "ARRIERE ",0
fst4:   dc.b "  DIR.  ",0
        dc.b "  DIR.  ",0
fst5:   dc.b "  QUIT  ",0
        dc.b "QUITTER ",0
fst6:   dc.b " RETURN ",0
        dc.b "   OK   ",0
fst7:   dc.b "            ",0
fst8:   dc.b "                                "
        dc.b "                               ",0
fsr:    dc.b 3,32,3,0
        even
fsc:    dc.w 0,2,16,15
        dc.w 16,2,10,3
        dc.w 16,5,10,3
        dc.w 16,8,10,3
        dc.w 16,11,10,3
        dc.w 16,14,16,3
fstext: dc.l fst1-fst
        dc.w 2,2
        dc.l fst2-fst
        dc.w 2,16
        dc.l fst3-fst
        dc.w 17,3
        dc.l fst4-fst
        dc.w 17,6
        dc.l fst5-fst
        dc.w 17,9
        dc.l fst6-fst
        dc.w 17,12
        dc.l fst7-fst
        dc.w 18,15
        dc.l fst8-fst
        dc.w 0,17
fsdriv: dc.w 26,2,29,2
        dc.w 26,5,29,5
        dc.w 26,8,29,8
        dc.w 26,11,29,11

*************************************************************************
*       SS PGM QACTIVE
L559:   dc.w 0
***********************
        move d0,-(sp)
        moveq #W_getcurwindow,d7
        trap #3
        move d0,mnd+32(a5)
        move (sp)+,d0
        moveq #W_qwindon,d7
        trap #3
        rts

*************************************************************************
*       REACTIVATION DE L'ANCIENNE FENETRE
L560:   dc.w 0
***********************
        move mnd+32(a5),d0
        moveq #W_qwindon,d7
        trap #3
        rts

*************************************************************************
*       AFFCHOIX: DISPLAY AN ITEM FROM THE MENU BAR (D3)
L561:   dc.w 0
***********************
        movem.l d0-d3/a0-a3,-(sp)
        move d3,d0
        mulu #25*16+22,d0
        add d0,a3               ;pointe le menu!
        bsr mii2                 ;met pen/paper/inverse
        clr d0
        lea mnd+34(a5),a0
        lsl #1,d3
        beq.s ac1
        move.w -2(a0,d3.w),d0
ac1:    move.w 0(a0,d3.w),d2    ;taille de la chaine!
        sub d0,d2
        beq ac10
        move d0,-(sp)
        tst mnd+10(a5)
        beq.s ac3
; deux lignes de titre!
        moveq #1,d1
        moveq #W_locate,d7
        trap #3             ;locate!
        move d2,d0
        subq #1,d0
        move.l buffer(a5),a0
ac2:    move.b #32,(a0)+    ;que des 32
        dbra d0,ac2
        clr.b (a0)+
        moveq #31,d0
        move.w #W_chrout,d7              ;souligne
        trap #3
        move.l buffer(a5),a0
        moveq #W_prtstring,d7
        trap #3             ;affiche la ligne du bas, soulignee
        moveq #29,d0
        move.w #W_chrout,d7              ;desouligne
        trap #3
        bra ac4
; une seule ligne dans la barre
ac3:    moveq #31,d0
        move.w #W_chrout,d7              ;souligne
        trap #3
ac4:    move (sp)+,d0
        moveq #0,d1
        moveq #W_locate,d7
        trap #3             ;locate
        move.l buffer(a5),a0
        subq #1,d2
ac5:    move.b (a3)+,(a0)+
        dbra d2,ac5
        clr.b (a0)
        move.l buffer(a5),a0
        moveq #W_prtstring,d7
        trap #3
ac10:   movem.l (sp)+,d0-d3/a0-a3
        rts
; Met shade..
mii2:   clr d0
        move.b (a3)+,d0
        moveq #W_setpaper,d7         ;SET PAPER
        trap #3
        clr d0
        move.b (a3)+,d0
        moveq #W_setpen,d7         ;SET PEN
        trap #3
        tst d2
        beq.s mii3
        moveq #21,d0        ;inverse on
        bra.s mii4
mii3:   moveq #18,d0        ;inverse off
mii4:   move.w #W_chrout,d7
        trap #3
        rts

*************************************************************************
*       AFFBARRE
L562:   dc.w l562a-L562,l562b-L562,l562c-L562,l562d-L562
        dc.w l562e-L562,0
***********************
        tst.w mnd+14(a5)
        beq ab13
        moveq #15,d3
l562a:  jsr L_adbank.l
        cmp.l #$03008000,d0
        bne ab13
        move.l a1,-(sp)
        clr mnd+4(a5)
        moveq #9,d0
        moveq #40,d1
        move #8,mnd+8(a5)    ;hauteur des tests de la souris
        move mode(a5),d7
        cmp #2,d7
        bne.s ab0
        move #16,mnd+8(a5)
ab0:    tst d7
        beq.s ab1
        lsl #1,d1           ;d1= nombre de lettres en largeur
ab1:    lea mnd+66(a5),a2     ;coordonnees reelle/souris
        lea mnd+34(a5),a3     ;coordonnees texte dans la barre
        moveq #9,d0
ab2:    clr.w (a2)+         ;nettoie les tables
        clr.w (a3)+
        dbra d0,ab2
        lea mnd+66(a5),a3
        lea mnd+34(a5),a2
        clr d2
        clr d3
        clr d5              ;mnd+10 recherche!
        moveq #9,d0
ab3:    tst.b 2(a1)         ;fini!
        beq ab6a
        clr d4
ab4:    cmp.b #27,2(a1,d4.w)
        bne.s ab4a
        moveq #1,d5
ab4a:   addq #1,d2
        addq #8,d3
        cmp d1,d2           ;trop loin a droite?
        bcc.s ab6
        addq #1,d4
        cmp #20,d4          ;fin de la chaine?
        beq.s ab5
        tst.b 2(a1,d4.w)
        bne.s ab4
ab5:    move.w d2,(a2)+     ;poke les coordonnees
        move.w d3,(a3)+
        add #422,a1
        dbra d0,ab3
        bra.s ab6a
ab6:    move.w d2,(a2)+
        move.w d3,(a3)+
; mode 2
ab6a:   cmp #2,mode(a5)
        bne ab7             ;en mode 2: toujours UNE SEULE LIGNE!
        moveq #0,d5
        move #16,mnd+8(a5)
        tst mnd+12(a5)
        beq.s ab8
        bne.s ab9
; mode 0/1
ab7:    move #8,d0
        move d0,mnd+8(a5)
        mulu d5,d0
        add d0,mnd+8(a5)
        tst mnd+12(a5)
        beq.s ab8
        cmp mnd+10(a5),d5
        beq.s ab9
; change l'ecran
ab8:    move #1,mnd+12(a5)     ;va effacer l'ecran, revient ici
        move d5,mnd+10(a5)    ;affiche le menu, et fini mode!
        addq.l #4,sp        ;raz pile
l562b:  jmp L_modebis.l         ;OUCH!
; ne change pas l'ecran
ab9:    moveq #15,d0
l562c:  jsr L_qactive.l         ;active la fenetre de menus
; prepare la fenetre
        move mnd+30(a5),d0   ;set paper
        moveq #W_setpaper,d7
        trap #3
        move mnd+28(a5),d0     ;set pen
        moveq #W_setpen,d7
        trap #3
        moveq #18,d0
        moveq #W_chrout,d7            ;pas en inverse!
        trap #3
        moveq #12,d0        ;cls
        moveq #W_chrout,d7
        trap #3
; souligne la ligne du menu, sur toute la largeur
        move.l buffer(a5),a0
        moveq #39,d0
        tst mode(a5)
        beq.s ab9a
        lsl #1,d0
        addq #1,d0
ab9a:   move.b #32,(a0)+
        dbra d0,ab9a
        clr.b (a0)
        moveq #31,d0        ;SOULIGNE
        move.w #W_chrout,d7
        trap #3
        tst mnd+10(a5)
        beq.s ab9b
        moveq #0,d0
        moveq #1,d1
        moveq #W_locate,d7
        trap #3             ;si DEUX LIGNES: souligne la ligne du bas!
ab9b:   move.l buffer(a5),a0
        moveq #W_prtstring,d7
        trap #3
        moveq #29,d0        ;DESOULIGNE
        move.w #W_chrout,d7
        trap #3
; affiche tous les choix
        move.l (sp)+,a3     ;adresse de la banque
        clr d3
        lea mnd+34(a5),a0
ab10:   tst.w (a0)+
        beq.s ab12
        clr d2              ;pas en inverse!
l562d:  jsr L_affchoix.l
ab11:   addq #1,d3
        cmp #10,d3
        bcs.s ab10
; reactive l'ancienne fenetre
ab12:
l562e:  jsr L_qreactive.l
ab13:   rts

*************************************************************************
*       RES15? RESERVE LA BANQUE DES MENU?
L563:   dc.w l563a-L563,l563b-L563,l563c-L563,l563d-L563,l563e-L563
        dc.w l563f-L563,0
*********************************************************************
        move.w d0,-(sp)
        tst mnd+14(a5)
        bne.s mn1
; reserve la banque 15 pour les menus
        moveq #15,d3
l563a:  jsr L_adbank.l                    ;deja reservee???
        bne.s l563mr
        move.l #$8000,d3              ;prend 32000 octets
l563b:  jsr L_malloc.l
        move.l #$8000,d3              ;longueur a reservee
        moveq #$3,d1                  ;flag MENUS
        moveq #15,d2                  ;numero de la banque
l563c:  jsr L_reservin.l
l563d:  jsr L_resbis.l
        moveq #15,d3
l563e:  jsr L_adbank.l
        move.w #8000-1,d2
mnf:    clr.l (a1)+
        dbra d2,mnf
        move #1,mnd+14(a5)              ;met le flag a un!
mn1:    moveq #15,d3
l563f:  jsr L_adbank.l
        cmp.l #$03008000,d0
        bne.s l563nd
        move.w (sp)+,d7
        move.w d7,d0
        lsl.w #2,d0
        add.l d0,a6
        move.l a6,a3
        rts
l563nd: moveq #E_menu_def,d0
        bra.s l563go
l563mr: moveq #E_bank15_reserved,d0
l563go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MENU$(XX)=a$,pen,pap
L564:   dc.w l564a-L564,0
**************************
l564a:  jsr L_menu.l
        clr mnd(a5)
        move #1,mnd+4(a5)
        move.l (a6)+,d1
        subq.l #1,d1
        bcs.s l564fc
        cmp.l #10,d1                  ;pas plus de DIX!
        bcc.s l564fc
        mulu #422,d1
        add d1,a1                     ;pointe la chaine
        move.l a1,-(sp)
        move.w valpaper(a5),d0
        move.w valpen(a5),d1
        move.b d0,(a1)+               ;paper et pen par defaut!
        move.b d1,(a1)+
        moveq #19,d0
mn2:    clr.b (a1)+                   ;RAZ de la chaine
        dbra d0,mn2
        move.l -(a3),a2
        move.w (a2)+,d2
        move.l (sp),a1
        addq.l #2,a1
        tst d2
        beq.s mn4
        moveq #19,d0
mn3:    move.b (a2)+,(a1)+            ;copie la chaine, 20 car max!
        subq #1,d2
        beq.s mn4
        dbra d0,mn3
mn4:    move.l (sp)+,a1
        subq.w #1,d7
        beq.s mn5
        move.l -(a3),d1
        move.l -(a3),d2
        cmp.l colmax(a5),d1
        bcc.s l564fc
        cmp.l colmax(a5),d2
        bcc.s l564fc
        move.b d1,(a1)+               ;paper
        move.b d2,(a1)+               ;et pen!
mn5:    rts
l564fc: moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MENU$(xx,yy) /  prend les params
L565:   dc.w l565a-L565,0
***********************
l565a:  jsr L_menu.l
        move.l (a6)+,d2
        move.l (a6)+,d1
        subq.l #1,d1
        bcs.s l565fc
        cmp.l #10,d1                  ;pas plus de 10!
        bcc.s l565fc
        mulu #422,d1
        addi.w #22,d1
        add d1,a1                     ;pointe le groupe de menu
        subq.l #1,d2
        bcs.s l565fc
        cmp.l #16,d2                  ;pas plus de 16 choix!
        bcc.s l565fc
        mulu #25,d2
        add d2,a1                     ;pointe le bon endroit!
        rts
l565fc: moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MENU$(XX,yy)=a$,p,p
L566:   dc.w l566a-L566,0
***********************
l566a:  jsr L_setmenu2.l
        move.l a1,-(sp)
        clr.b (a1)+         ;position enY
        clr.b (a1)+         ;taille en Y par defaut: UN
        move.b #1,(a1)+     ;active par defaut
        move.w valpaper(a5),d0
        move.w valpen(a5),d1
        move.b d0,(a1)+     ;paper
        move.b d1,(a1)+     ;pen
        moveq #19,d0
mn11:   clr.b (a1)+                   ;nettoie la chaine
        dbra d0,mn11
        move.l -(a3),a2
        move.w (a2)+,d2
        move.l (sp),a1
        lea 1(a1),a0                  ;pointe la taille ligne!
        addq.l #5,a1
        tst d2
        beq.s mn14
        moveq #19,d0
mn12:   move.b (a2)+,d1
        move.b d1,(a1)+
        cmp.b #27,d1                  ;si icones: taille ligne = 2!
        bne.s mn13
        cmp #2,mode(a5)                   ;et si mode <> 2!
        beq.s mn13
        move.b #1,(a0)
mn13:   subq #1,d2
        beq.s mn14
        dbra d0,mn12
mn14:   addq.l #3,(sp)
        move.l (sp)+,a1
        subq.w #1,d7
        beq.s mn15
        move.l -(a3),d1
        move.l -(a3),d2
        cmp.l colmax(a5),d1
        bcc.s l566fc
        cmp.l colmax(a5),d2
        bcc.s l566fc
        move.b d1,(a1)+               ;paper
        move.b d2,(a1)+               ;et pen!
mn15:   rts
l566fc: moveq #E_illegalfunc,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       menu$(xx,yy) OFF
L567:   dc.w l567a-L567,0
***********************
l567a:  jsr L_setmenu2.l
        clr.b 2(a1)                   ;arrete!
        rts

*************************************************************************
*       menu$(xx,yy) ON
L568:   dc.w l568a-L568,0
***********************
l568a:  jsr L_setmenu2.l
        move.b #1,2(a1)               ;met en route!
        rts

*************************************************************************
*       MENU OFF
L569:   dc.w l569a-L569,l569b-L569,l569c-L569,0
************************************************
        clr mnd(a5)
        clr mnd+2(a5)
        clr mnd+18(a5)
        clr mnd+20(a5)
        tst mnd+14(a5)
        beq.s mf1
        clr mnd+14(a5)
        moveq #15,d3
l569a:  jsr L_effbank.l             ;va effacer, bouge toutes le variables
        bne.s mf1
l569b:  jsr L_resbis.l
mf1:    tst mnd+12(a5)
        beq.s mf2
        clr mnd+12(a5)
l569c:  jsr L_modebis.l         ;reaffiche tout l'ecran!
mf2:    rts                 ;c'est fini!

*************************************************************************
*       MENU FREEZE
L570:   dc.w 0
***********************
        tst mnd+14(a5)
        beq.s l570nd
        move mnd(a5),mnd+2(a5)
        clr mnd(a5)
        rts
l570nd: moveq #E_menu_def,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MENU ON paper/pen
L571:   dc.w l571a-L571,l571b-L571,0
*************************************
        move.w d0,-(sp)
; mise en route du menu!
        tst mnd+12(a5)         ;barre en route?
        beq.s mo0
        tst mnd(a5)            ;menus en marche
        bne.s mo0
        tst mnd+4(a5)
        bne.s mo0
        tst.w (sp)
        bne.s mo0
        move mnd+2(a5),d0
        beq.s mo0
        move d0,mnd(a5)
        addq.l #2,sp
        rts
mo0:    tst mnd+14(a5)
        beq.s l571nd
        moveq #15,d3
l571a:  jsr L_adbank.l
        cmp.l #$03008000,d0
        bne.s l571nd
        move #2,mnd+26(a5)
        move.w valpaper(a5),d0
        move.w valpen(a5),d1
        move d0,mnd+30(a5)
        move d1,mnd+28(a5)
        move.w (sp)+,d0
        move.w #-1,-(sp)
; MENU ON TOUR,AUTO (-1 laisse les memes)
        tst.w d0
        beq.s mo2
        cmp.w #1,d0
        beq.s mo1
        move.l (a6)+,d0
        bmi.s mo1
        cmp.l #1,d0
        beq.s mo1
        move.w #1,(sp)
mo1:    move.l (a6)+,d3
        bmi.s mo2
        beq.s l571fc
        cmp.l #16,d3
        bhi.s l571fc
        move.w d3,mnd+26(a5)
; calcul de la barre de menu, et des coordonnees
mo2:
l571b:  jsr L_affbarre.l        ;va afficher la barre de menu!
        move (sp)+,mnd(a5)  ;menus actives!
        rts
l571fc: moveq #E_illegalfunc,d0
        bra.s l571go
l571nd: moveq #E_menu_def,d0
l571go: move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       MENUS MANAGEMENT
L572:   dc.w l572a-L572,l572b-L572,l572c-L572,l572d-L572
        dc.w l572e-L572,l572f-L572,l572g-L572,0
**********************************************
menuin: move d1,mnd+16(a5)
        bsr fzm             ;va arreter les sprites
        moveq #15,d0
l572a:  jsr L_qactive.l         ;active la fenetre des menus
        moveq #15,d3
l572b:  jsr L_adbank.l      ;adresse de la banque!
        cmp.l #$03008000,d0
        beq mt7a
l572c:  jsr L_qreactive.l       ;reactive et revient
        bra finmenu
mt7a:   move.l a1,a3        ;a3= adresse de la banque de menus
; sauve le decor!
        add.l #4220,a1      ;skip menu data
        move #6999,d0       ;do not copy the whole screen!
        move.l adback(a5),a0
mt8:    move.l (a0)+,(a1)+  ;recopie le decor dans la banque!
        dbra d0,mt8
; affiche en inverse le choix de la barre
        move mnd+16(a5),d3    ;d3= # du choix a afficher
        moveq #1,d2         ;en mode inverse!
l572d:  jsr L_affchoix.l        ;va l'afficher!

; PREPARE LES PARAMETRES
        move mnd+16(a5),d0
        mulu #25*16+22,d0
        addi.w #22,d0          ;saute le titre
        add d0,a3           ;pointe l'arbre dans la banque
        move.l a3,a2
        move.l defloat(a5),a1
        lea 4(a1),a1            ;ou mettre l'arbre de tests!
        clr d3              ;numero du choix
        moveq #8,d6         ;taille d'un caractere en hauteur!
        cmp #2,mode(a5)
        bne.s mt12
        lsl #1,d6
mt12:   move d6,d7
        mulu #2,d7          ;debut de la zone graphique
        clr.w d5            ;debut de la zone texte
        clr.w d4            ;taille maxi en X
mt13:   tst.b 5(a2)
        beq mt16
; situe le souschoix en Y
        move.b d5,0(a2)     ;debut en Y
        clr d0
        move.b 1(a2),d0
        addq #1,d0          ;taille = 0 ou 1!
        add d0,d5           ;debut de la zone suivante
        cmp #16,d5          ;pas plus de 16 lignes !!!
        bhi mt16
        move d7,(a1)+       ;debut graphique en Y
        mulu d6,d0
        add d0,d7
        move d7,(a1)+       ;fin a tester pour cette zone/debut suivant
        tst.b 2(a2)
        bne mt13a
        move #800,-4(a1)    ;zone inactive!
        move #900,-2(a1)
; trouve la largeur maxi
mt13a:  move.l a2,a0
        addq.l #5,a0
        moveq #19,d0
        clr d1
mt14:   tst.b (a0)+
        beq mt14a
        addq #1,d1
        dbra d0,mt14
mt14a:  cmp d1,d4
        bcc mt15
        move d1,d4
; passe au suivant
mt15:   add.w #25,a2
        addq #1,d3
        cmp #16,d3
        bcs mt13
mt16:   clr.l (a1)          ;fin des tests!
        move d4,mnd+22(a5)      ;taille maxi en X
        move d3,mnd+24(a5)
        beq mt41          ;pas de rubrique !!!

; FAIT APPARAITRE LA FENETRE DE SOUS MENU
        moveq #W_autobackoff,d7
        trap #3             ;autoback OFF: ca va plus vite!
        addq #2,d4          ;TX
        addq #2,d5          ;TY
        clr d2
        move mnd+16(a5),d0
        lsl #1,d0           ;dx text= 0: a gauche, on ne change rien
        beq mt21
        lea mnd+34(a5),a0
        move.w -2(a0,d0.w),d2
        move d4,d1
        add d2,d1
        move #40,d7
        tst mode(a5)
        beq.s mt20
        lsl #1,d7
mt20:   cmp d7,d1           ;ca sort?
        bls.s mt21
        move d7,d2          ;oui: on recentre!
        sub d4,d2
mt21:   moveq #1,d3         ;DY text
        move mnd+26(a5),d1
        swap d1
        move mode(a5),d1
        addq #1,d1          ;jeux de caractere MODE + 1
        move mnd+28(a5),d6
        swap d6
        move mnd+30(a5),d6
        move.l defloat(a5),a0
        move d2,d0
        addq #1,d0           ;saute la bordure
        lsl #3,d0
        move d0,(a0)         ;DX pour la souris
        move d0,2(a0)
        move d4,d0
        subq #1,d0           ;saute aussi la bordure!
        lsl #3,d0
        add d0,2(a0)         ;FX pour la souris
        moveq #14,d0
        moveq #W_initwind,d7
        trap #3
        moveq #W_chrout,d7
        moveq #25,d0
        trap #3              ;scroll off!
        moveq #20,d0
        trap #3              ;arret du curseur!
; affiche le texte
        clr d2
        clr d3
mt23:   bsr affsschx
        addq #1,d3
        cmp mnd+24(a5),d3
        bne.s mt23
        moveq #W_autobackrest,d7        ;remet l'ancien autoback, (reaffiche les sprites)
        trap #3

; TESTS DE LA SOURIS!!!
        clr d2              ;flag: rien d'affiche en inverse!
        move #-1,d3         ;dernier choisi!
; teste quand meme les interruptions! C'EST GENIAL!
mt30:   move.l adm(a5),a6
; tests de la souris!
mt30b:  tst mnd(a5)
        bpl.s mt30e
; AUTOMATIQUE!
        move mnd+8(a5),d0
        cmp 2(a6),d0
        bcs.s mt30e           ;compare en Y
        lea mnd+66(a5),a0     ;dans la barre: trouve le choix en X
        move (a6),d0
        clr d1
mt30c:  tst (a0)
        beq.s mt30e
        cmp (a0),d0
        bcs.s mt30d
        addq.l #2,a0
        addq #1,d1
        cmp #10,d1
        bne.s mt30c
        bra mt30e
mt30d:  cmp mnd+16(a5),d1     ;change de zone?
        beq.s mt30e
        bsr effmenus
        movem.l (sp)+,d0-d7/a0-a6
        bra remenu           ;va tout effacer et revient a MENUTEST
; MANUEL! ou automatique pour arreter les menus...
mt30e:  btst #0,7(a6)
        beq mt31
        tst mnd+6(a5)
        bne.s mt31a
        bra mt40
; affiche en inverse le sous-choix
mt31:   clr mnd+6(a5)
mt31a:  move.l defloat(a5),a0
        move (a6),d0
        cmp (a0)+,d0        ;trop a gauche
        bcs mt36
        cmp (a0)+,d0        ;trop a droite
        bhi mt36
        move 2(a6),d0
        clr d1
mt32:   tst.l (a0)          ;pas a l'interieur!
        beq mt36
        cmp (a0),d0         ;a l'interieur des limites?
        bcs.s mt33
        cmp 2(a0),d0
        bcs.s mt34
mt33:   addq.l #4,a0
        addq #1,d1
        bra.s mt32
; affiche en inverse!
mt34:   cmp d1,d3
        beq.s mt35
        tst d3              ;si pas de choix avant: rien a faire!
        bmi.s mt35
        clr d2
        bsr affsschx        ;reaffiche en NORMAL!
mt35:   tst d2              ;si deja en inverse, pas la peine!
        bne mt30
        move d1,d3
        moveq #1,d2
        bsr affsschx        ;affiche en inverse!
        bra mt30
; pas a l'interieur: efface le choix inverse!
mt36:   tst d2
        beq.s mt37
        clr d2
        bsr affsschx
mt37:   moveq #-1,d3        ;plus de choix
        bra mt30

; FIN DES MENUS OUF!
mt40:   btst #0,7(a6)       ;attend qu'on relache!
        bne.s mt40
        tst d3
        bmi mt41
        move mnd+16(a5),d0
        addq #1,d0
        move d0,mnd+18(a5)   ;SI UN CHOIX: change les variables!!!
        addq #1,d3
        move d3,mnd+20(a5)
; teste si ON MENU GOTO
        tst mnd+98(a5)         ;branchemt ?
        beq.s mt41
        bmi.s mt41
        lea 68(sp),a3
        cmp.l lowpile(a5),a3   ;vient du programme ?
        bne.s mt41
        subq #1,d0
        lsl #2,d0
        lea mnd+100(a5),a0
        tst.l 0(a0,d0.w)
        beq.s mt41
        lea cretin(pc),a1
        move.l 0(a0,d0.w),(a1)
        bsr effmenus
        bset #7,mnd+98(a5)     ;empeche les appels en boucle
        movem.l (sp)+,d0-d7/a0-a6
        move.l cretin(pc),(sp)
        rts
mt41:   bsr effmenus
finmenu:movem.l (sp)+,d0-d7/a0-a6
        rts
cretin: dc.l 0

; RE-TEST DES MENUS (DESOLE)
remenu: tst mnd(a5)         ;menu en route?
        bne.s rmt1
        rts
rmt1:   bmi.s rmt4           ;menu automatique ???
; manuel
        move.l a0,-(sp)
        move.l adm(a5),a0
        btst #0,7(a0)       ;touche appuyee?
        bne.s rmt2
        clr mnd+6(a5)
        move.l (sp)+,a0
        rts
rmt2:   move.l (sp)+,a0
        tst mnd+6(a5)         ;pas de rebond?
        beq.s rmt3
        rts
rmt3:   move #1,mnd+6(a5)     ;dans la barre?
; automatique
rmt4:   movem.l d0-d7/a0-a6,-(sp)
        move.l adm(a5),a6
        move mnd+8(a5),d0
        cmp 2(a6),d0
        bcs.s finrm           ;compare en Y
        lea mnd+66(a5),a0     ;trouve le choix en X
        move (a6),d0
        clr d1
rmt6:   tst (a0)
        beq.s finrm
        cmp (a0),d0
        bcs menuin
        addq.l #2,a0
        addq #1,d1
        cmp #10,d1
        bne.s rmt6
finrm:  movem.l (sp)+,d0-d7/a0-a6
        rts

; EFFACE LES MENUS
effmenus:
        moveq #14,d0        ;effacemt rapide de la fenetre
        moveq #W_currwindow,d7
        trap #3
        moveq #W_qwindon,d7        ;activation rapide de la barre
        moveq #15,d0
        trap #3
        moveq #15,d3
l572e:  jsr L_adbank.l          ;adresse de la banque
        move.l a1,a3
        clr.l d2            ;efface le nom en inverse
        move mnd+16(a5),d3
l572f:  jsr L_affchoix.l
; recopie l'ecran!
        add.l #4220,a1
        move.l a1,a2
        move.l adback(a5),a0
        move #6999,d0
mt43:   move.l (a1)+,(a0)+  ;recopie dans le decor
        dbra d0,mt43
        move #6999,d0
        move.l adlogic(a5),a0
mt44:   move.l (a2)+,(a0)+  ;recopie dans l'ecran logique
        dbra d0,mt44
l572g:  jsr L_qreactive.l       ;reactive la fenetre pleine page!
        bsr ufzm            ;remet les sprites
        clr mnd+6(a5)
        rts

; AFFSSCHX: AFFICHE UN SOUS CHOIX (D3) DANS LA FENETRE!
affsschx:
        movem.l d0-d3/a0-a3,-(sp)
        mulu #25,d3
        add d3,a3
        clr d1
        clr d3
        move.b (a3)+,d1     ;depart en Y
        move.b (a3)+,d3     ;taille en Y
        movem d1/d3,-(sp)
        bsr menuinv         ;met SHADE/PEN/PAPER
        move.l buffer(a5),a0
        move mnd+22(a5),d0
        subq #1,d0
as1:    move.b #32,(a0)+    ;nettoie le buffer d'affichage
        dbra d0,as1
        clr.b (a0)
        movem (sp)+,d1-d2
        clr d0
; affiche sur plusieurs lignes
as2:    movem d0-d2,-(sp)
        add d2,d1
        moveq #W_locate,d7         ;locate
        trap #3
        tst d2              ;derniere ligne!
        beq.s as3
        move.l buffer(a5),a0
        moveq #W_prtstring,d7
        trap #3
        movem (sp)+,d0-d2
        subq #1,d2          ;remonte d'une ligne
        bra.s as2
as3:    movem (sp)+,d0-d2
        move.l buffer(a5),a0
as4:    move.b (a3)+,d1     ;poke le nom
        beq.s as5
        tst.b (a0)
        beq.s as5
        move.b d1,(a0)+
        bra.s as4
as5:    moveq #W_prtstring,d7
        move.l buffer(a5),a0
        trap #3
        movem.l (sp)+,d0-d3/a0-a3
        rts

; SSPGM: MET SHADE/PEN/PAPER/INVERSE, retour A3 pointe la chaine!!!
menuinv:tst.b (a3)+
        bne.s miv0
        moveq #22,d0
        bra.s miv1
miv0:   moveq #19,d0
miv1:   move.w #W_chrout,d7
        trap #3             ;SHADE ON/OFF
miv2:   clr d0
        move.b (a3)+,d0
        moveq #W_setpaper,d7         ;SET PAPER
        trap #3
        clr d0
        move.b (a3)+,d0
        moveq #W_setpen,d7         ;SET PEN
        trap #3
        tst d2
        beq.s miv3
        moveq #21,d0        ;inverse on
        bra.s miv4
miv3:   moveq #18,d0        ;inverse off
miv4:   move.w #W_chrout,d7
        trap #3
        rts
; FREEZE
fzm:    moveq #1,d2
        moveq #S_movesonoff,d0
        trap #5
        moveq #S_animsonoff,d0
        trap #5
        rts
; UNFREEZE
ufzm:   moveq #2,d2
        moveq #S_movesonoff,d0
        trap #5
        moveq #S_animsonoff,d0
        trap #5
        rts

*************************************************************************
*       CHOICE
L573:   dc.w 0
***********************
        moveq #0,d3
        move.w mnd+18(a5),d3
        clr.w mnd+18(a5)
        move.l d3,-(a6)
        rts

*************************************************************************
*       MENU ITEM
L574:   dc.w 0
***********************
        moveq #0,d3
        move.w mnd+20(a5),d3
        clr.w mnd+20(a5)
        move.l d3,-(a6)
        rts

*************************************************************************
*       ON MENU OFF
L575:   dc.w 0
***********************
        bset #7,mnd+98(a5)
        rts

*************************************************************************
*       ON MENU ON
L576:   dc.w 0
***********************
        bclr #7,mnd+98(a5)
        rts

*************************************************************************
*       ON MENU GOTO
L577:   dc.w 0
***********************
        move.w d0,d7
        lsl.w #2,d0
        add.w d0,a6
        move.l a6,a3
        subq.w #1,d7
        moveq #9,d0
        lea mnd+100(a5),a0
        move.l a0,a1
l577a:  clr.l (a0)+
        dbra d0,l577a
l577b:  move.l liad(a5),a0
        move.l -(a3),d0
L577c:  cmp.w (a0),d0
        lea 6(a0),a0
        beq.s L577d
        bcc.s L577c
        moveq #E_undefined_line,d0
        move.l error(a5),a0
        jmp (a0)
L577d:  move.l -4(a0),(a1)+
        dbra d7,l577b
        move.w #1,mnd+98(a5)
        rts

*************************************************************************
*       AUTOBACK 1
L578:   dc.w 0
***********************
        tst autoback(a5)
        beq.s l578a
        moveq #S_stopmouse,d0
        trap #5
        move.l adback(a5),$44e
l578a:  rts

*************************************************************************
*       AUTOBACK 2
L579:   dc.w 0
***********************
        tst autoback(a5)
        beq.s l579a
        move.l adlogic(a5),a1
        move.l a1,$44e
        move.l adback(a5),a0
        moveq #0,d5
        moveq #S_scrcopy,d0
        trap #5
        moveq #S_drawsprites,d0
        trap #5
l579a:  rts

*************************************************************************
*       DEFAULT pour STOS - RUN: appele le default du basic!
L580:   dc.w 0
***********************
        move.l table(a5),a0
        move.l sys_jumps(a0),a0
        move.l 4*(T_default-$80)(a0),a0   ; default
        jmp (a0)

*************************************************************************
*       RUN -seul-
L581:   dc.w l581a-L581,0
***********************
        tst.w flaggem(a5)
        bne.s l581z
; Sous STOS
l581a:  jsr L_delete.l                  ;Va deloger
        move.l table(a5),a2
        move.l sys_extjumps(a2),a2               ;extjump
        move.l 4*(T_exti_run-$70)(a2),a2             ;RUN
        lea -8(a2),a2                  ;RUN -seul-
        jmp (a2)
; Sous GEM
l581z:  moveq #E_syntax,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
*       RUN -nom-
L582:   dc.w l582a-L582,l582b-L582,0
***********************
l582a:  jsr L_vername.l                         ;Verifie le nom!
        movem.l d0/a0/a1,-(sp)
l582b:  jsr L_delete.l                  ;Deloge
        tst.w flaggem(a5)
        bne.s rn1
; Sous STOS ---> deloge et appelle le basic
        move.l table(a5),a2
        move.l sys_extjumps(a2),a2               ;extjump
        move.l 4*(T_exti_run-$70)(a2),a2             ;RUN
        lea -4(a2),a2                  ; calls run_name_entry
        movem.l (sp)+,d0/a0/a1
        tst.w d0
        jmp (a2)
; Sous GEM ---> poke une petite routine
rn1:    move.w #1,flgrun(a5)
        move.l oend(a5),a0
        jsr (a0)
        lea dro(pc),a0
        lea drof(pc),a1
        move.l adlogic(a5),a2
        lea 32032(a2),a2
        move.l a2,a3
rn2:    move.w (a0)+,(a2)+
        cmp.l a1,a0
        bcs.s rn2
        move.l name1(a5),a0
        move.l debut(a5),a4
        sub.l #$1c+2,a4
        move.l spile(a5),sp
        jmp (a3)
; ROUTINE RUN SOUS GEM
dro:    move.w #2,-(sp)
        move.l a0,-(sp)
        move.w #$3d,-(sp)
        trap #1
        lea 8(sp),sp
        move.w d0,d7
        move.l a4,-(sp)
        move.l #$fffffff,-(sp)
        move.w d7,-(sp)
        move.w #$3f,-(sp)
        trap #1
        lea 12(sp),sp
        move.w d7,-(sp)
        move.w #$3e,-(sp)
        trap #1
        lea 4(sp),sp
        jmp (a4)
        dc.w 0
drof:


*************************************************************************
*       RUN -nom- : VERIFIE la presence du programme
L583:   dc.w l583a-L583,l583b-L583,0
***********************
l583a:  jsr L_namedisk.l
        movem.l d0/a0/a1,-(sp)
        move.l name1(a5),a0
        moveq #0,d0
l583b:  jsr L_sfirst.l
        bne.s l583nf
        movem.l (sp)+,d0/a0/a1
        rts
l583nf: moveq #E_noent,d0
        move.l error(a5),a0
        jmp (a0)

*************************************************************************
L584:   dc.w 0
