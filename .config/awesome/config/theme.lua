local dpi = require("utils.ui").dpi
local system = require("config.globals").system

local theme = {}

-- font
theme.font = system.font_family

-- background
theme.bg_normal = "#000000"
theme.bg_dark = "#000000"
theme.bg_focus = "#444444"
theme.bg_urgent = "#ed8274"
theme.bg_minimize = "#000000"

-- foreground
theme.fg_normal = "#ffffff"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- window gap distance
theme.useless_gap = dpi(6)

-- window borders
theme.border_width = dpi(5)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.bg_urgent
theme.border_marked = theme.fg_urgent

-- taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = "#ffffff1a"
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_focus

-- tasklist
-- theme.tasklist_font = theme.font
-- theme.tasklist_bg_normal = theme.bg_normal
-- theme.tasklist_bg_focus = theme.bg_focus
-- theme.tasklist_bg_urgent = theme.bg_urgent
-- theme.tasklist_fg_focus = theme.fg_focus
-- theme.tasklist_fg_urgent = theme.fg_urgent
-- theme.tasklist_fg_normal = theme.fg_normal

-- notification sizing
theme.notification_max_width = dpi(300)

-- system tray
theme.bg_systray = theme.bg_normal
-- theme.systray_icon_spacing = dpi(5)

theme.titlebars_enabled = false
-- show gaps if only one client is visible
theme.gap_single_client = true

theme.icon_theme = "Tela-grey-dark"

return theme
