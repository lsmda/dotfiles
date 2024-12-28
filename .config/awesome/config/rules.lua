local awful = require "awful"
local beautiful = require "awful"

local keys = require "config.keys"

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
