local gears = require "gears"

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

gears.timer {
  timeout = 300, -- run every 5 minutes
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage "collect"
  end,
}
