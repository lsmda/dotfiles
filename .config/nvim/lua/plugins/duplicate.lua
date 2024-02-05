return {
	{
		"hinell/duplicate.nvim",
		commit = "ab057af7872c44e6fbd48df9b03983c8e67c50a7",
		dependencies = {
			{
				"mrjones2014/legendary.nvim",
				commit = "05af6881168266d8120cb7c2d6837c13a7df7527",
				priority = 10000,
				lazy = false,
			},
		},
		config = function()
			local legendary = require("legendary")
			legendary.keymaps({
				{ description = "line: duplicate up", mode = { "n" }, "<S-M-k>", "<cmd>t .-1<cr>==" },
				{ description = "Line: duplicate down", mode = { "n" }, "<S-M-j>", "<cmd>t .<CR>==" },
				{ description = "Selection: duplicate up", mode = { "v" }, "<S-M-j>", "<cmd>VisualDuplicate +1<CR>" },
				{ description = "Selection: duplicate down", mode = { "v" }, "<S-M-k>", "<cmd>VisualDuplicate -1<cr>" },
			})
		end,
	},
}
