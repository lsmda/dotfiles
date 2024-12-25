local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

local alt = "Mod1"
local shift = "Shift"
local super = "Mod4"
local ctrl = "Control"

local function exec(cmd)
	return function()
		awful.spawn(cmd)
	end
end

local function exec_with_shell(cmd)
	return function()
		awful.spawn.with_shell(cmd)
	end
end

local terminal = "kitty"

local global_keys = {
	{
		{ super },
		"r",
		exec({
			"rofi",
			"-modes",
			"combi",
			"-show",
			"combi",
			"-combi-modes",
			"run,drun",
			"-combi-display-format",
			"{text}",
		}),
	},

	{
		{ super },
		"s",
		hotkeys_popup.show_help,
		{ description = "show help", group = "awesome" },
	},

	{
		{ super },
		"l",
		function()
			awful.client.focus.byidx(1)
		end,
		{ description = "focus next by index", group = "client" },
	},

	{
		{ super },
		"h",
		function()
			awful.client.focus.byidx(-1)
		end,
		{ description = "focus previous by index", group = "client" },
	},

	{
		{ super },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" },
	},

	{
		{ super },
		"Return",
		function()
			awful.spawn(terminal)
		end,
		{ description = "open a terminal", group = "launcher" },
	},

	{
		{ super, ctrl },
		"l",
		function()
			awful.tag.incmwfact(0.05)
		end,
		{ description = "increase master width factor", group = "layout" },
	},

	{
		{ super, ctrl },
		"h",
		function()
			awful.tag.incmwfact(-0.05)
		end,
		{ description = "decrease master width factor", group = "layout" },
	},

	{
		{ super, shift },
		"r",
		awesome.restart,
		{ description = "reload awesome", group = "awesome" },
	},

	{
		{ super, alt },
		"l",
		function()
			awful.client.swap.byidx(1)
		end,
		{ description = "swap with next client by index", group = "client" },
	},

	{
		{ super, alt },
		"h",
		function()
			awful.client.swap.byidx(-1)
		end,
		{ description = "swap with previous client by index", group = "client" },
	},

	{
		{ super, shift },
		"q",
		awesome.quit,
		{ description = "quit awesome", group = "awesome" },
	},

	{
		{ super, shift },
		"h",
		awful.tag.viewprev,
		{ description = "view previous", group = "tag" },
	},

	{
		{ super, shift },
		"l",
		awful.tag.viewnext,
		{ description = "view next", group = "tag" },
	},

	{
		{ super, shift },
		"h",
		function()
			awful.tag.incnmaster(1, nil, true)
		end,
		{ description = "increase the number of master clients", group = "layout" },
	},

	{
		{ super, shift },
		"l",
		function()
			awful.tag.incnmaster(-1, nil, true)
		end,
		{ description = "decrease the number of master clients", group = "layout" },
	},

	{
		{ super, shift },
		"space",
		function()
			awful.layout.inc(-1)
		end,
		{ description = "select previous", group = "layout" },
	},

	{
		{ super, ctrl },
		"n",
		function()
			local c = awful.client.restore()
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end,
		{ description = "restore minimized", group = "client" },
	},
}

local keys = { client = {}, global = {} }

for _, config in ipairs(global_keys) do
	keys.global = gears.table.join(keys.global, awful.key(config[1], config[2], config[3], config[4]))
end

return keys
