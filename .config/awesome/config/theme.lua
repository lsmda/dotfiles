local config_path = require("config.globals").system.config_path
local dpi = require("utils.ui").dpi

local system = require("config.globals").system

local theme = {}

theme.font = system.font_family .. " " .. dpi(7.5)

theme.bg_normal = "#22222200"
theme.bg_focus = "#535d6c80"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(4)
theme.border_width = dpi(5)
theme.border_normal = "#000000"
theme.border_focus = "#aaaaaa"
theme.border_marked = "#91231c"

theme.layout_max = config_path .. "icons/layouts/max.svg"
theme.layout_tile = config_path .. "icons/layouts/tile.svg"

theme.icon_theme = nil

return theme
