-- n, v, i, t = mode names

local utils = require("core.utils")
local confirm_quit = utils.confirm_quit

local M = {}

M.general = {
	n = {
		["<CR>"] = { "o<Esc>", "Add line below cursor" },
		["<C-a>"] = { "ggVG", "Select all" },

		["<M-h>"] = { "<C-o>", "Navigate to previous cursor position" },
		["<M-l>"] = { "<C-i>", "Navigate to next cursor position" },

		["<C-d>"] = { "<C-d>zz", "Scroll down" },
		["<C-u>"] = { "<C-u>zz", "Scroll up" },

		["<M-k>"] = { ":m .-2<CR>==", "Move line up" },
		["<M-j>"] = { ":m .+1<CR>==", "Move line down" },

		["<C-s>"] = {
			function()
				require("conform").format()
				vim.cmd("wa")
			end,
			"Format current buffer and write all open buffers",
		},

		["<leader>s"] = {
			function()
				confirm_quit("wqa", nil, true)
			end,
			"Write all open buffers then exit neovim",
		},

		["<leader>q"] = {
			function()
				confirm_quit("qa!", "Are you sure you want to quit? Unsaved changes will be lost (y/N): ")
			end,
			"Ignore all open buffers then prompt user to exit neovim",
		},

		["<leader>cs"] = {
			function()
				vim.fn.setreg("/", "")
			end,
			"Clear search pattern",
		},
	},

	i = {
		-- Navigate within insert mode
		["<C-h>"] = { "<Left>", "Navigate left in insert mode" },
		["<C-l>"] = { "<Right>", "Navigate right in insert mode" },
		["<C-j>"] = { "<Down>", "Navigate down in insert mode" },
		["<C-k>"] = { "<Up>", "Navigate up in insert mode" },

		-- Close character pair and move cursor inside
		["'"] = { "''<left>" },
		['"'] = { '""<left>' },
		["("] = { "()<left>" },
		["["] = { "[]<left>" },
		["{"] = { "{}<left>" },
	},

	v = {
		-- Enclose visual selection with character pair
		["'"] = { "c''<Esc>P" },
		['"'] = { 'c""<Esc>P' },
		["("] = { "c()<Esc>P" },
		["["] = { "c[]<Esc>P" },
		["{"] = { "c{}<Esc>P" },

		["<M-k>"] = { ":m '<-2<CR>gv=gv", "Move visual selection up" },
		["<M-j>"] = { ":m '>+1<CR>gv=gv", "Move visual selection down" },
	},

	[{ "i", "v" }] = {
		["<M-n>"] = { "<Esc>", "Enter normal mode" },
	},

	[{ "n", "v" }] = {
		["<M-e>"] = { "$", "End of line" },
		["<M-q>"] = { "^", "Beginning of line" },

		-- Pane navigation
		["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Tmux navigate left command" },
		["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Tmux navigate right command" },
		["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Tmux navigate down command" },
		["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Tmux navigate up command" },
	},
}

M.lazygit = {
	plugin = true,

	n = {
		["<leader>gg"] = { "<cmd>LazyGit<CR>", "Open LazyGit window" },
	},
}

M.typescript_tools = {
	plugin = true,

	n = {
		["<leader>m"] = { "<cmd>TSToolsOrganizeImports<CR>", "Organize imports" },
		["<leader>a"] = { "<cmd>TSToolsAddMissingImports<CR>", "Add missing imports" },
	},
}

M.alternate_toggler = {
	plugin = true,

	n = {
		["<leader>tt"] = { "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>", "Toggle value" },
	},
}

M.todo_comments = {
	plugin = true,

	n = {
		["<leader>ft"] = { "<CMD>TodoTelescope<CR>", "Find todos" },
	},
}

return M
