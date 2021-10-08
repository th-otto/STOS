		.text

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

jumps:
		.dc.w 9
		.dc.l func1
		.dc.l func2
		.dc.l dummy
		.dc.l 0
		.dc.l dummy
		.dc.l 0
		.dc.l dummy
		.dc.l 0
		.dc.l dummy
		
welcome:
		.dc.b 10,"COMPILER installed",0
		.dc.b 10,"COMPILATEUR pr",0x82,"sent",0
		.even

table:  dc.l 0
savepc: dc.l 0

start:
		lea.l      finprg,a0
		lea.l      cold,a1
		rts

cold:
		move.l     a0,table
		lea.l      welcome,a0
		lea.l      warm,a1
		lea.l      tokens,a2
		lea.l      jumps,a3
		rts

warm:
dummy:
		rts

func1:
		move.l     (a7)+,savepc
		movem.l    a4-a6,-(a7)
func1_loop:
		adda.w     (a5),a5
		tst.w      (a5)
		bne.s      func1_loop
		addq.l     #2,a5
		movea.l    table,a0
		jsr        (a5)
		movem.l    (a7)+,a4-a6
		movea.l    savepc,a0
		jmp        (a0)

func2:
		clr.b      d2
		move.l     table,d3
		rts

        .dc.l 0
finprg:
