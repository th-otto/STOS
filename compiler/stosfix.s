* Universal STOS fixer
* Will update so, that will work with any TOS version


* Concept - GUI for file selection - or Drag & drop for TOS 2.06, TTP for older  ...
* If no command line start GUI - in next version ...




	.offset 0
adapt_gcurx   : ds.l 1
adapt_joy     : ds.l 1
adapt_kbiorec : ds.l 1
adapt_devtab  : ds.l 1
adapt_siztab  : ds.l 1
adapt_mousevec: ds.l 1
adapt_sndtable: ds.l 1
adapt_sizeof:

	.text



begin:

;check command line - TTP or drag and drop support for filename entering

  moveq #0,d2
  lea begin-128(pc),a2
  move.l  a2,a4
  move.b (a2)+,d2
  tst.b d2
  beq exitu   ;no command line

  move.w   d2,d1
  lea   backupN(pc),a3
.ncl:
   move.b   (a2)+,(a3)+
  dbf  d1,.ncl

* Change extension to ORG

seeEnd:
tst.b  (a3)
   beq.s   goBack
   cmp.b  #$D,(a3)    * Terminator of command line in TOS below 2.06
   bne.s   atlast
goBack:
	subq.l	#1,a3
   cmp.l  a3,a4
   bgt   exitu
   bra.s  seeEnd

atlast:   subq.l  #2,a3   * It is OK for regular extension TOS or PRG !

   move.b  #"O",(a3)+
   move.b  #"R",(a3)+
   move.b  #"G",(a3)+
  clr.b   (a3)

  




* Loading executable's first $C00  bytes :




	
	move.w	#2,-(a7)
	pea	begin-127(pc)   * Here should be it with possible path
	move.w	#$3D,-(a7)
	trap	#1
	addq.l	#8,a7
	move.w	d0,handle
	bmi	exitu
		
	pea	workArea(pc)
	pea	$C00
	move.w	d0,-(a7)
	move.w	#$3F,-(a7)
	trap	#1
	lea	12(sp),sp


* Checking is Stos exec at all, and not packed :


	lea	workArea(pc),a6

	cmp.l	#"Stos",$70(a6)
	bne	fcloseErr
	
	cmp.l	#"1.0 ",$86(a6)
	bne	fcloseErr

* Now detect Stos version - exec type - stupid signo is 1.0 in all versions !

* Is it old one (before 1990) ?  :

	cmp.l	#$41FA06FA,$40E(a6)
	bne	seeTy2

	cmp.l	#$49FA014A,$A74(a6)
	bne.s	seeTy2

* It is most likely it, so doing fix now :

	bsr	fixOld
	bra	saveMod


seeTy2:
	
*	nop


	cmp.l	#$22390000,$40E(a6) /* move.l $8.l,d1 in compbug.s in original adapt table lookup */
	bne	seeTy3

	cmp.l	#$49FA01A4,$A98(a6) /* lea dataec+32(pc),a4 in fingem */
	bne.s	seeTy3

* It is most likely it, so doing fix now :

	bsr	updnC
	bra	saveMod

seeTy3:
	nop

	bra	fcloseErr


saveMod:	

* before saving make copy of original file :

* Using buffer of 200K, so usable on 512K machines for sure


* Create file :

	move.w	#0,-(a7)
	pea	backupN(pc)
	move.w	#$3C,-(a7)
	trap	#1
	addq.l	#8,a7
	move.w	d0,handleB
	bmi	saveIt


	moveq	#0,d7    * flag

	clr.w	-(sp)
	move.w	handle(pc),-(a7)
	clr.l	-(sp)    * back to file begin
	move.w	#66,-(sp)
	trap	#1
	lea	10(sp),sp



backuLoop:
	pea	backuB(pc)
	pea	200000
	move.w	handle(pc),-(a7)
	move.w	#$3F,-(a7)
	trap	#1
	lea	12(sp),sp

	tst.l	d0
	bmi	cloB

	cmp.l	#200000,d0
	bcc.s	saveBu
	st	d7   * flag for last chunk

saveBu:
	tst.l	d0
	beq.s	cloB
	pea	backuB(pc)
	move.l	d0,-(sp)
	move.w	handleB(pc),-(a7)
	move.w	#$40,-(a7)
	trap	#1
	lea	12(sp),sp

	tst.b	d7
	beq.s	backuLoop



cloB:
	move.w	handleB(pc),-(a7)
	move.w	#$3E,-(a7)
	trap	#1
	addq.l	#4,a7


saveIt:
	clr.w	-(sp)
	move.w	handle(pc),-(a7)
	clr.l	-(sp)    * back to file begin
	move.w	#66,-(sp)
	trap	#1
	lea	10(sp),sp

	pea	workArea(pc)
	pea	$C00
	move.w	handle(pc),-(a7)
	move.w	#$40,-(a7)
	trap	#1
	lea	12(sp),sp



fcloseErr:   * Message


fclose:
	move.w	handle(pc),-(a7)
	move.w	#$3E,-(a7)
	trap	#1
	addq.l	#4,a7


exitu:
	clr.w	-(sp)
	trap	#1


handle:	dc.w	0
handleB:	dc.w	0



	even


updnC:

* Updates for newer compiles
* Where there is 7 TOS table and TOS 1.06 support


	move.b	#"U",$88(a6)  * Change signo to  V 1.U  instead 1.0 


* Bsr to address setting code & skip following of old code :
    lea $40E(a6),a2
    move.w #$6100,(a2)+
    move.w #$B4C-$40E-2,(a2)+
	move.w	#$603C,(a2)


* Bsr to code for restoring entry state :
    lea $AA0(a6),a2
    move.w #$6100,(a2)+
    move.w #restJv-newCod1+$B4C-$AA0-2,(a2)


* New code for setting addresses, Joystick state write code, and + code
* for restoring entry state , with Joy vector restore + IKBD regular mode (08 command) :

	lea	$B4C(a6),a2
	move.w #((newCod1e-newCod1)/2)-1,d0

co1:
	move.w	(a1)+,(a2)+
	dbf d0,co1


	rts


newCod1:


start:
*	lea	Adapt+2(pc),a4
	lea	start-28(pc),a4
	dc.w	$A000
	lea	-602(a0),a1	; Position souris
	move.l	a1,adapt_gcurx(a4)
	lea	-692(a0),a1	; Table VDI 1
	move.l	a1,adapt_devtab(a4)
	lea	-498(a0),a1	; Table VDI 2
	move.l	a1,adapt_siztab(a4)

	move.w	#1,-(sp)	; Adresse du buffer clavier
	move.w	#14,-(sp)
	trap 	#14
	addq.l	#4,sp
	move.l	d0,adapt_kbiorec(a4)

	move.w	#34,-(sp)	; Adresse des interruptions souris
	trap 	#14
	addq.l	#2,sp
	move.l	d0,a0
	lea	16(a0),a1		; Adresse souris vector 
	move.l	a1,adapt_mousevec(a4)		;  to vecteur inter souris !


	lea	24(a0),a0
	lea	Joy_In(pc),a1
	move.l	a0,Joy_Ad-Joy_In(a1)   
	move.l	(a0),Joy_Sav-Joy_In(a1)
	move.l	a1,(a0)			; Branche la routine joystick
	lea	Joy_Pos+1(pc),a1
	move.l	a1,adapt_joy(a4)
	rts


Joy_Sav:	dc.l	0		; Adresses de gestion du joystick - 
Joy_Pos:	dc.l	0         * Joystick 1 (usual) goes on adr. +1
Joy_Ad:	dc.l	0	* Not much useful if not supported in exit game




Joy_In:
	move.l	a1,-(sp)
	lea	Joy_Pos+1(pc),a1   * odd
	move.b	2(a0),(a1)
	move.b	1(a0),-1(a1)   * Joystick 0 - only if mouse off !

* Maybe move.w could be used too ? if a0 is even here !

	move.l	(sp)+,a1
	rts     *  20 bytes for this better variant



* Code for restoring  joystick vector may be linked after command:
*   move.b  #7,$484 ;  lea ....

restJv:
	move.l  	Joy_Ad(pc),a0
	move.l	Joy_Sav(pc),(a0)
	move.b	#8,$FFFFFC02.w   * Back to mouse mode, for case !

* Overwritten instruction with call for here
	move.l adapt_devtab(a3),a0
	rts

newCod1e:








* Update for older STOS executables, where in less space :

fixOld:
	move.b	#"U",$88(a6)  * Change signo to  V 1.U  instead 1.0

* Bsr to address setting code & skip following of old code :
	move.l	#$61000718,$40E(a6)
	move.w	#$6022,$412(a6)


* Bsr to + code for restoring entry state :
	move.l	#$6100F9AA,$A74(a6)   * calls at $40E+6+12  !




* First part goes in TOS tables start+30 = $B28
* Available space :  $B9C-$B28= 116 bytes ($74)
* Part to free space at $414 - so need to fix pc-relative addressing !



* New code for setting addresses, Joystick state write code, and + code
* for restoring entry state , with Joy vector restore + IKBD regular mode (08 command) :

	lea	$B28(a6),a2
	move.w #((newCod2e-newCod2)/2)-1,d0

co2:
	move.w	(a1)+,(a2)+
	dbf d0,co2

	lea	$414(a6),a2
	move.w #((newCod22e-newCod22)/2)-1,d0

co3:
	move.w	(a1)+,(a2)+
	dbf d0,co3
	rts



newCod2:


start2:   * to pos $B28

	lea	start2-28(pc),a4
	dc.w	$A000
	lea	-602(a0),a1	; Position souris
	move.l	a1,adapt_gcurx(a4)
	lea	-692(a0),a1	; Table VDI 1
	move.l	a1,adapt_devtab(a4)
	lea	-498(a0),a1	; Table VDI 2
	move.l	a1,adapt_siztab(a4)

	move.w	#1,-(sp)	; Adresse du buffer clavier
	move.w	#14,-(sp)
	trap 	#14
	addq.l	#4,sp
	move.l	d0,adapt_kbiorec(a4)

	move.w	#34,-(sp)	; Adresse des interruptions souris
	trap 	#14
	addq.l	#2,sp
	move.l	d0,a0
	lea	16(a0),a1		; Adresse souris vector 
	move.l	a1,adapt_mousevec(a4)	;  to vecteur inter souris !

* 62 bytes so far


	lea	24(a0),a0     *4
	lea	Joy_In2(pc),a1    *4
*	move.l	a0,Joy_Ad2-Joy_In2(a1)     * 4
	dc.l	$2348F89A
*	move.l	(a0),Joy_Sav2-Joy_In2(a1)   4
	dc.l	$2350F892
	move.l	a1,(a0)			;  *2  Branche la routine joystick
*	lea	joy_pos2+1(pc),a1   *4
	dc.l	$43FAF89F
	move.l	a1,adapt_joy(a4)   *4 adapt_joy
	rts   *2

* This section  28 bytes, subtotal 90 bytes



Joy_In2:
	move.l	a1,-(sp)   *2
*	lea	joy_Pos2+1(pc),a1   *4  odd
	dc.l	$43FAF893
	move.b	2(a0),(a1)  *4
	move.b	1(a0),-1(a1)   *6  Joystick 0 - only if mouse off !

	move.l	(sp)+,a1   *2
	rts     *  *2   - 20 bytes for this better variant

* 20 bytes in section, subtotal 110 bytes

newCod2e:


* To pos $414 :

newCod22:

Joy_Sav2:	  dc.l	0		; Adresses de gestion du joystick - 
Joy_Pos2:	  dc.l	0         * Joystick 1 (usual) goes on adr. +1
Joy_Ad2:	  dc.l	0	* Not much useful if not supported in exit game

* 12 bytes


* Code for restoring  joystick vector may be linked after command:
*   move.b  #7,$484 ;  lea ....

restJv2:
	move.l  	Joy_Ad2(pc),a0   *4
	move.l	Joy_Sav2(pc),(a0) *4
	move.b	#8,$FFFFFC02.w   *6 Back to mouse mode, for case !

*	lea	huh2(pc),a4   *4 Overwritten instruction with call for here
	dc.l	$49FA0790
	rts   *2

* 20  bytes here, subtotal 32 bytes

newCod22e:


* So, it can fit if place Joy_Sav2-Joy_Ad2 (12) and restJv2 put  in 34 bytes free at $414




	.bss

backupN:	ds.b   132

workArea:	   ds.b   $C00

backuB:	ds.b   200000




