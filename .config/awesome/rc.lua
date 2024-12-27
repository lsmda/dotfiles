---@diagnostic disable: undefined-global, param-type-mismatch, lowercase-global

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

number_of_tags = 5

apps = {
  terminal = "kitty",
  launcher = "rofi -modes combi -show combi -combi-modes run,drun -combi-display-format {text}",
  files = "nautilus",
}

awful.layout.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.fair,
}

-- system configuration

require "sysconf.tags"
require "sysconf.rules"
require "sysconf.wibox"

beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/default.lua")

-- List of apps to run on start-up
local run_on_start_up = {
  "picom --experimental-backends",
  "redshift",
}

-- Run all the apps listed in run_on_start_up
for _, app in ipairs(run_on_start_up) do
  local findme = app
  local firstspace = app:find " "
  if firstspace then
    findme = app:sub(0, firstspace - 1)
  end
  -- pipe commands to bash to allow command to be shell agnostic
  awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end

-- signal function to execute when a new client appears

client.connect_signal("manage", function(c)
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- garbage collection (lower memory consumption)

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
