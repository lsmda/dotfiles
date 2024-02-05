return {
	"folke/todo-comments.nvim",
	commit = "9935ae96190c4c177cf0a0dfaddbe4a8addf3eed",
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" },
	},
	init = function()
		require("core.utils").load_mappings("todo_comments")
	end,
	config = function()
		require("todo-comments").setup()
	end,
}
