return {
	"echasnovski/mini.nvim",
	commit = "b5645ac6eefce8e7af9d7dd4e5e296a81cba8a10",
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.cursorword").setup({
			delay = 351,
		})
		require("mini.indentscope").setup()
		require("mini.pairs").setup()
		require("mini.splitjoin").setup({
			mappings = {
				toggle = "<leader>j",
				split = "",
				join = "",
			},
		})
	end,
}
