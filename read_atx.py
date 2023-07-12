#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, math
from PIL import Image, ImageDraw
import struct

sizex = 300
sizey = (18 + 9) * 40

def y_for_track_sector(track, sector):
	return (18 + 9) * track + sector

def loadATX(atxFilename,filename_out,renderFloppy=True):
	data = bytearray(open(atxFilename,'rb').read())
	SECTOR_SIZE = 128
	SECTORS_PER_TRACK = 18
	TRACK_COUNT = 40
	DISK_SIZE = TRACK_COUNT * SECTORS_PER_TRACK * SECTOR_SIZE
	#dheader = struct.pack('<3h',0x0296,DISK_SIZE//16,SECTOR_SIZE) + bytearray(10)
	#ddata = bytearray(DISK_SIZE)

	if filename_out:
		if renderFloppy:
			size = 40000//16
			track_distance = size // 150
			img = Image.new('RGB', (size, size), color = 'white')
			draw = ImageDraw.Draw(img)
		else:
			img = Image.new('RGB', (sizex, sizey), color = 'white')
			pixels = img.load()
			draw = ImageDraw.Draw(img)

	offset = 0

	# read file header
	header,version_number,fh_size = struct.unpack('<4sh22xl16x', data[offset+0:offset+0x30])
	if header != b'AT8X':
		print('File Header AT8X not found')
		return False
	if fh_size != 48:
		print('File Header Size != 48 bytes')
		return False
	if version_number != 1:
		print('File Header Version != 1')
		return False
	offset += fh_size

	while offset < len(data):
		# read track header
		th_record_size,record_type,track_number,sector_count,th_size = struct.unpack('<lh2xB1xh8xl8x', data[offset+0:offset+0x20])
		if th_size != 32:
			print('Track Header Size != 32 bytes')
			return False
		if record_type != 0:
			print('Track Header record type != data track')
			return False
		track = data[offset+0:offset+th_record_size]

		if filename_out:
			if renderFloppy:
				radius = size * .99 / 2 - track_number * track_distance
				radius1 = radius - track_distance / 2.1
				radius2 = radius + track_distance / 2.1

				for i in range(0, 3000 * 8):
					angle = i / (3000 * 8) * 2 * math.pi
					x1 = int(round(size // 2 + radius1 * math.sin(angle)))
					y1 = int(round(size // 2 + radius1 * math.cos(angle)))
					x2 = int(round(size // 2 + radius2 * math.sin(angle)))
					y2 = int(round(size // 2 + radius2 * math.cos(angle)))
					value = (0x40, 0, 0)
					draw.line((x1, y1, x2, y2), fill = value, width = 2)
			else:
				track_y = y_for_track_sector(track_number, 0)
				draw.line((0, track_y, sizex - 1, track_y), fill = (0xc0, 0xc0, 0xc0), width = 1)
				draw.text((5, track_y + 2), str(track_number), fill=(0, 0, 0))

		# read sector list header
		record_size,record_type = struct.unpack('<lB3x', track[th_size+0:th_size+8])
		if record_type != 1:
			print('Sector List Header record type != sector list')
			return False

		# read sector list
		for sectorHeaderOffset in range(th_size+8,th_size+record_size,8):
			sector_number,sector_status,sector_position,start_data = struct.unpack('<BBhl', track[sectorHeaderOffset+0:sectorHeaderOffset+8])
			#for l in range(0,SECTOR_SIZE):
			#	ddata[SECTORS_PER_TRACK * SECTOR_SIZE * track_number + (sector_number - 1) * SECTOR_SIZE + l] = track[start_data + l]

			x = 20
			y = y_for_track_sector(track_number, sectorHeaderOffset // 8)
			status = []
			if sector_status == 0x00:
				status.append('OK')
			else:
				if sector_status & 0x80: # NOT READY - not valid/useful in the file
					status.append('Reserved:80')
				if sector_status & 0x40:
					status.append('EXTND DATA')
				if sector_status & 0x20:
					status.append('deleted DAM')
				if sector_status & 0x10:
					status.append('RECORD NOT FOUND')
				if sector_status & 0x08:
					status.append('CRC ERROR')
				if sector_status & 0x04:
					status.append('LOST DATA')
				if sector_status & 0x02: # DRQ - not valid/useful in the file
					status.append('Reserved:02')
				if sector_status & 0x01: # BUSY - not valid/useful in the file
					status.append('Reserved:01')
			sstr = ','.join(status)

			# read sector data as well
			sno = track_number * 18 + sector_number
			spos = sector_position * 8 / 1000
			print('Sector #%3d, Track #%2d Sector #%2d / %s / %7.3fms' % (sno, track_number, sector_number,sstr,spos),end='')

			lc = track[start_data+0]
			for i in range(1,SECTOR_SIZE):
				if lc != track[start_data+i]:
					lc = -1
					break
			if lc >= 0:
				print(' / $%02x * %d' % (lc, SECTOR_SIZE))
			else:
				print('')
				for l in range(0,SECTOR_SIZE,16):
					print('%02x: ' % l,end='')
					for p in range(0,16):
						print('%02x ' % track[start_data + l + p],end='')
					print(' ',end='')
					for p in range(0,16):
						c = track[start_data + l + p]
						if c < 0x20 or c >= 0x7F:
							c = ord('.')
						print('%c' % c,end='')
					print('')

			if filename_out:
				if renderFloppy:
					sectorlen = SECTOR_SIZE * 8
					for i in range(0, sectorlen):
						angle = (spos / 200 + i / (3000 * 8)) * 2 * math.pi
						x1 = int(round(size // 2 + radius1 * math.sin(angle)))
						y1 = int(round(size // 2 + radius1 * math.cos(angle)))
						x2 = int(round(size // 2 + radius2 * math.sin(angle)))
						y2 = int(round(size // 2 + radius2 * math.cos(angle)))
						if i // 8 == 0:
							value = (0xff, 0, 0) # sync = red
						else:
							byte = track[start_data + i // 8]
							pixel = ((byte >> (i % 7)) & 1) * 255
							value = (0, pixel, 0) # shades of green

						draw.line((x1, y1, x2, y2), fill = value, width = 2)
				else:
					for i in range(0, SECTOR_SIZE):
						value = track[start_data + i]
						if sector_status & 0x7C:
							colorValue = (value, 0, 0)
						else:
							colorValue = (0, value, 0)
						pixels[x, y] = colorValue
						pixels[x+1, y] = colorValue
						x += 2
			
		print('=' * 40)
		# proceed to the next track
		offset += th_record_size

	if filename_out:
		#img = img.resize((int(size // 16), int(size // 16)), Image.LANCZOS)
		img.save(filename_out)

	#open(atxFilename + '.dsk','wb').write(dheader+ddata)
	return True

loadATX("Pharaoh's Curse, The (1983)(Synapse Software)(US).atx",'a.png',renderFloppy=False)
