#!/bin/env python
import gtk
import sys

window = gtk.Window()
screen = window.get_screen()

# collect data about each monitor
monitors = []
nmons = screen.get_n_monitors()

for m in range(nmons):
  mg = screen.get_monitor_geometry(m)
  monitors.append(mg)

# current monitor
curmon = screen.get_monitor_at_window(screen.get_active_window())

x, y, width, height = monitors[curmon]

command = sys.argv[1]

if command == 'size':
    print "%d %d" % (width-10,height-90)
elif command == 'position':
    print "%d 56" % (x+3)
