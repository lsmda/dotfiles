return {
	"rose-pine/neovim",
	name = "rose-pine",
	commit = "14b371fb783a8cfdade04544fb782f0bb6f7c904",
	priority = 1001,
	config = function()
		require("rose-pine").setup({
			variant = "moon", -- auto, main, moon, or dawn
			dark_variant = "moon", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},

			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
		})

		vim.cmd.colorscheme("rose-pine")
	end,
}
