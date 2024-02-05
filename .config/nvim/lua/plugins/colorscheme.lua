return {
	"catppuccin/nvim",
	name = "catppuccin",
	commit = "5e36ca599f4aa41bdd87fbf2c5aae4397ac55074",
	priority = 1001,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = true,
				lsp_saga = true,
				mason = false,
				mini = {
					enabled = true,
					indentscope_color = "surface2",
				},
				telescope = { enabled = true },
				native_lsp = { enabled = true },
			},
			custom_highlights = function(colors)
				return {
					Comment = { fg = colors.overlay0 },
					GitSignsCurrentLineBlame = { fg = colors.overlay1 },
					LineNr = { fg = colors.lavender },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
