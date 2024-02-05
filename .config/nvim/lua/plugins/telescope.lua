return {
	"nvim-telescope/telescope.nvim",
	commit = "d90956833d7c27e73c621a61f20b29fdb7122709",
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" },
		{ "nvim-tree/nvim-web-devicons", commit = "a55b801b7ef5719ca25692c3a0a5447fdfb692ed" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			commit = "6c921ca12321edaa773e324ef64ea301a1d0da62",
			build = "make",
		},
	},
	lazy = false,
	cmd = "Telescope",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		local utils = require("core.utils")
		local icons = utils.icons

		-- Helper functions for custom path_display function
		local function normalize_path(path)
			return path:gsub("\\", "/")
		end

		local function normalize_cwd()
			return normalize_path(vim.loop.cwd()) .. "/"
		end

		local function is_subdirectory(cwd, path)
			return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
		end

		local function split_filepath(path)
			local normalized_path = normalize_path(path)
			local normalized_cwd = normalize_cwd()
			local filename = normalized_path:match("[^/]+$")

			if is_subdirectory(normalized_cwd, normalized_path) then
				local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
				return stripped_path, filename
			else
				local stripped_path = normalized_path:sub(1, -(#filename + 1))
				return stripped_path, filename
			end
		end

		-- Custom path rendering function for telescope
		function path_display(_, path)
			local stripped_path, filename = split_filepath(path)
			if filename == stripped_path or stripped_path == "" then
				return filename
			end
			return string.format("%s ~ %s", filename, stripped_path)
		end

		telescope.setup({
			defaults = {
				prompt_prefix = icons.ui.Telescope .. " ",
				selection_caret = icons.ui.Forward .. " ",
				entry_prefix = "   ",
				initial_mode = "normal",
				preview = true,
				selection_strategy = "reset",
				path_display = path_display,
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						width = { padding = 0 },
						height = { padding = 0 },
						preview_width = 0.5,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
				file_ignore_patterns = {
					"^.git/",
					"^pnpm-lock.*",
					"^lazy-lock.json",
					"node_modules/*",
					"build/*",
					".cache/*",
					"^yarn.lock",
					"schema.gql",
				},
			},

			pickers = {
				find_files = {
					initial_mode = "insert",
				},

				live_grep = {
					initial_mode = "insert",
				},

				diagnostics = {
					theme = "dropdown",
				},

				buffers = {
					theme = "dropdown",
					previewer = false,
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
						},
						n = {
							["<C-d>"] = actions.delete_buffer,
						},
					},
				},

				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		})

		telescope.load_extension("fzf")

		local opts = utils.opts

		-- grep
		vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
		vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, opts)
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
		vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
		vim.keymap.set("n", "<leader>fc", builtin.command_history, opts)

		-- git
		vim.keymap.set("n", "<leader>gf", builtin.git_files, opts)
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts)
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, opts)
		vim.keymap.set("n", "<leader>gs", builtin.git_status, opts)
		vim.keymap.set("n", "<leader>gx", builtin.git_stash, opts)
	end,
}
