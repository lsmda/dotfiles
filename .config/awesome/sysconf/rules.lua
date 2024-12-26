---@diagnostic disable: undefined-global

local awful = require "awful"
local beautiful = require "beautiful"

local keys = require "sysconf.keys"

root.keys(keys.global)

awful.rules.rules = {
  -- rules applied to every window
  {
    id = "global",
    rule = {},
    properties = {
      border_width = beautiful.border_width * 2,
      border_color = beautiful.border_normal,
      raise = true,
      keys = keys.client,
      size_hints_honor = true,
      honor_workarea = true,
      honor_padding = true,
      screen = awful.screen.focused,
      focus = awful.client.focus.filter,
      titlebars_enabled = false,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- set certain applications as floating
  {
    id = "floating",
    rule_any = {
      instance = {
        "Thunar",
        "feh",
        "simplescreenrecorder",
        "mpv",
      },
      class = {
        "Pavucontrol",
        "Lxappearance",
        "Nm-connection-editor",
        "qBittorrent",
        "mpv",
        "gnuplot_qt",
        "zoom",
      },
      role = {
        "GtkFileChooserDialog",
        "conversation",
      },
      type = {
        "dialog",
      },
    },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    },
  },

  -- force window height for certain applications
  {
    rule_any = {
      instance = {
        "Thunar",
      },
      class = {
        "Pavucontrol",
      },
    },
    properties = {
      height = 700,
    },
  },

  {
    rule_any = {
      instance = { "Xephyr" },
      class = { "Xephyr" },
    },
    properties = {
      placement = awful.placement.top_right,
    },
  },
}
