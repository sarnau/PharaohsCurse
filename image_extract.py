#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import struct
import binascii
from PIL import Image, ImageDraw, ImageShow, ImageFont

font12 = ImageFont.truetype('FiraCode-Regular.ttf', 12)
font8 = ImageFont.truetype('FiraCode-Regular.ttf', 8)

PIXEL_SET = '█︎'
PIXEL_CLEAR = ' '

data = bytearray(0x480) + bytearray(open('./Pharaohs Curse.bin','rb').read())

class bcolors:
	BLACK = '\033[38;5;0m'
	WHITE = '\033[38;5;15m'
	RED = '\033[38;5;1m'
	CYAN = '\033[38;5;13m'
	PURPLE = '\033[38;5;5m'
	GREEN = '\033[38;5;2m'
	BLUE = '\033[38;5;4m'
	YELLOW = '\033[38;5;11m'

	ORANGE = '\033[38;5;220m'
	BROWN = '\033[38;5;88m'
	LIGHT_RED = '\033[38;5;9m'
	DARK_GREY = '\033[38;5;238m'
	GREY = '\033[38;5;244m'
	LIGHT_GREEN = '\033[38;5;10m'
	LIGHT_BLUE = '\033[38;5;12m'
	LIGHT_GREY = '\033[38;5;252m'
	
	DEFAULT = '\033[1;39m'

atari_colors = (
			bcolors.BLACK,
			bcolors.YELLOW,
			bcolors.LIGHT_GREY,
			bcolors.BLUE,
			)

colortable_ntsc = [
 0x000000, 0x101010, 0x1f1f1f, 0x2f2f2f, 0x3e3e3e, 0x4e4e4e, 0x5e5e5e, 0x6e6e6e, 0x797979, 0x8a8a8a, 0x9c9c9c, 0xadadad, 0xbfbfbf, 0xd2d2d2, 0xe6e6e6, 0xfcfcfc,
 0x110900, 0x241d00, 0x342c00, 0x433c00, 0x514a00, 0x615a00, 0x716a00, 0x817a00, 0x8c850c, 0x9c951f, 0xaea734, 0xbfb847, 0xd0c95b, 0xe3dc71, 0xf6f087, 0xffffa1,
 0x2a0000, 0x3d0b00, 0x4c1b00, 0x5b2b00, 0x693a00, 0x794a00, 0x885a04, 0x976a16, 0xa27522, 0xb28634, 0xc39848, 0xd4aa5c, 0xe4bb6f, 0xf7cf84, 0xffe29a, 0xfff9b3,
 0x360000, 0x490100, 0x581100, 0x672100, 0x752f00, 0x844008, 0x93501a, 0xa2602b, 0xad6c37, 0xbd7d49, 0xcd8f5c, 0xdea16f, 0xeeb282, 0xffc697, 0xffdaac, 0xfff1c4,
 0x420000, 0x540000, 0x630204, 0x721214, 0x802123, 0x8f3233, 0x9e4244, 0xad5354, 0xb75e60, 0xc77071, 0xd88284, 0xe89496, 0xf8a6a7, 0xffbabb, 0xffced0, 0xffe5e7,
 0x3e002a, 0x51003e, 0x60004d, 0x6f065c, 0x7d156a, 0x8c2679, 0x9b3789, 0xaa4798, 0xb453a3, 0xc464b3, 0xd577c4, 0xe589d4, 0xf59ce5, 0xffb0f7, 0xffc4ff, 0xffdcff,
 0x0f0077, 0x220089, 0x320097, 0x410fa5, 0x501eb2, 0x5f2ec1, 0x6f3fcf, 0x7f50dd, 0x8a5be7, 0x9a6df5, 0xac7fff, 0xbd91ff, 0xcea3ff, 0xe1b7ff, 0xf4ccff, 0xffe3ff,
 0x000076, 0x000288, 0x0c1297, 0x1c22a5, 0x2b31b2, 0x3b41c0, 0x4c51ce, 0x5c61dc, 0x686de6, 0x797ef5, 0x8b90ff, 0x9da2ff, 0xafb3ff, 0xc2c7ff, 0xd6dbff, 0xedf2ff,
 0x000065, 0x001077, 0x002086, 0x082f94, 0x173ea1, 0x284eb0, 0x395ebe, 0x496ecc, 0x5579d7, 0x668ae6, 0x799cf6, 0x8baeff, 0x9ebfff, 0xb2d2ff, 0xc6e6ff, 0xddfcff,
 0x00074f, 0x001b62, 0x002a71, 0x003a7f, 0x0b488d, 0x1b589c, 0x2c68ab, 0x3d78b9, 0x4983c4, 0x5b94d3, 0x6ea5e3, 0x80b7f3, 0x93c8ff, 0xa7dbff, 0xbceeff, 0xd3ffff,
 0x000f3b, 0x00234e, 0x00325d, 0x00426c, 0x035079, 0x146089, 0x257098, 0x367fa7, 0x428ab1, 0x539bc1, 0x67acd2, 0x79bee2, 0x8ccff2, 0xa0e1ff, 0xb5f5ff, 0xcdffff,
 0x001a17, 0x002d2b, 0x003d3a, 0x004c49, 0x005a58, 0x0c6a67, 0x1e7a77, 0x2f8987, 0x3b9492, 0x4da4a2, 0x60b6b3, 0x73c7c4, 0x86d7d5, 0x9aeae8, 0xb0fdfb, 0xc8ffff,
 0x002500, 0x003800, 0x004803, 0x005713, 0x006522, 0x0d7432, 0x1e8443, 0x2f9353, 0x3b9e5f, 0x4dae70, 0x60bf83, 0x73d095, 0x86e0a7, 0x9bf3bb, 0xb0ffcf, 0xc8ffe6,
 0x001e00, 0x003100, 0x0c4100, 0x1c5000, 0x2a5e00, 0x3b6e00, 0x4b7d00, 0x5b8d00, 0x67970c, 0x78a81f, 0x8ab933, 0x9cca47, 0xaedb5b, 0xc2ed71, 0xd6ff87, 0xedffa0,
 0x001300, 0x132600, 0x233600, 0x324500, 0x415400, 0x516300, 0x617300, 0x718300, 0x7c8e08, 0x8d9e1b, 0x9fb02f, 0xb0c143, 0xc1d257, 0xd5e46d, 0xe8f883, 0xfeff9d,
 0x1e0000, 0x311400, 0x412400, 0x503300, 0x5e4200, 0x6e5200, 0x7d6200, 0x8d7209, 0x977d15, 0xa88e28, 0xb9a03c, 0xcab150, 0xdbc263, 0xedd679, 0xffe98f, 0xffffa8
]


def drawFont(addr,firstChar=0x00,lastChar=0x40,isColor=False):
	print('Font $%04x $%02x-$%02x' % (addr,firstChar,lastChar))
	print('=====================')
	if isColor:
		width = 4
		lineLen = 16
	else:
		width = 8
		lineLen = 8
	gap = 0
	chheight = 8
	for cindex in range(firstChar,lastChar+1,lineLen):
		s = ''
		for o in range(0,lineLen):
			st = '$%02x' % (cindex + o)
			s += (st + ' ' * 30)[:width+gap] + ' '
		print(s)
		for row in range(0,chheight):
			s = ''
			for o in range(0,lineLen):
				bstr = '{:08b}'.format(data[addr + (chheight * (cindex + o)) + row])
				st = ''
				if isColor:
					for i in range(0,len(bstr),2):
						val = int(bstr[i:i+2],2)
						st += atari_colors[val]+PIXEL_SET
					st += bcolors.DEFAULT
				else:
					st = bstr.replace('1',PIXEL_SET).replace('0',PIXEL_CLEAR)
				s += st + ' ' + ' ' * gap
			print(s)
	print()

def drawLevels(markActions=False):
	LEVEL_BASE = 0x2000
	LEVEL_SIZE = 0x200
	SCR_WIDTH_CH = 40
	CH_WIDTH = 4
	SCR_WITDH = SCR_WIDTH_CH * CH_WIDTH
	SCR_HEIGHT_CH = 12
	CH_HEIGHT = 8
	SCR_HEIGHT = SCR_HEIGHT_CH * CH_HEIGHT
	MARGIN_Y = MARGIN_X = 20
	LEVELS = 16

	IMAGE_WIDTH = LEVELS // 4 * (SCR_WITDH + MARGIN_X) + MARGIN_X
	IMAGE_HEIGHT = LEVELS // 4 * (SCR_HEIGHT + MARGIN_Y) + MARGIN_Y

	img = Image.new('RGBA', (IMAGE_WIDTH, IMAGE_HEIGHT), color = 'black')
	draw = ImageDraw.Draw(img)
	for level in range(0,LEVELS):
		#print('Level %2d' % (level))
		ladr = LEVEL_BASE + LEVEL_SIZE * level
		levelXOffset = (level & 3) * (SCR_WITDH + MARGIN_X) + MARGIN_X
		levelYOffset = (level >> 2) * (SCR_HEIGHT + MARGIN_Y) + MARGIN_Y
		#img = Image.new('RGBA', (SCR_WITDH, SCR_HEIGHT), color = 'white')
		#draw = ImageDraw.Draw(img)
		colb = colortable_ntsc[0]
		col0 = colortable_ntsc[data[ladr + 0x1EB]]
		col1 = colortable_ntsc[data[ladr + 0x1EC]]
		col2 = colortable_ntsc[data[ladr + 0x1ED]]
		colors = [
			((colb >> 16)&0xff,(colb >> 8)&0xff,colb&0xff,0xFF),
			((col0 >> 16)&0xff,(col0 >> 8)&0xff,col0&0xff,0xFF),
			((col1 >> 16)&0xff,(col1 >> 8)&0xff,col1&0xff,0xFF),
			((col2 >> 16)&0xff,(col2 >> 8)&0xff,col2&0xff,0xFF),
		]
		for row in range(0,SCR_HEIGHT_CH):
			s = ''
			for col in range(0,SCR_WIDTH_CH):
				b = data[ladr + row * SCR_WIDTH_CH + col]
				xpos = levelXOffset + col * CH_WIDTH
				ypos = levelYOffset + row * CH_HEIGHT
				b &= 0x7F
				LEVEL_FONT = 0x1800
				if level==14 and row<=8:
					LEVEL_FONT = 0x4000
				if b == 0x5E: # Treasure character left
					LEVEL_FONT = ladr + 0x1F0 # stored at the end of the level
					b = 0
				elif b == 0x5F: # Treasure character right
					LEVEL_FONT = ladr + 0x1F8 # stored at the end of the level
					b = 0
				for y in range(0,CH_HEIGHT):
					bf = data[LEVEL_FONT + (CH_HEIGHT * b) + y]
					bstr = '{:08b}'.format(bf)
					for x in range(0,CH_WIDTH):
						val = int(bstr[x * 2:(x + 1)*2],2)
						draw.point([(xpos + x, ypos + y)], colors[val])

		if markActions: # actionable tiles
			for row in range(0,SCR_HEIGHT_CH):
				s = ''
				for col in range(0,SCR_WIDTH_CH):
					b = data[ladr + row * SCR_WIDTH_CH + col]
					xpos = levelXOffset + col * CH_WIDTH
					ypos = levelYOffset + row * CH_HEIGHT
					if b & 0x80:
						b &= 0x7F
						if (b == 0x5C or b == 0x5D): # key (red)
							cc = (0xFF,0x00,0x00,0xFF)
							draw.text((xpos, ypos), u"K", font=font8, align ="left")
						elif (b == 0x5E or b == 0x5F): # treasure (green)
							cc = (0x00,0xFF,0x00,0xFF)
							draw.text((xpos, ypos), u"T", font=font8, align ="left")
						elif (b >= 0x60 and b <= 0x67): # trap (blue)
							cc = (0x00,0x00,0xFF,0xFF)
							draw.text((xpos, ypos), u"P", font=font8, align ="left")
						elif (b >= 0x70 and b <= 0x77): # door (cyan)
							cc = (0x00,0xFF,0xFF,0xFF)
							draw.text((xpos, ypos), u"D", font=font8, align ="left")
						elif b == 0x00: # full tile (white)
							cc = (0xFF,0xFF,0xFF,0xFF)
							draw.text((xpos, ypos), u"?", font=font8, align ="left")
						if False:
							for y in range(0,CH_HEIGHT):
								for x in range(0,CH_WIDTH):
									draw.point([(xpos + x, ypos + y)], cc)

		if markActions: # starting positions when entering from different directions
			for r in range(0,4):
				if r == 0: # top = red
					d = u"↑"
				elif r == 1: # bottom = green
					d = u"↓"
				elif r == 2: # left = blue
					d = u"←"
				elif r == 3: # right = cyan
					d = u"→"
				if data[ladr + 0x1E3 + r * 2] >= 20 and (data[ladr + 0x1E4 + r * 2] - 34) < 192:
					x = levelXOffset + data[ladr + 0x1E3 + r * 2] - 48
					y = levelYOffset + (data[ladr + 0x1E4 + r * 2] - 34) // 2
					draw.text((x-2, y-2), d, font=font12, align ="left")

		if markActions: # elevators
			ytop = (data[ladr + 0x1E0] - 34) // 2
			ybottom = (data[ladr + 0x1E1] - 34) // 2
			x = (data[ladr + 0x1E2] - 48) // 4 * 4
			if x > 20 and (ybottom - 34) < 192:
				draw.rectangle([(levelXOffset + x, levelYOffset + ytop),(levelXOffset + x+7, levelYOffset + ybottom)], outline ="red")

		#img.save('%d.png' % (level))
	img.save('levels.png')

def drawPM(addr,firstChar=0x00,lastChar=0x40,isColor=False):
	print('Font $%04x $%02x-$%02x' % (addr,firstChar,lastChar))
	print('==================')
	if isColor:
		width = 4
	else:
		width = 8
	chheight = 16
	for cindex in range(firstChar,lastChar//2+1):
		s = '$%02x / $%04x' % (cindex * 2,addr + (chheight * cindex))
		print(s)
		for row in range(0,chheight):
			bf = data[addr + (chheight * cindex) + row]
			bstr = '{:08b}'.format(bf)
			st = ''
			if isColor:
				for i in range(0,len(bstr),2):
					val = int(bstr[i:i+2],2)
					st += atari_colors[val]+PIXEL_SET
				st += bcolors.DEFAULT
			else:
				for i in range(0,len(bstr),1):
					val = int(bstr[i:i+1],2)
					if val:
						st += PIXEL_SET * 2
					else:
						st += PIXEL_CLEAR * 2
			print(st)
	print()


if True:
	drawFont(0x1800,0x00,0x7F,True)  # multi color - Font for characters in the rooms
	drawFont(0x1C00,0x00,0x1F,False) # single color - Font for the top status bar
	drawFont(0x1C00,0x20,0x3F,True)  # multi color
	drawFont(0x4000,0x00,0x3F,True)  # multi color - Font the the exit room with the game title

if True:
	drawLevels(markActions=True)

if True:
	drawPM(0x1100,0x00,0x3F,False)
