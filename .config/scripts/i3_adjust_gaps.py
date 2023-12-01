#!/usr/bin/env python3
import i3ipc
from i3ipc import Event

i3 = i3ipc.Connection()

def on_event(self, e):
    display = None
    outputs = i3.get_outputs()

    for output in outputs:
        if (output.current_workspace == e.current.name):
            display = output.name

    if (display == "HDMI-A-0"):
        i3.command("gaps left current set 10, gaps bottom current set 60, gaps right current set 10, gaps top current set 40")

    if (display == "DisplayPort-0"):
        i3.command("gaps left current set 48, gaps bottom current set 5, gaps right current set 10, gaps top current set 40")


# Subscribe to events
i3.on(Event.WORKSPACE_INIT, on_event)
i3.on(Event.WORKSPACE_FOCUS, on_event)
i3.on(Event.WORKSPACE_MOVE, on_event)
i3.on(Event.WORKSPACE_RELOAD, on_event)

# Start the main loop and wait for events to come in.
i3.main()

