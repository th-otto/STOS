****************************************
* New 3d menu support for menu extension
****************************************

	.include "linea.inc"

SCRATCHBUF_SIZE equ 1024

MAX_TITLE equ 6
MAX_ENTRY equ 11 /* one of them used for the title, so actually 10 */

MAX_ALERT_STR equ 7
MAX_ALERT_BUT equ 3
MAX_ALERT_ICON equ 5
ALERT_STR_SIZE equ 38
ALERT_BUT_SIZE equ 8

MD_REPLACE = 0
MD_TRANS   = 1

TXT_LIGHT = 2

	.OFFSET 0
mn_state: ds.w 1
mn_x1: ds.w 1
mn_y1: ds.w 1
mn_x2: ds.w 1
mn_y2: ds.w 1
mn_fillcolor: ds.w 1 /* 10 */
mn_leftcolor: ds.w 1 /* 12 */
mn_rightcolor: ds.w 1 /* 14 */
mn_textcolor: ds.w 1 /* 16 */
mn_sizeof:

	.OFFSET 0
tit_state: ds.w 1
tit_x1: ds.w 1
tit_y1: ds.w 1
tit_x2: ds.w 1
tit_y2: ds.w 1
tit_entcount: ds.w 1
tit_sizeof:

	.OFFSET 0
ent_x1: ds.w 1
ent_y1: ds.w 1
ent_x2: ds.w 1
ent_y2: ds.w 1
ent_state: ds.w 1
ent_namelen: ds.w 1
ent_namesize = 16
ent_name: ds.b ent_namesize
ENT_SIZE:

MENU_SIZE equ ENT_SIZE*MAX_ENTRY+tit_sizeof

	.text


*
* Syntax    :-   MN=_fmenu select
*
fmenu_select:
		moveq.l    #0,d0
		tst.w      in_menu_check
		bne.s      fmenu_select1
		move.w     selected_title,d1
		btst       #15,d1
		beq.s      fmenu_select1
		exg        d1,d0
		andi.l     #0x0000007F,d0
		andi.w     #0x7FFF,selected_title
fmenu_select1:
		rts


*
* Syntax    :-   ITEM=_fmenu item
*
fmenu_item:
		moveq.l    #0,d0
		tst.w      in_menu_check
		bne.s      fmenu_item1
		move.w     selected_item,d1
		btst       #15,d1
		beq.s      fmenu_item1
		exg        d1,d0
		andi.l     #0x0000007F,d0
		andi.w     #0x7FFF,selected_item
fmenu_item1:
		rts


set_titles_on:
		move.w     #-1,titles_are_on
		rts

set_titles_off:
		move.w     #0,titles_are_on
		rts

titles_are_on: dc.w 0
in_menu_check: dc.w 0


menu_check:
		tst.w      titles_are_on
		beq.s      menu_check1
		tst.w      in_menu_check
		bne.s      menu_check1
		movem.l    d0-d7/a0-a6,-(a7)
		bsr.s      do_menu_check
		movem.l    (a7)+,d0-d7/a0-a6
menu_check1:
		rts

x1311e:
		jmp        0.l


do_menu_check:
		move.w     #-1,in_menu_check
		lea.l      menuparams(pc),a1
		move.w     menuparams-menuparams(a1),d1
		btst       #1,d1
		bne.s      do_menu_check_1
		move.w     #0,in_menu_check
		rts
do_menu_check_1:
		bsr        checkmouse
		cmp.w      mn_y2(a1),d1
		bcc.s      do_menu_check_4
		bsr        check_mouse_title
		movem.l    d1-d3/a2,-(a7)
		lea.l      menuinfo+tit_sizeof(pc),a2
		moveq.l    #0,d3
		move.w     d0,d3
		subq.w     #1,d3
		bmi.s      do_menu_check_2
		mulu.w     #MENU_SIZE,d3
		adda.l     d3,a2
		move.w     ent_state(a2),d1
		and.w      d1,d0
do_menu_check_2:
		movem.l    (a7)+,d1-d3/a2
		tst.w      d0
		beq.s      do_menu_check_3
		cmp.w      last_title(pc),d0
		beq.s      do_menu_check_3
		move.w     d0,selected_title
		move.w     d0,last_title
		bsr        st_mouse_off
		bsr        restore_dropdown
		bsr        save_dropdown
		bsr        draw_dropdown
		bsr        st_mouse_on
do_menu_check_3:
		move.w     #0,in_menu_check
		rts
do_menu_check_4:
		lea.l      menuinfo(pc),a0
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2
		move.w     num_titles(pc),d7
		subq.w     #1,d7
do_menu_check_5:
		tst.w      (a0)
		bne.s      do_menu_check_6
		/* adda.l     #MENU_SIZE,a0
		adda.l     #MENU_SIZE,a2 */
		dc.w 0xd1fc,0,MENU_SIZE
		dc.w 0xd5fc,0,MENU_SIZE /* XXX */
		dbf        d7,do_menu_check_5
		move.w     #0,in_menu_check
		rts
do_menu_check_6:
		bsr        checkmouse
		cmp.w      mn_y2(a1),d1
		bcs.s      do_menu_check_7
		tst.w      d2
		beq.s      do_menu_check_7
		bsr.s      st_mouse_off
		bsr        restore_dropdown
		bsr.s      st_mouse_on
		bsr        find_entry
		tst.w      d0
		beq.s      do_menu_check_8
		moveq.l    #0,d1
		move.w     d0,d1
		subq.w     #1,d1
		mulu.w     #ENT_SIZE,d1
		adda.l     d1,a2
		move.w     ent_state(a2),d1
		and.w      d1,d0
		tst.w      d0
		beq.s      do_menu_check_8
		ori.w      #0x8000,d0
		move.w     d0,selected_item
		ori.w      #0x8000,selected_title
		move.w     #0,last_title
do_menu_check_7:
		move.w     #0,in_menu_check
		rts
do_menu_check_8:
		move.w     #0,selected_item
		move.w     #0,selected_title
		move.w     #0,last_title
		move.w     #0,in_menu_check
		rts

last_title: dc.w       0
        dc.w       0 /* unused */
selected_title: dc.w  0
selected_item: dc.w  0



st_mouse_off:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #S_st_mouse_off,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		rts

st_mouse_on:
		movem.l    d0-d7/a0-a6,-(a7)
		moveq.l    #S_st_mouse_on,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		rts


checkmouse:
		movem.l    d3-d7/a0-a6,-(a7)
		move.w     #S_mouse,d0
		trap       #5
		movem.l    d0-d1,-(a7)
		move.w     #S_mousekey,d0
		trap       #5
		move.l     d0,d2
		movem.l    (a7)+,d0-d1
		movem.l    (a7)+,d3-d7/a0-a6
		rts

save_title_coords:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menuinfo+tit_sizeof(pc),a2
		lea.l      title_coords(pc),a3
		move.w     num_titles,d7
		subq.w     #1,d7
save_title_coords_1:
		/* move.w     ent_x1(a2),d0 */
		dc.w 0x302a,ent_x1 /* XXX */
		move.w     ent_x2(a2),d1
		move.w     ent_y1(a2),d2
		move.w     ent_y2(a2),d3
		move.w     d0,(a3)+
		move.w     d1,(a3)+
		move.w     d2,(a3)+
		move.w     d3,(a3)+
		lea.l      MENU_SIZE(a2),a2
		dbf        d7,save_title_coords_1
		movem.l    (a7)+,d0-d7/a0-a6
		rts


check_mouse_title:
		movem.l    d2-d7/a0-a6,-(a7)
		move.w     d0,d2
		move.w     d1,d3
		move.w     #MAX_TITLE+4-1,d1
		lea.l      title_coords(pc),a1
check_mouse_title_1:
		tst.w      (a1)
		bne.s      check_mouse_title_3
check_mouse_title_2:
		addq.l     #8,a1
		dbf        d1,check_mouse_title_1
		clr.l      d0
		clr.l      d1
		movem.l    (a7)+,d2-d7/a0-a6
		rts
check_mouse_title_3:
		cmp.w      (a1),d2
		bcs.s      check_mouse_title_2
		cmp.w      2(a1),d2
		beq.s      check_mouse_title_4
		bcc.s      check_mouse_title_2
check_mouse_title_4:
		cmp.w      4(a1),d3
		bcs.s      check_mouse_title_2
		cmp.w      6(a1),d3
		beq.s      check_mouse_title_5
		bcc.s      check_mouse_title_2
check_mouse_title_5:
		neg.w      d1
		addi.w     #MAX_TITLE+4,d1
		clr.l      d0
		exg        d1,d0
		movem.l    (a7)+,d2-d7/a0-a6
		rts


save_entry_coords:
		bsr        clear_entry_coords
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2
		lea.l      entry_coords(pc),a3
		move.w     num_titles(pc),d7
		subq.w     #1,d7
save_entry_coords_1:
		tst.w      (a1)
		bne.s      save_entry_coords_2
		/* adda.l     #MENU_SIZE,a1
		adda.l     #MENU_SIZE,a2 */
		dc.w 0xd3fc,0,MENU_SIZE
		dc.w 0xd5fc,0,MENU_SIZE /* XXX */
		dbf        d7,save_entry_coords_1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
save_entry_coords_2:
		move.w     tit_x2(a1),d1
		subq.w     #8,d1
		move.w     tit_entcount(a1),d7
		subq.w     #1,d7
save_entry_coords_3:
		/* move.w     ent_x1(a2),d0 */
		dc.w 0x302a,ent_x1 /* XXX */
		move.w     ent_y1(a2),d2
		move.w     ent_y2(a2),d3
		move.w     d0,(a3)+
		move.w     d1,(a3)+
		move.w     d2,(a3)+
		move.w     d3,(a3)+
		lea.l      ENT_SIZE(a2),a2
		dbf        d7,save_entry_coords_3
		movem.l    (a7)+,d0-d7/a0-a6
		rts


find_entry:
		movem.l    d2-d7/a0-a6,-(a7)
		move.w     d0,d2
		move.w     d1,d3
		move.w     #MAX_ENTRY+9-1,d1
		lea.l      entry_coords(pc),a1
find_entry_1:
		tst.w      (a1)
		bne.s      find_entry_3
find_entry_2:
		addq.l     #8,a1
		dbf        d1,find_entry_1
		clr.l      d0
		clr.l      d1
		movem.l    (a7)+,d2-d7/a0-a6
		rts
find_entry_3:
		cmp.w      (a1),d2
		bcs.s      find_entry_2
		cmp.w      2(a1),d2
		beq.s      find_entry_4
		bcc.s      find_entry_2
find_entry_4:
		cmp.w      4(a1),d3
		bcs.s      find_entry_2
		cmp.w      6(a1),d3
		beq.s      find_entry_5
		bcc.s      find_entry_2
find_entry_5:
		neg.w      d1
		addi.w     #MAX_ENTRY+9,d1
		clr.l      d0
		exg        d1,d0
		movem.l    (a7)+,d2-d7/a0-a6
		rts

clear_entry_coords:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      entry_coords(pc),a0
		moveq.l    #((MAX_ENTRY+9)*8)/4-1,d7
clear_entry_coords_1:
		clr.l      (a0)+
		dbf        d7,clear_entry_coords_1
		movem.l    (a7)+,d0-d7/a0-a6
		rts


*
* Syntax    :-   _fmenu init COL1,COL2,COL3,COL4
*
fmenu_init:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      fonthdr(pc),a3
		/* clr.l      0(a3) */
                                     dc.w 0x42ab,0 /* XXX */
		clr.w      sysfont-fonthdr(a3)
		clr.w      text_style-fonthdr(a3)
		clr.w      textfg_color-fonthdr(a3)
		clr.w      textbg_color-fonthdr(a3)
		clr.w      wrt_mode-fonthdr(a3)
		clr.w      text_rotation-fonthdr(a3)
		clr.w      text_double-fonthdr(a3)
		clr.w      textblit_coords-fonthdr(a3)
		clr.w      textblit_coords+2-fonthdr(a3)
		clr.w      save_clip_flap-fonthdr(a3)
		clr.w      x1603c-fonthdr(a3)
		clr.l      x1603e-fonthdr(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        initmenu
		bsr        set_fontheight
		movem.l    (a7)+,d0-d7/a0-a6
		lea.l      menuparams(pc),a1
		movea.l    lineavars,a2
		lea.l      fonthdr(pc),a3
		move.w     V_REZ_HZ(a2),d0
		subq.w     #1,d0
		move.w     #0,mn_x1(a1)
		move.w     #0,mn_y1(a1)
		move.w     d0,mn_x2(a1)
		move.w     d1,mn_fillcolor(a1)
		move.w     d2,mn_leftcolor(a1)
		move.w     d3,mn_rightcolor(a1)
		move.w     d4,mn_textcolor(a1)
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     fontheight(pc),d4
		move.w     d4,d5
		asr.w      #1,d5
		add.w      d5,d4
		subq.w     #1,d4
		move.w     d4,mn_y2(a1)
		/* move.w     #1,0(a1) */
                                     dc.w 0x337c,1,0 /* XXX */

*
* clear all menu entries
*
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof(pc),a2
		moveq.l    #0,d1
		moveq.l    #MAX_TITLE-2,d3 /* BUG */
fmenu_clear1:
		moveq.l    #0,d2
		moveq.l    #MAX_ENTRY,d4
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     d1,d5
		mulu.w     #MENU_SIZE,d5
		clr.w      0(a1,d5.w)
		clr.w      tit_x1(a1,d5.w)
		clr.w      tit_y1(a1,d5.w)
		clr.w      tit_x2(a1,d5.w)
		clr.w      tit_y2(a1,d5.w)
		clr.w      tit_entcount(a1,d5.w)
		movem.l    (a7)+,d0-d7/a0-a6
fmenu_clear2:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     d1,d5
		move.w     d2,d6
		mulu.w     #MAX_ENTRY*ENT_SIZE,d5
		mulu.w     #ENT_SIZE,d6
		add.w      d5,d6
		clr.w      ent_x1(a2,d6.w)
		clr.w      ent_y1(a2,d6.w)
		clr.w      ent_x2(a2,d6.w)
		clr.w      ent_y2(a2,d6.w)
		clr.w      ent_state(a2,d6.w)
		clr.w      ent_namelen(a2,d6.w)
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d2
		cmp.w      d2,d4
		bne.s      fmenu_clear2
		addq.w     #1,d1
		cmp.w      d1,d3
		bne.s      fmenu_clear1

* init first title
		lea.l      menuinfo+0*MENU_SIZE(pc),a1
		lea.l      menuinfo+0*MENU_SIZE+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		move.w     mn_y2(a3),d6
		addq.w     #1,d6
		move.w     fontheight(pc),d7
		sub.w      d7,d6
		asr.w      #1,d6
		/* move.w     #8,ent_x1(a2) */
        dc.w 0x357c,8,ent_x1 /* XXX */
		move.w     d6,ent_y1(a2)
		add.w      d7,d6
		move.w     d6,ent_y2(a2)
		clr.w      tit_entcount(a1)

		lea.l      menuinfo+1*MENU_SIZE(pc),a1
		lea.l      menuinfo+1*MENU_SIZE+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		move.w     mn_y2(a3),d6
		addq.w     #1,d6
		move.w     fontheight(pc),d7
		sub.w      d7,d6
		asr.w      #1,d6
		/* move.w     #8,ent_x1(a2) */
        dc.w 0x357c,8,ent_x1 /* XXX */
		move.w     d6,ent_y1(a2)
		add.w      d7,d6
		move.w     d6,ent_y2(a2)
		clr.w      tit_entcount(a1)

		lea.l      menuinfo+2*MENU_SIZE(pc),a1
		lea.l      menuinfo+2*MENU_SIZE+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		move.w     mn_y2(a3),d6
		addq.w     #1,d6
		move.w     fontheight(pc),d7
		sub.w      d7,d6
		asr.w      #1,d6
		/* move.w     #8,ent_x1(a2) */
        dc.w 0x357c,8,ent_x1 /* XXX */
		move.w     d6,ent_y1(a2)
		add.w      d7,d6
		move.w     d6,ent_y2(a2)
		clr.w      tit_entcount(a1)

		lea.l      menuinfo+3*MENU_SIZE(pc),a1
		lea.l      menuinfo+3*MENU_SIZE+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		move.w     mn_y2(a3),d6
		addq.w     #1,d6
		move.w     fontheight(pc),d7
		sub.w      d7,d6
		asr.w      #1,d6
		/* move.w     #8,ent_x1(a2) */
        dc.w 0x357c,8,ent_x1 /* XXX */
		move.w     d6,ent_y1(a2)
		add.w      d7,d6
		move.w     d6,ent_y2(a2)
		clr.w      tit_entcount(a1)

		lea.l      menuinfo+4*MENU_SIZE(pc),a1
		lea.l      menuinfo+4*MENU_SIZE+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		move.w     mn_y2(a3),d6
		addq.w     #1,d6
		move.w     fontheight(pc),d7
		sub.w      d7,d6
		asr.w      #1,d6
		/* move.w     #8,ent_x1(a2) */
        dc.w 0x357c,8,ent_x1 /* XXX */
		move.w     d6,ent_y1(a2)
		add.w      d7,d6
		move.w     d6,ent_y2(a2)
		clr.w      tit_entcount(a1)

		lea.l      menuinfo+5*MENU_SIZE(pc),a1
		lea.l      menuinfo+5*MENU_SIZE+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		move.w     mn_y2(a3),d6
		addq.w     #1,d6
		move.w     fontheight(pc),d7
		sub.w      d7,d6
		asr.w      #1,d6
		/* move.w     #8,ent_x1(a2) */
        dc.w 0x357c,8,ent_x1 /* XXX */
		move.w     d6,ent_y1(a2)
		add.w      d7,d6
		move.w     d6,ent_y2(a2)
		clr.w      tit_entcount(a1)

		clr.w      num_titles
		movem.l    (a7)+,d0-d7/a0-a6
		clr.l      d0
		rts


*
* Syntax    :-   _fmenu on
*
fmenu_on:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menuparams(pc),a1
		/* move.w     0(a1),d0 */
		dc.w 0x3029,0 /* XXX */
		btst       #0,d0
		beq.s      fmenu_on3
		cmpi.w     #0x8003,(a1)
		beq.s      fmenu_on2
		cmpi.w     #3,(a1)
		beq.s      fmenu_on1
		bsr        draw_title_line
		bsr        save_title_coords
		/* move.w     0(a1),d1 */
		dc.w 0x3229,0 /* XXX */
		bset       #1,d1
		/* move.w     d1,0(a1) */
		dc.w 0x3341,0 /* XXX */
		bsr        set_titles_on
fmenu_on1:
		movem.l    (a7)+,d0-d7/a0-a6
		clr.l      d0
		rts
fmenu_on2:
		bsr        redraw_titles
		/* move.w     0(a1),d1 */
		dc.w 0x3229,0 /* XXX */
		bclr       #15,d1
		/* move.w     d1,0(a1) */
		dc.w 0x3341,0 /* XXX */
		bsr        set_titles_on
		movem.l    (a7)+,d0-d7/a0-a6
		clr.l      d0
		rts
fmenu_on3:
		movem.l    (a7)+,d0-d7/a0-a6
		moveq.l    #-1,d0
		rts


*
* Syntax    :-   _fmenu kill
*
fmenu_kill:
		lea.l      menuparams(pc),a1
		tst.w      mn_state(a1)
		beq.s      fmenu_kill1
		bsr        set_titles_off
		lea.l      menuparams(pc),a1
		/* move.w     #0,mn_state(a1) */
		dc.w 0x337c,0,0 /* XXX */
fmenu_kill1:
		rts

*
* Syntax    :-   _fmenu freeze
*
fmenu_freeze:
		lea.l      menuparams(pc),a1
		tst.w      mn_state(a1)
		beq.s      fmenu_freeze2
fmenu_freeze1:
		tst.w      in_menu_check
		bne.s      fmenu_freeze1
		bsr        set_titles_off
		lea.l      menuparams(pc),a1
		/* ori.w      #0x8000,mn_state(a1) */
		dc.w 0x0069,0x8000,0 /* XXX */
fmenu_freeze2:
		rts



*
* Syntax    :-   _fmenu$ TITLE,TITLE$
*                _fmenu$ TITLE,ITEM,ITEM$
*
* Inputs:
*  a0 = title$
*  d1 = title
*  d2 = item
fmenustr:
		cmpi.w     #MAX_TITLE+1,d1
		bcs.s      fmenustr1
		moveq.l    #-2,d0
		rts
fmenustr1:
		lea.l      menuparams(pc),a1
		/* move.w     mn_state(a1),d0 */
		dc.w 0x3029,0 /* XXX */
		btst       #0,d0
		beq        fmenustr7
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		subq.w     #1,d1
		bmi        fmenustr6
		tst.w      d2
		beq        fmenustr8
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2 /* point to first dropdown entry */
		lea.l      fmenustr_maxlen(pc),a4
		andi.l     #0x000000FF,d2
		subq.w     #1,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     #ENT_SIZE,d5
		mulu.w     d2,d5
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		addq.w     #1,d2
		adda.l     d3,a1
		cmpi.w     #MAX_ENTRY,d2
		bcs.s      fmenustr2
		moveq.l    #-2,d0
		rts
fmenustr2:
		adda.l     d3,a2
		adda.l     d5,a2
		lea.l      ent_name(a2),a5
		move.w     #0x00FF,ent_state(a2)
		move.w     (a0)+,d7
		cmpi.w     #ent_namesize,d7
		bcs.s      fmenustr3
		moveq.l    #ent_namesize,d7
fmenustr3:
		move.w     d7,ent_namelen(a2)
		subq.w     #1,d7
fmenustr4:
		move.b     (a0)+,(a5)+
		dbf        d7,fmenustr4
		addq.w     #1,tit_entcount(a1)
		move.w     ent_namelen(a2),d7
		asl.w      #3,d7 /* BUG: should use fontwidth */
		move.w     tit_x1(a1),d5
		addq.w     #8,d5
		/* move.w     d5,ent_x1(a2) */
		dc.w 0x3545,ent_x1 /* XXX */
		add.w      d7,d5
		move.w     d5,ent_x2(a2)
		move.w     ent_namelen(a2),d7
		cmp.w      (a4),d7
		bcs.s      fmenustr5
		move.w     d7,(a4)
fmenustr5:
		move.w     (a4),d7
		asl.w      #3,d7 /* BUG: should use fontwidth */
		move.w     tit_x1(a1),d5
		add.w      d7,d5
		addi.w     #24,d5
		move.w     d5,tit_x2(a1)
		moveq.l    #0,d4
		moveq.l    #0,d5
		subq.w     #1,d2
		move.w     tit_y1(a1),d5
		move.w     fontheight(pc),d7
		asr.w      #1,d7
		add.w      d7,d5
		move.w     fontheight(pc),d7
		asl.w      #1,d7
		mulu.w     d2,d7
		add.w      d7,d5
		move.w     d5,ent_y1(a2)
		move.w     fontheight(pc),d7
		asl.w      #1,d7
		add.w      d7,d5
		move.w     d5,ent_y2(a2)
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d7
		move.w     fontheight(pc),d7
		asl.w      #1,d7
		move.w     tit_entcount(a1),d4
		addq.w     #1,d4
		move.w     tit_y1(a1),d5
		mulu.w     d4,d7
		sub.w      fontheight(pc),d7
		sub.w      fontheight(pc),d7
		add.w      d7,d5
		move.w     d5,tit_y2(a1)
fmenustr6:
		clr.l      d0
		rts
fmenustr7:
		moveq.l    #-1,d0
		rts

fmenustr_maxlen: dc.w       0

* set the title itself
fmenustr8:
		lea.l      fmenustr_maxlen(pc),a4
		clr.w      (a4)
		moveq.l    #0,d3
		moveq.l    #0,d4
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		adda.l     d3,a1
		adda.l     d3,a2
		lea.l      ent_name(a2),a5
		move.w     #-1,ent_state(a2)
		move.w     (a0)+,d7
		cmpi.w     #ent_namesize,d7
		bcs.s      fmenustr9
		moveq.l    #ent_namesize,d7
fmenustr9:
		move.w     d7,ent_namelen(a2)
		subq.w     #1,d7
fmenustr10:
		move.b     (a0)+,(a5)+
		dbf        d7,fmenustr10
		addq.w     #1,num_titles
		/* move.w     ent_x1(a2),d5 */
		dc.w 0x3a2a,ent_x1 /* XXX */
		move.w     ent_namelen(a2),d7
		asl.w      #3,d7
		add.w      d5,d7
		move.w     d7,ent_x2(a2)
		/* move.w     ent_x1(a2),d5 */
		dc.w 0x3a2a,ent_x1 /* XXX */
		move.w     mn_y2(a3),d6
		/* subq.w     #8,d5 */
		dc.w 0x0445,8 /* XXX */
		move.w     d5,tit_x1(a1)
		addi.w     #128,d5
		move.w     d5,tit_x2(a1)
		addq.w     #1,d6
		move.w     d6,tit_y1(a1)
		move.w     d6,tit_y2(a1)
		cmpi.w     #MAX_TITLE,d1
		bcc.s      fmenustr11
		addi.w     #16,d7
		lea.l      MENU_SIZE(a2),a2
		/* move.w     d7,ent_x1(a2) */
		dc.w 0x3547,ent_x1 /* XXX */
fmenustr11:
		clr.l      d0
		rts


*
* Syntax    :-   _fmenu$ off TITLE
*                _fmenu$ off TITLE,ITEM
*
* Inputs:
*  d1 = title
*  d2 = item
fmenustr_off:
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		subq.w     #1,d1
		bmi.s      fmenustr_off1
		tst.w      d2
		beq.s      fmenustr_off2
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2
		andi.l     #0x000000FF,d2
		subq.w     #1,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     #ENT_SIZE,d5
		mulu.w     d2,d5
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		addq.w     #1,d2
		adda.l     d3,a1
		adda.l     d3,a2
		adda.l     d5,a2
		lea.l      ent_name(a2),a5
		move.b     #0,ent_state+1(a2)
fmenustr_off1:
		rts
fmenustr_off2:
* disable the title
		moveq.l    #0,d3
		moveq.l    #0,d4
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		adda.l     d3,a1
		adda.l     d3,a2
		lea.l      ent_name(a2),a5
		move.w     #0,ent_state(a2)
		bsr        redraw_titles
		rts


*
* Syntax    :-   _fmenu check item TITLE,ITEM
* Syntax    :-   _fmenu uncheck item TITLE,ITEM
*
* Inputs:
*  d1 = title
*  d2 = item
*
fmenu_check_item:
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		subq.w     #1,d1
		bmi.s      fmenu_check_item1
		tst.w      d2
		beq.s      fmenu_check_item1
		move.w     d3,d7
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2
		andi.l     #0x000000FF,d2
		subq.w     #1,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     #ENT_SIZE,d5
		mulu.w     d2,d5
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		addq.w     #1,d2
		adda.l     d3,a1
		adda.l     d3,a2
		adda.l     d5,a2
		lea.l      ent_name(a2),a5
		move.b     d7,ent_state(a2)
fmenu_check_item1:
		rts


*
* Syntax    :-   H=_fmenu height
*
fmenu_height:
		lea.l      menuparams(pc),a0
		moveq.l    #0,d0
		tst.w      mn_state(a0)
		beq.s      fmenu_height1
		move.w     mn_y1(a0),d1
		move.w     mn_y2(a0),d0
		sub.w      d1,d0
		addq.w     #1,d0
		andi.l     #255,d0 /* what for? */
fmenu_height1:
		rts



*
* Syntax    :-   _fmenu$ on TITLE
*                _fmenu$ on TITLE,ITEM
*
* Inputs:
*  d1 = title
*  d2 = item
*
fmenustr_on:
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof(pc),a2
		lea.l      menuparams(pc),a3
		subq.w     #1,d1
		bmi.s      fmenustr_on1
		tst.w      d2
		beq.s      fmenustr_on2
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2
		andi.l     #255,d2
		subq.w     #1,d2
		moveq.l    #0,d3
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     #ENT_SIZE,d5
		mulu.w     d2,d5
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		addq.w     #1,d2
		adda.l     d3,a1
		adda.l     d3,a2
		adda.l     d5,a2
		lea.l      tit_sizeof(a2),a5
		move.b     #-1,ent_state+1(a2)
fmenustr_on1:
		rts
fmenustr_on2:
		moveq.l    #0,d3
		moveq.l    #0,d4
		move.w     d1,d3
		move.w     d1,d4
		mulu.w     #MENU_SIZE,d3
		adda.l     d3,a1
		adda.l     d3,a2
		lea.l      ent_name(a2),a5
		move.w     #-1,ent_state(a2)
		bsr        redraw_titles
		rts



*
* Syntax    :-   BTN=_form alert(COL1,COL2,COL3,COL4,ALERT$)
*
* Inputs:
*  d1 = COL1
*  d2 = COL2
*  d3 = COL3
*  d4 = COL4
*  a0 = ALERT$
*
form_alert:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        initmenu
		bsr        set_fontheight
		movem.l    (a7)+,d0-d7/a0-a6
		bsr        init_alert_params
		bsr        init_alert_str
		bsr        init_alert_icon
		tst.w      d7
		bne.s      form_alert2
		bsr        parse_alert_strings
		tst.w      d7
		bne.s      form_alert2
		bsr        parse_alert_buttons
		tst.w      d7
		bne.s      form_alert2
		bsr        st_mouse_off
		bsr        save_screen
		bsr        draw_alert_box
		bsr        draw_alert_button_frames
		bsr        draw_alert_button_texts
		bsr        st_mouse_on
form_alert1:
		bsr        checkmouse
		tst.w      d2
		beq.s      form_alert1
		bsr.s      x139e0
		tst.l      d1
		beq.s      form_alert1
		bsr        st_mouse_off
		bsr        restore_screen
		bsr        st_mouse_on
		bra.s      form_alert3
form_alert2:
		moveq.l    #-1,d0
form_alert3:
		rts

x139e0:
		movem.l    d2-d7/a0-a6,-(a7)
		move.w     d0,d2
		move.w     d1,d3
		lea.l      alert_buttons(pc),a1
		move.w     num_alert_buttons(pc),d1
		subq.w     #1,d1
x139e0_1:
		tst.w      (a1)
		bne.s      x139e0_3
x139e0_2:
		lea.l      46(a1),a1
		dbf        d1,x139e0_1
		clr.l      d0
		clr.l      d1
		movem.l    (a7)+,d2-d7/a0-a6
		rts
x139e0_3:
		cmp.w      (a1),d2
		bcs.s      x139e0_2
		cmp.w      4(a1),d2
		beq.s      x139e0_4
		bcc.s      x139e0_2
x139e0_4:
		cmp.w      2(a1),d3
		bcs.s      x139e0_2
		cmp.w      6(a1),d3
		beq.s      x139e0_5
		bcc.s      x139e0_2
x139e0_5:
		neg.w      d1
		move.w     num_alert_buttons(pc),d6
		add.w      d6,d1
		moveq.l    #-1,d0
		exg        d1,d0
		movem.l    (a7)+,d2-d7/a0-a6
		rts



init_alert_params:
		lea.l      alert_colors(pc),a1
		cmpi.w     #16,nbplan
		beq.s      init_alert_params1
		move.w     d1,(a1)+
		move.w     d2,(a1)+
		move.w     d3,(a1)+
		move.w     d4,(a1)+
		bra.s      init_alert_params2
init_alert_params1:
		move.w     d4,textfg_color
		move.w     d1,textbg_color
		move.w     d1,(a1)+
		move.w     d2,(a1)+
		move.w     d3,(a1)+
		move.w     d4,(a1)+
init_alert_params2:
		move.l     a0,alert_str
		movea.l    lineavars(pc),a0
		move.w     DEV_TAB(a0),d0
		/* addq.w     #1,d0 */
		dc.w 0x0640,1 /* XXX */
		andi.l     #0x0000FFFF,d0
		move.w     DEV_TAB+2(a0),d1
		/* addq.w     #1,d1 */
		dc.w 0x0641,1 /* XXX */
		andi.l     #0x0000FFFF,d1
		subi.w     #312,d0
		asr.w      #1,d0
		lea.l      alert_pos(pc),a1
		/* move.w     d0,0(a1) */
		dc.w 0x3340,0 /* XXX */
		addi.w     #312,d0
		move.w     d0,4(a1)
		move.w     fontheight(pc),d5
		mulu.w     #12,d5
		sub.w      d5,d1
		asr.w      #1,d1
		lea.l      alert_pos+2(pc),a1
		/* move.w     d1,0(a1) */
		dc.w 0x3341,0 /* XXX */
		add.w      d5,d1
		move.w     d1,4(a1)
		rts


init_alert_str:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      alert_strings(pc),a1
		move.w     #(MAX_ALERT_STR*ALERT_STR_SIZE)/4-4,d7 /* BUG? does not clear everything */
init_alert_str_1:
		move.l     #0,(a1)+
		dbf        d7,init_alert_str_1
		lea.l      alert_strings(pc),a1
		move.w     alert_pos(pc),d1
		move.w     alert_pos+2(pc),d2
		addi.w     #48,d1
		move.w     fontheight(pc),d5
		addq.w     #1,d5
		moveq.l    #MAX_ALERT_STR-1,d7
init_alert_str_2:
		add.w      d5,d2
		/* move.w     d1,0(a1) */
		dc.w 0x3341,0 /* XXX */
		move.w     d2,2(a1)
		lea.l      ALERT_STR_SIZE(a1),a1
		dbf        d7,init_alert_str_2
		movem.l    (a7)+,d0-d7/a0-a6
		rts


init_alert_icon:
		movem.l    d0-d6/a0-a6,-(a7)
		moveq.l    #-1,d7
		lea.l      alert_icon(pc),a1
		clr.w      (a1)
		movea.l    alert_str(pc),a0
		move.l     2(a0),d0 /* skip string length */
		andi.l     #0xFF00FFFF,d0
		ori.l      #0x00200000,d0
		cmpi.l     #0x5B205D5B,d0 /* '[ ][' */
		bne.s      init_alert_icon2
		moveq.l    #0,d0
		move.b     3(a0),d0
		subi.b     #'0',d0
		cmpi.w     #MAX_ALERT_ICON,d0
		bgt.s      init_alert_icon1
		move.w     d0,(a1)
init_alert_icon1:
		moveq.l    #0,d7
init_alert_icon2:
		movem.l    (a7)+,d0-d6/a0-a6
		rts


parse_alert_strings:
		movem.l    d0-d6/a0-a6,-(a7)
		moveq.l    #-1,d7
		movea.l    alert_str(pc),a0
		move.w     (a0)+,d6
		move.l     (a0)+,d0
		andi.l     #0xFF00FFFF,d0
		ori.l      #0x00200000,d0
		cmpi.l     #0x5B205D5B,d0
		bne.s      parse_alert_strings4
		subq.w     #1,d6
		lea.l      alert_strings+4(pc),a1
		moveq.l    #0,d1
		moveq.l    #0,d2
		movea.l    a1,a2
parse_alert_strings1:
		subq.w     #1,d6
		bmi.s      parse_alert_strings3
		cmpi.w     #ALERT_STR_SIZE-6,d2
		beq.s      parse_alert_strings2
		move.b     (a0)+,d0
		cmpi.b     #']',d0
		beq.s      parse_alert_strings3
		cmpi.b     #'|',d0
		beq.s      parse_alert_strings2
		move.b     d0,(a2)+
		addq.w     #1,d2
		bra.s      parse_alert_strings1
parse_alert_strings2:
		move.b     #0,(a2)+
		lea.l      ALERT_STR_SIZE(a1),a1
		movea.l    a1,a2
		moveq.l    #0,d2
		addq.w     #1,d1
		cmpi.w     #MAX_ALERT_STR+1,d1
		bne.s      parse_alert_strings1
parse_alert_strings3:
		moveq.l    #0,d7
parse_alert_strings4:
		movem.l    (a7)+,d0-d6/a0-a6
		rts


parse_alert_buttons:
		movem.l    d0-d6/a0-a6,-(a7)
		lea.l      num_alert_buttons(pc),a2
		clr.w      (a2)
		moveq.l    #-1,d7
		movea.l    alert_str(pc),a0
		move.w     (a0)+,d6
		lea.l      num_alert_buttons(pc),a2
		clr.w      (a2)
		lea.l      4(a0),a1
		moveq.l    #4,d5
parse_alert_buttons1:
		move.b     (a1)+,d1
		rol.w      #8,d1
		move.b     (a1),d1
		cmpi.w     #0x5D5B,d1 /* '][' */
		beq.s      parse_alert_buttons2
		addq.w     #1,d5
		cmp.w      d5,d6
		bne.s      parse_alert_buttons1
		bra.s      parse_alert_buttons5
parse_alert_buttons2:
		addq.l     #1,a1
		movea.l    a1,a0
		addq.w     #1,(a2)
parse_alert_buttons3:
		addq.w     #1,d5
		cmp.w      d5,d6
		blt.s      parse_alert_buttons4
		move.b     (a1)+,d1
		cmpi.b     #']',d1
		beq.s      parse_alert_buttons4
		cmpi.b     #'|',d1
		bne.s      parse_alert_buttons3
		addq.w     #1,(a2)
		bra.s      parse_alert_buttons3
parse_alert_buttons4:
		move.w     (a2),d5
		andi.l     #3,d5
		subq.w     #1,d5
		asl.w      #2,d5
		lea.l      parse_alert_but_jmps(pc),a6
		movea.l    0(a6,d5.l),a6
		jsr        (a6)
		moveq.l    #0,d7
parse_alert_buttons5:
		movem.l    (a7)+,d0-d6/a0-a6
		rts

parse_alert_but_jmps:
		dc.l parse_1button
		dc.l parse_2button
		dc.l parse_3button

parse_1button:
		movea.l    a0,a1
		lea.l      alert_buttons(pc),a3
		movea.l    a3,a4
		moveq.l    #0,d6
parse_1button1:
		move.b     (a1)+,d1
		cmpi.b     #']',d1
		beq.s      parse_1button2
		addq.w     #1,d6
		bra.s      parse_1button1
parse_1button2:
		move.w     d6,d7
		mulu.w     #8,d6
		addi.w     #16,d6
		cmpi.w     #208,d6
		ble.s      parse_1button3
		move.w     #208,d6
parse_1button3:
		/* move.l     #0,0(a3) */
		dc.w 0x277c,0,0,0 /* XXX */
		move.w     d6,4(a3)
		asr.w      #1,d6
		move.w     alert_pos(pc),d1
		move.w     alert_pos+4(pc),d2
		sub.w      d1,d2
		asr.w      #1,d2
		add.w      d2,d1
		sub.w      d6,d1
		/* move.w     d1,0(a3) */
		dc.w 0x3741,0 /* XXX */
		add.w      d1,4(a3)
		/* addq.w     #8,d1 */
		dc.w 0x0641,8 /* XXX */
		move.w     d1,8(a3)
		move.w     alert_pos+6(pc),d1
		move.w     fontheight(pc),d5
		sub.w      d5,d1
		sub.w      d5,d1
		move.w     d1,10(a3)
		move.w     d1,2(a3)
		subq.w     #3,2(a3)
		add.w      d5,d1
		addq.w     #2,d1
		move.w     d1,6(a3)
		lea.l      12(a3),a4
		subq.w     #1,d7
parse_1button4:
		move.b     (a0)+,d1
		cmpi.b     #']',d1
		beq.s      parse_1button5
		move.b     d1,(a4)+
		dbf        d7,parse_1button4
parse_1button5:
		move.b     #0,(a4)+
		lea.l      12(a3),a4
		move.b     #0,24(a4)
		rts


parse_2button:
		lea.l      alert_buttons(pc),a3
		lea.l      46(a3),a4
		/* move.l     #0,0(a3) */
		dc.w 0x277c,0,0,0 /* XXX */
		move.l     #0,4(a3)
		/* move.l     #0,0(a4) */
		dc.w 0x297c,0,0,0 /* XXX */
		move.l     #0,4(a4)
		move.w     alert_pos(pc),d1
		move.w     alert_pos+4(pc),d2
		sub.w      d1,d2
		asr.w      #1,d2
		add.w      d2,d1
		move.w     #112,d6
		/* move.w     d1,0(a3) */
		dc.w 0x3741,0 /* XXX */
		move.w     d1,4(a3)
		/* sub.w      d6,0(a3) */
		dc.w 0x9d6b,0 /* XXX */
		/* subq.w     #8,0(a3) */
		dc.w 0x516b,0 /* XXX */
		subq.w     #8,4(a3)
		/* move.w     d1,0(a4)  */
		dc.w 0x3941,0 /* XXX */
		move.w     d1,4(a4)
		/* addq.w     #8,0(a4) */
		dc.w 0x506c,0 /* XXX */
		addq.w     #8,4(a4)
		add.w      d6,4(a4)
		move.w     alert_pos+6(pc),d1
		move.w     fontheight(pc),d5
		sub.w      d5,d1
		sub.w      d5,d1
		move.w     d1,10(a3)
		move.w     d1,10(a4)
		move.w     d1,2(a3)
		subq.w     #3,2(a3)
		move.w     d1,2(a4)
		subq.w     #3,2(a4)
		add.w      d5,d1
		addq.w     #2,d1
		move.w     d1,6(a3)
		move.w     d1,6(a4)
		movea.l    a0,a1
		moveq.l    #0,d6
parse_2button2:
		move.b     (a1)+,d1
		cmpi.b     #'|',d1
		beq.s      parse_2button3
		addq.w     #1,d6
		bra.s      parse_2button2
parse_2button3:
		movea.l    a1,a2
		cmpi.w     #12,d6
		ble.s      parse_2button4
		move.w     #12,d6
parse_2button4:
		moveq.l    #0,d7
parse_2button5:
		move.b     (a1)+,d1
		cmpi.b     #']',d1
		beq.s      parse_2button6
		addq.w     #1,d7
		bra.s      parse_2button5
parse_2button6:
		cmpi.w     #12,d7
		ble.s      parse_2button7
		move.w     #12,d7
parse_2button7:
		move.w     d6,d4
		move.w     d7,d5
		subq.w     #1,d6
		subq.w     #1,d7
		movea.l    a0,a1
		lea.l      alert_buttons+12(pc),a3
		movea.l    a3,a4
parse_2button8:
		move.b     (a1)+,d1
		cmpi.b     #'|',d1
		beq.s      parse_2button9
		move.b     d1,(a4)+
		dbf        d6,parse_2button8
parse_2button9:
		move.b     #0,(a4)+
		move.b     #0,12(a3)
		lea.l      46(a3),a3
		movea.l    a3,a4
parse_2button10:
		move.b     (a2)+,d1
		cmpi.b     #']',d1
		beq.s      parse_2button11
		move.b     d1,(a4)+
		dbf        d7,parse_2button10
parse_2button11:
		move.b     #0,(a4)+
		move.b     #0,12(a3)
		lea.l      alert_buttons(pc),a3
		lea.l      46(a3),a4
		move.w     alert_pos+6(pc),d1
		move.w     fontheight(pc),d2
		sub.w      d2,d1
		sub.w      d2,d1
		move.w     d1,10(a3)
		move.w     d1,10(a4)
		move.w     #112,d3
		asl.w      #3,d4
		sub.w      d4,d3
		asr.w      #1,d3
		/* move.w     0(a3),8(a3) */
		dc.w 0x376b,0,8 /* XXX */
		add.w      d3,8(a3)
		move.w     #112,d3
		asl.w      #3,d5
		sub.w      d5,d3
		asr.w      #1,d3
		/* move.w     0(a4),8(a4) */
		dc.w 0x396c,0,8 /* XXX */
		add.w      d3,8(a4)
		rts

parse_3button:
		lea.l      alert_buttons(pc),a3
		lea.l      46(a3),a4
		lea.l      46(a4),a5
		/* move.l     #0,0(a3) */
		dc.w 0x277c,0,0,0 /* XXX */
		move.l     #0,4(a3)
		/* move.l     #0,0(a4) */
		dc.w 0x297c,0,0,0 /* XXX */
		move.l     #0,4(a4)
		/* move.l     #0,0(a5) */
		dc.w 0x2b7c,0,0,0 /* XXX */
		move.l     #0,4(a5)
		move.w     alert_pos(pc),d1
		move.w     alert_pos+4(pc),d2
		sub.w      d1,d2
		asr.w      #1,d2
		add.w      d2,d1
		move.w     #80,d6
		move.w     d6,d5
		asr.w      #1,d5
		/* move.w     d1,0(a3) */
		dc.w 0x3741,0 /* XXX */
		move.w     d1,4(a3)
		/* sub.w      d5,0(a3) */
		dc.w 0x9b6b,0 /* XXX */
		/* sub.w      d6,0(a3) */
		dc.w 0x9d6b,0 /* XXX */
		/* subq.w     #8,0(a3) */
		dc.w 0x516b,0 /* XXX */
		/* move.w     0(a3),4(a3) */
		dc.w 0x376b,0,4 /* XXX */
		add.w      d6,4(a3)
		/* move.w     0(a3),0(a4) */
		dc.w 0x396b,0,0 /* XXX */
		move.w     4(a3),4(a4)
		/* add.w      d6,0(a4) */
		dc.w 0xdd6c,0 /* XXX */
		add.w      d6,4(a4)
		/* addq.w     #8,0(a4) */
		dc.w 0x506c,0 /* XXX */
		addq.w     #8,4(a4)
		/* move.w     0(a4),0(a5) */
		dc.w 0x3b6c,0,0 /* XXX */
		move.w     4(a4),4(a5)
		/* add.w      d6,0(a5) */
		dc.w 0xdd6d,0 /* XXX */
		add.w      d6,4(a5)
		/* addq.w     #8,0(a5) */
		dc.w 0x506d,0 /* XXX */
		addq.w     #8,4(a5)
		move.w     alert_pos+6(pc),d1
		move.w     fontheight(pc),d5
		sub.w      d5,d1
		sub.w      d5,d1
		move.w     d1,10(a3)
		move.w     d1,10(a4)
		move.w     d1,10(a5)
		move.w     d1,2(a3)
		subq.w     #3,2(a3)
		move.w     d1,2(a4)
		subq.w     #3,2(a4)
		move.w     d1,2(a5)
		subq.w     #3,2(a5)
		add.w      d5,d1
		addq.w     #2,d1
		move.w     d1,6(a3)
		move.w     d1,6(a4)
		move.w     d1,6(a5)
		movea.l    a0,a1
		moveq.l    #0,d5
parse_3button1:
		move.b     (a1)+,d0
		cmpi.b     #'|',d0
		beq.s      parse_3button2
		addq.w     #1,d5
		bra.s      parse_3button1
parse_3button2:
		movea.l    a1,a2
		cmpi.w     #8,d5
		ble.s      parse_3button3
		move.w     #8,d5
parse_3button3:
		moveq.l    #0,d6
parse_3button4:
		move.b     (a1)+,d0
		cmpi.b     #'|',d0
		beq.s      parse_3button5
		addq.w     #1,d6
		bra.s      parse_3button4
parse_3button5:
		movea.l    a1,a3
		cmpi.w     #8,d6
		ble.s      parse_3button6
		move.w     #8,d6
parse_3button6:
		moveq.l    #0,d7
parse_3button7:
		move.b     (a1)+,d0
		cmpi.b     #']',d0
		beq.s      parse_3button8
		addq.w     #1,d7
		bra.s      parse_3button7
parse_3button8:
		cmpi.w     #8,d7
		ble.s      parse_3button9
		move.w     #8,d7
parse_3button9:
		move.w     d5,d2
		move.w     d6,d3
		move.w     d7,d4
		subq.w     #1,d5
		subq.w     #1,d6
		subq.w     #1,d7
		movea.l    a0,a1
		lea.l      alert_buttons+12(pc),a4
		movea.l    a4,a5
parse_3button10:
		move.b     (a1)+,d0
		cmpi.b     #'|',d0
		beq.s      parse_3button11
		move.b     d0,(a5)+
		dbf        d5,parse_3button10
parse_3button11:
		move.b     #0,(a5)+
		move.b     #0,8(a4)
		lea.l      46(a4),a4
		movea.l    a4,a5
parse_3button12:
		move.b     (a2)+,d0
		cmpi.b     #'|',d0
		beq.s      parse_3button13
		move.b     d0,(a5)+
		dbf        d6,parse_3button12
parse_3button13:
		move.b     #0,(a5)+
		move.b     #0,8(a4)
		lea.l      46(a4),a4
		movea.l    a4,a5
parse_3button14:
		move.b     (a3)+,d0
		cmpi.b     #']',d0
		beq.s      parse_3button15
		move.b     d0,(a5)+
		dbf        d7,parse_3button14
parse_3button15:
		move.b     #0,(a5)+
		move.b     #0,8(a4)
		lea.l      alert_buttons(pc),a3
		lea.l      46(a3),a4
		lea.l      46(a4),a5
		move.w     alert_pos+6(pc),d0
		move.w     fontheight(pc),d1
		sub.w      d1,d0
		sub.w      d1,d0
		move.w     d0,10(a3)
		move.w     d0,10(a4)
		move.w     d0,10(a5)
		move.w     #80,d0
		asl.w      #3,d2
		sub.w      d2,d0
		asr.w      #1,d0
		/* move.w     0(a3),8(a3) */
		dc.w 0x376b,0,8 /* XXX */
		add.w      d0,8(a3)
		move.w     #80,d0
		asl.w      #3,d3
		sub.w      d3,d0
		asr.w      #1,d0
		/* move.w     0(a4),8(a4) */
		dc.w 0x396c,0,8 /* XXX */
		add.w      d0,8(a4)
		move.w     #80,d0
		asl.w      #3,d4
		sub.w      d4,d0
		asr.w      #1,d0
		/* move.w     0(a5),8(a5) */
		dc.w 0x3b6d,0,8 /* XXX */
		add.w      d0,8(a5)
		rts


draw_alert_box:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
		move.w     alert_colors(pc),d0 /* fillcolor */
		bsr        linea_setcolor
		lea.l      alert_pos(pc),a4
		bsr        fillrect
		move.w     alert_colors+2(pc),d0 /* left color */
		lea.l      alert_pos(pc),a4
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     6(a4),d2
		/* move.w     0(a4),d3 */
		dc.w 0x362c,0 /* XXX */
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     alert_colors+2(pc),d0 /* left color */
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     2(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     alert_colors+4(pc),d0 /* right color */
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     6(a4),d4
		bsr        linea_drawline
		move.w     alert_colors+4(pc),d0 /* right color */
		move.w     4(a4),d1
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		bsr.s      draw_alert_strings
		bsr        draw_alert_icon
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_alert_strings:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #MD_TRANS,wrt_mode
		move.w     #0,text_style
		lea.l      textblit_str(pc),a2
		lea.l      textblit_coords(pc),a3
		lea.l      alert_strings(pc),a5
		moveq.l    #MAX_ALERT_STR-1,d7
draw_alert_strings1:
		move.w     alert_colors(pc),textbg_color /* fillcolor */
		move.w     alert_colors+2(pc),textfg_color /* left color */
		movea.l    a5,a4
		move.l     (a4)+,(a3)
		addq.w     #1,(a3)
		move.l     a4,(a2)
draw_alert_strings2:
		movea.l    (a2),a0
		tst.b      (a0)
		beq.s      draw_alert_strings3
		bsr        linea_textblit
		bra.s      draw_alert_strings2
draw_alert_strings3:
		move.w     alert_colors(pc),textbg_color /* fillcolor */
		move.w     alert_colors+6(pc),textfg_color /* text color */
		movea.l    a5,a4
		move.l     (a4)+,(a3)
		move.l     a4,(a2)
draw_alert_strings4:
		movea.l    (a2),a0
		tst.b      (a0)
		beq.s      draw_alert_strings5
		bsr        linea_textblit
		bra.s      draw_alert_strings4
draw_alert_strings5:
		lea.l      ALERT_STR_SIZE(a5),a5
		dbf        d7,draw_alert_strings1
		move.w     #0,text_style
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_alert_icon:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     alert_icon(pc),d0
		tst.w      d0
		beq        draw_alert_icon1
		lea.l      alert_icon_fontsave(pc),a5
		move.w     sysfont(pc),d0
		move.l     fonthdr(pc),d1
		movem.l    d0-d1,(a5)
		move.w     #2,sysfont
		lea.l      alert_icon_font(pc),a0
		move.l     a0,fonthdr
		move.w     alert_colors(pc),textbg_color /* fillcolor */
		move.w     alert_colors+2(pc),textfg_color /* left color */
		move.w     #MD_TRANS,wrt_mode
		move.w     #0,text_style
		lea.l      alert_icon+1(pc),a0
		lea.l      textblit_str(pc),a2
		lea.l      textblit_coords(pc),a3
		move.l     a0,(a2)
		move.w     fontheight(pc),d5
		move.l     alert_pos(pc),d0
		add.w      d5,d0
		move.l     d0,(a3)
		addi.w     #9,(a3)
		addq.w     #1,2(a3)
		bsr        linea_textblit
		move.w     alert_colors+6(pc),textfg_color /* text color */
		move.l     a0,(a2)
		move.l     d0,(a3)
		/* addq.w     #8,(a3) */
		dc.w 0x0653,8 /* XXX */
		bsr        linea_textblit
		lea.l      alert_icon_fontsave(pc),a5
		movem.l    (a5)+,d0-d1
		move.w     d0,sysfont
		move.l     d1,fonthdr
draw_alert_icon1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

alert_icon_fontsave: ds.l 2

draw_alert_button_frames:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     num_alert_buttons(pc),d5
		tst.w      d5
		beq        draw_alert_button_frames2
		cmpi.w     #MAX_ALERT_BUT,d5
		bgt        draw_alert_button_frames2
		subq.w     #1,d5
		lea.l      alert_buttons(pc),a3
draw_alert_button_frames1:
		movea.l    a3,a4
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     6(a4),d2
		/* move.w     0(a4),d3 */
		dc.w 0x362c,0 /* XXX */
		move.w     2(a4),d4
		move.w     alert_colors+2(pc),d0 /* left color */
		bsr        linea_drawline
		subq.w     #2,d1
		addq.w     #2,d2
		subq.w     #2,d3
		subq.w     #2,d4
		move.w     alert_colors+4(pc),d0 /* right color */
		bsr        linea_drawline
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     2(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		move.w     alert_colors+2(pc),d0 /* left color */
		bsr        linea_drawline
		subq.w     #2,d1
		subq.w     #2,d2
		addq.w     #2,d3
		subq.w     #2,d4
		move.w     alert_colors+4(pc),d0 /* right color */
		bsr        linea_drawline
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     6(a4),d4
		move.w     alert_colors+4(pc),d0 /* right color */
		bsr        linea_drawline
		subq.w     #2,d1
		addq.w     #2,d2
		addq.w     #2,d3
		addq.w     #2,d4
		move.w     alert_colors+2(pc),d0 /* left color */
		bsr        linea_drawline
		move.w     4(a4),d1
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		move.w     alert_colors+4(pc),d0 /* right color */
		bsr        linea_drawline
		addq.w     #2,d1
		addq.w     #2,d2
		addq.w     #2,d3
		subq.w     #2,d4
		move.w     alert_colors+2(pc),d0 /* left color */
		bsr        linea_drawline
		lea.l      46(a3),a3
		dbf        d5,draw_alert_button_frames1
draw_alert_button_frames2:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_alert_button_texts:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     num_alert_buttons(pc),d7
		tst.w      d7
		beq.s      draw_alert_button_texts6
		cmpi.w     #MAX_ALERT_BUT,d7
		bgt.s      draw_alert_button_texts6
		subq.w     #1,d7
		move.w     #MD_TRANS,wrt_mode
		move.w     #0,text_style
		lea.l      textblit_str(pc),a2
		lea.l      textblit_coords(pc),a3
		lea.l      alert_buttons+8(pc),a5
draw_alert_button_texts1:
		move.w     alert_colors(pc),textbg_color /* fillcolor */
		move.w     alert_colors+2(pc),textfg_color /* left color */
		movea.l    a5,a4
		move.l     (a4)+,(a3)
		addq.w     #1,(a3)
		move.l     a4,(a2)
draw_alert_button_texts2:
		movea.l    (a2),a0
		tst.b      (a0)
		beq.s      draw_alert_button_texts3
		bsr        linea_textblit
		bra.s      draw_alert_button_texts2
draw_alert_button_texts3:
		move.w     alert_colors(pc),textbg_color /* fillcolor */
		move.w     alert_colors+6(pc),textfg_color /* text color */
		movea.l    a5,a4
		move.l     (a4)+,(a3)
		move.l     a4,(a2)
draw_alert_button_texts4:
		movea.l    (a2),a0
		tst.b      (a0)
		beq.s      draw_alert_button_texts5
		bsr        linea_textblit
		bra.s      draw_alert_button_texts4
draw_alert_button_texts5:
		lea.l      46(a5),a5
		dbf        d7,draw_alert_button_texts1
		move.w     #0,text_style
draw_alert_button_texts6:
		movem.l    (a7)+,d0-d7/a0-a6
		rts


save_screen:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      alert_pos(pc),a0
		movea.l    lineavars(pc),a2
		movea.l    physic(pc),a3
		lea.l      screenbuf,a4
		cmpi.l     #32000,falcon_screensize
		beq.s      save_screen_fast
		cmpi.w     #16,LA_PLANES(a2)
		beq.s      save_screen_hi
		/* move.w     0(a0),d0 */
		dc.w 0x3028,0 /* XXX */
		move.w     2(a0),d1
		bsr        calc_screenaddr
		movea.l    a5,a6
		move.w     4(a0),d0
		move.w     2(a0),d1
		bsr        calc_screenaddr
		exg        a6,a5
		moveq.l    #0,d6
		move.w     LA_PLANES(a2),d6
		asl.w      #1,d6
		adda.l     d6,a6 /* round end address up */
		move.w     2(a0),d6
		move.w     6(a0),d7
		sub.w      d6,d7
save_screen1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
save_screen2:
		move.w     (a5)+,(a4)+
		cmpa.l     a5,a6
		bcc.s      save_screen2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,save_screen1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
save_screen_fast:
		move.w     #1000-1,d7
save_screen_fast1:
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		dbf        d7,save_screen_fast1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
save_screen_hi:
		movea.l    a3,a5
		movea.l    a3,a6
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		moveq.l    #0,d6
		move.w     (a2),d6
		move.w     V_BYTES_LIN(a2),d5
		/* move.w     0(a0),d0 */
		dc.w 0x3028,0 /* XXX */
		asl.w      #1,d0
		move.w     2(a0),d1
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a5
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		move.w     V_BYTES_LIN(a2),d5
		move.w     4(a0),d0
		move.w     2(a0),d1
		asl.w      #1,d0
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a6
		move.w     2(a0),d6
		move.w     6(a0),d7
		sub.w      d6,d7
save_screen_hi1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
save_screen_hi2:
		move.w     (a5)+,(a4)+
		cmpa.l     a5,a6
		bcc.s      save_screen_hi2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,save_screen_hi1
		movem.l    (a7)+,d0-d7/a0-a6
		rts


restore_screen:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      alert_pos(pc),a0
		movea.l    lineavars(pc),a2
		movea.l    physic(pc),a3
		lea.l      screenbuf,a4
		cmpi.l     #32000,falcon_screensize
		beq.s      restore_screen_fast
		cmpi.w     #16,LA_PLANES(a2)
		beq.s      restore_screen_hi
		/* move.w     0(a0),d0 */
		dc.w 0x3028,0 /* XXX */
		move.w     2(a0),d1
		bsr        calc_screenaddr
		movea.l    a5,a6
		move.w     4(a0),d0
		move.w     2(a0),d1
		bsr        calc_screenaddr
		exg        a6,a5
		moveq.l    #0,d6
		move.w     LA_PLANES(a2),d6
		asl.w      #1,d6
		adda.l     d6,a6 /* round end address up */
		move.w     2(a0),d6
		move.w     6(a0),d7
		sub.w      d6,d7
restore_screen1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
restore_screen2:
		move.w     (a4)+,(a5)+
		cmpa.l     a5,a6
		bcc.s      restore_screen2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,restore_screen1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
restore_screen_fast:
		move.w     #1000-1,d7
restore_screen_fast1:
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		dbf        d7,restore_screen_fast1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
restore_screen_hi:
		movea.l    a3,a5
		movea.l    a3,a6
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		moveq.l    #0,d6
		move.w     (a2),d6
		move.w     -2(a2),d5
		/* move.w     0(a0),d0 */
		dc.w 0x3028,0 /* XXX */
		asl.w      #1,d0
		move.w     2(a0),d1
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a5
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		move.w     -2(a2),d5
		move.w     4(a0),d0
		move.w     2(a0),d1
		asl.w      #1,d0
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a6
		move.w     2(a0),d6
		move.w     6(a0),d7
		sub.w      d6,d7
restore_screen_hi1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
restore_screen_hi2:
		move.w     (a4)+,(a5)+
		cmpa.l     a5,a6
		bcc.s      restore_screen_hi2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     -2(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,restore_screen_hi1
		movem.l    (a7)+,d0-d7/a0-a6
		rts


redraw_titles:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menuparams(pc),a1
		cmpi.w     #0x8003,(a1)
		beq.s      redraw_titles1
		cmpi.w     #3,mn_state(a1)
		beq.s      redraw_titles1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
redraw_titles1:
		tst.w      in_menu_check
		bne.s      redraw_titles1
		bsr        set_titles_off
		bsr        save_linea_clip
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
		movea.l    lineavars(pc),a0
		movea.l    a1,a4
		addq.l     #mn_x1,a4
		move.w     mn_fillcolor(a1),d0
		bsr        linea_setcolor
		bsr        fillrect
		lea.l      menuparams(pc),a1
		move.w     mn_leftcolor(a1),d0
		movea.l    a1,a4
		addq.l     #mn_x1,a4
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     6(a4),d2
		/* move.w     0(a4),d3 */
		dc.w 0x362c,0 /* XXX */
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     mn_leftcolor(a1),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0 /* XXX */
		move.w     2(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     mn_rightcolor(a1),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     6(a4),d4
		bsr        linea_drawline
		move.w     mn_rightcolor(a1),d0
		move.w     4(a4),d1
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		bsr        draw_title_strings
		bsr        restore_linea_clip
		bsr        set_titles_on
		movem.l    (a7)+,d0-d7/a0-a6
		rts


draw_title_line:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menuparams(pc),a1
		tst.w      (a1)
		bne.s      draw_title_line1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
draw_title_line1:
		bsr        save_linea_clip
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
		movea.l    lineavars(pc),a0
		movea.l    a1,a4
		addq.l     #2,a4
		move.w     mn_fillcolor(a1),d0
		bsr        linea_setcolor
		bsr        fillrect
		lea.l      menuparams(pc),a1
		move.w     mn_leftcolor(a1),d0
		movea.l    a1,a4
		addq.l     #2,a4
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     6(a4),d2
		/* move.w     0(a4),d3 */
		dc.w 0x362c,0
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     mn_leftcolor(a1),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     2(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     mn_rightcolor(a1),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     6(a4),d4
		bsr        linea_drawline
		move.w     mn_rightcolor(a1),d0
		move.w     4(a4),d1
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		bsr.s      draw_title_strings
		bsr        restore_linea_clip
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_title_strings:
		lea.l      menuparams(pc),a0
		lea.l      menuinfo+tit_sizeof(pc),a1
		lea.l      textblit_str(pc),a2
		lea.l      textblit_coords,a3
		moveq.l    #0,d5
draw_title_strings1:
		movem.l    d5/a0-a3,-(a7)
		move.w     mn_fillcolor(a0),textbg_color
		move.w     mn_leftcolor(a0),textfg_color
		move.w     #MD_TRANS,wrt_mode
		move.w     #0,text_style
		/* move.l     0(a1),0(a3) */
		dc.w 0x2769,0,0
		move.w     ent_namelen(a1),d7
		subq.w     #1,d7
		lea.l      ent_name(a1),a4
		move.l     a4,(a2)
draw_title_strings2:
		bsr        linea_textblit
		dbf        d7,draw_title_strings2
		move.w     mn_textcolor(a0),textfg_color
		tst.w      ent_state(a1)
		bne.s      draw_title_strings3
		move.w     mn_rightcolor(a0),textfg_color
		bsr.s      set_title_style
draw_title_strings3:
		move.w     #MD_TRANS,wrt_mode
		/* move.l     0(a1),0(a3) */
		dc.w 0x2769,0,0
		/* subq.w     #1,0(a3) */
		dc.w 0x536b,0
		move.w     ent_namelen(a1),d7
		subq.w     #1,d7
		lea.l      ent_name(a1),a4
		move.l     a4,(a2)
draw_title_strings4:
		bsr        linea_textblit
		dbf        d7,draw_title_strings4
		movem.l    (a7)+,d5/a0-a3
		lea.l      MENU_SIZE(a1),a1
		addq.w     #1,d5
		cmp.w      num_titles,d5
		bne        draw_title_strings1
		move.w     #0,text_style
		rts

set_title_style:
		movem.l    d0-d7/a0-a6,-(a7)
		tst.b      ent_state(a1)
		bne.s      set_title_style1
		movea.l    lineavars(pc),a0
		cmpi.w     #2,LA_PLANES(a0)
		bgt.s      set_title_style1
		move.w     #TXT_LIGHT,text_style
set_title_style1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts


draw_dropdown:
		movem.l    d0-d7/a0-a6,-(a7)
		subq.w     #1,d0
		bmi        draw_dropdown1
		andi.l     #255,d0
		lea.l      menuinfo(pc),a1
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a2
		lea.l      menuparams(pc),a3
		mulu.w     #MENU_SIZE,d0
		adda.l     d0,a1
		adda.l     d0,a2
		tst.w      (a1)
		bmi        draw_dropdown1
		move.w     #-1,(a1)
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
		movea.l    lineavars(pc),a0
		lea.l      tit_x1(a1),a4
		move.w     mn_fillcolor(a3),d0
		bsr        linea_setcolor
		bsr        fillrect
		move.w     mn_leftcolor(a3),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     6(a4),d2
		/* move.w     0(a4),d3 */
		dc.w 0x362c,0
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     mn_leftcolor(a3),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     2(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		move.w     mn_rightcolor(a3),d0
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     6(a4),d4
		bsr        linea_drawline
		move.w     mn_rightcolor(a3),d0
		move.w     4(a4),d1
		move.w     6(a4),d2
		move.w     4(a4),d3
		move.w     2(a4),d4
		bsr        linea_drawline
		movem.l    (a7)+,d0-d7/a0-a6
		bsr.s      draw_dropdown_strings
		rts
draw_dropdown1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_dropdown_strings:
		movem.l    d0-d7/a0-a6,-(a7)
		subq.w     #1,d0
		bmi        draw_dropdown_strings8
		andi.l     #255,d0
		lea.l      menuparams(pc),a0
		lea.l      menuinfo+tit_sizeof+ENT_SIZE(pc),a1
		mulu.w     #MENU_SIZE,d0
		adda.l     d0,a1
		lea.l      textblit_str(pc),a2
		lea.l      textblit_coords,a3
		lea.l      menuinfo(pc),a4
		adda.l     d0,a4
		moveq.l    #0,d5
draw_dropdown_strings1:
		movem.l    d5/a0-a4,-(a7)
		move.w     mn_fillcolor(a0),textbg_color
		move.w     mn_leftcolor(a0),textfg_color
		move.w     #MD_TRANS,wrt_mode
		move.w     #0,text_style
		tst.b      ent_state(a1)
		beq.s      draw_dropdown_strings3
		tst.b      ent_state+1(a1)
		beq.s      draw_dropdown_strings3
		movem.l    a0-a4,-(a7)
		/* move.l     0(a1),0(a3) */
		dc.w 0x2769,0,0
		/* subq.w     #5,(a3) */
		dc.w 0x0453,5 /* XXX */
		lea.l      checkmark(pc),a4
		move.l     a4,(a2)
		bsr        linea_textblit
		move.w     mn_textcolor(a0),textfg_color
		tst.b      ent_state+1(a1)
		bne.s      draw_dropdown_strings2
		move.w     mn_rightcolor(a0),textfg_color
draw_dropdown_strings2:
		/* move.l     0(a1),0(a3) */
		dc.w 0x2769,0,0
		/* subq.w     #6,(a3) */
		dc.w 0x453,6 /* XXX */
		lea.l      checkmark(pc),a4
		move.l     a4,(a2)
		bsr        linea_textblit
		movem.l    (a7)+,a0-a4
		move.w     mn_fillcolor(a0),textbg_color
		move.w     mn_leftcolor(a0),textfg_color
		move.w     #MD_TRANS,wrt_mode
		bra.s      draw_dropdown_strings4
draw_dropdown_strings3:
		bsr        set_entry_style
draw_dropdown_strings4:
		/* move.l     0(a1),0(a3) */
		dc.w 0x2769,0,0
		/* addq.w     #6,(a3) */
		dc.w 0x0653,6 /* XXX */
		move.w     ent_namelen(a1),d7
		subq.w     #1,d7
		lea.l      ent_name(a1),a4
		move.l     a4,(a2)
draw_dropdown_strings5:
		bsr        linea_textblit
		dbf        d7,draw_dropdown_strings5
		move.w     mn_textcolor(a0),textfg_color
		tst.b      ent_state+1(a1)
		bne.s      draw_dropdown_strings6
		move.w     mn_rightcolor(a0),textfg_color
draw_dropdown_strings6:
		move.w     #MD_TRANS,wrt_mode
		/* move.l     0(a1),0(a3) */
		dc.w 0x2769,0,0
		/* addq.w     #5,(a3) */
		dc.w 0x0653,5 /* XXX */
		move.w     ent_namelen(a1),d7
		subq.w     #1,d7
		lea.l      ent_name(a1),a4
		move.l     a4,(a2)
draw_dropdown_strings7:
		bsr        linea_textblit
		dbf        d7,draw_dropdown_strings7
		movem.l    (a7)+,d5/a0-a4
		bsr.s      draw_dropdown_line
		bsr        save_entry_coords
		lea.l      ENT_SIZE(a1),a1
		addq.w     #1,d5
		cmp.w      tit_entcount(a4),d5
		bne        draw_dropdown_strings1
		lea.l      mch_cookie(pc),a0
		/* tst.l     (a0) */
		dc.w 0x0c90,0,0 /* XXX */
		beq.s      draw_dropdown_strings8
		lea.l      $000005AC.l,a0 /* bellhook */ /* XXX */
		movea.l    (a0),a0
		jsr        (a0)
draw_dropdown_strings8:
		move.w     #0,text_style
		movem.l    (a7)+,d0-d7/a0-a6
		rts

checkmark: dc.b 8,0

set_entry_style:
		movem.l    d0-d7/a0-a6,-(a7)
		tst.b      ent_state+1(a1)
		bne.s      set_entry_style1
		movea.l    lineavars(pc),a0
		cmpi.w     #2,LA_PLANES(a0)
		bgt.s      set_entry_style1
		move.w     #TXT_LIGHT,text_style
set_entry_style1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

*
* draw the line between two entries
*
draw_dropdown_line:
		movem.l    d0-d7/a0-a6,-(a7)
		addq.w     #1,d5
		cmp.w      tit_entcount(a4),d5
		beq.s      draw_dropdown_line1
		move.w     fontheight(pc),d5
		asr.w      #1,d5
		lea.l      menuparams(pc),a3
		move.w     mn_rightcolor(a3),d0
		move.w     tit_x1(a4),d1
		addq.w     #1,d1
		move.w     ent_y2(a1),d2
		move.w     tit_x2(a4),d3
		move.w     ent_y2(a1),d4
		sub.w      d5,d2
		sub.w      d5,d4
		subq.w     #1,d2
		subq.w     #1,d4
		bsr        linea_drawline
		move.w     mn_leftcolor(a3),d0
		move.w     tit_x1(a4),d1
		move.w     ent_y2(a1),d2
		move.w     tit_x2(a4),d3
		subq.w     #1,d3
		move.w     ent_y2(a1),d4
		sub.w      d5,d2
		sub.w      d5,d4
		bsr        linea_drawline
draw_dropdown_line1:
		movem.l    (a7)+,d0-d7/a0-a6
		rts


save_linea_clip:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      la_cliprect(pc),a1
		move.w     LA_XMN_CLIP(a0),(a1)+
		move.w     LA_YMN_CLIP(a0),(a1)+
		move.w     LA_XMX_CLIP(a0),(a1)+
		move.w     LA_YMX_CLIP(a0),(a1)+
		move.w     LA_CLIP(a0),(a1)+
		movem.l    (a7)+,d0-d7/a0-a6
		rts

restore_linea_clip:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		lea.l      la_cliprect(pc),a1
		move.w     (a1)+,LA_XMN_CLIP(a0)
		move.w     (a1)+,LA_YMN_CLIP(a0)
		move.w     (a1)+,LA_XMX_CLIP(a0)
		move.w     (a1)+,LA_YMX_CLIP(a0)
		move.w     #0,LA_CLIP(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts
la_cliprect: ds.w 6


restore_dropdown:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      menuinfo(pc),a0
		move.w     num_titles(pc),d7
		subq.w     #1,d7
restore_dropdown1:
		tst.w      tit_state(a0)
		bne.s      restore_dropdown2
		/* adda.w     #MENU_SIZE,a0 */
		dc.w 0xd1fc,0,MENU_SIZE /* XXX */
		dbf        d7,restore_dropdown1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
restore_dropdown2:
		clr.w      tit_state(a0)
		movea.l    lineavars(pc),a2
		movea.l    physic(pc),a3
		lea.l      screenbuf,a4
		cmpi.l     #32000,falcon_screensize
		beq.s      restore_dropdown_fast
		cmpi.w     #16,LA_PLANES(a2)
		beq.s      restore_dropdown_hi
		move.w     tit_x1(a0),d0
		move.w     tit_y1(a0),d1
		bsr        calc_screenaddr
		movea.l    a5,a6
		move.w     tit_x2(a0),d0
		move.w     tit_y1(a0),d1
		bsr        calc_screenaddr
		exg        a6,a5
		moveq.l    #0,d6
		move.w     LA_PLANES(a2),d6
		asl.w      #1,d6
		adda.l     d6,a6
		move.w     tit_y1(a0),d6
		move.w     tit_y2(a0),d7
		sub.w      d6,d7
restore_dropdown3:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
restore_dropdown4:
		move.w     (a4)+,(a5)+
		cmpa.l     a5,a6
		bcc.s      restore_dropdown4
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,restore_dropdown3
		movem.l    (a7)+,d0-d7/a0-a6
		rts
restore_dropdown_fast:
		move.w     #1000-1,d7
restore_dropdown_fast1:
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		move.l     (a4)+,(a3)+
		dbf        d7,restore_dropdown_fast1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
restore_dropdown_hi:
		movea.l    a3,a5
		movea.l    a3,a6
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		moveq.l    #0,d6
		move.w     (a2),d6
		move.w     -2(a2),d5
		move.w     2(a0),d0
		asl.w      #1,d0
		move.w     4(a0),d1
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a5
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		move.w     -2(a2),d5
		move.w     6(a0),d0
		move.w     4(a0),d1
		asl.w      #1,d0
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a6
		move.w     4(a0),d6
		move.w     8(a0),d7
		sub.w      d6,d7
restore_dropdown_hi1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
restore_dropdown_hi2:
		move.w     (a4)+,(a5)+
		cmpa.l     a5,a6
		bcc.s      restore_dropdown_hi2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     -2(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,restore_dropdown_hi1
		movem.l    (a7)+,d0-d7/a0-a6
		rts



save_dropdown:
		movem.l    d0-d7/a0-a6,-(a7)
		subq.w     #1,d0
		bmi.s      save_dropdown3
		andi.l     #255,d0
		lea.l      menuinfo(pc),a0
		mulu.w     #MENU_SIZE,d0
		adda.l     d0,a0
		movea.l    lineavars(pc),a2
		movea.l    physic(pc),a3
		lea.l      screenbuf,a4
		cmpi.l     #32000,falcon_screensize
		beq.s      save_dropdown_fast
		cmpi.w     #16,LA_PLANES(a2)
		beq.s      save_dropdown_hi
		move.w     2(a0),d0
		move.w     4(a0),d1
		bsr        calc_screenaddr
		movea.l    a5,a6
		move.w     6(a0),d0
		move.w     4(a0),d1
		bsr        calc_screenaddr
		exg        a6,a5
		moveq.l    #0,d6
		move.w     LA_PLANES(a2),d6
		asl.w      #1,d6
		adda.l     d6,a6
		move.w     4(a0),d6
		move.w     8(a0),d7
		sub.w      d6,d7
save_dropdown1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
save_dropdown2:
		move.w     (a5)+,(a4)+
		cmpa.l     a5,a6
		bcc.s      save_dropdown2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,save_dropdown1
save_dropdown3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
save_dropdown_fast:
		move.w     #1000-1,d7
save_dropdown_fast1:
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		move.l     (a3)+,(a4)+
		dbf        d7,save_dropdown_fast1
		movem.l    (a7)+,d0-d7/a0-a6
		rts
save_dropdown_hi:
		movea.l    a3,a5
		movea.l    a3,a6
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		moveq.l    #0,d6
		move.w     (a2),d6
		move.w     -2(a2),d5
		move.w     2(a0),d0
		asl.w      #1,d0
		move.w     4(a0),d1
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a5
		moveq.l    #0,d0
		moveq.l    #0,d1
		moveq.l    #0,d5
		move.w     -2(a2),d5
		move.w     6(a0),d0
		move.w     4(a0),d1
		asl.w      #1,d0
		mulu.w     d1,d5
		add.l      d0,d5
		adda.l     d5,a6
		move.w     4(a0),d6
		move.w     8(a0),d7
		sub.w      d6,d7
save_dropdown_hi1:
		movem.l    d0-d7/a0-a3/a5-a6,-(a7)
save_dropdown_hi2:
		move.w     (a5)+,(a4)+
		cmpa.l     a5,a6
		bcc.s      save_dropdown_hi2
		movem.l    (a7)+,d0-d7/a0-a3/a5-a6
		moveq.l    #0,d6
		move.w     -2(a2),d6
		adda.l     d6,a5
		adda.l     d6,a6
		dbf        d7,save_dropdown_hi1
		movem.l    (a7)+,d0-d7/a0-a6
		rts


calc_screenaddr:
		movem.l    d1-d7/a0-a4,-(a7)
		move.w     LA_PLANES(a2),d5
		subq.w     #1,d5
		move.w     V_BYTES_LIN(a2),d6
		moveq.l    #0,d7
		move.w     d0,d7
		asr.l      #4,d7
		cmpi.w     #3,d5
		beq.s      calc_screenaddr1
		cmpi.w     #7,d5
		beq.s      calc_screenaddr2
		moveq.l    #0,d0
		movem.l    (a7)+,d1-d7/a0-a4
		rts
calc_screenaddr1:
		asl.l      #2,d7
		bra.s      calc_screenaddr3
calc_screenaddr2:
		asl.l      #3,d7
calc_screenaddr3:
		mulu.w     d6,d1
		add.l      d7,d1
		add.l      d7,d1
		adda.l     d1,a3
		movea.l    a3,a5
		andi.w     #15,d0
		neg.w      d0
		addi.w     #15,d0
		movem.l    (a7)+,d1-d7/a0-a4
		rts


fillrect:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		/* cmpi.w     #16,LA_PLANES(a0) */
		dc.w 0xc68,16,LA_PLANES /* XXX */
		beq.s      fillrect_hi
		cmpi.w     #1,LA_PLANES(a0)
		beq.s      fillrect3
		cmpi.w     #8,LA_PLANES(a0)
		beq.s      fillrect1
		cmpi.w     #4,LA_PLANES(a0)
		ble.s      fillrect2
		bra.s      fillrect4
fillrect1:
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
		bsr        linea_fillrect
		bsr        fillrect_8planes
		bra.s      fillrect4
fillrect2:
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
		bsr        linea_fillrect
		bra.s      fillrect4
fillrect3:
		lea.l      fillpattern(pc),a5
		move.l     #0xAAAA5555,(a5)
		bsr        linea_fillrect
		lea.l      fillpattern(pc),a5
		move.l     #-1,(a5)
fillrect4:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
fillrect_hi:
		movea.l    physic(pc),a0
		moveq.l    #0,d3
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		/* move.w     0(a4),d3 */
		dc.w 0x362c,0
		move.w     2(a4),d5
		move.w     4(a4),d6
		move.w     6(a4),d7
		bra.s      fillrect_hi2
		cmp.w      d3,d6
		bcc.s      fillrect_hi1
		exg        d3,d6
fillrect_hi1:
		cmp.w      d5,d7
		bcc.s      fillrect_hi2
		exg        d5,d7
fillrect_hi2:
		movea.l    lineavars(pc),a1
		sub.l      d3,d6
		sub.l      d5,d7
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		asl.w      #1,d3
		adda.w     d3,a0
fillrect_hi3:
		movem.l    d3-d7/a0-a6,-(a7)
fillrect_hi4:
		move.w     d0,(a0)+
		dbf        d6,fillrect_hi4
		movem.l    (a7)+,d3-d7/a0-a6
		adda.w     V_BYTES_LIN(a1),a0
		dbf        d7,fillrect_hi3
		movem.l    (a7)+,d0-d7/a0-a6
		rts


linea_drawline:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		cmpi.w     #16,nbplan
		beq.s      drawline_hi
		bsr        linea_setcolor
		move.w     d1,LA_X1(a0)
		move.w     d2,LA_Y1(a0)
		move.w     d3,LA_X2(a0)
		move.w     d4,LA_Y2(a0)
		move.w     d1,LA_XMN_CLIP(a0)
		move.w     d2,LA_YMN_CLIP(a0)
		move.w     d3,LA_XMX_CLIP(a0)
		move.w     d4,LA_YMX_CLIP(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     #-1,LA_LN_MASK(a0)
		move.w     #MD_REPLACE,LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w 0xa003
		movem.l    (a7)+,d0-d7/a0-a6
		cmpi.w     #8,nbplan
		bne.s      linea_drawline1
		bsr        linea_fill8planes
linea_drawline1:
		rts

drawline_hi:
		movea.l    physic(pc),a0
		lea.l      drawline_ccords(pc),a1
		movem.w    d1-d4,(a1)
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.w     drawline_ccords(pc),d4
		move.w     drawline_ccords+2(pc),d5
		move.w     drawline_ccords+4(pc),d6
		move.w     drawline_ccords+6(pc),d7
		cmp.w      d4,d6
		bcc.s      drawline_hi1
		exg        d4,d6
drawline_hi1:
		cmp.w      d5,d7
		bcc.s      drawline_hi2
		exg        d5,d7
drawline_hi2:
		cmp.w      d4,d6
		beq.s      drawline_hi_ver
		cmp.w      d5,d7
		beq.s      drawline_hi_hor
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_hi_ver:
		movea.l    lineavars(pc),a1
		sub.w      d5,d7
		move.w     d5,d2
		moveq.l    #0,d1
		move.w     V_BYTES_LIN(a1),d1
		mulu.w     d1,d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
drawline_hi_ver1:
		move.w     d0,(a0)
		adda.w     d1,a0
		dbf        d7,drawline_hi_ver1
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_hi_hor:
		movea.l    lineavars(pc),a1
		sub.w      d4,d6
		move.w     d5,d2
		mulu.w     V_BYTES_LIN(a1),d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
drawline_hi_hor1:
		move.w     d0,(a0)+
		dbf        d6,drawline_hi_hor1
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_ccords: ds.w 4


linea_fill8planes:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a0
		/* move.w     LA_PLANES(a0),d7 */
		dc.w 0x3e28,0 /* XXX */
		asl.w      #1,d7
		move.w     V_BYTES_LIN(a0),d5
		cmp.w      d1,d3
		bcc.s      linea_fill8planes1
		exg        d1,d3
linea_fill8planes1:
		cmp.w      d2,d4
		bcc.s      linea_fill8planes2
		exg        d2,d4
linea_fill8planes2:
		sub.w      d1,d3
		addq.w     #1,d3
		sub.w      d2,d4
		addq.w     #1,d4
		lea.l      bitblt,a1
		move.w     d3,(a1)+ /* b_wd */
		move.w     d4,(a1)+ /* b_ht */
		move.w     #4,(a1)+ /* plane_cnt */
		move.w     #12,(a1)+ /* fg_col */
		move.w     #10,(a1)+ /* bg_col */
		bsr        calc_optab
		move.l     d0,(a1)+ /* op_tab */
		move.w     d1,(a1)+ /* s_xmin */
		move.w     d2,(a1)+ /* s_ymin */
		move.l     physic(pc),d6
		/* addq.l     #8,d6 */
		dc.w 0x0686,0,8 /* XXX */
		move.l     d6,(a1)+ /* s_form */
		move.w     d7,(a1)+ /* s_nxwd */
		move.w     d5,(a1)+ /* s_nxln */
		move.w     #2,(a1)+ /* s_nxpl */
		move.w     d1,(a1)+ /* d_xmin */
		move.w     d2,(a1)+ /* d_ymin */
		move.l     physic(pc),d6
		/* addq.l     #8,d6 */
		dc.w 0x0686,0,8 /* XXX */
		move.l     d6,(a1)+ /* d_form */
		move.w     d7,(a1)+ /* d_nxwd */
		move.w     d5,(a1)+ /* d_nxln */
		move.w     #2,(a1)+ /* d_nxpl */
		move.l     #0,(a1)+ /* p_addr */
		lea.l      bitblt,a6
		dc.w 0xa007
		movem.l    (a7)+,d0-d7/a0-a6
		rts


*
* draw a single char pointed to by textblit_str
*
linea_textblit:
		movem.l    d0-d7/a0-a6,-(a7)
		dc.w 0xa000
		cmpi.w     #16,nbplan
		beq        linea_textblit_hi
		move.w     sysfont(pc),d0
		asl.w      #2,d0
		movea.l    0(a1,d0.w),a3
		move.l     fonthdr(pc),d1
		tst.l      d1
		beq.s      linea_textblit1
		movea.l    fonthdr(pc),a3
		move.l     a3,d1
linea_textblit1:
		move.l     font_dat_table(a3),d0
		add.l      d1,d0
		move.l     d0,LA_FBASE(a0)
		move.w     wrt_mode,LA_WRT_MODE(a0)
		move.w     #-1,LA_DDA_INC(a0)
		move.w     #1,LA_T_SCLSTS(a0)
		move.w     font_flags(a3),LA_MONO_STAT(a0)
		clr.w      LA_SRCY(a0)
		move.w     font_form_width(a3),LA_FWIDTH(a0)
		move.w     font_form_height(a3),LA_DELY(a0)
		move.w     text_style,LA_STYLE(a0)
		move.w     font_lighten(a3),LA_LITEMASK(a0)
		move.w     font_skew(a3),LA_SKEWMASK(a0)
		move.w     font_left_offset(a3),LA_L_OFF(a0)
		move.w     font_right_offset(a3),LA_R_OFF(a0)
		move.w     font_thicken(a3),LA_WEIGHT(a0)
		move.w     text_double,LA_DOUBLE(a0)
		tst.w      LA_DOUBLE(a0)
		beq.s      linea_textblit2
		asl.w      LA_L_OFF(a0)
		asl.w      LA_R_OFF(a0)
linea_textblit2:
		move.w     text_rotation,LA_CHUP(a0)
		move.w     textfg_color,LA_TEXTFG(a0)
		move.w     textbg_color,LA_TEXTBG(a0)
		lea.l      scratchbuf,a6
		move.l     a6,LA_SCRTCHP(a0)
		move.w     #SCRATCHBUF_SIZE,LA_SCRPT2(a0)
		lea.l      save_clip_flap,a6
		move.w     LA_CLIP(a0),(a6)
		move.w     #0,LA_CLIP(a0)
		movea.l    textblit_str(pc),a2
		move.b     (a2),d0
		andi.l     #255,d0
		cmp.w      font_last_ade(a3),d0
		bgt.s      linea_textblit6
		sub.w      font_first_ade(a3),d0
		blt.s      linea_textblit6
		move.l     fonthdr(pc),d1
		add.w      d0,d0
		movea.l    font_off_table(a3),a4
		adda.l     d1,a4
		move.w     0(a4,d0.w),LA_SRCX(a0)
		btst       #3,LA_MONO_STAT+1(a0)
		beq.s      linea_textblit3
		move.w     font_max_cell_width(a3),LA_DELX(a0)
		bra.s      linea_textblit4
linea_textblit3:
		move.w     2(a4,d0.w),d1
		sub.w      0(a4,d0.w),d1
		move.w     d1,LA_DELX(a0)
linea_textblit4:
		move.l     font_hor_table(a3),d2
		beq.s      linea_textblit5
		move.l     fonthdr(pc),d1
		add.l      d1,d2
		movea.l    d2,a5
		move.w     LA_DESTX(a0),d1
		add.w      0(a5,d0.w),d1
		move.w     d1,LA_DESTX(a0)
linea_textblit5:
		movem.l    a0-a6,-(a7)
		lea.l      textblit_coords,a3
		move.w     (a3),LA_DESTX(a0)
		move.w     2(a3),LA_DESTY(a0)
		bsr.s      inc_coords
		move.w     #0x8000,LA_XACC_DDA(a0)
		ALINE      #8
		movem.l    (a7)+,a0-a6
linea_textblit6:
		lea.l      save_clip_flap,a6
		move.w     (a6),LA_CLIP(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

inc_coords:
		move.w     LA_DELX(a0),d1
		move.w     LA_DOUBLE(a0),d0
		or.w       LA_STYLE(a0),d0
		tst.w      d0
		beq.s      inc_coords3
		move.w     LA_R_OFF(a0),d2
		cmpi.w     #20,LA_STYLE(a0)
		blt.s      inc_coords2
		tst.w      LA_DOUBLE(a0)
		beq.s      inc_coords1
		asr.w      #1,d2
		sub.w      LA_WEIGHT(a0),d1
inc_coords1:
		add.w      d2,d1
inc_coords2:
		tst.w      LA_DOUBLE(a0)
		beq.s      inc_coords3
		asl.w      #1,d1
inc_coords3:
		tst.w      text_rotation
		beq.s      inc_coords4
		cmpi.w     #1800,text_rotation
		beq.s      inc_coords4
		add.w      d1,2(a3)
		rts
inc_coords4:
		add.w      d1,(a3)
		lea.l      textblit_str(pc),a2
		addq.l     #1,(a2)
		rts

linea_textblit_hi:
		move.w     #2,-(a7) /* Physbase */
		trap       #14
		addq.l     #2,a7
		movea.l    d0,a2
		movem.l    a2-a6,-(a7)
		ALINE      #0
		movem.l    (a7)+,a2-a6
		move.w     sysfont(pc),d0
		asl.w      #2,d0
		movea.l    0(a1,d0.w),a3
		move.l     fonthdr(pc),d1
		tst.l      d1
		beq.s      linea_textblit_hi1
		movea.l    fonthdr(pc),a3
		move.l     a3,d1
linea_textblit_hi1:
		move.l     font_dat_table(a3),d0
		add.l      d1,d0
		movea.l    d0,a4
		move.w     font_max_cell_width(a3),d5
		move.w     font_form_width(a3),d6
		move.w     font_form_height(a3),d7
		lea.l      textblit_coords(pc),a5
		movea.l    textblit_str(pc),a1
		move.b     (a1),d0
		andi.l     #255,d0
		cmp.w      font_last_ade(a3),d0
		bgt.s      linea_textblit_hi8
		sub.w      font_first_ade(a3),d0
		blt.s      linea_textblit_hi8
		movem.l    d0-d7/a1-a6,-(a7)
		move.w     #0x5555,d1
		cmpi.w     #TXT_LIGHT,text_style
		beq.s      linea_textblit_hi2
		move.w     #-1,d1
linea_textblit_hi2:
		/* move.w     0(a5),d4 */
		dc.w 0x382d,0
		asl.w      #1,d4
		move.w     2(a5),d5
		mulu.w     V_BYTES_LIN(a0),d5
		adda.l     d5,a2
		adda.w     d4,a2
		subq.w     #1,d7
linea_textblit_hi3:
		movea.l    a2,a1
		move.w     font_max_cell_width(a3),d3
		subq.w     #1,d3
		move.b     0(a4,d0.w),d2
		and.b      d1,d2
linea_textblit_hi4:
		btst       d3,d2
		beq.s      linea_textblit_hi5
		move.w     textfg_color(pc),(a2)+
		bra.s      linea_textblit_hi7
linea_textblit_hi5:
		cmpi.w     #MD_TRANS,wrt_mode
		bne.s      linea_textblit_hi6
		addq.l     #2,a2
		bra.s      linea_textblit_hi7
linea_textblit_hi6:
		move.w     textbg_color(pc),(a2)+
linea_textblit_hi7:
		dbf        d3,linea_textblit_hi4
		rol.w      #1,d1
		movea.l    a1,a2
		lea.l      256(a4),a4
		adda.w     V_BYTES_LIN(a0),a2
		dbf        d7,linea_textblit_hi3
		movem.l    (a7)+,d0-d7/a1-a6
		add.w      d5,(a5)
		lea.l      textblit_str(pc),a2
		addq.l     #1,(a2)
linea_textblit_hi8:
		movem.l    (a7)+,d0-d7/a0-a6
		rts


linea_fillrect:
		movem.l    d0-d7/a0-a6,-(a7)
		/* move.w     0(a4),LA_X1(a0) */
		dc.w 0x316c,0,LA_X1
		move.w     2(a4),LA_Y1(a0)
		move.w     4(a4),LA_X2(a0)
		move.w     6(a4),LA_Y2(a0)
		/* move.w     0(a4),LA_XMN_CLIP(a0) */
		dc.w 0x316c,0,LA_XMN_CLIP
		move.w     2(a4),LA_YMN_CLIP(a0)
		move.w     4(a4),LA_XMX_CLIP(a0)
		move.w     6(a4),LA_YMX_CLIP(a0)
		move.w     #MD_REPLACE,LA_WRT_MODE(a0)
		lea.l      fillpattern(pc),a5
		move.l     a5,LA_PATPTR(a0)
		move.w     #1,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		move.w     #1,LA_CLIP(a0)
		ALINE      #5
		movem.l    (a7)+,d0-d7/a0-a6
		rts


fillrect_8planes:
		movem.l    d0-d7/a0-a6,-(a7)
		/* move.w     LA_PLANES(a0),d7 */
		dc.w 0x3e28,0 /* XXX */
		asl.w      #1,d7
		move.w     V_BYTES_LIN(a0),d5
		lea.l      bitblt,a1
		bsr.s      calc_optab
		/* move.w     0(a4),d1 */
		dc.w 0x322c,0
		move.w     2(a4),d2
		move.w     4(a4),d3
		move.w     6(a4),d4
		sub.w      d1,d3 /* calc width */
		addq.w     #1,d3
		sub.w      d2,d4 /* calc height */
		addq.w     #1,d4
		move.w     d3,(a1)+ /* b_wd */
		move.w     d4,(a1)+ /* b_ht */
		move.w     #4,(a1)+ /* plane_cnt */
		move.w     #12,(a1)+ /* fg_col */
		move.w     #10,(a1)+ /* bg_col */
		move.l     d0,(a1)+ /* op_tab */
		move.w     d1,(a1)+ /* s_xmin */
		move.w     d2,(a1)+ /* s_ymin */
		move.l     physic(pc),d6
		/* addq.l     #8,d6 */
		dc.w 0x0686,0,8 /* XXX */
		move.l     d6,(a1)+ /* s_form */
		move.w     d7,(a1)+ /* s_nxwd */
		move.w     d5,(a1)+ /* s_nxln */
		move.w     #2,(a1)+ /* s_nxpl */
		move.w     d1,(a1)+ /* d_xmin */
		move.w     d2,(a1)+ /* d_ymin */
		move.l     physic(pc),d6
		/* addq.l     #8,d6 */
		dc.w 0x0686,0,8 /* XXX */
		move.l     d6,(a1)+ /* d_form */
		move.w     d7,(a1)+ /* d_nxwd */
		move.w     d5,(a1)+ /* d_nxln */
		move.w     #2,(a1)+ /* d_nxpl */
		move.l     #0,(a1)+ /* p_addr */
		lea.l      bitblt,a6
		dc.w 0xa007
		movem.l    (a7)+,d0-d7/a0-a6
		rts

calc_optab:
		move.w     d0,d3
		moveq.l    #0,d0
		btst       #4,d3
		beq.s      calc_optab1
		ori.l      #0x0F000000,d0
calc_optab1:
		btst       #5,d3
		beq.s      calc_optab2
		ori.l      #0x000F0000,d0
calc_optab2:
		btst       #6,d3
		beq.s      calc_optab3
		ori.l      #0x00000F00,d0
calc_optab3:
		btst       #7,d3
		beq.s      calc_optab4
		ori.l      #0x0000000F,d0
calc_optab4:
		rts


linea_setcolor:
		move.l     d0,-(a7)
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      linea_setcolor1
		bset       #0,LA_FG_1+1(a0)
linea_setcolor1:
		btst       #1,d0
		beq.s      linea_setcolor2
		bset       #0,LA_FG_2+1(a0)
linea_setcolor2:
		btst       #2,d0
		beq.s      linea_setcolor3
		bset       #0,LA_FG_3+1(a0)
linea_setcolor3:
		btst       #3,d0
		beq.s      linea_setcolor4
		bset       #0,LA_FG_4+1(a0)
linea_setcolor4:
		move.l     (a7)+,d0
		rts

set_fontheight:
		lea.l      mch_cookie(pc),a0
		cmpi.l     #0x00030000,(a0)
		bne.s      set_fontheight1
		lea.l      vdo_cookie(pc),a0
		cmpi.l     #0x00030000,(a0)
		bne.s      set_fontheight1
		move.w     #-1,-(a7)
		move.w     #88,-(a7) /* VsetMode */
		trap       #14
		addq.l     #4,a7
		lea.l      falconmode(pc),a1
		move.w     d0,(a1)
		btst       #7,d0
		beq.s      set_fontheight3 /* ST-compatible? */
set_fontheight1:
		move.w     #4,-(a7) /* yes, use Getrez */
		trap       #14
		addq.l     #2,a7
		cmpi.w     #2,d0    /* highcolor? */
		blt.s      set_fontheight2
		lea.l      fontheight(pc),a1 /* yes, use large font */
		move.w     #16,(a1)
		lea.l      sysfont(pc),a1
		move.w     #2,(a1)
		rts
set_fontheight2:
		lea.l      fontheight(pc),a1 /* no, use small font */
		move.w     #8,(a1)
		lea.l      sysfont(pc),a1
		move.w     #1,(a1)
		rts
set_fontheight3:
		btst       #4,d0 /* VGA mode? */
		beq.s      set_fontheight6
		btst       #8,d0  /* interlace? */
		bne.s      set_fontheight5
		lea.l      fontheight(pc),a1
set_fontheight4:
		move.w     #16,(a1)
		lea.l      sysfont(pc),a1
		move.w     #2,(a1)
		rts
set_fontheight5:
		lea.l      fontheight(pc),a1
		move.w     #8,(a1)
		lea.l      sysfont(pc),a1
		move.w     #1,(a1)
		rts
set_fontheight6:
		btst       #8,d0
		bne.s      set_fontheight7
		lea.l      fontheight(pc),a1
		move.w     #8,(a1)
		lea.l      sysfont(pc),a1
		move.w     #1,(a1)
		rts
set_fontheight7:
		lea.l      fontheight(pc),a1
		move.w     #16,(a1)
		lea.l      sysfont(pc),a1
		move.w     #2,(a1)
		rts

	.data
fillpattern:
		dc.w $ffff
		dc.w $ffff
		dc.w $5555
		dc.w $aaaa
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0003
		dc.w $0001
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $001f
		dc.w $001f
		dc.w $0100
		dc.w $0040
		dc.w $017f
		dc.w $007f
		dc.w $0000
		dc.w $0000
		dc.w $0020
		dc.w $0020
		dc.w $0002
		dc.w $0000
		dc.w $0001
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0000
		dc.w $0280
		dc.w $00c8
		dc.w $0028
		dc.w $0000
		dc.w $0002
		dc.w $0000
		dc.w $0000
		dc.w $0000

alert_icon_font:
		dc.w 1 /* id */
		dc.w 24 /* points */
		dc.b 'STOS Alert Icons 32x32',0,0,0,0,0,0,0,0,0,0
		dc.w 0 /* first_ade */
		dc.w 6 /* last_ade */
		dc.w 27 /* top */
		dc.w 23 /* ascent */
		dc.w 21 /* half */
		dc.w 4 /* descent */
		dc.w 5 /* bottom */
		dc.w 32 /* char width */
		dc.w 32 /* char height */
		dc.w 2 /* left_offset */
		dc.w 17 /* right offset */
		dc.w 2 /* thicken */
		dc.w 2 /* underline size */
		dc.w $5555 /* lighten mask */
		dc.w $5555 /* skew mask */
		dc.w 4+8 /* flags: bigendian+monospaced */
		dc.l alert_icon_hortable-alert_icon_font
		dc.l alert_icon_offtable-alert_icon_font
		dc.l alert_icon_dattable-alert_icon_font
		dc.w 28 /* form width */
		dc.w 32 /* form height */
		dc.l 0 /* next font */

alert_icon_hortable:

alert_icon_offtable:
		dc.w 0*32,1*32,2*32,3*32,4*32,5*32,6*32,7*32

alert_icon_dattable:
		dc.w $0000,$0000,$0001,$8000,$3fff,$fffe,$00ff,$ff00,$ffff,$ffff,$7fff,$fff0,$1e7e,$78f0
		dc.w $0000,$0000,$0002,$4000,$4000,$0001,$0100,$0080,$8000,$0001,$ffff,$fff8,$3f7e,$fdf8
		dc.w $0000,$0000,$0004,$2000,$5fff,$fffd,$027f,$fe40,$bfff,$fffd,$fc00,$003c,$3318,$cd98
		dc.w $0000,$0000,$0009,$9000,$5fff,$fffd,$04ff,$ff20,$bffe,$3ffd,$fc00,$003e,$3018,$cd80
		dc.w $0000,$0000,$0013,$c800,$5fc0,$01fd,$09ff,$ff90,$bffc,$1ffd,$fc00,$3f3f,$3018,$cd80
		dc.w $0000,$0000,$0027,$e400,$5f80,$00fd,$13ff,$ffc8,$bffc,$1ffd,$fc00,$3f3f,$3018,$cd80
		dc.w $0000,$0000,$004c,$3200,$5f00,$007d,$27ff,$ffe4,$bffc,$1ffd,$fc00,$3f3f,$3e18,$cdf0
		dc.w $0000,$0000,$009c,$3900,$5f0f,$f87d,$4fff,$fff2,$bffe,$3ffd,$fc00,$3f3f,$1f18,$ccf8
		dc.w $0000,$0000,$013c,$3c80,$5f1f,$fc7d,$9fff,$fff9,$bfff,$fffd,$fc00,$3f3f,$0318,$cc18
		dc.w $0000,$0000,$027c,$3e40,$4f1f,$fc79,$bfff,$fffd,$bfff,$fffd,$fc00,$3f3f,$0318,$cc18
		dc.w $0000,$0000,$04fc,$3f20,$2f1f,$fc7a,$b8c1,$8c3d,$bfc0,$0ffd,$fc00,$3f3f,$0318,$cc18
		dc.w $0000,$0000,$09fc,$3f90,$271f,$fc72,$b777,$75dd,$bfc0,$0ffd,$fc00,$3f3f,$0318,$cc18
		dc.w $0000,$0000,$13fc,$3fc8,$17ff,$f874,$b7f7,$75dd,$bfc0,$0ffd,$fc00,$003f,$3318,$cd98
		dc.w $0000,$0000,$27fc,$3fe4,$13ff,$f0e4,$b7f7,$75dd,$bfc0,$0ffd,$fc00,$003f,$3f18,$fdf8
		dc.w $0000,$0000,$4ffc,$3ff2,$0bff,$e1e8,$b7f7,$75dd,$bfc0,$0ffd,$ffff,$ffff,$1e18,$78f0
		dc.w $0000,$0000,$9ffc,$3ff9,$09ff,$c3c8,$b7f7,$75dd,$bff8,$0ffd,$ffff,$ffff,$0000,$0000
		dc.w $0000,$0000,$9ffc,$3ff9,$05ff,$87d0,$b8f7,$743d,$bff8,$0ffd,$ffff,$ffff,$0000,$0000
		dc.w $0000,$0000,$4ffc,$3ff2,$04ff,$0f90,$bf77,$75fd,$bff8,$0ffd,$fc00,$001f,$7c78,$f33c
		dc.w $0000,$0000,$27fc,$3fe4,$02fe,$1fa0,$bf77,$75fd,$bff8,$0ffd,$fc00,$001f,$7efd,$fb7e
		dc.w $0000,$0000,$13fc,$3fc8,$027e,$3f20,$bf77,$75fd,$bff8,$0ffd,$fc00,$001f,$66cd,$9b62
		dc.w $0000,$0000,$09ff,$ff90,$017e,$3f40,$b777,$75fd,$bff8,$0ffd,$fc00,$001f,$66cd,$8360
		dc.w $0000,$0000,$04ff,$ff20,$013e,$3e40,$b8f7,$8dfd,$bff8,$0ffd,$fc00,$001f,$66cd,$8360
		dc.w $0000,$0000,$027c,$3e40,$00bf,$fe80,$bfff,$fffd,$bff8,$0ffd,$fc00,$001f,$66cd,$8360
		dc.w $0000,$0000,$013c,$3c80,$009f,$fc80,$9fff,$fff9,$bff8,$0ffd,$fc00,$001f,$7cfd,$f360
		dc.w $0000,$0000,$009c,$3900,$005e,$3d00,$4fff,$fff2,$bff8,$0ffd,$fc00,$001f,$7cfc,$fb60
		dc.w $0000,$0000,$004c,$3200,$004e,$3900,$27ff,$ffe4,$bfc0,$01fd,$fc00,$001f,$66cc,$1b60
		dc.w $0000,$0000,$0027,$e400,$002e,$3a00,$13ff,$ffc8,$bfc0,$01fd,$fc00,$001f,$66cc,$1b60
		dc.w $0000,$0000,$0013,$c800,$0026,$3200,$09ff,$ff90,$bfc0,$01fd,$8c00,$001f,$66cc,$1b60
		dc.w $0000,$0000,$0009,$9000,$0017,$f400,$04ff,$ff20,$bfc0,$01fd,$8c00,$001f,$66cc,$1b60
		dc.w $0000,$0000,$0004,$2000,$0013,$e400,$027f,$fe40,$bfff,$fffd,$8c00,$001f,$66cd,$9b62
		dc.w $0000,$0000,$0002,$4000,$0008,$0800,$0100,$0080,$8000,$0001,$ffff,$ffff,$7ecd,$fb7e
		dc.w $0000,$0000,$0001,$8000,$0007,$f000,$00ff,$ff00,$ffff,$ffff,$7fff,$fffe,$7ccc,$f33c

	.bss

scratchbuf: ds.w SCRATCHBUF_SIZE /* 157c4 */

bitblt: ds.b 78 /* 15fc4 */
physic: ds.l 1 /* 16012 */
logic: ds.l 1 /* 16016 */
num_titles: ds.w 1 /* 1601a */
            ds.w 1
fontheight: ds.w 1 /* 1601e */
textblit_str: ds.l 1 /* 16020 */
fonthdr: ds.l 1 /* 16024 */
sysfont: ds.w 1 /* 16028 */
text_style: ds.w 1 /* 1602a */
textfg_color: ds.w 1
textbg_color: ds.w 1
wrt_mode: ds.w 1 /* 16030 */
text_rotation: ds.w 1
text_double: ds.w 1
textblit_coords: ds.w 2 /* 16036 */
save_clip_flap: ds.w 1
x1603c: ds.w 1
x1603e: ds.l 1
alert_colors: ds.w 4
     ds.w 1
alert_str: ds.l 1 /* 1604c */
alert_icon: ds.w 1 /* 16050 */
num_alert_buttons: ds.w 1 /* 16052 */
alert_pos: ds.w 6 ; coordinates of the three buttons

alert_strings: ds.b MAX_ALERT_STR*ALERT_STR_SIZE /* 16060 */

alert_buttons: ds.b 46*MAX_ALERT_BUT /* 1616a */

menuparams: ds.b mn_sizeof

menuinfo: ds.b MAX_TITLE*(MAX_ENTRY*ENT_SIZE+tit_sizeof)


title_coords: ds.w 4*(MAX_TITLE+4)

entry_coords: ds.w 4*(MAX_ENTRY+9)

/* 16a76 */
	.IFEQ COMPILER
pair:     ds.l 2
bufcopie: ds.b 32064
    .ENDC
	
screenbuf: ds.b 122884


