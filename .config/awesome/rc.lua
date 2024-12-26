---@diagnostic disable: undefined-global

pcall(require, "luarocks.loader")

-- standard awesome library
local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"

-- widget and layout library
local wibox = require "wibox"

-- theme handling library
local beautiful = require "beautiful"

-- notification library
local naughty = require "naughty"
local menubar = require "menubar"
require "awful.hotkeys_popup.keys"

-- check if awesome encountered an error during startup and fell back to
-- another config (this code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify {
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  }
end

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

-- themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- this is used later as the default terminal and editor to run.
local terminal = "kitty"

awful.layout.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.fair,
}

menubar.utils.terminal = terminal -- set the terminal for applications that require it

local keyboard_layout = awful.widget.keyboardlayout()
local system_clock = wibox.widget.textclock()

local function set_wallpaper(s)
  -- wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- if wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

require "sysconf"

local tags = {}

for i = 1, NUMBER_OF_TAGS do
  tags[i] = tostring(i)
end

awful.screen.connect_for_each_screen(function(s)
  -- wallpaper
  set_wallpaper(s)

  -- each screen has its own tag table.
  awful.tag(tags, s, awful.layout.layouts[1])

  -- create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- create an imagebox widget which will contain an icon indicating which layout we're using.
  -- we need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)

  -- create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  -- create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }

  -- create the wibox
  s.mywibox = awful.wibar { position = "top", screen = s }

  -- add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- middle widget
    { -- right widgets
      layout = wibox.layout.fixed.horizontal,
      keyboard_layout,
      wibox.widget.systray(),
      system_clock,
      s.mylayoutbox,
    },
  }
end)

-- signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

beautiful.useless_gap = 5
