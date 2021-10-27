	.OFFSET -0x38e
               ds.l 1        /*   (lineavars-$38e)    reserved long */
CUR_FONT:      ds.l 1      /* (lineavars-$38a) */	/* long */
               ds.w 23       /*   (lineavars-$386)    23 reserved words */
M_POS_HX:      ds.w 1      /* (lineavars-$358) */	/* word */
M_POS_HY:      ds.w 1      /* (lineavars-$356) */	/* word */
M_PLANES:      ds.w 1      /* (lineavars-$354) */	/* word */
M_CDB_BG:      ds.w 1      /* (lineavars-$352) */	/* word */
M_CDB_FG:      ds.w 1      /* (lineavars-$350) */	/* word */
MASK_FORM:     ds.w 32     /* (lineavars-$34e) */	/* 32 words */
INQ_TAB:       ds.w 45     /* (lineavars-$30e) */	/* 45 words */
DEV_TAB:       ds.w 45     /* (lineavars-$2b4) */	/* 45 words */
GCURX:         ds.w 1      /* (lineavars-$25a) */	/* word */
GCURY:         ds.w 1      /* (lineavars-$258) */	/* word */
M_HID_CNT:     ds.w 1      /* (lineavars-$256) */	/* word */
MOUSE_BT:      ds.w 1      /* (lineavars-$254) */	/* word */
REQ_COL:       ds.w 16*3   /* (lineavars-$252) */	/* 16 * 3 words */
SIZ_TAB:       ds.w 15     /* (lineavars-$1F2) */	/* 15 words */
TERM_CH:       ds.w 1      /* (lineavars-$1d4) */	/* word */
CHC_MOD:       ds.w 1      /* (lineavars-$1d2) */	/* word */
CUR_WORK:      ds.l 1      /* (lineavars-$1d0) */	/* long */
DEF_FONT:      ds.l 1      /* (lineavars-$1cc) */	/* long */
FONT_RING:     ds.l 4      /* (lineavars-$1c8) */	/* 4 longs */
FONT_COUNT:    ds.w 1      /* (lineavars-$1b8) */	/* word */
LINE_CW:       ds.w 1      /* (lineavars-$1b6) */	/* word */
LOC_MODE:      ds.w 1      /* (lineavars-$1b4) */	/* word */
NUM_QC_LIN:    ds.w 1      /* (lineavars-$1b2) */	/* word */
TRAP14SAV:     ds.l 1      /* (lineavars-$1b0) */	/* long */
COL_OR_MASK:   ds.l 1      /* (lineavars-$1ac) */	/* long */
COL_AND_MASK:  ds.l 1      /* (lineavars-$1a8) */	/* long */
TRAP14BSAV:    ds.l 1      /* (lineavars-$1a4) */	/* long */
               ds.w 32       /*   (lineavars-$1a2)    32 reserved words */
STR_MODE:      ds.w 1      /* (lineavars-$160) */	/* word */
VAL_MODE:      ds.w 1      /* (lineavars-$15e) */	/* word */
CUR_MS_STAT:   ds.b 1      /* (lineavars-$15c) */	/* byte */
               ds.b 1                           /* padding */
V_HID_CNT:     ds.w 1      /* (lineavars-$15a) */	/* word */
CUR_X:         ds.w 1      /* (lineavars-$158) */	/* word */
CUR_Y:         ds.w 1      /* (lineavars-$156) */	/* word */
CUR_FLAG:      ds.b 1      /* (lineavars-$154) */	/* byte */
MOUSE_FLAG:    ds.b 1      /* (lineavars-$153) */	/* byte */
RETSAV:        ds.l 1      /* (lineavars-$152) */	/* long */
SAV_CURX:      ds.w 1      /* (lineavars-$14e) */	/* word */
SAV_CURY:      ds.w 1      /* (lineavars-$14c) */	/* word */
SAVE_LEN:      ds.w 1      /* (lineavars-$14a) */	/* word */
SAVE_ADDR:     ds.l 1      /* (lineavars-$148) */	/* long */
SAVE_STAT:     ds.w 1      /* (lineavars-$144) */	/* word */
SAVE_AREA:     ds.l 64      /* (lineavars-$142) */	/* 64 longs */
USER_TIM:      ds.l 1      /* (lineavars-$042) */	/* long */
NEXT_TIM:      ds.l 1      /* (lineavars-$03e) */	/* long */
USER_BUT:      ds.l 1      /* (lineavars-$03a) */	/* long */
USER_CUR:      ds.l 1      /* (lineavars-$036) */	/* long */
USER_MOT:      ds.l 1      /* (lineavars-$032) */	/* long */
V_CEL_HT:      ds.w 1      /* (lineavars-$02e) */	/* word */
V_CEL_MX:      ds.w 1      /* (lineavars-$02c) */	/* word */
V_CEL_MY:      ds.w 1      /* (lineavars-$02a) */	/* word */
V_CEL_WR:      ds.w 1      /* (lineavars-$028) */	/* word */
V_COL_BG:      ds.w 1      /* (lineavars-$026) */	/* word */
V_COL_FG:      ds.w 1      /* (lineavars-$024) */	/* word */
V_CUR_AD:      ds.l 1      /* (lineavars-$022) */	/* long */
V_CUR_OF:      ds.w 1      /* (lineavars-$01e) */	/* word */
V_CUR_XY:      ds.w 2      /* (lineavars-$01c) */	/* 2 words X,Y */
V_PERIOD:      ds.b 1      /* (lineavars-$018) */	/* byte */
V_CUR_CT:      ds.b 1      /* (lineavars-$017) */	/* byte */
V_FNT_AD:      ds.l 1      /* (lineavars-$016) */	/* long */
V_FNT_ND:      ds.w 1      /* (lineavars-$012) */	/* word */
V_FNT_ST:      ds.w 1      /* (lineavars-$010) */	/* word */
V_FNT_WD:      ds.w 1      /* (lineavars-$00e) */	/* word */
V_REZ_HZ:      ds.w 1      /* (lineavars-$00c) */	/* word */
V_OFF_AD:      ds.l 1      /* (lineavars-$00a) */	/* long */
V_STAT_0:      ds.b 1      /* (lineavars-$006) */	/* byte */
V_DELAY:       ds.b 1      /* (lineavars-$005) */	/* byte */
V_REZ_VT:      ds.w 1      /* (lineavars-$004) */	/* word */
V_BYTES_LIN:   ds.w 1      /* (lineavars-$002) */	/* word */

LA_PLANES:     ds.w 1      /* (lineavars+$000) */	/* word */
LA_LIN_WR:     ds.w 1      /* (lineavars+$002) */	/* word */
LA_CONTROL:    ds.l 1      /* (lineavars+$004) */	/* long */
LA_INTIN:      ds.l 1      /* (lineavars+$008) */	/* long */
LA_PTSIN:      ds.l 1      /* (lineavars+$00c) */	/* long */
LA_INTOUT:     ds.l 1      /* (lineavars+$010) */	/* long */
LA_PTSOUT:     ds.l 1      /* (lineavars+$014) */	/* long */
LA_FG_1:       ds.w 1      /* (lineavars+$018) */	/* word */
LA_FG_2:       ds.w 1      /* (lineavars+$01a) */	/* word */
LA_FG_3:       ds.w 1      /* (lineavars+$01c) */	/* word */
LA_FG_4:       ds.w 1      /* (lineavars+$01e) */	/* word */
LA_LSTLIN:     ds.w 1      /* (lineavars+$020) */	/* word */
LA_LN_MASK:    ds.w 1      /* (lineavars+$022) */	/* word */
LA_WRT_MODE:   ds.w 1      /* (lineavars+$024) */	/* word */
LA_X1:         ds.w 1      /* (lineavars+$026) */	/* word */
LA_Y1:         ds.w 1      /* (lineavars+$028) */	/* word */
LA_X2:         ds.w 1      /* (lineavars+$02a) */	/* word */
LA_Y2:         ds.w 1      /* (lineavars+$02c) */	/* word */
LA_PATPTR:     ds.l 1      /* (lineavars+$02e) */	/* long */
LA_PATMSK:     ds.w 1      /* (lineavars+$032) */	/* word */
LA_MULTIFILL:  ds.w 1      /* (lineavars+$034) */	/* word */
LA_CLIP:       ds.w 1      /* (lineavars+$036) */	/* word */
LA_XMN_CLIP:   ds.w 1      /* (lineavars+$038) */	/* word */
LA_YMN_CLIP:   ds.w 1      /* (lineavars+$03a) */	/* word */
LA_XMX_CLIP:   ds.w 1      /* (lineavars+$03c) */	/* word */
LA_YMX_CLIP:   ds.w 1      /* (lineavars+$03e) */	/* word */
LA_XACC_DDA:   ds.w 1      /* (lineavars+$040) */	/* word */
LA_DDA_INC:    ds.w 1      /* (lineavars+$042) */	/* word */
LA_T_SCLSTS:   ds.w 1      /* (lineavars+$044) */	/* word */
LA_MONO_STAT:  ds.w 1      /* (lineavars+$046) */	/* word */
LA_SRCX:       ds.w 1      /* (lineavars+$048) */	/* word */
LA_SRCY:       ds.w 1      /* (lineavars+$04a) */	/* word */
LA_DESTX:      ds.w 1      /* (lineavars+$04c) */	/* word */
LA_DESTY:      ds.w 1      /* (lineavars+$04e) */	/* word */
LA_DELX:       ds.w 1      /* (lineavars+$050) */	/* word */
LA_DELY:       ds.w 1      /* (lineavars+$052) */	/* word */
LA_FBASE:      ds.l 1      /* (lineavars+$054) */	/* long */
LA_FWIDTH:     ds.w 1      /* (lineavars+$058) */	/* word */
LA_STYLE:      ds.w 1      /* (lineavars+$05a) */	/* word */
LA_LITEMASK:   ds.w 1      /* (lineavars+$05c) */	/* word */
LA_SKEWMASK:   ds.w 1      /* (lineavars+$05e) */	/* word */
LA_WEIGHT:     ds.w 1      /* (lineavars+$060) */	/* word */
LA_R_OFF:      ds.w 1      /* (lineavars+$062) */	/* word */
LA_L_OFF:      ds.w 1      /* (lineavars+$064) */	/* word */
LA_DOUBLE:     ds.w 1      /* (lineavars+$066) */	/* word */
LA_CHUP:       ds.w 1      /* (lineavars+$068) */	/* word */
LA_TEXTFG:     ds.w 1      /* (lineavars+$06a) */	/* word */
LA_SCRTCHP:    ds.l 1      /* (lineavars+$06c) */	/* long */
LA_SCRPT2:     ds.w 1      /* (lineavars+$070) */	/* word */
LA_TEXTBG:     ds.w 1      /* (lineavars+$072) */	/* word */
LA_COPYTRAN:   ds.w 1      /* (lineavars+$074) */	/* word */
LA_FILL_ABORT: ds.l 1      /* (lineavars+$076) */	/* long */

/*
 * variables below were never documented, and
 * may differ depending on TOS version used.
 * The layout below is maybe valid for MULTITOS only.
 */
LA_USERDEVINIT:ds.l 1      /* (lineavars+$07a) */	/* long */
LA_USERESCINIT:ds.l 1      /* (lineavars+$07e) */	/* long */
LA_RSRD2:      ds.l 8      /* (lineavars+$082) */	/* 8 longs */
LA_ROUTINES:   ds.l 1      /* (lineavars+$0a2) */	/* long */
LA_CURDEV:     ds.l 1      /* (lineavars+$0a6) */	/* long */
LA_BLTMODE:    ds.w 1      /* (lineavars+$0aa) */	/* word */
LA_RSRD3:      ds.w 1      /* (lineavars+$0ac) */	/* word */
/* TOS 4.04 only: */
LA_REGQXCOL:   ds.w 240*3  /* (lineavars+$0ae) */	/* 240*3 words */
LA_SVBLKPTR:   ds.l 1      /* (lineavars+$64e) */	/* long */
LA_FG_B_PLANES: ds.l 1     /* (lineavars+$652) */	/* long */
LA_FG_5:       ds.w 1      /* (lineavars+$656) */	/* word */
LA_FG_6:       ds.w 1      /* (lineavars+$658) */	/* word */
LA_FG_7:       ds.w 1      /* (lineavars+$65a) */	/* word */
LA_FG_8:       ds.w 1      /* (lineavars+$65c) */	/* word */
LA_SAVLEN:     ds.w 1      /* (lineavars+$65e) */	/* word */
LA_SAVADDR:    ds.l 1      /* (lineavars+$660) */	/* long */
LA_SAVSTAT:    ds.w 1      /* (lineavars+$664) */	/* word */
LA_SAVAREA:    ds.l 256    /* (lineavars+$666) */	/* 256 longs */
LA_QCIRCLE:    ds.w 80     /* (lineavars+$a66) */	/* 80 words */
LA_BYTPERPIX:  ds.w 1      /* (lineavars+$b06) */	/* word */
LA_FORMID:     ds.w 1      /* (lineavars+$b08) */	/* word */
LA_VCOLBG:     ds.l 1      /* (lineavars+$b0a) */	/* long */
LA_VCOLFG:     ds.l 1      /* (lineavars+$b0e) */	/* long */
LA_PALMAP:     ds.l 256    /* (lineavars+$b12) */	/* 256 longs */
LA_PRIMITIVES: ds.l 40     /* (lineavars+$f12) */	/* 40 longs */


/* font header */
		.OFFSET 0
font_id:        ds.w 1   /*  0 font id */
font_point:     ds.w 1   /*  2 height in points */
font_name:      ds.b 32  /*  4 font name */
font_first_ade: ds.w 1   /* 36 first character */
font_last_ade:  ds.w 1   /* 38 last character */
font_top:       ds.w 1   /* 40 distance topline->baseline */
font_ascent:    ds.w 1   /* 42 distance ascentline->baseline */
font_half:      ds.w 1   /* 44 distance halfline->baseline */
font_descent:   ds.w 1   /* 46 distance descentline->baeline */
font_bottom:    ds.w 1   /* 48 distance bottomline->baseline */
font_max_char_width: ds.w 1   /* 50 largest character width */
font_max_cell_width: ds.w 1   /* 52 largest cell width */
font_left_offset:    ds.w 1   /* 54 left offset for italic */
font_right_offset:   ds.w 1   /* 56 right offset for italic */
font_thicken:   ds.w 1   /* 58 embolden factor */
font_ul_size:   ds.w 1   /* 60 height of underline */
font_lighten:   ds.w 1   /* 62 mask for light effect */
font_skew:      ds.w 1   /* 64 mask for italic effect */
font_flags:     ds.w 1   /* 66 flags */
font_hor_table: ds.l 1   /* 68 offset/pointer to horizontal table */
font_off_table: ds.l 1   /* 72 offset/pointer to character offset table */
font_dat_table: ds.l 1   /* 76 offset/pointer to font image */
font_form_width: ds.w 1   /* 80 width of font image in bytes */
font_form_height: ds.w 1   /* 82 height of font image in pixel */
font_next_font:   ds.l 1   /* 84 pointer to next font */
sizeof_FONTHDR:          /* 88 */

