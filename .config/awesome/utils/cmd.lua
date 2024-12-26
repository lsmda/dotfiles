local awful = require "awful"

local M = {}

M.exec = function(cmd)
  return function()
    awful.spawn(cmd)
  end
end

M.exec_with_shell = function(cmd)
  return function()
    awful.spawn.with_shell(cmd)
  end
end

return M
