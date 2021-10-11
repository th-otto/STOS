;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;       STOS BASIC LOADER / RUNTIME / GEM VERSION
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .include "adapt.inc"

soundctrl = 0xffff8921

    .text

entry:  bra.w    start

; place for file name
; this is written by basic.bin when saving a program file
basname:     ds.b 16


; Adaptation tables
; In order :
; Word: Tos version
; .l  : Mouse addr (linea-602, GCURX)
; .l  : Addr joystick (#Joy_Pos)
; .l  : Keyboard Buffer (Iorec(1))
; .l  : Table Vdi 1 (linea-692, DEV_TAB)
; .l  : Table Vdi 2 (linea-498, SIZ_TAB)
; .l  : Mouse interrupt vector (Kbdvbase())
; .l  : Start of a sound (sndtable)
tosversion: .dc.w    0
Adapt:      .ds.b    adapt_sizeof

extend: .ds.l     26             ;26 addresses for extensions
        .ds.l     26             ;26 addresses for extensions cleanup ptrs (setup by basic.bin)

dta:    .ds.w    13              ;Buffer DTA
size:   .dc.l    0               ;File size
name:   .dc.w    0               ;Her name
        .ds.w    9               ;Buffer Dta (Continued) 

Joy_Sav:  .dc.l 0                ;Joystick management
Joy_Pos:  .dc.l 0
Joy_Ad:   .dc.l 0
fake_sndtable: ds.b 6

end_adr: .dc.l    0               ;upload address of the next file
logic:   .dc.l    0               ;Logic screen address
physic:  .dc.l    0               ;Physical screen address
mode:    .dc.w    0               ;resolution at boot
handle:  .dc.w    0               ;File handle
Cmd_Tail:.dc.l    0               ;Command Tail
sav_col: .ds.w    16              ;Buffer for 16 colors
falcon_pal: .ds.l 256             ;Buffer for 256 colors
soundctrl_save: .dc.b 0
soundctrl_was_saved: .dc.b 0
falcon_was_saved: .dc.b 0
         .even
falcon_mode: .ds.w 1
falcon_save: .ds.w 19
         .even
save_hbl: .dc.l 0
save_vbl: .dc.l 0

vdi_1:   .ds.w    45              ;Table VDI 1 (devtab)
         .ds.w    12              ;Table VDI 2 (siztab)
         .ds.l    1               ;mouse coordinates


curs_off:
         .dc.b    27,'f',0        ;Curs Off
folder:  .dc.b    "\stos",0       ;Folder \Stos

oldpath: .ds.b    128             ;Buffer
newpath: .ds.b    128             ;Other buffer
piclow:  .dc.b    "pic.pi1",0     ;low resolution image
pichi:   .dc.b    "pic.pi3",0     ;high resolution image
sprit:   .dc.b    "sprit*.bin",0 ; Sprite trap
windo:   .dc.b    "windo*.bin",0 ; Window Trap
float:   .dc.b    "float*.bin",0 ; Float Trap
music:   .dc.b    "music*.bin",0 ; Music Trap
basic:   .dc.b    "basic*.bin",0 ; Basic himself
namext:  .dc.b "*.ex"
numbext: .dc.b 0,0
        .even

start:  lea     Cmd_Tail(pc),a6
        clr.l   (a6)
        movea.l 4(a7),a0        ;address Basepage
        lea     128(a0),a0      ;Number of characters on command line
        move.b  (a0)+,d0        ;=0 ?
        beq.s   Skip0
        cmp.b   #127,d0
        bcc.s   Skip0
        move.l  a0,(a6)         ;Stores his address
Skip0:
; Find addresses while respecting the system
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    .dc.w   0xa000
    lea Adapt(pc),a5
    lea -602(a0),a1 ; Mouse position
    move.l  a1,adapt_gcurx(a5)
    lea -692(a0),a1 ; Table VDI 1
    move.l  a1,adapt_devtab(a5)
    lea -498(a0),a1 ; Table VDI 2
    move.l  a1,adapt_siztab(a5)
    /*
     * older basic*.bin need the address of the TOS internal sndtab
     * variable, that is set by Dosound(). There is no way this can
     * be determined, so we provide a dummy address to avoid crashes.
     * Newer versions call Dosound() and thus don't need that address.
     */
    lea fake_sndtable(pc),a1
    move.l  a1,adapt_sndtable(a5)

    move.w  #1,-(sp)    ; Keyboard Buffer (Iorec(1))
    move.w  #14,-(sp)   ; Iorec
    trap    #14
    addq.l  #4,sp
    move.l  d0,adapt_kbiorec(a5)

    move.w  #34,-(sp)   ; Mouse interrupt addresses
    trap    #14
    addq.l  #2,sp
    move.l  d0,a0
    lea     16(a0),a1
    move.l  a1,adapt_mousevec(a5)
    lea     24(a0),a0
    lea     Joy_Pos(pc),a1
    move.l  a0,Joy_Ad-Joy_Pos(a1)
    move.l  (a0),Joy_Sav-Joy_Pos(a1)
    move.l  a1,adapt_joy(a5)        ; Result address
    lea     Joy_In(pc),a1
    move.l  a1,(a0)     ; Plug in the joystick routine

; Find the address of the screen
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~
        move.w  #3,-(a7)        ;Logbase
        trap    #14
        addq.l  #2,a7
        move.l  d0,logic-Adapt(a5)         ;save screen address
        move.w  #2,-(a7)        ;Physbase
        trap    #14
        addq.l  #2,a7
        move.l  d0,physic-Adapt(a5)         ;save screen address

        pea     sav_vect(pc)    ;Save the configuration
        move.w  #38,-(a7)       ;Supexec
        trap    #14
        addq.l  #6,a7
        move.w  #4,-(a7)        ;Getrez
        trap    #14
        addq.l  #2,a7
        move.w  d0,mode-Adapt(a5)  ;Range resolution
        move.w  d0,d7
        move.w  #-1,-(a7)
        move.w  #0x58,-(a7)     ;VsetMode
        trap    #14
        addq.l  #4,a7
        move.w  d0,falcon_mode-Adapt(a5)

        lea     vdi_1(pc),a6
        movea.l adapt_devtab(a5),a0       ;addr Table VDI 1
        moveq   #45-1,d0        ;Copy 45 mots
bcl1:
        move.w  (a0)+,(a6)+
        dbf     d0,bcl1
        movea.l adapt_siztab(a5),a0       ;address Table VDI 2
        moveq   #12-1,d0        ;Copy 12 mots
bcl2:
        move.w  (a0)+,(a6)+
        dbf     d0,bcl2
        movea.l adapt_gcurx(a5),a0
        move.l  (a0),(a6)+      ;mouse coordinates
        lea     EXIT(pc),a0
        lea     end_adr(pc),a1
        move.l  a0,(a1)         ;BASLOAD.PRG end address
        bsr     set_dta         ;Fixed I/O buffer
        clr.w   -(a7)           ;current drive
        pea     oldpath(pc)     ;buffer for path
        move.w  #0x47,-(a7)     ;Dgetpath
        trap    #1
        addq.l  #8,a7
        tst.w   d0
        bne     set_scr         ;Problem...
        lea     oldpath(pc),a0  ;Current path
        lea     newpath(pc),a1  ;Copy into a buffer
Copy_path:
        move.b  (a0)+,(a1)+
        bne.s   Copy_path
        lea     oldpath(pc),a0
        tst.b   (a0)            ;End of the way?
        bne.s   lbl1            ;No, increase 
        move.b  #'\',(a0)+      ;backslash
        clr.b   (a0)            ;End of path
lbl1:
        subq.l  #1,a1
        lea     folder(pc),a0   ;copy "\STOS"
Copy_Folder:
        move.b  (a0)+,(a1)+
        bne.s   Copy_Folder
        lea     newpath(pc),a0  ;Fixed path \STOS 
        bsr     set_path
        bne     Error1          ;Not found
        cmpi.w  #2,d7           ;High resolution?
        beq.s   hi_res          ;vouiiiiii!
        lea     piclow(pc),a0   ;'PIC.PI1' : zouli image
        bra.s   affiche         ;Go get her
hi_res:
        lea     pichi(pc),a0    ;'PIC.PI3'
affiche:
        bsr     fsfirst         ;Does it exist?
        bne     No_Image        ;No...
        bsr     fopen
        movea.l logic(pc),a0    ;Logic-32768 : Back
        suba.l  #32768,a0
        move.l  #32034,d0       ;Read 32034 bytes (Degas)
        bsr     fread           ;read
        bsr     fclose          ;close it

        .dc.w   0xa00a          ;mouse cover
        tst.w   d7              ;low res ?
        beq     fix_scr         ;yes
        cmpi.w  #2,d7           ;Hi Res ?
        beq     fix_scr         ;yes
        clr.w   -(a7)           ;Mid Res: switch to low
        moveq   #-1,d0
        move.l  d0,-(a7)
        move.l  d0,-(a7)
        move.w  #5,-(a7)        ;Setscreen
        trap    #14
        lea     12(a7),a7
fix_scr:
        lea     curs_off(pc),a0 ;Remove cursor 
        bsr     print           ;Emulation VT52
        move.l  logic(pc),-(a7) ;
        subi.l  #32766,(a7)     ;palette address
        move.w  #6,-(a7)        ;Setpalette
        trap    #14
        addq.l  #6,a7

; Copy the image with a ...
        moveq   #1,d6
copy_scr:
        movea.l logic(pc),a2
        movea.l a2,a3
        adda.l  #99*160,a2      ;line 99
        adda.l  #100*160,a3     ;line 100
        movea.l a2,a0
        movea.l a3,a1
        suba.l  #32734,a0
        suba.l  #32734,a1
        moveq   #99,d7
        addq.w  #1,d6
        cmp.w   #100,d6         ;Line 100 reached?
        bhi     load            ;yes...
        moveq   #50,d5
Effect:
        add.w   d6,d5
        cmp.w   #100,d5
        bcs.s   cpy_scr
        subi.w  #100,d5
        movem.l a0-a3,-(a7)
        moveq   #9,d0
BitMap_Copy:
        move.l  (a0)+,(a2)+
        move.l  (a0)+,(a2)+
        move.l  (a0)+,(a2)+
        move.l  (a0)+,(a2)+
        move.l  (a1)+,(a3)+
        move.l  (a1)+,(a3)+
        move.l  (a1)+,(a3)+
        move.l  (a1)+,(a3)+
        dbf     d0,BitMap_Copy
        movem.l (a7)+,a0-a3
        suba.l  #160,a2
        adda.l  #160,a3
cpy_scr:
        suba.l  #160,a0
        adda.l  #160,a1
        dbf     d7,Effect
        bra     copy_scr

; No image on the floppy disk: remove the mouse
No_Image:
        .dc.w   0xa00a          ;Hide the mouse
        lea     curs_off(pc),a0 ;Remove cursor
        bsr     print

; load and call the trap libraries
load:
        lea     sprit(pc),a0    ;'SPRIT*.BIN'
        bsr     get_im          ;File load
        lea     Adapt(pc),a3    ;addresses
        jsr     (a0)            ;install trap
        lea     end_adr(pc),a1
        move.l  a0,(a1)

        lea     windo(pc),a0    ;'WINDO*.BIN'
        bsr     get_im          ;File load
        lea     Adapt(pc),a3    ;addresses
        jsr     (a0)            ;install trap
        lea     end_adr(pc),a1
        move.l  a0,(a1)

        lea     float(pc),a0    ;'FLOAT*.BIN'
        bsr     get_bin         ;File load
        bne     load_zik        ;If not ..., too bad!
        lea     Adapt(pc),a3    ;addresses
        jsr     (a0)            ;install trap
        /* float.bin does not return correct end address; ignore it and just use filesize */

load_zik:
        lea     music(pc),a0    ;'MUSIC*.BIN'
        bsr     get_im          ;File load
        lea     Adapt(pc),a3    ;addresses
        jsr     (a0)            ;install trap
        lea     end_adr(pc),a1
        move.l  a0,(a1)

; load and call extensions, poke addresses
        moveq   #26-1,d7
        lea     extend(pc),a6
load5:  lea     namext(pc),a0
        move.b  d7,numbext-namext(a0)
        add.b   #'a',numbext-namext(a0)
        bsr     fsfirst
        bne.s   load6
        lea     namext(pc),a0
        bsr     get_im
        movem.l a6/d6/d7,-(sp)
        lea     Adapt(pc),a3
        jsr     (a0)
        lea     end_adr(pc),a6
        move.l  a0,(a6)
        movem.l (sp)+,a6/d6/d7
        move.l  a1,(a6)        ;poke the start address
load6:  addq.w  #4,a6
        dbf     d7,load5

; load the basic
        lea     basic(pc),a0    ;'BASIC*.BIN'
        bsr     get_im          ;load
        move.l  a0,-(a7)        ;Save the address on the stack
        lea     oldpath(pc),a0  ;boot path
        bsr     set_path        ;put it back
        movea.l (a7)+,a6        ;address BASIC.BIN
; clears the screen, goes on average if color
        move.w  #0x25,-(a7)     ;Vsync
        trap    #14
        addq.l  #2,a7
        movea.l logic(pc),a0    ;clear logic
        move.w  #8000-1,d0
cls:
        clr.l   (a0)+
        dbf     d0,cls
        move.w  mode(pc),d7
        cmpi.w  #2,d7           ;high resolution ?
        beq.s   hi              ;yes
        move.w  #1,-(a7)        ;switch to med resolution
        moveq   #-1,d0
        move.l  d0,-(a7)
        move.l  d0,-(a7)
        move.w  #5,-(a7)        ;Setscreen
        trap    #14
        lea     12(a7),a7
hi:
        lea     extend(pc),a0   ;Extensions address
        lea     basname(pc),a1  ;file name address
        lea     oldpath(pc),a2  ;old directory 
        lea     Adapt(pc),a3    ;address adaptations
        movea.l Cmd_Tail(pc),a4 ;Command Tail
        move.b  (a1),d0
        sne     d0              ;d0=RUNONLY flag
        neg.b   d0
        ext.w   d0
        ext.l   d0
        jsr     (a6)            ;Saute au basic
        bra     set_scr         ;fin du basic

; error in loading ---> return to GEM
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
errmsg:
        .dc.b " not found",13,10,0
        .even
ErrorLoad:
        bsr print
        lea errmsg(pc),a0
        bsr print
        move.w #8,-(a7)
        trap #1
        addq.w #2,a7
        bra.s Error1
Error:
        bsr     fclose
Error1:
        lea     oldpath(pc),a0
        bsr     set_path
; loading error or returns from basic
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set_scr:
; Restore the joystick entry routine
        move.l  Joy_Ad(pc),d0
        beq.s   Skip
        move.l  d0,a0
        move.l  Joy_Sav(pc),(a0)
Skip:
        pea     rest_vect(pc)    ;Save the configuration
        move.w  #38,-(a7)       ;Supexec
        trap    #14
        addq.l  #6,a7
        lea     curs_off(pc),a0 ;Remove cursor 
        bsr     print           ;Emulation VT52

; The screens
        move.w  falcon_mode(pc),-(a7)
        move.w  mode(pc),-(a7)  ;restore resolution
        move.l  physic(pc),-(a7) ;screen address
        move.l  logic(pc),-(a7)
        move.w  #5,-(a7)        ;Setscreen
        trap    #14
        lea     14(a7),a7

        lea     vdi_1(pc),a6    ;Restore Vectors
        lea     Adapt(pc),a5
        movea.l adapt_devtab(a5),a0
        moveq   #45-1,d0
bcl7:
        move.w  (a6)+,(a0)+
        dbf     d0,bcl7
        movea.l adapt_siztab(a5),a0
        moveq   #12-1,d0
bcl8:
        move.w  (a6)+,(a0)+
        dbf     d0,bcl8
        movea.l adapt_gcurx(a5),a0
        move.l  (a6)+,(a0)
        pea     sav_col(pc)     ;Restore colors
        move.w  #6,-(a7)        ;Setpalette
        trap    #14
        addq.l  #6,a7
        move.w  #0x25,-(a7)     ;Vsync
        trap    #14
        addq.l  #2,a7
        clr.w   -(a7)           ;Pterm
        trap    #1

; Joystick input routine
; ~~~~~~~~~~~~~~~~~~~~~~
Joy_In: lea     Joy_Pos(pc),a2
        move.b  2(a0),(a2)
        rts

; As supervisor
; ~~~~~~~~~~~~~
sav_vect:
; copy the palette
        move.l  a5,-(a7)
        lea     Adapt(pc),a5

        lea     0xffff8240,a0
        lea     sav_col(pc),a1
        moveq   #16-1,d0
bcl8A:
        move.w  (a0)+,(a1)+
        dbf     d0,bcl8A
; dummy float trap
        lea     fake_fl(pc),a0
        move.l  a0,0x98

; save hbl & vbl interrupt vector
	    move.l  0x68,save_hbl-Adapt(a5)
	    move.l  0x70,save_vbl-Adapt(a5)

; save soundctrl register, and set it to 12.5Khz
        move.l  sp,d0
        move.l  0x08,d1
        lea     noste(pc),a0
        move.l  a0,0x08
        move.b  soundctrl,soundctrl_save-Adapt(a5)
        move.b  #1,soundctrl
        move.b  #1,soundctrl_was_saved-Adapt(a5)
noste:

; save falcon video registers
        lea        nofalcon(pc),a0
        move.l     a0,0x08
        lea        falcon_save(pc),a1
		move.w     0xffff8210,(a1)+   /* width of scanline */
		lea 0xffff8280,a0
		move.w     (a0)+,(a1)+   /* HHC - Horizontal Hold Counter */
		move.w     (a0)+,(a1)+   /* HHT - Horizontal Hold Timer */
		move.w     (a0)+,(a1)+   /* HBB - Horizontal Border Begin */
		move.w     (a0)+,(a1)+   /* HBE - Horizontal Border End */
		move.w     (a0)+,(a1)+   /* HDB - Horizontal Display Begin */
		move.w     (a0)+,(a1)+   /* HDE - Horizontal Display End */
		move.w     (a0)+,(a1)+   /* HSS - Horizontal SS */
		move.w     (a0)+,(a1)+   /* HFS - Horizontal FS */
		move.w     (a0)+,(a1)+   /* HEE - Horizontal EE */
		lea 0xffff82a0,a0
		move.w     (a0)+,(a1)+   /* VFC - Vertical Frequency Counter */
		move.w     (a0)+,(a1)+   /* VFT - Vertical Frequency Timer */
		move.w     (a0)+,(a1)+   /* VBB - Vertical Border Begin */
		move.w     (a0)+,(a1)+   /* VBE - Vertical Border End */
		move.w     (a0)+,(a1)+   /* VDB - Vertical Display Begin */
		move.w     (a0)+,(a1)+   /* VDE - Vertical Display End */
		move.w     (a0)+,(a1)+   /* VSS - Vertical SS */
		move.w     0xffff82c0,(a1)+   /* VMC - Video Master control */
		move.w     0xffff82c2,(a1)+   /* VCO - Video Control */

; copy the palette
		lea.l      0xffff9800,a0
		lea.l      falcon_pal(pc),a1
		move.w     #256-1,d2
copy_falpal:
		move.l     (a0)+,(a1)+
		dbf        d2,copy_falpal

        move.b  #1,falcon_was_saved-Adapt(a5)
nofalcon:
        
        move.l  d0,sp
        move.l  d1,0x08
        move.l  (a7)+,a5
        rts

; dummy float trap
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fake_fl:cmp.b   #12,d0
        beq.s   fltoa
        moveq   #0,d0
        moveq   #0,d1
        rte
; Function 0x0c 'FLTOA'
; ~~~~~~~~~~~~~~~~~~~
fltoa:  move.b  #'0',(a0)
        move.b  #'.',1(a0)
        move.b  #'0',2(a0)
        clr.b   3(a0)
        rte


; As supervisor
; ~~~~~~~~~~~~~
rest_vect:
; restore hbl & vbl interrupt vector
	    move.l  save_hbl(pc),0x68
	    move.l  save_vbl(pc),0x70

; restore sound ctrl
        move.b  soundctrl_was_saved(pc),d0
        beq.s   rest_vect1
        move.b  soundctrl_save(pc),soundctrl
rest_vect1:

; restore falcon palette
        move.b  falcon_was_saved(pc),d0
        beq.s   rest_vect2

		lea.l      0xffff9800,a1
		lea.l      falcon_pal(pc),a0
		move.w     #256-1,d0
rest_falpal:
		move.l     (a0)+,(a1)+
		dbf        d0,rest_falpal

; restore falcon video registers
        lea        falcon_save(pc),a0
		move.w     (a0)+,0xffff8210   /* width of scanline */
		lea        0xffff8280,a1
		move.w     (a0)+,(a1)+   /* HHC - Horizontal Hold Counter */
		move.w     (a0)+,(a1)+   /* HHT - Horizontal Hold Timer */
		move.w     (a0)+,(a1)+   /* HBB - Horizontal Border Begin */
		move.w     (a0)+,(a1)+   /* HBE - Horizontal Border End */
		move.w     (a0)+,(a1)+   /* HDB - Horizontal Display Begin */
		move.w     (a0)+,(a1)+   /* HDE - Horizontal Display End */
		move.w     (a0)+,(a1)+   /* HSS - Horizontal SS */
		move.w     (a0)+,(a1)+   /* HFS - Horizontal FS */
		move.w     (a0)+,(a1)+   /* HEE - Horizontal EE */
		lea        0xffff82a0,a1
		move.w     (a0)+,(a1)+   /* VFC - Vertical Frequency Counter */
		move.w     (a0)+,(a1)+   /* VFT - Vertical Frequency Timer */
		move.w     (a0)+,(a1)+   /* VBB - Vertical Border Begin */
		move.w     (a0)+,(a1)+   /* VBE - Vertical Border End */
		move.w     (a0)+,(a1)+   /* VDB - Vertical Display Begin */
		move.w     (a0)+,(a1)+   /* VDE - Vertical Display End */
		move.w     (a0)+,(a1)+   /* VSS - Vertical SS */
		move.w     (a0)+,0xffff82c0   /* VMC - Video Master control */
		move.w     (a0)+,0xffff82c2   /* VCO - Video Control */

rest_vect2:
        rts

; Disk Interfacing Routines
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fsnext:
        move.w  #0x4f,-(sp)
        trap    #1
        addq.l  #2,sp
        rts
set_dta:
        move.l  a0,-(a7)
        pea     dta(pc)
        move.w  #26,-(a7)   ;Fsetdta
        trap    #1
        addq.l  #6,a7
        movea.l (a7)+,a0
        rts

set_path:
        move.l  a0,-(a7)
        move.w  #59,-(a7)   ;Dsetpath
        trap    #1
        addq.l  #6,a7
        tst.w   d0
        rts

fsfirst:
        move.l  a0,-(a7)
        clr.w   -(a7)
        move.l  a0,-(a7)
        move.w  #78,-(a7)
        trap    #1
        addq.l  #8,a7
        move.l  (a7)+,a0
        tst.w   d0
        bne.s   fsfirst1
        lea     name(pc),a0
fsfirst1:
        rts

fopen:
        clr.w   -(a7)
        move.l  a0,-(a7)
        move.w  #61,-(a7)
        trap    #1
        addq.l  #8,a7
        tst.w   d0
        bmi     Error1
        lea     handle(pc),a0
        move.w  d0,(a0)
        rts

charge:
        move.l  size(pc),d0
fread:
        move.l  a0,-(a7)
        move.l  d0,-(a7)
        move.w  handle(pc),-(a7)
        move.w  #63,-(a7)
        trap    #1
        lea     12(a7),a7
        tst.l   d0
        bmi     Error
        rts
fclose:
        move.w  handle(pc),-(a7)
        move.w  #62,-(a7)
        trap    #1
        addq.l  #4,a7
        rts
print:
        move.l  a0,-(a7)
        move.w  #9,-(a7)
        trap    #1
        addq.l  #6,a7
        rts

; EXEC normal ---> error if file not on disk
get_im:
        bsr     get_bin
        bne     ErrorLoad
        rts
; EXEC: load the program -if it is there- and relocate it!
get_bin:
        movem.l d1-d7/a1-a6,-(a7)
        bsr     set_dta
        bsr     fsfirst
        bne     failed
        move.l  end_adr(pc),d3
        add.l   size(pc),d3     ;check the memory size!
        addi.l  #60000,d3
        cmp.l   logic(pc),d3
        bcc     Error
        bsr     fopen
        movea.l end_adr(pc),a0
        bsr     charge
        bsr     fclose
; relocate the program
        movea.l end_adr(pc),a1
        move.l  2(a1),d0        ;distance to the table
        add.l   6(a1),d0
        andi.l  #0xffffff,d0
        adda.w  #28,a1          ;marks the start of the program
        movea.l a1,a2
        move.l  a2,d2           ;d2=start of program
        adda.l  d0,a1
        clr.l   d0
        tst.l   (a1)
        beq.s   reloge
        adda.l  (a1)+,a2        ;point to the first address to relocate
        bra.s   noerr
err:
        move.b  (a1)+,d0
        beq.s   reloge
        cmp.b   #1,d0
        beq.s   do_asc
        adda.w  d0,a2           ;next fixup address
noerr:
        add.l   d2,(a2)         ;reocate program address
        bra.s   err
do_asc:
        adda.w  #254,a2         ;if 1 skips 254 bytes
        bra.s   err
; update end address with the length of the program
reloge:
        lea.l   end_adr(pc),a0
        move.l  (a0),d0
        move.l  d0,d1
        add.l   size(pc),d1
        btst    #0,d1
        beq.s   pair
        addq.l  #1,d1
pair:
        move.l  d1,(a0)
        movem.l (a7)+,d1-d7/a1-a6
        move.l  d0,a0
        moveq   #0,d0
        rts
failed:
        movem.l (a7)+,d1-d7/a1-a6
        moveq   #1,d0
        rts

EXIT:   .dc.l    0
