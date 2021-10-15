

	bra Installe

*********************************************************************
*	TABLE DES SAUTS A LA TRAPPE
************************************
Jumps:
	dc.l Cadd		;0
	dc.l Csub		;1
	dc.l CMult		;2
	dc.l CDivi		;3
	dc.l CSIN			;4
	dc.l CCOS			;5
	dc.l CTAN			;6
	dc.l CEXP			;7
	dc.l CLN			;8
	dc.l CLOG			;9
	dc.l CSQR			;A
	dc.l Catof		;B
	dc.l CFtoa		;C
	dc.l CFtol		;D
	dc.l CLtof		;E
	dc.l CEq			;F
	dc.l CDif			;10
	dc.l CGt			;11
	dc.l CGe			;12
	dc.l CLt			;13
	dc.l CLe			;14
	dc.l CASIN		;15
	dc.l CACOS		;16
	dc.l CATAN		;17
	dc.l CSINH		;18
	dc.l CCOSH		;19
	dc.l CTANH		;1A
	dc.l CINT			;1B
	dc.l Cpow		;1C
	dc.l CABS			;1D

Jump2:	dc.l 0			;0
	dc.l GetSgn		;1
	dc.l pi			;2
	dc.l deg			;3
	dc.l rad			;4
	dc.l zerau		;5

tempbuf: 	dc.l 0
tempfl: 	dc.l 0
Zero:	dc.b "0.0000000",0
badflo:	dc.b 21," BAD FLOAT TRAP ",18,0
buffer:	ds.b 64

	even

**********************************************************************
*	INSTALLATION DE LA TRAPPE
**********************************
Installe:	pea STrap(pc)
	move.w #38,-(sp)
	trap #14
	addq.l #6,sp
	lea FinPrg(pc),a0
	rts
STrap:	lea Entrap(pc),a0
	move.l a0,$98
	rts

**********************************************************************
*	ENTREE DE LA TRAPPE
****************************
Entrap:	lsl.w #2,d0
	bmi.s DirFonc
	lea Jumps(pc),a1
	move.l 0(a1,d0.w),a1
	jmp (a1)

; Fonctions SUPPLEMENTAIRES
DirFonc:
	tst.b d0
	beq.s Inverse
	andi.w #$ff,d0
	lea Jump2(pc),a1
	move.l 0(a1,d0.w),a1
	jmp (a1)
;-----> INVERSE
Inverse:	bchg #7,d3			;0 ---> INVERSE le signe
	rte
;-----> RAMENE LE SIGNE en D0
GetSgn:	tst.l d3
	beq.s Gs2
	btst #7,d3			;1 ---> TROUVE le signe, en D0
	bne.s Gs1
	moveq #1,d0
	rte
Gs1:	moveq #-1,d0
	rte
Gs2:	moveq #0,d0
	rte
;-----> PI
pi:	move.l #$c90fd942,d3
	move.l #$12345678,d4
	rte
;-----> DEG
deg:	move.l #$c90fc942,-(sp)		;/pi
	move.l d3,-(sp)
	bsr fpdiv
	addq.l #8,sp
	move.l d0,-(sp)
	move.l #$b4000048,-(sp)		;*180
	bsr fpmul
	addq.l #8,sp
	move.l d0,d3
	move.l #$12345678,d4
	rte
;-----> RAD
rad:	move.l #$b4000048,-(sp)		;/180
	move.l d3,-(sp)
	bsr fpdiv
	addq.l #8,sp
	move.l d0,-(sp)
	move.l #$c90fc942,-(sp)		;*PI
	bsr fpmul
	addq.l #8,sp
	move.l d0,d3
	move.l #$12345678,d4
	rte
;-----> ZERO: ramene le ZERO (pour DIM)
zerau:	moveq #0,d3
	move.l #$12345678,d4
	rte



* TRAP #6,$00
* Adds two floating point numbers together
Cadd:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpadd
	addq.l #8,sp
	move.l #$12345678,d1
	rte

* TRAP #6,$01
* Subtract one floating point number from another
* Parameters used identical to ADFL
Csub:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpsub
	addq.l #8,sp
	move.l #$12345678,d1
	rte

* TRAP #6,$02
* Multiply two floating point numbers
CMult:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpmul
	addq.l #8,sp
	move.l #$12345678,d1
	rte

* TRAP #6,$03
* Oivide two floating point numbers
CDivi:	tst.l d3
	beq.s CD0
	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpdiv
	addq.l #8,sp
	move.l #$12345678,d1
	rte
; Division par ZERO!
CD0:	divu #0,d1
	rte

* TRAP #6,$0B
* Takes an Ascii string pointed to by AO and converts
* it into a number in floating point format in D0-D1
Catof:
	lea buffer(pc),a1
	move.l a1,-(sp)
	moveq #18,d1
Ca1:	move.b (a0)+,d0
	beq.s Ca2
	cmp.b #32,d0
	beq.s Ca1
	move.b d0,(a1)+
	dbra d1,Ca1
Ca2:	clr.b (a1)
	clr.b 1(a1)
	bsr atof
	addq.l #4,sp
	move.l #$12345678,d1
	rte

* TRAP #6,$0C
* Takes an FP number in D1-D2 and converts it into
* an Ascii string
CFtoa:	cmp.l #$12345678,d2
	beq.s paplant
; Prevents crashes when listing!
	move.l a0,-(sp)
	lea badflo(pc),a1
papl:	move.b (a1)+,(a0)+
	bne.s papl
	move.l a0,d0
	move.l (sp)+,a0
	sub.l a0,d0
	subq.l #1,d0
	rte
; OK, c'est le bon float!
paplant:	movem.l a2/d1-d5,-(sp)
	move.l a0,tempbuf
	move.l d1,tempfl
	tst.w d5		;D5= FIX FLAG
	bne.s PaFix
	tst.w d4
	bmi.s PaFix
; Fix precise NORMAL
	cmp.w #8,d4
	bcs.s Fx1
	moveq #7,d4
Fx1:	move.w d4,-(sp)
	move.l a0,-(sp)
	move.l d1,-(sp)
	bsr ftoa
	lea 10(sp),sp
	tst.w d4		;Si FIX=0, enleve le POINT!
	bne.s Fx2
	cmp.b #".",-1(a0)
	bne.s Fx2
	clr.b -(a0)
Fx2:	sub.l d0,a0
	exg d0,a0
	movem.l (sp)+,a2/d1-d5
	rte
; Representation proportionnelle
PaFix:	move.b d1,d0
	andi.b #$7f,d0
	cmp.b #$41,d0
	bcs.s PaF1
	move.w #7,-(sp)
	bra.s PaF5
PaF1:	cmp.b #$31,d0
	bcs.s PaF2
	move.w #7+3,-(sp)
	bra.s PaF5
PaF2:	move.w #16+6,-(sp)	;Si >-1 et <1, demande 16 chiffres!
PaF5:	pea buffer(pc)
	move.l d1,-(sp)
	bsr ftoa
	lea 10(sp),sp
	move.l d0,a1
	cmp.b #"-",(a1)
	bne.s PaFix1
	addq.l #1,a1
PaFix1:	move.l a1,a0
	cmp.b #"0",(a0)
	beq.s PaFix5
;-----> Chiffre >1
PaFix2:	move.b (a0)+,d0		;Compte AVANT la virgule
	beq.s PaFix3
	cmp.b #$2e,d0
	bne.s PaFix2
PaFix3:	sub.l a1,a0
	tst.w d5
	bne ExFix1
	moveq #7,d0
	cmp.w #8,a0		;Si >7 ---> representation E+
	bcc ExFix1
	sub.w a0,d0
	cmp.b #5,d0
	bcs Clean
	moveq #5,d0
	bra Clean
;-----> Chiffre <1
PaFix5:	addq.l #1,a0
	addq.l #1,a0
	move.l a0,a1
PaFix6:	move.b (a0)+,d0		;Compte le nombre de ZEROS
	beq.s PaFix7
	cmp.b #"0",d0
	beq.s PaFix6
PaFix7:	sub.l a1,a0
	clr.w d0
	cmp.w #16+6,a0		;Est-ce un vrai ZERO?
	bcs.s PaFix8
	move.w #6,a0
	moveq #1,d0
	bra.s PaFix9
PaFix8:	cmp.w #4,a0		;0.0001 ---> Exponantielle
	bcc ExVir1
PaFix9:	tst.w d5
	bne ExVir1
	addq.w #6,a0
	move.w a0,d0
; Calcule BIEN, et nettoie le chiffre
Clean:	move.w d0,-(sp)
	pea buffer(pc)
	move.l tempfl(pc),-(sp)
	bsr ftoa
	lea 10(sp),sp
	move.l d0,a0
	move.l tempbuf(pc),a1
Cl1:	move.b (a0)+,d0
	beq.s Cl5
	move.b d0,(a1)+
	cmp.b #".",d0
	bne.s Cl1
	lea -1(a1),a2
Cl2:	move.b (a0)+,d0
	beq.s Cl3
	move.b d0,(a1)+
	cmp.b #"0",d0
	beq.s Cl2
	move.l a1,a2		;Dernier non nul
	bra.s Cl2
Cl3:	move.l a2,a1
Cl5:	clr.b (a1)
	move.l tempbuf(pc),a0
	sub.l a0,a1
	move.l a1,d0
	movem.l (sp)+,a2/d1-d5
	rte

;-----> Representation exponantielle >= 1
ExFix1:	move.w a0,d2
	subq.w #2,d2
	cmp.w #7,a0
	bcs.s Exf0
	move.w #7,a0
Exf0:	moveq #9,d0
	sub.w a0,d0
	move.w d0,-(sp)
	pea buffer(pc)
	move.l tempfl(pc),-(sp)
	bsr ftoa
	lea 10(sp),sp

	lea buffer(pc),a0
	move.l tempbuf(pc),a1
	cmp.b #"-",(a0)
	bne.s Exf0a
	move.b (a0)+,(a1)+
Exf0a:	move.b (a0)+,(a1)+
	move.b #".",(a1)+
	lea -1(a1),a2
	move.w d4,d1
	bpl.s Exf1
	moveq #5,d1
	bra.s Exf2
Exf1:	cmp.w #5,d1
	bcs.s Exf2
	moveq #5,d1
Exf2:	move.b (a0)+,d0
	beq.s Exf2a
	cmp.b #".",d0
	beq.s Exf2
	move.b d0,(a1)+
	subq.w #1,d1
	bne.s Exf2
Exf2a:	clr.b (a1)
	tst.w d4
	bpl.s Exf5
; Enleve les zeros
	lea 1(a2),a0
Exf3:	move.b (a0)+,d0
	beq.s Exf4
	cmp.b #"0",d0
	beq.s Exf3
	move.l a0,a2		;Dernier non nul
	bra.s Exf3
Exf4:	move.l a2,a1
; Rajoute le E+00
Exf5:	move.b #"E",(a1)+
	move.b #"+",(a1)+
	move.b #"0",(a1)+
Exf6:	cmp.b #10,d2
	bcs.s Exf7
	add.b #1,-1(a1)
	subi.w #10,d2
	bra.s Exf6
Exf7:	addi.b #"0",d2
	move.b d2,(a1)+
	clr.b (a1)
	move.l tempbuf(pc),a0
	sub.l a0,a1
	move.l a1,d0
	movem.l (sp)+,a2/d1-d5
	rte

;-----> Exponantielle <1
ExVir1:	tst.w d0
	beq.s Exv0
	clr.w d2
	moveq #1,d3
	lea Zero(pc),a0
	bra.s Exv0a

Exv0:	clr.w d3
	move.w a0,d2
	addq.l #6,a0
	move.w a0,-(sp)
	pea buffer(pc)
	move.l tempfl(pc),-(sp)
	bsr ftoa
	lea 10(sp),sp
	lea buffer(pc),a0

Exv0a:	move.l tempbuf(pc),a1
	cmp.b #"-",(a0)
	bne.s Exv1
	move.b (a0)+,(a1)+
Exv1:	lea 2(a0),a2
Exv2:	move.b (a0)+,d0			;Cherche le debut du chiffre
	beq.s Exv3
	cmp.b #".",d0
	beq.s Exv2
	cmp.b #"0",d0
	beq.s Exv2
	bra.s Exv4
Exv3:	move.l a2,a0
	moveq #"0",d0
Exv4:	move.w d4,d1
	bpl.s Exv5
	moveq #6,d1
	bra.s Exv6
Exv5:	cmp.w #6,d1
	bcs.s Exv6
	moveq #6,d1
Exv6:	move.b d0,(a1)+
	move.b #".",(a1)+
	lea -1(a1),a2
	tst.w d1
	beq.s Exv7b
Exv7:	move.b (a0)+,d0
	beq.s Exv7a
	move.b d0,(a1)+
	cmp.b #"0",d0
	beq.s Exv7a
	move.l a1,a2
Exv7a:	subq.w #1,d1
	bne.s Exv7
Exv7b:	tst.w d4		;Nettoie le chiffre
	bpl.s Exv8
	move.l a2,a1
Exv8:	tst.w d3
	bne Exf5
	move.b #"E",(a1)+
	move.b #"-",(a1)+
	move.b #"0",(a1)+
	bra Exf6

* TRAP #6,$0D
* Convert a FP number in D1-D2 into an integer in D0
CFtol:	move.l d1,-(sp)
	bsr fpftol
	addq.l #4,sp
	rte

* TRAP #6,$0E
* Convert an integer in 01 into an FP no in D0-D1
CLtof:	move.l d1,-(sp)
	bsr fpltof
	addq.l #4,sp
	move.l #$12345678,d1
	rte

* TRAP #6,$0F
* Compares the two numbers in D1-D2 and D3-D4.
* If they are equal then D0 contains a -1, otherwise it
* contains a zero.
CEq:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpcmp
	addq.l #8,sp
	beq.s Vrai
Faux:	moveq #0,d0
	rte
Vrai:	moveq #-1,d0
	rte

* TRAP #6,$10
* Compares the two numbers in D1-D2 and D3-D4.
* If they are not equal then D0 contains a -1,otherwise
* it contains a zero.
CDif:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpcmp
	addq.l #8,sp
	bne.s Vrai
	bra.s Faux

* TRAP #6,$13
* Test if less than
CLt:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpcmp
	addq.l #8,sp
	blt.s Vrai
	bra.s Faux

* TRAP #6,$14
* Test if less than or equal
CLe:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpcmp
	addq.l #8,sp
	ble.s Vrai
	bra.s Faux

* TRAP #6,$11
* Compare two numbers and return a -1 in D0 if the
* first is greater than the second.
CGt:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpcmp
	addq.l #8,sp
	bgt.s Vrai
	bra.s Faux

* TRAP #6,$12
* Test if greater than or equal
CGe:	move.l d3,-(sp)
	move.l d1,-(sp)
	bsr fpcmp
	addq.l #8,sp
	bge.s Vrai
	bra.s Faux

* TRAP #6,$06
* Takes the TAN of the number in D1-D2 and places
* it in D0-D1.
CTAN:	MOVE.L 	D1,-(SP)
	BSR 	SIN
	MOVE.L 	D0,tempfl
	BSR 	COS
	MOVE.L 	D0,(SP)
	MOVE.L 	tempfl,-(SP)
	BSR 	fpdiv
	ADDQ.L 	#8,SP
	MOVE.L 	#$12345678,D1
	RTE

* TRAP #6,$1D
* ABS
CABS:	MOVE.L 	D1,D0
	BCLR 	#7,D0
	MOVE.L 	#$12345678,D1
	RTE

* TRAP #6,$1B
* Get the integer part of D1-D2 and place the result
* in D0-D1
CINT:	MOVE.L	D1,-(SP)
	BSR 	INT
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE

* TRAP #6,$05
* Takes the COS of the number in D1-D2 and places
* it in D0-D1.
CCOS:	MOVE.L 	D1,-(SP)
	BSR 	COS
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE
COS:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	BSR	TB0572
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS

* TRAP #6,$1C
* POWER
Cpow:
	MOVE.L	D3,-(SP)
	MOVE.L	D1,-(SP)
	BSR 	PUIS
	ADDQ.L 	#8,SP
	MOVE.L 	#$12345678,D1
	RTE
PUIS:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	MOVE.L	$C(A6),D6
	BSR	TB053C
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS

* TRAP #6,$04
* Takes the SIN of the number in D1-D2 and places
* it in D0-D1.
CSIN:
	MOVE.L 	D1,-(SP)
	BSR 	SIN
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE
SIN:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	BSR	TB0584
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS

* TRAP #6,$0A
* Takes a number in D1-D2 and returns the square
* of it in D0,D1
CSQR:
	MOVE.L	D1,-(SP)
	BSR 	SQR
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE

SQR:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	BSR	TB06EC
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS

* TRAP #6,$07
* Takes the Exponential of the number in D1-D2 and
* places it in D0-D1.
CEXP:
	MOVE.L 	D1,-(SP)
	BSR 	EXP
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE

EXP:
	LINK	A6,#-4
	MOVEM.L	D7,-(A7)
	MOVE.L	8(A6),D7
	JSR	TB093E
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D7
	UNLK	A6
	RTS

* TRAP #6,$08
* Calculates the naperien log of the number in D1-
* D2 and returns the result in D0-D1
CLN:
	MOVE.L 	D1,-(SP)
	BSR 	LN
	ADDQ.L	#4,SP
	MOVE.L 	#$12345678,D1
	RTE

LN:
	LINK	A6,#-4
	MOVEM.L	D7,-(A7)
	MOVE.L	8(A6),D7
	BSR	TB0A18
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D7
	UNLK	A6
	RTS

* TRAP #6,$09
* Calculates the base 10 log of the number in D1-D2
* and returns the result in D0-D1
CLOG:
	MOVE.L	D1,-(SP)
	BSR 	LN
	MOVE.L	#$935D8D42,(SP)
	MOVE.L 	D0,-(SP)
	BSR	fpdiv
	ADDQ.L 	#8,SP
	MOVE.L	#$12345678,D1
	RTE

* TRAP #6,$17
* Calculate the arc tan
CATAN:
	MOVE.L	D1,-(SP)
	BSR 	ATAN
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE

ATAN:
	LINK	A6,#-4
	MOVE.L	D7,-(A7)
	MOVE.L	8(A6),D7
	JSR	TB03D4
	MOVE.L	D7,D0
	MOVE.L	(A7)+,D7
	UNLK	A6
	RTS

* TRAP #6,$15
* Calculate the Arc Sin of no in D1-D2 and return it
* in D0-D1
CASIN:
	BSR 	ASIN
	MOVE.L	#$12345678,D1
	RTE

ASIN:
	MOVE.L 	D1,D7
	MOVE.L 	D1,-(SP)
	MOVE.L 	D1,-(SP)
	BSR 	fpmul
	ADDQ.L 	#8,SP
	BCHG	#7,D0
	MOVE.L	D0,-(SP)
	MOVE.L 	#$80000041,-(SP)
	BSR 	fpadd
	ADDQ.L 	#8,SP
	BTST	#7,D0
	BNE	CAS
	MOVE.L 	D0,-(SP)
	MOVE.L 	D7,-(SP)
	BSR 	fpdiv
	ADDQ.L 	#8,SP
	MOVE.L	D0,-(SP)
	BSR	ATAN
	ADDQ.L	#4,SP
	RTS
CAS:
	MOVEQ	#$0,D0
	RTS

* TRAP #6,$16
* Calculate the arc cos
CACOS:
	BSR 	ASIN
	MOVE.L	D0,-(SP)
	MOVE.L	#$C90FD941,-(SP)
	BSR 	fpsub
	ADDQ.L 	#8,SP
	MOVE.L 	#$12345678,D1
	RTE

* TRAP #6,$18
* Calculate the hyperbolic sin
CSINH:
	MOVE.L	D1,-(SP)
	BSR 	SINH
	ADDQ.L 	#4,SP
	MOVE.L 	#$12345678,D1
	RTE

SINH:
	LINK	A6,#-4
	MOVE.L	D7,-(A7)
	MOVE.L	8(A6),D7
	BSR	TB049A
	MOVE.L	D7,D0
	MOVE.L	(A7)+,D7
	UNLK	A6
	RTS

* TRAP #6,$19
* Calculate the hyperbolic cos
CCOSH:
	MOVE.L 	D1,-(SP)
	BSR 	EXP
	MOVE.L 	D0,tempfl
	MOVE.L	(SP),D0
	BCHG	#7,D0
	MOVE.L 	D0,(SP)
	BSR	EXP
	MOVE.L	D0,(SP)
	MOVE.L	tempfl,-(SP)
	BSR	fpadd
	ADDQ.L	#8,SP
	MOVE.L 	#$80000042,-(SP)
	MOVE.L	D0,-(SP)
	BSR 	fpdiv
	ADDQ.L 	#8,SP
	MOVE.L 	#$12345678,D1
	RTE

* TRAP #6,$1A
* Calculate the hyperbolic tan
CTANH:
	MOVE.L 	D1,-(SP)
	BSR 	TANH
	ADDQ.L	#4,SP
	MOVE.L 	#$12345678,D1
	RTE
TANH:
	LINK	A6,#-4
	MOVE.L	D7,-(A7)
	MOVE.L	8(A6),D7
	BSR	TB04D4
	MOVE.L	D7,D0
	MOVE.L	(A7)+,D7
	UNLK	A6
	RTS

*****************************************************************
*	CONVERSION FLOAT ---> ASCII
************************************
ftoa:
	LINK	A6,#-8
	MOVEM.L	D3-d7,-(A7)
	MOVE.L	$C(A6),-4(A6)
	TST.W	$10(A6)
	BGT.S	L27CDA
	MOVEQ	#1,D0
	BRA.S	L27CEC
L27CDA:
	CMPI.W	#$16,$10(A6)
	BLE.S	L27CE6
	MOVEQ	#$17,D0
	BRA.S	L27CEC
L27CE6:
	MOVE.W	$10(A6),D0
	ADDQ.W	#1,D0
L27CEC:
	MOVE.W	D0,D4
	CLR.W	D7
	CLR.L	-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BGE.S	L27D1C
	MOVEA.L	$C(A6),A0
	MOVE.B	#$2D,(A0)
	ADDQ.L	#1,$C(A6)
	MOVE.L	8(A6),-(A7)
	JSR	fpneg
	ADDQ.L	#4,A7
	MOVE.L	D0,8(A6)
L27D1C:
	CLR.L	-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BLE.S	L27D5A
	BRA.S	L27D46
L27D2E:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
	SUBQ.W	#1,D7
L27D46:
	MOVE.L	#$80000041,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BLT.S	L27D2E
L27D5A:
	BRA.S	L27D74
L27D5C:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpdiv
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
	ADDQ.W	#1,D7
L27D74:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BGE.S	L27D5C
	ADD.W	D7,D4
	MOVEQ	#1,D6
	MOVE.W	D6,D0
	EXT.L	D0
	MOVE.L	D0,-(A7)
	JSR	L28270
	ADDQ.L	#4,A7
	MOVE.L	D0,-8(A6)
	BRA.S	L27DB8
L27DA0:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	-8(A6),-(A7)
	JSR	fpdiv
	ADDQ.L	#8,A7
	MOVE.L	D0,-8(A6)
	ADDQ.W	#1,D6
L27DB8:
	CMP.W	D4,D6
	BLT.S	L27DA0
	MOVE.L	#$80000042,-(A7)
	MOVE.L	-8(A6),-(A7)
	JSR	fpdiv
	ADDQ.L	#8,A7
	MOVE.L	D0,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpadd
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BLT.S	L27DFE
	MOVE.L	#$80000041,8(A6)
	ADDQ.W	#1,D7
L27DFE:
	TST.W	D7
	BGE.S	L27E36
	MOVEA.L	$C(A6),A0
	MOVE.B	#$30,(A0)
	ADDQ.L	#1,$C(A6)
	MOVEA.L	$C(A6),A0
	MOVE.B	#$2E,(A0)
	ADDQ.L	#1,$C(A6)
	TST.W	D4
	BGE.S	L27E20
	SUB.W	D4,D7
L27E20:
	MOVEQ	#-1,D6
	BRA.S	L27E32
L27E24:
	MOVEA.L	$C(A6),A0
	MOVE.B	#$30,(A0)
	ADDQ.L	#1,$C(A6)
	SUBQ.W	#1,D6
L27E32:
	CMP.W	D7,D6
	BGT.S	L27E24
L27E36:
	CLR.W	D6
	BRA.S	L27EA4
L27E3A:
	MOVE.L	8(A6),-(A7)
	JSR	L28300
	ADDQ.L	#4,A7
	MOVE.W	D0,D5
	MOVE.W	D5,D0
	ADDI.W	#$30,D0
	MOVEA.L	$C(A6),A1
	MOVE.B	D0,(A1)
	ADDQ.L	#1,$C(A6)
	CMP.W	D7,D6
	BNE.S	L27E68
	MOVEA.L	$C(A6),A0
	MOVE.B	#$2E,(A0)
	ADDQ.L	#1,$C(A6)
L27E68:
	MOVE.W	D5,D0
	EXT.L	D0
	MOVE.L	D0,-(A7)
	JSR	L28270
	ADDQ.L	#4,A7
	MOVE.L	D0,-8(A6)
	MOVE.L	D0,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpsub
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
	ADDQ.W	#1,D6
L27EA4:
	CMP.W	D4,D6
	BLT.S	L27E3A
	MOVEA.L	$C(A6),A0
	CLR.B	(A0)
	ADDQ.L	#1,$C(A6)
	MOVE.L	-4(A6),D0
	TST.L	(A7)+
	MOVEM.L	(A7)+,D4-D7
	UNLK	A6
	RTS

******************************************************************
*	Conversion ASCII---> FLOAT
***********************************
atof:
	LINK	A6,#-$2E
	MOVEM.L	D7/A4-A5,-(A7)
	LEA	-$14(A6),A5
	LEA	-$18(A6),A4
	CLR.W	-$1E(A6)
	CLR.W	-$26(A6)
	BRA.S	L27EDE
L27EDA:
	ADDQ.L	#1,8(A6)
L27EDE:
	MOVEA.L	8(A6),A0
	CMPI.B	#$20,(A0)
	BEQ.S	L27EDA
	MOVEA.L	8(A6),A0
	CMPI.B	#9,(A0)
	BEQ.S	L27EDA
	MOVEA.L	8(A6),A0
	CMPI.B	#$2D,(A0)
	BEQ.S	L27F00
	CLR.W	D0
	BRA.S	L27F02
L27F00:
	MOVEQ	#1,D0
L27F02:
	MOVE.W	D0,-$22(A6)
	MOVEA.L	8(A6),A0
	CMPI.B	#$2D,(A0)
	BEQ.S	L27F1A
	MOVEA.L	8(A6),A0
	CMPI.B	#$2B,(A0)
	BNE.S	L27F1E
L27F1A:
	ADDQ.L	#1,8(A6)
L27F1E:
	BRA.S	L27F44
L27F20:
	MOVEA.L	8(A6),A0
	CMPI.B	#$2E,(A0)
	BNE.S	L27F30
	ADDQ.W	#1,-$1E(A6)
	BRA.S	L27F40
L27F30:
	MOVEA.L	8(A6),A0
	MOVE.B	(A0),(A5)+
	TST.W	-$1E(A6)
	BEQ.S	L27F40
	ADDQ.W	#1,-$26(A6)
L27F40:
	ADDQ.L	#1,8(A6)
L27F44:
	MOVEA.L	8(A6),A0
	TST.B	(A0)
	BEQ.S	L27F60
	MOVEA.L	8(A6),A0
	CMPI.B	#$65,(A0)
	BEQ.S	L27F60
	MOVEA.L	8(A6),A0
	CMPI.B	#$45,(A0)
	BNE.S	L27F20
L27F60:
	CLR.B	(A5)
	MOVEA.L	8(A6),A0
	CMPI.B	#$65,(A0)
	BEQ.S	L27F76
	MOVEA.L	8(A6),A0
	CMPI.B	#$45,(A0)
	BNE.S	L27FBA
L27F76:
	ADDQ.L	#1,8(A6)
	MOVEA.L	8(A6),A0
	CMPI.B	#$2D,(A0)
	BEQ.S	L27F88
	CLR.W	D0
	BRA.S	L27F8A
L27F88:
	MOVEQ	#1,D0
L27F8A:
	MOVE.W	D0,-$20(A6)
	MOVEA.L	8(A6),A0
	CMPI.B	#$2D,(A0)
	BEQ.S	L27FA2
	MOVEA.L	8(A6),A0
	CMPI.B	#$2B,(A0)
	BNE.S	L27FA6
L27FA2:
	ADDQ.L	#1,8(A6)
L27FA6:
	BRA.S	L27FB2
L27FA8:
	MOVEA.L	8(A6),A0
	MOVE.B	(A0),(A4)+
	ADDQ.L	#1,8(A6)
L27FB2:
	MOVEA.L	8(A6),A0
	TST.B	(A0)
	BNE.S	L27FA8
L27FBA:
	CLR.B	(A4)
	MOVE.L	A6,(A7)
	ADDI.L	#$FFFFFFEC,(A7)
	BSR	L280A8
	MOVE.L	D0,-$2A(A6)
	MOVE.L	A6,(A7)
	ADDI.L	#$FFFFFFE8,(A7)
	JSR	L28654
	MOVE.W	D0,-$24(A6)
	TST.W	-$20(A6)
	BEQ.S	L27FF0
	MOVE.W	-$24(A6),D0
	NEG.W	D0
	SUB.W	-$26(A6),D0
	BRA.S	L27FF8
L27FF0:
	MOVE.W	-$24(A6),D0
	SUB.W	-$26(A6),D0
L27FF8:
	MOVE.W	D0,-$26(A6)
	MOVE.L	-$2A(A6),-(A7)
	MOVE.W	-$26(A6),-(A7)
	BSR.S	L28040
	ADDQ.L	#2,A7
	MOVE.L	D0,-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,-$2E(A6)
	MOVE.L	-$2E(A6),(A7)
	JSR	L28116
	MOVE.L	D0,-$1C(A6)
	TST.W	-$22(A6)
	BEQ.S	L28032
	ORI.L	#$80,-$1C(A6)
L28032:
	MOVE.L	-$1C(A6),D0
	TST.L	(A7)+
	MOVEM.L	(A7)+,A4-A5
	UNLK	A6
	RTS
L28040:
	LINK	A6,#-8
	TST.W	8(A6)
	BGE.S	L28076
	MOVE.L	#$80000041,-4(A6)
	BRA.S	L2806E
L28054:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	fpdiv
	ADDQ.L	#8,A7
	MOVE.L	D0,-4(A6)
	ADDQ.W	#1,8(A6)
L2806E:
	TST.W	8(A6)
	BLT.S	L28054
	BRA.S	L280A0
L28076:
	MOVE.L	#$80000041,-4(A6)
	BRA.S	L2809A
L28080:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,-4(A6)
	SUBQ.W	#1,8(A6)
L2809A:
	TST.W	8(A6)
	BGT.S	L28080
L280A0:
	MOVE.L	-4(A6),D0
	UNLK	A6
	RTS
L280A8:
	LINK	A6,#-8
	MOVE.L	#0,-4(A6)
	BRA.S	L280FA
L280B6:
	MOVE.L	#$A0000044,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),-(A7)
	MOVEA.L	8(A6),A0
	MOVE.B	(A0),D0
	EXT.W	D0
	ADDI.W	#$FFD0,D0
	EXT.L	D0
	MOVE.L	D0,-(A7)
	JSR	L28270
	ADDQ.L	#4,A7
	MOVE.L	D0,-(A7)
	JSR	fpadd
	ADDQ.L	#8,A7
	MOVE.L	D0,-4(A6)
	ADDQ.L	#1,8(A6)
L280FA:
	MOVEA.L	8(A6),A0
	CMPI.B	#$30,(A0)
	BLT.S	L2810E
	MOVEA.L	8(A6),A0
	CMPI.B	#$39,(A0)
	BLE.S	L280B6
L2810E:
	MOVE.L	-4(A6),D0
	UNLK	A6
	RTS
L28116:
	LINK	A6,#-4
	MOVEM.L	D4-D7,-(A7)
	CLR.L	-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BNE.S	L28134
	CLR.L	D0
	BRA	L28208
L28134:
	CLR.L	-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BGE.S	L28158
	MOVE.L	8(A6),-(A7)
	JSR	fpneg
	ADDQ.L	#4,A7
	MOVE.L	D0,8(A6)
	MOVEQ	#1,D5
	BRA.S	L2815A
L28158:
	CLR.W	D5
L2815A:
	CLR.W	D7
	BRA.S	L28176
L2815E:
	ADDQ.W	#1,D7
	MOVE.L	#$80000042,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpdiv
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
L28176:
	MOVE.L	#$80000041,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BGE.S	L2815E
	BRA.S	L281A4
L2818C:
	SUBQ.W	#1,D7
	MOVE.L	#$80000042,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
L281A4:
	MOVE.L	#$80000040,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpcmp
	ADDQ.L	#8,A7
	BLT.S	L2818C
	MOVE.L	#$80000059,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	fpmul
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
	MOVE.L	8(A6),-(A7)
	JSR	L28300
	ADDQ.L	#4,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),D0
	ASL.L	#8,D0
	MOVE.L	D0,-4(A6)
	ADDI.W	#$40,D7
	MOVE.W	D7,D0
	ANDI.W	#$7F,D0
	EXT.L	D0
	OR.L	D0,-4(A6)
	TST.W	D5
	BEQ.S	L28204
	ORI.L	#$80,-4(A6)
L28204:
	MOVE.L	-4(A6),D0
L28208:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D5-D7
	UNLK	A6
	RTS

L28270:
	LINK	A6,#0
	MOVEM.L	D5-D7,-(A7)
	TST.L	8(A6)
	BGE.S	L2828C
	MOVEQ	#1,D6
	MOVE.L	8(A6),D0
	NEG.L	D0
	MOVE.L	D0,8(A6)
	BRA.S	L2828E
L2828C:
	CLR.W	D6
L2828E:
	TST.L	8(A6)
	BNE.S	L28298
	CLR.L	D0
	BRA.S	L282F6
L28298:
	MOVEQ	#$18,D7
	BRA.S	L282A8
L2829C:
	MOVE.L	8(A6),D0
	ASR.L	#1,D0
	MOVE.L	D0,8(A6)
	ADDQ.L	#1,D7
L282A8:
	MOVE.L	8(A6),D0
	ANDI.L	#$7F000000,D0
	BNE.S	L2829C
	BRA.S	L282C2
L282B6:
	MOVE.L	8(A6),D0
	ASL.L	#1,D0
	MOVE.L	D0,8(A6)
	SUBQ.L	#1,D7
L282C2:
	BTST	#7,9(A6)
	BEQ.S	L282B6
	MOVE.L	8(A6),D0
	ASL.L	#8,D0
	MOVE.L	D0,8(A6)
	ADDI.L	#$40,D7
	MOVE.L	D7,D0
	ANDI.L	#$7F,D0
	OR.L	D0,8(A6)
	TST.W	D6
	BEQ.S	L282F2
	ORI.L	#$80,8(A6)
L282F2:
	MOVE.L	8(A6),D0
L282F6:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D6-D7
	UNLK	A6
	RTS

L28300:
	LINK	A6,#0
	MOVEM.L	D4-D7,-(A7)
	MOVE.L	8(A6),D0
	ANDI.L	#$7F,D0
	ADDI.L	#$FFFFFFC0,D0
	MOVE.W	D0,D6
	TST.L	8(A6)
	BEQ.S	L28324
	TST.W	D6
	BGE.S	L28328
L28324:
	CLR.L	D0
	BRA.S	L2837E
L28328:
	MOVE.L	8(A6),D0
	ANDI.L	#$80,D0
	MOVE.W	D0,D5
	CMP.W	#$1F,D6
	BLE.S	L2834E
	TST.W	D5
	BEQ.S	L28346
	MOVE.L	#$80000000,D0
	BRA.S	L2834C
L28346:
	MOVE.L	#$7FFFFFFF,D0
L2834C:
	BRA.S	L2837E
L2834E:
	MOVE.L	8(A6),D7
	ASR.L	#8,D7
	ANDI.L	#$FFFFFF,D7
	SUBI.W	#$18,D6
	BRA.S	L28364
L28360:
	ASR.L	#1,D7
	ADDQ.W	#1,D6
L28364:
	TST.W	D6
	BLT.S	L28360
	BRA.S	L2836E
L2836A:
	ASL.L	#1,D7
	SUBQ.W	#1,D6
L2836E:
	TST.W	D6
	BGT.S	L2836A
	TST.W	D5
	BEQ.S	L2837C
	MOVE.L	D7,D0
	NEG.L	D0
	MOVE.L	D0,D7
L2837C:
	MOVE.L	D7,D0
L2837E:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D5-D7
	UNLK	A6
	RTS

* 
*	Floating Point Negation :
*		Front End to FFP Floating Point Package.
*
*		double
*		fpneg(farg)
*		double farg;
*
*	Returns : negated Floating point number
*
fpneg:
	link	a6,#-4
	movem.l	d3-d7,-(sp)
	move.l	8(a6),d7
	jsr		ffpneg
	move.l	d7,d0
	movem.l	(sp)+,d3-d7
	unlk	a6
	rts

*************************************************************
*                     ffpneg                                *
*           fast floating point negate                      *
*                                                           *
*  input:  d7 - fast floating point argument                *
*                                                           *
*  output: d7 - fast floating point negated result          *
*                                                           *
*      condition codes:                                     *
*              n - set if result is negative                *
*              z - set if result is zero                    *
*              v - cleared                                  *
*              c - undefined                                *
*              x - undefined                                *
*                                                           *
*               all registers transparent                   *
*                                                           *
*************************************************************
 
**********************
* negate entry point *
**********************
ffpneg:  tst.b     d7        ; ? is argument a zero
         beq.s     ffprtn    ; return if so
         eori.b    #$80,d7   ; invert the sign bit
ffprtn:  rts                 ; and return to caller




L28654:
	LINK	A6,#0
	MOVEM.L	D5-D7/A5,-(A7)
	MOVEA.L	8(A6),A5
	CLR.W	D7
	CLR.W	D6
	BRA.S	L28668
L28666:
	ADDQ.L	#1,A5
L28668:
	MOVE.B	(A5),D0
	EXT.W	D0
	EXT.L	D0
	ADDI.L	#0,D0
	MOVEA.L	D0,A0
;	BTST	#5,(A0)
;	BNE.S	L28666
	CMPI.B	#$2B,(A5)
	BNE.S	L28686
	ADDQ.L	#1,A5
	BRA.S	L28690
L28686:
	CMPI.B	#$2D,(A5)
	BNE.S	L28690
	ADDQ.L	#1,A5
	ADDQ.W	#1,D6
L28690:
	BRA.S	L286A0
L28692:
	MULS	#$A,D7
	MOVE.B	(A5)+,D0
	EXT.W	D0
L2869A:
	ADD.W	D0,D7
L2869C:
	ADDI.W	#$FFD0,D7
L286A0:
	CMPI.B	#$30,(A5)
L286A4:
	BLT.S	L286AC
	CMPI.B	#$39,(A5)
	BLE.S	L28692
L286AC:
	TST.W	D6
	BEQ.S	L286B6
	MOVE.W	D7,D0
	NEG.W	D0
	MOVE.W	D0,D7
L286B6:
	MOVE.W	D7,D0
	TST.L	(A7)+
	MOVEM.L	(A7)+,D6-D7/A5
	UNLK	A6
	RTS

* 
*	Floating Point Long to Float Routine :
*		Front End to FFP Floating Point Package.
*
*		double
*		fpltof(larg)
*		long larg;
*
*	Return : Floating Point representation of Long Fixed point integer
*
fpltof:
	LINK	A6,#0
	MOVEM.L	D5-D7,-(A7)
	TST.L	8(A6)
	BGE.S	LAFFF0
	MOVEQ	#1,D6
	MOVE.L	8(A6),D0
	NEG.L	D0
	MOVE.L	D0,8(A6)
	BRA.S	LAFFF2
LAFFF0:
	CLR.W	D6
LAFFF2:
	TST.L	8(A6)
	BNE.S	LAFFFC
	CLR.L	D0
	BRA.S	LB005A
LAFFFC:
	MOVEQ	#$18,D7
	BRA.S	LB000C
LB0000:
	MOVE.L	8(A6),D0
	ASR.L	#1,D0
	MOVE.L	D0,8(A6)
	ADDQ.L	#1,D7
LB000C:
	MOVE.L	8(A6),D0
	ANDI.L	#$7F000000,D0
	BNE.S	LB0000
	BRA.S	LB0026
LB001A:
	MOVE.L	8(A6),D0
	ASL.L	#1,D0
	MOVE.L	D0,8(A6)
	SUBQ.L	#1,D7
LB0026:
	BTST	#7,9(A6)
	BEQ.S	LB001A
	MOVE.L	8(A6),D0
	ASL.L	#8,D0
	MOVE.L	D0,8(A6)
	ADDI.L	#$40,D7
	MOVE.L	D7,D0
	ANDI.L	#$7F,D0
	OR.L	D0,8(A6)
	TST.W	D6
	BEQ.S	LB0056
	ORI.L	#$80,8(A6)
LB0056:
	MOVE.L	8(A6),D0
LB005A:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D6-D7
	UNLK	A6
	RTS

* 
*	Floating Point Float to Long Routine :
*		Front End to IEEE Floating Point Package.
*
*	long
*	fpftol(fparg)
*	double fparg;
*
*	Return : Fixed Point representation of Floating Point Number
*
fpftol:
	LINK	A6,#0
	MOVEM.L	D4-D7,-(A7)
	MOVE.L	8(A6),D0
	ANDI.L	#$7F,D0
	ADDI.L	#$FFFFFFC0,D0
	MOVE.W	D0,D6
	TST.L	8(A6)
	BEQ.S	LB0088
	TST.W	D6
	BGE.S	LB008C
LB0088:
	CLR.L	D0
	BRA.S	LB00E2
LB008C:
	MOVE.L	8(A6),D0
	ANDI.L	#$80,D0
	MOVE.W	D0,D5
	CMP.W	#$1F,D6
	BLE.S	LB00B2
	TST.W	D5
	BEQ.S	LB00AA
	MOVE.L	#$80000000,D0
	BRA.S	LB00B0
LB00AA:
	MOVE.L	#$7FFFFFFF,D0
LB00B0:
	BRA.S	LB00E2
LB00B2:
	MOVE.L	8(A6),D7
	ASR.L	#8,D7
	ANDI.L	#$FFFFFF,D7
	SUBI.W	#$18,D6
	BRA.S	LB00C8
LB00C4:
	ASR.L	#1,D7
	ADDQ.W	#1,D6
LB00C8:
	TST.W	D6
	BLT.S	LB00C4
	BRA.S	LB00D2
LB00CE:
	ASL.L	#1,D7
	SUBQ.W	#1,D6
LB00D2:
	TST.W	D6
	BGT.S	LB00CE
	TST.W	D5
	BEQ.S	LB00E0
	MOVE.L	D7,D0
	NEG.L	D0
	MOVE.L	D0,D7
LB00E0:
	MOVE.L	D7,D0
LB00E2:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D5-D7
	UNLK	A6
	RTS



*************************************************************
*	Floating Point Addition :
*		Front End to FFP Floating Point Package.
*
*		double
*		fpadd(addend,adder)
*		double addend, adder;
*
*	Returns : Sum of two floating point numbers
*
fpadd:
	link	a6,#-4
	movem.l	d3-d7,-(sp)
	move.l	8(a6),d7
	move.l	12(a6),d6
	jsr		ffpadd
	move.l	d7,d0
	movem.l	(sp)+,d3-d7
	unlk	a6
	rts

* 
*	Floating Point Compare :
*		Front End to FFP Floating Point Package.
*
*		int
*		fpcmp(source,dest)
*		double source, dest;
*
*	Returns : Condition codes based on Floating Point Compare
*
fpcmp:
	link	a6,#-4
	movem.l	d3-d7,-(sp)
	move.l	8(a6),d7
	move.l	12(a6),d6
	jsr		ffpcmp
	movem.l	(sp)+,d3-d7
	unlk	a6
	rts

* 
*	Floating Point Division :
*		Front End to FFP Floating Point Package.
*
*		double
*		fpdiv(divisor,dividend)
*		double divisor, dividend;
*
*	Return : Floating Point Quotient
*
fpdiv:
	link	a6,#-4
	movem.l	d3-d7,-(sp)
	move.l	8(a6),d7
	move.l	12(a6),d6
	jsr		ffpdiv
	move.l	d7,d0
	movem.l	(sp)+,d3-d7
	unlk	a6
	rts

* 
*	Floating Point Multiplication :
*		Front End to FFP Floating Point Package.
*
*		double
*		fpmul(multiplier,multiplicand)
*		double multiplier, multiplicand;
*
*	Return : Result of Floating Point Multiply
*
fpmul:
	link	a6,#-4
	movem.l	d3-d7,-(sp)
	move.l	8(a6),d7
	move.l	12(a6),d6
	jsr		ffpmul2
	move.l	d7,d0
	movem.l	(sp)+,d3-d7
	unlk	a6
	rts

* 
*	Floating Point Subtraction :
*		Front End to FFP Floating Point Package.
*
*		double
*		fpsub(subtrahend,minuend)
*		double subtrahend, minuend;
*
*	Returns : Floating point subtraction result
*
fpsub:
	link	a6,#-4
	movem.l	d3-d7,-(sp)
	move.l	8(a6),d7
	move.l	12(a6),d6
	jsr		ffpsub
	move.l	d7,d0
	movem.l	(sp)+,d3-d7
	unlk	a6
	rts

*************************************************************
*                      ffpcmp                               *
*              fast floating point compare                  *
*                                                           *
*  input:  d6 - fast floating point argument (source)       *
*          d7 - fast floating point argument (destination)  *
*                                                           *
*  output: condition code reflecting the following branches *
*          for the result of comparing the destination      *
*          minus the source:                                *
*                                                           *
*                  gt - destination greater                 *
*                  ge - destination greater or equal to     *
*                  eq - destination equal                   *
*                  ne - destination not equal               *
*                  lt - destination less than               *
*                  le - destination less than or equal to   *
*                                                           *
*      condition codes:                                     *
*              n - cleared                                  *
*              z - set if result is zero                    *
*              v - cleared                                  *
*              c - undefined                                *
*              x - undefined                                *
*                                                           *
*               all registers transparent                   *
*                                                           *
*************************************************************

***********************
* compare entry point *
***********************
ffpcmp:  tst.b     d6
         bpl.s     ffpcp
         tst.b     d7
         bpl.s     ffpcp
         cmp.b     d7,d6
         bne.s     ffpcrtn
         cmp.l     d7,d6
         rts
ffpcp:
         cmp.b     d6,d7     ; compare sign and exponent only first
         bne.s     ffpcrtn   ; return if that is sufficient
         cmp.l     d6,d7     ; no, compare full longwords then
ffpcrtn: rts                 ; and return to the caller

*************************************************************
*                     ffptst                                *
*           fast floating point test                        *
*                                                           *
*  input:  d7 - fast floating point argument                *
*                                                           *
*  output: condition codes set for the following branches:  *
*                                                           *
*                  eq - argument equals zero                *
*                  ne - argument not equal zero             *
*                  pl - argument is positive (includes zero)*
*                  mi - argument is negative                *
*                                                           *
*      condition codes:                                     *
*              n - set if result is negative                *
*              z - set if result is zero                    *
*              v - cleared                                  *
*              c - undefined                                *
*              x - undefined                                *
*                                                           *
*               all registers transparent                   *
*                                                           *
*************************************************************
 
********************
* test entry point *
********************
ffptst:  tst.b     d7        ; return tested condition code
         rts                 ; to caller

*************************************************************
*                  ffpadd/ffpsub                            *
*             fast floating point add/subtract              *
*                                                           *
*  ffpadd/ffpsub - fast floating point add and subtract     *
*                                                           *
*  input:                                                   *
*      ffpadd                                               *
*          d6 - floating point addend                       *
*          d7 - floating point adder                        *
*      ffpsub                                               *
*          d6 - floating point subtrahend                   *
*          d7 - floating point minuend                      *
*                                                           *
*  output:                                                  *
*          d7 - floating point add result                   *
*                                                           *
*  condition codes:                                         *
*          n - result is negative                           *
*          z - result is zero                               *
*          v - overflow has occured                         *
*          c - undefined                                    *
*          x - undefined                                    *
*                                                           *
*           registers d3 thru d5 are volatile               *
*                                                           *
*  code size: 228 bytes       stack work area:  0 bytes     *
*                                                           *
*  notes:                                                   *
*    1) addend/subtrahend unaltered (d6).                   *
*    2) underflow returns zero and is unflagged.            *
*    3) overflow returns the highest value with the         *
*       correct sign and the 'v' bit set in the ccr.        *
*                                                           *
*  time: (8 mhz no wait states assumed)                     *
*                                                           *
*           composite average  20.625 microseconds          *
*                                                           *
*  add:         arg1=0              7.75 microseconds       *
*               arg2=0              5.25 microseconds       *
*                                                           *
*          like signs  14.50 - 26.00  microseconds          *
*                    average   18.00  microseconds          *
*         unlike signs 20.13 - 54.38  microceconds          *
*                    average   22.00  microseconds          *
*                                                           *
*  subtract:    arg1=0              4.25 microseconds       *
*               arg2=0              9.88 microseconds       *
*                                                           *
*          like signs  15.75 - 27.25  microseconds          *
*                    average   19.25  microseconds          *
*         unlike signs 21.38 - 55.63  microseconds          *
*                    average   23.25  microseconds          *
*                                                           *
*************************************************************

************************
* subtract entry point *
************************
ffpsub:   move.b  d6,d4   ; test arg1
         beq.s   fpart2   ; return arg2 if arg1 zero
         eor.b   #$80,d4  ; invert copied sign of arg1
         bmi.s   fpami1   ; branch arg1 minus
* + arg1
         move.b  d7,d5    ; copy and test arg2
         bmi.s   fpams    ; branch arg2 minus
         bne.s   fpals    ; branch positive not zero
         bra.s   fpart1   ; return arg1 since arg2 is zero

*******************
* add entry point *
*******************
ffpadd:  move.b  d6,d4    ; test argument1
         bmi.s   fpami1   ; branch if arg1 minus
         beq.s   fpart2   ; return arg2 if zero
 
* + arg1
         move.b  d7,d5    ; test argument2
         bmi.s   fpams    ; branch if mixed signs
         beq.s   fpart1   ; zero so return argument1
 
* +arg1 +arg2
* -arg1 -arg2
fpals:   sub.b   d4,d5    ; test exponent magnitudes
         bmi.s   fpa2lt   ; branch arg1 greater
         move.b  d7,d4    ; setup stronger s+exp in d4
 
* arg1exp <= arg2exp
         cmp.b   #24,d5   ; overbearing size
         bcc.s   fpart2   ; branch yes, return arg2
         move.l  d6,d3    ; copy arg1
         clr.b   d3       ; clean off sign+exponent
         lsr.l   d5,d3    ; shift to same magnitude
         move.b  #$80,d7  ; force carry if lsb-1 on
         add.l   d3,d7    ; add arguments
         bcs.s   fpa2gc   ; branch if carry produced
fparsr:  move.b  d4,d7    ; restore sign/exponent
         rts              ; return to caller
 
* add same sign overflow normalization
fpa2gc:  roxr.l  #1,d7    ; shift carry back into result
         add.b   #1,d4    ; add one to exponent
         bvs.s   fpa2os   ; branch overflow
         bcc.s   fparsr   ; branch if no exponent overflow
fpa2os:  moveq   #-1,d7   ; create all ones
         sub.b   #1,d4    ; back to highest exponent+sign
         move.b  d4,d7    ; replace in result
         ori.b   #$02,ccr ; show overflow occurred
         rts              ; return to caller
 
* return argument1
fpart1:  move.l  d6,d7    ; move in as result
         move.b  d4,d7    ; move in prepared sign+exponent
         rts              ; return to caller
 
* return argument2
fpart2:  tst.b   d7       ; test for returned value
         rts              ; return to caller
 
* -arg1exp > -arg2exp
* +arg1exp > +arg2exp
fpa2lt:  cmp.b   #-24,d5  ; ? arguments within range
         ble.s   fpart1   ; nope, return larger
         neg.b   d5       ; change difference to positive
         move.l  d6,d3    ; setup larger value
         clr.b   d7       ; clean off sign+exponent
         lsr.l   d5,d7    ; shift to same magnitude
         move.b  #$80,d3  ; force carry if lsb-1 on
         add.l   d3,d7    ; add arguments
         bcs.s   fpa2gc   ; branch if carry produced
         move.b  d4,d7    ; restore sign/exponent
         rts              ; return to caller
 
* -arg1
fpami1:  move.b  d7,d5    ; test arg2's sign
         bmi.s   fpals    ; branch for like signs
         beq.s   fpart1   ; if zero return argument1
 
* -arg1 +arg2
* +arg1 -arg2
fpams:   moveq   #-128,d3  ; create a carry mask ($80)
         eor.b   d3,d5    ; strip sign off arg2 s+exp copy
         sub.b   d4,d5    ; compare magnitudes
         beq.s   fpaeq    ; branch equal magnitudes
         bmi.s   fpatlt   ; branch if arg1 larger
* arg1 <= arg2
         cmp.b   #24,d5   ; compare magnitude difference
         bcc.s   fpart2   ; branch arg2 much bigger
         move.b  d7,d4    ; arg2 s+exp dominates
         move.b  d3,d7    ; setup carry on arg2
         move.l  d6,d3    ; copy arg1
fpamss:  clr.b   d3       ; clear extraneous bits
         lsr.l   d5,d3    ; adjust for magnitude
         sub.l   d3,d7    ; subtract smaller from larger
         bmi.s   fparsr   ; return final result if no overflow

* mixed signs normalize
fpanor:  move.b  d4,d5    ; save correct sign
fpanrm:  clr.b   d7       ; clear subtract residue
         sub.b   #1,d4    ; make up for first shift
         cmp.l   #$00007fff,d7   ; ? small enough for swap
         bhi.s   fpaxqn   ; branch nope
         swap.w  d7       ; shift left 16 bits real fast
         subi.b  #16,d4   ; make up for 16 bit shift
fpaxqn:  add.l   d7,d7    ; shift up one bit
         dbmi    d4,fpaxqn ; decrement and branch if positive
         eor.b   d4,d5    ; ? same sign
         bmi.s   fpazro   ; branch underflow to zero
         move.b  d4,d7    ; restore sign/exponent
         beq.s   fpazro   ; return zero if exponent underflowed
         rts              ; return to caller

* exponent underflowed - return zero
fpazro:  moveq.l #0,d7    ; create a true zero
         rts              ; return to caller

* arg1 > arg2
fpatlt:  cmp.b   #-24,d5  ; ? arg1 >> arg2
         ble.s   fpart1   ; return it if so
         neg.b   d5       ; absolutize difference
         move.l  d7,d3    ; move arg2 as lower value
         move.l  d6,d7    ; set up arg1 as high
         move.b  #$80,d7  ; setup rounding bit
         bra.s   fpamss   ; perform the addition

* equal magnitudes
fpaeq:   move.b  d7,d5    ; save arg1 sign
         exg     d5,d4    ; swap arg2 with arg1 s+exp
         move.b  d6,d7    ; insure same low byte
         sub.l   d6,d7    ; obtain difference
         beq.s   fpazro   ; return zero if identical
         bpl.s   fpanor   ; branch if arg2 bigger
         neg.l   d7       ; correct difference to positive
         move.b  d5,d4    ; use arg2's sign + exponent
         bra.s   fpanrm   ; and go normalize

********************************************
*           ffpdiv subroutine              *
*                                          *
* input:                                   *
*        d6 - floating point divisor       *
*        d7 - floating point dividend      *
*                                          *
* output:                                  *
*        d7 - floating point quotient      *
*                                          *
* condition codes:                         *
*        n - set if result negative        *
*        z - set if result zero            *
*        v - set if result overflowed      *
*        c - undefined                     *
*        x - undefined                     *
*                                          *
* registers d3 thru d5 volatile            *
*                                          *
* code: 150 bytes     stack work: 0 bytes  *
*                                          *
* notes:                                   *
*   1) divisor is unaltered (d6).          *
*   2) underflows return zero without      *
*      any indicators set.                 *
*   3) overflows return the highest value  *
*      with the proper sign and the 'v'    *
*      bit set in the ccr.                 *
*   4) if a divide by zero is attempted    *
*      the divide by zero exception trap   *
*      is forced by this code with the     *
*      original arguments intact.  if the  *
*      exception returns with the denom-   *
*      inator altered the divide operation *
*      continues, otherwise an overflow    *
*      is forced with the proper sign.     *
*      the floating divide by zero can be  *
*      distinguished from true zero divide *
*      by the fact that it is an immediate *
*      zero dividing into register d7.     *
*                                          *
* time: (8 mhz no wait states assumed)     *
* dividend zero         5.250 microseconds *
* minimum time others  72.750 microseconds *
* maximum time others  85.000 microseconds *
* average others       76.687 microseconds *
*                                          *
********************************************

* divide by zero exit
fpddzr: divu.w #0,d7     ; **force divide by zero **
 
* if the exception returns with altered denominator - continue divide
         tst.l     d6        ; ? exception alter the zero
         bne.s     ffpdiv    ; branch if so to continue
* setup maximum number for divide overflow
fpdovf: ori.l   #$ffffff7f,d7 ; maximize with proper sign
       tst.b  d7        ; set condition code for sign
*      or.w   #$02,ccr  set overflow bit
       dc.l   $003c0002 ; ******sick assembler******
fpdrtn: rts              ; return to caller
 
* over or underflow detected
fpdov2:   swap.w    d6        ; restore arg1
         swap.w    d7        ; restore arg2 for sign
fpdovfs: eor.b  d6,d7     ; setup correct sign
        bra.s  fpdovf    ; and enter overflow handling
fpdouf: bmi.s  fpdovfs   ; branch if overflow
fpdund: move.l #0,d7     ; underflow to zero
        rts              ; and return to caller
 
***************
* entry point *
***************
 
* first subtract exponents
ffpdiv: move.b d6,d5    ; copy arg1 (divisor)
       beq.s  fpddzr    ; branch if divide by zero
       move.l d7,d4     ; copy arg2 (dividend)
       beq.s  fpdrtn    ; return zero if dividend zero
       moveq  #-128,d3  ; setup sign mask
       add.w  d5,d5     ; isolate arg1 sign from exponent
       add.w  d4,d4     ; isolate arg2 sign from exponent
       eor.b  d3,d5     ; adjust arg1 exponent to binary
       eor.b  d3,d4     ; adjust arg2 exponent to binary
       sub.b  d5,d4     ; subtract exponents
       bvs.s  fpdouf    ; branch if overflow/underflow
       clr.b  d7        ; clear arg2 s+exp
       swap.w d7        ; prepare high 16 bit compare
       swap.w d6        ; against arg1 and arg2
       cmp.w  d6,d7     ; ? check if overflow will occur
       bmi.s  fpdnov    ; branch if not
* adjust for fixed point ; divide overflow
       add.b  #2,d4     ; adjust exponent up one
       bvs.s  fpdov2    ; branch overflow here
       ror.l  #1,d7     ; shift down by power of two
fpdnov: swap.w d7       ; correct arg2
       move.b d3,d5     ; move $80 into d5.b
       eor.w  d5,d4     ; create sign and absolutize exponent
       lsr.w  #1,d4     ; d4.b now has sign+exponent of result
 
* now divide just using 16 bits into 24
       move.l d7,d3     ; copy arg1 for initial divide
       divu.w d6,d3     ; obtain test quotient
       move.w d3,d5     ; save test quotient
 
* now multiply 16-bit divide result times full 24 bit divisor and compare
* with the dividend.  multiplying back out with the full 24-bits allows
* us to see if the result was too large due to the 8 missing divisor bits
* used in the hardware divide.  the result can only be too large by 1 unit.
       mulu.w d6,d3     ; high divisor x quotient
       sub.l  d3,d7     ; d7=partial subtraction
       swap.w d7        ; to low divisor
       swap.w d6        ; rebuild arg1 to normal
       move.w d6,d3     ; setup arg1 for product
       clr.b  d3        ; zero low byte
       mulu.w d5,d3     ; find remaining product
       sub.l  d3,d7     ; now have full subtraction
       bcc.s  fpdqok    ; branch first 16 bits correct
 
* estimate too high, decrement quotient by one
       move.l d6,d3     ; rebuild divisor
       clr.b  d3        ; reverse halves
       add.l  d3,d7     ; add another divisor
       sub.w  #1,d5     ; decrement quotient
 
* compute last 8 bits with another divide.  the exact remainder from the
* multiply and compare above is divided again by a 16-bit only divisor.
* however, this time we require only 9 bits of accuracy in the result
* (8 to make 24 bits total and 1 extra bit for rounding purposes) and this
* divide always returns a precision of at least 9 bits.
fpdqok: move.l d6,d3    ; copy arg1 again
       swap.w d3        ; first 16 bits divisor in d3.w
       clr.w  d7        ; into first 16 bits of dividend
       divu.w d3,d7     ; obtain final 16 bit result
       swap.w d5        ; first 16 quotient to high half
       bmi.s  fpdisn    ; branch if normalized
* rare occurrance - unnormalized
* happends when mantissa arg1 < arg2 and they differ only in last 8 bits
       move.w d7,d5     ; insert low word of quotient
       add.l  d5,d5     ; shift mantissa left one
       sub.b  #1,d4     ; adjust exponent down (cannot zero)
       move.w d5,d7     ; cancel next instruction
 
* rebuild our final result and return
fpdisn: move.w d7,d5    ; append next 16 bits
       addi.l  #$80,d5  ; round to 24 bits (cannot overflow)
       move.l d5,d7     ; return in d7
       move.b d4,d7     ; finish result with sign+exponent
       beq.s  fpdund    ; underflow if zero exponent
       rts              ; return result to caller



********************************************
*          ffpmul2 subroutine              *
*                                          *
*   this module is the second of the       *
*   multiply routines.  it is 18% slower   *
*   but provides the highest accuracy      *
*   possible.  the error is exactly .5     *
*   least significant bit versus an error  *
*   in the high-speed default routine of   *
*   .50390625 least significant bit due    *
*   to truncation.                         *
*                                          *
* input:                                   *
*          d6 - floating point multiplier  *
*          d7 - floating point multiplican *
*                                          *
* output:                                  *
*          d7 - floating point result      *
*                                          *
* registers d3 thru d5 are volatile        *
*                                          *
* condition codes:                         *
*          n - set if result negative      *
*          z - set if result is zero       *
*          v - set if overflow occurred    *
*          c - undefined                   *
*          x - undefined                   *
*                                          *
* code: 134 bytes    stack work: 0 bytes   *
*                                          *
* notes:                                   *
*   1) multipier unaltered (d6).           *
*   2) underflows return zero with no      *
*      indicator set.                      *
*   3) overflows will return the maximum   *
*      value with the proper sign and the  *
*      'v' bit set in the ccr.             *
*                                          *
*  times: (8mhz no wait states assumed)    *
* arg1 zero            5.750 microseconds  *
* arg2 zero            3.750 microseconds  *
* minimum time others 45.750 microseconds  *
* maximum time others 61.500 microseconds  *
* average others      52.875 microseconds  *
*                                          *
********************************************
ffpmul2: move.b d7,d5   ; prepare sign/exponent work       4
       beq.s  ffmrtn    ; return if result already zero    8/10
       move.b d6,d4     ; copy arg1 sign/exponent          4
       beq.s  ffmrt0    ; return zero if arg1=0            8/10
       add.w  d5,d5     ; shift left by one                4
       add.w  d4,d4     ; shift left by one                4
       moveq  #-128,d3  ; prepare exponent modifier ($80)  4
       eor.b  d3,d4     ; adjust arg1 exponent to binary   4
       eor.b  d3,d5     ; adjust arg2 exponent to binary   4
       add.b  d4,d5     ; add exponents                    4
       bvs.s  ffmouf    ; branch if overflow/underflow     8/10
       move.b d3,d4     ; overlay $80 constant into d4     4
       eor.w  d4,d5     ; d5 now has sign and exponent     4
       ror.w  #1,d5     ; move to low 8 bits               8
       swap.w d5        ; save final s+exp in high word    4
       move.w d6,d5     ; copy arg1 low byte               4
       clr.b  d7        ; clear s+exp out of arg2          4
       clr.b  d5        ; clear s+exp out of arg1 low byte 4
       move.w d5,d4     ; prepare arg1lowb for multiply    4
       mulu.w d7,d4     ; d4 = arg2lowb x arg1lowb         38-54 (46)
       swap.w d4        ; place result in low word         4
       move.l d7,d3     ; copy arg2                        4
       swap.w d3        ; to arg2highw                     4
       mulu.w d5,d3     ; d3 = arg1lowb x arg2highw        38-54 (46)
       add.l  d3,d4     ; d4 = partial product (no carry)  8
       swap.w d6        ; to arg1 high two bytes           4
       move.l d6,d3     ; copy arg1highw over              4
       mulu.w d7,d3     ; d3 = arg2lowb x arg1highw        38-54 (46)
       add.l  d3,d4     ; d4 = partial product             8
       clr.w  d4        ; clear low end runoff             4
       addx.b d4,d4     ; shift in carry if any            4
       swap.w d4        ; put carry into high word         4
       swap.w d7        ; now top of arg2                  4
       mulu.w d6,d7     ; d7 = arg1highw x arg2highw       40-70 (54)
       swap.w d6        ; restore arg1                     4 
       swap.w d5        ; restore s+exp to low word
       add.l  d4,d7     ; add partial products             8
       bpl    ffmnor    ; branch if must normalize         8/10
       addi.l  #$80,d7  ; round up (cannot overflow)       16
       move.b d5,d7     ; insert sign and exponent         4
       beq.s  ffmrt0    ; return zero if zero exponent     8/10
ffmrtn: rts             ; return to caller                 16
 
* must normalize result
ffmnor: subi.b   #1,d5   ; bump exponent down by one        4
       bvs.s   ffmrt0   ; return zero if underflow         8/10
       bcs.s   ffmrt0   ; return zero if sign inverted     8/10
       moveq   #$40,d4  ; rounding factor                  4
       add.l   d4,d7    ; add in rounding factor           8
       add.l   d7,d7    ; shift to normalize               8
       bcc.s   ffmcln   ; return normalized number         8/10
       roxr.l  #1,d7    ; rounding forced carry in top bit 10
       addi.b   #1,d5    ; undo normalize attempt           4
ffmcln: move.b  d5,d7   ; insert sign and exponent         4
       beq.s   ffmrt0   ; return zero if exponent zero     8/10
       rts              ; return to caller                 16
 
* arg1 zero
ffmrt0: move.l #0,d7    ; return zero                      4
       rts              ; return to caller                 16
 
* overflow or underflow exponent
ffmouf: bpl.s  ffmrt0    ; branch if underflow to give zero 8/10
       eor.b  d6,d7     ; calculate proper sign            4
       ori.l   #$ffffff7f,d7 ; force highest value possible 16
       tst.b  d7        ; set sign in return code
       ori.b   #$02,ccr ; set overflow bit
       rts              ; return to caller                 16

	even
FinPrg:	dc.l 0



****************************************************************
*	ROUTINES TRIGONOMETRIQUES
**********************************
TB011C:
	MOVE.L	-$10(A6),-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	TB036C
	ADDQ.L	#8,A7
	MOVE.L	D0,-4(A6)
TB0130:
	CLR.L	-(A7)
	MOVE.L	-$10(A6),-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	TB036C
	ADDQ.L	#8,A7
	MOVE.L	D0,-(A7)
	JSR	TB018A
	ADDQ.L	#8,A7
	BGE.S	TB011C
	MOVE.L	-4(A6),-(A7)
	JSR	TB02E4
	ADDQ.L	#4,A7
	MOVE.L	D0,D7
	CLR.L	-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	TB018A
	ADDQ.L	#8,A7
	BGE.S	TB016E
	NEG.L	D7
TB016E:
	MOVE.L	D7,-(A7)
	JSR	TB0254
	ADDQ.L	#4,A7
	MOVE.L	D0,-8(A6)
	MOVE.L	-8(A6),D0
	TST.L	(A7)+
	MOVEM.L	(A7)+,D7
	UNLK	A6
	RTS

TB018A:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	MOVE.L	$C(A6),D6
	JSR	TB0520
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS


TB0254:
	LINK	A6,#0
	MOVEM.L	D5-D7,-(A7)
	TST.L	8(A6)
	BGE.S	TB0270
	MOVEQ	#1,D6
	MOVE.L	8(A6),D0
	NEG.L	D0
	MOVE.L	D0,8(A6)
	BRA.S	TB0272
TB0270:
	CLR.W	D6
TB0272:
	TST.L	8(A6)
	BNE.S	TB027C
	CLR.L	D0
	BRA.S	TB02DA
TB027C:
	MOVEQ	#$18,D7
	BRA.S	TB028C
TB0280:
	MOVE.L	8(A6),D0
	ASR.L	#1,D0
	MOVE.L	D0,8(A6)
	ADDQ.L	#1,D7
TB028C:
	MOVE.L	8(A6),D0
	ANDI.L	#$7F000000,D0
	BNE.S	TB0280
	BRA.S	TB02A6
TB029A:
	MOVE.L	8(A6),D0
	ASL.L	#1,D0
	MOVE.L	D0,8(A6)
	SUBQ.L	#1,D7
TB02A6:
	BTST	#7,9(A6)
	BEQ.S	TB029A
	MOVE.L	8(A6),D0
	ASL.L	#8,D0
	MOVE.L	D0,8(A6)
	ADDI.L	#$40,D7
	MOVE.L	D7,D0
	ANDI.L	#$7F,D0
	OR.L	D0,8(A6)
	TST.W	D6
	BEQ.S	TB02D6
	ORI.L	#$80,8(A6)
TB02D6:
	MOVE.L	8(A6),D0
TB02DA:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D6-D7
	UNLK	A6
	RTS
TB02E4:
	LINK	A6,#0
	MOVEM.L	D4-D7,-(A7)
	MOVE.L	8(A6),D0
	ANDI.L	#$7F,D0
	ADDI.L	#$FFFFFFC0,D0
	MOVE.W	D0,D6
	TST.L	8(A6)
	BEQ.S	TB0308
	TST.W	D6
	BGE.S	TB030C
TB0308:
	CLR.L	D0
	BRA.S	TB0362
TB030C:
	MOVE.L	8(A6),D0
	ANDI.L	#$80,D0
	MOVE.W	D0,D5
	CMP.W	#$1F,D6
	BLE.S	TB0332
	TST.W	D5
	BEQ.S	TB032A
	MOVE.L	#$80000000,D0
	BRA.S	TB0330
TB032A:
	MOVE.L	#$7FFFFFFF,D0
TB0330:
	BRA.S	TB0362
TB0332:
	MOVE.L	8(A6),D7
	ASR.L	#8,D7
	ANDI.L	#$FFFFFF,D7
	SUBI.W	#$18,D6
	BRA.S	TB0348
TB0344:
	ASR.L	#1,D7
	ADDQ.W	#1,D6
TB0348:
	TST.W	D6
	BLT.S	TB0344
	BRA.S	TB0352
TB034E:
	ASL.L	#1,D7
	SUBQ.W	#1,D6
TB0352:
	TST.W	D6
	BGT.S	TB034E
	TST.W	D5
	BEQ.S	TB0360
	MOVE.L	D7,D0
	NEG.L	D0
	MOVE.L	D0,D7
TB0360:
	MOVE.L	D7,D0
TB0362:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D5-D7
	UNLK	A6
	RTS

TB036C:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	MOVE.L	$C(A6),D6
	JSR	TB079E
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS


TB03D4:
	MOVEM.L	D1-D6/A0,-(A7)
	MOVE.B	D7,-(A7)
	ANDI.B	#$7F,D7
	MOVE.L	#$80000041,D6
	CLR.B	-(A7)
	CMP.B	D6,D7
	BCS.S	TB03FA
	BHI.S	TB03F0
	CMP.L	D6,D7
	BLS.S	TB03FA
TB03F0:
	NOT.B	(A7)
	EXG	D6,D7
	JSR	TB08A6
TB03FA:
	SUBI.B	#$43,D7
	NEG.B	D7
	CMP.B	#$1F,D7
	BLS.S	TB040A
	MOVEQ	#0,D6
	BRA.S	TB0442
TB040A:
	LSR.L	D7,D7
	MOVEQ	#0,D6
	MOVE.L	#$20000000,D5
	LEA	TB0B72,A0
	MOVEQ	#$18,D1
	MOVEQ	#1,D2
	BRA.S	TB0426
TB0420:
	ASR.L	D2,D4
	ADD.L	D4,D5
	ADD.L	(A0),D6
TB0426:
	MOVE.L	D7,D4
	MOVE.L	D5,D3
	ASR.L	D2,D3
TB042C:
	SUB.L	D3,D7
	BPL.S	TB0420
	MOVE.L	D4,D7
	ADDQ.L	#4,A0
	ADDQ.B	#1,D2
	LSR.L	#1,D3
	DBF	D1,TB042C
	JSR	TB0BDA
TB0442:
	MOVE.L	D6,D7
	TST.B	(A7)+
	BEQ.S	TB0454
	MOVE.L	#$C90FDB41,D7
	JSR	TB079E
TB0454:
	MOVE.B	(A7)+,D6
	TST.B	D7
	BEQ.S	TB0460
	ANDI.B	#$80,D6
	OR.B	D6,D7
TB0460:
	MOVEM.L	(A7)+,D1-D6/A0
	RTS
	MOVE.L	D6,-(A7)
	ANDI.B	#$7F,D7
	JSR	TB093E
	BVS.S	TB0494
	MOVE.L	D7,-(A7)
	MOVE.L	D7,D6
	MOVE.L	#$80000041,D7
	JSR	TB08A6
	MOVE.L	(A7)+,D6
	JSR	TB07B0
	BEQ.S	TB0494
	SUBQ.B	#1,D7
	BVC.S	TB0494
	MOVEQ	#0,D7
TB0494:
	MOVEM.L	(A7)+,D6
	RTS
TB049A:
	MOVE.L	D6,-(A7)
	JSR	TB093E
	BVS.S	TB04CE
	MOVE.L	D7,-(A7)
	MOVE.L	D7,D6
	MOVE.L	#$80000041,D7
	JSR	TB08A6
	MOVE.L	(A7),D6
	JSR	TB07B0
	BEQ.S	TB04C4
	SUBQ.B	#1,D7
	BVC.S	TB04C4
	MOVEQ	#0,D7
TB04C4:
	MOVE.L	D7,D6
	MOVE.L	(A7)+,D7
	JSR	TB079E
TB04CE:
	MOVEM.L	(A7)+,D6
	RTS
TB04D4:
	MOVE.L	D6,-(A7)
	TST.B	D7
	BEQ.S	TB050A
	ADDQ.B	#1,D7
	BVS.S	TB050E
	JSR	TB093E
	BVS.S	TB0518
	MOVE.L	D7,-(A7)
	MOVE.L	#$80000041,D6
	JSR	TB07B0
	MOVE.L	D7,-(A7)
	MOVE.L	4(A7),D7
	JSR	TB079E
	MOVE.L	(A7)+,D6
	JSR	TB08A6
	ADDQ.L	#4,A7
TB050A:
	MOVE.L	(A7)+,D6
	RTS
TB050E:
	MOVE.L	#$80000082,D7
	ROXR.B	#1,D7
	BRA.S	TB050A
TB0518:
	MOVE.L	#$80000041,D7
	BRA.S	TB050A
TB0520:
	TST.B	D6
	BPL.S	TB0530
	TST.B	D7
	BPL.S	TB0530
	CMP.B	D7,D6
	BNE.S	TB0536
	CMP.L	D7,D6
	RTS
TB0530:
	CMP.B	D6,D7
	BNE.S	TB0536
	CMP.L	D6,D7
TB0536:
	RTS
	TST.B	D7
	RTS
TB053C:
	TST.B	D7
	BPL.S	TB054C
	ANDI.B	#$7F,D7
	BSR.S	TB054C
	ORI.B	#2,CCR
	RTS
TB054C:
	JSR	TB0A18
	MOVEM.L	D3-D5,-(A7)
	JSR	TB0AE8
	MOVEM.L	(A7)+,D3-D5
	JMP	TB093E
	MOVE.W	#$FFFE,-(A7)
	BRA.S	TB0590
	MOVE.W	#$FFFF,-(A7)
	BRA.S	TB0586
TB0572:
	MOVE.W	#1,-(A7)
	BRA.S	TB0590
TB0578:
	CMP.B	#$B8,D7
	BHI.S	TB0590
TB057E:
	ADDQ.L	#2,A7
	TST.B	D7
	RTS
TB0584:
	CLR.W	-(A7)
TB0586:
	TST.B	D7
	BMI.S	TB0578
	CMP.B	#$38,D7
	BLS.S	TB057E
TB0590:
	MOVEM.L	D1-D6/A0,-(A7)
	MOVE.L	D7,D2
	ADD.B	D7,D7
	CMP.B	#$8A,D7
	BLS.S	TB05EE
	CMP.B	#$A8,D7
	BLS.S	TB05B0
	ORI.B	#2,CCR
	MOVEM.L	(A7)+,D1-D6/A0
	ADDQ.L	#2,A7
	RTS
TB05B0:
	MOVE.L	#$A2F9833E,D6
	MOVE.L	D2,D7
	JSR	TB0AE8
	MOVE.B	D7,D5
	ANDI.B	#$7F,D5
	SUBI.B	#$58,D5
	NEG.B	D5
	MOVEQ	#-1,D4
	CLR.B	D4
	LSL.L	D5,D4
	ORI.B	#$FF,D4
	AND.L	D4,D7
	MOVE.L	#$C90FDB43,D6
	JSR	TB0AE8
	MOVE.L	D7,D6
	MOVE.L	D2,D7
	JSR	TB079E
	MOVE.L	D7,D2
TB05EE:
	MOVE.L	#$C90FDAA,D4
	MOVE.L	D2,D7
	CLR.B	D7
	TST.B	D2
	BMI.S	TB0616
	SUBI.B	#$46,D2
	NEG.B	D2
	CMP.B	#$1F,D2
	BLS.S	TB060A
	MOVEQ	#0,D7
TB060A:
	LSR.L	D2,D7
TB060C:
	CMP.L	D4,D7
	BLE.S	TB0634
	SUB.L	D4,D7
	SUB.L	D4,D7
	BRA.S	TB060C
TB0616:
	SUBI.B	#$C6,D2
	NEG.B	D2
	CMP.B	#$1F,D2
	BLS.S	TB0624
	MOVEQ	#0,D7
TB0624:
	LSR.L	D2,D7
	NEG.L	D7
	NEG.L	D4
TB062A:
	CMP.L	D4,D7
	BGE.S	TB0634
	SUB.L	D4,D7
	SUB.L	D4,D7
	BRA.S	TB062A
TB0634:
	MOVEQ	#0,D5
	MOVE.L	#$EC916240,D6
	MOVE.L	#$3243F6A8,D4
	ASL.L	#3,D7
	BMI.S	TB064A
	NEG.L	D6
	NEG.L	D4
TB064A:
	ADD.L	D4,D7
	LEA	TB0B6E,A0
	MOVEQ	#$17,D1
	MOVEQ	#-1,D2
TB0656:
	ADDQ.W	#1,D2
	MOVE.L	D5,D3
	MOVE.L	D6,D4
	ASR.L	D2,D3
	ASR.L	D2,D4
	TST.L	D7
	BMI.S	TB0670
	SUB.L	D4,D5
	ADD.L	D3,D6
	SUB.L	(A0)+,D7
	DBF	D1,TB0656
	BRA.S	TB067A
TB0670:
	ADD.L	D4,D5
	SUB.L	D3,D6
	ADD.L	(A0)+,D7
	DBF	D1,TB0656
TB067A:
	MOVE.W	$1C(A7),D1
	BPL.S	TB06A4
	ADDQ.B	#1,D1
	BNE.S	TB06B6
	BSR.S	TB06C2
	MOVE.L	D6,D7
	MOVE.L	D5,D6
	BSR.S	TB06C2
	BEQ.S	TB069C
	JSR	TB08A6
TB0694:
	MOVEM.L	(A7)+,D1-D6/A0
	ADDQ.L	#2,A7
	RTS
TB069C:
	DC.W 	$FFFF
TB069E:
	DC.W 	$FF7F
	BRA.S	TB0694
TB06A4:
	BEQ.S	TB06A8
	MOVE.L	D5,D6
TB06A8:
	BSR.S	TB06C2
	MOVE.L	D6,D7
	TST.B	D7
	MOVEM.L	(A7)+,D1-D6/A0
	ADDQ.L	#2,A7
	RTS
TB06B6:
	MOVE.L	D5,-(A7)
	BSR.S	TB06C2
	MOVE.L	D6,$18(A7)
	MOVE.L	(A7)+,D6
	BRA.S	TB06A8
TB06C2:
	MOVE.L	D6,D4
	BMI.S	TB06D2
	CMP.L	#$FF,D6
	BHI.S	TB06DA
TB06CE:
	MOVEQ	#0,D6
	RTS
TB06D2:
	ASR.L	#8,D4
	ADDQ.L	#1,D4
	BNE.S	TB06DA
	BRA.S	TB06CE
TB06DA:
	JMP	TB0BDA
TB06E0:
	ANDI.B	#$7F,D7
	BSR.S	TB06EC
	ORI.B	#2,CCR
	RTS
TB06EC:
	MOVE.B	D7,D3
	BEQ.S	TB0740
	BMI.S	TB06E0
	LSR.B	#1,D3
	BCC.S	TB06FA
	ADDQ.B	#1,D3
	LSR.L	#1,D7
TB06FA:
	ADDI.B	#$20,D3
	SWAP	D3
	MOVE.W	#$17,D3
	LSR.L	#7,D7
	MOVE.L	D7,D4
	MOVE.L	D7,D5
	MOVE.L	A0,D6
	LEA	TB0742(PC),A0
	MOVE.L	#$800000,D7
	SUB.L	D7,D4
	SUBI.L	#$1200000,D5
	BRA.S	TB072C
TB0720:
	BSET	D3,D7
	MOVE.L	D5,D4
TB0724:
	ADD.L	D4,D4
	MOVE.L	D4,D5
	SUB.L	(A0)+,D5
	SUB.L	D7,D5
TB072C:
	DBMI	D3,TB0720
	DBPL	D3,TB0724
	BLS.S	TB0738
	ADDQ.L	#1,D7
TB0738:
	LSL.L	#8,D7
	MOVEA.L	D6,A0
	SWAP	D3
	MOVE.B	D3,D7
TB0740:
	RTS

TB0742:
	DC.B	0,$10,0,0,0,8,0,0
	DC.B	0,4,0,0,0,2,0,0
	DC.B	0,1,0,0,0,0,$80,0
	DC.B	0,0,$40,0,0,0,$20,0
	DC.B	0,0,$10,0,0,0,8,0
	DC.B	0,0,4,0,0,0,2,0
	DC.B	0,0,1,0,0,0,0,$80
	DC.B	0,0,0,$40,0,0,0,$20
	DC.B	0,0,0,$10,0,0,0,8
	DC.B	0,0,0,4,0,0,0,2
	DC.B	0,0,0,1,0,0,0,0
	DC.B	0,0,0,0

TB079E:
	MOVE.B 	D6,D4
	BEQ.S 	TB07F4
	EORI.B 	#$80,D4
	BMI.S	TB0812
	MOVE.B	D7,D5
	BMI.S	TB0818
	BNE.S	TB07BC
	BRA.S	TB07EE
TB07B0:
	MOVE.B	D6,D4
	BMI.S	TB0812
	BEQ.S	TB07F4
	MOVE.B	D7,D5
	BMI.S	TB0818
	BEQ.S	TB07EE
TB07BC:
	SUB.B	D4,D5
	BMI.S	TB07F8
	MOVE.B	D7,D4
	CMP.B	#$18,D5
	BCC.S	TB07F4
	MOVE.L	D6,D3
	CLR.B	D3
	LSR.L	D5,D3
	MOVE.B	#$80,D7
	ADD.L	D3,D7
	BCS.S	TB07DA
TB07D6:
	MOVE.B	D4,D7
	RTS
TB07DA:
	ROXR.L	#1,D7
	ADDQ.B	#1,D4
	BVS.S	TB07E2
	BCC.S	TB07D6
TB07E2:
	MOVEQ	#-1,D7
	SUBQ.B	#1,D4
	MOVE.B	D4,D7
	ORI.B	#2,CCR
	RTS
TB07EE:
	MOVE.L	D6,D7
	MOVE.B	D4,D7
	RTS
TB07F4:
	TST.B	D7
	RTS
TB07F8:
	CMP.B	#$E8,D5
	BLE.S	TB07EE
	NEG.B	D5
	MOVE.L	D6,D3
	CLR.B	D7
	LSR.L	D5,D7
	MOVE.B	#$80,D3
	ADD.L	D3,D7
	BCS.S	TB07DA
	MOVE.B	D4,D7
	RTS
TB0812:
	MOVE.B	D7,D5
	BMI.S	TB07BC
	BEQ.S	TB07EE
TB0818:
	MOVEQ	#-$80,D3
	EOR.B	D3,D5
	SUB.B	D4,D5
	BEQ.S	TB0870
	BMI.S	TB085E
	CMP.B	#$18,D5
	BCC.S	TB07F4
	MOVE.B	D7,D4
	MOVE.B	D3,D7
	MOVE.L	D6,D3
TB082E:
	CLR.B	D3
	LSR.L	D5,D3
	SUB.L	D3,D7
	BMI.S	TB07D6
TB0836:
	MOVE.B	D4,D5
TB0838:
	CLR.B	D7
	SUBQ.B	#1,D4
	CMP.L	#$7FFF,D7
	BHI.S	TB084A
	SWAP	D7
	SUBI.B	#$10,D4
TB084A:
	ADD.L	D7,D7
	DBMI	D4,TB084A
	EOR.B	D4,D5
	BMI.S	TB085A
	MOVE.B	D4,D7
	BEQ.S	TB085A
	RTS
TB085A:
	MOVEQ	#0,D7
	RTS
TB085E:
	CMP.B	#$E8,D5
	BLE.S	TB07EE
	NEG.B	D5
	MOVE.L	D7,D3
	MOVE.L	D6,D7
	MOVE.B	#$80,D7
	BRA.S	TB082E
TB0870:
	MOVE.B	D7,D5
	EXG	D5,D4
	MOVE.B	D6,D7
	SUB.L	D6,D7
	BEQ.S	TB085A
	BPL.S	TB0836
	NEG.L	D7
	MOVE.B	D5,D4
	BRA.S	TB0838
TB0882:
	DIVU	#0,D7
	TST.L	D6
	BNE.S	TB08A6
TB088A:
	ORI.L	#$FFFFFF7F,D7
	TST.B	D7
	ORI.B	#2,CCR
TB0896:
	RTS
TB0898:
	SWAP	D6
	SWAP	D7
TB089C:
	EOR.B	D6,D7
	BRA.S	TB088A
TB08A0:
	BMI.S	TB089C
TB08A2:
	MOVEQ	#0,D7
	RTS
TB08A6:
	MOVE.B	D6,D5
	BEQ.S	TB0882
	MOVE.L	D7,D4
	BEQ.S	TB0896
	MOVEQ	#-$80,D3
	ADD.W	D5,D5
	ADD.W	D4,D4
	EOR.B	D3,D5
	EOR.B	D3,D4
	SUB.B	D5,D4
	BVS.S	TB08A0
	CLR.B	D7
	SWAP	D7
	SWAP	D6
	CMP.W	D6,D7
	BMI.S	TB08CC
	ADDQ.B	#2,D4
	BVS.S	TB0898
	ROR.L	#1,D7
TB08CC:
	SWAP	D7
	MOVE.B	D3,D5
	EOR.W	D5,D4
	LSR.W	#1,D4
	MOVE.L	D7,D3
	DIVU	D6,D3
	MOVE.W	D3,D5
	MULU	D6,D3
	SUB.L	D3,D7
	SWAP	D7
	SWAP	D6
	MOVE.W	D6,D3
	CLR.B	D3
	MULU	D5,D3
	SUB.L	D3,D7
	BCC.S	TB08F4
	MOVE.L	D6,D3
	CLR.B	D3
	ADD.L	D3,D7
	SUBQ.W	#1,D5
TB08F4:
	MOVE.L	D6,D3
	SWAP	D3
	CLR.W	D7
	DIVU	D3,D7
	SWAP	D5
	BMI.S	TB0908
	MOVE.W	D7,D5
	ADD.L	D5,D5
	SUBQ.B	#1,D4
	MOVE.W	D5,D7
TB0908:
	MOVE.W	D7,D5
	ADDI.L	#$80,D5
	MOVE.L	D5,D7
	MOVE.B	D4,D7
	BEQ.S	TB08A2
	RTS
TB0918:
	MOVE.W	(A7)+,D6
	TST.B	D6
	BPL.S	TB0922
	MOVEQ	#0,D7
	BRA.S	TB092A
TB0922:
	MOVEQ	#-1,D7
	LSR.B	#1,D7
	ORI.B	#2,CCR
TB092A:
	MOVEM.L	(A7)+,D1-D6/A0
	RTS
TB0930:
	MOVE.L	#$80000041,D7
	LEA	$1E(A7),A7
	TST.B	D7
	RTS
TB093E:
	MOVEM.L	D1-D6/A0,-(A7)
	MOVE.W	D7,-(A7)
	BEQ.S	TB0930
	ANDI.B	#$7F,D7
	MOVE.L	D7,D2
	MOVE.L	#$B8AA3B41,D6
	JSR	TB0AE8
	BVS.S	TB0918
	MOVE.B	D7,D5
	MOVE.B	D7,D6
	SUBI.B	#$60,D5
	NEG.B	D5
	CMP.B	#$18,D5
	BLE.S	TB0918
	CMP.B	#$20,D5
	BGE.S	TB0992
	LSR.L	D5,D7
	MOVE.B	D7,(A7)
	LSL.L	D5,D7
	MOVE.B	D6,D7
	MOVE.L	#$B1721840,D6
	JSR	TB0AE8
	MOVE.L	D7,D6
	MOVE.L	D2,D7
	JSR	TB079E
	MOVE.L	D7,D2
	BRA.S	TB0996
TB0992:
	CLR.B	(A7)
	MOVE.L	D2,D7
TB0996:
	CLR.B	D7
	SUBI.B	#$43,D2
	NEG.B	D2
	CMP.B	#$1F,D2
	BLS.S	TB09A6
	MOVEQ	#0,D7
TB09A6:
	LSR.L	D2,D7
	MOVEQ	#0,D5
	MOVE.L	#$26A3D100,D6
	LEA	TB0C10,A0
	MOVEQ	#0,D2
	MOVEQ	#3,D1
	BSR.S	TB09F2
	SUBQ.L	#4,A0
	SUBQ.W	#1,D2
	MOVEQ	#9,D1
	BSR.S	TB09F2
	SUBQ.L	#4,A0
	SUBQ.W	#1,D2
	MOVEQ	#$A,D1
	BSR.S	TB09F2
	TST.B	1(A7)
	BPL.S	TB09D6
	NEG.L	D5
	NEG.B	(A7)
TB09D6:
	ADD.L	D5,D6
	JSR	TB0BDA
	MOVE.L	D6,D7
	ADD.B	(A7),D7
	BMI	TB0918
	BEQ	TB0918
	ADDQ.L	#2,A7
	MOVEM.L	(A7)+,D1-D6/A0
	RTS
TB09F2:
	ADDQ.W	#1,D2
	MOVE.L	D5,D3
	MOVE.L	D6,D4
	ASR.L	D2,D3
	ASR.L	D2,D4
	TST.L	D7
	BMI.S	TB0A0C
	ADD.L	D4,D5
	ADD.L	D3,D6
	SUB.L	(A0)+,D7
	DBF	D1,TB09F2
	RTS
TB0A0C:
	SUB.L	D4,D5
	SUB.L	D3,D6
	ADD.L	(A0)+,D7
	DBF	D1,TB09F2
	RTS
TB0A18:
	TST.B	D7
	BEQ.S	TB0A2A
	BPL.S	TB0A32
	ANDI.B	#$7F,D7
	BSR.S	TB0A32
TB0A24:
	ORI.B	#2,CCR
	RTS
TB0A2A:
	MOVEQ	#-1,D7
	JMP	TB0A24
TB0A32:
	MOVEM.L	D1-D6/A0,-(A7)
	MOVE.B	D7,-(A7)
	MOVE.B	#$41,D7
	MOVE.L	#$80000041,D6
	MOVE.L	D7,D2
	JSR	TB07B0
	EXG	D7,D2
	JSR	TB079E
	MOVE.L	D2,D6
	JSR	TB08A6
	BEQ.S	TB0AAA
	SUBI.B	#$43,D7
	NEG.B	D7
	CMP.B	#$1F,D7
	BLS.S	TB0A6A
	MOVEQ	#0,D7
TB0A6A:
	LSR.L	D7,D7
	MOVEQ	#0,D6
	MOVE.L	#$20000000,D5
	LEA	TB0C10,A0
	MOVEQ	#$16,D1
	MOVEQ	#1,D2
	BRA.S	TB0A86
TB0A80:
	ASR.L	D2,D4
	SUB.L	D4,D5
	ADD.L	(A0),D6
TB0A86:
	MOVE.L	D7,D4
	MOVE.L	D5,D3
	ASR.L	D2,D3
TB0A8C:
	SUB.L	D3,D7
	BPL.S	TB0A80
	MOVE.L	D4,D7
	ADDQ.L	#4,A0
	ADDQ.B	#1,D2
	LSR.L	#1,D3
	DBF	D1,TB0A8C
	MOVEQ	#0,D7
	JSR	TB0BDA
	BEQ.S	TB0AAA
	ADDQ.B	#1,D6
	MOVE.L	D6,D7
TB0AAA:
	MOVE.L	D7,D2
	MOVEQ	#0,D6
	MOVE.B	(A7)+,D6
	SUBI.B	#$41,D6
	BEQ.S	TB0AE2
	MOVE.B	D6,D1
	BPL.S	TB0ABC
	NEG.B	D6
TB0ABC:
	ROR.L	#8,D6
	MOVEQ	#$47,D5
TB0AC0:
	ADD.L	D6,D6
	DBMI	D5,TB0AC0
	MOVE.B	D5,D6
	ANDI.B	#$80,D1
	OR.B	D1,D6
	MOVE.L	#$B1721840,D7
	JSR	TB0AE8
	MOVE.L	D2,D6
	JSR	TB07B0
TB0AE2:
	MOVEM.L	(A7)+,D1-D6/A0
	RTS
TB0AE8:
	MOVE.B	D7,D5
	BEQ.S	TB0B3E
	MOVE.B	D6,D4
	BEQ.S	TB0B58
	ADD.W	D5,D5
	ADD.W	D4,D4
	MOVEQ	#-$80,D3
	EOR.B	D3,D4
	EOR.B	D3,D5
	ADD.B	D4,D5
	BVS.S	TB0B5C
	MOVE.B	D3,D4
	EOR.W	D4,D5
	ROR.W	#1,D5
	SWAP	D5
	MOVE.W	D6,D5
	CLR.B	D7
	CLR.B	D5
	MOVE.W	D5,D4
	MULU	D7,D4
	SWAP	D4
	MOVE.L	D7,D3
	SWAP	D3
	MULU	D5,D3
	ADD.L	D3,D4
	SWAP	D6
	MOVE.L	D6,D3
	MULU	D7,D3
	ADD.L	D3,D4
	CLR.W	D4
	ADDX.B	D4,D4
	SWAP	D4
	SWAP	D7
	MULU	D6,D7
	SWAP	D6
	SWAP	D5
	ADD.L	D4,D7
	BPL.S	TB0B40
	ADDI.L	#$80,D7
	MOVE.B	D5,D7
	BEQ.S	TB0B58
TB0B3E:
	RTS
TB0B40:
	SUBQ.B	#1,D5
	BVS.S	TB0B58
	BCS.S	TB0B58
	MOVEQ	#$40,D4
	ADD.L	D4,D7
	ADD.L	D7,D7
	BCC.S	TB0B52
	ROXR.L	#1,D7
	ADDQ.B	#1,D5
TB0B52:
	MOVE.B	D5,D7
	BEQ.S	TB0B58
	RTS
TB0B58:
	MOVEQ	#0,D7
	RTS
TB0B5C:
	DC.B	$6A,$FA,$BD,7,$8E,$BC,$FF,$FF
	DC.B	$FF,$7F,$4A,7,0,$3C,0,2
	DC.B	$4E,$75
TB0B6E:
	DC.B 	$19,$21,$FB,$54
TB0B72:
	DC.B	$E,$D6
	DC.B	$33,$82,7,$D6,$DD,$7E,3,$FA
	DC.B	$B7,$53,1,$FF,$55,$BB,0,$FF
	DC.B	$EA,$AD,0,$7F,$FD,$55,0,$3F
	DC.B	$FF,$AA,0,$1F,$FF,$F5,0,$F
	DC.B	$FF,$FE,0,7,$FF,$FF,0,3
	DC.B	$FF,$FF,0,1,$FF,$FF,0,0
	DC.B	$FF,$FF,0,0,$7F,$FF,0,0
	DC.B	$3F,$FF,0,0,$1F,$FF,0,0
	DC.B	$F,$FF,0,0,7,$FF,0,0
	DC.B	3,$FF,0,0,1,$FF,0,0
	DC.B	0,$FF,0,0,0,$7F,0,0
	DC.B	0,$3F,0,0,0,$1F,0,0
	DC.B	0,$F,0,0,0,7
TB0BDA:
	MOVEQ	#$42,D4
	TST.L	D6
	BEQ.S	TB0C0E
	BPL.S	TB0BE8
	NEG.L	D6
	MOVE.B	#$C2,D4
TB0BE8:
	CMP.L	#$7FFF,D6
	BHI.S	TB0BF6
	SWAP	D6
	SUBI.B	#$10,D4
TB0BF6:
	ADD.L	D6,D6
	DBMI	D4,TB0BF6
	TST.B	D6
	BPL.S	TB0C0C
	ADDI.L	#$100,D6
	BCC.S	TB0C0C
	ROXR.L	#1,D6
	ADDQ.B	#1,D4
TB0C0C:
	MOVE.B	D4,D6
TB0C0E:
	RTS
TB0C10:
	DC.B	$11,$93,$EA,$7A,8,$2C,$57,$7D
	DC.B	4,5,$62,$47,2,0,$AB,$11
	DC.B	1,0,$15,$58,0,$80,2,$AA
	DC.B	0,$40,0,$55,0,$20,0,$A
	DC.B	0,$10,0,1,0,8,0,0
	DC.B	0,4,0,0,0,2,0,0
	DC.B	0,1,0,0,0,0,$80,0
	DC.B	0,0,$40,0,0,0,$20,0
	DC.B	0,0,$10,0,0,0,8,0
	DC.B	0,0,4,0,0,0,2,0
	DC.B	0,0,1,0,0,0,0,$80
	DC.B	0,0,0,$40,0,0,0,$20

**********************************************************************
*	PARTIE ENTIERE
************************
INT:
	LINK	A6,#-4
	MOVEM.L	D6-D7,-(A7)
	CLR.L	-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	IB0028
	ADDQ.L	#8,A7
	BGE.S	IAFFFE
	MOVE.L	#$FFFFFE40,-(A7)
	MOVE.L	8(A6),-(A7)
	JSR	IB015E
	ADDQ.L	#8,A7
	MOVE.L	D0,8(A6)
IAFFFE:
	MOVE.L	8(A6),-(A7)
	JSR	IB00D6
	ADDQ.L	#4,A7
	MOVE.L	D0,D7
	MOVE.L	D7,-(A7)
	JSR	IB0046
	ADDQ.L	#4,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),D0
	TST.L	(A7)+
	MOVEM.L	(A7)+,D7
	UNLK	A6
	RTS
IB0028:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	MOVE.L	$C(A6),D6
	JSR	IB017E
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS

IB0046:
	LINK	A6,#0
	MOVEM.L	D5-D7,-(A7)
	TST.L	8(A6)
	BGE.S	IB0062
	MOVEQ	#1,D6
	MOVE.L	8(A6),D0
	NEG.L	D0
	MOVE.L	D0,8(A6)
	BRA.S	IB0064
IB0062:
	CLR.W	D6
IB0064:
	TST.L	8(A6)
	BNE.S	IB006E
	CLR.L	D0
	BRA.S	IB00CC
IB006E:
	MOVEQ	#$18,D7
	BRA.S	IB007E
IB0072:
	MOVE.L	8(A6),D0
	ASR.L	#1,D0
	MOVE.L	D0,8(A6)
	ADDQ.L	#1,D7
IB007E:
	MOVE.L	8(A6),D0
	ANDI.L	#$7F000000,D0
	BNE.S	IB0072
	BRA.S	IB0098
IB008C:
	MOVE.L	8(A6),D0
	ASL.L	#1,D0
	MOVE.L	D0,8(A6)
	SUBQ.L	#1,D7
IB0098:
	BTST	#7,9(A6)
	BEQ.S	IB008C
	MOVE.L	8(A6),D0
	ASL.L	#8,D0
	MOVE.L	D0,8(A6)
	ADDI.L	#$40,D7
	MOVE.L	D7,D0
	ANDI.L	#$7F,D0
	OR.L	D0,8(A6)
	TST.W	D6
	BEQ.S	IB00C8
	ORI.L	#$80,8(A6)
IB00C8:
	MOVE.L	8(A6),D0
IB00CC:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D6-D7
	UNLK	A6
	RTS

IB00D6:
	LINK	A6,#0
	MOVEM.L	D4-D7,-(A7)
	MOVE.L	8(A6),D0
	ANDI.L	#$7F,D0
	ADDI.L	#$FFFFFFC0,D0
	MOVE.W	D0,D6
	TST.L	8(A6)
	BEQ.S	IB00FA
	TST.W	D6
	BGE.S	IB00FE
IB00FA:
	CLR.L	D0
	BRA.S	IB0154
IB00FE:
	MOVE.L	8(A6),D0
	ANDI.L	#$80,D0
	MOVE.W	D0,D5
	CMP.W	#$1F,D6
	BLE.S	IB0124
	TST.W	D5
	BEQ.S	IB011C
	MOVE.L	#$80000000,D0
	BRA.S	IB0122
IB011C:
	MOVE.L	#$7FFFFFFF,D0
IB0122:
	BRA.S	IB0154
IB0124:
	MOVE.L	8(A6),D7
	ASR.L	#8,D7
	ANDI.L	#$FFFFFF,D7
	SUBI.W	#$18,D6
	BRA.S	IB013A
IB0136:
	ASR.L	#1,D7
	ADDQ.W	#1,D6
IB013A:
	TST.W	D6
	BLT.S	IB0136
	BRA.S	IB0144
IB0140:
	ASL.L	#1,D7
	SUBQ.W	#1,D6
IB0144:
	TST.W	D6
	BGT.S	IB0140
	TST.W	D5
	BEQ.S	IB0152
	MOVE.L	D7,D0
	NEG.L	D0
	MOVE.L	D0,D7
IB0152:
	MOVE.L	D7,D0
IB0154:
	TST.L	(A7)+
	MOVEM.L	(A7)+,D5-D7
	UNLK	A6
	RTS
IB015E:
	LINK	A6,#-4
	MOVEM.L	D3-D7,-(A7)
	MOVE.L	8(A6),D7
	MOVE.L	$C(A6),D6
	JSR	IB019A
	MOVE.L	D7,D0
	MOVEM.L	(A7)+,D3-D7
	UNLK	A6
	RTS
IB017E:
	TST.B	D6
	BPL.S	IB018E
	TST.B	D7
	BPL.S	IB018E
	CMP.B	D7,D6
	BNE.S	IB0194
	CMP.L	D7,D6
	RTS
IB018E:
	CMP.B	D6,D7
	BNE.S	IB0194
	CMP.L	D6,D7
IB0194:
	RTS
	TST.B	D7
	RTS
IB019A:
	MOVE.B	D6,D4
	BEQ.S	IB01F0
	EORI.B	#$80,D4
	BMI.S	IB020E
	MOVE.B	D7,D5
	BMI.S	IB0214
	BNE.S	IB01B8
	BRA.S	IB01EA
	MOVE.B	D6,D4
	BMI.S	IB020E
	BEQ.S	IB01F0
	MOVE.B	D7,D5
	BMI.S	IB0214
	BEQ.S	IB01EA
IB01B8:
	SUB.B	D4,D5
	BMI.S	IB01F4
	MOVE.B	D7,D4
	CMP.B	#$18,D5
	BCC.S	IB01F0
	MOVE.L	D6,D3
	CLR.B	D3
	LSR.L	D5,D3
	MOVE.B	#$80,D7
	ADD.L	D3,D7
	BCS.S	IB01D6
IB01D2:
	MOVE.B	D4,D7
	RTS
IB01D6:
	ROXR.L	#1,D7
	ADDQ.B	#1,D4
	BVS.S	IB01DE
	BCC.S	IB01D2
IB01DE:
	MOVEQ	#-1,D7
	SUBQ.B	#1,D4
	MOVE.B	D4,D7
	ORI.B	#2,CCR
	RTS
IB01EA:
	MOVE.L	D6,D7
	MOVE.B	D4,D7
	RTS
IB01F0:
	TST.B	D7
	RTS
IB01F4:
	CMP.B	#$E8,D5
	BLE.S	IB01EA
	NEG.B	D5
	MOVE.L	D6,D3
	CLR.B	D7
	LSR.L	D5,D7
	MOVE.B	#$80,D3
	ADD.L	D3,D7
	BCS.S	IB01D6
	MOVE.B	D4,D7
	RTS
IB020E:
	MOVE.B	D7,D5
	BMI.S	IB01B8
	BEQ.S	IB01EA
IB0214:
	MOVEQ	#-$80,D3
	EOR.B	D3,D5
	SUB.B	D4,D5
	BEQ.S	IB026C
	BMI.S	IB025A
	CMP.B	#$18,D5
	BCC.S	IB01F0
	MOVE.B	D7,D4
	MOVE.B	D3,D7
	MOVE.L	D6,D3
IB022A:
	CLR.B	D3
	LSR.L	D5,D3
	SUB.L	D3,D7
	BMI.S	IB01D2
IB0232:
	MOVE.B	D4,D5
IB0234:
	CLR.B	D7
	SUBQ.B	#1,D4
	CMP.L	#$7FFF,D7
	BHI.S	IB0246
	SWAP	D7
	SUBI.B	#$10,D4
IB0246:
	ADD.L	D7,D7
	DBMI	D4,IB0246
	EOR.B	D4,D5
	BMI.S	IB0256
	MOVE.B	D4,D7
	BEQ.S	IB0256
	RTS
IB0256:
	MOVEQ	#0,D7
	RTS
IB025A:
	CMP.B	#$E8,D5
	BLE.S	IB01EA
	NEG.B	D5
	MOVE.L	D7,D3
	MOVE.L	D6,D7
	MOVE.B	#$80,D7
	BRA.S	IB022A
IB026C:
	MOVE.B	D7,D5
	EXG	D5,D4
	MOVE.B	D6,D7
	SUB.L	D6,D7
	BEQ.S	IB0256
	BPL.S	IB0232
	NEG.L	D7
	MOVE.B	D5,D4
	BRA.S	IB0234

