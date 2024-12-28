local awful = require "awful"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"

local apps = require("config.globals").apps
local set_keybind = require("utils.binds").set_keybind
local exec = require("utils.cmd").exec

------ mouse keybinds ------

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

------ client keybinds ------

local client_keybinds = {
  {
    "super+q",
    function(c)
      c:kill()
    end,
    { description = "Close client", group = "layout" },
  },

  {
    "ctrl+alt+l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    { description = "Increase master width factor", group = "layout" },
  },

  {
    "ctrl+alt+h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    { description = "Decrease master width factor", group = "layout" },
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

------ global keybinds ------

local global_keybinds = {

  {
    "super+space",
    function()
      awful.layout.inc(1)
    end,
    { description = "Next layout", group = "awesome" },
  },

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

  -- vim-like window navigation --

  {
    "super+h",
    function()
      awful.client.focus.bydirection "left"
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "Focus left", group = "client" },
  },

  {
    "super+j",
    function()
      awful.client.focus.bydirection "down"
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "Focus down", group = "client" },
  },

  {
    "super+k",
    function()
      awful.client.focus.bydirection "up"
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "Focus up", group = "client" },
  },

  {
    "super+l",
    function()
      awful.client.focus.bydirection "right"
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "Focus right", group = "client" },
  },

  -- sound controls --

  {
    "XF86AudioRaiseVolume",
    function()
      awful.spawn("amixer -D pulse sset Master 5%+", false)
      awesome.emit_signal "widget::volume"
      awesome.emit_signal("module::volume_osd:show", true)
    end,
    { description = "Increase volume by 5%", group = "hotkeys" },
  },

  {
    "XF86AudioLowerVolume",
    function()
      awful.spawn("amixer -D pulse sset Master 5%-", false)
      awesome.emit_signal "widget::volume"
      awesome.emit_signal("module::volume_osd:show", true)
    end,
    { description = "Decrease volume by 5%", group = "hotkeys" },
  },

  {
    "XF86AudioMute",
    function()
      awful.spawn("amixer -D pulse set Master 1+ toggle", false)
    end,
    { description = "Toggle mute", group = "hotkeys" },
  },

  {
    "XF86AudioNext",
    function()
      awful.spawn("mpc next", false)
    end,
    { description = "Next track", group = "hotkeys" },
  },

  {
    "XF86AudioPrev",
    function()
      awful.spawn("mpc prev", false)
    end,
    { description = "Previous track", group = "hotkeys" },
  },

  {
    "XF86AudioPlay",
    function()
      awful.spawn("mpc toggle", false)
    end,
    { description = "Play/Pause", group = "hotkeys" },
  },

  {
    "XF86AudioMicMute",
    function()
      awful.spawn("amixer set Capture toggle", false)
    end,
    { description = "Mute microphone", group = "hotkeys" },
  },

  {
    "super+shift+h",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" },
  },

  {
    "super+shift+l",
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

  -- vim-like window movement

  {
    "shift+h",
    function()
      awful.client.swap.bydirection "left"
    end,
    { description = "Move window left", group = "client" },
  },

  {
    "shift+j",
    function()
      awful.client.swap.bydirection "down"
    end,
    { description = "Move window down", group = "client" },
  },

  {
    "shift+k",
    function()
      awful.client.swap.bydirection "up"
    end,
    { description = "Move window up", group = "client" },
  },

  {
    "shift+l",
    function()
      awful.client.swap.bydirection "right"
    end,
    { description = "Move window right", group = "client" },
  },

  {
    "super+shift+space",
    function()
      awful.layout.inc(1)
    end,
    { description = "Select next layout", group = "layout" },
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

------ setup keybinds ------

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
