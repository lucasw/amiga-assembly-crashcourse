#!/usr/bin/env python
# Generate an Amiga image in a 3-bit plane raw format
# Needs to be 19200 bytes
# Is that:
# 320*160* 3 bits/pixel / 8 bits/bytes
# or just make it 320x200 and get rid of the blk.b command in the code


format = '''
         bit plane 0  | bit plane 1  | bit plane 2
row 0    8pixels/byte
...
row 160


So each row has the three bit planes in a row:
first 320/8 = 40 bytes of bp 0, then 40 of 1, then 40 of bit plane 2


'''

# Make a 'flag' with two color squares on top,
# and a solid rectangle on the bottom
with open('temp.raw', 'wb') as f:
    # for ind_plane in range(3):
    for y in range(160):
        # index through the bit planes
        for b in range(3):
            for x in range(320 / 8):
                # this should be the bits for 8 pixels
                if y < 80:
                    # first bit plane
                    if b == 0:
                        f.write(chr(0b11111111))
                    # second bit plane
                    elif b == 1:
                        if (x < 20):
                            f.write(chr(0b11111111))
                        else:
                            f.write(chr(0))
                    # third bit plane
                    else:
                        f.write(chr(0))
                else:
                    f.write(chr(0b11111111))
