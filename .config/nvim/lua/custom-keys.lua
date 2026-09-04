-- fetch keymap
local map = vim.api.nvim_set_keymap

-- map the key n to run the command :NvimTreeToggle
map('n', '<C-n>', [[:NvimTreeFocus<CR>]], {})
map('n', '<C-t>', [[:NvimTreeToggle<CR>]], {})

vim.wo.number = true
vim.wo.relativenumber = true
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, 'LineNrAbove', {bold=true, fg='darkgrey', bg='NONE'})
		vim.api.nvim_set_hl(0, 'LineNr', {bold=true, fg='yellow', bg='NONE'})
		vim.api.nvim_set_hl(0, 'LineNrBelow', {bold=true, fg='darkgrey', bg='NONE'})
		vim.api.nvim_set_hl(0, 'CursorLineNr', {bold=true, fg='yellow', bg='NONE'})
	end,
})
