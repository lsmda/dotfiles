return {
	"nvim-treesitter/nvim-treesitter",
	commit = "64b3d5e5698d485a4f197ffbe85a4b6c29e16325",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local config = require("nvim-treesitter.configs")

		config.setup({
			auto_install = true,
			ensure_installed = { "lua" },
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-Space>",
					node_incremental = "<C-Space>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
