local awful = require("awful")
local keybindings = require("modules.keybindings")

local function move_to_tag(t)
  if client.focus then
    client.focus:move_to_tag(t)
  end
end

local function toggle_tag(t)
  if client.focus then
    client.focus:toggle_tag(t)
  end
end

function minimize_or_show(c)
  if c == client.focus then
    c.minimized = true
  else
    -- Without this, the following
    -- :isvisible() makes no sense
    c.minimized = false
    if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
    end
    -- This will also un-minimize
    -- the client, if needed
    client.focus = c
    c:raise()
  end
end

function show_task_selector()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
   end
  end

end

awful.util.taglist_buttons = awful.util.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({keybindings.super}, 1, move_to_tag),
  awful.button({keybindings.super}, 3, toggle_tag)
)

awful.util.tasklist_buttons = awful.util.table.join(
  awful.button({}, 1, minimize_or_show),
  awful.button({}, 3, show_task_selector),
  awful.button({}, 4, function () awful.client.focus.byidx(-1) end),
  awful.button({}, 5, function () awful.client.focus.byidx(1) end)
)

