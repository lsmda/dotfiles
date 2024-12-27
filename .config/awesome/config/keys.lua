local awful = require "awful"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"

local apps = require("config.globals").apps
local exec = require("utils.cmd").exec
local set_keybind = require("utils.binds").set_keybind

----------------------------
------ mouse keybinds ------
----------------------------

local mouse_keybinds = {
  {
    "1",
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
    end,
  },

  {
    "super+1",
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(c)
    end,
  },

  {
    "super+3",
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(c)
    end,
  },

  {
    "3",
    function()
      mymainmenu:toggle()
    end,
  },

  {
    "4",
    awful.tag.viewnext,
  },

  {
    "5",
    awful.tag.viewprev,
  },
}

-----------------------------
------ client keybinds ------
-----------------------------

local client_keybinds = {
  {
    "super+q",
    function(c)
      c:kill()
    end,
    { description = "Close client", group = "client" },
  },

  {
    "super+t",
    function(c)
      c.ontop = not c.ontop
    end,
    { description = "Toggle keep on top", group = "client" },
  },

  {
    "super+n",
    function(c)
      c.minimized = true
    end,
    { description = "Minimize client", group = "client" },
  },

  {
    "super+m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(Un)Maximize client", group = "client" },
  },

  {
    "super+ctrl+m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(Un)Maximize client vertically", group = "client" },
  },

  {
    "super+shift+m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(Un)Maximize client horizontally", group = "client" },
  },

  {
    "super+f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "Toggle fullscreen", group = "client" },
  },
}

-----------------------------
------ global keybinds ------
-----------------------------

local global_keybinds = {
  {
    "super+r",
    exec(apps.launcher),
    { description = "Execute rofi", group = "launcher" },
  },

  {
    "super+s",
    hotkeys_popup.show_help,
    { description = "show help", group = "awesome" },
  },

  {
    "super+h",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" },
  },

  {
    "super+l",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" },
  },

  {
    "super+Return",
    exec(apps.terminal),
    { description = "open a terminal", group = "launcher" },
  },

  {
    "super+ctrl+h",
    function()
      awful.tag.incmwfact(0.05)
    end,
    { description = "increase master width factor", group = "layout" },
  },

  {
    "super+ctrl+l",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    { description = "decrease master width factor", group = "layout" },
  },

  {
    "super+shift+r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" },
  },

  {
    "super+alt+l",
    function()
      awful.client.swap.byidx(1)
    end,
    { description = "swap with next client by index", group = "client" },
  },

  {
    "super+alt+h",
    function()
      awful.client.swap.byidx(-1)
    end,
    { description = "swap with previous client by index", group = "client" },
  },

  {
    "super+shift+q",
    awesome.quit,
    { description = "quit awesome", group = "awesome" },
  },

  {
    "super+shift+h",
    awful.tag.viewprev,
    { description = "view previous", group = "tag" },
  },

  {
    "super+shift+l",
    awful.tag.viewnext,
    { description = "view next", group = "tag" },
  },

  {
    "super+shift+h",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = "increase the number of master clients", group = "layout" },
  },

  {
    "super+shift+l",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = "decrease the number of master clients", group = "layout" },
  },

  {
    "super+shift+space",
    function()
      awful.layout.inc(-1)
    end,
    { description = "select previous", group = "layout" },
  },

  {
    "super+ctrl+n",
    function()
      local c = awful.client.restore()
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end,
    { description = "restore minimized", group = "client" },
  },
}

----------------------------
------ setup keybinds ------
----------------------------

local M = {}

M.client, M.global, M.mouse = {}, {}, {}

for _, config in ipairs(mouse_keybinds) do
  M.mouse = gears.table.join(M.mouse, set_keybind(table.unpack(config)))
end

for _, config in ipairs(client_keybinds) do
  M.client = gears.table.join(M.client, set_keybind(table.unpack(config)))
end

for _, config in ipairs(global_keybinds) do
  M.global = gears.table.join(M.global, set_keybind(table.unpack(config)))
end

return M
