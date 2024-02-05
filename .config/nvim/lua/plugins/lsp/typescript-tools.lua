return {
	"pmizio/typescript-tools.nvim",
	commit = "c43d9580c3ff5999a1eabca849f807ab33787ea7",
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" },
		{ "neovim/nvim-lspconfig", commit = "fe1484034f47cf064c6bfd10ef1ff26665a08fd2" },
	},
	init = function()
		require("core.utils").load_mappings("typescript_tools")
	end,
	config = function()
		require("typescript-tools").setup({})
	end,
}
