local window_manager = {}
local awful = require("awful")
local gears = require("gears")

function window_manager.init(beautiful)
  -- Create a wibox for each screen and add it
  awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
  awful.util.spawn_with_shell("killall -9 conky; conky --config ~/.config/conky/rc.lua")
 
  -- {{{ Screen
  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, false)
    end
  end)
  
  -- Signal function to execute when a new client appears.
  client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
  
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
  end)
  
  -- Enable sloppy focus, so that focus follows mouse.
  client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus ~= nil
        and awful.client.focus.filter(c) 
        and client.focus ~= nil
        and client.focus.instance ~= "guake" then
        client.focus = c
    end
  end)

  screen.connect_signal("list", awesome.restart)
end

return window_manager
