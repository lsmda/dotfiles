return {
	"neovim/nvim-lspconfig",
	commit = "fe1484034f47cf064c6bfd10ef1ff26665a08fd2",
	event = { "BufEnter" },
	config = function()
		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		lspconfig.eslint.setup({})
		lspconfig.tailwindcss.setup({})
		lspconfig.cssls.setup({})
		lspconfig.astro.setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", opts)
				vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>pk", "<cmd>Lspsaga peek_definition<CR>", opts)

				-- Diagnostics
				local get_float_opts = function(options)
					options = options or {}
					return {
						border = options.border or "rounded",
						prefix = options.prefix or " ",
						severity_sort = options.severity_sort or true,
						scope = options.scope or "buffer",
						source = options.source or false,
					}
				end

				vim.diagnostic.config({ underline = false })

				vim.keymap.set("n", "<leader>dd", function()
					vim.diagnostic.open_float(nil, get_float_opts())
				end, opts)

				vim.keymap.set("n", "<leader>nd", function()
					vim.diagnostic.goto_next({ float = get_float_opts({ scope = "line" }) })
				end, opts)

				vim.keymap.set("n", "<leader>pd", function()
					vim.diagnostic.goto_prev({ float = get_float_opts({ scope = "line" }) })
				end, opts)
			end,
		})
	end,
}
