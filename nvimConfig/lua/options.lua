local opt = vim.opt
local g = vim.g

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"

opt.cmdheight = 0
opt.laststatus = 3
opt.showmode = false
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

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
