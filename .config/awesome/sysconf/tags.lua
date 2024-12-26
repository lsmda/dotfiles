local awful = require "awful"
local gears = require "gears"

local keys = require "sysconf.keys"
local bind = require "utils.bind"

local set_keybind = bind.set_keybind

local get_tag_keybinds = function(index)
  return {
    {
      "super+" .. "#" .. index + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          tag:view_only()
        end
      end,
      { description = "View tag #" .. index, group = "tag" },
    },
  }
end

-- extend global keys with tag keybinds
for i = 1, NUMBER_OF_TAGS do
  local tag_keybinds = get_tag_keybinds(i) -- `i` represents a tag number
  for _, config in ipairs(tag_keybinds) do
    keys.global = gears.table.join(keys.global, set_keybind(table.unpack(config)))
  end
end
