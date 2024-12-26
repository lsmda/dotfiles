------------------------------------------------------------------------------
------ source: https://github.com/garado/cozy/blob/main/utils/binds.lua ------
------------------------------------------------------------------------------

local M = {}

--- @function split
-- @brief Split text input on a given delimiter.
-- @param txt  A string to delimit.
-- @param delim Delimiting character(s)
-- @param keepEmpty True if empty tokens should be kept (stored
--                  in return array as "")
-- @return A table containing the split tokens.
function M.split(txt, delim, keepEmpty)
  delim = delim or "%s" -- default all whitespace
  keepEmpty = keepEmpty or false

  local match
  if keepEmpty then
    txt = txt .. delim
    match = "([^" .. delim .. "]*)" .. delim
  else
    match = "([^" .. delim .. "]+)"
  end

  local ret = {}
  for str in txt:gmatch(match) do
    ret[#ret + 1] = str
  end

  return ret
end

return M
