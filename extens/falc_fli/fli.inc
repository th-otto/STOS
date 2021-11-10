	.offset 0
fli_size:       ds.l 1
fli_type:       ds.w 1
fli_frames:     ds.w 1
fli_width:      ds.w 1
fli_height:     ds.w 1
fli_depth:      ds.w 1
fli_flags:      ds.w 1
fli_speed:      ds.l 1
	ds.w 1
fli_created:    ds.l 1
fli_creator:    ds.l 1
fli_updated:    ds.l 1
fli_updater:    ds.l 1
fli_aspectx:    ds.w 1
fli_aspecty:    ds.w 1
	ds.b 38
fli_oframe1:    ds.l 1
fli_oframe2:    ds.l 1
	ds.b 40
fli_headersize:



FLI_MAGIC equ 0x11AF /* endian-swapped */
FLC_MAGIC equ 0x12AF /* endian-swapped */
FLI_FRAME_MAGIC equ 0xfaf1 /* endian-swapped */

FLI_COLOR_256 equ 4
FLI_DELTA_FLC equ 7
FLI_COLOR_64  equ 11
FLI_DELTA_FLI equ 12
FLI_BLACK     equ 13
FLI_BYTE_RUN  equ 15
FLI_COPY      equ 16
