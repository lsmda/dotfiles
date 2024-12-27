local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"

-- widget and layout library
local wibox = require "wibox"

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

local tags = {}

for i = 1, number_of_tags do
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
  }

  -- create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
  }

  -- create the wibox
  s.mywibox = awful.wibar { position = "top", screen = s }

  -- add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,

    { -- left widgets
      layout = wibox.layout.fixed.horizontal,
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
