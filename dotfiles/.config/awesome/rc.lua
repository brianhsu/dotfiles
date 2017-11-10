-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local string, os, table, type = string, os, table, type

local awful          = require("awful")
                       require("awful.autofocus")
local beautiful      = require("beautiful")
local error_handler  = require("modules.error_handler")
local autostart      = require("modules.autostart")
local keybindings    = require("modules.keybindings")
local mousebindings  = require("modules.mousebindings")
local taskbar        = require("modules.taskbar")
local menu	     = require("modules.menu")
local titlebar	     = require("modules.titlebar")
local window_manager = require("modules.window_manager")
local revelation     = require("revelation")

-- Variable definitions
local chosen_theme = "powerarrow-mine"
local terminal     = "xfce4-terminal"
local titlebar_size = 24
local titlebar_font = "Source Han Sans TW Medium 10"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)

-- 隱藏的 TAG，用來放諸如 Conky / XFCE4-Panel / Guake 等不應該出現在 TAG 裡的視窗
hiddentag = awful.tag({ '隱藏' }, s, awful.layout.suit.tile)[1]
awful.tag.setproperty(hiddentag, 'hide', true)

awful.util.terminal = terminal
awful.util.tagnames = { "[1]  瀏覽", "[2]  開發", "[3]  影音", "[4]  檔案", "[5]  一般"}
awful.util.taglayouts = {
  awful.layout.suit.max, 
  awful.layout.suit.max, 
  awful.layout.suit.spiral, 
  awful.layout.suit.spiral, 
  awful.layout.suit.spiral
}
awful.layout.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.spiral,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  --awful.layout.suit.tile.left,
  --awful.layout.suit.tile.bottom,
  --awful.layout.suit.tile.top,
  --awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.spiral.dwindle,
  --awful.layout.suit.max.fullscreen,
  --awful.layout.suit.magnifier,
  --awful.layout.suit.corner.nw,
  --awful.layout.suit.corner.ne,
  --awful.layout.suit.corner.sw,
  --awful.layout.suit.corner.se,
}

-- Background Service
autostart.run_once({"sleepMegasync"})
autostart.run_once({"compton --config ~/.config/compton.conf"})

-- Initialize
beautiful.init(theme_path)
revelation.init()
menu.init(beautiful, awful.util.terminal)
titlebar.init(beautiful, titlebar_size, titlebar_font)
taskbar.init()
window_manager.init(beautiful)
revelation.tag_name = '[O] 所有視窗'
revelation.charorder = "1234567890asdfghjkl;'"

function keep_on_current_tag(c)
  local current_tag = awful.screen.focused().selected_tag
  c:toggle_tag(current_tag)
end

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

  -- All clients will match this rule.
  { 
    rule = {},
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      raise = true,
      focus = awful.client.focus.filter,
      maximized = false,
      keys = keybindings.clientkeys,
      buttons = mousebindings.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      size_hints_honor = false,
      switchtotag = true,
      titlebars_enabled = true,
      tag = awful.util.tagnames[5]
    }
  },

  -- Application Finder
  {
    rule_any = {class = {"Xfce4-appfinder"}},
    properties = {
      floating = false, 
      ontop = true 
    } 
  },

  -- Panel
  {
    rule = {class = "Xfce4-panel"},
    properties = { 
      floating = true, 
      focusable = true, 
      dockable = true, 
      tag = hiddentag, 
      titlebars_enabled = false, 
      switchtotag = false, 
      ontop = true, 
      sticky = true  
    } 
  },

  -- Conky
  {   
    rule = { class = "conky" },
    properties = {
      tag = hiddentag,
      titlebars_enabled = false
    }
  },

  -- Guake
  {
    rule_any = { instance = {"guake"} },
    properties = { 
      floating = true, 
      ontop = true, 
      titlebars_enabled = false, 
      sticky=true, 
      switchtotag = false,
      tag = hiddentag
    } 
  },

  -- Tags
  { 
    rule_any = { class = {"Firefox", "Google-chrome", "PCManX"} },
    properties = {tag = awful.util.tagnames[1] } 
  },
  { 
    rule_any = { class = {"Mysql-workbench-bin", "jetbrains-idea-ce"} },
    properties = {tag = awful.util.tagnames[2] } 
  },
  { 
    rule_any = { role = {"FitnessIDE"}},
    properties = {tag = awful.util.tagnames[2], switchtotag = false } 
  },
  { 
    rule_any = { class = {"Deadbeef"}},
    properties = {tag = awful.util.tagnames[3] } 
  },
  { 
    rule_any = { class = {"Thunar", "Nemo"}},
    properties = {tag = awful.util.tagnames[4]} 
  },

  -- MPV
  {
    rule_any = {class = {"mpv"}},
    properties = { 
      floating = false, 
      tag = awful.util.tagnames[3], 
      switchtotag = false  
    },
    callback = keep_on_current_tag
  },
}


