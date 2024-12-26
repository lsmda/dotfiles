------------------------------------------------------------------------------
------ source: https://github.com/garado/cozy/blob/main/utils/binds.lua ------
------------------------------------------------------------------------------

local awful = require "awful"

local strutil = require "utils.string"

local M = {}

local mods = {
  alt = "Mod1",
  shift = "Shift",
  super = "Mod4",
  ctrl = "Control",
}

--- @method parsekeys
-- @param keystr
-- @return mods
-- @return key
local function parsekeys(keystr)
  local m = {} -- mods
  local k = "" -- key

  local tokens = strutil.split(keystr, "+")

  for _, key in ipairs(tokens) do
    if mods[key] then
      m[#m + 1] = mods[key] -- modifier
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

return M
