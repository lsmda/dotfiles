return {
	"nvim-lualine/lualine.nvim",
	commit = "566b7036f717f3d676362742630518a47f132fff",
	config = function()
		local icons = require("core.utils").icons

		local diff = {
			"diff",
			colored = true,
			symbols = {
				added = icons.git.LineAdded,
				modified = icons.git.LineModified,
				removed = icons.git.LineRemoved,
			},
		}

		require("lualine").setup({
			options = {
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				ignore_focus = { "NvimTree" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", path = 1 } },
				lualine_c = { diff },
				lualine_x = { "diagnostics" },
				lualine_y = { "progress" },
				lualine_z = { "filetype" },
			},
			extensions = { "quickfix", "man", "fugitive" },
		})
	end,
}
