return {
	"williamboman/mason.nvim",
	commit = "baf99d94c3380640d19af9c70c0541bd6e7cd0cb",
	dependencies = {
		{ "neovim/nvim-lspconfig", commit = "fe1484034f47cf064c6bfd10ef1ff26665a08fd2" },
		{ "williamboman/mason-lspconfig.nvim", commit = "56e435e09f8729af2d41973e81a0db440f8fe9c9" },
		{ "whoissethdaniel/mason-tool-installer.nvim", commit = "bf0f4f8062d3acbe0afcc61db01a4d19d96310e4" },
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"cssls",
				"tailwindcss",
				"astro",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"eslint_d",
				"prettier",
				"prettierd",
			},
		})
	end,
}
