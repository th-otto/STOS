	.offset 0
; address of a 512 byte buffer
ext_buffer:     .ds.l 1 ; 0x00

; address of fltoint function
; inputs:
;    d3/d4: float number
; outputs:
;    d3: integer value
ext_fltoint:    .ds.l 1 ; 0x04

; address of inttofl function
; inputs:
;    d3: integer value
; outputs:
;    d3/d4: float number
ext_inttofl:    .ds.l 1 ; 0x08

; address of a DTA buffer
ext_dta:        .ds.l 1 ; 0x0c

; address of files table
ext_files:      .ds.l 1 ; 0x10

; address of error function
; inputs:
;   d0.w: error number
; outputs:
;   -
ext_error:      .ds.l 1 ; 0x14

; address of error handler (close all files etc.)
; inputs:
;   -
; outputs:
;   -
ext_err2:       .ds.l 1 ; 0x18

; allocate some memory:
; inputs:
;   d3: size
; outputs:
;   d0.l: address
ext_demand:     .ds.l 1 ; 0x1c

; get address of memory bank
; inputs:
;   d1.l: program number (1-16)
;   d2.l: memory bank #
; outputs:
;   d3.l: address
ext_start:      .ds.l 1 ; 0x20

; get length of memory bank
; inputs:
;   d1.l: program number (1-16)
;   d2.l: memory bank #
; outputs:
;   d3.l: length
ext_leng:       .ds.l 1 ; 0x24

; memory copy
; inputs:
;   a2: source address (must be even)
;   a3: destination address (must be even)
;   d3.l: length
ext_transmem:   .ds.l 1 ; 0x28

; address of editor windows
ext_windows:    .ds.l 1 ; 0x2c

; address of interpreter execution jump table
ext_jumps:      .ds.l 1 ; 0x30

; address of interpreter functions table
ext_opejumps:   .ds.l 1 ; 0x34

; address of interpreter operators table
ext_evajumps:   .ds.l 1 ; 0x38

; address of interpreter extfunc
ext_extfunc:    .ds.l 1 ; 0x3c

; address of interpreter directives table
ext_dirjumps:   .ds.l 1 ; 0x40

; address of interpreter extended functions table
ext_extjumps:   .ds.l 1 ; 0x44

; address of error messages
ext_errormsg:   .ds.l 1 ; 0x48

; address of system variables
ext_vectors:    .ds.l 1 ; 0x4c

; address of graphic variables
ext_graphic:    .ds.l 1 ; 0x50

; address of VDI contrl array
ext_contrl:     .ds.l 1 ; 0x54

; address of VDI intin array
ext_intin:      .ds.l 1 ; 0x58

; address of VDI ptsin array
ext_ptsin:      .ds.l 1 ; 0x5c

; address of VDI intout array
ext_intout:     .ds.l 1 ; 0x60

; address of VDI ptsout array
ext_ptsout:     .ds.l 1 ; 0x64

; address of VDI parameter block
ext_vdipb:      .ds.l 1 ; 0x68

ext_chrget:     .ds.l 1 ; 0x6c

ext_chain:      .ds.l 1 ; 0x70

ext_dechain:    .ds.l 1 ; 0x74

; activate program
; inputs:
;   d0.w: program number (0-15)
ext_active:     .ds.l 1 ; 0x78

; save exception vectors
ext_savect:     .ds.l 1 ; 0x7c

; reset exception vectors
ext_loadvect:   .ds.l 1 ; 0x80

ext_menage:     .ds.l 1 ; 0x84

; get address of memory bank
; inputs:
;   d3.l: memory bank # (1-15)
; outputs:
;   d3.l: address
ext_adoubank:   .ds.l 1 ; 0x88

; get/verify address of screen
; inputs:
;   d3.l: screen address or bank number (1-15)
; outputs:
;   d3.l: address
ext_adscreen:   .ds.l 1 ; 0x8c

;first call auto back management
ext_abck:       .ds.l 1 ; 0x90

;second call auto back management
ext_abis:       .ds.l 1 ; 0x94

;address of function key buffer
ext_buffunc:    .ds.l 1 ; 0x98

;address of function key definitions
ext_deffunc:    .ds.l 1 ; 0x9c

;address of function key names
ext_funcname:   .ds.l 1 ; 0xa0
