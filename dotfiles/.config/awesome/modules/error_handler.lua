local error_handler = {}

local naughty  = require("naughty")
local awful    = require("awful")

function send_notification(opts)
  local command = string.format('notify-send "%s" "%s"', opts.title, opts.text)
  awful.util.spawn_with_shell(command)
end

naughty.config.notify_callback = send_notification

if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors 
  })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end

return error_handler
