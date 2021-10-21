;***********************************************************************
;***********                                                 ***********
;***********                                                 ***********
;***********        Routine de Replay Soundtracker           ***********
;***********               2 + 2 * x  voies                  ***********
;***********                                                 ***********
;***********         Transmission par port Host              ***********
;***********           Routine en Host Command               ***********
;***********                                                 ***********
;***********           Par Simplet / ABSTRACT                ***********
;***********                                                 ***********
;***********************************************************************


PBC       equ       $ffe0               ; Port B Control Register
PCC       equ       $ffe1               ; Port C Control register
HCR       equ       $ffe8               ; Host Control Register
HSR       equ       $ffe9               ; Host Status Register
HRX       equ       $ffeb               ; Host Receive Register
HTX       equ       $ffeb               ; Host Transmit Register
CRA       equ       $ffec               ; SSI Control Register A
CRB       equ       $ffed               ; SSI Control Register B
SSISR     equ       $ffee               ; SSI Status Register
TX        equ       $ffef               ; SSI Serial Transmit data/shift register
IPR       equ       $ffff               ; Interrupt Priority Register

;    Host Control Register Bit Flags

HCIE      equ       2                   ; Host Command Interrupt Enable

;    Host Status Register Bit Flags

HRDF      equ       0                   ; Host Receive Data Full
HTDE      equ       1                   ; Host Transmit Data Empty


          org       p:0
          jmp       Start

          org       p:$10
          jsr       Spl_Out

          org       p:$12
          jsr       Spl_Out

          org       p:$24
          jmp       memload

          org       p:$26
          jsr       Soundtrack_Rout

          org       p:$28
          jsr       clear_buffer


; Routine sous interruption de Replay du son par le SSI

          org       p:$40

Spl_Out:
          jset      #2,X:<<SSISR,Right_Out   ; Detects the first transfer

Left_Out:
          movep     Y:(r7),X:<<TX
          rti
Right_Out:
          movep     X:(r7)+,X:<<TX
          rti

;
; It starts there:
;

Start:    movep     #1,X:<<PBC               ; Port B en Host
          movep     #$1f8,X:<<PCC            ; Port C en SSI
          movep     #$4100,X:<<CRA           ; 1 voice 16 bits Stereo
          movep     #$5800,X:<<CRB           ; enable tranmission
          movep     #$3800,X:<<IPR           ; set HOST COMMAND IPL to 2
          bset      #HCIE,X:<<HCR            ; Autorise ITs Host Command


; Initialisations Registres

          movec          #-1,m0
          movec          #2047,m7
          movec          m0,m1
          movec          m0,m2
          movec          m0,m3
          movec          m0,m4
          movec          m0,m5
          movec          m7,m6

		jsr            <clear_buffer
; To check the connection

Conct_Get:
	  jclr      #HRDF,X:<<HSR,Conct_Get
          movep     X:<<HRX,x0

Conct_Snd:
          jclr      #HTDE,X:<<HSR,Conct_Snd
          movep     #12345678,X:<<HTX


          move      #SampleBuffer,r7

; Allow interrupts (IPL0)
          andi      #%11111100,mr

;
; Main loop that does absolutely nothing
;

Loop:     jmp       <Loop

;
; SoundTracker Routine in Host Command
;

Soundtrack_Rout:
          jclr      #HTDE,X:<<HSR,Soundtrack_Rout
          movep     #$4d4754,X:<<HRX

          move      #<Nb_Voices_Sup,r0
          move      X:<CalcNext,x0
          move      x0,X:<Calc
          move      r7,a
          sub       x0,a r7,X:CalcNext
          jpl       <Left_Wrap
          move      #2048,x0
          add       x0,a
Left_Wrap:
		move       a,X:(r0)+
		
; Receive the first two tracks

Receive_Voice_Left:
Get_NbVox:
          jclr		#HRDF,X:<<HSR,Get_NbVox
		movep	X:<<HRX,X:(r0)+
Receive_Left_Volume:
          jclr      #HRDF,X:<<HSR,Receive_Left_Volume
          movep     X:<<HRX,X:(r0)+
Receive_Left_Frequence:
          jclr      #HRDF,X:<<HSR,Receive_Left_Frequence
          movep     X:<<HRX,y0
          tfr       y0,b #$000002,a
          addr      a,b #$000001,a
          andi      #$fe,ccr
          rep       #24
          div       y0,a
          move      a0,X:(r0)
          clr       a X:Calc,r6
          move      X:Nb_Voices_Sup,x0
          DO        x0,clear_loop
          move       a,l:(r6)+
clear_loop:
		move       #$000008,r1
		DO         b,send_loop
          jsr        <send_minus1
          jsr        <Receive_Voices_Sup
		tst        a
		jeq        <skip
		jsr        <x_send
		jsr        <calc_left
		jsr        <mix_left
skip:
		lua        (r1)+,r1
          jsr        <send_minus1
          jsr        <Receive_Voices_Sup
		tst        a
		jeq        <skip2
		jsr        <x_send
		jsr        <calc_right
		jsr        <mix_right
skip2:
		lua        (r1)+,r1
send_loop:

send_zero:
          jclr      #HTDE,X:<<HSR,send_zero
          movep     #0,X:<<HTX
		rti

send_minus1:
          jclr      #HTDE,X:<<HSR,send_minus1
          movep     #$ffffff,X:<<HTX
		rts

Receive_Voices_Sup:
		move      #$000006,r0
		jclr      #HRDF,X:<<HSR,Receive_Voices_Sup
		movep     X:<<HRX,a
		move      a,X:(r0)+
		rts

x_send:
		jclr       #HRDF,X:<<HSR,x_send
		movep      X:<<HRX,x0
		move       X:<Nb_Voices_Sup,b
		lsl        b
		clr        b b,x1
		move       X:(r1),b0
		mac        x1,x0,b x0,X:(r0)
x_send1:
		jclr       #HTDE,X:<<HSR,x_send1
		movep      b,X:<<HTX
		rts

mix_left:
		move       #$00002e,r0
		move       X:<Calc,r6
		move       X:<$0006,x0
		move       X:<LengthL,x1
		mpy        x1,x0,a X:<$0005,x1
		move       a0,x0
		mpyr       x1,x0,a
		lsl        a
		move       a,x1
		move       #Nb_Voices_Sup,y0
		move       X:<$0007,y1
		move       r0,b
		move       X:(r1),b0
		DO         X:<Nb_Voices_Sup,mix_left1
		mac        y1,y0,b X:(r0),x0 Y:(r6),a
		mac        x1,x0,a b,r0
		move       a,Y:(r6)+
mix_left1:
		move       b0,X:(r1)
		rts

mix_right:
		move       #$00002e,r0
		move       X:<Calc,r6
		move       X:<$0006,y0
		move       X:<LengthR,y1
		mpy        y1,y0,a X:<$0005,y1
		move       a0,y0
		mpyr       y1,y0,a
		lsl        a
		move       a,y1
		move       #Nb_Voices_Sup,x0
		move       X:<$0007,x1
		move       r0,a
		move       X:(r1),a0
		DO         X:<Nb_Voices_Sup,mix_right1
		mac        x1,x0,a X:(r6),b Y:(r0),y0
		mac        y1,y0,b a,r0
		move       b,X:(r6)+
mix_right1:
		move       a0,X:(r1)
		rts

calc_left:
		move       #$00002f,r0
		move       #<3,n0
		move       #$ff0000,x1
		move       #$000080,y0
		move       #$008000,y1
		move       #$000001,a
		addr       a,b
		do         b,calc_left2
calc_left1:
		jclr       #HRDF,X:<<HSR,calc_left1
		movep      X:<<HRX,x0
		mpy        y0,x0,a
		mpy        x0,y1,a a0,b
		and        x1,b a0,X:(r0)-
		move       b,X:(r0)+n0
calc_left2:
		rts

calc_right:
		move       #$00002f,r0
		move       #<3,n0
		move       #$ff0000,x1
		move       #$000080,y0
		move       #$008000,y1
		move       #$000001,a
		addr       a,b
		do         b,calc_right2
calc_right1:
		jclr       #HRDF,X:<<HSR,calc_right1
		movep      X:<<HRX,x0
		mpy        y0,x0,a
		mpy        x0,y1,a a0,b
		and        x1,b a0,Y:(r0)-
		move       b,Y:(r0)+n0
calc_right2:
		rts





; Clear the buffer
clear_buffer:
		move       a,X:<$002d
		move       r0,X:<$002c
		clr        a #SampleBuffer,r0

                DO         #2048,Clear_Sample
		move       a,l:(r0)+
Clear_Sample:
		move       X:<$002d,a
		move       X:<$002c,r0
		rti


memload:
		jclr       #HTDE,X:<<HSR,memload
		movep      #$503536,X:<<HTX
		move       #getdata,r1
		movec      #<0,sp
memload1:
		jsr        (r1)          ; get memory type
		tfr        x0,b x0,n0
		tst        b #jumps,r0
		jmi        <0            ; boot program on end
		movem      P:(r0+n0),r2  ; fetch jump address
		jsr        (r1)          ; get address
		move       x0,r0
		jsr        (r1)          ; get count
		DO         x0,memload2
		jsr        (r1)          ; read data
		jsr        (r2)          ; write to mem
		nop
memload2:
		jmp        <memload1
getdata:
		jclr       #HRDF,X:<<HSR,getdata
		movep      X:<<HRX,x0
		rts
getp:
		movem      x0,P:(r0)+
		rts
getx:
		move       x0,X:(r0)+
		rts
gety:
		move       x0,Y:(r0)+
		rts
jumps:
		dc getp
		dc getx
		dc gety

; Data area

               org       X:0
CalcNext       DC        SampleBuffer
Calc           equ CalcNext+1

Nb_Voices_Sup  equ Calc+1
LengthR        equ Nb_Voices_Sup+1
LengthL        equ LengthR+1


               org       Y:3*4096
SampleBuffer
               END
