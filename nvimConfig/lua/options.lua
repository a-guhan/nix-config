local opt = vim.opt
local g = vim.g

opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"
opt.hidden = true

opt.cmdheight = 0
opt.laststatus = 3
opt.showmode = false
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Enable mouse support (required for smooth wheel scrolling)
opt.mouse = "a"
opt.mousescroll = "ver:4,hor:4" -- Faster mouse wheel scroll steps

-- Optional: nicer cursor shape in terminal
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

local function unlist_empty_startup_buffer()
	local buf = vim.api.nvim_get_current_buf()
	local is_empty = vim.api.nvim_buf_line_count(buf) == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""

	if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buftype == "" and is_empty then
		vim.bo[buf].buflisted = false
	end
end

unlist_empty_startup_buffer()
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, { callback = unlist_empty_startup_buffer })
vim.schedule(unlist_empty_startup_buffer)

g.mapleader = " "
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}
