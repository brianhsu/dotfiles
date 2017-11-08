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
local tyrannical = require("tyrannical")

-- Variable definitions
local chosen_theme = "powerarrow-mine"
local terminal     = "xfce4-terminal"
local titlebar_size = 24
local titlebar_font = "Source Han Sans TW Medium 10"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
hiddentag = awful.tag({ 'hidden' }, s, awful.layout.suit.max)
awful.tag.setproperty(hiddentag[1],'hide',true)
awful.util.terminal = terminal
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

tyrannical.tags = {
    {
        name        = "[1]  瀏覽",
      --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
        init        = true,                   -- Load the tag on startup
        exclusive   = true,                   -- Refuse any other type of clients (by classes)
        screen      = {1,2},                  -- Create this tag on screen 1 and screen 2
        layout      = awful.layout.suit.max,  -- Use the tile layout
        class = {
            "Opera"         , "Firefox"        , "Rekonq"    , "Dillo"        , "Arora",
            "Chromium"      , "nightly"        , "minefield", "Google-chrome", "PCManX", "Postman"
        }
    } ,
    {
        name        = "[2]  開發",
        init        = true,
        exclusive   = true,
        screen      = {1, 2},			  
        layout      = awful.layout.suit.max,      
        instance    = {"FitnessIDE"},
        class       = {"Mysql-workbench-bin", "jetbrains-idea-ce", "FitnessIDE"}
    } ,
    {
        name        = "[3]  影音",
        init        = true,
        exclusive   = true,
        screen      = {1, 2},
        layout      = awful.layout.suit.spiral,
        class  = { "mpv", "Deadbeef"}
    } ,
    {
        name        = "[4]  檔案",
        init        = true,
        exclusive   = true,
        screen      = {1, 2},
        layout      = awful.layout.suit.spiral,
        class       = {"Thunar", "mpv", "Nemo"}
    } ,
    {
        name        = "[5]  一般",
	init	    = true,
        exclusive   = false,
	fallback    = true,
        layout      = awful.layout.suit.spiral
    }
}
tyrannical.properties.intrusive = {
    "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
    "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
    "kcolorchooser" , "plasmoidviewer" , "Xephyr"    , "kruler"       , "plasmaengineexplorer",
}
tyrannical.settings.group_children = true --Force popups/dialogs to have the same tags as the parent client
-- Background Service
autostart.run_once({"compton --config ~/.config/compton.conf -b"})
autostart.run_once({"conky -c ~/.config/conky/rc.lua"})
autostart.run_once({"sleepMegasync"})

-- Initialize
beautiful.init(theme_path)
revelation.init()
menu.init(beautiful, awful.util.terminal)
titlebar.init(beautiful, titlebar_size, titlebar_font)
taskbar.init()
window_manager.init(beautiful)
revelation.tag_name = '[O] 所有視窗'
revelation.charorder = "1234567890asdfghjkl;'"

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
      titlebars_enabled = true 
    }
  },

  -- Application Finder
  {
    rule_any = {class = {"Xfce4-appfinder"}},
    properties = { floating = false, intrusive=true, ontop = true } 
  },

  -- Floating
  {
    rule_any = { instance = {"guake"} },
    properties = { floating = true, ontop = true, titlebars_enabled = false, intrusive=true }
  },


  -- XFCE4 Panel, 不要顯示小方框在標籤列表上
  {
    rule = {class = "Xfce4-panel", name = "xfce4-panel"},
    properties = { 
      titlebars_enabled = false, 
      intrusive=true,
      border_width = 0,
      floating = true,
      sticky = true,
      ontop = false,
      focusable = false,
      below = true,
      tag = hiddentag[1]
    } 
  },
  {
    rule = {class = "conky"},
    properties = { 
      titlebars_enabled = false, 
      intrusive=true,
      floating = true,
      sticky = true,
      ontop = false,
      focusable = false,
      below = true,
      tag = hiddentag[1],
      switchtotag = false
    } 
  },

}


