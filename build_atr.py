#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys,os
import struct

SECTOR_SIZE = 128
SECTORS_PER_TRACK = 18
TRACK_COUNT = 40
DISK_SIZE = TRACK_COUNT * SECTORS_PER_TRACK * SECTOR_SIZE

objectCode = sys.argv[1]
objectSymbols = sys.argv[2]
outputFile = sys.argv[3]
originalFile = sys.argv[4]

data = bytearray(open(objectCode,'rb').read())

labels = {}
for l in open(objectSymbols).readlines():
	_,adr,label = l.strip().split(' ')
	adr = int(adr,16)
	labels[label] = adr
	#print('%#06x %s' % (adr,label))

# if copy protection is enabled, just verify that the code is 100% identical
if '.COPY_PROTECTION' in labels and not '.PATCH_PROTECTION' in labels:
	os.system('cmp %s %s' % (objectCode,originalFile))
else:
	print('- no compare')

dheader = struct.pack('<3h',0x0296,DISK_SIZE//16,SECTOR_SIZE) + bytearray(10)
ddata = bytearray(DISK_SIZE)

for i in range(0,SECTOR_SIZE*data[1]):
	ddata[i] = data[i]

codeStartSector = labels['.START_SECTOR']
mainOffset = labels['.START']-labels['.__CODE_LOAD__']
for i in range(0,labels['.__CODE_SIZE__']-mainOffset):
	ddata[(codeStartSector - 1) * SECTOR_SIZE + i] = data[i+mainOffset]

open(outputFile,'wb').write(dheader+ddata)
