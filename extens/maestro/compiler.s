		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "equates.inc"
		.include "lib.inc"

PSG  =	 $ffff8800

iera =   $fffffa07
ipra =   $fffffa0b
isra =   $fffffa0f
imra =   $fffffa13
vr   =   $fffffa17
tacr =   $fffffa19
tadr =   $fffffa1f

TYPE_FORWARD       = 1
TYPE_BACKWARD      = 2
TYPE_LOOP_FORWARD  = 3
TYPE_LOOP_BACKWARD = 4
TYPE_SWEEP         = 5

		.text

* Define extension addresses

start:
	dc.l	para-start		; parameter definitions
	dc.l	entry-start		; reserve data area for program
	dc.l	lib1-start		; start of library

catalog:
	dc.w	lib2-lib1
	dc.w	lib3-lib2
	dc.w	lib4-lib3
	dc.w	lib5-lib4
	dc.w	lib6-lib5
	dc.w	lib7-lib6
	dc.w	lib8-lib7
	dc.w	lib9-lib8
	dc.w	lib10-lib9
	dc.w	lib11-lib10
	dc.w	lib12-lib11
	dc.w	lib13-lib12
	dc.w	lib14-lib13
	dc.w	lib15-lib14
	dc.w	lib16-lib15
	dc.w	lib17-lib16
	dc.w	lib18-lib17
	dc.w	lib19-lib18
	dc.w	lib20-lib19
	dc.w	lib21-lib20
	dc.w	lib22-lib21
	dc.w	lib23-lib22
	dc.w	lib24-lib23
	dc.w	lib25-lib24
	dc.w	lib26-lib25
	dc.w	lib27-lib26
	dc.w	lib28-lib27
	dc.w	lib29-lib28
	dc.w	lib30-lib29
	dc.w	lib31-lib30
	dc.w	lib32-lib31
	dc.w	lib33-lib32
	dc.w	lib34-lib33
	dc.w	lib35-lib34
	dc.w	lib36-lib35
	dc.w	lib37-lib36
	dc.w	libex-lib37

para:
	dc.w	37			; number of library routines
	dc.w	37			; number of extension commands
	.dc.w l001-para
	.dc.w l002-para
	.dc.w l003-para
	.dc.w l004-para
	.dc.w l005-para
	.dc.w l006-para
	.dc.w l007-para
	.dc.w l008-para
	.dc.w l009-para
	.dc.w l010-para
	.dc.w l011-para
	.dc.w l012-para
	.dc.w l013-para
	.dc.w l014-para
	.dc.w l015-para
	.dc.w l016-para
	.dc.w l017-para
	.dc.w l018-para
	.dc.w l019-para
	.dc.w l020-para
	.dc.w l021-para
	.dc.w l022-para
	.dc.w l023-para
	.dc.w l024-para
	.dc.w l025-para
	.dc.w l026-para
	.dc.w l027-para
	.dc.w l028-para
	.dc.w l029-para
	.dc.w l030-para
	.dc.w l031-para
	.dc.w l032-para
	.dc.w l033-para
	.dc.w l034-para
	.dc.w l035-para
	.dc.w l036-para
	.dc.w l037-para


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,1,1,0             ; sound init
l002:	.dc.b I,1,1,0             ; sample
l003:	.dc.b 0,I,1,1,0           ; samplay
l004:	.dc.b I,1,1,0             ; samplace
l005:	.dc.b 0,1,1,0             ; samspeed manual
l006:
l008:
l010:
l012:
l014:
l016:
l018:
l020:
l022:
l024:
l026:
l028:
l030:
l032:
l033:
l034:
l036:
        .dc.b I,1,1,0
l007:	.dc.b 0,1,1,0             ; samspeed_auto
l009:	.dc.b 0,I,1,1,0           ; samspeed N
l011:	.dc.b 0,1,1,0             ; samstop
l013:	.dc.b 0,1,1,0             ; samloop_off
l015:	.dc.b 0,1,1,0             ; samloop_on
l017:	.dc.b 0,1,1,0             ; samdir_forward
l019:	.dc.b 0,1,1,0             ; samdir_backward
l021:	.dc.b 0,1,1,0             ; samsweep_on
l023:	.dc.b 0,1,1,0             ; samsweep_off
l025:	.dc.b 0,I,',',I,1,1,0     ; samraw
l027:	.dc.b 0,I,',',I,1,1,0     ; samrecord
l029:	.dc.b 0,I,',',I,',',I,1,1,0 ; samcopy
l031:	.dc.b 0,I,',',S,1,1,0     ; sammusic
l035:	.dc.b 0,1,1,0             ; samthru
l037:	.dc.b 0,I,1,1,0           ; sambank

		.even

entry:  bra.w init

snd_init:
	dc.b 0,0
	dc.b 1,0
	dc.b 2,0
	dc.b 3,0
	dc.b 4,0
	dc.b 5,0
	dc.b 6,0
	dc.b 7,255
	dc.b 8,0
	dc.b 9,0
	dc.b 10,0
	dc.b 11,0
	dc.b 12,0
	dc.b 13,0
	dc.b -1,0

sampleno: ds.l 1
auto_on: ds.w 1
speed_override: ds.w 1
type: dc.w 1
speed: dc.b 41
	.even

playbankno: dc.w 5


hertz:
	dc.b 0,0,0,0,115,91,75,63,54,47,41,36,32,28,25,22,20,18,16
	dc.b 14,13,11,10,9,8,7,6,5,4,3,2,1,0,0
	even

startaddr: ds.l 1
startaddr2: ds.l 1
length: ds.l 1
length2: ds.l 1

* Conversion table as used in stos maestro

voldat2:
	dc.l $08000000,$09000000,$0a000000,$00000000
	dc.l $08000000,$09000000,$0a000100,$00000000
	dc.l $08000100,$09000100,$0a000000,$00000000
	dc.l $08000100,$09000100,$0a000100,$00000000
	dc.l $08000200,$09000200,$0a000000,$00000000
	dc.l $08000200,$09000200,$0a000100,$00000000
	dc.l $08000300,$09000100,$0a000000,$00000000
	dc.l $08000300,$09000100,$0a000100,$00000000
	dc.l $08000400,$09000000,$0a000000,$00000000
	dc.l $08000400,$09000100,$0a000100,$00000000
	dc.l $08000400,$09000200,$0a000000,$00000000
	dc.l $08000400,$09000200,$0a000100,$00000000
	dc.l $08000500,$09000000,$0a000000,$00000000
	dc.l $08000500,$09000100,$0a000100,$00000000
	dc.l $08000500,$09000200,$0a000000,$00000000
	dc.l $08000500,$09000200,$0a000100,$00000000
	dc.l $08000500,$09000300,$0a000000,$00000000
	dc.l $08000500,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000200,$0a000000,$00000000
	dc.l $08000600,$09000200,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000000,$00000000
	dc.l $08000600,$09000300,$0a000000,$00000000
	dc.l $08000600,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000100,$00000000
	dc.l $08000600,$09000300,$0a000200,$00000000
	dc.l $08000600,$09000300,$0a000200,$00000000
	dc.l $08000600,$09000300,$0a000200,$00000000
	dc.l $08000700,$09000000,$0a000000,$00000000
	dc.l $08000700,$09000100,$0a000100,$00000000
	dc.l $08000700,$09000200,$0a000100,$00000000
	dc.l $08000700,$09000200,$0a000200,$00000000
	dc.l $08000700,$09000400,$0a000000,$00000000
	dc.l $08000700,$09000400,$0a000100,$00000000
	dc.l $08000700,$09000400,$0a000200,$00000000
	dc.l $08000700,$09000400,$0a000300,$00000000
	dc.l $08000800,$09000300,$0a000000,$00000000
	dc.l $08000800,$09000300,$0a000200,$00000000
	dc.l $08000800,$09000400,$0a000000,$00000000
	dc.l $08000800,$09000400,$0a000200,$00000000
	dc.l $08000800,$09000500,$0a000000,$00000000
	dc.l $08000800,$09000500,$0a000100,$00000000
	dc.l $08000800,$09000500,$0a000200,$00000000
	dc.l $08000800,$09000500,$0a000300,$00000000
	dc.l $08000900,$09000000,$0a000100,$00000000
	dc.l $08000900,$09000000,$0a000100,$00000000
	dc.l $08000900,$09000200,$0a000200,$00000000
	dc.l $08000900,$09000200,$0a000200,$00000000
	dc.l $08000a00,$09000300,$0a000000,$00000000
	dc.l $08000a00,$09000300,$0a000100,$00000000
	dc.l $08000a00,$09000300,$0a000200,$00000000
	dc.l $08000a00,$09000300,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000100,$00000000
	dc.l $08000a00,$09000400,$0a000100,$00000000
	dc.l $08000a00,$09000400,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000200,$00000000
	dc.l $08000a00,$09000400,$0a000300,$00000000
	dc.l $08000a00,$09000400,$0a000300,$00000000
	dc.l $08000a00,$09000400,$0a000400,$00000000
	dc.l $08000a00,$09000400,$0a000400,$00000000
	dc.l $08000a00,$09000400,$0a000400,$00000000
	dc.l $08000a00,$09000400,$0a000500,$00000000
	dc.l $08000a00,$09000400,$0a000500,$00000000
	dc.l $08000a00,$09000400,$0a000500,$00000000
	dc.l $08000a00,$09000500,$0a000000,$00000000
	dc.l $08000a00,$09000500,$0a000200,$00000000
	dc.l $08000a00,$09000500,$0a000300,$00000000
	dc.l $08000a00,$09000500,$0a000400,$00000000
	dc.l $08000a00,$09000600,$0a000000,$00000000
	dc.l $08000a00,$09000600,$0a000200,$00000000
	dc.l $08000a00,$09000600,$0a000300,$00000000
	dc.l $08000a00,$09000600,$0a000400,$00000000
	dc.l $08000a00,$09000600,$0a000500,$00000000
	dc.l $08000a00,$09000700,$0a000000,$00000000
	dc.l $08000a00,$09000700,$0a000000,$00000000
	dc.l $08000a00,$09000700,$0a000100,$00000000
	dc.l $08000a00,$09000700,$0a000200,$00000000
	dc.l $08000a00,$09000700,$0a000200,$00000000
	dc.l $08000a00,$09000700,$0a000300,$00000000
	dc.l $08000a00,$09000700,$0a000400,$00000000
	dc.l $08000b00,$09000000,$0a000000,$00000000
	dc.l $08000b00,$09000100,$0a000000,$00000000
	dc.l $08000b00,$09000100,$0a000100,$00000000
	dc.l $08000b00,$09000200,$0a000000,$00000000
	dc.l $08000b00,$09000200,$0a000100,$00000000
	dc.l $08000b00,$09000300,$0a000000,$00000000
	dc.l $08000b00,$09000300,$0a000200,$00000000
	dc.l $08000b00,$09000400,$0a000000,$00000000
	dc.l $08000b00,$09000400,$0a000200,$00000000
	dc.l $08000b00,$09000400,$0a000300,$00000000
	dc.l $08000b00,$09000400,$0a000400,$00000000
	dc.l $08000b00,$09000600,$0a000000,$00000000
	dc.l $08000b00,$09000600,$0a000200,$00000000
	dc.l $08000b00,$09000600,$0a000300,$00000000
	dc.l $08000b00,$09000600,$0a000400,$00000000
	dc.l $08000b00,$09000800,$0a000000,$00000000
	dc.l $08000b00,$09000800,$0a000100,$00000000
	dc.l $08000b00,$09000800,$0a000300,$00000000
	dc.l $08000b00,$09000800,$0a000400,$00000000
	dc.l $08000b00,$09000900,$0a000000,$00000000
	dc.l $08000b00,$09000900,$0a000200,$00000000
	dc.l $08000b00,$09000900,$0a000300,$00000000
	dc.l $08000b00,$09000900,$0a000400,$00000000
	dc.l $08000c00,$09000400,$0a000000,$00000000
	dc.l $08000c00,$09000400,$0a000000,$00000000
	dc.l $08000c00,$09000400,$0a000100,$00000000
	dc.l $08000c00,$09000400,$0a000100,$00000000
	dc.l $08000c00,$09000500,$0a000200,$00000000
	dc.l $08000c00,$09000500,$0a000200,$00000000
	dc.l $08000c00,$09000500,$0a000300,$00000000
	dc.l $08000c00,$09000500,$0a000300,$00000000
	dc.l $08000c00,$09000500,$0a000400,$00000000
	dc.l $08000c00,$09000500,$0a000400,$00000000
	dc.l $08000c00,$09000600,$0a000000,$00000000
	dc.l $08000c00,$09000600,$0a000100,$00000000
	dc.l $08000c00,$09000600,$0a000200,$00000000
	dc.l $08000c00,$09000600,$0a000400,$00000000
	dc.l $08000c00,$09000700,$0a000000,$00000000
	dc.l $08000c00,$09000700,$0a000200,$00000000
	dc.l $08000c00,$09000700,$0a000400,$00000000
	dc.l $08000c00,$09000800,$0a000000,$00000000
	dc.l $08000c00,$09000800,$0a000200,$00000000
	dc.l $08000c00,$09000800,$0a000300,$00000000
	dc.l $08000c00,$09000800,$0a000400,$00000000
	dc.l $08000c00,$09000900,$0a000000,$00000000
	dc.l $08000c00,$09000900,$0a000200,$00000000
	dc.l $08000c00,$09000900,$0a000300,$00000000
	dc.l $08000d00,$09000000,$0a000000,$00000000
	dc.l $08000d00,$09000100,$0a000000,$00000000
	dc.l $08000d00,$09000100,$0a000100,$00000000
	dc.l $08000d00,$09000200,$0a000100,$00000000
	dc.l $08000d00,$09000300,$0a000100,$00000000
	dc.l $08000d00,$09000300,$0a000200,$00000000
	dc.l $08000d00,$09000400,$0a000000,$00000000
	dc.l $08000d00,$09000400,$0a000200,$00000000
	dc.l $08000d00,$09000400,$0a000300,$00000000
	dc.l $08000d00,$09000400,$0a000400,$00000000
	dc.l $08000d00,$09000500,$0a000300,$00000000
	dc.l $08000d00,$09000500,$0a000400,$00000000
	dc.l $08000d00,$09000600,$0a000300,$00000000
	dc.l $08000d00,$09000600,$0a000400,$00000000
	dc.l $08000d00,$09000700,$0a000000,$00000000
	dc.l $08000d00,$09000700,$0a000200,$00000000
	dc.l $08000d00,$09000700,$0a000300,$00000000
	dc.l $08000d00,$09000700,$0a000400,$00000000
	dc.l $08000d00,$09000700,$0a000500,$00000000
	dc.l $08000d00,$09000700,$0a000500,$00000000
	dc.l $08000d00,$09000800,$0a000000,$00000000
	dc.l $08000d00,$09000800,$0a000200,$00000000
	dc.l $08000d00,$09000800,$0a000400,$00000000
	dc.l $08000d00,$09000800,$0a000500,$00000000
	dc.l $08000d00,$09000900,$0a000100,$00000000
	dc.l $08000d00,$09000900,$0a000300,$00000000
	dc.l $08000d00,$09000900,$0a000400,$00000000
	dc.l $08000d00,$09000900,$0a000500,$00000000
	dc.l $08000d00,$09000900,$0a000500,$00000000
	dc.l $08000d00,$09000900,$0a000600,$00000000
	dc.l $08000d00,$09000900,$0a000600,$00000000
	dc.l $08000d00,$09000900,$0a000600,$00000000
	dc.l $08000d00,$09000a00,$0a000100,$00000000
	dc.l $08000d00,$09000a00,$0a000200,$00000000
	dc.l $08000d00,$09000a00,$0a000300,$00000000
	dc.l $08000d00,$09000a00,$0a000300,$00000000
	dc.l $08000d00,$09000a00,$0a000400,$00000000
	dc.l $08000d00,$09000a00,$0a000500,$00000000
	dc.l $08000d00,$09000a00,$0a000500,$00000000
	dc.l $08000d00,$09000a00,$0a000600,$00000000
	dc.l $08000d00,$09000b00,$0a000000,$00000000
	dc.l $08000d00,$09000b00,$0a000100,$00000000
	dc.l $08000d00,$09000b00,$0a000200,$00000000
	dc.l $08000d00,$09000b00,$0a000300,$00000000
	dc.l $08000d00,$09000b00,$0a000400,$00000000
	dc.l $08000d00,$09000b00,$0a000400,$00000000
	dc.l $08000d00,$09000b00,$0a000500,$00000000
	dc.l $08000d00,$09000b00,$0a000500,$00000000
	dc.l $08000e00,$09000000,$0a000000,$00000000
	dc.l $08000e00,$09000000,$0a000100,$00000000
	dc.l $08000e00,$09000300,$0a000000,$00000000
	dc.l $08000e00,$09000300,$0a000200,$00000000
	dc.l $08000e00,$09000400,$0a000300,$00000000
	dc.l $08000e00,$09000400,$0a000500,$00000000
	dc.l $08000e00,$09000500,$0a000400,$00000000
	dc.l $08000e00,$09000500,$0a000500,$00000000
	dc.l $08000e00,$09000700,$0a000000,$00000000
	dc.l $08000e00,$09000700,$0a000300,$00000000
	dc.l $08000e00,$09000700,$0a000400,$00000000
	dc.l $08000e00,$09000700,$0a000400,$00000000
	dc.l $08000e00,$09000800,$0a000200,$00000000
	dc.l $08000e00,$09000800,$0a000400,$00000000
	dc.l $08000e00,$09000800,$0a000500,$00000000
	dc.l $08000e00,$09000800,$0a000500,$00000000
	dc.l $08000e00,$09000900,$0a000000,$00000000
	dc.l $08000e00,$09000900,$0a000100,$00000000
	dc.l $08000e00,$09000900,$0a000200,$00000000
	dc.l $08000e00,$09000900,$0a000300,$00000000
	dc.l $08000e00,$09000900,$0a000500,$00000000
	dc.l $08000e00,$09000900,$0a000500,$00000000
	dc.l $08000e00,$09000900,$0a000600,$00000000
	dc.l $08000e00,$09000900,$0a000700,$00000000
	dc.l $08000e00,$09000a00,$0a000000,$00000000
	dc.l $08000e00,$09000a00,$0a000500,$00000000
	dc.l $08000e00,$09000a00,$0a000800,$00000000
	dc.l $08000e00,$09000a00,$0a000900,$00000000
	dc.l $08000e00,$09000b00,$0a000300,$00000000
	dc.l $08000e00,$09000b00,$0a000600,$00000000
	dc.l $08000e00,$09000b00,$0a000800,$00000000
	dc.l $08000e00,$09000b00,$0a000900,$00000000
	dc.l $08000e00,$09000c00,$0a000000,$00000000
	dc.l $08000e00,$09000c00,$0a000100,$00000000
	dc.l $08000e00,$09000c00,$0a000200,$00000000
	dc.l $08000e00,$09000c00,$0a000300,$00000000
	dc.l $08000e00,$09000c00,$0a000400,$00000000
	dc.l $08000e00,$09000c00,$0a000400,$00000000
	dc.l $08000e00,$09000c00,$0a000500,$00000000
	dc.l $08000e00,$09000c00,$0a000500,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000600,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000c00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000000,$00000000
	dc.l $08000e00,$09000d00,$0a000100,$00000000
	dc.l $08000e00,$09000d00,$0a000200,$00000000
	dc.l $08000e00,$09000d00,$0a000200,$00000000
	dc.l $08000e00,$09000d00,$0a000300,$00000000
	dc.l $08000e00,$09000d00,$0a000400,$00000000
	dc.l $08000e00,$09000d00,$0a000500,$00000000
	dc.l $08000e00,$09000d00,$0a000500,$00000000
	dc.l $08000e00,$09000d00,$0a000600,$00000000
	dc.l $08000e00,$09000d00,$0a000600,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000700,$00000000
	dc.l $08000e00,$09000d00,$0a000800,$00000000
	dc.l $08000e00,$09000d00,$0a000800,$00000000
	dc.l $08000e00,$09000e00,$0a000000,$00000000
	dc.l $08000e00,$09000e00,$0a000000,$00000000
	dc.l $08000e00,$09000e00,$0a000100,$00000000
	dc.l $08000e00,$09000e00,$0a000100,$00000000
	dc.l $08000e00,$09000e00,$0a000200,$00000000
	dc.l $08000e00,$09000e00,$0a000200,$00000000
	dc.l $08000e00,$09000e00,$0a000300,$00000000
	dc.l $08000e00,$09000e00,$0a000300,$00000000
	dc.l $08000e00,$09000e00,$0a000400,$00000000
	dc.l $08000e00,$09000e00,$0a000500,$00000000
	dc.l $08000e00,$09000e00,$0a000600,$00000000
	dc.l $08000e00,$09000e00,$0a000600,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000
	dc.l $08000e00,$09000e00,$0a000700,$00000000

init:
		lea.l      exit(pc),a2
exit:
		rts


* forward normal play routine *

playirq1:
		movem.l    d7/a0/a3,-(a7)
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi        outofit1
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3)+,d7
		move.l     a3,(a0)
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte

outofit1:
		bclr       #5,iera              ; disable interrupt
		movem.l    (a7)+,d7/a0/a3       ; stack back
		rte

* backward normal play routine *

playirq2:
		movem.l    d7/a0/a3,-(a7)
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi        outofit1
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		subq.l     #1,a3
		move.l     a3,(a0)
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte

* forward loop play routine *

playirq3:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit2
		addq.l     #1,(a0)
intoit2:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit2:
		move.l     length2(pc),(a3)
		move.l     startaddr2(pc),(a0)
		bra.s      intoit2

* backward loop play routine *

playirq4:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit3
		subq.l     #1,(a0)
intoit3:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit3:
		move.l     length2(pc),(a3)
		move.l     startaddr2(pc),(a0)
		bra.s      intoit3

* sweep play routine *

playirq5:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit4
		addq.l     #1,(a0)
intoit4:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit4:
		move.l     length2(pc),(a3)
		lea        playirq6(pc),a3
		move.l     a3,0x0134
		bra.s      intoit4


playirq6:
		movem.l    d7/a0/a3,-(a7)
		lea        startaddr(pc),a0
		movea.l    (a0),a3
		moveq      #0,d7
		move.b     (a3),d7
		lea        length(pc),a3
		subq.l     #1,(a3)
		bmi.s      outofit5
		subq.l     #1,(a0)
intoit5:
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a0/a3
		rte
outofit5:
		move.l     length2(pc),(a3)
		lea        playirq5(pc),a3
		move.l     a3,0x0134
		bra.s      intoit5

* record interrupt routine *
recirq:
		movem.l    d7/a0/a3,-(a7)       ; save regs on stack
		lea        length(pc),a3
		subq.l     #1,(a3)              ; length -1
		bmi.s      routofit             ; end, exit
		lea        startaddr(pc),a0
		movea.l    (a0),a3              ; start address
		moveq      #0,d7                ; clr word
		move.b     0x00FB0001,d7        ; get input data
		move.b     d7,(a3)+             ; save it in memory
		move.l     a3,(a0)              ; start address +1
		lea.l      voldat2(pc),a3       ; volume convert table
		lsl.w      #4,d7                ; d7 * 16
		move.l     0(a3,d7.w),PSG       ; data for volume 1
		move.l     4(a3,d7.w),PSG       ; data for volume 2
		move.l     8(a3,d7.w),PSG       ; data for volume 3
		movem.l    (a7)+,d7/a0/a3       ; stack stuff back
		rte
routofit:
		clr.l      (a3)
		bclr       #5,iera              ; clear timer a interrupt
		movem.l    (a7)+,d7/a0/a3       ; stack stuff back
		rte


thruirq:
		movem.l    d7/a3,-(a7)
		move.b     $00FB0001,d7         ; get input data
		andi.w     #255,d7
		lea.l      voldat2(pc),a3
		lsl.w      #4,d7
		move.l     0(a3,d7.w),PSG
		move.l     4(a3,d7.w),PSG
		move.l     8(a3,d7.w),PSG
		movem.l    (a7)+,d7/a3
		rte


realplaysam:
		movea.l    d3,a1
		cmpi.b     #'M',(a1)
		bne        nosampledata
		cmpi.b     #'A',1(a1)
		bne        nosampledata
		cmpi.b     #'E',2(a1)
		bne        nosampledata
		cmpi.b     #'S',3(a1)
		bne        nosampledata
		cmpi.b     #'T',4(a1)
		bne        nosampledata
		cmpi.b     #'R',5(a1)
		bne        nosampledata
		cmpi.b     #'O',6(a1)
		bne        nosampledata
		cmpi.b     #'!',7(a1)
		bne        nosampledata
		move.l     a1,-(a7)
		clr.w      d7
samplay1:
		addq.l     #8,a1
		addq.w     #1,d7
		tst.l      (a1)
		bne.s      samplay1
		subq.w     #1,d7
		movea.l    (a7)+,a1
		movea.l    a1,a0
		move.l     sampleno-entry(a3),d3
		tst.b     d3
		beq        samplenotfound
		cmp.b      d7,d3
		bgt        samplenotfound
		andi.l     #255,d3
		lsl.w      #3,d3
		adda.l     d3,a1
		adda.l     (a1),a0
		movea.l    4(a1),a1
		lea        -20(a1),a1
		addq.l     #8,a0

* Sample play routine, includes code for forward,back,loop,sweep
* Also can be used with samples that include their sample rate,
* if no sample rate is found within the sample then the current
* sample rate is used.

* ON ENTRY:
*            A0.L = START ADDRESS OF PLAY
*            A1.L = LENGTH IN BYTES TO PLAY
*          TYPE.W = 1 - FORWARD PLAY
*                 = 2 - BACKWARD PLAY
*                 = 3 - FORWARD LOOP
*                 = 4 - BACKWARD LOOP
*                 = 5 - SWEEP PLAY
*       AUTO_ON.W = 0 - SAMPLE SPEED MANUAL ( USES CURRENT RATE )
*                 = 1 - SAMPLE SPEED AUTO ( SEARCHES FOR RATE STORED )

*         SPEED.B = 5-32 SAMPLE RATE ( IGNORED IF AUTO_ON = 1 )


* I.E,
* 
* 	LEA SAMSTART,A0		; START ADDRESS
*       LEA SAMLENGTH,A1	; LENGTH TO PLAY
*	MOVE.W #1,TYPE		; NORMAL FORWARD PLAY
*       MOVE.W #1,AUTO_ON	; AUTO SPEED SEARCH
*	JSR PLAYSAM		; PLAY THE SAMPLE

* The above code could only be used with files saved using stos maestro
* as auto_on is set to 1, this tells the play routine to search for
* the sample rate which is found after a three byte code saved with
* every stos maestro file, if the code is not found ( a replay or pro-sound 
* file is to be played ) then the current sample rate is used.


realplayraw:
playsam:
		move.l     a0,startaddr-entry(a3)         ; start address store
		move.l     a1,length-entry(a3)  ; length store
		move.l     a0,startaddr2-entry(a3)  ; backup
		move.l     a1,length2-entry(a3) ; backup
		move.w     sr,d7                ; save status
		move.w     #0x2700,sr           ; kill interrupts

		clr.b      tacr                 ; stop timer a
		move.b     #1,tacr              ; start timer a
		tst.w      auto_on-entry(a3)    ; auto mode ?
		beq.s      noton                ; no, dont search
		cmpi.b     #'J',(a0)            ; check code digit 1
		bne        nospeed              ; not found use set rate
		cmpi.b     #'O',1(a0)           ; check digit 2
		bne        nospeed              ; not found
		cmpi.b     #'N',2(a0)           ; check digit 3
		bne        nospeed              ; not found
		moveq      #0,d3
		move.b     3(a0),d3             ; 4th byte is the rate
		lea.l      hertz-entry(a3),a0   ; start of rate conversion table
		move.b     0(a0,d3.w),d3        ; get timer a data for samrate
		addi.b     #19,d3               ; add 19 timer ticks
		bra.s      skipnxt              ; store timer a data & skip next bit

noton:
		tst.w      speed_override-entry(a3)
		beq.s      noton1
		move.b     speed-entry(a3),d3
		bra.s      skipnxt
noton1:
		move.b     speed-entry(a3),d3   ; speed in d3
		addi.b     #19,d3               ; add 19 ticks
skipnxt:
		move.b     d3,tadr              ; store the data

		ori.b      #0x20,imra           ; timer a mask
		ori.b      #0x20,iera           ; timer a enable
		bclr       #3,vr                ; automatic end-of-interrupt BUG: should not mess with this
		move.w     type-entry(a3),d3
		subq.w     #TYPE_FORWARD,d3     ; type 1 forward
		beq.s      type1
		subq.w     #1,d3                ; type 2 backward
		beq.s      type2
		subq.w     #1,d3                ; type 3 forward loop
		beq.s      type3
		subq.w     #1,d3                ; type 4 backward loop
		beq.s      type4
		subq.w     #1,d3                ; type 5 sweep
		beq.s      type5
type1:
		lea        playirq1-entry(a3),a0 ; interrupt address 1
		bra.s      playsamexit
type2:
		move.l     length-entry(a3),d0            
		add.l      d0,startaddr-entry(a3)         ; start from the end
		add.l      d0,startaddr2-entry(a3)
		lea        playirq2-entry(a3),a0 ; interrupt address 2
		bra.s      playsamexit
type3:
		lea        playirq3-entry(a3),a0 ; interrupt address 3
		bra.s      playsamexit
type4:
		move.l     length-entry(a3),d0
		add.l      d0,startaddr-entry(a3)         ; start from the end
		add.l      d0,startaddr2-entry(a3)
		lea        playirq4-entry(a3),a0 ; interrupt address 4
		bra.s      playsamexit
type5:
		lea        playirq5-entry(a3),a0   ; interrupt address 5
playsamexit:
		move.l     a0,0x0134
		move.w     d7,sr                ; status back
		clr.l      d0
		rts

nospeed:
		move.w     d7,sr
nosampledata:
samplenotfound:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)


/*
 * Syntax: sound init
 */
lib1:
	dc.w	0			; no library calls
soundinit:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		pea        snd_init-entry(a3)
		move.w     #32,-(a7) ; Dosound
		trap       #14
		addq.l     #6,a7
		rts

/*
 * Syntax: X=sample
 */
lib2:
	dc.w	0			; no library calls
sample:
		move.b     0x00FB0001,d0 ; get input data
		subi.b     #$80,d0
		ext.w      d0
		ext.l      d0
		move.l     d0,-(a6)
		rts

/*
 * Syntax: samplay SAMPLENO
 */
lib3:
	dc.w lib3_1-lib3
	dc.w	0
samplay:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     #0,speed_override-entry(a3)
		move.l     (a6)+,d3
		move.l     d3,sampleno-entry(a3)
		move.w     playbankno-entry(a3),d3
		andi.l     #0x0000FFFF,d3
		move.l     d3,-(a6)
lib3_1: jsr        L_addrofbank.l
		lea        realplaysam-entry(a3),a0
		jmp        (a0)

/*
 * Syntax: X=samplace
 */
lib4:
	dc.w	0			; no library calls
samplace:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     startaddr-entry(a3),d3
		sub.l      startaddr2-entry(a3),d3
		move.l     d3,-(a6)
		rts

/*
 * Syntax: samspeed manual
 */
lib5:
	dc.w	0			; no library calls
samspeed_manual:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     #0,auto_on-entry(a3)
		rts

lib6:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samspeed auto
 */
lib7:
	dc.w	0			; no library calls
samspeed_auto:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     #1,auto_on-entry(a3)
		rts

lib8:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samspeed N
 */
lib9:
	dc.w	0			; no library calls
samspeed:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     (a6)+,d3
		cmpi.w     #23,d3
		bge.s      outofrange
		cmpi.w     #4,d3
		blt.s      outofrange
		clr.w      auto_on-entry(a3)
		lea.l      hertz-entry(a3),a0
		move.b     0(a0,d3.w),d3
		move.b     d3,speed-entry(a3)
		addi.b     #19,d3
		move.b     d3,tadr
		rts

outofrange:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

lib10:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samstop
 * stop sample routine, simply clears timer a interrupt
 */
lib11:
	dc.w	0			; no library calls
samstop:
		move.w     sr,d7                ; save status
		move.w     #0x2700,sr           ; kill interrupts
		bclr       #5,iera              ; timer a interrupt off
		move.b     #0xdf,ipra           ; timer a pending clear
		move.b     #0xdf,isra           ; timer a interrupt in service clr
		bclr       #5,imra              ; timer a mask off
		move.w     d7,sr                ; status back
		rts

lib12:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samloop off
 */
lib13:
	dc.w	0			; no library calls
samloop_off:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        type-entry(a3),a0
		cmpi.w     #TYPE_BACKWARD,(a0)
		ble.s      samloop_off1
		cmpi.w     #TYPE_SWEEP,(a0)
		beq.s      samloop_off1
		subq.w     #2,(a0)
samloop_off1:
		rts

lib14:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samloop on
 */
lib15:
	dc.w	0			; no library calls
samloop_on:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        type-entry(a3),a0
		cmpi.w     #TYPE_SWEEP,(a0)
		beq.s      samloop_on1
		cmpi.w     #TYPE_LOOP_FORWARD,(a0)
		bge.s      samloop_on1
		addq.w     #2,(a0)
samloop_on1:
		rts

lib16:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samdir forward
 */
lib17:
	dc.w	0			; no library calls
samdir_forward:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        type-entry(a3),a0
		cmpi.w     #TYPE_LOOP_BACKWARD,(a0)
		beq.s      samdir_forward1
		cmpi.w     #TYPE_BACKWARD,(a0)
		bne.s      samdir_forward1
		move.w     #TYPE_FORWARD,(a0)
		rts
samdir_forward1:
		move.w     #TYPE_LOOP_FORWARD,(a0)
samdir_forward2:
		rts

lib18:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samdir backward
 */
lib19:
	dc.w	0			; no library calls
samdir_backward:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		lea        type-entry(a3),a0
		cmpi.w     #TYPE_LOOP_FORWARD,(a0)
		beq.s      samdir_backward2
		cmpi.w     #TYPE_FORWARD,(a0)
		bne.s      samdir_backward1
		move.w     #TYPE_BACKWARD,(a0)
		rts
samdir_backward2:
		move.w     #TYPE_LOOP_BACKWARD,(a0)
samdir_backward1:
		rts

lib20:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samsweep on
 */
lib21:
	dc.w	0			; no library calls
samsweep_on:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     #TYPE_SWEEP,type-entry(a3)
		rts

lib22:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samsweep off
 */
lib23:
	dc.w	0			; no library calls
samsweep_off:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     #TYPE_FORWARD,type-entry(a3)
		rts

lib24:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samraw START,END
 */
lib25:
	dc.w	0			; no library calls
samraw:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     (a6)+,a1
		move.l     (a6)+,a0 
		cmp.l      a1,a0
		bge.s      illegalend
		suba.l     a0,a1
		lea        realplayraw-entry(a3),a2
		jmp        (a2)

illegalend:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

lib26:
	dc.w	0			; no library calls
	rts


/*
 * Syntax: samrecord ADDR,END
 * samrec records a sample into memory
 * a0.l    = start address
 * a1.l    = length
 * speed.w = sample speed
 */
lib27:
	dc.w	0			; no library calls
samrecord:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     (a6)+,a1
		move.l     (a6)+,a0
		cmp.l      a1,a0
		bge.s      samrecorderr
		suba.l     a0,a1                ; calculate length
		move.l     a0,startaddr-entry(a3)         ; start address
		move.l     a1,length-entry(a3)            ; length
		move.l     a0,startaddr2-entry(a3)        ; backup
		move.l     a1,length2-entry(a3)           ; backup
		move.w     sr,d7                ; status save
		move.w     #0x2700,sr           ; interrupts off
		clr.b      tacr                 ; timer a off
		move.b     #1,tacr              ; timer a start
		move.b     speed-entry(a3),d3             ; speed
		addi.b     #19,d3               ; add 19 ticks
		move.b     d3,tadr              ; timer a data
		ori.b      #0x20,imra           ; interrupt mask
		ori.b      #0x20,iera           ; interrupt enable
		bclr       #3,vr                ; automatic end-of-interrupt BUG: should not mess with this
		lea.l      recirq-entry(a3),a0  ; address of routine
		move.l     a0,0x0134
		move.w     d7,sr                ; status back
		rts
samrecorderr:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

lib28:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samcopy SRC,SRCEND,DST
 */
lib29:
	dc.w	0			; no library calls
samcopy:
		move.l     (a6)+,a2
		move.l     (a6)+,d0
		move.l     (a6)+,a0
samcopy1:
		move.b     (a0)+,(a2)+
		cmp.l      d0,a0
		blt.s      samcopy1
		rts

lib30:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: sammusick SAMPLENO,N$
 */
lib31:
	dc.w lib31_1-lib31
	dc.w	0
sammusic:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		movea.l    (a6)+,a2
		move.w     (a2)+,d2
		beq.s      sammusic2
		move.b     (a2)+,d0
		andi.b     #0xDF,d0 ; make uppercase
		movea.l    a2,a0
		lea.l      notetable(pc),a1
sammusic1:
		cmp.b      (a1)+,d0
		bne.s      sammusic4
		cmpi.b     #1,d2
		beq.s      sammusic3
		cmpm.b     (a0)+,(a1)+
		bne.s      sammusic5
		cmpi.b     #2,d2
		beq.s      sammusic3
sammusic2:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)
sammusic3:
		move.b     (a1),speed-entry(a3)
		clr.w      auto_on-entry(a3)
		move.w     #1,speed_override-entry(a3)
		move.l     (a6)+,d3
		move.l     d3,sampleno-entry(a3)
		moveq      #0,d3
		move.w     playbankno-entry(a3),d3
		move.l     d3,-(a6)
lib31_1: jsr       L_addrofbank.l
		lea        realplaysam-entry(a3),a0
		jmp        (a0)
sammusic4:
		addq.l     #1,a1
sammusic5:
		addq.l     #2,a1
		movea.l    a2,a0
		tst.b      (a1)
		bne.s      sammusic1
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

notetable:
	dc.b 'C','9',0,0
	dc.b 'C','#',55,0
	dc.b 'D','5',0,0
	dc.b 'D','#',51,0
	dc.b 'E','1',0,0
	dc.b 'F','.',0,0
	dc.b 'F','#',44,0
	dc.b 'G','+',0,0
	dc.b 'G','#',41,0
	dc.b 'A','(',0,0
	dc.b 'A','#',38,0
	dc.b 'B','%',0,0
	dc.b 0,0,0,0


lib32:
	dc.w	0			; no library calls
	rts

lib33:
	dc.w	0			; no library calls
	rts

lib34:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: samthru
 * thru mode routine
 */
lib35:
	dc.w	0			; no library calls
samthru:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.w     sr,d7                ; save status
		move.w     #0x2700,sr           ; interrupts off
		clr.b      tacr                 ; stop timer a
		move.b     #1,tacr              ; start timer a
		move.b     speed-entry(a3),d3   ; speed
		addi.b     #19,d3               ; +19
		move.b     d3,tadr              ; timer a data
		ori.b      #$20,imra
		ori.b      #$20,iera            ; enable timer a
		bclr       #3,vr
		lea.l      thruirq-entry(a3),a0 ; address of routine
		move.l     a0,0x0134
		move.w     d7,sr                ; status back
		rts


lib36:
	dc.w	0			; no library calls
	rts

/*
 * Syntax: sambank N
 */
lib37:
	dc.w	0			; no library calls
sambank:
		move.l     debut(a5),a3
		movea.l    0(a3,d1.w),a3
		move.l     (a6)+,d3
		/* tst.w      d3 */
		dc.w 0x0c43,0 /* XXX */
		beq.s      memorybankrange
		cmpi.w     #16,d3
		bge.s      memorybankrange
		move.w     d3,playbankno-entry(a3)
		rts

memorybankrange:
		moveq.l    #E_illegalfunc,d0
		move.l     error(a5),a0
		jmp        (a0)

libex:
		dc.w 0
