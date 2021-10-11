;**************************************************************************
;*
;*      EXTENSION COMPILATEUR
;*
;*      (c) FL Soft 1989
;*
;**************************************************************************

		.text

; STOS BASIC INTERFACE
entry:
		bra.w      start
		
		.dc.b 0x80
		
tokens:
		.dc.b 13
		.dc.b "***************************************",13,10
		.dc.b "*                                     *",13,10
		.dc.b "*          COMPILED PROGRAM           *",13,10
		.dc.b "*                                     *",13,10
		.dc.b "*      Don't change line 65535!       *",13,10
		.dc.b "*                                     *",13,10
		.dc.b "***************************************",13,10
		.dc.b 0x80
		.dc.b "compad",0x81
		.dc.b "comptest off",0x82
		.dc.b "comptest on",0x84
		.dc.b "comptest always",0x86
		.dc.b "comptest",0x88
		.even

; Table of jumps related to the tokens
jumps:
		.dc.w 9
		.dc.l run
		.dc.l compad
		.dc.l dummy
		.dc.l 0
		.dc.l dummy
		.dc.l 0
		.dc.l dummy
		.dc.l 0
		.dc.l dummy
		
; Welcome message, in two languages, 40 char max.
welcome:
		.dc.b 10,"COMPILER installed",0
		.dc.b 10,"COMPILATEUR pr",0x82,"sent",0
		.even

table:  dc.l 0
savepc: dc.l 0

;**************************************************************************
;       INITIALISATION ROUTINES
;**************************************************************************

start:
		lea.l      finprg,a0           ;A0---> end of the extension
		lea.l      cold,a1             ;A1---> adress of COLD START routine
		rts

cold:
		move.l     a0,table         ;INPUT: basic table adress
		lea.l      welcome,a0       ;OUTPUT:        A0= welcome message
		lea.l      warm,a1          ;               A1= warm start
		lea.l      tokens,a2        ;               A2= token table
		lea.l      jumps,a3         ;               A3= jump table
		rts

warm:
dummy:
		rts

;************************************************************************
;       INTERFACE ROUTINES
;**************************************************************************

;-----> Calling the program in machine language
run:
		move.l     (a7)+,savepc   ;Return address
		movem.l    a4-a6,-(a7)    ;Push important registers
;Find the start of the program
run1:
		adda.w     (a5),a5        ;Cherche la derniere ligne
		tst.w      (a5)
		bne.s      run1
		addq.l     #2,a5          ;Skip the 0
		movea.l    table,a0       ;Table address
		jsr        (a5)           ;Call the prg
; Fin du programme
		movem.l    (a7)+,a4-a6
		movea.l    savepc,a0
		jmp        (a0)

;FUNCTION: returns the address of the vector table
compad:
		clr.b      d2
		move.l     table,d3
		rts

;************************************************************************
;       END OF THE PROGRAM
;************************************************************************

        .dc.l 0
finprg:
