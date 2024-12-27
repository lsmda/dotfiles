local gears = require "gears"

local bind = require "utils.binds"
local keys = require "sysconf.keys"

local set_keybind = bind.set_keybind
local set_tag_keybind = bind.set_tag_keybind

-- extend global keys with tag keybinds
for i = 1, number_of_tags do
  local tag_keybinds = set_tag_keybind(i) -- `i` represents a tag number
  for _, config in ipairs(tag_keybinds) do
    keys.global = gears.table.join(keys.global, set_keybind(table.unpack(config)))
  end
end
