dmainter   = $ff8900 /* XXX */
dmacontrol = $ff8901
trackcontrol = $ff8920
modecontrol = $ff8921

st_palette = $ff8240
st_shift   = $ff8260  /* ST shift mode */
st_hbits   = $ff8265  /* horizontal pixel scroll */
st_hoff    = $ff820e  /* horizontal offset */
st_dstride = $ff820f  /* width of a scanline */

joyfire    = $ff9201
joyport    = $ff9202

lightpen_x = $ff9220
lightpen_y = $ff9222

mwdata     = $ff8922
mwmask     = $ff8924

st_vach    = $ff8205	;.b video address counter hi
st_vacm	   = $ff8207	;.b video address counter mid
st_vacl	   = $ff8209	;.b video address counter lo

f_b_um     = $ff8903    ;. Frame start address (high byte)
f_b_lm     = $ff8905    ;. Frame start address (mid byte)
f_b_ll     = $ff8907    ;. Frame start address (low byte)

f_e_um     = $ff890f    ;. Frame end address (high byte)
f_e_lm     = $ff8911    ;. Frame end address (mid byte)
f_e_ll     = $ff8913    ;. Frame end address (low byte)

ikbdacia    = $fffc00

MICROWIRE_ADDRESS = 0x400
/* LMC1992 functions */
LMC1992_FUNCTION_INPUT_SELECT       = MICROWIRE_ADDRESS+0x000 /* 0<<6 */
LMC1992_FUNCTION_BASS               = MICROWIRE_ADDRESS+0x040 /* 1<<6 */
LMC1992_FUNCTION_TREBLE             = MICROWIRE_ADDRESS+0x080 /* 2<<6 */
LMC1992_FUNCTION_VOLUME             = MICROWIRE_ADDRESS+0x0c0 /* 3<<6 */
LMC1992_FUNCTION_RIGHT_FRONT_FADER  = MICROWIRE_ADDRESS+0x100 /* 4<<6 */
LMC1992_FUNCTION_LEFT_FRONT_FADER   = MICROWIRE_ADDRESS+0x140 /* 5<<6 */
LMC1992_FUNCTION_RIGHT_REAR_FADER   = MICROWIRE_ADDRESS+0x180 /* 6<<6 */
LMC1992_FUNCTION_LEFT_REAR_FADER    = MICROWIRE_ADDRESS+0x1c0 /* 7<<6 */

