local titlebar = {}
local awful = require("awful")
local wibox = require("wibox")

local function define_buttons(c)
  local buttons = awful.util.table.join(
    awful.button({ }, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      client.focus = c
      c:raise()
      awful.mouse.client.resize(c)
    end)
  )
  return buttons
end

local function define_title(titlebar_font, c)
  return function()
    title = awful.titlebar.widget.titlewidget(c)
    title.font = titlebar_font
    return title
  end
end

function titlebar.init(beautiful, titlebar_size, titlebar_font)

  -- Add a titlebar if titlebars_enabled is set to true in the rules.
  client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
      beautiful.titlebar_fun(c)
      return
    end
  
    -- Default
    awful.titlebar(c, {size = titlebar_size}) : setup {
      { -- Left
        awful.titlebar.widget.closebutton(c),
        awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        layout  = wibox.layout.fixed.horizontal
      },
      { -- Middle
        { -- Title
          align  = "center",
          widget = define_title(titlebar_font, c)
        },
        buttons = define_buttons(c),
        layout  = wibox.layout.flex.horizontal
      },
      { -- Right
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.iconwidget(c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
  end)
end

return titlebar
