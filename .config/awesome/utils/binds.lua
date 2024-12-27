------------------------------------------------------------------------------
------ source: https://github.com/garado/cozy/blob/main/utils/binds.lua ------
------------------------------------------------------------------------------

local awful = require "awful"

local strutil = require "utils.string"
local kbd = require("config.globals").kbd

local M = {}

--- @method parsekeys
-- @param keystr
-- @return mods
-- @return key
local function parsekeys(keystr)
  local m = {} -- mods
  local k = "" -- key

  local tokens = strutil.split(keystr, "+")

  for _, key in ipairs(tokens) do
    if kbd[key] then
      m[#m + 1] = kbd[key] -- modifier
    else
      k = k .. key -- normal key
    end
  end

  return m, k
end

M.set_keybind = function(keystr, func, data)
  keystr = keystr or ""
  func = func or nil
  data = data or {}

  local m, k = parsekeys(keystr)

  local g = data["group"] or nil
  local d = data["description"] or nil

  return awful.key(m, k, func, { description = d, group = g })
end

M.set_tag_keybind = function(index)
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

return M
