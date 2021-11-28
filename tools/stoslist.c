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

#define ARRAY_SIZE(a) ((unsigned int)(sizeof(a) / sizeof(a[0])))


#define EXTIF_SYSCTRL  0x0001
#define EXTIF_CONTROL  0x0002

struct instruction {
	unsigned char opcode;
	const char *name;
};

struct extension {
	char extension;
	unsigned short extension_if;
	const char *name;
	const char *filename;
	const struct instruction *instructions;
	unsigned int num_instructions;
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

/*
 * List of known extensions
 */

/* Compact: 2 commands */
static struct instruction const compact_instructions[] = {
	{ 0x80, "unpack" },
	{ 0x81, "pack" },
};

static struct extension const compaction_extension = {
	'A',
	0,
	"compact",
	"compact",
	compact_instructions,
	ARRAY_SIZE(compact_instructions)
};

/* STOS Compiler: 5 commands */
static struct instruction const compiler_instructions[] = {
	{ 0x80, "run" },
	{ 0x81, "compad" },
	{ 0x82, "comptest off" },
	{ 0x84, "comptest on" },
	{ 0x86, "comptest always" },
	{ 0x88, "comptest" },
};

static struct extension const compiler_extension = {
	'C',
	0,
	"compiler",
	"compiler",
	compiler_instructions,
	ARRAY_SIZE(compiler_instructions)
};

/* STOS Maestro: 20 commands */
static struct instruction const maestro_instructions[] = {
	{ 0x80, "sound init" },
	{ 0x81, "sample" },
	{ 0x82, "samplay" },
	{ 0x83, "samplace" },
	{ 0x84, "samspeed manual" },
	{ 0x86, "samspeed auto" },
	{ 0x88, "samspeed" },
	{ 0x8a, "samstop" },
	{ 0x8c, "samloop off" },
	{ 0x8e, "samloop on" },
	{ 0x90, "samdir forward" },
	{ 0x92, "samdir backward" },
	{ 0x94, "samsweep on" },
	{ 0x96, "samsweep off" },
	{ 0x98, "samraw" },
	{ 0x9a, "samrecord" },
	{ 0x9c, "samcopy" },
	{ 0x9e, "sammusic" },
	{ 0xa2, "samthru" },
	{ 0xa4, "sambank" },
};

static struct extension const maestro_extension = {
	'D',
	0,
	"Maestro",
	"maestro",
	maestro_instructions,
	ARRAY_SIZE(maestro_instructions)
};

/* STOS Squasher: 2 commands */
static struct instruction const squasher_instructions[] = {
	{ 0x80, "unsquash" },
	{ 0x81, "squash" },
};

static struct extension const squasher_extension = {
	'E',
	0,
	"Squasher",
	"squasher",
	squasher_instructions,
	ARRAY_SIZE(squasher_instructions)
};


/* STE extension: 35 commands */
static struct instruction const ste_instructions[] = {
	{ 0x80, "sticks on" },
	{ 0x81, "stick1" },
	{ 0x82, "sticks off" },
	{ 0x83, "stick2" },
	{ 0x84, "dac convert" },
	{ 0x85, "l stick" },
	{ 0x86, "dac raw" },
	{ 0x87, "r stick" },
	{ 0x88, "dac speed" },
	{ 0x89, "u stick" },
	{ 0x8a, "dac stop" },
	{ 0x8b, "d stick" },
	{ 0x8c, "dac m volume" },
	{ 0x8d, "f stick" },
	{ 0x8e, "dac l volume" },
	{ 0x8f, "light x" },
	{ 0x90, "dac r volume" },
	{ 0x91, "light y" },
	{ 0x92, "dac treble" },
	{ 0x93, "ste" },
	{ 0x94, "dac bass" },
	{ 0x95, "e color" },
	{ 0x96, "dac mix on" },
	{ 0x97, "hard physic" },
	{ 0x98, "dac mix off" },
	/* unused */
	{ 0x9a, "dac mono" },
	/* 0x9b unused */
	{ 0x9c, "dac stereo" },
	/* 0x9d unused */
	{ 0x9e, "dac loop on" },
	/* 0x9f unused */
	{ 0xa0, "dac loop off" },
	/* 0xa1 unused */
	{ 0xa2, " e palette" },
	/* 0xa3 unused */
	{ 0xa4, "e colour" },
	/* 0xa5 unused */
	{ 0xa6, "hard screen size" },
	/* 0xa7 unused */
	{ 0xa8, "hard screen offset" },
	/* 0xa9 unused */
	{ 0xaa, "hard screen offset" },
	/* 0xab unused */
	{ 0xac, "hard screen offset" },
};

static struct extension const ste_extension = {
	'F',
	0,
	"STE extension",
	"ste_extn",
	ste_instructions,
	ARRAY_SIZE(ste_instructions)
};


/* Blitter Extension. v 1.1 by Ambrah */
static struct instruction const blitter_instructions[] = {
	{ 0x80, "blit halftone" },
	{ 0x81, "blit busy" },
	{ 0x82, "blit source x inc" },
	{ 0x83, "blitter" },
	{ 0x84, "blit source y inc" },
	{ 0x85, "blit remain" },
	{ 0x86, "blit source address" },
	/* 0x87 unused */
	{ 0x88, "blit dest x inc" },
	/* 0x89 unused */
	{ 0x8a, "blit dest y inc" },
	/* 0x8b unused */
	{ 0x8c, "blit dest address" },
	/* 0x8d unused */
	{ 0x8e, "blit endmask 1" },
	/* 0x8f unused */
	{ 0x90, "blit endmask 2" },
	/* 0x91 unused */
	{ 0x92, "blit endmask 3" },
	/* 0x93 unused */
	{ 0x94, "blit x count" },
	/* 0x95 unused */
	{ 0x96, "blit y count" },
	/* 0x97 unused */
	{ 0x98, "blit hop" },
	/* 0x99 unused */
	{ 0x9a, "blit op" },
	/* 0x9b unused */
	{ 0x9c, "blit h line" },
	/* 0x9d unused */
	{ 0x9e, "blit smudge" },
	/* 0x9f unused */
	{ 0xa0, "blit hog" },
	/* 0xa1 unused */
	{ 0xa2, " blit it" },
	/* 0xa3 unused */
	{ 0xa4, "blit skew" },
	/* 0xa5 unused */
	{ 0xa6, "blit nfsr" },
	/* 0xa7 unused */
	{ 0xa8, "blit fxsr" },
	/* 0xa9 unused */
	{ 0xaa, "blit cls" },
	/* 0xab unused */
	{ 0xac, "blit copy" },
	/* 0xad unused */
	{ 0xae, "about blitter" },
};

static struct extension const blitter_extension = {
	'G',
	0,
	"Blitter extension",
	"blitter",
	blitter_instructions,
	ARRAY_SIZE(blitter_instructions)
};

/* STORM/GBP blitter extension: 18 commands */
static struct instruction const gbpblitter_instructions[] = {
	{ 0x80, "blit sinc" },
	{ 0x81, "blit clr" },
	{ 0x82, "blit dinc" },
	{ 0x83, "blit fskopy" },
	{ 0x84, "blit address" },
	/* 0x85 unused */
	{ 0x86, "blit mask" },
	/* 0x87 unused */
	{ 0x88, "blit count" },
	/* 0x89 unused */
	{ 0x8a, "blit hop" },
	/* 0x8b unused */
	{ 0x8c, "blit op" },
	/* 0x8d unused */
	{ 0x8e, "blit skew" },
	/* 0x8f unused */
	{ 0x90, "blit nfsr" },
	/* 0x91 unused */
	{ 0x92, "blit fxsr" },
	/* 0x93 unused */
	{ 0x94, "blit line" },
	/* 0x95 unused */
	{ 0x96, "blit smudge" },
	/* 0x97 unused */
	{ 0x98, "blit hog" },
	/* 0x99 unused */
	{ 0x9a, "blit it" },
	/* 0x9b unused */
	{ 0x9c, "fcopy" },
	/* 0x9c unused */
	{ 0x9d, "cls" },
};

static struct extension const gbpblitter_extension = {
	'G',
	0,
	"GBP Blitter extension",
	"blitter",
	gbpblitter_instructions,
	ARRAY_SIZE(gbpblitter_instructions)
};

/* Stars: 4 commands */
static struct instruction const stars_instructions[] = {
	{ 0x80, "set stars" },
	/* 0x81 unused */
	{ 0x82, "go stars" },
	/* 0x83 unused */
	{ 0x84, "wipe stars on" },
	/* 0x85 unused */
	{ 0x86, "wipe stars off" },
	/* 0x87 unused */
	{ 0x88, "stars cmds" },
};

static struct extension const stars_extension = {
	'H',
	0,
	"Stars",
	"stars",
	stars_instructions,
	ARRAY_SIZE(stars_instructions)
};


/* GEM text */
static struct instruction const gemtext_instructions[] = {
	{ 0x80, "gemtext init" },
	{ 0x81, "gemfont name$" },
	{ 0x82, "gemtext color" },
	{ 0x83, "gemfont cellwidth" },
	{ 0x84, "gemtext mode" },
	{ 0x85, "gemfont cellheight" },
	{ 0x86, "gemtext style" },
	{ 0x87, "gemtext stringwidth" },
	{ 0x88, "gemtext angle" },
	{ 0x89, "gemfont convert" },
	{ 0x8a, "gemtext font" },
	{ 0x8b, "gemfont info" },
	{ 0x8c, "gemtext scale" },
	/* 0x8d unused */
	{ 0x8e, "gemtext" },
	/* 0x8f unused */
	{ 0x90, "gemfont load" },
	/* 0x91 unused */
	{ 0x92, "gemfont cmds" },
};

static struct extension const gemtext_extension = {
	'L',
	0,
	"GEM text",
	"gem_txt",
	gemtext_instructions,
	ARRAY_SIZE(gemtext_instructions)
};


/* Misty: 21 commands */
static struct instruction const misty_instructions[] = {
	{ 0x80, "fastcopy" },
	{ 0x81, "col" },
	{ 0x82, "floprd" },
	{ 0x83, "mediach" },
	{ 0x84, "flopwrt" },
	{ 0x85, "hardkey" },
	{ 0x86, "dot" },
	{ 0x87, "ndrv" },
	{ 0x88, "mouseoff" },
	{ 0x89, "freq" },
	{ 0x8a, "mouseon" },
	{ 0x8b, "resvalid" },
	{ 0x8c, "skopy" },
	{ 0x8d, "aesin" },
	{ 0x8e, "setrtim" },
	{ 0x8f, "rtim" },
	{ 0x90, "warmboot" },
	{ 0x91, "blitter" },
	{ 0x92, "silence" },
	{ 0x93, "kbshift" },
	{ 0x94, "kopy" },
};

static struct extension const misty_extension = {
	'M',
	0,
	"Misty",
	"misty",
	misty_instructions,
	ARRAY_SIZE(misty_instructions)
};


/* MIDI: 5 commands */
static struct instruction const midi_instructions[] = {
	{ 0x80, "midi on" },
	{ 0x81, "midi in" },
	{ 0x82, "midi off" },
	/* 0x83 unused */
	{ 0x84, "midi out" },
	/* 0x85 unused */
	{ 0x86, "about musician" },
};

static struct extension const midi_extension = {
	'M',
	0,
	"MIDI",
	"midi",
	midi_instructions,
	ARRAY_SIZE(midi_instructions)
};


/* GBP: 32 commands */
static struct instruction const gbp_instructions[] = {
	{ 0x80, "lights on" },
	{ 0x81, "pready" },
	{ 0x82, "lights off" },
	{ 0x83, "xpen" },
	{ 0x84, "fastwipe" },
	{ 0x85, "paktype" },
	{ 0x86, "dac volume" },
	{ 0x87, "even" },
	{ 0x88, "setpal" },
	{ 0x89, "setprt" },
	{ 0x8a, "d crunch" },
	{ 0x8b, "eplace" },
	{ 0x8c, "elite unpack" },
	{ 0x8d, "foffset" },
	{ 0x8e, "estop" },
	{ 0x8f, "jar" },
	{ 0x90, "mirror" },
	{ 0x91, "percent" },
	{ 0x92, "tiny unpack" },
	{ 0x93, "paksize" },
	{ 0x94, "treble" },
	{ 0x95, "special key" },
	{ 0x96, "bass" },
	{ 0x97, "fstart" },
	{ 0x98, "hcopy" },
	{ 0x99, "flength" },
	{ 0x9a, "ca unpack" },
	{ 0x9b, "ca pack" },
	{ 0x9c, "bcls" },
	{ 0x9d, "cookie" },
	{ 0x9e, "eplay" },
	{ 0x9f, "ypen" },
};

static struct extension const gbp_extension = {
	'P',
	0,
	"GBP",
	"gbp",
	gbp_instructions,
	ARRAY_SIZE(gbp_instructions)
};


/* Protracker: 3 commands */
static struct instruction const protracker_instructions[] = {
	{ 0x80, "propack" },
	{ 0x81, "mpack" },
	/* 0x82 unused */
	{ 0x83, "munpack" },
};

static struct extension const protracker_extension = {
	'P',
	0,
	"Pro Tracker",
	"propack",
	protracker_instructions,
	ARRAY_SIZE(protracker_instructions)
};


/* Falcon FLI extension: 8 commands */
static struct instruction const falcon_fli_instructions[] = {
	{ 0x80, "_fli bank" },
	{ 0x81, "_fli framewidth" },
	{ 0x82, "_fli screen" },
	{ 0x83, "_fli frameheight" },
	{ 0x84, "_fli play" },
	{ 0x85, "_fli frames" },
	{ 0x86, "_fli stop" },
	{ 0x87, "_fli frame" },
};

static struct extension const falcon_fli_extension = {
	'P',
	0,
	"Falcon FLI",
	"falc_fli",
	falcon_fli_instructions,
	ARRAY_SIZE(falcon_fli_instructions)
};


/* Missing Link: 33 commands (link1) */
static struct instruction const mislink1_instructions[] = {
	{ 0x80, "landscape" },
	{ 0x81, "overlap" },
	{ 0x82, "bob" },
	{ 0x83, "map toggle" },
	{ 0x84, "wipe" },
	{ 0x85, "boundary" },
	{ 0x86, "tile" },
	{ 0x87, "palt" },
	{ 0x88, "world" },
	{ 0x89, "musauto" },
	{ 0x8a, "musplay" },
	{ 0x8b, "which block" },
	{ 0x8c, "relocate" },
	{ 0x8d, "p left" },
	{ 0x8e, "p on" },
	{ 0x8f, "p joy" },
	{ 0x90, "p stop" },
	{ 0x91, "p up" },
	{ 0x92, "set block" },
	{ 0x93, "p right" },
	{ 0x94, "palsplit" },
	{ 0x95, "p down" },
	{ 0x96, "floodpal" },
	{ 0x97, "p fire" },
	{ 0x98, "digi play" },
	{ 0x99, "string" },
	{ 0x9a, "samsign" },
	{ 0x9b, "depack" },
	{ 0x9c, "replace blocks" },
	{ 0x9d, "dload" },
	{ 0x9e, "display pc1" },
	{ 0x9f, "dsave" },
	{ 0xa0, "honesty" },
};

static struct extension const mislink1_extension = {
	'Q',
	0,
	"Missing Link 1",
	"link1",
	mislink1_instructions,
	ARRAY_SIZE(mislink1_instructions)
};


/* Ninja Tracker: 9 commands */
static struct instruction const ninja_instructions[] = {
	{ 0x80, "track play" },
	{ 0x81, "vu meter" },
	{ 0x82, "track frequency" },
	{ 0x83, "track pos" },
	{ 0x84, "track info" },
	{ 0x85, "track pattern" },
	/* 0x86 unused */
	{ 0x87, "track key" },
	{ 0x88, "track unpack" },
	{ 0x89, "track name" },
};

static struct extension const ninja_extension = {
	'Q',
	0,
	"Ninja Tracker",
	"tracker",
	ninja_instructions,
	ARRAY_SIZE(ninja_instructions)
};

/* Missing Link: 28 commands (link2) */
static struct instruction const mislink2_instructions[] = {
	{ 0x80, "joey" },
	{ 0x81, "b height" },
	{ 0x82, "blit" },
	{ 0x83, "b width" },
	{ 0x84, "spot" },
	{ 0x85, "block amount" },
	{ 0x86, "reflect" },
	{ 0x87, "compstate" },
	{ 0x88, "mozaic" },
	{ 0x89, "x limit" },
	{ 0x8a, "xy block" },
	{ 0x8b, "y limit" },
	{ 0x8c, "text" },
	{ 0x8d, "mostly harmless" },
	{ 0x8e, "wash" },
	{ 0x8f, "real length" },
	{ 0x90, "reboot" },
	{ 0x91, "brightest" },
	{ 0x92, "bank load" },
	{ 0x93, "bank length" },
	{ 0x94, "bank copy" },
	{ 0x95, "bank size" },
	{ 0x96, "m blit" },
	{ 0x97, "win block amount" },
	{ 0x98, "replace range" },
	/* { 0x99, "empty" }, */
	{ 0x9a, "win replace blocks" },
	/* { 0x9b, "empty2" }, */
	{ 0x9c, "win replace range" },
	/* { 0x9d, "empty3" }, */
	{ 0x9e, "win xy block" },
};

static struct extension const mislink2_extension = {
	'R',
	0,
	"Missing Link 2",
	"link2",
	mislink2_instructions,
	ARRAY_SIZE(mislink2_instructions)
};


/* Missing Link: 13 commands (link3) */
static struct instruction const mislink3_instructions[] = {
	{ 0x80, "many add" },
	{ 0x81, "many overlap" },
	{ 0x82, "many sub" },
	/* { 0x83, "function2" }, */
	{ 0x84, "many bob" },
	/* { 0x85, "function3" }, */
	{ 0x86, "many joey" },
	{ 0x87, "hertz" },
	{ 0x88, "set hertz" },
	/* { 0x89, "function4" }, */
	{ 0x8a, "many inc" },
	/* { 0x8b, "function5" }, */
	{ 0x8c, "many dec" },
	/* { 0x8d, "function6" }, */
	{ 0x8e, "raster" },
	/* { 0x8f, "function7" }, */
	{ 0x90, "bullet" },
	/* { 0x91, "function8" }, */
	{ 0x92, "many bullet" },
	/* { 0x93, "function9" }, */
	{ 0x94, "many spot" },
};

static struct extension const mislink3_extension = {
	'S',
	0,
	"Missing Link 3",
	"link3",
	mislink3_instructions,
	ARRAY_SIZE(mislink3_instructions)
};


/* STOS 3D: 59 commands */
static struct instruction const stos3d_instructions[] = {
	{ 0x80, "td priority" },
	{ 0x81, "td visible" },
	{ 0x82, "td load" },
	{ 0x83, "td range" },
	{ 0x84, "td clear all" },
	{ 0x85, "td position x" },
	{ 0x86, "td object" },
	{ 0x87, "td position y" },
	{ 0x88, "td screen height" },
	{ 0x89, "td position z" },
	{ 0x8a, "td kill" },
	{ 0x8b, "td attitude a" },
	{ 0x8c, "td move x" },
	{ 0x8d, "td attitude b" },
	{ 0x8e, "td move y" },
	{ 0x8f, "td attitude b" },
	{ 0x90, "td move z" },
	{ 0x91, "td collide" },
	{ 0x92, "td move rel" },
	{ 0x93, "td zone x" },
	{ 0x94, "td move" },
	{ 0x95, "td zone y" },
	{ 0x96, "td angle a" },
	{ 0x97, "td zone z" },
	{ 0x98, "td angle b" },
	{ 0x99, "td zone r" },
	{ 0x9a, "td angle c" },
	{ 0x9b, "td world x" },
	{ 0x9c, "td angle rel" },
	{ 0x9d, "td world y" },
	{ 0x9e, "td angle" },
	{ 0x9f, "td world z" },
	/* 0xa0 unused */
	{ 0xa1, "td view x" },
	{ 0xa2, "td delete zone" },
	{ 0xa3, "td view y" },
	{ 0xa4, "td redraw" },
	{ 0xa5, "td view z" },
	{ 0xa6, "td set zone" },
	{ 0xa7, "td screen x" },
	{ 0xa8, "td cls" },
	{ 0xa9, "td screen y" },
	{ 0xaa, "td background" },
	{ 0xab, "td bearing a" },
	{ 0xac, "td dir" },
	{ 0xad, "td bearing b" },
	{ 0xae, "td set colour" },
	{ 0xaf, "td bearing r" },
	{ 0xb0, "td anim rel" },
	{ 0xb1, "td anim point x" },
	{ 0xb2, "td init" },
	{ 0xb3, "td anim point y" },
	{ 0xb4, "td face" },
	{ 0xb5, "td anim point z" },
	{ 0xb6, "td forward" },
	{ 0xb7, "td advanced" },
	/* 0xb8 unused */
	{ 0xb9, "td debug" },
	{ 0xba, "td anim" },
	/* 0xbb unused */
	{ 0xbc, "td surface points" },
	/* 0xbd unused */
	{ 0xbe, "td surface" },
};

static struct extension const stos3d_extension = {
	'S',
	0,
	"STOS 3D",
	"3d",
	stos3d_instructions,
	ARRAY_SIZE(stos3d_instructions)
};


/* STOS Tracker: 9 commands (track_7/track_10/track_14) */
static struct instruction const tracker7_instructions[] = {
	{ 0x80, "track load" },
	{ 0x81, "track scan" },
	{ 0x82, "track bank" },
	{ 0x83, "track vu" },
	{ 0x84, "track play" },
	/* 0x85 unused */
	{ 0x86, "track key" },
	/* 0x87 unused */
	{ 0x88, "track volume" },
	/* 0x89 unused */
	{ 0x8a, "track tempo" },
	/* 0x8b unused */
	{ 0x8c, "track stop" },
};

static struct extension const tracker7_extension = {
	'S', /* track_10 sometimes has 'T' extension character */
	0,
	"STOS Tracker",
	"track_7",
	tracker7_instructions,
	ARRAY_SIZE(tracker7_instructions)
};


/* 3D menu */
static struct instruction const threed_instructions[] = {
	{ 0x80, "_fmenu init" },
	{ 0x81, "_fmenu select" },
	{ 0x82, "_fmenu on" },
	{ 0x83, "_fmenu item" },
	{ 0x84, "_fmenu$ off" },
	{ 0x85, "_fmenu height" },
	{ 0x86, "_fmenu$ on" },
	/* 0x87 unused */
	{ 0x88, "_fmenu$" },
	/* 0x89 unused */
	{ 0x8a, "_fmenu kill" },
	/* 0x8b unused */
	{ 0x8c, "_fmenu freeze" },
	/* 0x8d unused */
	{ 0x8e, "_fmenu uncheck item" },
	/* 0x8f unused */
	{ 0x90, "_fmenu check item" },
	{ 0x91, "_form alert" },
	{ 0x92, "_fmenu cmds" },
};

static struct extension const threed_extension = {
	'U',
	0,
	"3D menu",
	"3d_menu",
	threed_instructions,
	ARRAY_SIZE(threed_instructions)
};


/* Falcon gfx3 */
static struct instruction const falcon_gfx3_instructions[] = {
	{ 0x80, "_falc pen" },
	{ 0x81, "_falc xcurs" },
	{ 0x82, "_falc paper" },
	{ 0x83, "_falc ycurs" },
	{ 0x84, "_falc locate" },
	{ 0x85, "_stos charwidth" },
	{ 0x86, "_falc print" },
	{ 0x87, "_stos charheight" },
	{ 0x88, "_stosfont" },
	{ 0x89, "_falc multipen status" },
	{ 0x8a, "_falc multipen off" },
	{ 0x8b, "_charset addr" },
	{ 0x8c, "_falc multipen on" },
	{ 0x8d, "_tc rgb" },
	{ 0x8e, "_falc ink" },
	/* 0x8f unused */
	{ 0x90, "_falc draw mode" },
	{ 0x91, "_get pixel" },
	{ 0x92, "_def linepattern" },
	/* 0x93 unused */
	{ 0x94, "_def stipple" },
	/* 0x95 unused */
	{ 0x96, "_falc plot" },
	/* 0x97 unused */
	{ 0x98, "_falc line" },
	/* 0x99 unused */
	{ 0x9a, "_falc box" },
	/* 0x9b unused */
	{ 0x9c, "_falc bar" },
	/* 0x9d unused */
	{ 0x9e, "_falc polyline" },
	/* 0x9f unused */
	{ 0xa0, "_falc centre" },
	/* 0xa1 unused */
	{ 0xa2, "_falc polyfill" },
	/* 0xa3 unused */
	{ 0xa4, "_falc contourfill" },
	/* 0xa5 unused */
	{ 0xa6, "_falc circle" },
	/* 0xa7 unused */
	{ 0xa8, "_falc ellipse" },
	/* 0xa9 unused */
	{ 0xaa, "_falc earc" },
	/* 0xab unused */
	{ 0xac, "_falc arc" },
};

static struct extension const falcon_gfx3_extension = {
	'V',
	0,
	"Falcon Graphics",
	"falcgfx3",
	falcon_gfx3_instructions,
	ARRAY_SIZE(falcon_gfx3_instructions)
};


/* Control: 61 commands */
static struct instruction const control_instructions[] = {
	{ 0x80, "switch on" },
	{ 0x81, "case" },
	{ 0x82, "switch off" },
	{ 0x83, "otherwise" },
	{ 0x84, "cmove" },
	/* 0x85 unused */
	{ 0x86, "write" },
	{ 0x87, "parallel" },
	{ 0x88, "cremember" },
	{ 0x89, "para fire" },
	{ 0x8a, "crecall" },
	{ 0x8b, "add" },
	{ 0x8c, "ctrl" },
	{ 0x8d, "test megazone" },
	{ 0x8e, "para on" },
	{ 0x8f, "para up" },
	{ 0x90, "para off" },
	{ 0x91, "para down" },
	{ 0x92, "init megazone" },
	{ 0x93, "para left" },
	{ 0x94, "set megazone" },
	{ 0x95, "klatu" },
	{ 0x96, "range megazone" },
	{ 0x97, "exist$" },
	{ 0x98, "map write" },
	/* 0x99 unused */
	{ 0x9a, "spread" },
	{ 0x9b, "para right" },
	{ 0x9c, "brdr remove" },
	{ 0x9d, "crack pac" },
	{ 0x9e, "crack unpac" },
	{ 0x9f, "map address" },
	{ 0xa0, "quick screen" },
	{ 0xa1, "klatu" },
	{ 0xa2, "font" },
	{ 0xa3, "map h" },
	{ 0xa4, "image put" },
	{ 0xa5, "map w" },
	{ 0xa6, "screen size" },
	{ 0xa7, "klatu" },
	{ 0xa8, "hscroll" },
	{ 0xa9, "image width" },
	{ 0xaa, "image palette" },
	{ 0xab, "image height" },
	{ 0xac, "many image" },
	{ 0xad, "map read" },
	{ 0xae, "set clip" },
	{ 0xaf, "klatu" },
	{ 0xb0, "turbocopy" },
	{ 0xb1, "klatu" },
	{ 0xb2, "bigcls" },
	{ 0xb3, "inside" },
	{ 0xb4, "bigcopy" },
	{ 0xb5, "image collide" },
	{ 0xb6, "screen offset" },
	{ 0xb7, "image mcollide" },
	{ 0xb8, "cylinder" },
	{ 0xb9, "klatu" },
	{ 0xba, "image map" },
	{ 0xbb, "jagjoy" },
	{ 0xbc, "set map" },
	{ 0xbd, "klatu" },
	{ 0xbe, "image offset" },
};

static struct extension const control_extension = {
	'W',
	EXTIF_CONTROL,
	"Control",
	"control",
	control_instructions,
	ARRAY_SIZE(control_instructions)
};


/* Falcon sys_ctrl extension */
static struct instruction const falcon_control_instructions[] = {
	{ 0x80, "coldboot" },
	{ 0x81, "cookieptr" },
	{ 0x82, "warmboot" },
	{ 0x83, "cookie" },
	{ 0x84, "caps on" },
	{ 0x85, "_tos$" },
	{ 0x86, "caps off" },
	{ 0x87, "_phystop" },
	{ 0x88, "_cpuspeed" },
	{ 0x89, "_memtop" },
	{ 0x8a, "_blitterspeed" },
	{ 0x8b, "_busmode" },
	{ 0x8c, "_stebus" },
	{ 0x8d, "paddle x" },
	{ 0x8e, "_falconbus" },
	{ 0x8f, "paddle y" },
	{ 0x90, "_cpucache on" },
	{ 0x91, "_cpucache stat" },
	{ 0x92, "_cpucache off" },
	{ 0x93, "lpen x" },
	{ 0x94, "ide on" },
	{ 0x95, "lpen y" },
	{ 0x96, "ide off" },
	{ 0x97, "_nemesis" },
	{ 0x98, "_set printer" },
	{ 0x99, "_printer ready" },
	{ 0x9a, "_file attr" },
	{ 0x9b, "kbshift" },
	{ 0x9c, "code$" },
	{ 0x9d, "_aes in" },
	{ 0x9e, "uncode$" },
	{ 0x9f, "_file exist" },
	/* 0xa0 unused */
	{ 0xa1, "_add cbound" },
	{ 0xa2, "lset$" },
	{ 0xa3, "_sub cbound" },
	{ 0xa4, "rset$" },
	{ 0xa5, "_add ubound" },
	{ 0xa6, "st mouse on" },
	{ 0xa7, "_sub lbound" },
	{ 0xa8, "st mouse off" },
	{ 0xa9, "odd" },
	{ 0xaa, "st mouse colour" },
	{ 0xab, "even" },
	{ 0xac, "_limit st mouse" },
	{ 0xad, "st mouse stat" },
	{ 0xae, "st mouse" },
	{ 0xaf, "_fileselect$" },
	/* 0xb0 unused */
	{ 0xb1, "_jagpad direction" },
	/* 0xb2 unused */
	{ 0xb3, "_jagpad fire" },
	/* 0xb4 unused */
	{ 0xb5, "_jagpad pause" },
	/* 0xb6 unused */
	{ 0xb7, "_jagpad option" },
	/* 0xb8 unused */
	{ 0xb9, "_jagpad key$" },
	{ 0xba, "_joysticks on" },
	{ 0xbb, "_joyfire" },
	{ 0xbc, "_joysticks off" },
	{ 0xbd, "_joystick" },
	{ 0xbe, "sys cmds" },
};

static struct extension const falcon_control_extension = {
	'W',
	EXTIF_SYSCTRL,
	"Falcon Control",
	"sys_ctrl",
	falcon_control_instructions,
	ARRAY_SIZE(falcon_control_instructions)
};


/* Falcon video */
static struct instruction const falcon_vid_instructions[] = {
	{ 0x80, "vsetmode" },
	{ 0x81, "vgetmode" },
	{ 0x82, "_falc cls" },
	{ 0x83, "vgetsize" },
	{ 0x84, "vgetpalt" },
	{ 0x85, "montype" },
	{ 0x86, "vsetpalt" },
	{ 0x87, "whichmode" },
	{ 0x88, "_get spritepalette" },
	{ 0x89, "scr width" },
	{ 0x8a, "_hardphysic" },
	{ 0x8b, "scr height" },
	{ 0x8c, "_setcolour" },
	{ 0x8d, "_getcolour" },
	{ 0x8e, "_get st palette" },
	{ 0x8f, "_falc rgb" },
	{ 0x90, "palfade in" },
	{ 0x91, "_falc palt" },
	{ 0x92, "palfade out" },
	{ 0x93, "darkest" },
	{ 0x94, "quickwipe" },
	{ 0x95, "brightest" },
	{ 0x96, "ilbmpalt" },
	{ 0x97, "_get red" },
	{ 0x98, "_shift off" },
	{ 0x99, "_get green" },
	{ 0x9a, "_shift" },
	{ 0x9b, "_get blue" },
	/* 0x9c unused */
	{ 0x9d, "vget ilbm mode" },
	/* 0x9e unused */
	{ 0x9f, "dpack ilbm" },
	/* 0xa0 unused */
	{ 0xa1, "fmchunk" },
	/* 0xa2 unused */
	{ 0xa3, "_falc zone" },
	/* 0xa4 unused */
	{ 0xa5, "ilbmchunk" },
	{ 0xa6, "_reset falc zone" },
	{ 0xa7, "bmhdchunk" },
	{ 0xa8, "_set falc zone" },
	{ 0xa9, "cmapchunk" },
	{ 0xaa, "_paste pi1" },
	{ 0xab, "bodychunk" },
	{ 0xac, "_bitblit" },
	/* 0xad unused */
	{ 0xae, "_convert pi1" },
};

static struct extension const falcon_vid_extension = {
	'X',
	0,
	"Falcon Video",
	"falc_vid",
	falcon_vid_instructions,
	ARRAY_SIZE(falcon_vid_instructions)
};


/* Falcon sound */
static struct instruction const falcon_snd_instructions[] = {
	{ 0x80, "dma reset" },
	{ 0x81, "locksound" },
	{ 0x82, "dma buffer" },
	{ 0x83, "unlocksound" },
	{ 0x84, "devconnect" },
	{ 0x85, "dma status" },
	{ 0x86, "dma samsign" },
	{ 0x87, "dma samrecptr" },
	{ 0x88, "dma setmode" },
	{ 0x89, "dma samplayptr" },
	{ 0x8a, "dma samtracks" },
	{ 0x8b, "dma samstatus" },
	{ 0x8c, "dma montrack" },
	{ 0x8d, "dma samtype" },
	{ 0x8e, "dma interrupt" },
	{ 0x8f, "dma samfreq" },
	{ 0x90, "dma samrecord" },
	{ 0x91, "dma sammode" },
	{ 0x92, "dma playloop off" },
	{ 0x93, "dma sampval" },
	{ 0x94, "dma playloop on" },
	{ 0x95, "dma samconvert" },
	{ 0x96, "dma samplay" },
	{ 0x97, "dma samsize" },
	{ 0x98, "dma samthru" },
	/* 0x99 unused */
	{ 0x9a, "dma samstop" },
	/* 0x9b unused */
	{ 0x9c, "adder in" },
	/* 0x9d unused */
	{ 0x9e, "adc input" },
	/* 0x9f unused */
	/* 0xa0 unused */
	/* 0xa1 unused */
	{ 0xa2, "left gain" },
	/* 0xa3 unused */
	{ 0xa4, "right gain" },
	/* 0xa5 unused */
	{ 0xa6, "left volume" },
	/* 0xa7 unused */
	{ 0xa8, "right volume" },
	/* 0xa9 unused */
	{ 0xaa, "speaker off" },
	/* 0xab unused */
	{ 0xac, "speaker on" },
};

static struct extension const falcon_snd_extension = {
	'Y',
	0,
	"Falcon Sound",
	"falc_snd",
	falcon_snd_instructions,
	ARRAY_SIZE(falcon_snd_instructions)
};


/* Cyber: 2 commands */
static struct instruction const cyber_instructions[] = {
	{ 0x80, "cyber" },
	/* 0x81 unused */
	{ 0x82, "view cyber" },
};


static struct extension const cyber_extension = {
	'Y',
	0,
	"Cyber",
	"cyber",
	cyber_instructions,
	ARRAY_SIZE(cyber_instructions)
};


/* Falcon tracker mod */
static struct instruction const falcon_mod_instructions[] = {
	{ 0x80, "_tracker reset" },
	{ 0x81, "_tracker init" },
	{ 0x82, "_tracker play" },
	{ 0x83, "_tracker title$" },
	{ 0x84, "_tracker loop on" },
	{ 0x85, "_tracker format$" },
	{ 0x86, "_tracker loop off" },
	{ 0x87, "_tracker startaddress" },
	{ 0x88, "_tracker stop" },
	{ 0x89, "_tracker size" },
	{ 0x8a, "_tracker pause" },
	{ 0x8b, "_tracker songlength" },
	{ 0x8c, "_tracker speed" },
	{ 0x8d, "_tracker instruments max" },
	{ 0x8e, "_tracker volume" },
	{ 0x8f, "_tracker status" },
	{ 0x90, "_tracker copy" },
	{ 0x91, "_tracker songpos" },
	/* 0x92 unused */
	{ 0x93, "_tracker pattpos" },
	{ 0x94, "_tracker ffwd" },
	{ 0x95, "_tracker sample title$" },
	{ 0x96, "_tracker songprev" },
	{ 0x97, "_tracker voices" },
	{ 0x98, "_tracker songnext" },
	{ 0x99, "_tracker vu" },
	/* 0x9a unused */
	{ 0x9b, "_tracker spectrum" },
	/* 0x9c unused */
	{ 0x9d, "_tracker maxsize" },
	/* 0x9e unused */
	{ 0x9f, "_tracker howmany" },
	/* 0xa0 unused */
	{ 0xa1, "_tracker packed" },
	{ 0xa2, "_tracker depack" },
	{ 0xa3, "_tracker filelength" },
	{ 0xa4, "_tracker load" },
	{ 0xa5, "_tracker instruments used" },
	{ 0xa6, "_tracker scope init" },
	{ 0xa7, "_tracker patt info$" },
	{ 0xa8, "_tracker scope draw" },
	{ 0xa9, "_tracker tempo" },
};

static struct extension const falcon_mod_extension = {
	'Z',
	0,
	"Falcon DSP",
	"falc_mod",
	falcon_mod_instructions,
	ARRAY_SIZE(falcon_mod_instructions)
};


/* Extra: 61 commands */
static struct instruction const extra_instructions[] = {
	{ 0x80, "extra" },
	{ 0x81, "prntr" },
	{ 0x82, "caps lock on" },
	{ 0x83, "ndrv" },
	{ 0x84, "caps lock on" },
	{ 0x85, "write protected" },
	{ 0x86, "swp col" },
	{ 0x87, "gemdos version$" },
	{ 0x88, "screen dump" },
	{ 0x89, "os version$" },
	{ 0x8a, "disk verify on" },
	{ 0x8b, "left shift key" },
	{ 0x8c, "disk verify off" },
	{ 0x8d, "right shift key" },
	{ 0x8e, "fmt disc" },
	{ 0x8f, "cntrl key" },
	{ 0x90, "cpy disc" },
	{ 0x91, "alt key" },
	{ 0x92, "visible input" },
	{ 0x93, "caps lock" },
	{ 0x94, "blur" },
	{ 0x95, "screen hz" },
	{ 0x96, "set rs232" },
	{ 0x97, "media status" },
	{ 0x98, "deshade" },
	{ 0x99, "power" },
	{ 0x9a, "set printer data" },
	{ 0x9b, "cartridge input" },
	{ 0x9c, "hrev" },
	{ 0x9d, "disc sides" },
	{ 0x9e, "set fattrib" },
	{ 0x9f, "disc tracks" },
	/* 0xa0 unused */
	{ 0xa1, "cookie _cpu" },
	{ 0xa2, "pal inverse" },
	{ 0xa3, "disc spt" },
	{ 0xa4, "set screen hz" },
	/* 0xa5 unused */
	{ 0xa6, "pal change" },
	{ 0xa7, "fattrib" },
	{ 0xa8, "ppsc" },
	{ 0xa9, "cookie _mch" },
	{ 0xaa, "opaque screen" },
	{ 0xab, "compact" },
	{ 0xac, "vrev" },
	{ 0xad, "mem config" },
	{ 0xae, "desquash" },
	{ 0xaf, "disc verify" },
	{ 0xb0, "del" },
	{ 0xb1, "disc size" },
	{ 0xb2, "pload" },
	{ 0xb3, "disc free" },
	{ 0xb4, "disable mouse" },
	{ 0xb5, "disc used" },
	{ 0xb6, "enable mouse" },
	{ 0xb7, "vtab" },
	{ 0xb8, "screen squash" },
	{ 0xb9, "ltab" },
	{ 0xba, "label disc" },
	{ 0xbb, "setup of printer" },
	{ 0xbc, "rmv dup col" },
	/* 0xbd unused */
	{ 0xbe, "ren" },
	{ 0xbf, "fmt text" },
};

static struct extension const extra_extension = {
	'Z',
	0,
	"Extra",
	"extra",
	extra_instructions,
	ARRAY_SIZE(extra_instructions)
};





static const struct extension *const external_extensions[] = {
	&compaction_extension,
	&compiler_extension,
	&maestro_extension,
	&squasher_extension,
	&ste_extension,
	&blitter_extension,
	&gbpblitter_extension,
	&stars_extension,
	&gemtext_extension,
	&misty_extension,
	&midi_extension,
	&gbp_extension,
	&protracker_extension,
	&falcon_fli_extension,
	&mislink1_extension,
	&ninja_extension,
	&mislink2_extension,
	&mislink3_extension,
	&stos3d_extension,
	&tracker7_extension,
	&threed_extension,
	&falcon_gfx3_extension,
	&control_extension,
	&falcon_control_extension,
	&falcon_vid_extension,
	&falcon_snd_extension,
	&cyber_extension,
	&falcon_mod_extension,
	&extra_extension,
};




static int upperflag = FALSE;
static unsigned int extensions = EXTIF_SYSCTRL;
#define MAX_EXTENSIONS 26
static unsigned int unknown_extensions[MAX_EXTENSIONS + 1];
static unsigned int used_extensions[ARRAY_SIZE(external_extensions)];

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
	const struct extension *ext;
	char extension_char = 'A' + extension;
	unsigned int i, j;
	const struct instruction *inst;
	
	for (i = 0; i < ARRAY_SIZE(external_extensions); i++)
	{
		ext = external_extensions[i];
		if (ext->extension == extension_char)
		{
			if (ext->extension_if == 0 ||
				(extensions & ext->extension_if) != 0)
			{
				inst = ext->instructions;
				for (j = 0; j < ext->num_instructions; j++, inst++)
				{
					if (inst->opcode == opcode)
					{
						print_upper(inst->name, out);
						used_extensions[i]++;
						return;
					}
				}
			}
		}
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
	unsigned int i;
	int remflg;
	unsigned char opcode;
	unsigned char opcode2;
	int badfloat = 0;
	int first;

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

	for (i = 0; i < ARRAY_SIZE(used_extensions); i++)
		used_extensions[i] = 0;

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

	first = 1;
	for (i = 0; i < ARRAY_SIZE(used_extensions); i++)
	{
		if (used_extensions[i] != 0)
		{
			if (first)
			{
				fprintf(stderr, "\nUsed extensions:\n");
				first = 0;
			}
			fprintf(stderr, "%s (%s.ex%c)\n", external_extensions[i]->name, external_extensions[i]->filename, external_extensions[i]->extension - 'A' + 'a');
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
