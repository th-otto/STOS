;**************************************************************************
;*
;*      EXTENSION COMPILATEUR
;*
;*      (c) FL Soft 1989
;*
;**************************************************************************

        .text

start:
	.dc.l para-start  ; offset to parameter definitions
	.dc.l entry-start ; offset to coldboot function
	.dc.l lib1-start  ; offset to first library function

; length of library routines follows
	.dc.w lib2-lib1
	.dc.w libex-lib2
para:
	.dc.w 2           ; number of library routines
	.dc.w 2           ; number of extension commands
	.dc.w l001-para
	.dc.w l002-para

l001:  .dc.b 0,0,-1,0,1,1
l002:  .dc.b 0,1

entry:
        lea extend(pc),a2		; load position of end into A2
extend: rts

lib1:
		.dc.w 0 ; no library calls
compad:
		rts

lib2:
		.dc.w 0 ; no library calls
comptest_off:
		tst.w      2464(a5)
		bne.s      comptest_off1
		move.l     2356(a5),-(a6)
		rts
comptest_off1:
		move.l     a5,d0
		bset       #31,d0
		move.l     d0,-(a6)
		rts

libex:
        
;************************************************************************
        dc.w 0
finprg:
