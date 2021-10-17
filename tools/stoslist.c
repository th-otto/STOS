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
struct extension {
	char extension;
	unsigned char opcode;
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
    { 'A', 0x80, "unpack" },
    { 'A', 0x81, "pack" },

    /* STOS Compiler: 5 commands */
    { 'C', 0x80, "compad" },
    { 'C', 0x82, "comptest off" },
    { 'C', 0x84, "comptest on" },
    { 'C', 0x86, "comptest always" },
    { 'C', 0x88, "comptest" },

    /* STOS Maestro: 20 commands */
	{ 'D', 0x80, "sound init" },
	{ 'D', 0x81, "sample" },
	{ 'D', 0x82, "samplay" },
	{ 'D', 0x83, "samplace" },
	{ 'D', 0x84, "samspeed manual" },
	{ 'D', 0x86, "samspeed auto" },
	{ 'D', 0x88, "samspeed" },
	{ 'D', 0x8a, "samstop" },
	{ 'D', 0x8c, "samloop off" },
	{ 'D', 0x8e, "samloop on" },
	{ 'D', 0x90, "samdir forward" },
	{ 'D', 0x92, "samdir backward" },
	{ 'D', 0x94, "samsweep on" },
	{ 'D', 0x96, "samsweep off" },
	{ 'D', 0x98, "samraw" },
	{ 'D', 0x9a, "samrecord" },
	{ 'D', 0x9c, "samcopy" },
	{ 'D', 0x9e, "sammusic" },
	{ 'D', 0xa2, "samthru" },
	{ 'D', 0xa4, "sambank" },

	/* STOS 3D: 59 commands */
	{ 'S', 0x80, "td priority" },
	{ 'S', 0x81, "td visible" },
	{ 'S', 0x82, "td load" },
	{ 'S', 0x83, "td range" },
	{ 'S', 0x84, "td clear all" },
	{ 'S', 0x85, "td position x" },
	{ 'S', 0x86, "td object" },
	{ 'S', 0x87, "td position y" },
	{ 'S', 0x88, "td screen height" },
	{ 'S', 0x89, "td position z" },
	{ 'S', 0x8a, "td kill" },
	{ 'S', 0x8b, "td attitude a" },
	{ 'S', 0x8c, "td move x" },
	{ 'S', 0x8d, "td attitude b" },
	{ 'S', 0x8e, "td move y" },
	{ 'S', 0x8f, "td attitude b" },
	{ 'S', 0x90, "td move z" },
	{ 'S', 0x91, "td collide" },
	{ 'S', 0x92, "td move rel" },
	{ 'S', 0x93, "td zone x" },
	{ 'S', 0x94, "td move" },
	{ 'S', 0x95, "td zone y" },
	{ 'S', 0x96, "td angle a" },
	{ 'S', 0x97, "td zone z" },
	{ 'S', 0x98, "td angle b" },
	{ 'S', 0x99, "td zone r" },
	{ 'S', 0x9a, "td angle c" },
	{ 'S', 0x9b, "td world x" },
	{ 'S', 0x9c, "td angle rel" },
	{ 'S', 0x9d, "td world y" },
	{ 'S', 0x9e, "td angle" },
	{ 'S', 0x9f, "td world z" },
	/* 0xa0 missing */
	{ 'S', 0xa1, "td view x" },
	{ 'S', 0xa2, "td delete zone" },
	{ 'S', 0xa3, "td view y" },
	{ 'S', 0xa4, "td redraw" },
	{ 'S', 0xa5, "td view z" },
	{ 'S', 0xa6, "td set zone" },
	{ 'S', 0xa7, "td screen x" },
	{ 'S', 0xa8, "td cls" },
	{ 'S', 0xa9, "td screen y" },
	{ 'S', 0xaa, "td background" },
	{ 'S', 0xab, "td bearing a" },
	{ 'S', 0xac, "td dir" },
	{ 'S', 0xad, "td bearing b" },
	{ 'S', 0xae, "td set colour" },
	{ 'S', 0xaf, "td bearing r" },
	{ 'S', 0xb0, "td anim rel" },
	{ 'S', 0xb1, "td anim point x" },
	{ 'S', 0xb2, "td init" },
	{ 'S', 0xb3, "td anim point y" },
	{ 'S', 0xb4, "td face" },
	{ 'S', 0xb5, "td anim point z" },
	{ 'S', 0xb6, "td forward" },
	{ 'S', 0xb7, "td advanced" },
	/* 0xb8 missing */
	{ 'S', 0xb9, "td debug" },
	{ 'S', 0xba, "td anim" },
	/* 0xbb missing */
	{ 'S', 0xbc, "td surface points" },
	/* 0xbd missing */
	{ 'S', 0xbe, "td surface" },

    /* Extra: 61 commands */
	{ 'Z', 0x80, "extra" },
	{ 'Z', 0x81, "prntr" },
	{ 'Z', 0x82, "caps lock on" },
	{ 'Z', 0x83, "ndrv" },
	{ 'Z', 0x84, "caps lock on" },
	{ 'Z', 0x85, "write protected" },
	{ 'Z', 0x86, "swp col" },
	{ 'Z', 0x87, "gemdos version$" },
	{ 'Z', 0x88, "screen dump" },
	{ 'Z', 0x89, "os version$" },
	{ 'Z', 0x8a, "disk verify on" },
	{ 'Z', 0x8b, "left shift key" },
	{ 'Z', 0x8c, "disk verify off" },
	{ 'Z', 0x8d, "right shift key" },
	{ 'Z', 0x8e, "fmt disc" },
	{ 'Z', 0x8f, "cntrl key" },
	{ 'Z', 0x90, "cpy disc" },
	{ 'Z', 0x91, "alt key" },
	{ 'Z', 0x92, "visible input" },
	{ 'Z', 0x93, "caps lock" },
	{ 'Z', 0x94, "blur" },
	{ 'Z', 0x95, "screen hz" },
	{ 'Z', 0x96, "set rs232" },
	{ 'Z', 0x97, "media status" },
	{ 'Z', 0x98, "deshade" },
	{ 'Z', 0x99, "power" },
	{ 'Z', 0x9a, "set printer data" },
	{ 'Z', 0x9b, "cartridge input" },
	{ 'Z', 0x9c, "hrev" },
	{ 'Z', 0x9d, "disc sides" },
	{ 'Z', 0x9e, "set fattrib" },
	{ 'Z', 0x9f, "disc tracks" },
	/* 0xa0 missing */
	{ 'Z', 0xa1, "cookie _cpu" },
	{ 'Z', 0xa2, "pal inverse" },
	{ 'Z', 0xa3, "disc spt" },
	{ 'Z', 0xa4, "set screen hz" },
	/* 0xa5 missing */
	{ 'Z', 0xa6, "pal change" },
	{ 'Z', 0xa7, "fattrib" },
	{ 'Z', 0xa8, "ppsc" },
	{ 'Z', 0xa9, "cookie _mch" },
	{ 'Z', 0xaa, "opaque screen" },
	{ 'Z', 0xab, "compact" },
	{ 'Z', 0xac, "vrev" },
	{ 'Z', 0xad, "mem config" },
	{ 'Z', 0xae, "desquash" },
	{ 'Z', 0xaf, "disc verify" },
	{ 'Z', 0xb0, "del" },
	{ 'Z', 0xb1, "disc size" },
	{ 'Z', 0xb2, "pload" },
	{ 'Z', 0xb3, "disc free" },
	{ 'Z', 0xb4, "disable mouse" },
	{ 'Z', 0xb5, "disc used" },
	{ 'Z', 0xb6, "enable mouse" },
	{ 'Z', 0xb7, "vtab" },
	{ 'Z', 0xb8, "screen squash" },
	{ 'Z', 0xb9, "ltab" },
	{ 'Z', 0xba, "label disc" },
	{ 'Z', 0xbb, "setup of printer" },
	{ 'Z', 0xbc, "rmv dup col" },
	/* 0xbd missing */
	{ 'Z', 0xbe, "ren" },
	{ 'Z', 0xbf, "fmt text" },

    /* Control: 61 commands */
	{ 'W', 0x80, "switch on" },
	{ 'W', 0x81, "case" },
	{ 'W', 0x82, "switch off" },
	{ 'W', 0x83, "otherwise" },
	{ 'W', 0x84, "cmove" },
	/* 0x85 missing */
	{ 'W', 0x86, "write" },
	{ 'W', 0x87, "parallel" },
	{ 'W', 0x88, "cremember" },
	{ 'W', 0x89, "para fire" },
	{ 'W', 0x8a, "crecall" },
	{ 'W', 0x8b, "add" },
	{ 'W', 0x8c, "ctrl" },
	{ 'W', 0x8d, "test megazone" },
	{ 'W', 0x8e, "para on" },
	{ 'W', 0x8f, "para up" },
	{ 'W', 0x90, "para off" },
	{ 'W', 0x91, "para down" },
	{ 'W', 0x92, "init megazone" },
	{ 'W', 0x93, "para left" },
	{ 'W', 0x94, "set megazone" },
	{ 'W', 0x95, "klatu" },
	{ 'W', 0x96, "range megazone" },
	{ 'W', 0x97, "exist$" },
	{ 'W', 0x98, "map write" },
	/* 0x99 missing */
	{ 'W', 0x9a, "spread" },
	{ 'W', 0x9b, "para right" },
	{ 'W', 0x9c, "brdr remove" },
	{ 'W', 0x9d, "crack pac" },
	{ 'W', 0x9e, "crack unpac" },
	{ 'W', 0x9f, "map address" },
	{ 'W', 0xa0, "quick screen" },
	{ 'W', 0xa1, "klatu" },
	{ 'W', 0xa2, "font" },
	{ 'W', 0xa3, "map h" },
	{ 'W', 0xa4, "image put" },
	{ 'W', 0xa5, "map w" },
	{ 'W', 0xa6, "screen size" },
	{ 'W', 0xa7, "klatu" },
	{ 'W', 0xa8, "hscroll" },
	{ 'W', 0xa9, "image width" },
	{ 'W', 0xaa, "image palette" },
	{ 'W', 0xab, "image height" },
	{ 'W', 0xac, "many image" },
	{ 'W', 0xad, "map read" },
	{ 'W', 0xae, "set clip" },
	{ 'W', 0xaf, "klatu" },
	{ 'W', 0xb0, "turbocopy" },
	{ 'W', 0xb1, "klatu" },
	{ 'W', 0xb2, "bigcls" },
	{ 'W', 0xb3, "inside" },
	{ 'W', 0xb4, "bigcopy" },
	{ 'W', 0xb5, "image collide" },
	{ 'W', 0xb6, "screen offset" },
	{ 'W', 0xb7, "image mcollide" },
	{ 'W', 0xb8, "cylinder" },
	{ 'W', 0xb9, "klatu" },
	{ 'W', 0xba, "image map" },
	{ 'W', 0xbb, "jagjoy" },
	{ 'W', 0xbc, "set map" },
	{ 'W', 0xbd, "klatu" },
	{ 'W', 0xbe, "image offset" },

    /* Misty: 21 commands */
	{ 'M', 0x80, "fastcopy" },
	{ 'M', 0x81, "col" },
	{ 'M', 0x82, "floprd" },
	{ 'M', 0x83, "mediach" },
	{ 'M', 0x84, "flopwrt" },
	{ 'M', 0x85, "hardkey" },
	{ 'M', 0x86, "dot" },
	{ 'M', 0x87, "ndrv" },
	{ 'M', 0x88, "mouseoff" },
	{ 'M', 0x89, "freq" },
	{ 'M', 0x8a, "mouseon" },
	{ 'M', 0x8b, "resvalid" },
	{ 'M', 0x8c, "skopy" },
	{ 'M', 0x8d, "aesin" },
	{ 'M', 0x8e, "setrtim" },
	{ 'M', 0x8f, "rtim" },
	{ 'M', 0x90, "warmboot" },
	{ 'M', 0x91, "blitter" },
	{ 'M', 0x92, "silence" },
	{ 'M', 0x93, "kbshift" },
	{ 'M', 0x94, "kopy" },

    /* Missing Link: 33 commands (link1) */
	{ 'Q', 0x80, "landscape" },
	{ 'Q', 0x81, "overlap" },
	{ 'Q', 0x82, "bob" },
	{ 'Q', 0x83, "map toggle" },
	{ 'Q', 0x84, "wipe" },
	{ 'Q', 0x85, "boundary" },
	{ 'Q', 0x86, "tile" },
	{ 'Q', 0x87, "palt" },
	{ 'Q', 0x88, "world" },
	{ 'Q', 0x89, "musauto" },
	{ 'Q', 0x8a, "musplay" },
	{ 'Q', 0x8b, "which block" },
	{ 'Q', 0x8c, "relocate" },
	{ 'Q', 0x8d, "p left" },
	{ 'Q', 0x8e, "p on" },
	{ 'Q', 0x8f, "p joy" },
	{ 'Q', 0x90, "p stop" },
	{ 'Q', 0x91, "p up" },
	{ 'Q', 0x92, "set block" },
	{ 'Q', 0x93, "p right" },
	{ 'Q', 0x94, "palsplit" },
	{ 'Q', 0x95, "p down" },
	{ 'Q', 0x96, "floodpal" },
	{ 'Q', 0x97, "p fire" },
	{ 'Q', 0x98, "digi play" },
	{ 'Q', 0x99, "string" },
	{ 'Q', 0x9a, "samsign" },
	{ 'Q', 0x9b, "depack" },
	{ 'Q', 0x9c, "replace blocks" },
	{ 'Q', 0x9d, "dload" },
	{ 'Q', 0x9e, "display pc1" },
	{ 'Q', 0x9f, "dsave" },
	{ 'Q', 0xa0, "honesty" },

    /* Missing Link: 28 commands (link2) */
	{ 'R', 0x80, "joey" },
	{ 'R', 0x81, "b height" },
	{ 'R', 0x82, "blit" },
	{ 'R', 0x83, "b width" },
	{ 'R', 0x84, "spot" },
	{ 'R', 0x85, "block amount" },
	{ 'R', 0x86, "reflect" },
	{ 'R', 0x87, "compstate" },
	{ 'R', 0x88, "mozaic" },
	{ 'R', 0x89, "x limit" },
	{ 'R', 0x8a, "xy block" },
	{ 'R', 0x8b, "y limit" },
	{ 'R', 0x8c, "text" },
	{ 'R', 0x8d, "mostly harmless" },
	{ 'R', 0x8e, "wash" },
	{ 'R', 0x8f, "real length" },
	{ 'R', 0x90, "reboot" },
	{ 'R', 0x91, "brightest" },
	{ 'R', 0x92, "bank load" },
	{ 'R', 0x93, "bank length" },
	{ 'R', 0x94, "bank copy" },
	{ 'R', 0x95, "bank size" },
	{ 'R', 0x96, "m blit" },
	{ 'R', 0x97, "win block amount" },
	{ 'R', 0x98, "replace range" },
	{ 'R', 0x99, "empty" },
	{ 'R', 0x9a, "win replace blocks" },
	{ 'R', 0x9b, "empty2" },
	{ 'R', 0x9c, "win replace range" },
	{ 'R', 0x9d, "empty3" },
	{ 'R', 0x9e, "win xy block" },

    /* Missing Link: 13 commands (link3) */
	{ 'S', 0x80, "many add" },
	{ 'S', 0x81, "many overlap" },
	{ 'S', 0x82, "many sub" },
	{ 'S', 0x83, "function2" },
	{ 'S', 0x84, "many bob" },
	{ 'S', 0x85, "function3" },
	{ 'S', 0x86, "many joey" },
	{ 'S', 0x87, "hertz" },
	{ 'S', 0x88, "set hertz" },
	{ 'S', 0x89, "function4" },
	{ 'S', 0x8a, "many inc" },
	{ 'S', 0x8b, "function5" },
	{ 'S', 0x8c, "many dec" },
	{ 'S', 0x8d, "function6" },
	{ 'S', 0x8e, "raster" },
	{ 'S', 0x8f, "function7" },
	{ 'S', 0x90, "bullet" },
	{ 'S', 0x91, "function8" },
	{ 'S', 0x92, "many bullet" },
	{ 'S', 0x93, "function9" },
	{ 'S', 0x94, "many spot" },

    /* Ninja Tracker: 9 commands */
	{ 'Q', 0x80, "track play" },
	{ 'Q', 0x81, "vu meter" },
	{ 'Q', 0x82, "track frequency" },
	{ 'Q', 0x83, "track pos" },
	{ 'Q', 0x84, "track info" },
	{ 'Q', 0x85, "track pattern" },
	/* 0x86 missing */
	{ 'Q', 0x87, "track key" },
	{ 'Q', 0x88, "track unpack" },
	{ 'Q', 0x89, "track name" },

    /* GPB: 32 commands */
	{ 'P', 128, "lights on" },
	{ 'P', 129, "pready" },
	{ 'P', 130, "lights off" },
	{ 'P', 131, "xpen" },
	{ 'P', 132, "fastwipe" },
	{ 'P', 133, "paktype" },
	{ 'P', 134, "dac volume" },
	{ 'P', 135, "even" },
	{ 'P', 136, "setpal" },
	{ 'P', 137, "setprt" },
	{ 'P', 138, "d crunch" },
	{ 'P', 139, "eplace" },
	{ 'P', 140, "elite unpack" },
	{ 'P', 141, "foffset" },
	{ 'P', 142, "estop" },
	{ 'P', 143, "jar" },
	{ 'P', 144, "mirror" },
	{ 'P', 145, "percent" },
	{ 'P', 146, "tiny unpack" },
	{ 'P', 147, "paksize" },
	{ 'P', 148, "treble" },
	{ 'P', 149, "special key" },
	{ 'P', 150, "bass" },
	{ 'P', 151, "fstart" },
	{ 'P', 152, "hcopy" },
	{ 'P', 153, "flength" },
	{ 'P', 154, "ca unpack" },
	{ 'P', 155, "ca pack" },
	{ 'P', 156, "bcls" },
	{ 'P', 157, "cookie" },
	{ 'P', 158, "eplay" },
	{ 'P', 159, "ypen" },

    /* STOS Tracker: 9 commands (track_10) */
	{ 'T', 0x80, "track load" },
	{ 'T', 0x81, "track scan" },
	{ 'T', 0x82, "track bank" },
	{ 'T', 0x83, "track vu" },
	{ 'T', 0x84, "track play" },
	/* 0x85 missing */
	{ 'T', 0x86, "track key" },
	/* 0x87 missing */
	{ 'T', 0x88, "track volume" },
	/* 0x89 missing */
	{ 'T', 0x8a, "track tempo" },
	/* 0x8b missing */
	{ 'T', 0x8c, "track stop" },

    /* STOS Tracker: 9 commands (track_7/track_14) */
	{ 'S', 0x80, "track load" },
	{ 'S', 0x81, "track scan" },
	{ 'S', 0x82, "track bank" },
	{ 'S', 0x83, "track vu" },
	{ 'S', 0x84, "track play" },
	/* 0x85 missing */
	{ 'S', 0x86, "track key" },
	/* 0x87 missing */
	{ 'S', 0x88, "track volume" },
	/* 0x89 missing */
	{ 'S', 0x8a, "track tempo" },
	/* 0x8b missing */
	{ 'S', 0x8c, "track stop" },

    /* MIDI: 5 commands */
	{ 'M', 0x80, "midi on" },
	{ 'M', 0x81, "midi in" },
	{ 'M', 0x82, "midi off" },
	/* 0x83 missing */
	{ 'M', 0x84, "midi out" },
	/* 0x85 missing */
	{ 'M', 0x86, "about musician" },

    /* Stars: 4 commands */
	{ 'H', 0x80, "set stars" },
	/* $81 missing */
	{ 'H', 0x82, "go stars" },
	/* $83 missing */
	{ 'H', 0x84, "wipe stars on" },
	/* $85 missing */
	{ 'H', 0x86, "wipe stars off" },

	/* STE extension: 35 commands */
	{ 'F', 0x80, "sticks on" },
	{ 'F', 0x81, "stick1" },
	{ 'F', 0x82, "sticks off" },
	{ 'F', 0x83, "stick2" },
	{ 'F', 0x84, "dac convert" },
	{ 'F', 0x85, "l stick" },
	{ 'F', 0x86, "dac raw" },
	{ 'F', 0x87, "r stick" },
	{ 'F', 0x88, "dac speed" },
	{ 'F', 0x89, "u stick" },
	{ 'F', 0x8a, "dac stop" },
	{ 'F', 0x8b, "d stick" },
	{ 'F', 0x8c, "dac m volume" },
	{ 'F', 0x8d, "f stick" },
	{ 'F', 0x8e, "dac l volume" },
	{ 'F', 0x8f, "light x" },
	{ 'F', 0x90, "dac r volume" },
	{ 'F', 0x91, "light y" },
	{ 'F', 0x92, "dac treble" },
	{ 'F', 0x93, "ste" },
	{ 'F', 0x94, "dac bass" },
	{ 'F', 0x95, "e color" },
	{ 'F', 0x96, "dac mix on" },
	{ 'F', 0x97, "hard physic" },
	{ 'F', 0x98, "dac mix off" },
	/* 0x99 missing */
	{ 'F', 0x9a, "dac mono" },
	/* 0x9b missing */
	{ 'F', 0x9c, "dac stereo" },
	/* 0x9d missing */
	{ 'F', 0x9e, "dac loop on" },
	/* 0x9f missing */
	{ 'F', 0xa0, "dac loop off" },
	/* 0xa1 missing */
	{ 'F', 0xa2, " e palette" },
	/* 0xa3 missing */
	{ 'F', 0xa4, "e colour" },
	/* 0xa5 missing */
	{ 'F', 0xa6, "hard screen size" },
	/* 0xa7 missing */
	{ 'F', 0xa8, "hard screen offset" },
	/* 0xa9 missing */
	{ 'F', 0xaa, "hard screen offset" },
	/* 0xab missing */
	{ 'F', 0xac, "hard screen offset" },

#if 0
	/* STORM/GBP blitter extension: 18 commands */
	{ 'G', 0x80, "blit sinc" },
	{ 'G', 0x81, "blit clr" },
	{ 'G', 0x82, "blit dinc" },
	{ 'G', 0x83, "blit fskopy" },
	{ 'G', 0x84, "blit address" },
	/* 0x85 missing */
	{ 'G', 0x86, "blit mask" },
	/* 0x87 missing */
	{ 'G', 0x88, "blit count" },
	/* 0x89 missing */
	{ 'G', 0x8a, "blit hop" },
	/* 0x8b missing */
	{ 'G', 0x8c, "blit op" },
	/* 0x8d missing */
	{ 'G', 0x8e, "blit skew" },
	/* 0x8f missing */
	{ 'G', 0x90, "blit nfsr" },
	/* 0x91 missing */
	{ 'G', 0x92, "blit fxsr" },
	/* 0x93 missing */
	{ 'G', 0x94, "blit line" },
	/* 0x95 missing */
	{ 'G', 0x96, "blit smudge" },
	/* 0x97 missing */
	{ 'G', 0x98, "blit hog" },
	/* 0x99 missing */
	{ 'G', 0x9a, "blit it" },
	/* 0x9b missing */
	{ 'G', 0x9c, "fcopy" },
	/* 0x9c missing */
	{ 'G', 0x9d, "cls" },
#else
	/* Blitter Extension. v 1.1 by Ambrah */
	{ 'G', 0x80, "blit halftone" },
	{ 'G', 0x81, "blit busy" },
	{ 'G', 0x82, "blit source x inc" },
	{ 'G', 0x83, "blitter" },
	{ 'G', 0x84, "blit source y inc" },
	{ 'G', 0x85, "blit remain" },
	{ 'G', 0x86, "blit source address" },
	/* $87 missing */
	{ 'G', 0x88, "blit dest x inc" },
	/* $89 missing */
	{ 'G', 0x8a, "blit dest y inc" },
	/* $8b missing */
	{ 'G', 0x8c, "blit dest address" },
	/* $8d missing */
	{ 'G', 0x8e, "blit endmask 1" },
	/* $8f missing */
	{ 'G', 0x90, "blit endmask 2" },
	/* $91 missing */
	{ 'G', 0x92, "blit endmask 3" },
	/* $93 missing */
	{ 'G', 0x94, "blit x count" },
	/* $95 missing */
	{ 'G', 0x96, "blit y count" },
	/* $97 missing */
	{ 'G', 0x98, "blit hop" },
	/* $99 missing */
	{ 'G', 0x9a, "blit op" },
	/* $9b missing */
	{ 'G', 0x9c, "blit h line" },
	/* $9d missing */
	{ 'G', 0x9e, "blit smudge" },
	/* $9f missing */
	{ 'G', 0xa0, "blit hog" },
	/* $a1 missing */
	{ 'G', 0xa2, " blit it" },
	/* $a3 missing */
	{ 'G', 0xa4, "blit skew" },
	/* $a5 missing */
	{ 'G', 0xa6, "blit nfsr" },
	/* $a7 missing */
	{ 'G', 0xa8, "blit fxsr" },
	/* $a9 missing */
	{ 'G', 0xaa, "blit cls" },
	/* $ab missing */
	{ 'G', 0xac, "blit copy" },
	/* $ad missing */
	{ 'G', 0xae, "about blitter" },
#endif

    /* Cyber: 2 commands */
	{ 'Y', 0x80, "cyber" },
	/* 0x81 missing */
	{ 'Y', 0x82, "view cyber" },
    
    /* STOS Squasher: 2 commands */
	{ 'E', 0x80, "unsquash" },
	{ 'E', 0x81, "squash" },

    /* Protracker: 3 commands */
	{ 'P', 0x80, "propack" },
	{ 'P', 0x81, "mpack" },
	{ 'P', 0x83, "munpack" },

	{ 0, 0, NULL }
};

static int upperflag = FALSE;

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


static void print_external_extension(char extension, unsigned char opcode, FILE *out)
{
	const struct extension *ext = external_extensions;
	
	while (ext->name != NULL)
	{
		if (ext->extension == extension && ext->opcode == opcode)
		{
			print_upper(ext->name, out);
			return;
		}
		ext++;
	}
	fprintf(out, "extension #%c(0x%02x)", extension, opcode);
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
		fprintf(out, "%5u ", lineno);
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
						fprintf(out, "$%lx", (unsigned long)v);
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
								*p = (v & 1) + '0';
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
				print_external_extension('A' + extension, opcode, out);
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
