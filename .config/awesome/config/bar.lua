local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local dpi = require("utils.ui").dpi
local system = require("config.globals").system
local keys = require "config.keys"
local tasklist = require "ui.tasklist"

local system_clock = wibox.widget.textclock "%d-%m-%Y %H:%M"
system_clock.font = system.font_family .. " " .. dpi(7)

-- dynamically generates a list of tags based on the
-- `system.tags` global. passed to wibox widget after.
local tags_list = {}

for i = 1, system.tags do
  tags_list[i] = tostring(i)
end

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  awful.tag(tags_list, s, awful.layout.layouts[1])

  -- create an imagebox widget which will contain an icon indicating which layout we're using.
  -- we need one layoutbox per screen.
  s.layout_box = awful.widget.layoutbox(s)
  s.layout_box:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  s.taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    widget_template = {
      {
        id = "text_role",
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
      },
      forced_width = dpi(24),
      forced_height = dpi(24),
      widget = wibox.container.background,
    },
  }

  s.tasklist = tasklist(s)

  s.wibox = awful.wibar {
    position = "top",
    screen = s,
    bg = "#00000000",
  }

  s.wibox:setup {
    layout = wibox.layout.align.horizontal,

    { -- left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.margin(s.taglist, dpi(10), dpi(10), dpi(5), dpi(5)),
    },

    { -- middle widget
      s.tasklist,
      left = dpi(10),
      right = dpi(10),
      widget = wibox.container.margin,
    },

    { -- right widgets
      layout = wibox.layout.fixed.horizontal,
      {
        {
          wibox.widget.systray(),
          halign = "center",
          valign = "center",
          widget = wibox.container.place,
        },
        forced_width = dpi(20),
        forced_height = dpi(20),
        widget = wibox.container.constraint,
      },
      wibox.container.margin(system_clock, dpi(5), dpi(10)),
      s.layout_box,
    },
  }
end)

awful.rules.rules = {
  -- all clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.client,
      -- buttons = {},
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- firefox addon downthemall.
        "copyq", -- includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin", -- kalarm.
        "Sxiv",
        "Tor Browser", -- needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },

      -- note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- thunderbird's calendar.
        "ConfigManager", -- thunderbird's about:config.
        "pop-up", -- e.g. google chrome's (detached) developer tools.
      },
    },
    properties = { floating = false },
  },
}
