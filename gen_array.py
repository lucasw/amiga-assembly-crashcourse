#!/usr/bin/python

import math

msg = "dc.b "
num = 32
amp = 3
for i in range(num):
    msg += str(int(amp * math.cos(float(i) / float(num) * 2.0 * math.pi))) + ","
    # msg += "-1,"
print msg[:-1]
