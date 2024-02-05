return {
	"nvimdev/lspsaga.nvim",
	commit = "2198c07124bef27ef81335be511c8abfd75db933",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", commit = "64b3d5e5698d485a4f197ffbe85a4b6c29e16325" },
		{ "nvim-tree/nvim-web-devicons", commit = "a55b801b7ef5719ca25692c3a0a5447fdfb692ed" },
	},
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
			},
			diagnostic = {
				show_code_action = true,
				max_height = 0.8,
				max_show_width = 0.7,
			},
		})
	end,
}
