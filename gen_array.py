#!/usr/bin/python

import math

msg = "dc.b "
num = 32
amp = 10
for i in range(num):
    msg += str(int(amp * math.cos(float(i) / float(num) * math.pi))) + ","
    # msg += "-1,"
print msg
