local mousebindings = {}
local awful = require("awful")
local keybindings = require("modules.keybindings")

root.buttons(awful.util.table.join(
  awful.button({}, 3, function () awful.util.mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

mousebindings.clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ keybindings.super }, 1, awful.mouse.client.move),
  awful.button({ keybindings.super }, 3, awful.mouse.client.resize)
)

return mousebindings
