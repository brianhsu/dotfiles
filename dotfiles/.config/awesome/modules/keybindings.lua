local keybindings = {}

local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local awful = require("awful")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local revelation   =require("revelation")
local terminal     = "xfce4-terminal"

local super   = "Mod4"
local alt     = "Mod1"
local ctrl    = "Control"
local shift   = "Shift"

local key_group_awesome         = "[1] Awesome"
local key_group_workflow        = "[2] 工作流程"
local key_group_window_action   = "[3] 視窗操作"
local key_group_window_browser  = "[4] 視窗瀏覽"
local key_group_layout          = "[5] 版面操作"
local key_group_tag_browser     = "[6] 標籤瀏覽"
local key_group_tag_action      = "[7] 標籤操作"

function switch_focus(direction)
  return function()
    awful.client.focus.bydirection(direction)
    if client.focus then client.focus:raise() end
  end
end

function toggle_floating(c)
  return function(c)
    lain.util.magnify_client(c)
    c:raise()
  end
end

function swap_window(direction)
  return function()
    awful.client.swap.bydirection(direction)
  end
end

function maximize_window(c)
  c.maximized = not c.maximized
  c:raise()
end

function view_tag(i)
  return function()
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
       tag:view_only()
    end
  end
end

function toggle_tag(i)
  return function()
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
       awful.tag.viewtoggle(tag)
    end
  end
end

function move_window_to_tag(i)
  return function()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
         client.focus:move_to_tag(tag)
      end
    end
  end
end

function toggle_window_tag()
  return function()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        client.focus:toggle_tag(tag)
      end
    end
  end
end

local function show_runner()
  awful.spawn("rofi -modi \"drun,window\" -show drun -sidebar-mode -font \"Source Han Sans TW 14\"", false)
end

local function adjust_volume(direction, percent)
  return function()
    awful.spawn(string.format("pactl set-sink-volume 0 %s%d%%", direction, percent), false)

  end
end

local function define_global_keys() 
  local keys = awful.util.table.join(
  
    -- Hotkeys
    awful.key({super}, "s", hotkeys_popup.show_help,  
              {description="顯示快速鍵", group=key_group_awesome}),
    awful.key({super}, "w", function () awful.util.mymainmenu:show() end,
              {description = "顯示主選單", group = key_group_awesome}),
    awful.key({shift, super}, "r", awesome.restart,
              {description = "重啟 Awesome", group = key_group_awesome}),
    awful.key({shift, super}, "q", awesome.quit,
              {description = "離開 Awesome", group = key_group_awesome}),
    awful.key({super}, "Return", function () awful.spawn(terminal) end,
              {description = "開啟終端機視窗", group = key_group_awesome}),
    awful.key({super}, "r", show_runner,
              {description = "執行指令", group = key_group_awesome}),

    -- Workflow
    awful.key({alt}, "Left", awful.tag.viewprev,
              {description = "上一個標籤", group = key_group_workflow}),
    awful.key({alt}, "Right",  awful.tag.viewnext,
              {description = "下一個標籤", group = key_group_workflow}),
    awful.key({alt}, "Escape", awful.tag.history.restore,
              {description = "上次使用的標籤", group = key_group_workflow}),
    awful.key({alt}, "Prior", function () lain.util.tag_view_nonempty(-1) end,
              {description = "上一個有視窗的標籤", group = key_group_workflow}),
    awful.key({alt}, "Next", function () lain.util.tag_view_nonempty(1) end,
              {description = "下一個有視窗的標籤", group = key_group_workflow}),
    awful.key({alt}, "Up", function () awful.client.focus.byidx(-1) end,
              {description = "上一個視窗", group = key_group_workflow}),
    awful.key({alt}, "Down", function () awful.client.focus.byidx(1) end,
              {description = "下一個視窗", group = key_group_workflow}),
    awful.key({alt}, "Tab", function () awful.client.focus.byidx(1) end,
              {description = "下一個視窗", group = key_group_workflow}),
    awful.key({alt}, "F11", adjust_volume("-", 3),
              {description = "調低音量", group = key_group_workflow}),
    awful.key({alt}, "F12", adjust_volume("+", 3),
              {description = "調高音量", group = key_group_workflow}),

 
    -- 視窗瀏覽
    awful.key({super}, "Up", switch_focus("up"),
              {description = "切換至上方視窗", group = key_group_window_browser}),
    awful.key({super}, "Down", switch_focus("down"),
              {description = "切換至下方視窗", group = key_group_window_browser}),
    awful.key({super}, "Left", switch_focus("left"),
              {description = "切換至左方視窗", group = key_group_window_browser}),
    awful.key({super}, "Right", switch_focus("right"),
              {description = "切換至右方視窗", group = key_group_window_browser}),
    awful.key({super}, "u", awful.client.urgent.jumpto,
              {description = "切換至緊急狀態視窗", group = key_group_window_browser}),
    awful.key({shift, super}, "Right", function () awful.screen.focus_relative( 1) end,
              {description = "切換至下一個螢幕", group = key_group_window_browser}),
    awful.key({shift, super}, "Left", function () awful.screen.focus_relative(-1) end,
              {description = "切換至上一個螢幕", group = key_group_window_browser}),
    awful.key({super}, "e", revelation,
              {description = "revelation", group = key_group_window_browser}),

    -- 視窗操作
    awful.key({ctrl, super}, "Up", swap_window("up"),
              {description = "與上方視窗交換位置", group = key_group_window_action}),
    awful.key({ctrl, super}, "Down", swap_window("down"),
              {description = "與下方視窗交換位置", group = key_group_window_action}),
    awful.key({ctrl, super}, "Left", swap_window("left"),
              {description = "與左方視窗交換位置", group = key_group_window_action}),
    awful.key({ctrl, super}, "Right", swap_window("right"),
              {description = "與右方視窗交換位置", group = key_group_window_action}),
  
    -- Layout
    awful.key({alt, super}, "Left", function () awful.tag.incmwfact(-0.05) end,
              {description = "減少主視窗大小", group = key_group_layout}),
    awful.key({alt, super}, "Right", function () awful.tag.incmwfact(0.05) end,
              {description = "增加主視窗大小", group = key_group_layout}),
    awful.key({alt, super}, "Down", function () awful.client.incwfact(-0.05) end,
              {description = "減少附視窗大小", group = key_group_layout}),
    awful.key({alt, super}, "Up", function () awful.client.incwfact(0.05) end,
              {description = "增加附視窗大小", group = key_group_layout}),
    awful.key({alt, super}, "=",  function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "增加主視窗數量", group = key_group_layout}),
    awful.key({alt, super}, "-",  function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "減少主視窗數量", group = key_group_layout}),
    awful.key({alt, super}, "Prior", function () awful.tag.incncol(1, nil, true) end,
              {description = "增加畫面欄數", group = key_group_layout}),
    awful.key({alt, super}, "Next", function () awful.tag.incncol(-1, nil, true) end,
              {description = "減少畫面欄數", group = key_group_layout}),
    awful.key({alt}, "space", function () awful.layout.inc(1) end,
              {description = "下一個版面配置", group = key_group_layout}),
    awful.key({alt, shift}, "space", function () awful.layout.inc(-1)                end,
              {description = "上一個版面配置", group = key_group_layout}),
    awful.key({alt}, "F10", function () awful.layout.inc(1) end,
              {description = "下一個版面配置", group = key_group_layout}),
    awful.key({alt}, "F9", function () awful.layout.inc(-1)                end,
              {description = "上一個版面配置", group = key_group_layout}),
  
    awful.key({alt, shift, super}, "=", function () lain.util.useless_gaps_resize(1) end,
              {description = "增加視窗間間隔", group = key_group_layout}),
    awful.key({alt, shift, super}, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "減少視窗間間隔", group = key_group_layout}),
  
    -- Dynamic tagging
    awful.key({alt, super}, "t", function () lain.util.add_tag() end,
              {description = "新增標籤", group = key_group_tag_action}),
    awful.key({alt, super}, "r", function () lain.util.rename_tag() end,
              {description = "重新命名標籤", group = key_group_tag_action}),
    awful.key({alt, super}, "w", function () lain.util.delete_tag() end,
              {description = "刪除標籤", group = key_group_tag_action}),
    awful.key({alt, super, shift}, "Left", function () lain.util.move_tag(-1) end,
              {description = "將標籤往左移", group = key_group_tag_action}),
    awful.key({alt, super, shift}, "Right", function () lain.util.move_tag(1) end,
              {description = "將標籤往右移", group = key_group_tag_action})
  )

  for i = 1, 9 do
      keys = awful.util.table.join(keys,
  
          -- View tag only.
          awful.key({super}, "#" .. i + 9, view_tag(i),
                    {description = "切換至標籤 #"..i, group = key_group_tag_browser}),
          awful.key({super, ctrl}, "#" .. i + 9, toggle_tag(i),
                    {description = "Toggle 標籤 #" .. i, group = key_group_tag_browser}),
  
          -- Move client to tag.
          awful.key({super, shift}, "#" .. i + 9, move_window_to_tag(i),
                    {description = "移動視窗至 #"..i, group = key_group_tag_action}),
          awful.key({super, ctrl, shift }, "#" .. i + 9, toggle_window_tag(i),
                    {description = "Toggle 視窗標籤 #" .. i, group = key_group_tag_action})
      )
  end

  return keys
end


keybindings.super   = super
keybindings.alt     = alt
keybindings.ctrl    = ctrl
keybindings.shift   = shift
keybindings.clientkeys = awful.util.table.join(
  awful.key({ctrl, super}, "f", toggle_floating(c),
            {description = "切換視窗是否浮動", group = key_group_window_action}),
  awful.key({ctrl, super}, "m", maximize_window,
            {description = "切換視窗是否最大化", group = key_group_window_action}),
  awful.key({ctrl, super}, "o", function (c) c:move_to_screen() end,
            {description = "將視窗移至另一個螢幕", group = key_group_window_action}),
  awful.key({ctrl, super}, "w", function (c) c:kill() end,
            {description = "關閉視窗", group = key_group_window_action}),
  awful.key({alt}, "F4", function (c) c:kill() end,
            {description = "關閉視窗", group = key_group_window_action}),
  awful.key({ctrl, super}, "Return", function (c) c:swap(awful.client.getmaster()) end,
            {description = "將現在的視窗與主視窗交換位置", group = key_group_window_action})
)

root.keys(awful.util.table.join(define_global_keys()))

return keybindings
