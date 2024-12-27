local awful = require "awful"
local wibox = require "wibox"

-- utility imports
local dpi = require("utils.ui").dpi
local system = require("config.globals").system

-- custom widgets
local keyboard_layout = awful.widget.keyboardlayout()
keyboard_layout.widget.font = system.font_family .. " " .. dpi(7)

local battery_widget = wibox.widget {
  font = system.font_family .. " " .. dpi(7),
  widget = wibox.widget.textbox,
}

local system_clock = wibox.widget.textclock "%d-%m-%Y %H:%M"
system_clock.font = system.font_family .. " " .. dpi(7)

-- update the battery widget every 60 seconds
awful.widget.watch("sh -c 'cat /sys/class/power_supply/BAT1/capacity'", 60, function(widget, stdout)
  local percent = tonumber(stdout)
  if percent then
    widget:set_text("battery:" .. percent .. "%")
  else
    widget:set_text "battery:N/A"
  end
end, battery_widget)

-- dynamically generates a list of tags based on the
-- `system.tags` global. passed to wibox widget after.
local tags_list = {}

for i = 1, system.tags do
  tags_list[i] = tostring(i)
end

awful.screen.connect_for_each_screen(function(s)
  awful.tag(tags_list, s, awful.layout.layouts[1])

  -- create a taglist widget
  s.taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
  }

  -- create a tasklist widget
  s.tasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
  }

  -- create the wibox
  s.wibox = awful.wibar { position = "top", screen = s }

  -- add widgets to the wibox
  s.wibox:setup {
    layout = wibox.layout.align.horizontal,

    { -- left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.margin(s.taglist, 5, 5),
    },

    { -- middle widget
      layout = wibox.layout.fixed.horizontal,
      wibox.container.constraint(wibox.container.constraint(s.tasklist, "min", 500), "max", 500),
    },

    { -- right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.margin(keyboard_layout),
      wibox.container.margin(battery_widget, 5, 5),
      wibox.container.margin(wibox.widget.systray(), 5, 5),
      wibox.container.margin(system_clock, 5, 10),
    },
  }
end)
