/* m68k-atari-mint-gcc -nostdlib -o mouse.spr  -Wl,--oformat,binary mouse.s */

	.text

	.dc.l 0x19861987
start:
	.dc.l sprlo-start
	.dc.l sprmed-start
	.dc.l sprhi-start
	.dc.w 3
	.dc.w 3
	.dc.w 3

sprlo:
	.dc.l sprlo0-sprlo
	.dc.b 1,16,0,0
	.dc.l sprlo1-sprlo
	.dc.b 1,21,5,0
	.dc.l sprlo2-sprlo
	.dc.b 1,16,8,9

sprlo0:
	/* mask */
	.dc.w 0x00ff
	.dc.w 0x007f
	.dc.w 0x007f
	.dc.w 0x00ff
	.dc.w 0x007f
	.dc.w 0x003f
	.dc.w 0x001f
	.dc.w 0x900f
	.dc.w 0xf807
	.dc.w 0xfc03
	.dc.w 0xfe03
	.dc.w 0xff07
	.dc.w 0xff8f
	.dc.w 0xffff
	.dc.w 0xffff
	.dc.w 0xffff

	/* data */
	.dc.w 0xff00
	.dc.w 0xff00
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0xc080
	.dc.w 0xc080
	.dc.w 0x7f00
	.dc.w 0x0000
	.dc.w 0xa080
	.dc.w 0xe080
	.dc.w 0x7f00
	.dc.w 0x0000
	.dc.w 0xd100
	.dc.w 0xb100
	.dc.w 0x7e00
	.dc.w 0x0000
	.dc.w 0xe880
	.dc.w 0x9880
	.dc.w 0x7f00
	.dc.w 0x0000
	.dc.w 0xf440
	.dc.w 0x8c40
	.dc.w 0x7f80
	.dc.w 0x0000
	.dc.w 0xfa20
	.dc.w 0x9620
	.dc.w 0x6fc0
	.dc.w 0x0000
	.dc.w 0x6d10
	.dc.w 0x6b10
	.dc.w 0x07e0
	.dc.w 0x0000
	.dc.w 0x0688
	.dc.w 0x0588
	.dc.w 0x03f0
	.dc.w 0x0000
	.dc.w 0x0344
	.dc.w 0x02c4
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01a4
	.dc.w 0x0164
	.dc.w 0x00f8
	.dc.w 0x0000
	.dc.w 0x00d8
	.dc.w 0x00b8
	.dc.w 0x0070
	.dc.w 0x0000
	.dc.w 0x0070
	.dc.w 0x0070
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000

sprlo1:
	/* mask */
	.dc.w 0xf3ff
	.dc.w 0xe1ff
	.dc.w 0xe1ff
	.dc.w 0xe1ff
	.dc.w 0xe1ff
	.dc.w 0xe1ff
	.dc.w 0xe1ff
	.dc.w 0xe03f
	.dc.w 0xe007
	.dc.w 0x8001
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x8001
	.dc.w 0xc003
	.dc.w 0xe007
	.dc.w 0xe007

	/* data */
	.dc.w 0x0c00
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x1600
	.dc.w 0x1600
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x1600
	.dc.w 0x1600
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x1600
	.dc.w 0x1600
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x1600
	.dc.w 0x1600
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x1600
	.dc.w 0x1600
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x1600
	.dc.w 0x1600
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x17c0
	.dc.w 0x17c0
	.dc.w 0x0c00
	.dc.w 0x0000
	.dc.w 0x16f8
	.dc.w 0x16f8
	.dc.w 0x0d80
	.dc.w 0x0000
	.dc.w 0x70de
	.dc.w 0x70de
	.dc.w 0x0fb0
	.dc.w 0x0000
	.dc.w 0xd01d
	.dc.w 0xd01f
	.dc.w 0x2ff6
	.dc.w 0x0000
	.dc.w 0x9005
	.dc.w 0x9007
	.dc.w 0x6ffe
	.dc.w 0x0000
	.dc.w 0x9005
	.dc.w 0x9007
	.dc.w 0x6ffe
	.dc.w 0x0000
	.dc.w 0x9005
	.dc.w 0x9007
	.dc.w 0x6ffe
	.dc.w 0x0000
	.dc.w 0x9005
	.dc.w 0x9007
	.dc.w 0x6ffe
	.dc.w 0x0000
	.dc.w 0x800b
	.dc.w 0x800f
	.dc.w 0x7ffc
	.dc.w 0x0000
	.dc.w 0x800a
	.dc.w 0x800e
	.dc.w 0x7ffc
	.dc.w 0x0000
	.dc.w 0x400a
	.dc.w 0x400e
	.dc.w 0x3ffc
	.dc.w 0x0000
	.dc.w 0x2014
	.dc.w 0x201c
	.dc.w 0x1ff8
	.dc.w 0x0000
	.dc.w 0x1028
	.dc.w 0x1038
	.dc.w 0x0ff0
	.dc.w 0x0000
	.dc.w 0x1028
	.dc.w 0x1038
	.dc.w 0x0ff0
	.dc.w 0x0000

sprlo2:
	/* mask */
	.dc.w 0xfe7f
	.dc.w 0xfc3f
	.dc.w 0xfe7f
	.dc.w 0xf00f
	.dc.w 0xc003
	.dc.w 0x8001
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x8001
	.dc.w 0xc003
	.dc.w 0xf00f

	/* data */
	.dc.w 0x0180
	.dc.w 0x0000
	.dc.w 0x0180
	.dc.w 0x0000
	.dc.w 0x0340
	.dc.w 0x0000
	.dc.w 0x03c0
	.dc.w 0x0000
	.dc.w 0x0180
	.dc.w 0x0000
	.dc.w 0x0180
	.dc.w 0x0000
	.dc.w 0x0ff0
	.dc.w 0x0000
	.dc.w 0x0ff0
	.dc.w 0x0000
	.dc.w 0x3ddc
	.dc.w 0x0440
	.dc.w 0x3ffc
	.dc.w 0x0000
	.dc.w 0x71c6
	.dc.w 0x1040
	.dc.w 0x7ffe
	.dc.w 0x0000
	.dc.w 0xe003
	.dc.w 0x2000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0xc61d
	.dc.w 0x4000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0xc371
	.dc.w 0x4000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0xe187
	.dc.w 0x0000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0xc001
	.dc.w 0x4000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0xc001
	.dc.w 0x4000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0xe003
	.dc.w 0x2000
	.dc.w 0xffff
	.dc.w 0x0000
	.dc.w 0x79c6
	.dc.w 0x1840
	.dc.w 0x7ffe
	.dc.w 0x0000
	.dc.w 0x3ddc
	.dc.w 0x0440
	.dc.w 0x3ffc
	.dc.w 0x0000
	.dc.w 0x0ff0
	.dc.w 0x0000
	.dc.w 0x0ff0
	.dc.w 0x0000

sprmed:
	.dc.l sprmed0-sprmed
	.dc.b 2,16,0,0
	.dc.l sprmed1-sprmed
	.dc.b 2,22,11,0
	.dc.l sprmed2-sprmed
	.dc.b 2,16,15,9

sprmed0:
	/* mask */
	.dc.w 0x1fff
	.dc.w 0xffff
	.dc.w 0x001f
	.dc.w 0xffff
	.dc.w 0x8000
	.dc.w 0x3fff
	.dc.w 0xc003
	.dc.w 0xffff
	.dc.w 0xc000
	.dc.w 0xffff
	.dc.w 0xc400
	.dc.w 0x3fff
	.dc.w 0xe700
	.dc.w 0x0fff
	.dc.w 0xe7c0
	.dc.w 0x03ff
	.dc.w 0xfff0
	.dc.w 0x00ff
	.dc.w 0xfffc
	.dc.w 0x003f
	.dc.w 0xffff
	.dc.w 0x001f
	.dc.w 0xffff
	.dc.w 0xc01f
	.dc.w 0xffff
	.dc.w 0xf07f
	.dc.w 0xffff
	.dc.w 0xffff
	.dc.w 0xffff
	.dc.w 0xffff
	.dc.w 0xffff
	.dc.w 0xffff

	/* data */
	.dc.w 0xe000
	.dc.w 0x8000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0xffe0
	.dc.w 0xc020
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x7fff
	.dc.w 0x6000
	.dc.w 0xc000
	.dc.w 0x4000
	.dc.w 0x3ffc
	.dc.w 0x3004
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x3fff
	.dc.w 0x3001
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x3bff
	.dc.w 0x3300
	.dc.w 0xc000
	.dc.w 0x4000
	.dc.w 0x18ff
	.dc.w 0x18c0
	.dc.w 0xf000
	.dc.w 0x1000
	.dc.w 0x183f
	.dc.w 0x1830
	.dc.w 0xfc00
	.dc.w 0x0400
	.dc.w 0x000f
	.dc.w 0x000c
	.dc.w 0xff00
	.dc.w 0x0100
	.dc.w 0x0003
	.dc.w 0x0003
	.dc.w 0xffc0
	.dc.w 0x0040
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0xffe0
	.dc.w 0xc020
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x3fe0
	.dc.w 0x3020
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0f80
	.dc.w 0x0f80
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000

sprmed1:
	/* mask */
	.dc.w 0xff87
	.dc.w 0xffff
	.dc.w 0xfe01
	.dc.w 0xffff
	.dc.w 0xfe01
	.dc.w 0xffff
	.dc.w 0xfe01
	.dc.w 0xffff
	.dc.w 0xfe01
	.dc.w 0xffff
	.dc.w 0xfe01
	.dc.w 0xffff
	.dc.w 0xfe01
	.dc.w 0xffff
	.dc.w 0xfe00
	.dc.w 0x1fff
	.dc.w 0xfe00
	.dc.w 0x007f
	.dc.w 0xc000
	.dc.w 0x0007
	.dc.w 0x0000
	.dc.w 0x0003
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x8000
	.dc.w 0x0001
	.dc.w 0xc000
	.dc.w 0x0001
	.dc.w 0xe000
	.dc.w 0x0003
	.dc.w 0xf000
	.dc.w 0x0007
	.dc.w 0xf800
	.dc.w 0x001f
	.dc.w 0xfc00
	.dc.w 0x001f
	.dc.w 0xfe00
	.dc.w 0x001f
	.dc.w 0xff00
	.dc.w 0x001f

	/* data */
	.dc.w 0x0078
	.dc.w 0x0078
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01fe
	.dc.w 0x0186
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01fe
	.dc.w 0x0186
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01fe
	.dc.w 0x0186
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01fe
	.dc.w 0x0186
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01fe
	.dc.w 0x0186
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01fe
	.dc.w 0x0186
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x01ff
	.dc.w 0x0187
	.dc.w 0xe000
	.dc.w 0xe000
	.dc.w 0x01ff
	.dc.w 0x0186
	.dc.w 0xff80
	.dc.w 0x1f80
	.dc.w 0x3fff
	.dc.w 0x3f86
	.dc.w 0xfff8
	.dc.w 0x18f8
	.dc.w 0xffff
	.dc.w 0xf184
	.dc.w 0xfffc
	.dc.w 0x004c
	.dc.w 0xffff
	.dc.w 0xc180
	.dc.w 0xfffe
	.dc.w 0x0006
	.dc.w 0xffff
	.dc.w 0xc100
	.dc.w 0xfffe
	.dc.w 0x0006
	.dc.w 0xffff
	.dc.w 0xc100
	.dc.w 0xfffe
	.dc.w 0x0006
	.dc.w 0x7fff
	.dc.w 0x6000
	.dc.w 0xfffe
	.dc.w 0x0006
	.dc.w 0x3fff
	.dc.w 0x3000
	.dc.w 0xfffe
	.dc.w 0x0006
	.dc.w 0x1fff
	.dc.w 0x1800
	.dc.w 0xfffc
	.dc.w 0x000c
	.dc.w 0x0fff
	.dc.w 0x0c00
	.dc.w 0xfff8
	.dc.w 0x0038
	.dc.w 0x07ff
	.dc.w 0x0600
	.dc.w 0xffe0
	.dc.w 0x0060
	.dc.w 0x03ff
	.dc.w 0x0300
	.dc.w 0xffe0
	.dc.w 0x0060
	.dc.w 0x01ff
	.dc.w 0x0180
	.dc.w 0xffe0
	.dc.w 0x0060
	.dc.w 0x00ff
	.dc.w 0x0080
	.dc.w 0xffe0
	.dc.w 0x0060

sprmed2:
	/* mask */
	.dc.w 0xfff8
	.dc.w 0x7fff
	.dc.w 0xfff0
	.dc.w 0x3fff
	.dc.w 0xfff8
	.dc.w 0x7fff
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xf000
	.dc.w 0x000f
	.dc.w 0xc000
	.dc.w 0x0003
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0xc000
	.dc.w 0x0003
	.dc.w 0xf000
	.dc.w 0x000f
	.dc.w 0xfc00
	.dc.w 0x003f

	/* data */
	.dc.w 0x0007
	.dc.w 0x0007
	.dc.w 0x8000
	.dc.w 0x8000
	.dc.w 0x000f
	.dc.w 0x000c
	.dc.w 0xc000
	.dc.w 0x4000
	.dc.w 0x0007
	.dc.w 0x0007
	.dc.w 0x8000
	.dc.w 0x8000
	.dc.w 0x03ff
	.dc.w 0x03ff
	.dc.w 0xffc0
	.dc.w 0xffc0
	.dc.w 0x0fff
	.dc.w 0x0c03
	.dc.w 0xfff0
	.dc.w 0x8030
	.dc.w 0x3fff
	.dc.w 0x3803
	.dc.w 0xfffc
	.dc.w 0x80cc
	.dc.w 0xffff
	.dc.w 0xc000
	.dc.w 0xffff
	.dc.w 0x0303
	.dc.w 0xffff
	.dc.w 0xc0e0
	.dc.w 0xffff
	.dc.w 0x0c03
	.dc.w 0xffff
	.dc.w 0xc03c
	.dc.w 0xffff
	.dc.w 0x7003
	.dc.w 0xffff
	.dc.w 0xfc07
	.dc.w 0xffff
	.dc.w 0xc03f
	.dc.w 0xffff
	.dc.w 0xc000
	.dc.w 0xffff
	.dc.w 0x0003
	.dc.w 0xffff
	.dc.w 0xc000
	.dc.w 0xffff
	.dc.w 0x0003
	.dc.w 0xffff
	.dc.w 0xc000
	.dc.w 0xfffe
	.dc.w 0x0002
	.dc.w 0x3fff
	.dc.w 0x3003
	.dc.w 0xfffc
	.dc.w 0x800c
	.dc.w 0x0fff
	.dc.w 0x0c03
	.dc.w 0xfff0
	.dc.w 0x8030
	.dc.w 0x03ff
	.dc.w 0x03ff
	.dc.w 0xffc0
	.dc.w 0xffc0

sprhi:
	.dc.l sprhi0-sprhi
	.dc.b 2,27,0,0
	.dc.l sprhi1-sprhi
	.dc.b 2,52,10,1
	.dc.l sprhi2-sprhi
	.dc.b 2,38,15,21
sprhi0:
	/* mask */
	.dc.w 0x0fff
	.dc.w 0xffff
	.dc.w 0x01ff
	.dc.w 0xffff
	.dc.w 0x003f
	.dc.w 0xffff
	.dc.w 0x0007
	.dc.w 0xffff
	.dc.w 0x8000
	.dc.w 0xffff
	.dc.w 0x8000
	.dc.w 0xffff
	.dc.w 0x8000
	.dc.w 0xffff
	.dc.w 0xc001
	.dc.w 0xffff
	.dc.w 0xc001
	.dc.w 0xffff
	.dc.w 0xc000
	.dc.w 0xffff
	.dc.w 0xe000
	.dc.w 0x7fff
	.dc.w 0xe000
	.dc.w 0x3fff
	.dc.w 0xe000
	.dc.w 0x1fff
	.dc.w 0xf000
	.dc.w 0x0fff
	.dc.w 0xf000
	.dc.w 0x07ff
	.dc.w 0xf100
	.dc.w 0x03ff
	.dc.w 0xff80
	.dc.w 0x01ff
	.dc.w 0xffc0
	.dc.w 0x00ff
	.dc.w 0xffe0
	.dc.w 0x007f
	.dc.w 0xfff0
	.dc.w 0x007f
	.dc.w 0xfff8
	.dc.w 0x007f
	.dc.w 0xfffc
	.dc.w 0x007f
	.dc.w 0xfffe
	.dc.w 0x007f
	.dc.w 0xffff
	.dc.w 0x007f
	.dc.w 0xffff
	.dc.w 0x80ff
	.dc.w 0xffff
	.dc.w 0xc1ff
	.dc.w 0xffff
	.dc.w 0xffff

	/* data */
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x6000
	.dc.w 0x0000
	.dc.w 0x7c00
	.dc.w 0x0000
	.dc.w 0x3f80
	.dc.w 0x0000
	.dc.w 0x1ff0
	.dc.w 0x0000
	.dc.w 0x2ffe
	.dc.w 0x0000
	.dc.w 0x17fc
	.dc.w 0x0000
	.dc.w 0x0bf8
	.dc.w 0x0000
	.dc.w 0x15f8
	.dc.w 0x0000
	.dc.w 0x0afc
	.dc.w 0x0000
	.dc.w 0x057e
	.dc.w 0x0000
	.dc.w 0x0abf
	.dc.w 0x0000
	.dc.w 0x055f
	.dc.w 0x8000
	.dc.w 0x02af
	.dc.w 0xc000
	.dc.w 0x0457
	.dc.w 0xe000
	.dc.w 0x002b
	.dc.w 0xf000
	.dc.w 0x0015
	.dc.w 0xf800
	.dc.w 0x000a
	.dc.w 0xfc00
	.dc.w 0x0005
	.dc.w 0x7e00
	.dc.w 0x0002
	.dc.w 0xbf00
	.dc.w 0x0001
	.dc.w 0x5f00
	.dc.w 0x0000
	.dc.w 0xaf00
	.dc.w 0x0000
	.dc.w 0x5700
	.dc.w 0x0000
	.dc.w 0x2a00
	.dc.w 0x0000
	.dc.w 0x1400
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000

sprhi1:
	/* mask */
	.dc.w 0xfc03
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc01
	.dc.w 0xffff
	.dc.w 0xfc00
	.dc.w 0x3fff
	.dc.w 0xfc00
	.dc.w 0x0fff
	.dc.w 0xfc00
	.dc.w 0x007f
	.dc.w 0xfc00
	.dc.w 0x007f
	.dc.w 0xfc00
	.dc.w 0x0007
	.dc.w 0xfc00
	.dc.w 0x0003
	.dc.w 0xc000
	.dc.w 0x0001
	.dc.w 0x8000
	.dc.w 0x0001
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x8000
	.dc.w 0x0001
	.dc.w 0x8000
	.dc.w 0x0003
	.dc.w 0x8000
	.dc.w 0x0003
	.dc.w 0xc000
	.dc.w 0x0003
	.dc.w 0xc000
	.dc.w 0x0007
	.dc.w 0xe000
	.dc.w 0x000f
	.dc.w 0xe000
	.dc.w 0x000f
	.dc.w 0xf000
	.dc.w 0x000f
	.dc.w 0xf800
	.dc.w 0x001f
	.dc.w 0xf800
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f
	.dc.w 0xfc00
	.dc.w 0x003f

	/* data */
	.dc.w 0x00f0
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f8
	.dc.w 0x0000
	.dc.w 0x01f4
	.dc.w 0x0000
	.dc.w 0x01f9
	.dc.w 0x8000
	.dc.w 0x01f5
	.dc.w 0xe000
	.dc.w 0x01fd
	.dc.w 0xf700
	.dc.w 0x01f9
	.dc.w 0xef00
	.dc.w 0x01f5
	.dc.w 0xfbb0
	.dc.w 0x01f9
	.dc.w 0xff78
	.dc.w 0x1dfd
	.dc.w 0xffbc
	.dc.w 0x3df7
	.dc.w 0xfffc
	.dc.w 0x7dff
	.dc.w 0xfffe
	.dc.w 0x7dff
	.dc.w 0xfffa
	.dc.w 0x7dff
	.dc.w 0xfffe
	.dc.w 0x7dff
	.dc.w 0xfff4
	.dc.w 0x7dff
	.dc.w 0xfffa
	.dc.w 0x7dff
	.dc.w 0xfff4
	.dc.w 0x7dff
	.dc.w 0xffea
	.dc.w 0x7fff
	.dc.w 0xfff4
	.dc.w 0x7fff
	.dc.w 0xfff8
	.dc.w 0x3fff
	.dc.w 0xfff4
	.dc.w 0x3fff
	.dc.w 0xffa8
	.dc.w 0x3fff
	.dc.w 0xffd0
	.dc.w 0x1fff
	.dc.w 0xffe8
	.dc.w 0x1fff
	.dc.w 0xff50
	.dc.w 0x0fff
	.dc.w 0xffa0
	.dc.w 0x0fff
	.dc.w 0xffc0
	.dc.w 0x07ff
	.dc.w 0xff60
	.dc.w 0x03ff
	.dc.w 0xfdc0
	.dc.w 0x03ff
	.dc.w 0xff00
	.dc.w 0x01ff
	.dc.w 0xfe80
	.dc.w 0x01ff
	.dc.w 0xfb00
	.dc.w 0x01ff
	.dc.w 0xfe80
	.dc.w 0x01ff
	.dc.w 0xfb00
	.dc.w 0x01ff
	.dc.w 0xfe80
	.dc.w 0x01ff
	.dc.w 0xfb00
	.dc.w 0x01ff
	.dc.w 0xfe80
	.dc.w 0x01ff
	.dc.w 0xfb00

sprhi2:
	/* mask */
	.dc.w 0xfff0
	.dc.w 0x0fff
	.dc.w 0xffe0
	.dc.w 0x07ff
	.dc.w 0xffe0
	.dc.w 0x07ff
	.dc.w 0xffe0
	.dc.w 0x07ff
	.dc.w 0xffe0
	.dc.w 0x07ff
	.dc.w 0xfff0
	.dc.w 0x0fff
	.dc.w 0xfe00
	.dc.w 0x007f
	.dc.w 0xf800
	.dc.w 0x001f
	.dc.w 0xf000
	.dc.w 0x0007
	.dc.w 0xe000
	.dc.w 0x0007
	.dc.w 0xc000
	.dc.w 0x0003
	.dc.w 0x8044
	.dc.w 0x0401
	.dc.w 0x8000
	.dc.w 0x0001
	.dc.w 0x0011
	.dc.w 0x1000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0404
	.dc.w 0x4000
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0101
	.dc.w 0x0010
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0440
	.dc.w 0x0040
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0110
	.dc.w 0x0100
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0444
	.dc.w 0x0440
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0111
	.dc.w 0x1110
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0444
	.dc.w 0x4440
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0111
	.dc.w 0x1100
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x8044
	.dc.w 0x0401
	.dc.w 0x8000
	.dc.w 0x0001
	.dc.w 0xc010
	.dc.w 0x1003
	.dc.w 0xe000
	.dc.w 0x0007
	.dc.w 0xf000
	.dc.w 0x000f
	.dc.w 0xf800
	.dc.w 0x001f
	.dc.w 0xfe00
	.dc.w 0x007f

	/* data */
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0007
	.dc.w 0xe000
	.dc.w 0x000c
	.dc.w 0x1000
	.dc.w 0x000c
	.dc.w 0x1000
	.dc.w 0x0007
	.dc.w 0xe000
	.dc.w 0x0001
	.dc.w 0x8000
	.dc.w 0x0001
	.dc.w 0x8000
	.dc.w 0x00ff
	.dc.w 0xff00
	.dc.w 0x03ff
	.dc.w 0xffc0
	.dc.w 0x07c5
	.dc.w 0xc7f0
	.dc.w 0x0e01
	.dc.w 0x8070
	.dc.w 0x1d11
	.dc.w 0x9138
	.dc.w 0x3800
	.dc.w 0x005c
	.dc.w 0x3444
	.dc.w 0x44cc
	.dc.w 0x7080
	.dc.w 0x018e
	.dc.w 0x71d1
	.dc.w 0x131e
	.dc.w 0x6060
	.dc.w 0x0606
	.dc.w 0x6474
	.dc.w 0x4c46
	.dc.w 0x6018
	.dc.w 0x1806
	.dc.w 0x711d
	.dc.w 0x3116
	.dc.w 0x6005
	.dc.w 0xa006
	.dc.w 0x7c45
	.dc.w 0xc47e
	.dc.w 0x6001
	.dc.w 0x8006
	.dc.w 0x7111
	.dc.w 0x1116
	.dc.w 0x6000
	.dc.w 0x0006
	.dc.w 0x6444
	.dc.w 0x4446
	.dc.w 0x6000
	.dc.w 0x0006
	.dc.w 0x7111
	.dc.w 0x1116
	.dc.w 0x7000
	.dc.w 0x000e
	.dc.w 0x7444
	.dc.w 0x444e
	.dc.w 0x3000
	.dc.w 0x000c
	.dc.w 0x3911
	.dc.w 0x111c
	.dc.w 0x1c01
	.dc.w 0x8038
	.dc.w 0x0e45
	.dc.w 0xc470
	.dc.w 0x07c1
	.dc.w 0x83e0
	.dc.w 0x03ff
	.dc.w 0xffc0
	.dc.w 0x00ff
	.dc.w 0xff00
	.dc.w 0x0000
	.dc.w 0x0000

/* garbage? */
	.dc.w 0x0064
	.dc.w 0x0004
	.dc.w 0x5350
	.dc.w 0x5259
	.dc.w 0x0000
	.dc.w 0x0096
	.dc.w 0x0004
	.dc.w 0x5350
	.dc.w 0x5258
	.dc.w 0x0000
	.dc.w 0x0010
	.dc.w 0x0002
	.dc.w 0x5459
	.dc.w 0x0000
	.dc.w 0x0010
	.dc.w 0x0002
	.dc.w 0x5458
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0004
	.dc.w 0x4d55
	.dc.w 0x4c59
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x4d55
	.dc.w 0x4c58
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0006
	.dc.w 0x5452
	.dc.w 0x414e
	.dc.w 0x5350
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0554
	.dc.w 0x5943
	.dc.w 0x4152
	.dc.w 0x0000
	.dc.w 0x0008
	.dc.w 0x0554
	.dc.w 0x594d
	.dc.w 0x4158
	.dc.w 0x0000
	.dc.w 0x0028
	.dc.w 0x0554
	.dc.w 0x584d
	.dc.w 0x4158
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x0006
	.dc.w 0x4e42
	.dc.w 0x504c
	.dc.w 0x414e
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x0545
	.dc.w 0x4e43
	.dc.w 0x5245
	.dc.w 0x0000
	.dc.w 0x000f
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0064
	.dc.w 0x0004
	.dc.w 0x5350
	.dc.w 0x5259
	.dc.w 0x0000
	.dc.w 0x0096
	.dc.w 0x0004
	.dc.w 0x5350
	.dc.w 0x5258
	.dc.w 0x0000
	.dc.w 0x0010
	.dc.w 0x0002
	.dc.w 0x5459
	.dc.w 0x0000
	.dc.w 0x0010
	.dc.w 0x0002
	.dc.w 0x5458
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0004
	.dc.w 0x4d55
	.dc.w 0x4c59
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x4d55
	.dc.w 0x4c58
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0006
	.dc.w 0x5452
	.dc.w 0x414e
	.dc.w 0x5350
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0554
	.dc.w 0x5943
	.dc.w 0x4152
	.dc.w 0x0000
	.dc.w 0x0008
	.dc.w 0x0554
	.dc.w 0x594d
	.dc.w 0x4158
	.dc.w 0x0000
	.dc.w 0x0028
	.dc.w 0x0554
	.dc.w 0x584d
	.dc.w 0x4158
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x0006
	.dc.w 0x4e42
	.dc.w 0x504c
	.dc.w 0x414e
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x0545
	.dc.w 0x4e43
	.dc.w 0x5245
	.dc.w 0x0000
	.dc.w 0x000f
	.dc.w 0x0000
	.dc.w 0x0000
	.dc.w 0x0002
	.dc.w 0x5459
	.dc.w 0x0000
	.dc.w 0x0028
	.dc.w 0x0002
	.dc.w 0x5458
	.dc.w 0x0000
	.dc.w 0x0004
	.dc.w 0x0004
	.dc.w 0x4d55
	.dc.w 0x4c59
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0004
	.dc.w 0x4d55
	.dc.w 0x4c58
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0006
	.dc.w 0x5452
	.dc.w 0x414e
	.dc.w 0x5350
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0554
	.dc.w 0x5943
	.dc.w 0x4152
	.dc.w 0x0000
	.dc.w 0x0010
	.dc.w 0x0554
	.dc.w 0x594d
	.dc.w 0x4158
	.dc.w 0x0000
	.dc.w 0x0050
	.dc.w 0x0554
	.dc.w 0x584d
	.dc.w 0x4158
	.dc.w 0x0000
	.dc.w 0x0008
	.dc.w 0x0006
	.dc.w 0x4e42
	.dc.w 0x504c
	.dc.w 0x414e
	.dc.w 0x0000
	.dc.w 0x0001
	.dc.w 0x0550
	.dc.w 0x414c
	.dc.w 0x4554
	.dc.w 0x0000
	.dc.w 0x0001
