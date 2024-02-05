local global_opts = {
	-- Set <Space> as the leader key
	mapleader = " ",
	maplocalleader = " ",

	-- Disable netrw for nvim-tree
	loaded_netrw = 1,
	loaded_netrwPlugin = 1,
}

for key, value in pairs(global_opts) do
	vim.g[key] = value
end

local options = {
	number = true,
	relativenumber = true,
	numberwidth = 4,

	splitbelow = true,
	splitright = true,

	hlsearch = false,
	incsearch = true,

	wrap = false,
	fileencoding = "utf-8",

	clipboard = "unnamedplus",
	scrolloff = 999,

	expandtab = true,
	tabstop = 2,
	shiftwidth = 2,
	softtabstop = 2,
	autoindent = true,

	ignorecase = true,
	smartcase = true,

	hidden = true,
	showmode = false,
	signcolumn = "yes",

	backup = false,
	swapfile = false,

	cursorline = true,
	mouse = "",
	termguicolors = true,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
