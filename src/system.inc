*
* internal vectors.
* A pointer to this structure is passed in A0 to extensions
* In the interpreter, the routines table must match this layout
*

	.offset 0
; address of a 512 byte buffer
sys_buffer:     .ds.l 1 ; 0x00

; address of fltoint function
; inputs:
;    d3/d4: float number
; outputs:
;    d3: integer value
sys_fltoint:    .ds.l 1 ; 0x04

; address of inttofl function
; inputs:
;    d3: integer value
; outputs:
;    d3/d4: float number
sys_inttofl:    .ds.l 1 ; 0x08

; address of a DTA buffer
sys_dta:        .ds.l 1 ; 0x0c

; address of files table
sys_files:      .ds.l 1 ; 0x10

; address of error function
; inputs:
;   d0.w: error number
; outputs:
;   -
sys_error:      .ds.l 1 ; 0x14

; address of error handler (close all files etc.)
; inputs:
;   -
; outputs:
;   -
sys_err2:       .ds.l 1 ; 0x18

; allocate some memory:
; inputs:
;   d3: size
; outputs:
;   d0.l: address
sys_demand:     .ds.l 1 ; 0x1c

; get address of memory bank
; inputs:
;   d1.l: program number (1-16)
;   d2.l: memory bank #
; outputs:
;   d3.l: address
sys_start:      .ds.l 1 ; 0x20

; get length of memory bank
; inputs:
;   d1.l: program number (1-16)
;   d2.l: memory bank #
; outputs:
;   d3.l: length
sys_leng:       .ds.l 1 ; 0x24

; memory copy
; inputs:
;   a2: source address (must be even)
;   a3: destination address (must be even)
;   d3.l: length
sys_transmem:   .ds.l 1 ; 0x28

; address of editor windows
sys_windows:    .ds.l 1 ; 0x2c

; address of interpreter execution jump table
sys_jumps:      .ds.l 1 ; 0x30

; address of interpreter functions table
sys_opejumps:   .ds.l 1 ; 0x34

; address of interpreter operators table
sys_evajumps:   .ds.l 1 ; 0x38

; address of interpreter extfunc
sys_extfunc:    .ds.l 1 ; 0x3c

; address of interpreter directives table
sys_dirjumps:   .ds.l 1 ; 0x40

; address of interpreter extended functions table
sys_extjumps:   .ds.l 1 ; 0x44

; address of error messages
sys_errormsg:   .ds.l 1 ; 0x48

; address of system variables
sys_vectors:    .ds.l 1 ; 0x4c

; address of graphic variables
sys_graphic:    .ds.l 1 ; 0x50

; address of VDI contrl array
sys_contrl:     .ds.l 1 ; 0x54

; address of VDI intin array
sys_intin:      .ds.l 1 ; 0x58

; address of VDI ptsin array
sys_ptsin:      .ds.l 1 ; 0x5c

; address of VDI intout array
sys_intout:     .ds.l 1 ; 0x60

; address of VDI ptsout array
sys_ptsout:     .ds.l 1 ; 0x64

; address of VDI parameter block
sys_vdipb:      .ds.l 1 ; 0x68

sys_chrget:     .ds.l 1 ; 0x6c

sys_chain:      .ds.l 1 ; 0x70

sys_dechain:    .ds.l 1 ; 0x74

; activate program
; inputs:
;   d0.w: program number (0-15)
sys_active:     .ds.l 1 ; 0x78

; save exception vectors
sys_savect:     .ds.l 1 ; 0x7c

; reset exception vectors
sys_loadvect:   .ds.l 1 ; 0x80

sys_menage:     .ds.l 1 ; 0x84

; get address of memory bank
; inputs:
;   d3.l: memory bank # (1-15)
; outputs:
;   d3.l: address
sys_adoubank:   .ds.l 1 ; 0x88

; get/verify address of screen
; inputs:
;   d3.l: screen address or bank number (1-15)
; outputs:
;   d3.l: address
sys_adscreen:   .ds.l 1 ; 0x8c

;first call auto back management
sys_abck:       .ds.l 1 ; 0x90

;second call auto back management
sys_abis:       .ds.l 1 ; 0x94

;address of function key buffer
sys_buffunc:    .ds.l 1 ; 0x98

;address of function key definitions
sys_deffunc:    .ds.l 1 ; 0x9c

;address of function key names
sys_funcname:   .ds.l 1 ; 0xa0
