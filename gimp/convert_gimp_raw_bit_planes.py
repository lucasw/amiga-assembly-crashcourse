#!/usr/bin/env python
# Copyright 2018 Lucas Walter
# Convert a Gimp 8-color raw data r,g,b to an Amiga image in a n-bit plane raw format
# Needs to be 19200 bytes
# Is that:
# 320*160* 3 bits/pixel / 8 bits/bytes
# or just make it 320x200 and get rid of the blk.b command in the code


format = '''

convert a 4 color sprite:
./convert_gimp_raw_bit_planes.py image.data 16 2

         bit plane 0  | bit plane 1  | bit plane 2
row 0    8pixels/byte
...
row 160


So each row has the three bit planes in a row:
first 320/8 = 40 bytes of bp 0, then 40 of 1, then 40 of bit plane 2


'''

import sys

data = sys.argv[1]
print "input file: ", data
width = int(sys.argv[2])  # 320
print "width", width
bitplanes = int(sys.argv[3])
print "bit planes", bitplanes
pixels_per_byte = 8  # 1 << bitplanes
# print "pixels per byte: ", pixels_per_byte

# Make a 'flag' with two color squares on top,
# and a solid rectangle on the bottom
with open(data, 'rb') as src, open(data + '.raw', 'wb') as f:
    row = []
    num_bytes = 0
    for src_byte in src.read():
        row.append(ord(src_byte))
        if len(row) == width:
            for bp in range(bitplanes):
                for xb in range(width / pixels_per_byte):
                    img_byte = 0
                    plane_mask = (1 << bp)
                    for b in range(pixels_per_byte):
                        ind = xb * pixels_per_byte + b
                        srcb = row[ind]
                        masked_src = ((srcb & plane_mask) >> bp)
                        # print ind, srcb, masked_src  # , type(srcb)
                        img_byte += masked_src << (pixels_per_byte - b - 1)
                    # print xb, hex(img_byte), plane_mask
                    f.write(chr(img_byte))
                    num_bytes += 1
            row = []
    print 'num_bytes ', num_bytes

with open(data + ".pal", 'rb') as src, open(data + '_color.asm', 'w') as f:
    col = []
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
