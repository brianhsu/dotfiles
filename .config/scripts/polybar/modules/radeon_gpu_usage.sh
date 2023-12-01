#!/usr/bin/python

import subprocess

proc = subprocess.Popen(['radeontop', '-d', '-'],stdout=subprocess.PIPE)

for line in iter(proc.stdout.readline,''):
    message = str(line)
    if "gpu" in message:
        usage = message.split(",")[1][5:][:-1]
        print(usage + "%", flush = True)

