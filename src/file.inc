;FILE structure
	.offset 0
fhmode:   .ds.w 1   ; open flags
fha:      .ds.w 1   ; file handle
fhl:      .ds.l 1   ; file size
fht:      .ds.w 1   ; total field size
fhc:      .ds.w 16  ; field sizes
fhs:      .ds.l 16  ; address of field variables
tfiche:             ; 106 bytes per file

