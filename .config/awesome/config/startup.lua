local awful = require "awful"

-- list of apps to run on start-up
local run_on_start_up = {
  "picom --experimental-backends",
  -- "redshift",
}

-- run all the apps listed in run_on_start_up
for _, app in ipairs(run_on_start_up) do
  local findme = app
  local firstspace = app:find " "
  if firstspace then
    findme = app:sub(0, firstspace - 1)
  end
  -- pipe commands to bash to allow command to be shell agnostic
  awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end
