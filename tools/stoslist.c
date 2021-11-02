#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>
#include <getopt.h>
#include <math.h>
#include "tokens.h"

#ifndef FALSE
# define FALSE 0
# define TRUE  1
#endif

#define MAX_BANKS 16

struct basfile {
	unsigned char magic[10]; /* "Lionpoulos" */
	unsigned char dataprg[4]; /* total filesize, excluding header */
	/* length of memory banks; bank #0 is used for tokenized program code */
	unsigned char databank[MAX_BANKS][4];
};

struct token {
	const char *name;
	unsigned char val1;
	unsigned char val2;
};

#define EXTIF_SYSCTRL  0x0001
#define EXTIF_CONTROL  0x0002

struct extension {
	char extension;
	unsigned char opcode;
	unsigned short extension_if;
	const char *name;
};

struct token const tokens[] = {
	{ "to", T_to, 0 },
	{ "step", T_step, 0 },
	{ "next", T_next, 0 },
	{ "wend", T_wend, 0 },
	{ "until", T_until, 0 },
	{ "dim", T_dim, 0 },
	{ "poke", T_poke, 0 },
	{ "doke", T_doke, 0 },
	{ "loke", T_loke, 0 },
	{ "read", T_read, 0 },
	{ "rem", T_rem, 0 },
	{ "'", T_rem, 0 },
	{ "return", T_return, 0 },
	{ "pop", T_pop, 0 },
	{ "resume next", T_resumenext, 0 },
	{ "resume", T_resume, 0 },
	{ "on error", T_onerror, 0 },
	{ "screen copy", T_screencopy, 0 },
	{ "swap", T_swap, 0 },
	{ "plot", T_plot, 0 },
	{ "pie", T_pie, 0 },
	{ "draw", T_draw, 0 },
	{ "polyline", T_polyline, 0 },
	{ "polymark", T_polymark, 0 },
	{ "goto", T_goto, 0 },
	{ "gosub", T_gosub, 0 },
	{ "then", T_then, 0 },
	{ "else", T_else, 0 },
	{ "restore", T_restore, 0 },
	{ "for", T_for, 0 },
	{ "while", T_while, 0 },
	{ "repeat", T_repeat, 0 },
	{ "print", T_print, 0 },
	{ "?", T_print, 0 },
	{ "if", T_if, 0 },
	{ "update", T_update, 0 },
	{ "sprite", T_sprite, 0 },
	{ "freeze", T_freeze, 0 },
	{ "off", T_off, 0 },
	{ "on", T_on, 0 },
	{ "locate", T_locate, 0 },
	{ "paper", T_paper, 0 },
	{ "pen", T_pen, 0 },
	{ "home", T_home, 0 },
	{ ".b", T_sizeb, 0 },
	{ ".w", T_sizew, 0 },
	{ ".l", T_sizel, 0 },
	{ "cup", T_cup, 0 },
	{ "cdown", T_cdown, 0 },
	{ "cleft", T_cleft, 0 },
	{ "cright", T_cright, 0 },
	{ "cls", T_cls, 0 },
	{ "inc", T_inc, 0 },
	{ "dec", T_dec, 0 },
	{ "screen swap", T_screenswap, 0 },
	/* functions */
	{ "psg", T_psg, 0 },
	{ "scrn", T_scrn, 0 },
	{ "dreg", T_dreg, 0 },
	{ "areg", T_areg, 0 },
	{ "point", T_point, 0 },
	{ "drive$", T_drivestr, 0 },
	{ "dir$", T_dirstr, 0 },
	{ "abs", T_abs, 0 },
	{ "colour", T_colour, 0 },
	{ "fkey", T_fkey, 0 },
	{ "sin", T_sin, 0 },
	{ "cos", T_cos, 0 },
	{ "drive", T_drive, 0 },
	{ "timer", T_timer, 0 },
	{ "logic", T_logic, 0 },
	{ "fn", T_fn, 0 },
	{ "not", T_not, 0 },
	{ "rnd", T_rnd, 0 },
	{ "val", T_val, 0 },
	{ "asc", T_asc, 0 },
	{ "chr$", T_chr, 0 },
	{ "inkey$", T_inkey, 0 },
	{ "scancode", T_scancode, 0 },
	{ "mid$", T_mid, 0 },
	{ "right$", T_right, 0 },
	{ "left$", T_left, 0 },
	{ "length", T_length, 0 },
	{ "start", T_start, 0 },
	{ "len", T_len, 0 },
	{ "pi", T_pi, 0 },
	{ "peek", T_peek, 0 },
	{ "deek", T_deek, 0 },
	{ "leek", t_leek, 0 },
	{ "zone", T_zone, 0 },
	{ "x sprite", T_xsprite, 0 },
	{ "y sprite", T_ysprite, 0 },
	{ "x mouse", T_xmouse, 0 },
	{ "y mouse", T_ymouse, 0 },
	{ "mouse key", T_mousekey, 0 },
	{ "physic", T_physic, 0 },
	{ "back", T_back, 0 },
	{ "log", T_log, 0 },
	{ "pof", T_pof, 0 },
	{ "mode", T_mode, 0 },
	{ "time$", T_time, 0 },
	{ "date$", T_date, 0 },
	{ "screen$", T_screen, 0 },
	{ "default", T_default, 0 },
	/* OPERATORS */
	{ " xor ", T_xor, 0 },
	{ " or ", T_or, 0 },
	{ " and ", T_and, 0 },
	{ "<>", T_neq, 0 },
	{ "><", T_neq, 0 },
	{ "<=", T_leq, 0 },
	{ "=<", T_leq, 0 },
	{ ">=", T_geq, 0 },
	{ "=>", T_geq, 0 },
	{ "=", T_eq, 0 },
	{ "<", T_lt, 0 },
	{ ">", T_gt, 0 },
	{ "+", T_add, 0 },
	{ "-", T_sub, 0 },
	{ " mod ", T_mod, 0 },
	{ "*", T_mul, 0 },
	{ "/", T_div, 0 },
	{ "^", T_pow, 0 },
	{ NULL, 0, 0 }
};
static struct token const extfunctions[] = {
	{ "hsin", T_extfunc, T_extf_sinh },
	{ "hcos", T_extfunc, T_extf_cosh },
	{ "htan", T_extfunc, T_extf_tanh },
	{ "asin", T_extfunc, T_extf_asin },
	{ "acos", T_extfunc, T_extf_acos },
	{ "atan", T_extfunc, T_extf_atan },
	{ "upper$", T_extfunc, T_extf_upper },
	{ "lower$", T_extfunc, T_extf_lower },
	{ "current", T_extfunc, T_extf_current },
	{ "match", T_extfunc, T_extf_match },
	{ "errn", T_extfunc, T_extf_errn },
	{ "errl", T_extfunc, T_extf_errl },
	{ "varptr", T_extfunc, T_extf_varptr },
	{ "input$", T_extfunc, T_extf_input },
	{ "flip$", T_extfunc, T_extf_flip },
	{ "free", T_extfunc, T_extf_free },
	{ "str$", T_extfunc, T_extf_str },
	{ "hex$", T_extfunc, T_extf_hex },
	{ "bin$", T_extfunc, T_extf_bin },
	{ "string$", T_extfunc, T_extf_string },
	{ "space$", T_extfunc, T_extf_space },
	{ "instr", T_extfunc, T_extf_instr },
	{ "max", T_extfunc, T_extf_max },
	{ "min", T_extfunc, T_extf_min },
	{ "lof", T_extfunc, T_extf_lof },
	{ "eof", T_extfunc, T_extf_eof },
	{ "dir first$", T_extfunc, T_extf_dirfirst },
	{ "dir next$", T_extfunc, T_extf_dirnext },
	{ "btst", T_extfunc, T_extf_btst },
	{ "collide", T_extfunc, T_extf_collide },
	{ "accnb", T_extfunc, T_extf_accnb },
	{ "language", T_extfunc, T_extf_language },
	{ "hunt", T_extfunc, T_extf_hunt },
	{ "true", T_extfunc, T_extf_true },
	{ "false", T_extfunc, T_extf_false },
	{ "xcurs", T_extfunc, T_extf_xcurs },
	{ "ycurs", T_extfunc, T_extf_ycurs },
	{ "jup", T_extfunc, T_extf_jup },
	{ "jleft", T_extfunc, T_extf_jleft },
	{ "jright", T_extfunc, T_extf_jright },
	{ "jdown", T_extfunc, T_extf_jdown },
	{ "fire", T_extfunc, T_extf_fire },
	{ "joy", T_extfunc, T_extf_joy },
	{ "movon", T_extfunc, T_extf_movon },
	{ "icon$", T_extfunc, T_extf_icon },
	{ "tab", T_extfunc, T_extf_tab },
	{ "exp", T_extfunc, T_extf_exp },
	{ "charlen", T_extfunc, T_extf_charlen },
	{ "mnbar", T_extfunc, T_extf_mnbar },
	{ "mnselect", T_extfunc, T_extf_mnselect },
	{ "windon", T_extfunc, T_extf_windon },
	{ "xtext", T_extfunc, T_extf_xtext },
	{ "ytext", T_extfunc, T_extf_ytext },
	{ "xgraphic", T_extfunc, T_extf_xgraphic },
	{ "ygraphic", T_extfunc, T_extf_ygraphic },
	{ "sqr", T_extfunc, T_extf_sqr },
	{ "divx", T_extfunc, T_extf_divx },
	{ "divy", T_extfunc, T_extf_divy },
	{ "ln", T_extfunc, T_extf_ln },
	{ "tan", T_extfunc, T_extf_tan },
	{ "drvmap", T_extfunc, T_extf_drvmap },
	{ "file select$", T_extfunc, T_extf_fileselect },
	{ "dfree", T_extfunc, T_extf_dfree },
	{ "sgn", T_extfunc, T_extf_sgn },
	{ "port", T_extfunc, T_extf_port },
	{ "pvoice", T_extfunc, T_extf_pvoice },
	{ "int", T_extfunc, T_extf_int },
	{ "detect", T_extfunc, T_extf_detect },
	{ "deg", T_extfunc, T_extf_deg },
	{ "rad", T_extfunc, T_extf_rad },
	{ NULL, 0, 0 }
};
static struct token const extinstructions[] = {
	{ "dir/w", T_extinst, T_exti_dirw },
	{ "fade", T_extinst, T_exti_fade },
	{ "bcopy", T_extinst, T_exti_bcopy },
	{ "square", T_extinst, T_exti_square },
	{ "previous", T_extinst, T_exti_previous },
	{ "transpose", T_extinst, T_exti_transpose },
	{ "shift", T_extinst, T_exti_shift },
	{ "wait key", T_extinst, T_exti_waitkey },
	{ "dir", T_extinst, T_exti_dir },
	{ "ldir", T_extinst, T_exti_ldir },
	{ "bload", T_extinst, T_exti_bload },
	{ "bsave", T_extinst, T_exti_bsave },
	{ "qwindow", T_extinst, T_exti_qwindow },
	{ "as set", T_extinst, T_exti_asset },
	{ "charcopy", T_extinst, T_exti_charcopy },
	{ "under", T_extinst, T_exti_under },
	{ "menu$", T_extinst, T_exti_menustr },
	{ "menu", T_extinst, T_exti_menu },
	{ "title", T_extinst, T_exti_title },
	{ "border", T_extinst, T_exti_border },
	{ "hardcopy", T_extinst, T_exti_hardcopy },
	{ "windcopy", T_extinst, T_exti_windcopy },
	{ "redraw", T_extinst, T_exti_redraw },
	{ "centre", T_extinst, T_exti_centre },
	{ "tempo", T_extinst, T_exti_tempo },
	{ "volume", T_extinst, T_exti_volume },
	{ "envel", T_extinst, T_exti_envel },
	{ "boom", T_extinst, T_exti_boom },
	{ "shoot", T_extinst, T_exti_shoot },
	{ "bell", T_extinst, T_exti_bell },
	{ "play", T_extinst, T_exti_play },
	{ "noise", T_extinst, T_exti_noise },
	{ "voice", T_extinst, T_exti_voice },
	{ "music", T_extinst, T_exti_music },
	{ "box", T_extinst, T_exti_box },
	{ "rbox", T_extinst, T_exti_rbox },
	{ "bar", T_extinst, T_exti_bar },
	{ "rbar", T_extinst, T_exti_rbar },
	{ "appear", T_extinst, T_exti_appear },
	{ "bclr", T_extinst, T_exti_bclr },
	{ "bset", T_extinst, T_exti_bset },
	{ "rol", T_extinst, T_exti_rol },
	{ "ror", T_extinst, T_exti_ror },
	{ "curs", T_extinst, T_exti_curs },
	{ "clw", T_extinst, T_exti_clw },
	{ "bchg", T_extinst, T_exti_bchg },
	{ "call", T_extinst, T_exti_call },
	{ "trap", T_extinst, T_exti_trap },
	{ "run", T_extinst, T_exti_run },
	{ "clear key", T_extinst, T_exti_clearkey },
	{ "line input", T_extinst, T_exti_lineinput },
	{ "input", T_extinst, T_exti_input },
	{ "clear", T_extinst, T_exti_clear },
	{ "data", T_extinst, T_exti_data },
	{ "end", T_extinst, T_exti_end },
	{ "erase", T_extinst, T_exti_erase },
	{ "reserve", T_extinst, T_exti_reserve },
	{ "as datascreen", T_extinst, T_exti_asdatascreen },
	{ "as work", T_extinst, T_exti_aswork },
	{ "as screen", T_extinst, T_exti_asscreen },
	{ "as data", T_extinst, T_exti_asdata },
	{ "copy", T_extinst, T_exti_copy },
	{ "def", T_extinst, T_exti_def },
	{ "hide", T_extinst, T_exti_hide },
	{ "show", T_extinst, T_exti_show },
	{ "change mouse", T_extinst, T_exti_changemouse },
	{ "limit mouse", T_extinst, T_exti_limitmouse },
	{ "move x", T_extinst, T_exti_movex },
	{ "move y", T_extinst, T_exti_movey },
	{ "fix", T_extinst, T_exti_fix },
	{ "bgrab", T_extinst, T_exti_bgrab },
	{ "fill", T_extinst, T_exti_fill },
	{ "key list", T_extinst, T_exti_keylist },
	{ "key speed", T_extinst, T_exti_keyspeed },
	{ "move", T_extinst, T_exti_move },
	{ "anim", T_extinst, T_exti_anim },
	{ "unfreeze", T_extinst, T_exti_unfreeze },
	{ "set zone", T_extinst, T_exti_setzone },
	{ "reset zone", T_extinst, T_exti_resetzone },
	{ "limit sprite", T_extinst, T_exti_limitsprite },
	{ "priority", T_extinst, T_exti_priority },
	{ "reduce", T_extinst, T_exti_reduce },
	{ "put sprite", T_extinst, T_exti_putsprite },
	{ "get sprite", T_extinst, T_exti_getsprite },
	{ "load", T_extinst, T_exti_load },
	{ "save", T_extinst, T_exti_save },
	{ "palette", T_extinst, T_exti_palette },
	{ "synchro", T_extinst, T_exti_synchro },
	{ "error", T_extinst, T_exti_error },
	{ "break", T_extinst, T_exti_break },
	{ "let", T_extinst, T_exti_let },
	{ "key", T_extinst, T_exti_key },
	{ "open in", T_extinst, T_exti_openin },
	{ "open out", T_extinst, T_exti_openout },
	{ "open", T_extinst, T_exti_open },
	{ "close", T_extinst, T_exti_close },
	{ "field", T_extinst, T_exti_field },
	{ " as", T_extinst, T_exti_as },
	{ "put key", T_extinst, T_exti_putkey },
	{ "get palette", T_extinst, T_exti_getpalette },
	{ "kill", T_extinst, T_exti_kill },
	{ "rename", T_extinst, T_exti_rename },
	{ "rm dir", T_extinst, T_exti_rmdir },
	{ "mk dir", T_extinst, T_exti_mkdir },
	{ "stop", T_extinst, T_exti_stop },
	{ "wait vbl", T_extinst, T_exti_waitvbl },
	{ "sort", T_extinst, T_exti_sort },
	{ "get", T_extinst, T_exti_get },
	{ "flash", T_extinst, T_exti_flash },
	{ "using", T_extinst, T_exti_using },
	{ "lprint", T_extinst, T_exti_lprint },
	{ "auto back", T_extinst, T_exti_autoback },
	{ "set line", T_extinst, T_exti_setline },
	{ "gr writing", T_extinst, T_exti_grwriting },
	{ "set mark", T_extinst, T_exti_setmark },
	{ "set paint", T_extinst, T_exti_setpaint },
	{ "set pattern", T_extinst, T_exti_setpattern },
	{ "clip", T_extinst, T_exti_clip },
	{ "arc", T_extinst, T_exti_arc },
	{ "polygon", T_extinst, T_exti_polygon },
	{ "circle", T_extinst, T_exti_circle },
	{ "earc", T_extinst, T_exti_earc },
	{ "epie", T_extinst, T_exti_epie },
	{ "ellipse", T_extinst, T_exti_ellipse },
	{ "writing", T_extinst, T_exti_writing },
	{ "paint", T_extinst, T_exti_paint },
	{ "ink", T_extinst, T_exti_ink },
	{ "wait", T_extinst, T_exti_wait },
	{ "click", T_extinst, T_exti_click },
	{ "put", T_extinst, T_exti_put },
	{ "zoom", T_extinst, T_exti_zoom },
	{ "set curs", T_extinst, T_exti_setcurs },
	{ "scroll down", T_extinst, T_exti_scrolldown },
	{ "scroll up", T_extinst, T_exti_scrollup },
	{ "scroll", T_extinst, T_exti_scroll },
	{ "inverse", T_extinst, T_exti_inverse },
	{ "shade", T_extinst, T_exti_shade },
	{ "windopen", T_extinst, T_exti_windopen },
	{ "window", T_extinst, T_exti_window },
	{ "windmove", T_extinst, T_exti_windmove },
	{ "windel", T_extinst, T_exti_windel },
	{ "listbank", T_extinst, T_exti_listbank },
	{ "llistbank", T_extinst, T_exti_llistbank },
	{ "follow", T_extinst, T_exti_follow },
	{ "frequency", T_extinst, T_exti_frequency },
	{ "cont", T_extinst, T_exti_cont },
	{ "change", T_extinst, T_exti_change },
	{ "search", T_extinst, T_exti_search },
	{ "delete", T_extinst, T_exti_delete },
	{ "merge", T_extinst, T_exti_merge },
	{ "auto", T_extinst, T_exti_auto },
	{ "new", T_extinst, T_exti_new },
	{ "unnew", T_extinst, T_exti_unnew },
	{ "fload", T_extinst, T_exti_fload },
	{ "fsave", T_extinst, T_exti_fsave },
	{ "reset", T_extinst, T_exti_reset },
	{ "system", T_extinst, T_exti_system },
	{ "env", T_extinst, T_exti_env },
	{ "renum", T_extinst, T_exti_renum },
	{ "multi", T_extinst, T_exti_multi },
	{ "full", T_extinst, T_exti_full },
	{ "grab", T_extinst, T_exti_grab },
	{ "list", T_extinst, T_exti_list },
	{ "llist", T_extinst, T_exti_llist },
	{ "hexa", T_extinst, T_exti_hexa },
	{ "accload", T_extinst, T_exti_accload },
	{ "accnew", T_extinst, T_exti_accnew },
	{ "lower", T_extinst, T_exti_lower },
	{ "upper", T_extinst, T_exti_upper },
	{ "english", T_extinst, T_exti_english },
	{ "francais", T_extinst, T_exti_francais },
	{ NULL, 0, 0 }
};

static struct extension const external_extensions[] = {
	/* Compact: 2 commands */
	{ 'A', 0x80, 0, "unpack" },
	{ 'A', 0x81, 0, "pack" },

	/* STOS Compiler: 5 commands */
	{ 'C', 0x80, 0, "run" },
	{ 'C', 0x81, 0, "compad" },
	{ 'C', 0x82, 0, "comptest off" },
	{ 'C', 0x84, 0, "comptest on" },
	{ 'C', 0x86, 0, "comptest always" },
	{ 'C', 0x88, 0, "comptest" },

	/* STOS Maestro: 20 commands */
	{ 'D', 0x80, 0, "sound init" },
	{ 'D', 0x81, 0, "sample" },
	{ 'D', 0x82, 0, "samplay" },
	{ 'D', 0x83, 0, "samplace" },
	{ 'D', 0x84, 0, "samspeed manual" },
	{ 'D', 0x86, 0, "samspeed auto" },
	{ 'D', 0x88, 0, "samspeed" },
	{ 'D', 0x8a, 0, "samstop" },
	{ 'D', 0x8c, 0, "samloop off" },
	{ 'D', 0x8e, 0, "samloop on" },
	{ 'D', 0x90, 0, "samdir forward" },
	{ 'D', 0x92, 0, "samdir backward" },
	{ 'D', 0x94, 0, "samsweep on" },
	{ 'D', 0x96, 0, "samsweep off" },
	{ 'D', 0x98, 0, "samraw" },
	{ 'D', 0x9a, 0, "samrecord" },
	{ 'D', 0x9c, 0, "samcopy" },
	{ 'D', 0x9e, 0, "sammusic" },
	{ 'D', 0xa2, 0, "samthru" },
	{ 'D', 0xa4, 0, "sambank" },

	/* STOS Squasher: 2 commands */
	{ 'E', 0x80, 0, "unsquash" },
	{ 'E', 0x81, 0, "squash" },

	/* STE extension: 35 commands */
	{ 'F', 0x80, 0, "sticks on" },
	{ 'F', 0x81, 0, "stick1" },
	{ 'F', 0x82, 0, "sticks off" },
	{ 'F', 0x83, 0, "stick2" },
	{ 'F', 0x84, 0, "dac convert" },
	{ 'F', 0x85, 0, "l stick" },
	{ 'F', 0x86, 0, "dac raw" },
	{ 'F', 0x87, 0, "r stick" },
	{ 'F', 0x88, 0, "dac speed" },
	{ 'F', 0x89, 0, "u stick" },
	{ 'F', 0x8a, 0, "dac stop" },
	{ 'F', 0x8b, 0, "d stick" },
	{ 'F', 0x8c, 0, "dac m volume" },
	{ 'F', 0x8d, 0, "f stick" },
	{ 'F', 0x8e, 0, "dac l volume" },
	{ 'F', 0x8f, 0, "light x" },
	{ 'F', 0x90, 0, "dac r volume" },
	{ 'F', 0x91, 0, "light y" },
	{ 'F', 0x92, 0, "dac treble" },
	{ 'F', 0x93, 0, "ste" },
	{ 'F', 0x94, 0, "dac bass" },
	{ 'F', 0x95, 0, "e color" },
	{ 'F', 0x96, 0, "dac mix on" },
	{ 'F', 0x97, 0, "hard physic" },
	{ 'F', 0x98, 0, "dac mix off" },
	/* 0x99 unused */
	{ 'F', 0x9a, 0, "dac mono" },
	/* 0x9b unused */
	{ 'F', 0x9c, 0, "dac stereo" },
	/* 0x9d unused */
	{ 'F', 0x9e, 0, "dac loop on" },
	/* 0x9f unused */
	{ 'F', 0xa0, 0, "dac loop off" },
	/* 0xa1 unused */
	{ 'F', 0xa2, 0, " e palette" },
	/* 0xa3 unused */
	{ 'F', 0xa4, 0, "e colour" },
	/* 0xa5 unused */
	{ 'F', 0xa6, 0, "hard screen size" },
	/* 0xa7 unused */
	{ 'F', 0xa8, 0, "hard screen offset" },
	/* 0xa9 unused */
	{ 'F', 0xaa, 0, "hard screen offset" },
	/* 0xab unused */
	{ 'F', 0xac, 0, "hard screen offset" },

	/* Blitter Extension. v 1.1 by Ambrah */
	{ 'G', 0x80, 0, "blit halftone" },
	{ 'G', 0x81, 0, "blit busy" },
	{ 'G', 0x82, 0, "blit source x inc" },
	{ 'G', 0x83, 0, "blitter" },
	{ 'G', 0x84, 0, "blit source y inc" },
	{ 'G', 0x85, 0, "blit remain" },
	{ 'G', 0x86, 0, "blit source address" },
	/* 0x87 unused */
	{ 'G', 0x88, 0, "blit dest x inc" },
	/* 0x89 unused */
	{ 'G', 0x8a, 0, "blit dest y inc" },
	/* 0x8b unused */
	{ 'G', 0x8c, 0, "blit dest address" },
	/* 0x8d unused */
	{ 'G', 0x8e, 0, "blit endmask 1" },
	/* 0x8f unused */
	{ 'G', 0x90, 0, "blit endmask 2" },
	/* 0x91 unused */
	{ 'G', 0x92, 0, "blit endmask 3" },
	/* 0x93 unused */
	{ 'G', 0x94, 0, "blit x count" },
	/* 0x95 unused */
	{ 'G', 0x96, 0, "blit y count" },
	/* 0x97 unused */
	{ 'G', 0x98, 0, "blit hop" },
	/* 0x99 unused */
	{ 'G', 0x9a, 0, "blit op" },
	/* 0x9b unused */
	{ 'G', 0x9c, 0, "blit h line" },
	/* 0x9d unused */
	{ 'G', 0x9e, 0, "blit smudge" },
	/* 0x9f unused */
	{ 'G', 0xa0, 0, "blit hog" },
	/* 0xa1 unused */
	{ 'G', 0xa2, 0, " blit it" },
	/* 0xa3 unused */
	{ 'G', 0xa4, 0, "blit skew" },
	/* 0xa5 unused */
	{ 'G', 0xa6, 0, "blit nfsr" },
	/* 0xa7 unused */
	{ 'G', 0xa8, 0, "blit fxsr" },
	/* 0xa9 unused */
	{ 'G', 0xaa, 0, "blit cls" },
	/* 0xab unused */
	{ 'G', 0xac, 0, "blit copy" },
	/* 0xad unused */
	{ 'G', 0xae, 0, "about blitter" },

	/* STORM/GBP blitter extension: 18 commands */
	{ 'G', 0x80, 0, "blit sinc" },
	{ 'G', 0x81, 0, "blit clr" },
	{ 'G', 0x82, 0, "blit dinc" },
	{ 'G', 0x83, 0, "blit fskopy" },
	{ 'G', 0x84, 0, "blit address" },
	/* 0x85 unused */
	{ 'G', 0x86, 0, "blit mask" },
	/* 0x87 unused */
	{ 'G', 0x88, 0, "blit count" },
	/* 0x89 unused */
	{ 'G', 0x8a, 0, "blit hop" },
	/* 0x8b unused */
	{ 'G', 0x8c, 0, "blit op" },
	/* 0x8d unused */
	{ 'G', 0x8e, 0, "blit skew" },
	/* 0x8f unused */
	{ 'G', 0x90, 0, "blit nfsr" },
	/* 0x91 unused */
	{ 'G', 0x92, 0, "blit fxsr" },
	/* 0x93 unused */
	{ 'G', 0x94, 0, "blit line" },
	/* 0x95 unused */
	{ 'G', 0x96, 0, "blit smudge" },
	/* 0x97 unused */
	{ 'G', 0x98, 0, "blit hog" },
	/* 0x99 unused */
	{ 'G', 0x9a, 0, "blit it" },
	/* 0x9b unused */
	{ 'G', 0x9c, 0, "fcopy" },
	/* 0x9c unused */
	{ 'G', 0x9d, 0, "cls" },

	/* Stars: 4 commands */
	{ 'H', 0x80, 0, "set stars" },
	/* 0x81 unused */
	{ 'H', 0x82, 0, "go stars" },
	/* 0x83 unused */
	{ 'H', 0x84, 0, "wipe stars on" },
	/* 0x85 unused */
	{ 'H', 0x86, 0, "wipe stars off" },

	/* GEM text */
	{ 'L', 0x80, 0, "gemtext init" },
	{ 'L', 0x81, 0, "gemfont name$" },
	{ 'L', 0x82, 0, "gemtext color" },
	{ 'L', 0x83, 0, "gemfont cellwidth" },
	{ 'L', 0x84, 0, "gemtext mode" },
	{ 'L', 0x85, 0, "gemfont cellheight" },
	{ 'L', 0x86, 0, "gemtext style" },
	{ 'L', 0x87, 0, "gemtext stringwidth" },
	{ 'L', 0x88, 0, "gemtext angle" },
	{ 'L', 0x89, 0, "gemfont convert" },
	{ 'L', 0x8a, 0, "gemtext font" },
	{ 'L', 0x8b, 0, "gemfont info" },
	{ 'L', 0x8c, 0, "gemtext scale" },
	/* 0x8d unused */
	{ 'L', 0x8e, 0, "gemtext" },
	/* 0x8f unused */
	{ 'L', 0x90, 0, "gemfont load" },
	/* 0x91 unused */
	{ 'L', 0x92, 0, "gemfont cmds" },

	/* Misty: 21 commands */
	{ 'M', 0x80, 0, "fastcopy" },
	{ 'M', 0x81, 0, "col" },
	{ 'M', 0x82, 0, "floprd" },
	{ 'M', 0x83, 0, "mediach" },
	{ 'M', 0x84, 0, "flopwrt" },
	{ 'M', 0x85, 0, "hardkey" },
	{ 'M', 0x86, 0, "dot" },
	{ 'M', 0x87, 0, "ndrv" },
	{ 'M', 0x88, 0, "mouseoff" },
	{ 'M', 0x89, 0, "freq" },
	{ 'M', 0x8a, 0, "mouseon" },
	{ 'M', 0x8b, 0, "resvalid" },
	{ 'M', 0x8c, 0, "skopy" },
	{ 'M', 0x8d, 0, "aesin" },
	{ 'M', 0x8e, 0, "setrtim" },
	{ 'M', 0x8f, 0, "rtim" },
	{ 'M', 0x90, 0, "warmboot" },
	{ 'M', 0x91, 0, "blitter" },
	{ 'M', 0x92, 0, "silence" },
	{ 'M', 0x93, 0, "kbshift" },
	{ 'M', 0x94, 0, "kopy" },

	/* MIDI: 5 commands */
	{ 'M', 0x80, 0, "midi on" },
	{ 'M', 0x81, 0, "midi in" },
	{ 'M', 0x82, 0, "midi off" },
	/* 0x83 unused */
	{ 'M', 0x84, 0, "midi out" },
	/* 0x85 unused */
	{ 'M', 0x86, 0, "about musician" },

	/* GBP: 32 commands */
	{ 'P', 0x80, 0, "lights on" },
	{ 'P', 0x81, 0, "pready" },
	{ 'P', 0x82, 0, "lights off" },
	{ 'P', 0x83, 0, "xpen" },
	{ 'P', 0x84, 0, "fastwipe" },
	{ 'P', 0x85, 0, "paktype" },
	{ 'P', 0x86, 0, "dac volume" },
	{ 'P', 0x87, 0, "even" },
	{ 'P', 0x88, 0, "setpal" },
	{ 'P', 0x89, 0, "setprt" },
	{ 'P', 0x8a, 0, "d crunch" },
	{ 'P', 0x8b, 0, "eplace" },
	{ 'P', 0x8c, 0, "elite unpack" },
	{ 'P', 0x8d, 0, "foffset" },
	{ 'P', 0x8e, 0, "estop" },
	{ 'P', 0x8f, 0, "jar" },
	{ 'P', 0x90, 0, "mirror" },
	{ 'P', 0x91, 0, "percent" },
	{ 'P', 0x92, 0, "tiny unpack" },
	{ 'P', 0x93, 0, "paksize" },
	{ 'P', 0x94, 0, "treble" },
	{ 'P', 0x95, 0, "special key" },
	{ 'P', 0x96, 0, "bass" },
	{ 'P', 0x97, 0, "fstart" },
	{ 'P', 0x98, 0, "hcopy" },
	{ 'P', 0x99, 0, "flength" },
	{ 'P', 0x9a, 0, "ca unpack" },
	{ 'P', 0x9b, 0, "ca pack" },
	{ 'P', 0x9c, 0, "bcls" },
	{ 'P', 0x9d, 0, "cookie" },
	{ 'P', 0x9e, 0, "eplay" },
	{ 'P', 0x9f, 0, "ypen" },

	/* Protracker: 3 commands */
	{ 'P', 0x80, 0, "propack" },
	{ 'P', 0x81, 0, "mpack" },
	{ 'P', 0x83, 0, "munpack" },

	/* Missing Link: 33 commands (link1) */
	{ 'Q', 0x80, 0, "landscape" },
	{ 'Q', 0x81, 0, "overlap" },
	{ 'Q', 0x82, 0, "bob" },
	{ 'Q', 0x83, 0, "map toggle" },
	{ 'Q', 0x84, 0, "wipe" },
	{ 'Q', 0x85, 0, "boundary" },
	{ 'Q', 0x86, 0, "tile" },
	{ 'Q', 0x87, 0, "palt" },
	{ 'Q', 0x88, 0, "world" },
	{ 'Q', 0x89, 0, "musauto" },
	{ 'Q', 0x8a, 0, "musplay" },
	{ 'Q', 0x8b, 0, "which block" },
	{ 'Q', 0x8c, 0, "relocate" },
	{ 'Q', 0x8d, 0, "p left" },
	{ 'Q', 0x8e, 0, "p on" },
	{ 'Q', 0x8f, 0, "p joy" },
	{ 'Q', 0x90, 0, "p stop" },
	{ 'Q', 0x91, 0, "p up" },
	{ 'Q', 0x92, 0, "set block" },
	{ 'Q', 0x93, 0, "p right" },
	{ 'Q', 0x94, 0, "palsplit" },
	{ 'Q', 0x95, 0, "p down" },
	{ 'Q', 0x96, 0, "floodpal" },
	{ 'Q', 0x97, 0, "p fire" },
	{ 'Q', 0x98, 0, "digi play" },
	{ 'Q', 0x99, 0, "string" },
	{ 'Q', 0x9a, 0, "samsign" },
	{ 'Q', 0x9b, 0, "depack" },
	{ 'Q', 0x9c, 0, "replace blocks" },
	{ 'Q', 0x9d, 0, "dload" },
	{ 'Q', 0x9e, 0, "display pc1" },
	{ 'Q', 0x9f, 0, "dsave" },
	{ 'Q', 0xa0, 0, "honesty" },

	/* Ninja Tracker: 9 commands */
	{ 'Q', 0x80, 0, "track play" },
	{ 'Q', 0x81, 0, "vu meter" },
	{ 'Q', 0x82, 0, "track frequency" },
	{ 'Q', 0x83, 0, "track pos" },
	{ 'Q', 0x84, 0, "track info" },
	{ 'Q', 0x85, 0, "track pattern" },
	/* 0x86 unused */
	{ 'Q', 0x87, 0, "track key" },
	{ 'Q', 0x88, 0, "track unpack" },
	{ 'Q', 0x89, 0, "track name" },

	/* Missing L0, ink: 28 commands (link2) */
	{ 'R', 0x80, 0, "joey" },
	{ 'R', 0x81, 0, "b height" },
	{ 'R', 0x82, 0, "blit" },
	{ 'R', 0x83, 0, "b width" },
	{ 'R', 0x84, 0, "spot" },
	{ 'R', 0x85, 0, "block amount" },
	{ 'R', 0x86, 0, "reflect" },
	{ 'R', 0x87, 0, "compstate" },
	{ 'R', 0x88, 0, "mozaic" },
	{ 'R', 0x89, 0, "x limit" },
	{ 'R', 0x8a, 0, "xy block" },
	{ 'R', 0x8b, 0, "y limit" },
	{ 'R', 0x8c, 0, "text" },
	{ 'R', 0x8d, 0, "mostly harmless" },
	{ 'R', 0x8e, 0, "wash" },
	{ 'R', 0x8f, 0, "real length" },
	{ 'R', 0x90, 0, "reboot" },
	{ 'R', 0x91, 0, "brightest" },
	{ 'R', 0x92, 0, "bank load" },
	{ 'R', 0x93, 0, "bank length" },
	{ 'R', 0x94, 0, "bank copy" },
	{ 'R', 0x95, 0, "bank size" },
	{ 'R', 0x96, 0, "m blit" },
	{ 'R', 0x97, 0, "win block amount" },
	{ 'R', 0x98, 0, "replace range" },
	{ 'R', 0x99, 0, "empty" },
	{ 'R', 0x9a, 0, "win replace blocks" },
	{ 'R', 0x9b, 0, "empty2" },
	{ 'R', 0x9c, 0, "win replace range" },
	{ 'R', 0x9d, 0, "empty3" },
	{ 'R', 0x9e, 0, "win xy block" },

	/* Missing Link: 13 commands (link3) */
	{ 'S', 0x80, 0, "many add" },
	{ 'S', 0x81, 0, "many overlap" },
	{ 'S', 0x82, 0, "many sub" },
	{ 'S', 0x83, 0, "function2" },
	{ 'S', 0x84, 0, "many bob" },
	{ 'S', 0x85, 0, "function3" },
	{ 'S', 0x86, 0, "many joey" },
	{ 'S', 0x87, 0, "hertz" },
	{ 'S', 0x88, 0, "set hertz" },
	{ 'S', 0x89, 0, "function4" },
	{ 'S', 0x8a, 0, "many inc" },
	{ 'S', 0x8b, 0, "function5" },
	{ 'S', 0x8c, 0, "many dec" },
	{ 'S', 0x8d, 0, "function6" },
	{ 'S', 0x8e, 0, "raster" },
	{ 'S', 0x8f, 0, "function7" },
	{ 'S', 0x90, 0, "bullet" },
	{ 'S', 0x91, 0, "function8" },
	{ 'S', 0x92, 0, "many bullet" },
	{ 'S', 0x93, 0, "function9" },
	{ 'S', 0x94, 0, "many spot" },

	/* STOS 3D: 59 commands */
	{ 'S', 0x80, 0, "td priority" },
	{ 'S', 0x81, 0, "td visible" },
	{ 'S', 0x82, 0, "td load" },
	{ 'S', 0x83, 0, "td range" },
	{ 'S', 0x84, 0, "td clear all" },
	{ 'S', 0x85, 0, "td position x" },
	{ 'S', 0x86, 0, "td object" },
	{ 'S', 0x87, 0, "td position y" },
	{ 'S', 0x88, 0, "td screen height" },
	{ 'S', 0x89, 0, "td position z" },
	{ 'S', 0x8a, 0, "td kill" },
	{ 'S', 0x8b, 0, "td attitude a" },
	{ 'S', 0x8c, 0, "td move x" },
	{ 'S', 0x8d, 0, "td attitude b" },
	{ 'S', 0x8e, 0, "td move y" },
	{ 'S', 0x8f, 0, "td attitude b" },
	{ 'S', 0x90, 0, "td move z" },
	{ 'S', 0x91, 0, "td collide" },
	{ 'S', 0x92, 0, "td move rel" },
	{ 'S', 0x93, 0, "td zone x" },
	{ 'S', 0x94, 0, "td move" },
	{ 'S', 0x95, 0, "td zone y" },
	{ 'S', 0x96, 0, "td angle a" },
	{ 'S', 0x97, 0, "td zone z" },
	{ 'S', 0x98, 0, "td angle b" },
	{ 'S', 0x99, 0, "td zone r" },
	{ 'S', 0x9a, 0, "td angle c" },
	{ 'S', 0x9b, 0, "td world x" },
	{ 'S', 0x9c, 0, "td angle rel" },
	{ 'S', 0x9d, 0, "td world y" },
	{ 'S', 0x9e, 0, "td angle" },
	{ 'S', 0x9f, 0, "td world z" },
	/* 0xa0 unused */
	{ 'S', 0xa1, 0, "td view x" },
	{ 'S', 0xa2, 0, "td delete zone" },
	{ 'S', 0xa3, 0, "td view y" },
	{ 'S', 0xa4, 0, "td redraw" },
	{ 'S', 0xa5, 0, "td view z" },
	{ 'S', 0xa6, 0, "td set zone" },
	{ 'S', 0xa7, 0, "td screen x" },
	{ 'S', 0xa8, 0, "td cls" },
	{ 'S', 0xa9, 0, "td screen y" },
	{ 'S', 0xaa, 0, "td background" },
	{ 'S', 0xab, 0, "td bearing a" },
	{ 'S', 0xac, 0, "td dir" },
	{ 'S', 0xad, 0, "td bearing b" },
	{ 'S', 0xae, 0, "td set colour" },
	{ 'S', 0xaf, 0, "td bearing r" },
	{ 'S', 0xb0, 0, "td anim rel" },
	{ 'S', 0xb1, 0, "td anim point x" },
	{ 'S', 0xb2, 0, "td init" },
	{ 'S', 0xb3, 0, "td anim point y" },
	{ 'S', 0xb4, 0, "td face" },
	{ 'S', 0xb5, 0, "td anim point z" },
	{ 'S', 0xb6, 0, "td forward" },
	{ 'S', 0xb7, 0, "td advanced" },
	/* 0xb8 unused */
	{ 'S', 0xb9, 0, "td debug" },
	{ 'S', 0xba, 0, "td anim" },
	/* 0xbb unused */
	{ 'S', 0xbc, 0, "td surface points" },
	/* 0xbd unused */
	{ 'S', 0xbe, 0, "td surface" },

	/* STOS Tracker: 9 commands (track_7/track_14) */
	{ 'S', 0x80, 0, "track load" },
	{ 'S', 0x81, 0, "track scan" },
	{ 'S', 0x82, 0, "track bank" },
	{ 'S', 0x83, 0, "track vu" },
	{ 'S', 0x84, 0, "track play" },
	/* 0x85 unused */
	{ 'S', 0x86, 0, "track key" },
	/* 0x87 unused */
	{ 'S', 0x88, 0, "track volume" },
	/* 0x89 unused */
	{ 'S', 0x8a, 0, "track tempo" },
	/* 0x8b unused */
	{ 'S', 0x8c, 0, "track stop" },

	/* STOS Tracker: 9 commands (track_10) */
	{ 'T', 0x80, 0, "track load" },
	{ 'T', 0x81, 0, "track scan" },
	{ 'T', 0x82, 0, "track bank" },
	{ 'T', 0x83, 0, "track vu" },
	{ 'T', 0x84, 0, "track play" },
	/* 0x85 unused */
	{ 'T', 0x86, 0, "track key" },
	/* 0x87 unused */
	{ 'T', 0x88, 0, "track volume" },
	/* 0x89 unused */
	{ 'T', 0x8a, 0, "track tempo" },
	/* 0x8b unused */
	{ 'T', 0x8c, 0, "track stop" },

	/* 3D menu */
	{ 'U', 0x80, 0, "_fmenu init" },
	{ 'U', 0x81, 0, "_fmenu select" },
	{ 'U', 0x82, 0, "_fmenu on" },
	{ 'U', 0x83, 0, "_fmenu item" },
	{ 'U', 0x84, 0, "_fmenu$ off" },
	{ 'U', 0x85, 0, "_fmenu height" },
	{ 'U', 0x86, 0, "_fmenu$ on" },
	/* 0x87 unused */
	{ 'U', 0x88, 0, "_fmenu$" },
	/* 0x89 unused */
	{ 'U', 0x8a, 0, "_fmenu kill" },
	/* 0x8b unused */
	{ 'U', 0x8c, 0, "_fmenu freeze" },
	/* 0x8d unused */
	{ 'U', 0x8e, 0, "_fmenu uncheck item" },
	/* 0x8f unused */
	{ 'U', 0x90, 0, "_fmenu check item" },
	{ 'U', 0x91, 0, "_form alert" },
	{ 'U', 0x92, 0, "_fmenu cmds" },

	/* Falcon gfx3 */
	{ 'V', 0x80, 0, "_falc pen" },
	{ 'V', 0x81, 0, "_falc xcurs" },
	{ 'V', 0x82, 0, "_falc paper" },
	{ 'V', 0x83, 0, "_falc ycurs" },
	{ 'V', 0x84, 0, "_falc locate" },
	{ 'V', 0x85, 0, "_stos charwidth" },
	{ 'V', 0x86, 0, "_falc print" },
	{ 'V', 0x87, 0, "_stos charheight" },
	{ 'V', 0x88, 0, "_stosfont" },
	{ 'V', 0x89, 0, "_falc multipen status" },
	{ 'V', 0x8a, 0, "_falc multipen off" },
	{ 'V', 0x8b, 0, "_charset addr" },
	{ 'V', 0x8c, 0, "_falc multipen on" },
	{ 'V', 0x8d, 0, "_tc rgb" },
	{ 'V', 0x8e, 0, "_falc ink" },
	/* 0x8f unused */
	{ 'V', 0x90, 0, "_falc draw mode" },
	{ 'V', 0x91, 0, "_get pixel" },
	{ 'V', 0x92, 0, "_def linepattern" },
	/* 0x93 unused */
	{ 'V', 0x94, 0, "_def stipple" },
	/* 0x95 unused */
	{ 'V', 0x96, 0, "_falc plot" },
	/* 0x97 unused */
	{ 'V', 0x98, 0, "_falc line" },
	/* 0x99 unused */
	{ 'V', 0x9a, 0, "_falc box" },
	/* 0x9b unused */
	{ 'V', 0x9c, 0, "_falc bar" },
	/* 0x9d unused */
	{ 'V', 0x9e, 0, "_falc polyline" },
	/* 0x9f unused */
	{ 'V', 0xa0, 0, "_falc centre" },
	/* 0xa1 unused */
	{ 'V', 0xa2, 0, "_falc polyfill" },
	/* 0xa3 unused */
	{ 'V', 0xa4, 0, "_falc contourfill" },
	/* 0xa5 unused */
	{ 'V', 0xa6, 0, "_falc circle" },
	/* 0xa7 unused */
	{ 'V', 0xa8, 0, "_falc ellipse" },
	/* 0xa9 unused */
	{ 'V', 0xaa, 0, "_falc earc" },
	/* 0xab unused */
	{ 'V', 0xac, 0, "_falc arc" },

	/* Control: 61 commands */
	{ 'W', 0x80, EXTIF_CONTROL, "switch on" },
	{ 'W', 0x81, EXTIF_CONTROL, "case" },
	{ 'W', 0x82, EXTIF_CONTROL, "switch off" },
	{ 'W', 0x83, EXTIF_CONTROL, "otherwise" },
	{ 'W', 0x84, EXTIF_CONTROL, "cmove" },
	/* 0x85 unused */
	{ 'W', 0x86, EXTIF_CONTROL, "write" },
	{ 'W', 0x87, EXTIF_CONTROL, "parallel" },
	{ 'W', 0x88, EXTIF_CONTROL, "cremember" },
	{ 'W', 0x89, EXTIF_CONTROL, "para fire" },
	{ 'W', 0x8a, EXTIF_CONTROL, "crecall" },
	{ 'W', 0x8b, EXTIF_CONTROL, "add" },
	{ 'W', 0x8c, EXTIF_CONTROL, "ctrl" },
	{ 'W', 0x8d, EXTIF_CONTROL, "test megazone" },
	{ 'W', 0x8e, EXTIF_CONTROL, "para on" },
	{ 'W', 0x8f, EXTIF_CONTROL, "para up" },
	{ 'W', 0x90, EXTIF_CONTROL, "para off" },
	{ 'W', 0x91, EXTIF_CONTROL, "para down" },
	{ 'W', 0x92, EXTIF_CONTROL, "init megazone" },
	{ 'W', 0x93, EXTIF_CONTROL, "para left" },
	{ 'W', 0x94, EXTIF_CONTROL, "set megazone" },
	{ 'W', 0x95, EXTIF_CONTROL, "klatu" },
	{ 'W', 0x96, EXTIF_CONTROL, "range megazone" },
	{ 'W', 0x97, EXTIF_CONTROL, "exist$" },
	{ 'W', 0x98, EXTIF_CONTROL, "map write" },
	/* 0x99 unused */
	{ 'W', 0x9a, EXTIF_CONTROL, "spread" },
	{ 'W', 0x9b, EXTIF_CONTROL, "para right" },
	{ 'W', 0x9c, EXTIF_CONTROL, "brdr remove" },
	{ 'W', 0x9d, EXTIF_CONTROL, "crack pac" },
	{ 'W', 0x9e, EXTIF_CONTROL, "crack unpac" },
	{ 'W', 0x9f, EXTIF_CONTROL, "map address" },
	{ 'W', 0xa0, EXTIF_CONTROL, "quick screen" },
	{ 'W', 0xa1, EXTIF_CONTROL, "klatu" },
	{ 'W', 0xa2, EXTIF_CONTROL, "font" },
	{ 'W', 0xa3, EXTIF_CONTROL, "map h" },
	{ 'W', 0xa4, EXTIF_CONTROL, "image put" },
	{ 'W', 0xa5, EXTIF_CONTROL, "map w" },
	{ 'W', 0xa6, EXTIF_CONTROL, "screen size" },
	{ 'W', 0xa7, EXTIF_CONTROL, "klatu" },
	{ 'W', 0xa8, EXTIF_CONTROL, "hscroll" },
	{ 'W', 0xa9, EXTIF_CONTROL, "image width" },
	{ 'W', 0xaa, EXTIF_CONTROL, "image palette" },
	{ 'W', 0xab, EXTIF_CONTROL, "image height" },
	{ 'W', 0xac, EXTIF_CONTROL, "many image" },
	{ 'W', 0xad, EXTIF_CONTROL, "map read" },
	{ 'W', 0xae, EXTIF_CONTROL, "set clip" },
	{ 'W', 0xaf, EXTIF_CONTROL, "klatu" },
	{ 'W', 0xb0, EXTIF_CONTROL, "turbocopy" },
	{ 'W', 0xb1, EXTIF_CONTROL, "klatu" },
	{ 'W', 0xb2, EXTIF_CONTROL, "bigcls" },
	{ 'W', 0xb3, EXTIF_CONTROL, "inside" },
	{ 'W', 0xb4, EXTIF_CONTROL, "bigcopy" },
	{ 'W', 0xb5, EXTIF_CONTROL, "image collide" },
	{ 'W', 0xb6, EXTIF_CONTROL, "screen offset" },
	{ 'W', 0xb7, EXTIF_CONTROL, "image mcollide" },
	{ 'W', 0xb8, EXTIF_CONTROL, "cylinder" },
	{ 'W', 0xb9, EXTIF_CONTROL, "klatu" },
	{ 'W', 0xba, EXTIF_CONTROL, "image map" },
	{ 'W', 0xbb, EXTIF_CONTROL, "jagjoy" },
	{ 'W', 0xbc, EXTIF_CONTROL, "set map" },
	{ 'W', 0xbd, EXTIF_CONTROL, "klatu" },
	{ 'W', 0xbe, EXTIF_CONTROL, "image offset" },

	/* Falcon sys_ctrl extension */
	{ 'W', 0x80, EXTIF_SYSCTRL, "coldboot" },
	{ 'W', 0x81, EXTIF_SYSCTRL, "cookieptr" },
	{ 'W', 0x82, EXTIF_SYSCTRL, "warmboot" },
	{ 'W', 0x83, EXTIF_SYSCTRL, "cookie" },
	{ 'W', 0x84, EXTIF_SYSCTRL, "caps on" },
	{ 'W', 0x85, EXTIF_SYSCTRL, "_tos$" },
	{ 'W', 0x86, EXTIF_SYSCTRL, "caps off" },
	{ 'W', 0x87, EXTIF_SYSCTRL, "_phystop" },
	{ 'W', 0x88, EXTIF_SYSCTRL, "_cpuspeed" },
	{ 'W', 0x89, EXTIF_SYSCTRL, "_memtop" },
	{ 'W', 0x8a, EXTIF_SYSCTRL, "_blitterspeed" },
	{ 'W', 0x8b, EXTIF_SYSCTRL, "_busmode" },
	{ 'W', 0x8c, EXTIF_SYSCTRL, "_stebus" },
	{ 'W', 0x8d, EXTIF_SYSCTRL, "paddle x" },
	{ 'W', 0x8e, EXTIF_SYSCTRL, "_falconbus" },
	{ 'W', 0x8f, EXTIF_SYSCTRL, "paddle y" },
	{ 'W', 0x90, EXTIF_SYSCTRL, "_cpucache on" },
	{ 'W', 0x91, EXTIF_SYSCTRL, "_cpucache stat" },
	{ 'W', 0x92, EXTIF_SYSCTRL, "_cpucache off" },
	{ 'W', 0x93, EXTIF_SYSCTRL, "lpen x" },
	{ 'W', 0x94, EXTIF_SYSCTRL, "ide on" },
	{ 'W', 0x95, EXTIF_SYSCTRL, "lpen y" },
	{ 'W', 0x96, EXTIF_SYSCTRL, "ide off" },
	{ 'W', 0x97, EXTIF_SYSCTRL, "_nemesis" },
	{ 'W', 0x98, EXTIF_SYSCTRL, "_set printer" },
	{ 'W', 0x99, EXTIF_SYSCTRL, "_printer ready" },
	{ 'W', 0x9a, EXTIF_SYSCTRL, "_file attr" },
	{ 'W', 0x9b, EXTIF_SYSCTRL, "kbshift" },
	{ 'W', 0x9c, EXTIF_SYSCTRL, "code$" },
	{ 'W', 0x9d, EXTIF_SYSCTRL, "_aes in" },
	{ 'W', 0x9e, EXTIF_SYSCTRL, "uncode$" },
	{ 'W', 0x9f, EXTIF_SYSCTRL, "_file exist" },
	/* 0xa0 unused */
	{ 'W', 0xa1, EXTIF_SYSCTRL, "_add cbound" },
	{ 'W', 0xa2, EXTIF_SYSCTRL, "lset$" },
	{ 'W', 0xa3, EXTIF_SYSCTRL, "_sub cbound" },
	{ 'W', 0xa4, EXTIF_SYSCTRL, "rset$" },
	{ 'W', 0xa5, EXTIF_SYSCTRL, "_add ubound" },
	{ 'W', 0xa6, EXTIF_SYSCTRL, "st mouse on" },
	{ 'W', 0xa7, EXTIF_SYSCTRL, "_sub lbound" },
	{ 'W', 0xa8, EXTIF_SYSCTRL, "st mouse off" },
	{ 'W', 0xa9, EXTIF_SYSCTRL, "odd" },
	{ 'W', 0xaa, EXTIF_SYSCTRL, "st mouse colour" },
	{ 'W', 0xab, EXTIF_SYSCTRL, "even" },
	{ 'W', 0xac, EXTIF_SYSCTRL, "_limit st mouse" },
	{ 'W', 0xad, EXTIF_SYSCTRL, "st mouse stat" },
	{ 'W', 0xae, EXTIF_SYSCTRL, "st mouse" },
	{ 'W', 0xaf, EXTIF_SYSCTRL, "_fileselect$" },
	/* 0xb0 unused */
	{ 'W', 0xb1, EXTIF_SYSCTRL, "_jagpad direction" },
	/* 0xb2 unused */
	{ 'W', 0xb3, EXTIF_SYSCTRL, "_jagpad fire" },
	/* 0xb4 unused */
	{ 'W', 0xb5, EXTIF_SYSCTRL, "_jagpad pause" },
	/* 0xb6 unused */
	{ 'W', 0xb7, EXTIF_SYSCTRL, "_jagpad option" },
	/* 0xb8 unused */
	{ 'W', 0xb9, EXTIF_SYSCTRL, "_jagpad key$" },
	{ 'W', 0xba, EXTIF_SYSCTRL, "sys cmds" },

	/* Falcon video */
	{ 'X', 0x80, 0, "vsetmode" },
	{ 'X', 0x81, 0, "vgetmode" },
	{ 'X', 0x82, 0, "_falc cls" },
	{ 'X', 0x83, 0, "vgetsize" },
	{ 'X', 0x84, 0, "vgetpalt" },
	{ 'X', 0x85, 0, "montype" },
	{ 'X', 0x86, 0, "vsetpalt" },
	{ 'X', 0x87, 0, "whichmode" },
	{ 'X', 0x88, 0, "_get spritepalette" },
	{ 'X', 0x89, 0, "scr width" },
	{ 'X', 0x8a, 0, "_hardphysic" },
	{ 'X', 0x8b, 0, "scr height" },
	{ 'X', 0x8c, 0, "_setcolour" },
	{ 'X', 0x8d, 0, "_getcolour" },
	{ 'X', 0x8e, 0, "_get st palette" },
	{ 'X', 0x8f, 0, "_falc rgb" },
	{ 'X', 0x90, 0, "palfade in" },
	{ 'X', 0x91, 0, "_falc palt" },
	{ 'X', 0x92, 0, "palfade out" },
	{ 'X', 0x93, 0, "darkest" },
	{ 'X', 0x94, 0, "quickwipe" },
	{ 'X', 0x95, 0, "brightest" },
	{ 'X', 0x96, 0, "ilbmpalt" },
	{ 'X', 0x97, 0, "_get red" },
	{ 'X', 0x98, 0, "_shift off" },
	{ 'X', 0x99, 0, "_get green" },
	{ 'X', 0x9a, 0, "_shift" },
	{ 'X', 0x9b, 0, "_get blue" },
	/* 0x9c unused */
	{ 'X', 0x9d, 0, "vget ilbm mode" },
	/* 0x9e unused */
	{ 'X', 0x9f, 0, "dpack ilbm" },
	/* 0xa0 unused */
	{ 'X', 0xa1, 0, "fmchunk" },
	/* 0xa2 unused */
	{ 'X', 0xa3, 0, "_falc zone" },
	/* 0xa4 unused */
	{ 'X', 0xa5, 0, "ilbmchunk" },
	{ 'X', 0xa6, 0, "_reset falc zone" },
	{ 'X', 0xa7, 0, "bmhdchunk" },
	{ 'X', 0xa8, 0, "_set falc zone" },
	{ 'X', 0xa9, 0, "cmapchunk" },
	{ 'X', 0xaa, 0, "_paste pi1" },
	{ 'X', 0xab, 0, "bodychunk" },
	{ 'X', 0xac, 0, "_bitblit" },
	/* 0xad unused */
	{ 'X', 0xae, 0, "_convert pi1" },

	{ 'Y', 0x80, 0, "dma reset" },
	{ 'Y', 0x81, 0, "locksound" },
	{ 'Y', 0x82, 0, "dma buffer" },
	{ 'Y', 0x83, 0, "unlocksound" },
	{ 'Y', 0x84, 0, "devconnect" },
	{ 'Y', 0x85, 0, "dma status" },
	{ 'Y', 0x86, 0, "dma samsign" },
	{ 'Y', 0x87, 0, "dma samrecptr" },
	{ 'Y', 0x88, 0, "dma setmode" },
	{ 'Y', 0x89, 0, "dma samplayptr" },
	{ 'Y', 0x8a, 0, "dma samtracks" },
	{ 'Y', 0x8b, 0, "dma samstatus" },
	{ 'Y', 0x8c, 0, "dma montrack" },
	{ 'Y', 0x8d, 0, "dma samtype" },
	{ 'Y', 0x8e, 0, "dma interrupt" },
	{ 'Y', 0x8f, 0, "dma samfreq" },
	{ 'Y', 0x90, 0, "dma samrecord" },
	{ 'Y', 0x91, 0, "dma sammode" },
	{ 'Y', 0x92, 0, "dma playloop off" },
	{ 'Y', 0x93, 0, "dma sampval" },
	{ 'Y', 0x94, 0, "dma playloop on" },
	{ 'Y', 0x95, 0, "dma samconvert" },
	{ 'Y', 0x96, 0, "dma samplay" },
	{ 'Y', 0x97, 0, "dma samsize" },
	{ 'Y', 0x98, 0, "dma samthru" },
	/* 0x99 unused */
	{ 'Y', 0x9a, 0, "dma samstop" },
	/* 0x9b unused */
	{ 'Y', 0x9c, 0, "adder in" },
	/* 0x9d unused */
	{ 'Y', 0x9e, 0, "adc input" },
	/* 0x9f unused */
	/* 0xa0 unused */
	/* 0xa1 unused */
	{ 'Y', 0xa2, 0, "left gain" },
	/* 0xa3 unused */
	{ 'Y', 0xa4, 0, "right gain" },
	/* 0xa5 unused */
	{ 'Y', 0xa6, 0, "left volume" },
	/* 0xa7 unused */
	{ 'Y', 0xa8, 0, "right volume" },
	/* 0xa9 unused */
	{ 'Y', 0xaa, 0, "speaker off" },
	/* 0xab unused */
	{ 'Y', 0xac, 0, "speaker on" },

	/* Cyber: 2 commands */
	{ 'Y', 0x80, 0, "cyber" },
	/* 0x81 unused */
	{ 'Y', 0x82, 0, "view cyber" },

	/* Falcon tracker mod */
	{ 'Z', 0x80, 0, "_tracker reset" },
	{ 'Z', 0x81, 0, "_tracker init" },
	{ 'Z', 0x82, 0, "_tracker play" },
	{ 'Z', 0x83, 0, "_tracker title$" },
	{ 'Z', 0x84, 0, "_tracker loop on" },
	{ 'Z', 0x85, 0, "_tracker format$" },
	{ 'Z', 0x86, 0, "_tracker loop off" },
	{ 'Z', 0x87, 0, "_tracker startaddress" },
	{ 'Z', 0x88, 0, "_tracker stop" },
	{ 'Z', 0x89, 0, "_tracker size" },
	{ 'Z', 0x8a, 0, "_tracker pause" },
	{ 'Z', 0x8b, 0, "_tracker songlength" },
	{ 'Z', 0x8c, 0, "_tracker speed" },
	{ 'Z', 0x8d, 0, "_tracker instruments max" },
	{ 'Z', 0x8e, 0, "_tracker volume" },
	{ 'Z', 0x8f, 0, "_tracker status" },
	{ 'Z', 0x90, 0, "_tracker copy" },
	{ 'Z', 0x91, 0, "_tracker songpos" },
	/* 0x92 unused */
	{ 'Z', 0x93, 0, "_tracker pattpos" },
	{ 'Z', 0x94, 0, "_tracker ffwd" },
	{ 'Z', 0x95, 0, "_tracker sample title$" },
	{ 'Z', 0x96, 0, "_tracker songprev" },
	{ 'Z', 0x97, 0, "_tracker voices" },
	{ 'Z', 0x98, 0, "_tracker songnext" },
	{ 'Z', 0x99, 0, "_tracker vu" },
	/* 0x9a unused */
	{ 'Z', 0x9b, 0, "_tracker spectrum" },
	/* 0x9c unused */
	{ 'Z', 0x9d, 0, "_tracker maxsize" },
	/* 0x9e unused */
	{ 'Z', 0x9f, 0, "_tracker howmany" },
	/* 0xa0 unused */
	{ 'Z', 0xa1, 0, "_tracker packed" },
	{ 'Z', 0xa2, 0, "_tracker depack" },
	{ 'Z', 0xa3, 0, "_tracker filelength" },
	{ 'Z', 0xa4, 0, "_tracker load" },
	{ 'Z', 0xa5, 0, "_tracker instruments used" },
	{ 'Z', 0xa6, 0, "_tracker scope init" },
	{ 'Z', 0xa7, 0, "_tracker patt info$" },
	{ 'Z', 0xa8, 0, "_tracker scope draw" },
	{ 'Z', 0xa9, 0, "_tracker tempo" },

	/* Extra: 61 commands */
	{ 'Z', 0x80, 0, "extra" },
	{ 'Z', 0x81, 0, "prntr" },
	{ 'Z', 0x82, 0, "caps lock on" },
	{ 'Z', 0x83, 0, "ndrv" },
	{ 'Z', 0x84, 0, "caps lock on" },
	{ 'Z', 0x85, 0, "write protected" },
	{ 'Z', 0x86, 0, "swp col" },
	{ 'Z', 0x87, 0, "gemdos version$" },
	{ 'Z', 0x88, 0, "screen dump" },
	{ 'Z', 0x89, 0, "os version$" },
	{ 'Z', 0x8a, 0, "disk verify on" },
	{ 'Z', 0x8b, 0, "left shift key" },
	{ 'Z', 0x8c, 0, "disk verify off" },
	{ 'Z', 0x8d, 0, "right shift key" },
	{ 'Z', 0x8e, 0, "fmt disc" },
	{ 'Z', 0x8f, 0, "cntrl key" },
	{ 'Z', 0x90, 0, "cpy disc" },
	{ 'Z', 0x91, 0, "alt key" },
	{ 'Z', 0x92, 0, "visible input" },
	{ 'Z', 0x93, 0, "caps lock" },
	{ 'Z', 0x94, 0, "blur" },
	{ 'Z', 0x95, 0, "screen hz" },
	{ 'Z', 0x96, 0, "set rs232" },
	{ 'Z', 0x97, 0, "media status" },
	{ 'Z', 0x98, 0, "deshade" },
	{ 'Z', 0x99, 0, "power" },
	{ 'Z', 0x9a, 0, "set printer data" },
	{ 'Z', 0x9b, 0, "cartridge input" },
	{ 'Z', 0x9c, 0, "hrev" },
	{ 'Z', 0x9d, 0, "disc sides" },
	{ 'Z', 0x9e, 0, "set fattrib" },
	{ 'Z', 0x9f, 0, "disc tracks" },
	/* 0xa0 unused */
	{ 'Z', 0xa1, 0, "cookie _cpu" },
	{ 'Z', 0xa2, 0, "pal inverse" },
	{ 'Z', 0xa3, 0, "disc spt" },
	{ 'Z', 0xa4, 0, "set screen hz" },
	/* 0xa5 unused */
	{ 'Z', 0xa6, 0, "pal change" },
	{ 'Z', 0xa7, 0, "fattrib" },
	{ 'Z', 0xa8, 0, "ppsc" },
	{ 'Z', 0xa9, 0, "cookie _mch" },
	{ 'Z', 0xaa, 0, "opaque screen" },
	{ 'Z', 0xab, 0, "compact" },
	{ 'Z', 0xac, 0, "vrev" },
	{ 'Z', 0xad, 0, "mem config" },
	{ 'Z', 0xae, 0, "desquash" },
	{ 'Z', 0xaf, 0, "disc verify" },
	{ 'Z', 0xb0, 0, "del" },
	{ 'Z', 0xb1, 0, "disc size" },
	{ 'Z', 0xb2, 0, "pload" },
	{ 'Z', 0xb3, 0, "disc free" },
	{ 'Z', 0xb4, 0, "disable mouse" },
	{ 'Z', 0xb5, 0, "disc used" },
	{ 'Z', 0xb6, 0, "enable mouse" },
	{ 'Z', 0xb7, 0, "vtab" },
	{ 'Z', 0xb8, 0, "screen squash" },
	{ 'Z', 0xb9, 0, "ltab" },
	{ 'Z', 0xba, 0, "label disc" },
	{ 'Z', 0xbb, 0, "setup of printer" },
	{ 'Z', 0xbc, 0, "rmv dup col" },
	/* 0xbd unused */
	{ 'Z', 0xbe, 0, "ren" },
	{ 'Z', 0xbf, 0, "fmt text" },

	{ 0, 0, 0, NULL }
};

static int upperflag = FALSE;
static unsigned int extensions = EXTIF_SYSCTRL;
#define MAX_EXTENSIONS 26
unsigned int unknown_extensions[MAX_EXTENSIONS + 1];

#define TOUPPER(c) (upperflag ? ((c) >= 'a' && (c) <= 'z' ? (c) - ('a' - 'A') : (c)) : (c))
#define TOLOWER(c) (upperflag ? ((c) >= 'A' && (c) <= 'Z' ? (c) + ('a' - 'A') : (c)) : (c))

static const char *const lbktext[MAX_BANKS] = {
	" work   ",
	" screen ",
	" menus  ",
	"",
	" data   ",
	" dscreen",
	" program",
	" chr set",
	" sprites",
	" icons  ",
	" music  ",
	" 3D     ",
};


static uint32_t getbe32(const unsigned char *src)
{
	return (((uint32_t)src[0]) << 24) | (((uint32_t)src[1]) << 16) | (((uint32_t)src[2]) << 8) | (((uint32_t)src[3]) << 0);
}


static uint16_t readbe16(FILE *fp)
{
	int c1, c2;
	c1 = fgetc(fp);
	c2 = fgetc(fp);
	return (c1 << 8) | c2;
}


static uint32_t readbe32(FILE *fp)
{
	uint32_t c;
	c = fgetc(fp);
	c <<= 8;
	c |= fgetc(fp);
	c <<= 8;
	c |= fgetc(fp);
	c <<= 8;
	c |= fgetc(fp);
	return c;
}


static void print_upper(const char *str, FILE *out)
{
	while (*str)
	{
		putc(TOUPPER(*str), out);
		str++;
	}
}


static void print_extfunc(unsigned char opcode, unsigned char opcode2, const struct token *tokens, FILE *out)
{
	while (tokens->name != NULL)
	{
		if (tokens->val1 == opcode && tokens->val2 == opcode2)
		{
			print_upper(tokens->name, out);
			return;
		}
		tokens++;
	}
	fputs("ILLEGAL", out);
}


static void print_token(unsigned char opcode, const struct token *tokens, FILE *out)
{
	while (tokens->name != NULL)
	{
		if (tokens->val1 == opcode)
		{
			print_upper(tokens->name, out);
			return;
		}
		tokens++;
	}
	fputs("ILLEGAL", out);
}


static void print_external_extension(int extension, unsigned char opcode, FILE *out)
{
	const struct extension *ext = external_extensions;
	char extension_char = 'A' + extension;
	
	while (ext->name != NULL)
	{
		if (ext->extension == extension_char && ext->opcode == opcode)
		{
			if (ext->extension_if == 0 ||
				(extensions & ext->extension_if) != 0)
			{
				print_upper(ext->name, out);
				return;
			}
		}
		ext++;
	}
	fprintf(out, "extension #%c(0x%02x)", extension_char, opcode);
	if (extension >= MAX_EXTENSIONS)
		extension = MAX_EXTENSIONS;
	unknown_extensions[extension]++;
}


static int listfile(FILE *fp, FILE *out)
{
	struct basfile header;
	uint16_t linelength;
	uint16_t lineno;
	int32_t prglen;
	int i;
	int remflg;
	unsigned char opcode;
	unsigned char opcode2;
	int badfloat = 0;
	
	if (fread(&header, sizeof(header), 1, fp) != 1)
	{
		fprintf(stderr, "read error\n");
		return FALSE;
	}
	if (memcmp(header.magic, "Lionpoulos", 10) != 0)
	{
		fprintf(stderr, "Not a STOS basic file\n");
		return FALSE;
	}
	
	for (i = 0; i <= MAX_EXTENSIONS; i++)
		unknown_extensions[i] = 0;

	prglen = getbe32(&header.databank[0][0]);
	while (prglen > 0)
	{
		uint32_t v;

		linelength = readbe16(fp);
		if (linelength == 0)
			break;
		lineno = readbe16(fp);
		/*
		 * lines must start at even address
		 */
		if (linelength & 1)
		{
			fprintf(stderr, "invalid length %u in line %u\n", linelength, lineno);
			linelength++;
		}
		/*
		 * we must have at least length field & lineno
		 */
		if (linelength < 4)
		{
			fprintf(stderr, "too short line %u\n", lineno);
			linelength = 4;
		}
		prglen -= linelength;
#if 0
		fprintf(out, "%5u (0x%04x) ", lineno, linelength);
#else
		fprintf(out, "%u ", lineno);
#endif
		
		linelength -= 4;
		opcode2 = 0xff;
		remflg = FALSE;
		while (linelength > 0)
		{
			opcode = fgetc(fp);
			linelength -= 1;
			if (remflg)
			{
				/* might be padding byte */
				if (opcode != 0)
					putc(opcode, out);
				opcode2 = 0;
				continue;
			}
			if (!(opcode & 0x80))
			{
				if (opcode == ':')
				{
					putc(' ', out);
					putc(':', out);
					putc(' ', out);
					opcode2 = 0xff;
					continue;
				}
				if (opcode2 != 0)
				{
					if (opcode2 < 0xb0)
						putc(' ', out);
				}
				/* might be padding byte */
				if (opcode != 0)
					putc(TOLOWER(opcode), out);
				opcode2 = 0;
				continue;
			}
			
			if (opcode >= T_goto && (opcode <= T_repeat || opcode >= T_var))
			{
				/* DETOKENIZE SPECIAL CODES */
				/* pad to even address */
				if (linelength & 1)
				{
					(void)fgetc(fp);
					linelength--;
				}
				if (opcode > T_repeat)
				{
					if (opcode2 != 0 && opcode2 < T_operator)
						putc(' ', out);
					switch (opcode)
					{
					case T_consthex:
						v = readbe32(fp);
						linelength -= 4;
						fprintf(out, "$%lX", (unsigned long)v);
						break;
					case T_constint:
						v = readbe32(fp);
						linelength -= 4;
						fprintf(out, "%ld", (long)(int32_t)v);
						break;
					case T_conststr:
						putc('"', out);
						/* read string length */
						v = readbe32(fp);
						linelength -= 4;
						while (v > 0)
						{
							fputc(fgetc(fp), out);
							v--;
							linelength--;
						}
						putc('"', out);
						break;
					case T_constbin:
						{
							char buffer[32];
							char *p;
							
							v = readbe32(fp);
							linelength -= 4;
							p = buffer;
							do
							{
								*p++ = (v & 1) + '0';
								v >>= 1;
							} while (v != 0);
							putc('%', out);
							while (p > buffer)
								putc(*--p, out);
						}
						break;
					case T_constflt:
						{
							uint32_t hi, lo;
							
							hi = readbe32(fp);
							lo = readbe32(fp);
							linelength -= 8;
							/* TODO: print float */
							if (lo != 0x12345678l)
							{
								fputs(" BAD FLOAT TRAP ", out);
								badfloat = 1;
							} else
							{
								int exp = hi & 0x7f;
								double mant = ((hi >> 8) & 0xfffffful) / 8388608.0;
								double x = ldexp(mant, exp - 0x41);
								if (hi & 0x80)
									x = -x;
								if (hi == 0)
									x = 0;
								fprintf(out, "%.6g", x);
							}
						}
						break;
					case T_var:
						/* skip variable name length */
						v = readbe32(fp);
						linelength -= 4;
						break;
					}
					opcode2 = 0;
					continue;
				}
				/* BRANCHEMENT TOKEN: skip the address and dtokenise! */
				v = readbe32(fp);
				linelength -= 4;
			}
			
			/* DETOKENIZE NORMAL TOKENS */
			if (opcode2 < T_operator &&
				opcode < T_operator &&
				(opcode < T_extfunc || opcode2 != 0))
				putc(' ', out);
			if (opcode == T_rem)
				remflg = TRUE;
			opcode2 = opcode;
			if (opcode == T_extinst)
			{
				opcode = fgetc(fp);
				linelength--;
				print_extfunc(opcode2, opcode, extinstructions, out);
			} else if (opcode == T_extfunc)
			{
				opcode = fgetc(fp);
				linelength--;
				print_extfunc(opcode2, opcode, extfunctions, out);
			} else if (opcode == T_extensioninst || opcode == T_extensionfunc)
			{
				/* dt11y */
				int extension;
				
				extension = fgetc(fp);
				opcode = fgetc(fp);
				linelength -= 2;
				/*
				 * TODO: load extensions
				 */
				print_external_extension(extension, opcode, out);
			} else
			{
				/* NORMAL token */
				print_token(opcode, tokens, out);
			}
		}
		putc('\n', out);
	}
	
	for (i = 1; i < MAX_BANKS; i++)
		if (getbe32(&header.databank[i][0]) != 0)
			break;
	if (i < MAX_BANKS)
	{
		fprintf(out, "\nReserved memory banks:\n");
		for (i = 1; i < MAX_BANKS; i++)
		{
			int32_t len;
			int b;
			
			len = getbe32(&header.databank[i][0]);
			if (len != 0)
			{
				if (i <= 4)
				{
					b = i + 7;
				} else
				{
					b = ((len >> 24) & 0xff) - 1;
					if (b & 0x80)
						b = (b & 3) | 4;
				}
				fprintf(out, "%2d: %s 0x%06lx\n", i, lbktext[b], len & 0xffffffL);
			}
		}
	}
	
	if (badfloat)
	{
		fprintf(stderr, "bad floating point constants detected,\n");
		fprintf(stderr, "run CONVERT.BAS\n");
	}

	for (i = 0; i <= MAX_EXTENSIONS; i++)
	{
		if (unknown_extensions[i] != 0)
		{
			fprintf(stderr, "%u unknown calls to extension %c found\n", unknown_extensions[i], i + 'A');
		}
	}
	return TRUE;
}


static struct option const long_options[] = {
	{ "upper", no_argument, NULL, 'u' },
	{ "version", no_argument, NULL, 'V' },
	{ "help", no_argument, NULL, 'h' },
	{ NULL, no_argument, NULL, 0 }
};


static void usage(FILE *out)
{
	fputs("usage: stoslist [-u] [file...]\n", out);
}


int main(int argc, char **argv)
{
	const char *filename;
	int i;
	FILE *fp;
	int c;
	int ret;

	while ((c = getopt_long(argc, argv, "uVh", long_options, NULL)) != EOF)
	{
		switch (c)
		{
		case 'u':
			upperflag = TRUE;
			break;
		case 'V':
			fprintf(stdout, "stoslist version 1.0\n");
			return 0;
		case 'h':
			usage(stdout);
			return 0;
		default:
			return 1;
		}
	}
	
	for (i = optind; i < argc; i++)
	{
		filename = argv[i];
		fp = fopen(filename, "rb");
		if (fp == NULL)
		{
			fprintf(stderr, "%s: %s\n", filename, strerror(errno));
			ret = FALSE;
		} else
		{
			ret = listfile(fp, stdout);
			fclose(fp);
		}
		if (ret == FALSE)
			return 1;
	}

	return 0;
}
