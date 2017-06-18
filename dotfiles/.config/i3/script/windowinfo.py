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
if screen.get_active_window() != None:
    curmon = screen.get_monitor_at_window(screen.get_active_window())
else:
    x, y, mods = window.get_screen().get_root_window().get_pointer()
    curmon = screen.get_monitor_at_point(x, y) 

x, y, width, height = monitors[curmon]

command = sys.argv[1]
widthSub = 0
heightSub = 0

if len(sys.argv) == 4:
  widthSub = int(sys.argv[2]);
  heightSub = int(sys.argv[3]);

if command == 'size':
    print "%d %d" % (width - 10 - widthSub, height - 90 - heightSub )
elif command == 'position':
    print "%d 56" % (x+3)
