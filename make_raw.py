#!/usr/bin/env python
# Generate an Amiga image in a 3-bit plane raw format
# Needs to be 19200 bytes
# Is that:
# 320*160* 3 bits/pixel / 8 bits/bytes
# or just make it 320x200 and get rid of the blk.b command in the code

with open('temp.raw', 'wb') as f:
    # for ind_plane in range(3):
    for y in range(160):
        for x in range(320 / 8 * 3):
            if x > 60:
                f.write(chr(255))
            else:
                f.write(chr(0))
