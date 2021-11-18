		.include "system.inc"
		.include "errors.inc"
		.include "window.inc"
		.include "sprites.inc"
		.include "linea.inc"
		.include "equates.inc"
		.include "lib.inc"

MD_REPLACE = 0

		.text

* Define extension addresses

start:
	dc.l	para-start		; parameter definitions
	dc.l	entry-start		; reserve data area for program
	dc.l	lib1-start		; start of library

catalog:
	dc.w	lib2-lib1
	dc.w	lib3-lib2
	dc.w	lib4-lib3
	dc.w	lib5-lib4
	dc.w	lib6-lib5
	dc.w	lib7-lib6
	dc.w	lib8-lib7
	dc.w	lib9-lib8
	dc.w	lib10-lib9
	dc.w	lib11-lib10
	dc.w	lib12-lib11
	dc.w	lib13-lib12
	dc.w	lib14-lib13
	dc.w	lib15-lib14
	dc.w	lib16-lib15
	dc.w	lib17-lib16
	dc.w	lib18-lib17
	dc.w	lib19-lib18
	dc.w	lib20-lib19
	dc.w	lib21-lib20
	dc.w	lib22-lib21
	dc.w	lib23-lib22
	dc.w	lib24-lib23
	dc.w	lib25-lib24
	dc.w	lib26-lib25
	dc.w	lib27-lib26
	dc.w	lib28-lib27
	dc.w	lib29-lib28
	dc.w	lib30-lib29
	dc.w	lib31-lib30
	dc.w	lib32-lib31
	dc.w	lib33-lib32
	dc.w	lib34-lib33
	dc.w	lib35-lib34
	dc.w	lib36-lib35
	dc.w	lib37-lib36
	dc.w	lib38-lib37
	dc.w	lib39-lib38
	dc.w	lib40-lib39
	dc.w	lib41-lib40
	dc.w	lib42-lib41
	dc.w	lib43-lib42
	dc.w	lib44-lib43
	dc.w	lib45-lib44
	dc.w	libex-lib45

para:
	dc.w	45			; number of library routines
	dc.w	45			; number of extension commands

	.dc.w l001-para
	.dc.w l002-para
	.dc.w l003-para
	.dc.w l004-para
	.dc.w l005-para
	.dc.w l006-para
	.dc.w l007-para
	.dc.w l008-para
	.dc.w l009-para
	.dc.w l010-para
	.dc.w l011-para
	.dc.w l012-para
	.dc.w l013-para
	.dc.w l014-para
	.dc.w l015-para
	.dc.w l016-para
	.dc.w l017-para
	.dc.w l018-para
	.dc.w l019-para
	.dc.w l020-para
	.dc.w l021-para
	.dc.w l022-para
	.dc.w l023-para
	.dc.w l024-para
	.dc.w l025-para
	.dc.w l026-para
	.dc.w l027-para
	.dc.w l028-para
	.dc.w l029-para
	.dc.w l030-para
	.dc.w l031-para
	.dc.w l032-para
	.dc.w l033-para
	.dc.w l034-para
	.dc.w l035-para
	.dc.w l036-para
	.dc.w l037-para
	.dc.w l038-para
	.dc.w l039-para
	.dc.w l040-para
	.dc.w l041-para
	.dc.w l042-para
	.dc.w l043-para
	.dc.w l044-para
	.dc.w l045-para


* Parameter definitions

I	equ	0
F	equ	$40
S	equ	$80

l001:	.dc.b 0,I,1               ; _falc pen
        .dc.b   I,',',I,',',I,1,1,0
l002:	.dc.b I,1,1,0             ; _falc xcurs
l003:	.dc.b 0,I,1               ; _falc paper
        .dc.b   I,',',I,',',I,1,1,0
l004:	.dc.b I,1,1,0             ; _falc ycurs
l005:	.dc.b 0,I,',',I,1,1,0     ; _falc locate
l006:	.dc.b I,1,1,0             ; _stos charwidth
l007:	.dc.b 0,S,1,1,0           ; _falc print
l008:	.dc.b I,1,1,0             ; _stos charheight
l009:	.dc.b 0,I,1,1,0           ; _stosfont
l010:	.dc.b I,1,1,0             ; _falc multipen status
l011:	.dc.b 0,1,1,0             ; _falc multipen off
l012:	.dc.b I,I,1,1,0           ; _charset addr
l013:	.dc.b 0,I,1               ; _falc multipen on
        .dc.b   I,',',I,',',I,1,1,0
l014:	.dc.b I,I,',',I,',',I,1,1,0   ; _tc rgb
l015:	.dc.b 0,I,1               ; _falc ink
        .dc.b   I,',',I,',',I,1,1,0
l016:	.dc.b I,1,1,0
l017:	.dc.b 0,I,1,1,0           ; _falc draw mode
l018:	.dc.b I,I,',',I,1,1,0     ; _get pixel
l019:	.dc.b 0,I,1,1,0           ; _def linepattern
l020:	.dc.b I,1,1,0
l021:	.dc.b 0,I,1,1,0           ; _def stipple
l022:	.dc.b I,1,1,0
l023:	.dc.b 0,I,',',I,1,1,0     ; _falc plot
l024:	.dc.b I,1,1,0
l025:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc line
l026:	.dc.b I,1,1,0
l027:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc box
l028:	.dc.b I,1,1,0
l029:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc bar
l030:	.dc.b I,1,1,0
l031:	.dc.b 0,I,',',I,1,1,0     ; _falc polyline
l032:	.dc.b I,1,1,0
l033:	.dc.b 0,S,1,1,0           ; _falc centre
l034:	.dc.b I,1,1,0
l035:	.dc.b 0,I,',',I,1,1,0     ; _falc polyfill
l036:	.dc.b I,1,1,0
l037:	.dc.b 0,I,',',I,',',I,1,1,0 ; _falc contourfill
l038:	.dc.b I,1,1,0
l039:	.dc.b 0,I,',',I,',',I,1,1,0 ; _falc circle
l040:	.dc.b I,1,1,0
l041:	.dc.b 0,I,',',I,',',I,',',I,1,1,0  ; _falc ellipse
l042:	.dc.b I,1,1,0
l043:	.dc.b 0,I,',',I,',',I,',',I,',',I,',',I,1,1,0  ; _falc earc
l044:	.dc.b I,1,1,0
l045:	.dc.b 0,I,',',I,',',I,',',I,',',I,1,1,0  ; _falc arc

		.even

entry:
	bra.w init

params_offset: dc.l params-entry
patterns_offset: dc.l patterns-entry /* 106da */
sintab_offset: dc.l sintab-entry /* 109da */
drawbox_offset: dc.l drawbox-entry /* 11532 */
drawbar_offset: dc.l drawbar-entry /* 115f0 */
drawline_offset: dc.l drawline-entry /* 116ac */

params:
	ds.l 1
lineavars: ds.l 1 /* 10206, 4 */
cliprect: ds.w 4 /* 8 */
logic: ds.l 1 /* 16 */
currcolor: ds.w 1 /* 20 */
wrt_mode: ds.w 1 /* 22 */
colormask: ds.w 1 /* 24 */
stipple_ptr: ds.l 1 /* 26 */
stipple_mask: ds.w 1 /* 30 */
stipple_default: ds.l 1 /* 32 */

	ds.b 1200

patterns:
	dc.w 0x4444,0x0000,0x1111,0x0000,0x4444,0x0000,0x1111,0x0000,0x4444,0x0000,0x1111,0x0000,0x4444,0x0000,0x1111,0x0000
	dc.w 0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000,0x5555,0x0000
	dc.w 0x5555,0x2222,0x5555,0x8888,0x5555,0x2222,0x5555,0x8888,0x5555,0x2222,0x5555,0x8888,0x5555,0x2222,0x5555,0x8888
	dc.w 0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa,0x5555,0xaaaa
	dc.w 0xdddd,0xaaaa,0x7777,0xaaaa,0xdddd,0xaaaa,0x7777,0xaaaa,0xdddd,0xaaaa,0x7777,0xaaaa,0xdddd,0xaaaa,0x7777,0xaaaa
	dc.w 0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa,0xffff,0xaaaa
	dc.w 0xffff,0xbbbb,0xffff,0xeeee,0xffff,0xbbbb,0xffff,0xeeee,0xffff,0xbbbb,0xffff,0xeeee,0xffff,0xbbbb,0xffff,0xeeee
	dc.w 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
	dc.w 0x8080,0x8080,0x8080,0xffff,0x0808,0x0808,0x0808,0xffff,0x8080,0x8080,0x8080,0xffff,0x0808,0x0808,0x0808,0xffff
	dc.w 0x4040,0x8080,0x4141,0x2222,0x1414,0x0808,0x1010,0x2020,0x4040,0x8080,0x4141,0x2222,0x1414,0x0808,0x1010,0x2020
	dc.w 0x0000,0x1010,0x2828,0x0000,0x0000,0x0101,0x8282,0x0000,0x0000,0x1010,0x2828,0x0000,0x0000,0x0101,0x8282,0x0000
	dc.w 0x0202,0xaaaa,0x5050,0x2020,0x2020,0xaaaa,0x0505,0x0202,0x0202,0xaaaa,0x5050,0x2020,0x2020,0xaaaa,0x0505,0x0202
	dc.w 0x8080,0x0000,0x0808,0x0404,0x0202,0x0000,0x2020,0x4040,0x8080,0x0000,0x0808,0x0404,0x0202,0x0000,0x2020,0x4040
	dc.w 0xc6c6,0xd8d8,0x1818,0x8181,0x8db1,0x0c33,0x6000,0x6606,0xc6c6,0xd8d8,0x1818,0x8181,0x8db1,0x0c33,0x6000,0x6606
	dc.w 0x0000,0x0400,0x0000,0x0010,0x0000,0x8000,0x0000,0x0000,0x0000,0x0400,0x0000,0x0010,0x0000,0x8000,0x0000,0x0000
	dc.w 0x6c6c,0xc6c6,0x8f8f,0x1f1f,0x3636,0x6363,0xf1f1,0xf8f8,0x6c6c,0xc6c6,0x8f8f,0x1f1f,0x3636,0x6363,0xf1f1,0xf8f8
	dc.w 0x0000,0x8888,0x1414,0x2222,0x4141,0x8888,0x0000,0xaaaa,0x0000,0x8888,0x1414,0x2222,0x4141,0x8888,0x0000,0xaaaa
	dc.w 0x0000,0xaaaa,0x0000,0x0808,0x0000,0x8888,0x0000,0x0808,0x0000,0xaaaa,0x0000,0x0808,0x0000,0x8888,0x0000,0x0808
	dc.w 0x9898,0xf8f8,0xf8f8,0x7777,0x8989,0x8f8f,0x8f8f,0x7777,0x9898,0xf8f8,0xf8f8,0x7777,0x8989,0x8f8f,0x8f8f,0x7777
	dc.w 0x8080,0x4141,0x3e3e,0x0808,0x0808,0x1414,0xe3e3,0x8080,0x8080,0x4141,0x3e3e,0x0808,0x0808,0x1414,0xe3e3,0x8080
	dc.w 0x4242,0x2424,0x1818,0x0606,0x0101,0x8080,0x8080,0x8181,0x4242,0x2424,0x1818,0x0606,0x0101,0x8080,0x8080,0x8181
	dc.w 0xf0f0,0xf0f0,0xf0f0,0x0f0f,0x0f0f,0x0f0f,0x0f0f,0xf0f0,0xf0f0,0xf0f0,0xf0f0,0x0f0f,0x0f0f,0x0f0f,0x0f0f,0xf0f0
	dc.w 0x1c1c,0x3e3e,0x7f7f,0xffff,0x7f7f,0x3e3e,0x1c1c,0x0808,0x1c1c,0x3e3e,0x7f7f,0xffff,0x7f7f,0x3e3e,0x1c1c,0x0808
	dc.w 0x2222,0x4444,0xffff,0x8888,0x4444,0x2222,0xffff,0x1111,0x2222,0x4444,0xffff,0x8888,0x4444,0x2222,0xffff,0x1111


sintab:
	dc.w 65535,1000
	dc.w 65527,999
	dc.w 65518,999
	dc.w 65509,999
	dc.w 65501,999
	dc.w 65492,999
	dc.w 65483,998
	dc.w 65474,998
	dc.w 65466,997
	dc.w 65457,996
	dc.w 65448,996
	dc.w 65440,995
	dc.w 65431,994
	dc.w 65422,993
	dc.w 65414,992
	dc.w 65405,991
	dc.w 65396,990
	dc.w 65388,989
	dc.w 65379,987
	dc.w 65370,986
	dc.w 65362,984
	dc.w 65353,983
	dc.w 65345,981
	dc.w 65336,979
	dc.w 65328,978
	dc.w 65319,976
	dc.w 65311,974
	dc.w 65302,972
	dc.w 65294,970
	dc.w 65285,968
	dc.w 65277,965
	dc.w 65268,963
	dc.w 65260,961
	dc.w 65251,958
	dc.w 65243,956
	dc.w 65235,953
	dc.w 65226,951
	dc.w 65218,948
	dc.w 65210,945
	dc.w 65202,942
	dc.w 65193,939
	dc.w 65185,936
	dc.w 65177,933
	dc.w 65169,930
	dc.w 65161,927
	dc.w 65153,923
	dc.w 65145,920
	dc.w 65137,917
	dc.w 65129,913
	dc.w 65121,909
	dc.w 65113,906
	dc.w 65105,902
	dc.w 65097,898
	dc.w 65089,894
	dc.w 65082,891
	dc.w 65074,887
	dc.w 65066,882
	dc.w 65058,878
	dc.w 65051,874
	dc.w 65043,870
	dc.w 65035,866
	dc.w 65028,861
	dc.w 65020,857
	dc.w 65013,852
	dc.w 65006,848
	dc.w 64998,843
	dc.w 64991,838
	dc.w 64984,833
	dc.w 64976,829
	dc.w 64969,824
	dc.w 64962,819
	dc.w 64955,814
	dc.w 64948,809
	dc.w 64941,803
	dc.w 64934,798
	dc.w 64927,793
	dc.w 64920,788
	dc.w 64913,782
	dc.w 64906,777
	dc.w 64899,771
	dc.w 64893,766
	dc.w 64886,760
	dc.w 64879,754
	dc.w 64873,748
	dc.w 64866,743
	dc.w 64860,737
	dc.w 64853,731
	dc.w 64847,725
	dc.w 64841,719
	dc.w 64835,713
	dc.w 64828,707
	dc.w 64822,700
	dc.w 64816,694
	dc.w 64810,688
	dc.w 64804,681
	dc.w 64798,675
	dc.w 64792,669
	dc.w 64787,662
	dc.w 64781,656
	dc.w 64775,649
	dc.w 64769,642
	dc.w 64764,636
	dc.w 64758,629
	dc.w 64753,622
	dc.w 64747,615
	dc.w 64742,608
	dc.w 64737,601
	dc.w 64732,594
	dc.w 64726,587
	dc.w 64721,580
	dc.w 64716,573
	dc.w 64711,566
	dc.w 64706,559
	dc.w 64702,551
	dc.w 64697,544
	dc.w 64692,537
	dc.w 64687,529
	dc.w 64683,522
	dc.w 64678,515
	dc.w 64674,507
	dc.w 64669,499
	dc.w 64665,492
	dc.w 64661,484
	dc.w 64657,477
	dc.w 64653,469
	dc.w 64648,461
	dc.w 64644,453
	dc.w 64641,446
	dc.w 64637,438
	dc.w 64633,430
	dc.w 64629,422
	dc.w 64626,414
	dc.w 64622,406
	dc.w 64618,398
	dc.w 64615,390
	dc.w 64612,382
	dc.w 64608,374
	dc.w 64605,366
	dc.w 64602,358
	dc.w 64599,350
	dc.w 64596,342
	dc.w 64593,333
	dc.w 64590,325
	dc.w 64587,317
	dc.w 64584,309
	dc.w 64582,300
	dc.w 64579,292
	dc.w 64577,284
	dc.w 64574,275
	dc.w 64572,267
	dc.w 64570,258
	dc.w 64567,250
	dc.w 64565,241
	dc.w 64563,233
	dc.w 64561,224
	dc.w 64559,216
	dc.w 64557,207
	dc.w 64556,199
	dc.w 64554,190
	dc.w 64552,182
	dc.w 64551,173
	dc.w 64549,165
	dc.w 64548,156
	dc.w 64546,147
	dc.w 64545,139
	dc.w 64544,130
	dc.w 64543,121
	dc.w 64542,113
	dc.w 64541,104
	dc.w 64540,95
	dc.w 64539,87
	dc.w 64539,78
	dc.w 64538,69
	dc.w 64537,61
	dc.w 64537,52
	dc.w 64536,43
	dc.w 64536,34
	dc.w 64536,26
	dc.w 64536,17
	dc.w 64536,8
	dc.w 64535,65535
	dc.w 64536,65527
	dc.w 64536,65518
	dc.w 64536,65509
	dc.w 64536,65501
	dc.w 64536,65492
	dc.w 64537,65483
	dc.w 64537,65474
	dc.w 64538,65466
	dc.w 64539,65457
	dc.w 64539,65448
	dc.w 64540,65440
	dc.w 64541,65431
	dc.w 64542,65422
	dc.w 64543,65414
	dc.w 64544,65405
	dc.w 64545,65396
	dc.w 64546,65388
	dc.w 64548,65379
	dc.w 64549,65370
	dc.w 64551,65362
	dc.w 64552,65353
	dc.w 64554,65345
	dc.w 64556,65336
	dc.w 64557,65328
	dc.w 64559,65319
	dc.w 64561,65311
	dc.w 64563,65302
	dc.w 64565,65294
	dc.w 64567,65285
	dc.w 64570,65277
	dc.w 64572,65268
	dc.w 64574,65260
	dc.w 64577,65251
	dc.w 64579,65243
	dc.w 64582,65235
	dc.w 64584,65226
	dc.w 64587,65218
	dc.w 64590,65210
	dc.w 64593,65202
	dc.w 64596,65193
	dc.w 64599,65185
	dc.w 64602,65177
	dc.w 64605,65169
	dc.w 64608,65161
	dc.w 64612,65153
	dc.w 64615,65145
	dc.w 64618,65137
	dc.w 64622,65129
	dc.w 64626,65121
	dc.w 64629,65113
	dc.w 64633,65105
	dc.w 64637,65097
	dc.w 64641,65089
	dc.w 64644,65082
	dc.w 64648,65074
	dc.w 64653,65066
	dc.w 64657,65058
	dc.w 64661,65051
	dc.w 64665,65043
	dc.w 64669,65035
	dc.w 64674,65028
	dc.w 64678,65020
	dc.w 64683,65013
	dc.w 64687,65006
	dc.w 64692,64998
	dc.w 64697,64991
	dc.w 64702,64984
	dc.w 64706,64976
	dc.w 64711,64969
	dc.w 64716,64962
	dc.w 64721,64955
	dc.w 64726,64948
	dc.w 64732,64941
	dc.w 64737,64934
	dc.w 64742,64927
	dc.w 64747,64920
	dc.w 64753,64913
	dc.w 64758,64906
	dc.w 64764,64899
	dc.w 64769,64893
	dc.w 64775,64886
	dc.w 64781,64879
	dc.w 64787,64873
	dc.w 64792,64866
	dc.w 64798,64860
	dc.w 64804,64853
	dc.w 64810,64847
	dc.w 64816,64841
	dc.w 64822,64835
	dc.w 64828,64828
	dc.w 64835,64822
	dc.w 64841,64816
	dc.w 64847,64810
	dc.w 64854,64804
	dc.w 64860,64798
	dc.w 64866,64792
	dc.w 64873,64787
	dc.w 64879,64781
	dc.w 64886,64775
	dc.w 64893,64769
	dc.w 64899,64764
	dc.w 64906,64758
	dc.w 64913,64753
	dc.w 64920,64747
	dc.w 64927,64742
	dc.w 64934,64737
	dc.w 64941,64732
	dc.w 64948,64726
	dc.w 64955,64721
	dc.w 64962,64716
	dc.w 64969,64711
	dc.w 64976,64706
	dc.w 64984,64702
	dc.w 64991,64697
	dc.w 64998,64692
	dc.w 65006,64687
	dc.w 65013,64683
	dc.w 65020,64678
	dc.w 65028,64674
	dc.w 65036,64669
	dc.w 65043,64665
	dc.w 65051,64661
	dc.w 65058,64657
	dc.w 65066,64653
	dc.w 65074,64648
	dc.w 65082,64644
	dc.w 65089,64641
	dc.w 65097,64637
	dc.w 65105,64633
	dc.w 65113,64629
	dc.w 65121,64626
	dc.w 65129,64622
	dc.w 65137,64618
	dc.w 65145,64615
	dc.w 65153,64612
	dc.w 65161,64608
	dc.w 65169,64605
	dc.w 65177,64602
	dc.w 65185,64599
	dc.w 65193,64596
	dc.w 65202,64593
	dc.w 65210,64590
	dc.w 65218,64587
	dc.w 65226,64584
	dc.w 65235,64582
	dc.w 65243,64579
	dc.w 65251,64577
	dc.w 65260,64574
	dc.w 65268,64572
	dc.w 65277,64570
	dc.w 65285,64567
	dc.w 65294,64565
	dc.w 65302,64563
	dc.w 65311,64561
	dc.w 65319,64559
	dc.w 65328,64557
	dc.w 65336,64556
	dc.w 65345,64554
	dc.w 65353,64552
	dc.w 65362,64551
	dc.w 65370,64549
	dc.w 65379,64548
	dc.w 65388,64546
	dc.w 65396,64545
	dc.w 65405,64544
	dc.w 65414,64543
	dc.w 65422,64542
	dc.w 65431,64541
	dc.w 65440,64540
	dc.w 65448,64539
	dc.w 65457,64539
	dc.w 65466,64538
	dc.w 65474,64537
	dc.w 65483,64537
	dc.w 65492,64536
	dc.w 65501,64536
	dc.w 65509,64536
	dc.w 65518,64536
	dc.w 65527,64536
	dc.w 0,64535
	dc.w 8,64536
	dc.w 17,64536
	dc.w 26,64536
	dc.w 34,64536
	dc.w 43,64536
	dc.w 52,64537
	dc.w 61,64537
	dc.w 69,64538
	dc.w 78,64539
	dc.w 87,64539
	dc.w 95,64540
	dc.w 104,64541
	dc.w 113,64542
	dc.w 121,64543
	dc.w 130,64544
	dc.w 139,64545
	dc.w 147,64546
	dc.w 156,64548
	dc.w 165,64549
	dc.w 173,64551
	dc.w 182,64552
	dc.w 190,64554
	dc.w 199,64556
	dc.w 207,64557
	dc.w 216,64559
	dc.w 224,64561
	dc.w 233,64563
	dc.w 241,64565
	dc.w 250,64567
	dc.w 258,64570
	dc.w 267,64572
	dc.w 275,64574
	dc.w 284,64577
	dc.w 292,64579
	dc.w 300,64582
	dc.w 309,64584
	dc.w 317,64587
	dc.w 325,64590
	dc.w 333,64593
	dc.w 342,64596
	dc.w 350,64599
	dc.w 358,64602
	dc.w 366,64605
	dc.w 374,64608
	dc.w 382,64612
	dc.w 390,64615
	dc.w 398,64618
	dc.w 406,64622
	dc.w 414,64626
	dc.w 422,64629
	dc.w 430,64633
	dc.w 438,64637
	dc.w 446,64641
	dc.w 453,64644
	dc.w 461,64648
	dc.w 469,64653
	dc.w 477,64657
	dc.w 484,64661
	dc.w 492,64665
	dc.w 500,64669
	dc.w 507,64674
	dc.w 515,64678
	dc.w 522,64683
	dc.w 529,64687
	dc.w 537,64692
	dc.w 544,64697
	dc.w 551,64702
	dc.w 559,64706
	dc.w 566,64711
	dc.w 573,64716
	dc.w 580,64721
	dc.w 587,64726
	dc.w 594,64732
	dc.w 601,64737
	dc.w 608,64742
	dc.w 615,64747
	dc.w 622,64753
	dc.w 629,64758
	dc.w 636,64764
	dc.w 642,64769
	dc.w 649,64775
	dc.w 656,64781
	dc.w 662,64787
	dc.w 669,64792
	dc.w 675,64798
	dc.w 682,64804
	dc.w 688,64810
	dc.w 694,64816
	dc.w 700,64822
	dc.w 707,64828
	dc.w 713,64835
	dc.w 719,64841
	dc.w 725,64847
	dc.w 731,64854
	dc.w 737,64860
	dc.w 743,64866
	dc.w 748,64873
	dc.w 754,64879
	dc.w 760,64886
	dc.w 766,64893
	dc.w 771,64899
	dc.w 777,64906
	dc.w 782,64913
	dc.w 788,64920
	dc.w 793,64927
	dc.w 798,64934
	dc.w 803,64941
	dc.w 809,64948
	dc.w 814,64955
	dc.w 819,64962
	dc.w 824,64969
	dc.w 829,64976
	dc.w 833,64984
	dc.w 838,64991
	dc.w 843,64998
	dc.w 848,65006
	dc.w 852,65013
	dc.w 857,65020
	dc.w 861,65028
	dc.w 866,65036
	dc.w 870,65043
	dc.w 874,65051
	dc.w 878,65058
	dc.w 882,65066
	dc.w 887,65074
	dc.w 891,65082
	dc.w 894,65089
	dc.w 898,65097
	dc.w 902,65105
	dc.w 906,65113
	dc.w 909,65121
	dc.w 913,65129
	dc.w 917,65137
	dc.w 920,65145
	dc.w 923,65153
	dc.w 927,65161
	dc.w 930,65169
	dc.w 933,65177
	dc.w 936,65185
	dc.w 939,65193
	dc.w 942,65202
	dc.w 945,65210
	dc.w 948,65218
	dc.w 951,65226
	dc.w 953,65235
	dc.w 956,65243
	dc.w 958,65251
	dc.w 961,65260
	dc.w 963,65268
	dc.w 965,65277
	dc.w 968,65285
	dc.w 970,65294
	dc.w 972,65302
	dc.w 974,65311
	dc.w 976,65319
	dc.w 978,65328
	dc.w 979,65336
	dc.w 981,65345
	dc.w 983,65353
	dc.w 984,65362
	dc.w 986,65370
	dc.w 987,65379
	dc.w 989,65388
	dc.w 990,65396
	dc.w 991,65405
	dc.w 992,65414
	dc.w 993,65422
	dc.w 994,65431
	dc.w 995,65440
	dc.w 996,65448
	dc.w 996,65457
	dc.w 997,65466
	dc.w 998,65474
	dc.w 998,65483
	dc.w 999,65492
	dc.w 999,65501
	dc.w 999,65509
	dc.w 999,65518
	dc.w 999,65527
	dc.w 1000,0
	dc.w 999,8
	dc.w 999,17
	dc.w 999,26
	dc.w 999,34
	dc.w 999,43
	dc.w 998,52
	dc.w 998,61
	dc.w 997,69
	dc.w 996,78
	dc.w 996,87
	dc.w 995,95
	dc.w 994,104
	dc.w 993,113
	dc.w 992,121
	dc.w 991,130
	dc.w 990,139
	dc.w 989,147
	dc.w 987,156
	dc.w 986,165
	dc.w 984,173
	dc.w 983,182
	dc.w 981,190
	dc.w 979,199
	dc.w 978,207
	dc.w 976,216
	dc.w 974,224
	dc.w 972,233
	dc.w 970,241
	dc.w 968,250
	dc.w 965,258
	dc.w 963,267
	dc.w 961,275
	dc.w 958,284
	dc.w 956,292
	dc.w 953,300
	dc.w 951,309
	dc.w 948,317
	dc.w 945,325
	dc.w 942,333
	dc.w 939,342
	dc.w 936,350
	dc.w 933,358
	dc.w 930,366
	dc.w 927,374
	dc.w 923,382
	dc.w 920,390
	dc.w 917,398
	dc.w 913,406
	dc.w 909,414
	dc.w 906,422
	dc.w 902,430
	dc.w 898,438
	dc.w 894,446
	dc.w 891,453
	dc.w 887,461
	dc.w 882,469
	dc.w 878,477
	dc.w 874,484
	dc.w 870,492
	dc.w 866,500
	dc.w 861,507
	dc.w 857,515
	dc.w 852,522
	dc.w 848,529
	dc.w 843,537
	dc.w 838,544
	dc.w 833,551
	dc.w 829,559
	dc.w 824,566
	dc.w 819,573
	dc.w 814,580
	dc.w 809,587
	dc.w 803,594
	dc.w 798,601
	dc.w 793,608
	dc.w 788,615
	dc.w 782,622
	dc.w 777,629
	dc.w 771,636
	dc.w 766,642
	dc.w 760,649
	dc.w 754,656
	dc.w 748,662
	dc.w 743,669
	dc.w 737,675
	dc.w 731,681
	dc.w 725,688
	dc.w 719,694
	dc.w 713,700
	dc.w 707,707
	dc.w 700,713
	dc.w 694,719
	dc.w 688,725
	dc.w 681,731
	dc.w 675,737
	dc.w 669,743
	dc.w 662,748
	dc.w 656,754
	dc.w 649,760
	dc.w 642,766
	dc.w 636,771
	dc.w 629,777
	dc.w 622,782
	dc.w 615,788
	dc.w 608,793
	dc.w 601,798
	dc.w 594,803
	dc.w 587,809
	dc.w 580,814
	dc.w 573,819
	dc.w 566,824
	dc.w 559,829
	dc.w 551,833
	dc.w 544,838
	dc.w 537,843
	dc.w 529,848
	dc.w 522,852
	dc.w 515,857
	dc.w 507,861
	dc.w 499,866
	dc.w 492,870
	dc.w 484,874
	dc.w 477,878
	dc.w 469,882
	dc.w 461,887
	dc.w 453,891
	dc.w 446,894
	dc.w 438,898
	dc.w 430,902
	dc.w 422,906
	dc.w 414,909
	dc.w 406,913
	dc.w 398,917
	dc.w 390,920
	dc.w 382,923
	dc.w 374,927
	dc.w 366,930
	dc.w 358,933
	dc.w 350,936
	dc.w 342,939
	dc.w 333,942
	dc.w 325,945
	dc.w 317,948
	dc.w 309,951
	dc.w 300,953
	dc.w 292,956
	dc.w 284,958
	dc.w 275,961
	dc.w 267,963
	dc.w 258,965
	dc.w 250,968
	dc.w 241,970
	dc.w 233,972
	dc.w 224,974
	dc.w 216,976
	dc.w 207,978
	dc.w 199,979
	dc.w 190,981
	dc.w 182,983
	dc.w 173,984
	dc.w 165,986
	dc.w 156,987
	dc.w 147,989
	dc.w 139,990
	dc.w 130,991
	dc.w 121,992
	dc.w 113,993
	dc.w 104,994
	dc.w 95,995
	dc.w 87,996
	dc.w 78,996
	dc.w 69,997
	dc.w 61,998
	dc.w 52,998
	dc.w 43,999
	dc.w 34,999
	dc.w 26,999
	dc.w 17,999
	dc.w 8,999
	dc.w 0,1000


	ds.w 10

drawbox:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        get_logic
		andi.l     #0x000003FF,d0 /* WTF; why clamp coordinates? */
		andi.l     #0x000001FF,d1
		andi.l     #0x000003FF,d2
		andi.l     #0x000001FF,d3
		cmp.w      d0,d2
		bcc.s      drawbox1
		exg        d0,d2
drawbox1:
		cmp.w      d1,d3
		bcc.s      drawbox2
		exg        d1,d3
drawbox2:
		lea.l      cliprect(pc),a1
		cmp.w      (a1),d0
		bcc.s      drawbox3
		move.w     (a1),d0
drawbox3:
		cmp.w      4(a1),d2
		bcs.s      drawbox4
		move.w     4(a1),d2
drawbox4:
		cmp.w      2(a1),d1
		bcc.s      drawbox5
		move.w     2(a1),d1
drawbox5:
		cmp.w      6(a1),d3
		bcs.s      drawbox6
		move.w     6(a1),d3
drawbox6:
		lea.l      drawbox_coords(pc),a4
* left line
		movem.w    d0-d3,(a4)
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     (a4),d2
		move.w     6(a4),d3
		bsr        drawline
* top line
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr        drawline
* right line
		move.w     4(a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawline
* bottom line
		move.w     (a4),d0
		move.w     6(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawbox_coords: ds.w 4

drawbar:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        get_logic
		andi.l     #0x000003FF,d0 /* WTF; why clamp coordinates? */
		andi.l     #0x000001FF,d1
		andi.l     #0x000003FF,d2
		andi.l     #0x000001FF,d3
		cmp.w      d0,d2
		bcc.s      drawbar1
		exg        d0,d2
drawbar1:
		cmp.w      d1,d3
		bcc.s      drawbar2
		exg        d1,d3
drawbar2:
		lea.l      cliprect(pc),a1
		cmp.w      (a1),d0
		bcc.s      drawbar3
		move.w     (a1),d0
drawbar3:
		cmp.w      4(a1),d2
		bcs.s      drawbar4
		move.w     4(a1),d2
drawbar4:
		cmp.w      2(a1),d1
		bcc.s      drawbar5
		move.w     2(a1),d1
drawbar5:
		cmp.w      6(a1),d3
		bcs.s      drawbar6
		move.w     6(a1),d3
drawbar6:
		movea.l    stipple_ptr(pc),a2
		cmpi.l     #-1,(a2)
		beq.s      drawbar7
		bra.s      drawbar12
drawbar7:
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a1
		cmp.w      d0,d2
		beq.s      drawbar8
		cmp.w      d1,d3
		beq.s      drawbar8
		bra.s      drawbar9
drawbar8:
		bsr        drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar9:
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     currcolor(pc),d6
		sub.w      d1,d3
		subq.w     #1,d3
		move.w     V_BYTES_LIN(a1),d5
		mulu.w     d5,d1
		adda.l     d1,a0
drawbar10:
		move.w     d0,d4
drawbar11:
		move.w     d6,0(a0,d4.l*2) ; 68020+ only
		addq.w     #1,d4
		cmp.w      d4,d2
		bgt.s      drawbar11
		adda.l     d5,a0
		dbf        d3,drawbar10
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawbar12:
		lea.l      drawbar_coords(pc),a4
		movem.w    d0-d3,(a4)
		cmp.w      d0,d2
		beq.s      drawbar14
		cmp.w      d1,d3
		beq.s      drawbar14
		move.w     0(a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr.s      drawline
drawbar13:
		addq.w     #1,2(a4)
		move.w     (a4),d0
		move.w     2(a4),d1
		move.w     4(a4),d2
		move.w     2(a4),d3
		bsr        draw_back
		move.w     6(a4),d0
		cmp.w      2(a4),d0
		bne.s      drawbar13
		move.w     (a4),d0
		move.w     6(a4),d1
		move.w     4(a4),d2
		move.w     6(a4),d3
		bsr.s      drawline
drawbar14:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawbar_coords: ds.w 4

drawline:
		movem.l    d0-d7/a0-a6,-(a7)
		bsr        get_logic
		andi.l     #0x0000FFFF,d0
		andi.l     #0x0000FFFF,d1
		andi.l     #0x0000FFFF,d2
		andi.l     #0x0000FFFF,d3
		movea.l    logic(pc),a0
		movea.l    lineavars(pc),a6
		cmp.w      d0,d2
		beq.s      drawline1
		cmp.w      d1,d2 /* BUG: should be d3 */
		beq.s      drawline1
		bra        drawline_hi1
drawline1:
		lea.l      line_coords(pc),a0
		movem.w    d0-d3,(a0)
		movea.l    logic(pc),a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.w     line_coords(pc),d4
		move.w     line_coords+2(pc),d5
		move.w     line_coords+4(pc),d6
		move.w     line_coords+6(pc),d7
		cmp.w      d4,d6
		bcc.s      drawline2
		exg        d4,d6
drawline2:
		cmp.w      d5,d7
		bcc.s      drawline3
		exg        d5,d7
drawline3:
		cmp.w      d4,d6
		beq.s      drawline_hi_ver
		cmp.w      d5,d7
		beq.s      drawline_hi_hor
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_hi_ver:
		movea.l    lineavars(pc),a1
		move.w     d5,d0
		sub.w      d5,d7
		move.w     d5,d2
		moveq.l    #0,d1
		move.w     V_BYTES_LIN(a1),d1
		mulu.w     d1,d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
		move.w     colormask(pc),d3
drawline_hi_ver1:
		move.w     currcolor(pc),d2
		cmpi.w     #-1,d3
		beq.s      drawline_hi_ver2
		move.w     d0,d4
		andi.w     #15,d4
		neg.w      d4
		addi.w     #15,d4
		btst       d4,d3
		bne.s      drawline_hi_ver2
		not.w      d2
		move.w     d2,(a0)
		bra.s      drawline_hi_ver3
drawline_hi_ver2:
		move.w     d2,(a0)
drawline_hi_ver3:
		nop
		addq.w     #1,d0
		adda.w     d1,a0
		dbf        d7,drawline_hi_ver1
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_hi_hor:
		movea.l    lineavars(pc),a1
		move.w     d4,d0
		sub.w      d4,d6
		move.w     d5,d2
		mulu.w     V_BYTES_LIN(a1),d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
		move.w     colormask(pc),d3
drawline_hi_hor1:
		move.w     currcolor(pc),d1
		cmpi.w     #-1,d3
		beq.s      drawline_hi_hor2
		move.w     d0,d4
		andi.w     #15,d4
		neg.w      d4
		addi.w     #15,d4
		btst       d4,d3
		bne.s      drawline_hi_hor2
		not.w      d1
		move.w     d1,(a0)+
		bra.s      drawline_hi_hor3
drawline_hi_hor2:
		move.w     d1,(a0)+
drawline_hi_hor3:
		addq.w     #1,d0
		dbf        d6,drawline_hi_hor1
		movem.l    (a7)+,d0-d7/a0-a6
		rts

line_coords: ds.w 4

* diagonal draw
drawline_hi1:
		lea.l      drawline_coords(pc),a0
		movem.w    d0-d3,(a0)
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		lea        line_dirs(pc),a3
		move.w     drawline_coords(pc),d0
		move.w     drawline_coords+2(pc),d1
		move.w     drawline_coords+4(pc),d2
		move.w     drawline_coords+6(pc),d3
		sub.w      d0,d2
		sub.w      d1,d3
		move.w     d2,d4
		move.w     d3,d5
		move.w     drawline_coords(pc),d0
		move.w     drawline_coords+2(pc),d1
		tst.w      d4
		bpl.s      drawline7
		neg.w      d4
		move.w     #-1,(a3)
		bra.s      drawline8
drawline7:
		move.w     #1,(a3)
drawline8:
		tst.w      d5
		bpl.s      drawline9
		neg.w      d5
		move.w     #-1,2(a3)
		bra.s      drawline10
drawline9:
		move.w     #1,2(a3)
drawline10:
		tst.w      d5
		bne.s      drawline11
		move.w     #-1,4(a3)
		bra.s      drawline12
drawline11:
		move.w     #0,4(a3)
drawline12:
		cmp.w      drawline_coords+4(pc),d0
		bne.s      drawline13
		cmp.w      drawline_coords+6(pc),d1
		beq.s      drawline16
drawline13:
		move.w     4(a3),d6
		tst.w      d6
		bge.s      drawline14
		add.w      (a3),d0
		add.w      d5,4(a3)
		bra.s      drawline15
drawline14:
		add.w      2(a3),d1
		sub.w      d4,4(a3)
drawline15:
		bsr.s      setpixel
		bra.s      drawline12
drawline16:
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawline_coords: ds.w 4
line_dirs: ds.w 3


setpixel:
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars(pc),a6
		moveq.l    #0,d6
		move.w     V_BYTES_LIN(a6),d6
		mulu.w     d6,d1
		movea.l    logic(pc),a0
		adda.l     d1,a0
		asl.w      #1,d0
		adda.l     d0,a0
		move.w     currcolor(pc),(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

draw_back:
		movem.l    d0-d7/a0-a6,-(a7)
		lea.l      drawhiback_coords(pc),a0
		movem.w    d0-d3,(a0)
		movea.l    logic(pc),a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		moveq.l    #0,d6
		moveq.l    #0,d7
		move.w     drawhiback_coords+0(pc),d4
		move.w     drawhiback_coords+2(pc),d5
		move.w     drawhiback_coords+4(pc),d6
		move.w     drawhiback_coords+6(pc),d7
		cmp.w      d4,d6
		bcc.s      drawhi_back1
		exg        d4,d6
drawhi_back1:
		cmp.w      d5,d7
		bcc.s      drawhi_back2
		exg        d5,d7
drawhi_back2:
		cmp.w      d5,d7
		beq.s      drawhi_back4
drawhi_back3:
		movem.l    (a7)+,d0-d7/a0-a6
		rts
drawhi_back4:
		movea.l    stipple_ptr(pc),a2
		movea.l    lineavars(pc),a1
		move.w     d4,d0
		sub.w      d4,d6
		subq.w     #2,d6
		move.w     d5,d2
		mulu.w     V_BYTES_LIN(a1),d2
		adda.l     d2,a0
		asl.w      #1,d4
		adda.l     d4,a0
		and.w      stipple_mask(pc),d5
		move.w     0(a2,d5.w*2),d3 ; 68020+ only
		move.w     currcolor(pc),(a0)+
drawhi_back5:
		move.w     currcolor(pc),d1
		move.w     d0,d4
		andi.w     #15,d4
		neg.w      d4
		addi.w     #15,d4
		btst       d4,d3
		bne.s      drawhi_back6
		move.w     #0,(a0)+
		bra.s      drawhi_back7
drawhi_back6:
		move.w     d1,(a0)+
drawhi_back7:
		addq.w     #1,d0
		dbf        d6,drawhi_back5
		move.w     currcolor(pc),(a0)+
		movem.l    (a7)+,d0-d7/a0-a6
		rts

drawhiback_coords: ds.w 4 /* FIXME */

get_logic:
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		lea.l      logic(pc),a0
		move.l     d0,(a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

init:
		movem.l    d0-d7/a0-a6,-(a7)
		dc.w       0xa000 /* linea_init */
		lea.l      params(pc),a4
		move.l     a0,lineavars-params(a4)
		move.w     #1,currcolor-params(a4)
		move.w     #MD_REPLACE,wrt_mode-params(a4)
		move.w     #-1,colormask-params(a4)
		lea.l      stipple_ptr-params(a4),a0
		lea.l      stipple_default-params(a4),a1
		move.l     #-1,(a1)
		move.l     a1,(a0)
		lea.l      stipple_mask-params(a4),a0
		move.w     #0,(a0)
		moveq.l    #S_falc_initfont,d0
		trap       #5
		moveq.l    #S_multipen_off,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a0-a6
		lea exit(pc),a2
		rts

exit:
		rts

/*
 * Syntax:   _falc pen COL_REG
 *           _falc pen RED,GREEN,BLUE
 */
lib1:
	dc.w	0			; no library calls
falc_pen:
		cmpi.b     #1,d0
		beq.s      falc_pen2
		cmpi.w     #2,d0
		beq.s      falc_pen1
		rts
falc_pen1:
		move.l     (a6)+,d3
		andi.l     #31,d3
		move.l     (a6)+,d2
		andi.l     #31,d2
		lsl.w      #6,d2
		move.l     (a6)+,d1
		andi.l     #31,d1
		lsl.w      #6,d1
		lsl.w      #5,d1
		or.w       d3,d2
		or.w       d2,d1
		andi.l     #0xFFFF,d1
		bra.s      falc_pen3
falc_pen2:
		move.l     (a6)+,d1
		andi.l     #255,d1
falc_pen3:
		moveq.l    #S_falc_pen,d0
		trap       #5
		rts

/*
 * Syntax:   X=_falc xcurs
 */
lib2:
	dc.w	0			; no library calls
falc_xcurs:
		moveq.l    #S_falc_xcurs,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc paper COL_REG
 *           _falc paper RED,GREEN,BLUE
 *           _falc paper -1
 */
lib3:
	dc.w	0			; no library calls
falc_paper:
		cmpi.w     #1,d0
		beq.s      falc_paper2
		cmpi.w     #2,d0
		beq.s      falc_paper1
		rts
falc_paper1:
		move.l     (a6)+,d3
		andi.l     #31,d3
		move.l     (a6)+,d2
		andi.l     #31,d2
		lsl.w      #6,d2
		move.l     (a6)+,d1
		andi.l     #31,d1
		lsl.w      #6,d1
		lsl.w      #5,d1
		or.w       d3,d2
		or.w       d2,d1
		andi.l     #0xFFFF,d1
		bra.s      falc_paper3
falc_paper2:
		move.l     (a6)+,d1
falc_paper3:
		moveq.l    #S_falc_paper,d0
		trap       #5
		rts

/*
 * Syntax:   Y=_falc ycurs
 */
lib4:
	dc.w	0			; no library calls
falc_ycurs:
		moveq.l    #S_falc_ycurs,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc locate X,Y
 */
lib5:
	dc.w	0			; no library calls
falc_locate:
		move.l     (a6)+,d3
		lea.l      falc_locate_coords+2(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_locate_coords(pc),a0
		move.w     d3,(a0)
		move.l     (a0),d1
		moveq.l    #S_falc_locate,d0
		trap       #5
		rts

falc_locate_coords: ds.w 2

/*
 * Syntax:   CHAR_WIDTH=_stos charwidth
 */
lib6:
	dc.w	0			; no library calls
stos_charwidth:
		moveq.l    #S_charwidth,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc print A$
 */
lib7:
	dc.w	0			; no library calls
falc_print:
		move.l     (a6)+,a0
		moveq.l    #S_falc_print,d0
		trap       #5
		rts

/*
 * Syntax:   CHAR_HEIGHT=_stos charheight
 */
lib8:
	dc.w	0			; no library calls
stos_charheight:
		moveq.l    #S_charheight,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _stosfont FNT_NUM
 */
lib9:
	dc.w	0			; no library calls
stosfont:
		move.l     (a6)+,d1
		andi.l     #255,d1
		subq.w     #1,d1
		bmi.s      stosfont1
		cmpi.w     #2,d1
		bgt.s      stosfont1
		moveq.l    #S_stosfont,d0
		trap       #5
stosfont1:
		rts

/*
 * Syntax:   X=_falc multipen status
 */
lib10:
	dc.w	0			; no library calls
falc_multipen_status:
		moveq.l    #S_multipen_status,d0
		trap       #5
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc multipen off
 */
lib11:
	dc.w	0			; no library calls
falc_multipen_off:
		moveq.l    #S_multipen_off,d0
		trap       #5
		rts

/*
 * Syntax:   ADDR=_charset addr(CHAR_SET)
 */
lib12:
	dc.w	0			; no library calls
charset_addr:
		move.l     (a6)+,d0
		andi.l     #15,d0
		subq.w     #1,d0
		tst.w      d0
		bmi.s      charset_addr1
		cmpi.w     #2,d0
		bgt.s      charset_addr1
		bra.s      charset_addr2
charset_addr1:
		clr.l      d0
charset_addr2:
		movem.l    a0-a6,-(a7)
		move.w     #W_getcharset,d7
		trap       #3
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts

/*
 * Syntax:   _falc multipen on STEP
 *           _falc multipen on R_INC,GR_INC,BL_INC
 */
lib13:
	dc.w	0			; no library calls
falc_multipen_on:
		lea.l      multipen_on_params(pc),a1
		move.w     #1,(a1)
		move.w     #1,2(a1)
		move.w     #1,4(a1)
		/* cmpi.b     #1,d0 */
		dc.w 0x0c00,0 /* XXX */ /* BUG: should be 1 */
		beq.s      falc_multipen_on1
		cmpi.w     #2,d0
		beq        falc_multipen_on0
		bra.s      falc_multipen_on1
falc_multipen_on0:
		move.l     (a6)+,d4
		move.l     (a6)+,d3
		move.l     (a6)+,d2
		andi.l     #31,d2
		andi.l     #31,d3
		andi.l     #31,d4
		bra.s      falc_multipen_on2
falc_multipen_on1:
		move.l     (a6)+,d2
		andi.l     #255,d2
falc_multipen_on2:
		lea.l      multipen_on_params(pc),a1
		move.w     d2,(a1) /* FIXME: useless */
		move.w     d3,2(a1)
		move.w     d4,4(a1)
		move.w     (a1),d2
		move.w     2(a1),d3
		move.w     4(a1),d4
		moveq.l    #S_multipen_on,d0
		trap       #5
		rts

multipen_on_params: ds.w 3

/*
 * Syntax:   RGB=_tc rgb(RED,GREEN,BLUE)
 */
lib14:
	dc.w	0			; no library calls
tc_rgb:
		move.l     (a6)+,d3
		andi.l     #31,d3
		lea.l      tc_rgb_colors(pc),a0
		move.w     d3,4(a0)
		move.l     (a6)+,d3
		andi.l     #31,d3
		asl.w      #6,d3
		lea.l      tc_rgb_colors(pc),a0
		move.w     d3,2(a0)
		move.l     (a6)+,d3
		andi.l     #31,d3
		asl.w      #6,d3
		asl.w      #5,d3
		lea.l      tc_rgb_colors(pc),a0
		move.w     d3,(a0)
		moveq.l    #0,d3
		lea.l      tc_rgb_colors(pc),a0
		or.w       (a0),d3
		or.w       2(a0),d3
		or.w       4(a0),d3
		clr.l      d2
		move.l     d3,-(a6)
		rts

tc_rgb_colors: ds.w 4

/*
 * Syntax:   _falc ink COL_REG
 *           _falc ink RED,GREEN,BLUE
 */
lib15:
	dc.w	0			; no library calls
falc_ink:
		cmpi.b     #1,d0
		beq.s      falc_ink2
		cmpi.w     #2,d0
		beq.s      falc_ink1
		rts
falc_ink1:
		move.l     (a6)+,d7
		andi.l     #31,d7
		move.l     (a6)+,d6
		andi.l     #31,d6
		lsl.w      #6,d6
		move.l     (a6)+,d5
		andi.l     #31,d5
		lsl.w      #6,d5
		lsl.w      #5,d5
		or.w       d7,d6
		or.w       d6,d5
		andi.l     #0xFFFF,d5
		bra.s      falc_ink3
falc_ink2:
		move.l     (a6)+,d5
		andi.l     #255,d5
falc_ink3:
		move.l     d5,d7
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		move.w     d7,currcolor-params(a6)
		movem.l    (a7)+,a0-a6
		rts

lib16:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc draw mode GR_MODE
 */
lib17:
	dc.w	0			; no library calls
falc_draw_mode:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		/* subq.l     #1,d3 */
		dc.w 0x0483,0,1 /* XXX */
		bmi.s      falc_draw_mode1
		andi.l     #3,d3
		move.w     d3,wrt_mode-params(a6)
falc_draw_mode1:
		movem.l    (a7)+,a0-a6
		rts

/*
 * Syntax:   COL_REG=_get pixel(X,Y)
 */
lib18:
	dc.w	0			; no library calls
get_pixel:
		move.l     (a6)+,d3
		lea.l      get_pixel_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      get_pixel_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      get_pixel1
		movem.l    a0-a6,-(a7) /* FIXME: not needed */
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,a0-a6
		movea.l    d0,a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     get_pixel_x(pc),d4
		asl.w      #1,d4
		move.w     get_pixel_y(pc),d5
		movea.l    lineavars-params(a6),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		move.w     (a0),d0
		movem.l    (a7)+,a0-a6
		andi.l     #0xFFFF,d0
		move.l     d0,-(a6)
		clr.l      d2
		rts
get_pixel1:
		lea.l      get_pixel_x(pc),a1
		move.l     a1,LA_PTSIN(a0)
		dc.w       0xa002 /* get_pixel */
		movem.l    (a7)+,a0-a6
		move.l     d0,-(a6)
		clr.l      d2
		rts

get_pixel_x: ds.w 1
get_pixel_y: ds.w 1

/*
 * Syntax:   _def linepattern PATTERN
 */
lib19:
	dc.w	0			; no library calls
def_linepattern:
		move.l     (a6)+,d3
		andi.l     #$0000FFFF,d3 /* FIXME: useless */
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		andi.l     #$0000FFFF,d3 /* FIXME: useless */
		move.w     d3,colormask-params(a6)
		movem.l    (a7)+,a0-a6
		rts

lib20:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _def stipple STIPPLE
 */
lib21:
	dc.w	0			; no library calls
def_stipple:
		move.l     (a6)+,d3
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a1
		move.l     patterns_offset-entry(a1),d4
		adda.l     d4,a1
		tst.l      d3
		beq.s      def_stipple1
		bmi.s      def_stipple1
		cmpi.l     #24,d3
		bgt.s      def_stipple1
		subq.l     #1,d3
		asl.l      #5,d3
		adda.l     d3,a1
		lea.l      stipple_ptr-params(a6),a0
		move.l     a1,(a0)
		lea.l      stipple_mask-params(a6),a0
		move.w     #15,(a0)
		movem.l    (a7)+,a0-a6
		rts
def_stipple1:
		lea.l      stipple_default-params(a6),a1
		move.l     d3,(a1)
		lea.l      stipple_ptr-params(a6),a0
		move.l     a1,(a0)
		lea.l      stipple_mask-params(a6),a0
		move.w     #0,(a0)
		movem.l    (a7)+,a0-a6
		rts

lib22:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc plot X,Y
 */
lib23:
	dc.w	0			; no library calls
falc_plot:
		move.l     (a6)+,d3
		lea.l      falc_plot_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_plot_x(pc),a0
		move.w     d3,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		cmpi.w     #16,LA_PLANES(a0)
		bne.s      falc_plot1
		movem.l    a0-a6,-(a7) /* FIXME: not needed */
		move.w     #3,-(a7) /* Logbase */
		trap       #14
		addq.l     #2,a7
		movem.l    (a7)+,a0-a6
		movea.l    d0,a0
		moveq.l    #0,d4
		moveq.l    #0,d5
		move.w     falc_plot_x(pc),d4
		asl.w      #1,d4
		move.w     falc_plot_y(pc),d5
		movea.l    lineavars-params(a6),a1
		mulu.w     V_BYTES_LIN(a1),d5
		adda.l     d5,a0
		adda.l     d4,a0
		/* move.w     currcolor-params(a6),(a0) */
		dc.w 0x30ae,currcolor-params /* XXX */
		movem.l    (a7)+,d0-d7/a0-a6
		rts
falc_plot1:
		lea.l      currcolor-params(a6),a1
		move.l     a1,LA_INTIN(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		lea.l      falc_plot_x(pc),a1
		move.l     a1,LA_PTSIN(a0)
		dc.w       0xa001 /* put_pixel */
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_plot_x: ds.w 1
falc_plot_y: ds.w 1

lib24:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc line X1,Y1,X2,Y2
 */
lib25:
	dc.w	0			; no library calls
falc_line:
		move.l     (a6)+,d3
		lea.l      falc_line_coords+6(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_line_coords+4(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_line_coords+2(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_line_coords+0(pc),a0
		move.w     d3,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_line1
		move.w     currcolor-params(a6),d0
		bsr.s      linea_setcolor
		lea.l      falc_line_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		rts
falc_line1:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     drawline_offset-entry(a0),d0
		adda.l     d0,a0
		lea.l      falc_line_coords(pc),a1
		move.w     (a1),d0
		move.w     2(a1),d1
		move.w     4(a1),d2
		move.w     6(a1),d3
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_line_coords: ds.w 4

linea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      linea_setcolor1
		bset       #0,LA_FG_1+1(a0)
linea_setcolor1:
		btst       #1,d0
		beq.s      linea_setcolor2
		bset       #0,LA_FG_2+1(a0)
linea_setcolor2:
		btst       #2,d0
		beq.s      linea_setcolor3
		bset       #0,LA_FG_3+1(a0)
linea_setcolor3:
		btst       #3,d0
		beq.s      linea_setcolor4
		bset       #0,LA_FG_4+1(a0)
linea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      linea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      linea_setcolor5
		bset       #0,LA_FG_5+1(a0)
linea_setcolor5:
		btst       #5,d0
		beq.s      linea_setcolor6
		bset       #0,LA_FG_6+1(a0)
linea_setcolor6:
		btst       #6,d0
		beq.s      linea_setcolor7
		bset       #0,LA_FG_7+1(a0)
linea_setcolor7:
		btst       #7,d0
		beq.s      linea_setcolor8
		bset       #0,LA_FG_8+1(a0)
linea_setcolor8:
		rts

lib26:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc box X1,Y1,X2,Y2
 */
lib27:
	dc.w	0			; no library calls
falc_box:
		move.l     (a6)+,d3
		lea.l      falc_box_coords+6(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_box_coords+4(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_box_coords+2(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_box_coords+0(pc),a0
		move.w     d3,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		lea.l      cliprect-params(a6),a1
		move.w     #0,(a1)+
		move.w     #0,(a1)+
		move.w     DEV_TAB(a0),(a1)+
		move.w     DEV_TAB+2(a0),(a1)+
		cmpi.w     #16,LA_PLANES(a0)
		beq        falc_box_hi
		move.w     currcolor-params(a6),d0
		bsr        blinea_setcolor
		lea.l      falc_box_coords(pc),a1
* left line
		move.w     (a1),d1
		move.w     2(a1),d2
		move.w     (a1),d3
		move.w     6(a1),d4
		bsr.s      linea_drawline
* top line
		move.w     (a1),d1
		move.w     2(a1),d2
		move.w     4(a1),d3
		move.w     2(a1),d4
		bsr.s      linea_drawline
* right line
		move.w     4(a1),d1
		move.w     2(a1),d2
		move.w     4(a1),d3
		move.w     6(a1),d4
		bsr.s      linea_drawline
* bottom line
		move.w     (a1),d1
		move.w     6(a1),d2
		move.w     4(a1),d3
		move.w     6(a1),d4
		bsr.s      linea_drawline
		movem.l    (a7)+,d0-d7/a0-a6
		rts

linea_drawline:
		movem.l    a0-a1,-(a7)
		move.w     d1,LA_X1(a0)
		move.w     d2,LA_Y1(a0)
		move.w     d3,LA_X2(a0)
		move.w     d4,LA_Y2(a0)
		move.w     d1,LA_XMN_CLIP(a0)
		move.w     d2,LA_YMN_CLIP(a0)
		move.w     d3,LA_XMX_CLIP(a0)
		move.w     d4,LA_YMX_CLIP(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,a0-a1
		rts

falc_box_hi:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     drawbox_offset-entry(a0),d0
		adda.l     d0,a0
		lea.l      falc_box_coords(pc),a1
		move.w     (a1),d0
		move.w     2(a1),d1
		move.w     4(a1),d2
		move.w     6(a1),d3
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_box_coords: ds.w 4

/* FIXME */
blinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      blinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
blinea_setcolor1:
		btst       #1,d0
		beq.s      blinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
blinea_setcolor2:
		btst       #2,d0
		beq.s      blinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
blinea_setcolor3:
		btst       #3,d0
		beq.s      blinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
blinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      blinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      blinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
blinea_setcolor5:
		btst       #5,d0
		beq.s      blinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
blinea_setcolor6:
		btst       #6,d0
		beq.s      blinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
blinea_setcolor7:
		btst       #7,d0
		beq.s      blinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
blinea_setcolor8:
		rts


lib28:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc bar X1,Y1,X2,Y2
 */
lib29:
	dc.w	0			; no library calls
falc_bar:
		move.l     (a6)+,d3
		lea.l      falc_bar_coords+6(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_bar_coords+4(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_bar_coords+2(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      falc_bar_coords+0(pc),a0
		move.w     d3,(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		lea.l      cliprect-params(a6),a1
		move.w     #0,(a1)+
		move.w     #0,(a1)+
		move.w     DEV_TAB(a0),(a1)+
		move.w     DEV_TAB+2(a0),(a1)+
		cmpi.w     #16,LA_PLANES(a0)
		beq.s      falc_bar_hi

		move.w     currcolor-params(a6),d0
		bsr        balinea_setcolor
		lea.l      falc_bar_coords+0(pc),a4
		move.w     (a4),LA_X1(a0)
		move.w     2(a4),LA_Y1(a0)
		move.w     4(a4),LA_X2(a0)
		move.w     6(a4),LA_Y2(a0)
		move.w     (a4),LA_XMN_CLIP(a0)
		move.w     2(a4),LA_YMN_CLIP(a0)
		move.w     4(a4),LA_XMX_CLIP(a0)
		move.w     6(a4),LA_YMX_CLIP(a0)

		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-params(a6),a5
		move.w     stipple_mask-params(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		move.w     #1,LA_CLIP(a0)
		dc.w       0xa005 /* filled_rect */
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_bar_hi:
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a0
		move.l     drawbar_offset-entry(a0),d0
		adda.l     d0,a0
		lea.l      falc_bar_coords(pc),a1
		move.w     (a1),d0
		move.w     2(a1),d1
		move.w     4(a1),d2
		move.w     6(a1),d3
		jsr        (a0)
		movem.l    (a7)+,d0-d7/a0-a6
		rts

falc_bar_coords: ds.w 4

/* FIXME */
balinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      balinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
balinea_setcolor1:
		btst       #1,d0
		beq.s      balinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
balinea_setcolor2:
		btst       #2,d0
		beq.s      balinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
balinea_setcolor3:
		btst       #3,d0
		beq.s      balinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
balinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      balinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      balinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
balinea_setcolor5:
		btst       #5,d0
		beq.s      balinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
balinea_setcolor6:
		btst       #6,d0
		beq.s      balinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
balinea_setcolor7:
		btst       #7,d0
		beq.s      balinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
balinea_setcolor8:
		rts


lib30:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc polyline varptr(XY_ARRAY(0)),PTS
 */
lib31:
	dc.w	0			; no library calls
falc_polyline:
		move.l     (a6)+,d3
		subq.l     #1,d3
		bmi        falc_polyline2
		cmpi.l     #63,d3
		bgt        falc_polyline2
		lea.l      polyline_pts(pc),a0
		move.l     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_polyline2
		lea.l      polyline_array(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		move.w     currcolor-params(a6),d0
		bsr.s      plinea_setcolor
		movea.l    polyline_array(pc),a1
		move.l     polyline_pts(pc),d7
		subq.l     #1,d7
falc_polyline1:
		move.l     (a1),d0
		move.w     d0,LA_X1(a0)
		move.l     4(a1),d0
		move.w     d0,LA_Y1(a0)
		move.l     8(a1),d0
		move.w     d0,LA_X2(a0)
		move.l     12(a1),d0
		move.w     d0,LA_Y2(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyline1
falc_polyline3:
		movem.l    (a7)+,a0-a6
falc_polyline2:
		rts

/* FIXME: duplicate code */
plinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      plinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
plinea_setcolor1:
		btst       #1,d0
		beq.s      plinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
plinea_setcolor2:
		btst       #2,d0
		beq.s      plinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
plinea_setcolor3:
		btst       #3,d0
		beq.s      plinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
plinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      plinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      plinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
plinea_setcolor5:
		btst       #5,d0
		beq.s      plinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
plinea_setcolor6:
		btst       #6,d0
		beq.s      plinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
plinea_setcolor7:
		btst       #7,d0
		beq.s      plinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
plinea_setcolor8:
		rts

polyline_pts: ds.l 1
polyline_array: ds.l 1

lib32:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc centre A$
 */
lib33:
	dc.w	0			; no library calls
falc_centre:
		move.l     (a6)+,a0
		movem.l    d0-d7/a1-a6,-(a7)
		moveq.l    #S_falc_centre,d0
		trap       #5
		movem.l    (a7)+,d0-d7/a1-a6
		rts

lib34:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc polyfill varptr(XY_ARRAY(0)),PTS
 */
lib35:
	dc.w	0			; no library calls
falc_polyfill:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_polyfill4
		cmpi.l     #64,d3
		bgt        falc_polyfill4
		lea.l      polyfill_pts(pc),a0
		move.l     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_polyfill4
		lea.l      polyfill_array(pc),a0
		move.l     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		move.w     currcolor-params(a6),d0
		bsr        pplinea_setcolor
		movem.l    a0-a6,-(a7)
		lea.l      pptsin(pc),a4
		movea.l    polyfill_array(pc),a2
		move.l     polyfill_pts(pc),d7
		asl.w      #1,d7
		subq.w     #1,d7
falc_polyfill1:
		move.l     (a2)+,d0
		move.w     d0,(a4)+
		dbf        d7,falc_polyfill1
		bsr        find_miny
		bsr        find_maxy
		lea.l      control(pc),a3
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		move.l     d7,(a3)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		lea.l      control(pc),a4
		move.l     a4,LA_CONTROL(a0)
		lea.l      pptsin(pc),a4
		move.l     a4,LA_PTSIN(a0)
		movea.l    stipple_ptr-params(a6),a5
		move.w     stipple_mask-params(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		move.w     #0,LA_CLIP(a0)
		move.w     polyfill_y1(pc),d3
		move.w     polyfill_maxy(pc),d4
falc_polyfill2:
		movem.l    d3-d4/a0,-(a7)
		move.w     d3,LA_Y1(a0)
		dc.w       0xa006 /* filled_polygon */
		movem.l    (a7)+,d3-d4/a0
		addq.w     #1,d3
		cmp.w      d3,d4
		bne.s      falc_polyfill2
		movem.l    (a7)+,a0-a6
		movea.l    polyfill_array(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.l     #2,d7
falc_polyfill3:
		move.l     (a1),d0
		move.w     d0,LA_X1(a0)
		move.l     4(a1),d0
		move.w     d0,LA_Y1(a0)
		move.l     8(a1),d0
		move.w     d0,LA_X2(a0)
		move.l     12(a1),d0
		move.w     d0,LA_Y2(a0)
		movem.l    d0-d7/a0-a6,-(a7)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.l     #8,a1
		dbf        d7,falc_polyfill3
falc_polyfill5:
		movem.l    (a7)+,a0-a6
falc_polyfill4:
		rts

/* FIXME: duplicate code */
pplinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      pplinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
pplinea_setcolor1:
		btst       #1,d0
		beq.s      pplinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
pplinea_setcolor2:
		btst       #2,d0
		beq.s      pplinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
pplinea_setcolor3:
		btst       #3,d0
		beq.s      pplinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
pplinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      falc_polyfill5
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      pplinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
pplinea_setcolor5:
		btst       #5,d0
		beq.s      pplinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
pplinea_setcolor6:
		btst       #6,d0
		beq.s      pplinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
pplinea_setcolor7:
		btst       #7,d0
		beq.s      pplinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
pplinea_setcolor8:
		rts

find_miny:
		movem.l    a0-a6,-(a7)
		lea.l      pptsin+2(pc),a0
		lea.l      polyfill_y1(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		move.l     #640,d0 /* BUG: should be much higher */
		move.w     d0,(a1)
find_miny1:
		move.w     (a0),d1
		cmp.w      d1,d0
		blt.s      find_miny2
		exg        d1,d0
find_miny2:
		addq.l     #4,a0
		dbf        d7,find_miny1
		move.w     d0,(a1)
		movem.l    (a7)+,a0-a6
		rts

find_maxy:
		movem.l    a0-a6,-(a7)
		lea.l      pptsin+2(pc),a0
		lea.l      polyfill_maxy(pc),a1
		move.l     polyfill_pts(pc),d7
		subq.w     #1,d7
		clr.l      d0
		move.w     d0,(a1)
find_maxy1:
		move.w     (a0),d1
		cmp.w      d1,d0
		bgt.s      find_maxy2
		exg        d1,d0
find_maxy2:
		addq.l     #4,a0
		dbf        d7,find_maxy1
		move.w     d0,(a1)
		movem.l    (a7)+,a0-a6
		rts

polyfill_pts: ds.l 1
polyfill_array: ds.l 1
polyfill_y1: ds.w 1
polyfill_maxy: ds.w 1

control: ds.w 10

pptsin: ds.w 64*2

lib36:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc contourfill X,Y,COLOR
 */
lib37:
	dc.w	0			; no library calls
falc_contourfill:
		move.l     (a6)+,d3
		andi.l     #15,d3
		lea.l      contourfill_work(pc),a0
		move.w     d3,30(a0) /* BUG: relies on layout of internal VDI structure */
		move.l     (a6)+,d3
		lea.l      contourfill_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      contourfill_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    lineavars-params(a6),a0
		lea.l      contourfill_intin(pc),a5
		move.l     a5,LA_INTIN(a0)
		lea.l      contourfill_x(pc),a5
		move.l     a5,LA_PTSIN(a0)
		lea.l      contourfill_work(pc),a5
		move.l     a5,CUR_WORK(a0) /* BUG: relies on layout of internal VDI structure */
		lea.l      fill_abort(pc),a5
		move.l     a5,LA_FILL_ABORT(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-params(a6),a5
		move.w     stipple_mask-params(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     DEV_TAB(a0),d0
		move.w     DEV_TAB+2(a0),d1
		move.w     #1,LA_CLIP(a0)
		move.w     #0,LA_XMN_CLIP(a0)
		move.w     #0,LA_YMN_CLIP(a0)
		move.w     d0,LA_XMX_CLIP(a0)
		move.w     d1,LA_YMX_CLIP(a0)
		dc.w       0xa00f /* seed_fill */
		movem.l    (a7)+,a0-a6
		rts

fill_abort:
		clr.l      d0
		rts

contourfill_x: ds.w 1
contourfill_y: ds.w 1
contourfill_intin: dc.w -1
contourfill_work: ds.w 16


lib38:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc circle X,Y,R
 */
lib39:
	dc.w	0			; no library calls
falc_circle:
		move.l     (a6)+,d3
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      circle_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		move.l     (a6)+,d3
		lea.l      circle_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      circle_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a4
		move.l     sintab_offset-entry(a4),d4
		adda.l     d4,a4
		movea.l    lineavars-params(a6),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_circle1
		lea.l      circle_rad+2(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_circle1:
		movea.l    lineavars-params(a6),a0
		move.w     currcolor-params(a6),d0
		bsr        clinea_setcolor
		movem.l    a0-a6,-(a7)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-params(a6),a5
		move.w     stipple_mask-params(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		lea.l      circle_coords(pc),a3
		clr.l      d7
falc_circle2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d0
		move.w     2(a4,d6.w),d1
		neg.w      d1
		move.w     circle_rad(pc),d4
		move.w     circle_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d0
		muls.w     d5,d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      circle_x(pc),d0
		add.w      circle_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     0(a4,d6.w),d2
		neg.w      d2
		move.w     2(a4,d6.w),d3
		neg.w      d3
		move.w     circle_rad(pc),d4
		move.w     circle_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d2
		muls.w     d5,d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      circle_x(pc),d2
		add.w      circle_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars-params(a6),a0
		lea.l      circle_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa004 /* horizontal_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #360,d7
		blt        falc_circle2
		movem.l    (a7)+,a0-a6
		lea.l      circle_coords(pc),a3
		clr.l      d7
falc_circle3:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     circle_rad(pc),d0
		muls.w     circle_rad+2(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      circle_x(pc),d0
		add.w      circle_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     circle_rad(pc),d2
		muls.w     circle_rad+2(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      circle_x(pc),d2
		add.w      circle_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars-params(a6),a0
		lea.l      circle_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #720,d7
		blt        falc_circle3
		movem.l    (a7)+,a0-a6
		rts

/* FIXME: duplicate code */
clinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      clinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
clinea_setcolor1:
		btst       #1,d0
		beq.s      clinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
clinea_setcolor2:
		btst       #2,d0
		beq.s      clinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
clinea_setcolor3:
		btst       #3,d0
		beq.s      clinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
clinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      clinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      clinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
clinea_setcolor5:
		btst       #5,d0
		beq.s      clinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
clinea_setcolor6:
		btst       #6,d0
		beq.s      clinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
clinea_setcolor7:
		btst       #7,d0
		beq.s      clinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
clinea_setcolor8:
		rts

circle_rad: ds.w 2
circle_x: ds.w 1
circle_y: ds.w 1
circle_coords: ds.w 4

lib40:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc ellipse X,Y,X_RAD,Y_RAD
 */
lib41:
	dc.w	0			; no library calls
falc_ellipse:
		move.l     (a6)+,d3
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      ellipse_rad+2(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      ellipse_rad(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      ellipse_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		lea.l      ellipse_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a4
		move.l     sintab_offset-entry(a4),d4
		adda.l     d4,a4
		movea.l    lineavars-params(a6),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_ellipse1
		lea.l      ellipse_rad+2(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_ellipse1:
		movea.l    lineavars-params(a6),a0
		move.w     currcolor-params(a6),d0
		bsr        elinea_setcolor
		movem.l    a0-a6,-(a7)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		movea.l    stipple_ptr-params(a6),a5
		move.w     stipple_mask-params(a6),d0
		move.l     a5,LA_PATPTR(a0)
		move.w     d0,LA_PATMSK(a0)
		move.w     #0,LA_MULTIFILL(a0)
		lea.l      ellipse_coords(pc),a3
		clr.l      d7
falc_ellipse2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d0
		move.w     2(a4,d6.w),d1
		neg.w      d1
		move.w     ellipse_rad(pc),d4
		move.w     ellipse_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d0
		muls.w     d5,d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      ellipse_x(pc),d0
		add.w      ellipse_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     0(a4,d6.w),d2
		neg.w      d2
		move.w     2(a4,d6.w),d3
		neg.w      d3
		move.w     ellipse_rad(pc),d4
		move.w     ellipse_rad+2(pc),d5
		subq.w     #1,d4
		subq.w     #1,d5
		muls.w     d4,d2
		muls.w     d5,d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      ellipse_x(pc),d2
		add.w      ellipse_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars-params(a6),a0
		lea.l      ellipse_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa004 /* horizontal_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #360,d7
		blt        falc_ellipse2
		movem.l    (a7)+,a0-a6
		lea.l      ellipse_coords(pc),a3
		clr.l      d7
falc_ellipse3:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     ellipse_rad(pc),d0
		muls.w     ellipse_rad+2(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      ellipse_x(pc),d0
		add.w      ellipse_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     ellipse_rad(pc),d2
		muls.w     ellipse_rad+2(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      ellipse_x(pc),d2
		add.w      ellipse_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars-params(a6),a0
		lea.l      ellipse_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmpi.w     #720,d7
		blt        falc_ellipse3
		movem.l    (a7)+,a0-a6
		rts

/* FIXME: duplicate code */
elinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      elinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
elinea_setcolor1:
		btst       #1,d0
		beq.s      elinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
elinea_setcolor2:
		btst       #2,d0
		beq.s      elinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
elinea_setcolor3:
		btst       #3,d0
		beq.s      elinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
elinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      elinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      elinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
elinea_setcolor5:
		btst       #5,d0
		beq.s      elinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
elinea_setcolor6:
		btst       #6,d0
		beq.s      elinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
elinea_setcolor7:
		btst       #7,d0
		beq.s      elinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
elinea_setcolor8:
		rts

ellipse_rad: ds.w 2
ellipse_x: ds.w 1
ellipse_y: ds.w 1
ellipse_coords: ds.w 4

lib42:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc earc X,Y,X_RAD,Y_RAD,BEG_ANGLE,END_ANGLE
 */
lib43:
	dc.w	0			; no library calls
falc_earc:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		cmpi.l     #3600,d3
		bgt        falc_earc3
		lea.l      earc_end_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		cmpi.l     #3600,d3
		bgt        falc_earc3
		lea.l      earc_beg_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		andi.l     #255,d3 /* BUG: why clamp? */
		lea.l      earc_yrad(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		andi.l     #511,d3 /* BUG: why clamp? */
		lea.l      earc_xrad(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		lea.l      earc_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_earc3
		lea.l      earc_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a4
		move.l     sintab_offset-entry(a4),d4
		adda.l     d4,a4
		movea.l    lineavars-params(a6),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_earc1
		lea.l      earc_yrad(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_earc1:
		movea.l    lineavars-params(a6),a0
		move.w     currcolor-params(a6),d0
		bsr        ealinea_setcolor
		lea.l      earc_coords(pc),a3
		move.w     earc_beg_angle(pc),d7
falc_earc2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     earc_xrad(pc),d0
		muls.w     earc_yrad(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      earc_x(pc),d0
		add.w      earc_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     earc_xrad(pc),d2
		muls.w     earc_yrad(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      earc_x(pc),d2
		add.w      earc_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars-params(a6),a0
		lea.l      earc_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      earc_end_angle(pc),d7
		blt        falc_earc2
		movem.l    (a7)+,a0-a6
falc_earc3:
		rts

/* FIXME: duplicate code */
ealinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      ealinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
ealinea_setcolor1:
		btst       #1,d0
		beq.s      ealinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
ealinea_setcolor2:
		btst       #2,d0
		beq.s      ealinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
ealinea_setcolor3:
		btst       #3,d0
		beq.s      ealinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
ealinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      ealinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      ealinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
ealinea_setcolor5:
		btst       #5,d0
		beq.s      ealinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
ealinea_setcolor6:
		btst       #6,d0
		beq.s      ealinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
ealinea_setcolor7:
		btst       #7,d0
		beq.s      ealinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
ealinea_setcolor8:
		rts

earc_beg_angle: ds.w 1
earc_end_angle: ds.w 1
earc_xrad: ds.w 1
earc_yrad: ds.w 1
earc_x: ds.w 1
earc_y: ds.w 1
earc_coords: ds.w 4

lib44:
	dc.w	0			; no library calls
	rts

/*
 * Syntax:   _falc arc X,Y,R,BEG_ANGLE,END_ANGLE
 */
lib45:
	dc.w	0			; no library calls
falc_arc:
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		cmpi.l     #3600,d3
		bgt        falc_arc3
		lea.l      arc_end_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		cmpi.l     #3600,d3
		bgt        falc_arc3
		lea.l      arc_beg_angle(pc),a0
		divu.w     #5,d3
		move.w     d3,(a0)
		move.l     (a6)+,d3
		andi.l     #511,d3 /* BUG: why clamp? */
		lea.l      arc_rad(pc),a0
		move.w     d3,(a0)
		move.w     d3,2(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		lea.l      arc_y(pc),a0
		move.w     d3,(a0)
		move.l     (a6)+,d3
		tst.l      d3
		bmi        falc_arc3
		lea.l      arc_x(pc),a0
		move.w     d3,(a0)
		movem.l    a0-a6,-(a7)
		movea.l    debut(a5),a6
		movea.l    0(a6,d1.w),a6
		move.l     params_offset-entry(a6),d4
		adda.l     d4,a6
		movea.l    debut(a5),a0
		movea.l    0(a0,d1.w),a4
		move.l     sintab_offset-entry(a4),d4
		adda.l     d4,a4
		movea.l    lineavars-params(a6),a0
		clr.l      d0
		clr.l      d1
		move.w     DEV_TAB(a0),d0
		addq.w     #1,d0
		move.w     DEV_TAB+2(a0),d1
		addq.w     #1,d1
		divu.w     d1,d0
		andi.l     #3,d0
		cmpi.w     #1,d0
		beq.s      falc_arc1
		lea.l      arc_rad+2(pc),a0
		move.w     (a0),d3
		asr.w      #1,d3
		move.w     d3,(a0)
falc_arc1:
		movea.l    lineavars-params(a6),a0
		move.w     currcolor-params(a6),d0
		bsr        alinea_setcolor
		lea.l      arc_coords(pc),a3
		move.w     arc_beg_angle(pc),d7
falc_arc2:
		move.w     d7,d6
		asl.w      #2,d6
		move.w     0(a4,d6.w),d1
		move.w     2(a4,d6.w),d0
		muls.w     arc_rad(pc),d0
		muls.w     arc_rad+2(pc),d1
		divs.w     #1000,d0
		divs.w     #1000,d1
		add.w      arc_x(pc),d0
		add.w      arc_y(pc),d1
		move.w     d0,(a3)
		move.w     d1,2(a3)
		move.w     4(a4,d6.w),d3
		move.w     6(a4,d6.w),d2
		muls.w     arc_rad(pc),d2
		muls.w     arc_rad+2(pc),d3
		divs.w     #1000,d2
		divs.w     #1000,d3
		add.w      arc_x(pc),d2
		add.w      arc_y(pc),d3
		move.w     d2,4(a3)
		move.w     d3,6(a3)
		movem.l    d0-d7/a0-a6,-(a7)
		movea.l    lineavars-params(a6),a0
		lea.l      arc_coords(pc),a1
		move.w     (a1)+,LA_X1(a0)
		move.w     (a1)+,LA_Y1(a0)
		move.w     (a1)+,LA_X2(a0)
		move.w     (a1)+,LA_Y2(a0)
		move.w     #0,LA_LSTLIN(a0)
		move.w     colormask-params(a6),LA_LN_MASK(a0)
		move.w     wrt_mode-params(a6),LA_WRT_MODE(a0)
		move.w     #0,LA_CLIP(a0)
		dc.w       0xa003 /* draw_line */
		movem.l    (a7)+,d0-d7/a0-a6
		addq.w     #1,d7
		cmp.w      arc_end_angle(pc),d7
		blt        falc_arc2
		movem.l    (a7)+,a0-a6
falc_arc3:
		rts

/* FIXME: duplicate code */
alinea_setcolor:
		clr.l      LA_FG_1(a0)
		clr.l      LA_FG_3(a0)
		btst       #0,d0
		beq.s      alinea_setcolor1
		bset       #0,LA_FG_1+1(a0)
alinea_setcolor1:
		btst       #1,d0
		beq.s      alinea_setcolor2
		bset       #0,LA_FG_2+1(a0)
alinea_setcolor2:
		btst       #2,d0
		beq.s      alinea_setcolor3
		bset       #0,LA_FG_3+1(a0)
alinea_setcolor3:
		btst       #3,d0
		beq.s      alinea_setcolor4
		bset       #0,LA_FG_4+1(a0)
alinea_setcolor4:
		cmpi.w     #8,LA_PLANES(a0)
		bne.s      alinea_setcolor8
		/* BUG: must also set FG_B_PLANES */
		clr.l      LA_FG_5(a0)
		clr.l      LA_FG_7(a0)
		btst       #4,d0
		beq.s      alinea_setcolor5
		bset       #0,LA_FG_5+1(a0)
alinea_setcolor5:
		btst       #5,d0
		beq.s      alinea_setcolor6
		bset       #0,LA_FG_6+1(a0)
alinea_setcolor6:
		btst       #6,d0
		beq.s      alinea_setcolor7
		bset       #0,LA_FG_7+1(a0)
alinea_setcolor7:
		btst       #7,d0
		beq.s      alinea_setcolor8
		bset       #0,LA_FG_8+1(a0)
alinea_setcolor8:
		rts

arc_beg_angle: ds.w 1
arc_end_angle: ds.w 1
arc_rad: ds.w 2
arc_x: ds.w 1
arc_y: ds.w 1
arc_coords: ds.w 4


libex:
	dc.w 0

ZERO equ 0

