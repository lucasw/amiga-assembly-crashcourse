#!/usr/bin/env python

import numpy as np
import scikits.audiolab
import sys
import struct

sound_file = sys.argv[1]

# data = np.random.uniform(-127,128,4000).astype(np.int8)
# scikits.audiolab.play(data / 128.0, fs=2000)

if sound_file.endswith('.wav'):
    data, fs, enc = scikits.audiolab.wavread(sound_file)
    print len(data), type(data), type(data[0]), data.shape, fs, enc
    # scikits.audiolab.play(data, fs=8000)
    data = data[::5]  # 44100 KHz to 8820

    fr = 128
    datai = (data * fr).astype(np.int8)
    print min(data), max(data), '->', min(datai), max(datai)
    #data = (data/2).astype(int) * 2
    scikits.audiolab.play(datai / float(fr), fs=fs/5.0)
    print len(data), 'bytes'
    datai.tofile(sound_file + '.raw')

else:
    # open a other uncompressed raw headerless signed 8-bit pcm from audacity
    count = 0
    with open(sound_file, 'rb') as src:
        data = []
        for src_byte in src.read():
            d = struct.unpack('b', src_byte)[0]  # ord(src_byte)
            if count < 32:
                print src_byte, d, type(d) # , ord(src_byte)  # ord convertes to unsigned
            data.append(d)
            count += 1

        sound = np.array(data)
        # audacity is exporting at 44100 KHz, not the native sample rate
        sound = sound[::5]
        print len(sound)

        scikits.audiolab.play(sound / 128.0, fs=8820)
