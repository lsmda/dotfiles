pcall(require, "luarocks.loader")

-- standard awesome library
local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"

-- theme handling library
local beautiful = require "beautiful"

-- notification library
local naughty = require "naughty"
require "awful.hotkeys_popup.keys"

-- handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    }
    in_error = false
  end)
end

awful.layout.layouts = {
  awful.layout.suit.fair,
}

-- system configuration

require "config.tags"
require "config.rules"
require "config.wibox"
require "config.startup"

beautiful.init(gears.filesystem.get_configuration_dir() .. "config/theme.lua")

gears.wallpaper.maximized("/etc/nixos/assets/00.jpg", s, true)

-- signal function to execute when a new client appears
client.connect_signal("manage", function(c)
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- enable garbage collection
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

gears.timer {
  timeout = 300, -- run every 5 minutes
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage "collect"
  end,
}
