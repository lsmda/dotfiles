local M = {}

M.apps = {
  files = "nautilus",
  launcher = "rofi -modes combi -show combi -combi-modes run,drun -combi-display-format {text}",
  terminal = "kitty",
}

M.kbd = {
  -- keyboard modkeys
  alt = "Mod1",
  super = "Mod4",
  ctrl = "Control",
  shift = "Shift",

  -- mouse buttons
  leftclick = 1,
  midclick = 2,
  rightclick = 3,
  scrolldown = 4,
  scrollup = 5,
  sidedownclick = 8,
  sideupclick = 9,
}

M.system = {
  font_family = "JetBrainsMono Nerd Font",
  tags = 5,
}

return M
