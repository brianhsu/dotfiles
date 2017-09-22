local menu = {}
local awful         = require("awful")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local myawesomemenu = {
  {"顯示快捷鍵", function() return false, hotkeys_popup.show_help end },
  {"重新啟動", awesome.restart },
  {"離開", function() awesome.quit() end }
}

function menu.init(beautiful, terminal)

  awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {{"Awesome", myawesomemenu, beautiful.awesome_icon }},
    after = {{"終端機", awful.util.terminal }}
  })

end

return menu
