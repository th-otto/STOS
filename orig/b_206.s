marcel	EQU	$11DDF0
trap0	EQU	$80
*logic	EQU	$11DDE8
vector	EQU	$11DE14
*res	EQU	$11DDEC
*mous102	EQU	$11DC12
_bufltype	EQU	0
end_adr	EQU	$11DDE4
*path	EQU	$11DE95
*newpath	EQU	$11DED5
*folder	EQU	$11DE8F
*pic_low	EQU	$11DF15
*pic_hi	EQU	$11DF1D
*curs_off	EQU	$11DE8C
*sprit	EQU	$11DF25
L11DF32	EQU	$11DF32
L11DF3F	EQU	$11DF3F
*music	EQU	$11DF4C
bidon	EQU	$11DCE2
L11DF6A	EQU	$11DF6A
ext_name	EQU	$11DF66
tos104	EQU	$11DF6C
tos106	EQU	$11DF79
basic	EQU	$11DF59
*sav_col	EQU	$11DDF4
color0	EQU	$FF8240
berr	EQU	8
LFC0002	EQU	$FC0002
*dat	EQU	$11DC10
trap6	EQU	$98
LE00002	EQU	$E00002
puns	EQU	1
_buflFATtyp	EQU	2
_bufldrive	EQU	3
*dta	EQU	$11DDB2
roger	EQU	$11DDD0
*handle	EQU	$11DDEE
hector	EQU	$11DDCC

TEXT	BRA	start

dat	DC.W	$0102
mous102
	DC.L	$2740,$E4F,$C76,$26E6,$27A8,$E22,$E8A
	
	DC.W	$0100
	DC.L	$26A0,$E09,$DB0,$2686,$2748,$DDC,$E44
	
	DC.W	$0101
	DC.L	$26A0,$E09,$DB0,$2686,$2748,$DDC,$E44
	
	DC.W	$0104
	DC.L	$2882,$E6B,$C92,$2828,$28EA,$E3E,$EA6
	
	DC.W	$0106
	DC.L	$28C2,$EAB,$CD2,$2868,$292A,$E7E,$EE6
	
	DC.W	-1
	DS.W	14
	DC.W	-1
	
L11DCC6	DC.W
L11DCC8	DC.W
L11DCCA	DC.W
L11DCCC	DC.W
L11DCCE	DC.W
L11DCD0	DC.W
L11DCD2	DC.W
L11DCD4	DC.W
L11DCD6	DC.W
L11DCD8	DC.W
L11DCDA	DC.W
L11DCDC	DC.W
L11DCDE	DC.W
L11DCE0	DC.W
bidon	DC.W
L11DCE4	DC.W
L11DCE6	DC.W
L11DCE8	DC.W
L11DCEA	DC.W
L11DCEC	DC.W
L11DCEE	DC.W
L11DCF0	DC.W
L11DCF2	DC.W
L11DCF4	DC.W
L11DCF6	DC.W
L11DCF8	DC.W
L11DCFA	DC.W
L11DCFC	DC.W
L11DCFE	DC.W
L11DD00	DC.W
L11DD02	DC.W
L11DD04	DC.W
L11DD06	DC.W
L11DD08	DC.W
L11DD0A	DC.W
L11DD0C	DC.W
L11DD0E	DC.W
L11DD10	DC.W
L11DD12	DC.W
L11DD14	DC.W
L11DD16	DC.W
L11DD18	DC.W
L11DD1A	DC.W
L11DD1C	DC.W
L11DD1E	DC.W
L11DD20	DC.W
L11DD22	DC.W
L11DD24	DC.W
L11DD26	DC.W
L11DD28	DC.W
L11DD2A	DC.W
L11DD2C	DC.W
L11DD2E	DC.W
L11DD30	DC.W
L11DD32	DC.W
L11DD34	DC.W
L11DD36	DC.W
L11DD38	DC.W
L11DD3A	DC.W
L11DD3C	DC.W
L11DD3E	DC.W
L11DD40	DC.W
L11DD42	DC.W
L11DD44	DC.W
L11DD46	DC.W
L11DD48	DC.W
L11DD4A	DC.W
L11DD4C	DC.W
L11DD4E	DC.W
L11DD50	DC.W
L11DD52	DC.W
L11DD54	DC.W
L11DD56	DC.W
L11DD58	DC.W
L11DD5A	DC.W
L11DD5C	DC.W
L11DD5E	DC.W
L11DD60	DC.W
L11DD62	DC.W
L11DD64	DC.W
L11DD66	DC.W
L11DD68	DC.W
L11DD6A	DC.W
L11DD6C	DC.W
L11DD6E	DC.W
L11DD70	DC.W
L11DD72	DC.W
L11DD74	DC.W
L11DD76	DC.W
L11DD78	DC.W
L11DD7A	DC.W
L11DD7C	DC.W
L11DD7E	DC.W
L11DD80	DC.W
L11DD82	DC.W
L11DD84	DC.W
L11DD86	DC.W
L11DD88	DC.W
L11DD8A	DC.W
L11DD8C	DC.W
L11DD8E	DC.W
L11DD90	DC.W
L11DD92	DC.W
L11DD94	DC.W
L11DD96	DC.W
L11DD98	DC.W
L11DD9A	DC.W
L11DD9C	DC.W
L11DD9E	DC.W
L11DDA0	DC.W
L11DDA2	DC.W
L11DDA4	DC.W
L11DDA6	DC.W
L11DDA8	DC.W
L11DDAA	DC.W
L11DDAC	DC.W
L11DDAE	DC.W
L11DDB0	DC.W
dta	DC.W
L11DDB4	DC.W
L11DDB6	DC.W
L11DDB8	DC.W
L11DDBA	DC.W
L11DDBC	DC.W
L11DDBE	DC.W
L11DDC0	DC.W
L11DDC2	DC.W
L11DDC4	DC.W
L11DDC6	DC.W
L11DDC8	DC.W
L11DDCA	DC.W
hector	DC.W
L11DDCE	DC.W
roger	DC.W
L11DDD2	DC.W
L11DDD4	DC.W
L11DDD6	DC.W
L11DDD8	DC.W
L11DDDA	DC.W
L11DDDC	DC.W
L11DDDE	DC.W
L11DDE0	DC.W
L11DDE2	DC.W
end_adr	DC.W
L11DDE6	DC.W
logic	DC.W
L11DDEA	DC.W
res	DC.W
handle	DC.W
marcel	DC.W
L11DDF2	DC.W
sav_col	DC.W
L11DDF6	DC.W
L11DDF8	DC.W
L11DDFA	DC.W
L11DDFC	DC.W
L11DDFE	DC.W
L11DE00	DC.W
L11DE02	DC.W
L11DE04	DC.W
L11DE06	DC.W
L11DE08	DC.W
L11DE0A	DC.W
L11DE0C	DC.W
L11DE0E	DC.W
L11DE10	DC.W
L11DE12	DC.W
vector	DC.W
L11DE16	DC.W
L11DE18	DC.W
L11DE1A	DC.W
L11DE1C	DC.W
L11DE1E	DC.W
L11DE20	DC.W
L11DE22	DC.W
L11DE24	DC.W
L11DE26	DC.W
L11DE28	DC.W
L11DE2A	DC.W
L11DE2C	DC.W
L11DE2E	DC.W
L11DE30	DC.W
L11DE32	DC.W
L11DE34	DC.W
L11DE36	DC.W
L11DE38	DC.W
L11DE3A	DC.W
L11DE3C	DC.W
L11DE3E	DC.W
L11DE40	DC.W
L11DE42	DC.W
L11DE44	DC.W
L11DE46	DC.W
L11DE48	DC.W
L11DE4A	DC.W
L11DE4C	DC.W
L11DE4E	DC.W
L11DE50	DC.W
L11DE52	DC.W
L11DE54	DC.W
L11DE56	DC.W
L11DE58	DC.W
L11DE5A	DC.W
L11DE5C	DC.W
L11DE5E	DC.W
L11DE60	DC.W
L11DE62	DC.W
L11DE64	DC.W
L11DE66	DC.W
L11DE68	DC.W
L11DE6A	DC.W
L11DE6C	DC.W
L11DE6E	DC.W
L11DE70	DC.W
L11DE72	DC.W
L11DE74	DC.W
L11DE76	DC.W
L11DE78	DC.W
L11DE7A	DC.W
L11DE7C	DC.W
L11DE7E	DC.W
L11DE80	DC.W
L11DE82	DC.W
L11DE84	DC.W
L11DE86	DC.W
L11DE88	DC.W


curs_off
	DC.B	27,$66,0
folder	DC.B	"\STOS",0
	
path	ds.b	64
newpath	DS.b	64
piclow	DC.B	"PIC.PI1",0
pichi	DC.B	"PIC.PI3",0
sprit	DC.B	"SPRITE???.BIN",0
windo	DC.B	"WINDO???.BIN",0
float	DC.B	"FLOAT???.BIN",0
music	DC.B	"MUSIC???.BIN",0
basic	DC.B	"BASIC???.BIN",0
ext_nam	DC.B	"*.EX"
extlet	dc.b	0,0
tos104	DC.B	27,"Y",$37,$30,"TOS 1.04",0
tos106	DC.B	27,"Y",$37,$44,"TOS 1.06",0

start
	CLR.L	marcel
	MOVEA.L	4(A7),A0
	LEA	trap0(A0),A0
	TST.B	(A0)
	BEQ.S	get_logic
	ADDQ.L	#1,A0
	MOVE.L	A0,marcel

get_logic
	MOVE.W	#3,-(A7)
	TRAP	#$E
	ADDQ.L	#2,A7
	MOVE.L	D0,logic
	PEA	sav_vect(PC)
	MOVE.W	#$26,-(A7)
	TRAP	#$E
	ADDQ.L	#6,A7
	LEA	vector(PC),A6
	MOVE.W	#4,-(A7)
	TRAP	#$E
	ADDQ.L	#2,A7
	MOVE.W	D0,res
	LEA	mous102(PC),A5
	MOVEA.L	$C(A5),A0
	MOVEQ	#$2C,D0
bcl1:
	MOVE.W	(A0)+,(A6)+
	DBF	D0,bcl1
	MOVEA.L	$10(A5),A0
	MOVEQ	#$B,D0
bcl2:
	MOVE.W	(A0)+,(A6)+
	DBF	D0,bcl2
	MOVEA.L	DATA(A5),A0
	MOVE.L	(A0),(A6)+
	MOVE.L	#$11E476,end_adr
	BSR	set_dta
	CLR.W	-(A7)
	PEA	path(PC)
	MOVE.W	#$47,-(A7)
	TRAP	#1
	ADDQ.L	#8,A7
	TST.W	D0
	BNE	set_scr
	LEA	path(PC),A0
	LEA	newpath(PC),A1
bcl3:
	MOVE.B	(A0)+,(A1)+
	BNE.S	bcl3
	LEA	path(PC),A0
	TST.B	(A0)
	BNE.S	lbl1
	MOVE.B	#$5C,(A0)+
	CLR.B	(A0)
lbl1:
	SUBQ.L	#1,A1
	LEA	folder(PC),A0
bcl4:
	MOVE.B	(A0)+,(A1)+
	BNE.S	bcl4
	LEA	newpath(PC),A0
	BSR	set_path
	BNE	display
	CMPI.W	#2,res
	BEQ.S	hi_res
	LEA	piclow(PC),A0
	BRA.S	affiche
hi_res:
	LEA	pichi(PC),A0
affiche:
	BSR	fs_first
	BNE	prepare
	BSR	fopen
	MOVEA.L	logic(PC),A0
	SUBA.L	#$8000,A0
	MOVE.L	#$7D22,D0
	BSR	fread
	BSR	fclose
	DC.W	$A00A
	TST.W	res
	BEQ	fix_scr
	CMPI.W	#2,res
	BEQ	fix_scr
	MOVE.W	#0,-(A7)
	MOVE.L	#$FFFFFFFF,-(A7)
	MOVE.L	#$FFFFFFFF,-(A7)
	MOVE.W	#5,-(A7)
	TRAP	#$E
	ADDA.L	#$C,A7
fix_scr:
	LEA	curs_off(PC),A0
	BSR	print
	MOVE.L	logic(PC),-(A7)
	SUBI.L	#$7FFE,(A7)
	MOVE.W	#6,-(A7)
	TRAP	#$E
	ADDQ.L	#6,A7
	MOVEQ	#1,D6
copy_scr:
	MOVEA.L	logic(PC),A2
	MOVEA.L	A2,A3
	ADDA.L	#$3DE0,A2
	ADDA.L	#$3E80,A3
	MOVEA.L	A2,A0
	MOVEA.L	A3,A1
	SUBA.L	#$7FDE,A0
	SUBA.L	#$7FDE,A1
	MOVEQ	#$63,D7
	ADDQ.W	#1,D6
	CMP.W	#$64,D6
	BHI	load
	MOVEQ	#$32,D5
bcl5:
	ADD.W	D6,D5
	CMP.W	#$64,D5
	BCS.S	cpy_scr
	SUBI.W	#$64,D5
	MOVEM.L	A0-A3,-(A7)
	MOVEQ	#9,D0
bcl6:
	MOVE.L	(A0)+,(A2)+
	MOVE.L	(A0)+,(A2)+
	MOVE.L	(A0)+,(A2)+
	MOVE.L	(A0)+,(A2)+
	MOVE.L	(A1)+,(A3)+
	MOVE.L	(A1)+,(A3)+
	MOVE.L	(A1)+,(A3)+
	MOVE.L	(A1)+,(A3)+
	DBF	D0,bcl6
	MOVEM.L	(A7)+,A0-A3
	SUBA.L	#$A0,A2
	ADDA.L	#$A0,A3
cpy_scr:
	SUBA.L	#$A0,A0
	ADDA.L	#$A0,A1
	DBF	D7,bcl5
	BRA	copy_scr
prepare:
	DC.W	$A00A
	LEA	curs_off(PC),A0
	BSR	print
load:
	LEA	sprit(PC),A0
	BSR	get_im
	LEA	mous102(PC),A3
	JSR	(A0)
	MOVE.L	A0,end_adr
	LEA	windo(PC),A0
	BSR	get_im
	LEA	mous102(PC),A3
	JSR	(A0)
	MOVE.L	A0,end_adr
	LEA	float(PC),A0
	BSR	get_bin
	BNE	load_zik
	LEA	mous102(PC),A3
	JSR	(A0)
load_zik:
	LEA	music(PC),A0
	BSR	get_im
	LEA	mous102(PC),A3
	JSR	(A0)
	MOVE.L	A0,end_adr
	CLR.W	D7
	LEA	bidon(PC),A6
load_ext:
	MOVE.B	D7,extlet
	ADDI.B	#$41,extlet
	LEA	ext_nam(PC),A0
	BSR	fsfirst
	BNE.S	nextext
	LEA	ext_nam(PC),A0
	BSR	get_im
	MOVEM.L	D6-D7/A6,-(A7)
	LEA	mous102(PC),A3
	JSR	(A0)
	MOVE.L	A0,end_adr
	MOVEM.L	(A7)+,D6-D7/A6
	MOVE.W	D7,D6
	LSL.W	#2,D6
	MOVE.L	A1,0(A6,D6.W)
nextext:
	ADDQ.W	#1,D7
	CMP.W	#$1A,D7
	BCS.S	load_ext
	LEA	tos104(PC),A0
	CMPI.W	#2,res
	BNE.S	low
	LEA	tos106(PC),A0
low:
	BSR	print
	LEA	basic(PC),A0
	BSR	get_im
	MOVE.L	A0,-(A7)
	LEA	path(PC),A0
	BSR	set_path
	MOVEA.L	(A7)+,A6
	MOVE.W	#$25,-(A7)
	TRAP	#$E
	ADDQ.L	#2,A7
	MOVEA.L	logic(PC),A0
	MOVE.W	#$1F3F,D0
bcl6:
	CLR.L	(A0)+
	DBF	D0,bcl6
	CMPI.W	#2,res
	BEQ.S	hi
	MOVE.W	#1,-(A7)
	MOVE.L	#$FFFFFFFF,-(A7)
	MOVE.L	#$FFFFFFFF,-(A7)
	MOVE.W	#5,-(A7)
	TRAP	#$E
	ADDA.W	#$C,A7
hi:
	LEA	bidon(PC),A0
	LEA	mous102(PC),A3
	MOVEA.L	marcel(PC),A4
	CLR.L	D0
	JSR	(A6)
	BRA	set_scr
display:
	BSR	fclose
	LEA	path(PC),A0
	BSR	set_path
set_scr:
	MOVE.W	res(PC),-(A7)
	MOVE.L	logic(PC),-(A7)
	MOVE.L	logic(PC),-(A7)
	MOVE.W	#5,-(A7)
	TRAP	#$E
	ADDA.W	#$C,A7
	LEA	vector(PC),A6
	LEA	mous102(PC),A5
	MOVEA.L	$C(A5),A0
	MOVEQ	#$2C,D0
bcl7:
	MOVE.W	(A6)+,(A0)+
	DBF	D0,bcl7
	MOVEA.L	$10(A5),A0
	MOVEQ	#$B,D0
bcl8:
	MOVE.W	(A6)+,(A0)+
	DBF	D0,bcl8
	MOVEA.L	DATA(A5),A0
	MOVE.L	(A6)+,(A5)
	PEA	sav_col(PC)
	MOVE.W	#6,-(A7)
	TRAP	#$E
	ADDQ.L	#6,A7
	MOVE.W	#$25,-(A7)
	TRAP	#$E
	ADDQ.L	#2,A7
	CLR.W	-(A7)
	TRAP	#1
sav_vect:
	LEA	color0,A0
	LEA	sav_col(PC),A1
	MOVEQ	#$F,D0
bcl8:
	MOVE.W	(A0)+,(A1)+
	DBF	D0,bcl8
	MOVE.L	berr,D1
	MOVE.L	#$11E31E,berr
	MOVE.L	A7,D2
	MOVE.W	LFC0002,D0
chg_vect:
	MOVEA.L	D2,A7
	MOVE.L	D1,berr
	LEA	dat(PC),A0
	MOVEQ	#6,D1
bcl9:
	CMP.W	(A0)+,D0
	BEQ.S	put_vect
	ADDA.W	#$1C,A0
	DBF	D1,bcl9
	LEA	mous102(PC),A0
put_vect:
	LEA	mous102(PC),A2
	MOVEQ	#6,D0
bcl10:
	MOVE.L	(A0)+,(A2)+
	DBF	D0,bcl10
	MOVE.L	#fake_fl,D0
	MOVE.L	D0,trap6
	RTS
	MOVE.W	LE00002,D0
	BRA.S	chg_vect
fake_fl	CMP.B	#$C,D0
	BEQ.S	fltoa
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	RTE
fltoa:
	MOVE.B	#$30,(A0)
	MOVE.B	#$2E,puns(A0)
	MOVE.B	#$30,_buflFATtype(A0)
	CLR.B	_bufldrive(A0)
	RTE
set_dta:
	MOVE.L	A0,-(A7)
	PEA	dta(PC)
	MOVE.W	#$1A,-(A7)
	TRAP	#1
	ADDQ.L	#6,A7
	MOVEA.L	(A7)+,A0
	RTS
set_path:
	MOVE.L	A0,-(A7)
	MOVE.W	#$3B,-(A7)
	TRAP	#1
	ADDQ.L	#6,A7
	TST.W	D0
	RTS
fs_first:
	CLR.W	-(A7)
	MOVE.L	A0,-(A7)
	MOVE.W	#$4E,-(A7)
	TRAP	#1
	ADDQ.L	#8,A7
	LEA	roger(PC),A0
	TST.W	D0
	RTS
fopen:
	CLR.W	-(A7)
	MOVE.L	A0,-(A7)
	MOVE.W	#$3D,-(A7)
	TRAP	#1
	ADDQ.L	#8,A7
	TST.W	D0
	BMI	display
	MOVE.W	D0,handle
	RTS
charge:
	MOVE.L	hector,D0
fread:
	MOVE.L	A0,-(A7)
	MOVE.L	D0,-(A7)
	MOVE.W	handle(PC),-(A7)
	MOVE.W	#$3F,-(A7)
	TRAP	#1
	ADDA.L	#$C,A7
	TST.L	D0
	BMI	display
	RTS
fclose:
	MOVE.W	handle(PC),-(A7)
	MOVE.W	#$3E,-(A7)
	TRAP	#1
	ADDQ.L	#4,A7
	RTS
print:
	MOVE.L	A0,-(A7)
	MOVE.W	#9,-(A7)
	TRAP	#1
	ADDQ.L	#6,A7
	RTS
get_im:
	BSR	get_bin
	BNE	display
	RTS
get_bin:
	MOVEM.L	D1-D3/A1-A3,-(A7)
	BSR	set_dta
	BSR	fs_first
	BNE	failed
	MOVE.L	end_adr(PC),D3
	ADD.L	hector(PC),D3
	ADDI.L	#$EA60,D3
	CMP.L	logic(PC),D3
	BCC	display
	BSR	fopen
	MOVEA.L	end_adr(PC),A0
	BSR	charge
	BSR	fclose
	MOVEA.L	end_adr(PC),A1
	MOVE.L	_buflFATtype(A1),D0
	ADD.L	6(A1),D0
	ANDI.L	#$FFFFFF,D0
	ADDA.W	#$1C,A1
	MOVEA.L	A1,A2
	MOVE.L	A2,D2
	ADDA.L	D0,A1
	CLR.L	D0
	TST.L	(A1)
	BEQ.S	mouline
	ADDA.L	(A1)+,A2
	BRA.S	L11E444
err:
	MOVE.B	(A1)+,D0
	BEQ.S	mouline
	CMP.B	#1,D0
	BEQ.S	do_asc
	ADDA.W	D0,A2
L11E444:
	ADD.L	D2,(A2)
	BRA.S	err
do_asc:
	ADDA.W	#$FE,A2
	BRA.S	err
mouline:
	MOVEA.L	end_adr(PC),A0
	MOVE.L	A0,D0
	ADD.L	hector(PC),D0
	BTST	#0,D0
	BEQ.S	pair
	ADDQ.L	#1,D0
pair:
	MOVE.L	D0,end_adr
	MOVEM.L	(A7)+,D1-D3/A1-A3
	MOVEQ	#0,D0
	RTS
failed:
	MOVEM.L	(A7)+,D1-D3/A1-A3
	MOVEQ	#1,D0
	RTS
