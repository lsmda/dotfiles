local awful = require "awful"
local wibox = require "wibox"

return function(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = {
      spacing = 0,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          id = "clienticon",
          widget = awful.widget.clienticon,
        },
        margins = 10,
        halign = "center",
        valign = "center",
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c)
        self:get_children_by_id("clienticon")[1].client = c
      end,
    },
  }
end
