; soundcmd() values
LTATTEN     = 0
RTATTEN     = 1
LTGAIN      = 2
RTGAIN      = 3
ADDERIN     = 4
   ADCIN    = 1
   MATIN    = 2
ADCINPUT    = 5
   ADCRT = 1
   ADCLT = 2
SETPRESCALE = 6
   PREMUTE  = 0
   PRE640   = 1
   PRE320   = 2
   PRE160   = 3

	.offset 0
avr_magic:      ds.l 1
avr_title:      ds.b 8
avr_stereo:     ds.w 1
avr_bits:       ds.w 1
avr_signed:     ds.w 1
avr_loop:       ds.w 1
avr_midi:       ds.w 1
avr_samprate:   ds.l 1
avr_length:     ds.l 1
avr_loopstart:  ds.l 1
avr_loopend:    ds.l 1
avr_keysplit:   ds.w 1
avr_compress:   ds.w 1
                ds.w 1
avr_titleextra: ds.b 20
avr_comment:    ds.b 64
avr_headersize:
AVR_MAGIC = 0x32424954  /* '2BIT' */

	.offset 0
wave_riffmagic: ds.l 1
wave_riffsize:  ds.l 1
wave_magic:     ds.l 1
wave_ckid:      ds.l 1
wave_cksize:    ds.l 1
wave_format:    ds.w 1
wave_channels:  ds.w 1 /* 22 */
wave_samprate:  ds.l 1 /* 24 */
wave_datarate:  ds.l 1 /* 28 */
wave_align:     ds.w 1 /* 32 */
wave_bits:      ds.w 1 /* 34 */
/* BUG: assumes that data chunk immediately follows */
wave_dataid:    ds.l 1
wave_datasize:  ds.l 1
wave_headersize:
WAVE_MAGIC = 0x57415645 /* 'WAVE' */
WAVE_FMT   = 0x666D7420 /* 'fmt ' */

MODE_STEREO8  = 0
MODE_STEREO16 = 1
MODE_MONO8    = 2

