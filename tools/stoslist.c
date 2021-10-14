#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>
#include <getopt.h>
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

static int upperflag = FALSE;

#define TOUPPER(c) (upperflag ? ((c) >= 'a' && (c) <= 'z' ? (c) - ('a' - 'A') : (c)) : (c))

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


static int32_t readbe32(FILE *fp)
{
	int32_t c1, c2, c3, c4;
	c1 = fgetc(fp);
	c2 = fgetc(fp);
	c3 = fgetc(fp);
	c4 = fgetc(fp);
	return (c1 << 24) | (c2 << 16) | (c3 << 8) | c4;
}


static void print_extfunc(unsigned char opcode, unsigned char opcode2, const struct token *tokens, FILE *out)
{
	const char *p;
	
	while (tokens->name != NULL)
	{
		if (tokens->val1 == opcode && tokens->val2 == opcode2)
		{
			p = tokens->name;
			while (*p)
			{
				putc(TOUPPER(*p), out);
				p++;
			}
			return;
		}
		tokens++;
	}
	fputs("ILLEGAL", out);
}


static void print_token(unsigned char opcode, const struct token *tokens, FILE *out)
{
	const char *p;
	
	while (tokens->name != NULL)
	{
		if (tokens->val1 == opcode)
		{
			p = tokens->name;
			while (*p)
			{
				putc(TOUPPER(*p), out);
				p++;
			}
			return;
		}
		tokens++;
	}
	fputs("ILLEGAL", out);
}


static int listfile(FILE *fp)
{
	FILE *out = stdout;
	struct basfile header;
	uint16_t linelength;
	uint16_t lineno;
	int32_t prglen;
	int i;
	int remflg;
	unsigned char opcode;
	unsigned char opcode2;
	
	if (fread(&header, sizeof(header), 1, fp) != 1)
	{
		fprintf(stderr, "read error\n");
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
					putc(TOUPPER(opcode), out);
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
							uint32_t hi;
							uint32_t lo;
							
							hi = readbe32(fp);
							lo = readbe32(fp);
							linelength -= 8;
							/* TODO: print float */
							fputs("0.0", out);
							(void) lo;
							(void) hi;
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
				int extensiono;
				int funcno;
				
				extensiono = fgetc(fp);
				funcno = fgetc(fp);
				linelength -= 2;
				/*
				 * TODO: load extensions
				 */
				fprintf(out, "extension #%c(0x%02x)", 'A' + extensiono, funcno);
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
		} else
		{
			listfile(fp);
			fclose(fp);
		}
	}
	return 0;
}
