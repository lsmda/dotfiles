pcall(require, "luarocks.loader")

-- standard awesome library
local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"

-- theme handling library
local beautiful = require "beautiful"

-- enable hotkeys help widget for vim and other apps
-- when client with a matching name is opened:
require "awful.hotkeys_popup.keys"

beautiful.init(gears.filesystem.get_configuration_dir() .. "config/theme.lua")

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
}

require "config.notifications"
require "config.tags"

root.keys(require("config.keys").global)

require "config.bar"

require "config.collect"
require "config.signals"
require "config.startup"

gears.wallpaper.maximized("/etc/nixos/assets/00.jpg", s, true)
