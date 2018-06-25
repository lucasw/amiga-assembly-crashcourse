#!/usr/bin/env python
# Copyright 2018 Lucas Walter
# Convert a Gimp 8-color raw data r,g,b to an Amiga image in a n-bit plane raw format
# Needs to be 19200 bytes
# Is that:
# 320*160* 3 bits/pixel / 8 bits/bytes
# or just make it 320x200 and get rid of the blk.b command in the code


format = '''

convert a 4 color sprite:
./convert_gimp_raw_bit_planes.py image.data 16 2 h

         bit plane 0  | bit plane 1  | bit plane 2
row 0    8pixels/byte
...
row 160


So each row has the three bit planes in a row:
first 320/8 = 40 bytes of bp 0, then 40 of 1, then 40 of bit plane 2


'''

import cv2
import numpy as np
import sys

if len(sys.argv) < 5:
    print './convert_gimp_raw_bit_planes.py image.data width num_bit_planes h-or-v'
    sys.exit(0)
data_file = sys.argv[1]
print "input file: ", data_file
width = int(sys.argv[2])  # 320
print "width", width
num_bit_planes = int(sys.argv[3])
print "bit planes", num_bit_planes
pixels_per_byte = 8  # 1 << num_bit_planes
# print "pixels per byte: ", pixels_per_byte

horizontal_mode = sys.argv[4] == 'h'

data = []
with open(data_file, 'rb') as src:
    for src_byte in src.read():
        data.append(ord(src_byte))

if len(data) < width:
    print "not enough data ", len(data)
    sys.exit(1)

height = len(data) / width
print "num_bytes: ", len(data), "height: ", height
# Every bytes in the gimp indexed image is one byte regardless of how few
# colors there are, it doesn't try to pack them tighter.
# The next steps is to separate each byte into bit planes and then arrange
# the bit planes in either of two ways:
#  A single row contains all the bit planes of that row in sequence
# or a single 'column' contains all the bit planes in sequence
# (which actually means in linear order the entire bit plane of each image
# in sequence)

bit_planes = []

for bp_ind in range(num_bit_planes):
    bit_planes.append([])
    bit_mask = 1 << bp_ind
    for ind in range(len(data)):
        val = (data[ind] & bit_mask) >> bp_ind
        bit_planes[bp_ind].append(val)

# pack each set of 8 bits into bytes 
packed_bit_planes = []
bpb = 8
packed_width = width / bpb
print 'packed width', packed_width
for bp_ind in range(len(bit_planes)):
    packed_bit_planes.append([])
    for out_ind in range(len(bit_planes[bp_ind]) / bpb):
        new_byte = 0
        for bit_ind in range(bpb):
            src_ind = out_ind * bpb + bit_ind
            # reverse the bit order
            shift = (bpb - bit_ind - 1)
            new_byte |= bit_planes[bp_ind][src_ind] << shift
        packed_bit_planes[bp_ind].append(new_byte)

if len(packed_bit_planes) <= 0:
    print "no packed bit planes"
    sys.exit(1)

if horizontal_mode:
    viz = np.zeros((height, width * num_bit_planes, 1), np.uint8)
else:
    viz = np.zeros((height * num_bit_planes, width, 1), np.uint8)

# arrange the bit planes in the desired order in the output file
with open(data_file + '.raw', 'wb') as f:
    num_bytes = 0

    ymax = len(packed_bit_planes[0]) / packed_width
    print 'ymax', ymax
    if horizontal_mode:
        print 'horizontal mode'
        for y in range(ymax):
            for bp_ind in range(len(packed_bit_planes)):
                for x in range(packed_width):
                    ind = y * packed_width + x
                    img_byte = packed_bit_planes[bp_ind][ind]
                    f.write(chr(img_byte))
                    num_bytes += 1
                    for i in range(bpb):
                        if (1 << i) & img_byte:
                            viz[y, width * bp_ind + x * bpb + (bpb - 1 - i)] = 255
    else:
        print 'vertical mode'
        for bp_ind in range(len(packed_bit_planes)):
            # don't need x and y, could just loop through data, but here for
            # symmetry with above
            for y in range(ymax):
                for x in range(packed_width):
                    ind = y * packed_width + x
                    img_byte = packed_bit_planes[bp_ind][ind]
                    f.write(chr(img_byte))
                    num_bytes += 1
                    for i in range(bpb):
                        if (1 << i) & img_byte:
                            yv = height * bp_ind + y
                            xv = x * bpb + (bpb - 1 - i)
                            # print yv, xv, viz.shape
                            viz[yv, xv] = 255

    print 'num_bytes ', num_bytes

cv2.imwrite("viz.png", viz)

# finally write the palette
with open(data_file + ".pal", 'rb') as src, open(data_file + '_color.asm', 'w') as f:
    col = []
    # TODO(lucasw) need color offset, may not be using color 0 to start
    addr = int("01800000", 16)
    color_ind = 0
    for src_byte in src.read():
        col.append(ord(src_byte))
        if len(col) == 3:
            # print [(comp) for comp in col]
            # need to squash each component to 4 bits
            r = ((col[0] >> 4) & 0xf) << 8
            g = ((col[1] >> 4) & 0xf) << 4
            b = ((col[2] >> 4) & 0xf)
            rgb = r + g + b
            # print hex(r), hex(g), hex(b), hex(rgb)
            # asm copper format
            line = '  move.l #$' + "{0:0{1}x}".format(addr + rgb, 8) + ',(a6)+  ; color ' + str(color_ind)
            print line
            f.write(line + '\n')
            col = []
            addr += 0x20000
            color_ind += 1
