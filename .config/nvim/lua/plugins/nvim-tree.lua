return {
	"nvim-tree/nvim-tree.lua",
	commit = "f1b3e6a7eb92da492bd693257367d9256839ed3d",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", commit = "a55b801b7ef5719ca25692c3a0a5447fdfb692ed" },
	},
	config = function()
		local nvim_tree = require("nvim-tree")

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Open help"))
			vim.keymap.set("n", "w", api.node.open.preview, opts("Open file preview"))
			vim.keymap.set("n", "<C-w>", api.tree.toggle, opts("Toggle file explorer"))
			vim.keymap.set("n", "<Tab>", function()
				api.node.open.edit()
				api.tree.toggle({ focus = false })
			end, opts("Focus file preview"))
			vim.keymap.set("n", "<leader>q", function()
				vim.cmd("wqa")
			end, opts("Exit neovim"))
		end

		nvim_tree.setup({
			on_attach = on_attach,
			sort = {
				sorter = "name",
			},
			view = {
				width = 35,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			filters = {
				exclude = { ".env" },
			},
			git = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
		})

		vim.keymap.set("n", "<C-w>", function()
			require("nvim-tree.api").tree.toggle()
		end)
	end,
}
