return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	commit = "2cd4e03372f7ee5692c8caa220f479ea07970f17",
	dependencies = {
		{ "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" },
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = false,
					layout_config = {
						horizontal = {
							width = 0.5,
							height = 0.5,
						},
					},
				})
				:find()
		end

		vim.keymap.set("n", "<C-e>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():append()
		end)

		vim.keymap.set("n", "<leader>hr", function()
			harpoon:list():remove()
		end)

		vim.keymap.set("n", "<leader>hc", function()
			harpoon:list():clear()
		end)

		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end)

		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end)

		vim.keymap.set("n", "<S-h>", function()
			harpoon:list():select(1)
		end)

		vim.keymap.set("n", "<S-j>", function()
			harpoon:list():select(2)
		end)

		vim.keymap.set("n", "<S-k>", function()
			harpoon:list():select(3)
		end)

		vim.keymap.set("n", "<S-l>", function()
			harpoon:list():select(4)
		end)

		vim.keymap.set("n", "<S-b>", function()
			harpoon:list():select(5)
		end)

		vim.keymap.set("n", "<S-n>", function()
			harpoon:list():select(6)
		end)

		vim.keymap.set("n", "<S-m>", function()
			harpoon:list():select(7)
		end)

		vim.keymap.set("n", "<S-,>", function()
			harpoon:list():select(8)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)

		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
