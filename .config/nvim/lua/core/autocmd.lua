local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = cursorGrp,
})
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Function to save the current file
local function save_file()
	-- Check for the specific conditions where we don't want to save
	local is_floating_window_open = false
	for _, win in pairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			is_floating_window_open = true
			break
		end
	end

	-- Save only if the buffer is modifiable, has been modified, not readonly, not a new buffer (buftype is empty),
	-- and no floating windows (like Telescope) are open
	if
		vim.bo.modifiable
		and vim.bo.modified
		and not vim.bo.readonly
		and vim.bo.buftype == ""
		and not is_floating_window_open
	then
		vim.cmd("silent write")
	end
end

-- Set up an auto-command group to prevent duplicate autocmds
vim.api.nvim_create_augroup("autosave", {})

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
	group = "autosave",
	pattern = "*",
	callback = function()
		if vim.fn.pumvisible() == 0 then
			vim.defer_fn(save_file, 350) -- Delay in milliseconds
		end
	end,
})
