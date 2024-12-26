---@diagnostic disable: undefined-global

local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

local keys = require "sysconf.keys"

root.keys(keys.global)

-- bind all key numbers to tags.
-- be careful: we use keycodes to make it work on any keyboard layout.
-- this should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  keys.global = gears.table.join(
    keys.global,
    -- View tag only.
    awful.key({ super }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ super, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ super, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ super, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

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
